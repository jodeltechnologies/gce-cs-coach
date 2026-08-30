-- =====================================================================
-- Phase 12 — tests a teacher sets
--
-- Run after phase11.sql. Safe to run more than once.
--
-- Practice is self-directed, which means it measures who chose to revise as
-- much as who understands. An assessment is different in one way that changes
-- everything: the teacher decides who sits it, which questions, and when. It
-- is the same twenty students answering the same twenty questions, so the
-- results can be compared.
--
-- The tables have existed since the schema was written and the app has never
-- written a row to either. Everything underneath them is now in place —
-- questions, tagging, attempts, marking — so this is the piece that turns
-- revision into assessment.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — Policies, and one attempt per student
-- ---------------------------------------------------------------------

ALTER TABLE assessments ENABLE ROW LEVEL SECURITY;
ALTER TABLE assessment_questions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS teacher_manages_assessments ON assessments;
CREATE POLICY teacher_manages_assessments ON assessments
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_manages_assessment_questions ON assessment_questions;
CREATE POLICY teacher_manages_assessment_questions ON assessment_questions
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

-- A student sits a test once. Enforced here rather than in the application,
-- because a second browser tab is not a good enough reason to get a second
-- attempt at a graded test.
CREATE UNIQUE INDEX IF NOT EXISTS attempts_one_per_assessment
  ON attempts (assessment_id, student_id)
  WHERE kind = 'assessment' AND deleted_at IS NULL;


-- ---------------------------------------------------------------------
-- PART 2 — Building a paper
--
-- Questions are chosen once and stored, not drawn at random when each student
-- opens it. Two students given different questions cannot be compared, which
-- is the whole reason for setting a test rather than telling them to practise.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.fill_assessment(
  p_assessment UUID, p_lesson UUID DEFAULT NULL,
  p_count INT DEFAULT 10, p_include_structured BOOLEAN DEFAULT false)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  syl UUID;
  n INTEGER;
  next_seq INTEGER;
BEGIN
  IF NOT public.is_teacher() THEN
    RETURN 0;
  END IF;

  SELECT sy.id INTO syl
  FROM assessments a
  JOIN classes c ON c.id = a.class_id
  JOIN syllabi sy ON sy.form_level = c.form_level AND sy.deleted_at IS NULL
  WHERE a.id = p_assessment;
  IF syl IS NULL THEN
    RETURN 0;
  END IF;

  SELECT coalesce(max(sequence), 0) INTO next_seq
  FROM assessment_questions WHERE assessment_id = p_assessment;

  INSERT INTO assessment_questions (assessment_id, question_id, sequence)
  SELECT p_assessment, q.id,
         next_seq + row_number() OVER (ORDER BY random())
  FROM questions q
  WHERE q.syllabus_id = syl
    AND q.deleted_at IS NULL
    AND NOT q.needs_review
    AND (
      (q.question_type = 'mcq' AND q.auto_markable)
      OR (p_include_structured AND q.question_type = 'structured'
          AND EXISTS (SELECT 1 FROM question_parts p
                       WHERE p.question_id = q.id AND p.deleted_at IS NULL))
    )
    AND (p_lesson IS NULL OR EXISTS (
          SELECT 1 FROM question_lessons ql
          WHERE ql.question_id = q.id AND ql.lesson_id = p_lesson))
    -- Not one already on this paper.
    AND NOT EXISTS (SELECT 1 FROM assessment_questions aq
                     WHERE aq.assessment_id = p_assessment
                       AND aq.question_id = q.id)
  LIMIT greatest(least(p_count, 60), 1);

  GET DIAGNOSTICS n = ROW_COUNT;

  -- Total marks follow the questions, so the number on the paper is always
  -- the number the questions add up to.
  UPDATE assessments a
     SET total_marks = (
           SELECT coalesce(sum(coalesce(aq.marks_override, q.marks)), 0)
           FROM assessment_questions aq
           JOIN questions q ON q.id = aq.question_id
           WHERE aq.assessment_id = p_assessment),
         updated_at = now()
   WHERE a.id = p_assessment;

  RETURN n;
END;
$$;

REVOKE ALL ON FUNCTION public.fill_assessment(UUID, UUID, INT, BOOLEAN) FROM public;
GRANT EXECUTE ON FUNCTION public.fill_assessment(UUID, UUID, INT, BOOLEAN) TO authenticated;


-- ---------------------------------------------------------------------
-- PART 3 — What a student has been set
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_assessments(p_student UUID)
RETURNS TABLE (assessment_id UUID, title TEXT, kind TEXT,
               total_marks NUMERIC, duration_minutes INTEGER,
               opens_at TIMESTAMPTZ, closes_at TIMESTAMPTZ,
               question_count BIGINT, show_results TEXT,
               attempt_id UUID, attempt_status TEXT,
               score NUMERIC, is_open BOOLEAN)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT a.id, a.title, a.kind, a.total_marks, a.duration_minutes,
         a.opens_at, a.closes_at,
         (SELECT count(*) FROM assessment_questions aq
           WHERE aq.assessment_id = a.id),
         a.show_results,
         t.id, t.status, t.score,
         (a.opens_at IS NULL OR a.opens_at <= now())
           AND (a.closes_at IS NULL OR a.closes_at > now())
  FROM assessments a
  JOIN enrolments e ON e.class_id = a.class_id AND e.student_id = p_student
                   AND e.status = 'active' AND e.deleted_at IS NULL
  LEFT JOIN attempts t ON t.assessment_id = a.id AND t.student_id = p_student
                      AND t.kind = 'assessment' AND t.deleted_at IS NULL
  WHERE a.deleted_at IS NULL
    AND EXISTS (SELECT 1 FROM assessment_questions aq
                 WHERE aq.assessment_id = a.id)
  ORDER BY coalesce(a.closes_at, a.opens_at, a.created_at) DESC
  LIMIT 20;
$$;


-- Start, or resume. Resuming matters: phones die and networks drop, and a
-- student who loses power halfway through a test should come back to the
-- questions they had, not to a locked door.
CREATE OR REPLACE FUNCTION public.student_start_assessment(
  p_student UUID, p_assessment UUID)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  a assessments%ROWTYPE;
  existing attempts%ROWTYPE;
  new_id UUID;
BEGIN
  SELECT * INTO a FROM assessments
   WHERE id = p_assessment AND deleted_at IS NULL;
  IF NOT FOUND THEN RETURN NULL; END IF;

  -- Set for their class?
  IF NOT EXISTS (SELECT 1 FROM enrolments e
                  WHERE e.class_id = a.class_id AND e.student_id = p_student
                    AND e.status = 'active' AND e.deleted_at IS NULL) THEN
    RETURN NULL;
  END IF;

  IF (a.opens_at IS NOT NULL AND a.opens_at > now())
     OR (a.closes_at IS NOT NULL AND a.closes_at <= now()) THEN
    RETURN NULL;
  END IF;

  SELECT * INTO existing FROM attempts
   WHERE assessment_id = p_assessment AND student_id = p_student
     AND kind = 'assessment' AND deleted_at IS NULL;

  IF FOUND THEN
    -- Already submitted: no second go.
    IF existing.submitted_at IS NOT NULL THEN
      RETURN NULL;
    END IF;
    RETURN existing.id;
  END IF;

  INSERT INTO attempts (assessment_id, student_id, kind, syllabus_id, status)
  VALUES (p_assessment, p_student, 'assessment', NULL, 'in_progress')
  RETURNING id INTO new_id;
  RETURN new_id;
END;
$$;


-- The paper itself. Correct options are never included.
-- Dropped rather than replaced: the returned columns change.
DROP FUNCTION IF EXISTS public.student_assessment_questions(UUID, UUID);

CREATE FUNCTION public.student_assessment_questions(
  p_student UUID, p_attempt UUID)
RETURNS TABLE (question_id UUID, sequence INTEGER, question_type TEXT,
               question_text TEXT, scenario TEXT, marks NUMERIC,
               figure_name TEXT, options JSONB, parts JSONB,
               your_label TEXT, your_response TEXT)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT q.id, aq.sequence, q.question_type, q.question_text, q.scenario,
         coalesce(aq.marks_override, q.marks), q.figure_name,
         (SELECT jsonb_agg(jsonb_build_object('label', o.label,
                                              'text', o.option_text)
                           ORDER BY o.sequence)
            FROM question_options o WHERE o.question_id = q.id),
         (SELECT jsonb_agg(jsonb_build_object('id', p.id, 'label', p.label,
                             'prompt', p.prompt, 'marks', p.marks)
                           ORDER BY p.sequence)
            FROM question_parts p
           WHERE p.question_id = q.id AND p.deleted_at IS NULL),
         -- What this student has already put down, so resuming shows their
         -- answers rather than a blank paper. Knowing only that a question was
         -- answered is not enough: a student who lost power on question
         -- eighteen would come back to seventeen empty boxes.
         (SELECT o.label FROM answers ans
            JOIN question_options o ON o.id = ans.selected_option_id
           WHERE ans.attempt_id = p_attempt AND ans.question_id = q.id
             AND ans.deleted_at IS NULL),
         (SELECT ans.response_text FROM answers ans
           WHERE ans.attempt_id = p_attempt AND ans.question_id = q.id
             AND ans.deleted_at IS NULL)
  FROM attempts t
  JOIN assessment_questions aq ON aq.assessment_id = t.assessment_id
  JOIN questions q ON q.id = aq.question_id
  WHERE t.id = p_attempt AND t.student_id = p_student AND t.deleted_at IS NULL
  ORDER BY aq.sequence;
$$;


-- Recording an answer during a test.
--
-- Unlike practice, this returns nothing about whether the answer was right.
-- Marks in a test are not shown as you go: a student who learns question three
-- was wrong before answering question four is sitting a different test from
-- one who does not.
CREATE OR REPLACE FUNCTION public.student_assessment_answer(
  p_attempt UUID, p_student UUID, p_question UUID,
  p_label TEXT DEFAULT NULL, p_response TEXT DEFAULT NULL)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  chosen question_options%ROWTYPE;
BEGIN
  IF NOT EXISTS (SELECT 1 FROM attempts
                  WHERE id = p_attempt AND student_id = p_student
                    AND kind = 'assessment' AND submitted_at IS NULL
                    AND deleted_at IS NULL) THEN
    RETURN false;
  END IF;

  IF p_label IS NOT NULL THEN
    SELECT * INTO chosen FROM question_options
     WHERE question_id = p_question AND label = p_label LIMIT 1;
  END IF;

  INSERT INTO answers (attempt_id, question_id, selected_option_id,
                       response_text, is_correct, marked_by)
  VALUES (p_attempt, p_question, chosen.id, p_response, NULL, NULL)
  ON CONFLICT (attempt_id, question_id) DO UPDATE
    SET selected_option_id = EXCLUDED.selected_option_id,
        response_text = EXCLUDED.response_text,
        updated_at = now();
  RETURN true;
END;
$$;


-- Submitting. Marking happens here, once, at the end.
CREATE OR REPLACE FUNCTION public.student_submit_assessment(
  p_attempt UUID, p_student UUID)
RETURNS TABLE (score NUMERIC, out_of NUMERIC, awaiting_marking BIGINT)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  s NUMERIC;
  total NUMERIC;
  pending BIGINT;
BEGIN
  IF NOT EXISTS (SELECT 1 FROM attempts
                  WHERE id = p_attempt AND student_id = p_student
                    AND kind = 'assessment' AND deleted_at IS NULL) THEN
    RETURN;
  END IF;

  -- Multiple choice marks itself.
  UPDATE answers ans
     SET is_correct = (o.is_correct),
         marks_awarded = CASE WHEN o.is_correct
                              THEN coalesce(aq.marks_override, q.marks)
                              ELSE 0 END,
         marked_by = 'auto', marked_at = now(), updated_at = now()
    FROM question_options o, questions q, attempts t, assessment_questions aq
   WHERE ans.attempt_id = p_attempt
     AND o.id = ans.selected_option_id
     AND q.id = ans.question_id
     AND q.question_type = 'mcq'
     AND t.id = ans.attempt_id
     AND aq.assessment_id = t.assessment_id AND aq.question_id = q.id
     AND ans.marked_at IS NULL;

  SELECT coalesce(sum(ans.marks_awarded), 0) INTO s
  FROM answers ans WHERE ans.attempt_id = p_attempt AND ans.deleted_at IS NULL;

  SELECT a.total_marks INTO total
  FROM attempts t JOIN assessments a ON a.id = t.assessment_id
  WHERE t.id = p_attempt;

  -- Written answers still need a person, so the score is provisional until
  -- they are marked. Saying so is better than showing a total that will
  -- change later without explanation.
  SELECT count(*) INTO pending
  FROM answers ans JOIN questions q ON q.id = ans.question_id
  WHERE ans.attempt_id = p_attempt AND q.question_type <> 'mcq'
    AND ans.marked_at IS NULL;

  UPDATE attempts
     SET submitted_at = coalesce(submitted_at, now()),
         status = CASE WHEN pending > 0 THEN 'submitted' ELSE 'marked' END,
         score = s,
         percentage = CASE WHEN total > 0 THEN round(100.0 * s / total, 2) END,
         updated_at = now()
   WHERE id = p_attempt;

  PERFORM public.refresh_lesson_mastery(p_student);
  RETURN QUERY SELECT s, total, pending;
END;
$$;

REVOKE ALL ON FUNCTION public.student_assessments(UUID) FROM public;
REVOKE ALL ON FUNCTION public.student_start_assessment(UUID, UUID) FROM public;
REVOKE ALL ON FUNCTION public.student_assessment_questions(UUID, UUID) FROM public;
REVOKE ALL ON FUNCTION public.student_assessment_answer(UUID, UUID, UUID, TEXT, TEXT) FROM public;
REVOKE ALL ON FUNCTION public.student_submit_assessment(UUID, UUID) FROM public;

GRANT EXECUTE ON FUNCTION public.student_assessments(UUID) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_start_assessment(UUID, UUID) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_assessment_questions(UUID, UUID) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_assessment_answer(UUID, UUID, UUID, TEXT, TEXT) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_submit_assessment(UUID, UUID) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 4 — Results, for the teacher
--
-- Every enrolled student appears, including the ones who never opened it.
-- A results table that silently omits absentees is the one thing a mark list
-- must not do.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.assessment_results(p_assessment UUID)
RETURNS TABLE (student_id UUID, student_name TEXT, attempt_id UUID,
               status TEXT, score NUMERIC, percentage NUMERIC,
               answered BIGINT, awaiting_marking BIGINT,
               submitted_at TIMESTAMPTZ)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT st.id, st.full_name, t.id,
         coalesce(t.status, 'not started'), t.score, t.percentage,
         (SELECT count(*) FROM answers ans
           WHERE ans.attempt_id = t.id AND ans.deleted_at IS NULL),
         (SELECT count(*) FROM answers ans JOIN questions q ON q.id = ans.question_id
           WHERE ans.attempt_id = t.id AND q.question_type <> 'mcq'
             AND ans.marked_at IS NULL),
         t.submitted_at
  FROM assessments a
  JOIN enrolments e ON e.class_id = a.class_id AND e.status = 'active'
                   AND e.deleted_at IS NULL
  JOIN students st ON st.id = e.student_id AND st.deleted_at IS NULL
  LEFT JOIN attempts t ON t.assessment_id = a.id AND t.student_id = st.id
                      AND t.kind = 'assessment' AND t.deleted_at IS NULL
  WHERE a.id = p_assessment AND public.is_teacher()
  ORDER BY t.percentage DESC NULLS LAST, st.full_name;
$$;


-- Which questions the class found hardest. This is the reason to set a test
-- rather than only look at the total: a question two thirds of the class got
-- wrong is a lesson to reteach, not twenty students to worry about.
CREATE OR REPLACE FUNCTION public.assessment_question_analysis(p_assessment UUID)
RETURNS TABLE (question_id UUID, sequence INTEGER, question_text TEXT,
               lesson_title TEXT, answered BIGINT, correct BIGINT,
               percentage NUMERIC)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT q.id, aq.sequence, q.question_text,
         (SELECT l.title FROM question_lessons ql
            JOIN lessons l ON l.id = ql.lesson_id
           WHERE ql.question_id = q.id ORDER BY ql.is_primary DESC LIMIT 1),
         count(ans.id) FILTER (WHERE ans.is_correct IS NOT NULL),
         count(ans.id) FILTER (WHERE ans.is_correct),
         CASE WHEN count(ans.id) FILTER (WHERE ans.is_correct IS NOT NULL) > 0
              THEN round(100.0 * count(ans.id) FILTER (WHERE ans.is_correct)
                   / count(ans.id) FILTER (WHERE ans.is_correct IS NOT NULL), 0)
         END
  FROM assessment_questions aq
  JOIN questions q ON q.id = aq.question_id
  LEFT JOIN attempts t ON t.assessment_id = aq.assessment_id
                      AND t.kind = 'assessment' AND t.deleted_at IS NULL
  LEFT JOIN answers ans ON ans.attempt_id = t.id AND ans.question_id = q.id
                       AND ans.deleted_at IS NULL
  WHERE aq.assessment_id = p_assessment AND public.is_teacher()
  GROUP BY q.id, aq.sequence, q.question_text
  ORDER BY 7 NULLS LAST, aq.sequence;
$$;

REVOKE ALL ON FUNCTION public.assessment_results(UUID) FROM public;
REVOKE ALL ON FUNCTION public.assessment_question_analysis(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.assessment_results(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.assessment_question_analysis(UUID) TO authenticated;


-- ---------------------------------------------------------------------
-- PART 5 — Check
-- ---------------------------------------------------------------------

SELECT
  (SELECT count(*) FROM assessments WHERE deleted_at IS NULL) AS assessments,
  (SELECT count(*) FROM assessment_questions) AS questions_on_papers,
  (SELECT count(*) FROM attempts WHERE kind = 'assessment'
     AND deleted_at IS NULL) AS sittings;
