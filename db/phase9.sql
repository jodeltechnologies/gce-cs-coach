-- =====================================================================
-- Phase 9 — letting a student choose what to practise
--
-- Run after phase8.sql. Safe to run more than once.
--
-- Practice has been handing out ten questions from anywhere in the syllabus.
-- That is the right default the night before a mock, and the wrong one on a
-- Tuesday when a student has just been taught logic gates and wants to drill
-- logic gates. The static platform this replaces let them pick a topic, and
-- losing that was a step backwards.
--
-- Three ways in, then: a topic they choose, the topics they are weakest in, or
-- everything. The middle one is the app's own suggestion and stays available,
-- because a student who does not know what they are bad at is exactly the
-- student who most needs telling.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — What is there to choose from
--
-- Counts come from the questions themselves rather than a fixed topic list, so
-- a topic with nothing behind it is never offered. Being shown "Logic gates"
-- and getting an empty quiz is worse than not being shown it.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_practice_topics(
  p_syllabus UUID, p_student UUID DEFAULT NULL)
RETURNS TABLE (lesson_id UUID, lesson_title TEXT, available BIGINT,
               answered BIGINT, correct BIGINT, percentage NUMERIC)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  WITH ready AS (
    SELECT q.id, ql.lesson_id
    FROM questions q
    JOIN question_lessons ql ON ql.question_id = q.id AND ql.is_primary
    WHERE q.syllabus_id = p_syllabus
      AND q.deleted_at IS NULL
      AND q.question_type = 'mcq'
      AND q.auto_markable
      AND NOT q.needs_review
  ),
  mine AS (
    SELECT a.question_id, a.is_correct
    FROM answers a
    JOIN attempts t ON t.id = a.attempt_id AND t.student_id = p_student
                   AND t.deleted_at IS NULL
    WHERE a.deleted_at IS NULL AND a.is_correct IS NOT NULL
  )
  SELECT r.lesson_id, l.title, count(*),
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


-- ---------------------------------------------------------------------
-- PART 2 — Practice, with a choice
--
-- p_lesson picks one topic. p_mode 'weak' leans on what the student keeps
-- getting wrong; 'mixed' draws from the whole syllabus.
-- ---------------------------------------------------------------------

DROP FUNCTION IF EXISTS public.student_practice(UUID, INT, UUID);

CREATE FUNCTION public.student_practice(
  p_syllabus UUID,
  p_limit INT DEFAULT 10,
  p_student UUID DEFAULT NULL,
  p_lesson UUID DEFAULT NULL,
  p_mode TEXT DEFAULT 'mixed')
RETURNS TABLE (question_id UUID, question_text TEXT, marks NUMERIC,
               figure_name TEXT, lesson_title TEXT, options JSONB)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  -- Computed once, not once per candidate question: a set-returning function
  -- inside a per-row EXISTS runs the whole weak-topic aggregate for every
  -- question in the bank.
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
           (q.id IN (SELECT question_id FROM right_already)) AS already_right
    FROM questions q
    WHERE q.syllabus_id = p_syllabus
      AND q.deleted_at IS NULL
      AND q.question_type = 'mcq'
      AND q.auto_markable
      AND NOT q.needs_review
      -- One topic, when one was chosen.
      AND (p_lesson IS NULL OR EXISTS (
            SELECT 1 FROM question_lessons ql
            WHERE ql.question_id = q.id AND ql.lesson_id = p_lesson))
      -- Weak mode only makes sense once there is something to be weak at; if
      -- nothing qualifies yet the filter is dropped rather than returning an
      -- empty quiz.
      AND (p_mode <> 'weak'
           OR NOT EXISTS (SELECT 1 FROM weak_q)
           OR q.id IN (SELECT question_id FROM weak_q))
  )
  SELECT id, question_text, marks, figure_name, lesson_title, options
  FROM pool
  ORDER BY already_right ASC,
           (CASE WHEN is_weak AND p_mode <> 'lesson' THEN 0 ELSE 1 END)
             * random() + random() * 0.5,
           random()
  LIMIT greatest(least(p_limit, 50), 1);
$$;

REVOKE ALL ON FUNCTION public.student_practice_topics(UUID, UUID) FROM public;
REVOKE ALL ON FUNCTION public.student_practice(UUID, INT, UUID, UUID, TEXT) FROM public;
GRANT EXECUTE ON FUNCTION public.student_practice_topics(UUID, UUID) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_practice(UUID, INT, UUID, UUID, TEXT) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 3 — Remember what was chosen
--
-- So a run can be reported as "Logic gates, 20 questions" rather than an
-- undifferentiated score, and so a teacher can see what a student chose to
-- work on.
-- ---------------------------------------------------------------------

ALTER TABLE attempts
  ADD COLUMN IF NOT EXISTS lesson_id UUID REFERENCES lessons(id),
  ADD COLUMN IF NOT EXISTS mode TEXT;

ALTER TABLE attempts DROP CONSTRAINT IF EXISTS attempts_mode_check;
ALTER TABLE attempts
  ADD CONSTRAINT attempts_mode_check
  CHECK (mode IS NULL OR mode IN ('mixed', 'weak', 'lesson'));

DROP FUNCTION IF EXISTS public.student_start_practice(UUID, UUID);

CREATE FUNCTION public.student_start_practice(
  p_student UUID, p_syllabus UUID,
  p_lesson UUID DEFAULT NULL, p_mode TEXT DEFAULT 'mixed')
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  a UUID;
BEGIN
  INSERT INTO attempts (assessment_id, student_id, kind, syllabus_id,
                        lesson_id, mode, status)
  VALUES (NULL, p_student, 'practice', p_syllabus,
          p_lesson, coalesce(p_mode, 'mixed'), 'in_progress')
  RETURNING id INTO a;
  RETURN a;
END;
$$;

REVOKE ALL ON FUNCTION public.student_start_practice(UUID, UUID, UUID, TEXT) FROM public;
GRANT EXECUTE ON FUNCTION public.student_start_practice(UUID, UUID, UUID, TEXT)
  TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 4 — Check
-- ---------------------------------------------------------------------

SELECT count(*) AS topics_a_student_could_choose
FROM public.student_practice_topics(
  (SELECT id FROM syllabi WHERE form_level = 'Form 5' AND deleted_at IS NULL
    ORDER BY created_at LIMIT 1));
