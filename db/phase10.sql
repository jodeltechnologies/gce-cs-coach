-- =====================================================================
-- Phase 10 — structured questions for students
--
-- Run after phase9.sql. Safe to run more than once.
--
-- Paper 2 is where the marks are, and until now a student could only practise
-- Paper 1. Structured questions cannot be marked by comparing strings, so this
-- does not pretend to mark them. A student writes their answer, then sees the
-- model answer and the mark allocation, and compares. That is what a teacher
-- does when handing back a script, and it is honest about what a computer can
-- and cannot judge here.
--
-- What is written is kept, so the teacher can read it. What is NOT done is
-- score it: is_correct stays null, so a structured attempt never moves the
-- weak-topic figures. Guessing at whether a paragraph earned four marks and
-- then telling a student they are weak in databases on that basis would be
-- worse than saying nothing.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — Structured questions a student may practise
--
-- Model answers are NOT returned here. They come from student_reveal_part,
-- after the student has written something, because a model answer sitting in
-- the page source turns the exercise into copying.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_structured(
  p_syllabus UUID, p_lesson UUID DEFAULT NULL, p_limit INT DEFAULT 3)
RETURNS TABLE (question_id UUID, title TEXT, scenario TEXT, marks NUMERIC,
               source_paper TEXT, lesson_title TEXT, parts JSONB)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT q.id, q.question_text, q.scenario, q.marks, q.source_paper,
         (SELECT l.title FROM question_lessons ql
            JOIN lessons l ON l.id = ql.lesson_id
           WHERE ql.question_id = q.id
           ORDER BY ql.is_primary DESC LIMIT 1),
         (SELECT jsonb_agg(jsonb_build_object(
                   'id', p.id, 'label', p.label, 'prompt', p.prompt,
                   'marks', p.marks, 'hint', p.hint)
                 ORDER BY p.sequence)
            FROM question_parts p
           WHERE p.question_id = q.id AND p.deleted_at IS NULL)
  FROM questions q
  WHERE q.syllabus_id = p_syllabus
    AND q.deleted_at IS NULL
    AND q.question_type = 'structured'
    AND NOT q.needs_review
    AND EXISTS (SELECT 1 FROM question_parts p
                 WHERE p.question_id = q.id AND p.deleted_at IS NULL)
    AND (p_lesson IS NULL OR EXISTS (
          SELECT 1 FROM question_lessons ql
          WHERE ql.question_id = q.id AND ql.lesson_id = p_lesson))
  ORDER BY random()
  LIMIT greatest(least(p_limit, 10), 1);
$$;


-- ---------------------------------------------------------------------
-- PART 2 — Save what the student wrote, then show the model answer
--
-- One call, in that order. Revealing without saving would let a student read
-- the answer and leave no evidence they had tried, which is the habit this is
-- meant to break.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_answer_part(
  p_attempt UUID, p_student UUID, p_part UUID, p_response TEXT)
RETURNS TABLE (model_answer TEXT, marks NUMERIC)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  prt question_parts%ROWTYPE;
BEGIN
  IF NOT EXISTS (SELECT 1 FROM attempts
                  WHERE id = p_attempt AND student_id = p_student
                    AND deleted_at IS NULL) THEN
    RETURN;
  END IF;

  SELECT * INTO prt FROM question_parts
   WHERE id = p_part AND deleted_at IS NULL;
  IF NOT FOUND THEN
    RETURN;
  END IF;

  -- answers is keyed on (attempt, question), and a structured question has
  -- several parts, so each part's response is appended under its own label
  -- rather than overwriting the last one.
  INSERT INTO answers (attempt_id, question_id, response_text,
                       is_correct, marked_by)
  VALUES (p_attempt, prt.question_id,
          prt.label || E'\n' || coalesce(p_response, ''),
          -- Deliberately null: nothing here has been marked, and a null keeps
          -- this attempt out of every score and weak-topic calculation.
          NULL, NULL)
  ON CONFLICT (attempt_id, question_id) DO UPDATE
    SET response_text = answers.response_text || E'\n\n'
                        || prt.label || E'\n' || coalesce(p_response, ''),
        updated_at = now();

  RETURN QUERY SELECT prt.model_answer, prt.marks;
END;
$$;

REVOKE ALL ON FUNCTION public.student_structured(UUID, UUID, INT) FROM public;
REVOKE ALL ON FUNCTION public.student_answer_part(UUID, UUID, UUID, TEXT) FROM public;
GRANT EXECUTE ON FUNCTION public.student_structured(UUID, UUID, INT) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_answer_part(UUID, UUID, UUID, TEXT) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 3 — How many of each kind a topic has
--
-- So the chooser can say "12 multiple choice, 2 structured" rather than
-- offering a structured set for a topic that has none.
-- ---------------------------------------------------------------------

DROP FUNCTION IF EXISTS public.student_practice_topics(UUID, UUID);

CREATE FUNCTION public.student_practice_topics(
  p_syllabus UUID, p_student UUID DEFAULT NULL)
RETURNS TABLE (lesson_id UUID, lesson_title TEXT, available BIGINT,
               structured BIGINT, answered BIGINT, correct BIGINT,
               percentage NUMERIC)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  WITH ready AS (
    SELECT q.id, ql.lesson_id, q.question_type
    FROM questions q
    JOIN question_lessons ql ON ql.question_id = q.id AND ql.is_primary
    WHERE q.syllabus_id = p_syllabus
      AND q.deleted_at IS NULL
      AND NOT q.needs_review
      AND ((q.question_type = 'mcq' AND q.auto_markable)
        OR (q.question_type = 'structured'
            AND EXISTS (SELECT 1 FROM question_parts p
                         WHERE p.question_id = q.id AND p.deleted_at IS NULL)))
  ),
  mine AS (
    SELECT a.question_id, a.is_correct
    FROM answers a
    JOIN attempts t ON t.id = a.attempt_id AND t.student_id = p_student
                   AND t.deleted_at IS NULL
    WHERE a.deleted_at IS NULL AND a.is_correct IS NOT NULL
  )
  SELECT r.lesson_id, l.title,
         count(*) FILTER (WHERE r.question_type = 'mcq'),
         count(*) FILTER (WHERE r.question_type = 'structured'),
         count(m.question_id),
         count(*) FILTER (WHERE m.is_correct),
         CASE WHEN count(m.question_id) > 0
              THEN round(100.0 * count(*) FILTER (WHERE m.is_correct)
                         / count(m.question_id), 0) END
  FROM ready r
  JOIN lessons l ON l.id = r.lesson_id
  LEFT JOIN mine m ON m.question_id = r.id
  GROUP BY r.lesson_id, l.title
  ORDER BY l.title;
$$;

REVOKE ALL ON FUNCTION public.student_practice_topics(UUID, UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_practice_topics(UUID, UUID) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 4 — Check
-- ---------------------------------------------------------------------

SELECT
  (SELECT count(*) FROM questions q
    WHERE q.question_type = 'structured' AND NOT q.needs_review
      AND q.deleted_at IS NULL
      AND EXISTS (SELECT 1 FROM question_parts p WHERE p.question_id = q.id))
    AS structured_ready,
  (SELECT count(*) FROM question_parts WHERE deleted_at IS NULL) AS parts;
