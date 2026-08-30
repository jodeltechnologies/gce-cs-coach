-- =====================================================================
-- Phase 8 — remembering what a student did
--
-- Run after phase7.sql. Safe to run more than once.
--
-- Until now a student could sign in, answer ten questions, see a score, and
-- close the tab — and nothing was kept. The whole point of tagging 350
-- questions to lessons was so that a wrong answer could name a topic, and
-- nothing was using it.
--
-- This records every answer, and turns the record into the one sentence a
-- student actually needs: which topic to go back to.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — An attempt that belongs to nobody's assessment
--
-- attempts.assessment_id is NOT NULL, which assumes every attempt is a test a
-- teacher set. Practice is not: a student revising on a Sunday has no
-- assessment behind them. Rather than inventing a fake assessment row per
-- student to satisfy the constraint — which would pollute the teacher's list
-- of real tests — the column becomes optional and the attempt says what kind
-- it is.
-- ---------------------------------------------------------------------

ALTER TABLE attempts
  ALTER COLUMN assessment_id DROP NOT NULL;

ALTER TABLE attempts
  ADD COLUMN IF NOT EXISTS kind TEXT NOT NULL DEFAULT 'practice',
  ADD COLUMN IF NOT EXISTS syllabus_id UUID REFERENCES syllabi(id);

ALTER TABLE attempts DROP CONSTRAINT IF EXISTS attempts_kind_check;
ALTER TABLE attempts
  ADD CONSTRAINT attempts_kind_check
  CHECK (kind IN ('practice', 'assessment'));

-- A test set by a teacher must point at that test. Practice must not.
ALTER TABLE attempts DROP CONSTRAINT IF EXISTS attempts_assessment_matches_kind;
ALTER TABLE attempts
  ADD CONSTRAINT attempts_assessment_matches_kind
  CHECK ((kind = 'assessment' AND assessment_id IS NOT NULL)
      OR (kind = 'practice'  AND assessment_id IS NULL));

CREATE INDEX IF NOT EXISTS attempts_by_student
  ON attempts (student_id, started_at DESC) WHERE deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS answers_by_question
  ON answers (question_id) WHERE deleted_at IS NULL;


-- ---------------------------------------------------------------------
-- PART 2 — Starting a practice run
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_start_practice(
  p_student UUID, p_syllabus UUID)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  a UUID;
BEGIN
  INSERT INTO attempts (assessment_id, student_id, kind, syllabus_id, status)
  VALUES (NULL, p_student, 'practice', p_syllabus, 'in_progress')
  RETURNING id INTO a;
  RETURN a;
END;
$$;


-- ---------------------------------------------------------------------
-- PART 3 — Answering
--
-- Marking and recording happen in the same call. Splitting them would let a
-- student see the mark and then close the tab before the answer was saved,
-- and the record of what they got wrong is the part worth keeping.
--
-- The answer is stored against the option's id, not its letter, so a later
-- correction to an option does not silently rewrite history.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_answer(
  p_attempt UUID, p_student UUID, p_question UUID, p_label TEXT)
RETURNS TABLE (correct BOOLEAN, correct_label TEXT,
               explanation TEXT, your_feedback TEXT)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  chosen  question_options%ROWTYPE;
  right_o question_options%ROWTYPE;
  guide   TEXT;
BEGIN
  -- An attempt belongs to one student. Without this check a student could
  -- post answers into a classmate's attempt and spoil their record.
  IF NOT EXISTS (SELECT 1 FROM attempts
                  WHERE id = p_attempt AND student_id = p_student
                    AND deleted_at IS NULL) THEN
    RETURN;
  END IF;

  SELECT * INTO right_o FROM question_options
   WHERE question_id = p_question AND is_correct LIMIT 1;
  IF NOT FOUND THEN
    RETURN;
  END IF;

  SELECT * INTO chosen FROM question_options
   WHERE question_id = p_question AND label = p_label LIMIT 1;

  SELECT marking_guide INTO guide FROM questions WHERE id = p_question;

  INSERT INTO answers (attempt_id, question_id, selected_option_id,
                       is_correct, marks_awarded, marked_by, marked_at,
                       feedback)
  VALUES (p_attempt, p_question, chosen.id,
          (chosen.label = right_o.label),
          CASE WHEN chosen.label = right_o.label THEN 1 ELSE 0 END,
          'auto', now(), chosen.feedback)
  -- Changing an answer replaces it rather than failing: a student who
  -- refreshes mid-question should not hit an error.
  ON CONFLICT (attempt_id, question_id) DO UPDATE
    SET selected_option_id = EXCLUDED.selected_option_id,
        is_correct = EXCLUDED.is_correct,
        marks_awarded = EXCLUDED.marks_awarded,
        feedback = EXCLUDED.feedback,
        marked_at = now(),
        updated_at = now();

  RETURN QUERY SELECT (chosen.label = right_o.label), right_o.label,
                      guide, chosen.feedback;
END;
$$;


CREATE OR REPLACE FUNCTION public.student_finish_practice(
  p_attempt UUID, p_student UUID)
RETURNS TABLE (score NUMERIC, out_of BIGINT)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  s NUMERIC;
  n BIGINT;
BEGIN
  SELECT coalesce(sum(marks_awarded), 0), count(*)
    INTO s, n
    FROM answers WHERE attempt_id = p_attempt AND deleted_at IS NULL;

  UPDATE attempts
     SET submitted_at = now(), status = 'marked',
         score = s,
         percentage = CASE WHEN n > 0 THEN round(100.0 * s / n, 2) END,
         updated_at = now()
   WHERE id = p_attempt AND student_id = p_student;

  RETURN QUERY SELECT s, n;
END;
$$;


-- ---------------------------------------------------------------------
-- PART 4 — Which topics a student is weak in
--
-- Only lessons with enough answers behind them are reported. Calling a topic
-- weak on the strength of one wrong answer is noise, and a revision list that
-- changes every session teaches a student to ignore it.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_weak_topics(
  p_student UUID, p_min_answers INT DEFAULT 3)
RETURNS TABLE (lesson_id UUID, lesson_title TEXT,
               answered BIGINT, correct BIGINT, percentage NUMERIC,
               note_section_id UUID, note_title TEXT)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  WITH graded AS (
    SELECT ql.lesson_id, a.is_correct
    FROM answers a
    JOIN attempts t ON t.id = a.attempt_id AND t.student_id = p_student
                   AND t.deleted_at IS NULL
    JOIN question_lessons ql ON ql.question_id = a.question_id AND ql.is_primary
    WHERE a.deleted_at IS NULL AND a.is_correct IS NOT NULL
  ),
  rolled AS (
    SELECT lesson_id, count(*) AS answered,
           count(*) FILTER (WHERE is_correct) AS correct
    FROM graded GROUP BY lesson_id
  )
  SELECT r.lesson_id, l.title, r.answered, r.correct,
         round(100.0 * r.correct / r.answered, 0),
         ns.id, ns.title
  FROM rolled r
  JOIN lessons l ON l.id = r.lesson_id
  -- The chapter that covers this lesson, so the answer to "what now" is a
  -- link rather than advice.
  LEFT JOIN LATERAL (
    SELECT s.id, s.title FROM lesson_note_sections lns
    JOIN note_sections s ON s.id = lns.note_section_id AND s.deleted_at IS NULL
    WHERE lns.lesson_id = r.lesson_id
    ORDER BY CASE lns.coverage WHEN 'full' THEN 0 WHEN 'partial' THEN 1 ELSE 2 END
    LIMIT 1
  ) ns ON true
  WHERE r.answered >= p_min_answers
  ORDER BY (1.0 * r.correct / r.answered), r.answered DESC
  LIMIT 8;
$$;


CREATE OR REPLACE FUNCTION public.student_progress(p_student UUID)
RETURNS TABLE (runs BIGINT, answered BIGINT, correct BIGINT, last_at TIMESTAMPTZ)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    (SELECT count(*) FROM attempts
      WHERE student_id = p_student AND kind = 'practice'
        AND status = 'marked' AND deleted_at IS NULL),
    count(*), count(*) FILTER (WHERE a.is_correct), max(a.marked_at)
  FROM answers a
  JOIN attempts t ON t.id = a.attempt_id AND t.student_id = p_student
                 AND t.deleted_at IS NULL
  WHERE a.deleted_at IS NULL;
$$;


-- Practice weighted towards what the student gets wrong.
--
-- Not exclusively: a set drawn only from weak topics is demoralising and never
-- confirms that anything has been learned. Two thirds weak, one third anything.
DROP FUNCTION IF EXISTS public.student_practice(UUID, INT);
CREATE FUNCTION public.student_practice(
  p_syllabus UUID, p_limit INT DEFAULT 10, p_student UUID DEFAULT NULL)
RETURNS TABLE (question_id UUID, question_text TEXT, marks NUMERIC,
               figure_name TEXT, lesson_title TEXT, options JSONB)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  -- Computed once, not once per candidate question. Calling a set-returning
  -- function inside a per-row EXISTS runs the whole weak-topic aggregate for
  -- every question in the bank, which on a few hundred rows is slow enough to
  -- notice on a phone.
  WITH weak AS (
    SELECT lesson_id FROM public.student_weak_topics(p_student)
    WHERE p_student IS NOT NULL
  ),
  weak_q AS (
    SELECT DISTINCT ql.question_id
    FROM question_lessons ql JOIN weak w ON w.lesson_id = ql.lesson_id
  ),
  right_already AS (
    SELECT DISTINCT a.question_id
    FROM answers a
    JOIN attempts t ON t.id = a.attempt_id
    WHERE t.student_id = p_student AND a.is_correct AND a.deleted_at IS NULL
  ),
  pool AS (
    SELECT q.id, q.question_text, q.marks, q.figure_name,
           coalesce(
             (SELECT l.title FROM question_lessons ql
                JOIN lessons l ON l.id = ql.lesson_id
               WHERE ql.question_id = q.id
               ORDER BY ql.is_primary DESC LIMIT 1),
             q.source_paper) AS lesson_title,
           (SELECT jsonb_agg(jsonb_build_object('label', o.label,
                                                'text', o.option_text)
                             ORDER BY o.sequence)
              FROM question_options o WHERE o.question_id = q.id) AS options,
           (q.id IN (SELECT question_id FROM weak_q)) AS is_weak,
           -- Questions already answered correctly are not the ones to repeat.
           (q.id IN (SELECT question_id FROM right_already)) AS already_right
    FROM questions q
    WHERE q.syllabus_id = p_syllabus
      AND q.deleted_at IS NULL
      AND q.question_type = 'mcq'
      AND q.auto_markable
      AND NOT q.needs_review
  )
  SELECT id, question_text, marks, figure_name, lesson_title, options
  FROM pool
  ORDER BY already_right ASC,
           (CASE WHEN is_weak THEN 0 ELSE 1 END) * random() + random() * 0.5,
           random()
  LIMIT greatest(least(p_limit, 40), 1);
$$;

REVOKE ALL ON FUNCTION public.student_start_practice(UUID, UUID) FROM public;
REVOKE ALL ON FUNCTION public.student_answer(UUID, UUID, UUID, TEXT) FROM public;
REVOKE ALL ON FUNCTION public.student_finish_practice(UUID, UUID) FROM public;
REVOKE ALL ON FUNCTION public.student_weak_topics(UUID, INT) FROM public;
REVOKE ALL ON FUNCTION public.student_progress(UUID) FROM public;
REVOKE ALL ON FUNCTION public.student_practice(UUID, INT, UUID) FROM public;

GRANT EXECUTE ON FUNCTION public.student_start_practice(UUID, UUID) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_answer(UUID, UUID, UUID, TEXT) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_finish_practice(UUID, UUID) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_weak_topics(UUID, INT) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_progress(UUID) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_practice(UUID, INT, UUID) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 5 — What a teacher sees
--
-- The same roll-up across a class. This is the question a teacher actually
-- asks — "what is this class not getting" — and until now the answer arrived
-- only after the mock.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.class_weak_topics(p_class UUID)
RETURNS TABLE (lesson_id UUID, lesson_title TEXT, students BIGINT,
               answered BIGINT, correct BIGINT, percentage NUMERIC)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT ql.lesson_id, l.title,
         count(DISTINCT t.student_id),
         count(*), count(*) FILTER (WHERE a.is_correct),
         round(100.0 * count(*) FILTER (WHERE a.is_correct) / count(*), 0)
  FROM answers a
  JOIN attempts t ON t.id = a.attempt_id AND t.deleted_at IS NULL
  JOIN enrolments e ON e.student_id = t.student_id AND e.class_id = p_class
                   AND e.status = 'active' AND e.deleted_at IS NULL
  JOIN question_lessons ql ON ql.question_id = a.question_id AND ql.is_primary
  JOIN lessons l ON l.id = ql.lesson_id
  WHERE a.deleted_at IS NULL AND a.is_correct IS NOT NULL
    AND public.is_teacher()
  GROUP BY ql.lesson_id, l.title
  HAVING count(*) >= 5
  ORDER BY 6 ASC
  LIMIT 20;
$$;

REVOKE ALL ON FUNCTION public.class_weak_topics(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.class_weak_topics(UUID) TO authenticated;


-- ---------------------------------------------------------------------
-- PART 6 — Mastery
--
-- lesson_mastery has existed and been empty since the schema was written.
-- It is a cache: everything in it can be recomputed from answers, so it is
-- refreshed rather than maintained by triggers. Triggers on every answer
-- would make each keystroke of a quiz a write to a second table.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.refresh_lesson_mastery(p_student UUID DEFAULT NULL)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  n INTEGER;
BEGIN
  INSERT INTO lesson_mastery (student_id, lesson_id, stream, attempts_count,
                              questions_count, average_score, weighted_score,
                              mastery_level, last_activity_at)
  SELECT t.student_id, ql.lesson_id, 'theory',
         count(DISTINCT t.id),
         count(*),
         round(100.0 * count(*) FILTER (WHERE a.is_correct) / count(*), 2),
         round(100.0 * count(*) FILTER (WHERE a.is_correct) / count(*), 2),
         CASE
           WHEN count(*) < 4 THEN 'insufficient_data'
           WHEN count(*) FILTER (WHERE a.is_correct) * 100 / count(*) < 40
             THEN 'needs_attention'
           WHEN count(*) FILTER (WHERE a.is_correct) * 100 / count(*) < 60
             THEN 'developing'
           WHEN count(*) FILTER (WHERE a.is_correct) * 100 / count(*) < 80
             THEN 'good'
           ELSE 'mastered'
         END,
         max(a.marked_at)
  FROM answers a
  JOIN attempts t ON t.id = a.attempt_id AND t.deleted_at IS NULL
  JOIN question_lessons ql ON ql.question_id = a.question_id AND ql.is_primary
  WHERE a.deleted_at IS NULL AND a.is_correct IS NOT NULL
    AND (p_student IS NULL OR t.student_id = p_student)
  GROUP BY t.student_id, ql.lesson_id
  ON CONFLICT (student_id, lesson_id, stream) DO UPDATE SET
    attempts_count = EXCLUDED.attempts_count,
    questions_count = EXCLUDED.questions_count,
    average_score = EXCLUDED.average_score,
    weighted_score = EXCLUDED.weighted_score,
    mastery_level = EXCLUDED.mastery_level,
    last_activity_at = EXCLUDED.last_activity_at,
    updated_at = now();
  GET DIAGNOSTICS n = ROW_COUNT;
  RETURN n;
END;
$$;

REVOKE ALL ON FUNCTION public.refresh_lesson_mastery(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.refresh_lesson_mastery(UUID) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 7 — Check
-- ---------------------------------------------------------------------

SELECT
  (SELECT count(*) FROM attempts WHERE deleted_at IS NULL) AS attempts,
  (SELECT count(*) FROM answers WHERE deleted_at IS NULL) AS answers_recorded,
  (SELECT count(*) FROM lesson_mastery) AS mastery_rows;
