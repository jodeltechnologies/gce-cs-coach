-- =====================================================================
-- Phase 11 — letting the teacher read and mark student work
--
-- Run after phase10.sql. Safe to run more than once.
--
-- Students have been able to write Paper 2 answers since phase10, and those
-- answers have been going into the database where nobody could read them. Row
-- Level Security is on for attempts and answers, and no policy was ever
-- written for either, so every teacher read returned nothing. Silent, and
-- total: effort going in one end and disappearing.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — The missing policies
--
-- Students never touch these tables directly; everything they do goes through
-- the SECURITY DEFINER functions. So these policies are for teachers only, and
-- the tables stay shut to anon.
-- ---------------------------------------------------------------------

DROP POLICY IF EXISTS teacher_reads_attempts ON attempts;
CREATE POLICY teacher_reads_attempts ON attempts
  FOR ALL TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_reads_answers ON answers;
CREATE POLICY teacher_reads_answers ON answers
  FOR ALL TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_reads_mastery ON lesson_mastery;
CREATE POLICY teacher_reads_mastery ON lesson_mastery
  FOR ALL TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());

ALTER TABLE lesson_mastery ENABLE ROW LEVEL SECURITY;


-- ---------------------------------------------------------------------
-- PART 2 — What is waiting to be marked
--
-- Only written answers. A multiple choice question marked itself the moment
-- the student pressed the button, and putting those in a marking queue would
-- bury the twelve things that need a person under four hundred that do not.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.marking_queue(
  p_class UUID DEFAULT NULL, p_include_marked BOOLEAN DEFAULT false)
RETURNS TABLE (answer_id UUID, attempt_id UUID,
               student_id UUID, student_name TEXT, class_name TEXT,
               question_id UUID, question_title TEXT, scenario TEXT,
               total_marks NUMERIC, source_paper TEXT,
               response_text TEXT, written_at TIMESTAMPTZ,
               marks_awarded NUMERIC, feedback TEXT, marked_at TIMESTAMPTZ,
               parts JSONB)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT a.id, a.attempt_id,
         st.id, st.full_name, c.name,
         q.id, q.question_text, q.scenario, q.marks, q.source_paper,
         a.response_text, a.created_at,
         a.marks_awarded, a.feedback, a.marked_at,
         (SELECT jsonb_agg(jsonb_build_object(
                   'label', p.label, 'prompt', p.prompt,
                   'marks', p.marks, 'model_answer', p.model_answer)
                 ORDER BY p.sequence)
            FROM question_parts p
           WHERE p.question_id = q.id AND p.deleted_at IS NULL)
  FROM answers a
  JOIN attempts t ON t.id = a.attempt_id AND t.deleted_at IS NULL
  JOIN students st ON st.id = t.student_id AND st.deleted_at IS NULL
  LEFT JOIN enrolments e ON e.student_id = st.id AND e.status = 'active'
                        AND e.deleted_at IS NULL
  LEFT JOIN classes c ON c.id = e.class_id AND c.deleted_at IS NULL
  JOIN questions q ON q.id = a.question_id
  WHERE a.deleted_at IS NULL
    AND q.question_type = 'structured'
    AND a.response_text IS NOT NULL
    AND btrim(a.response_text) <> ''
    AND (p_class IS NULL OR e.class_id = p_class)
    AND (p_include_marked OR a.marked_at IS NULL)
    AND public.is_teacher()
  ORDER BY a.created_at DESC
  LIMIT 60;
$$;

REVOKE ALL ON FUNCTION public.marking_queue(UUID, BOOLEAN) FROM public;
GRANT EXECUTE ON FUNCTION public.marking_queue(UUID, BOOLEAN) TO authenticated;


-- ---------------------------------------------------------------------
-- PART 3 — Recording a mark
--
-- A marked structured answer sets is_correct as well as the mark, so it can
-- count towards the student's weak topics. Half marks or better counts as
-- correct — a rough line, and better than leaving Paper 2 out of the picture
-- entirely, which is what happens while these stay unmarked.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.mark_answer(
  p_answer UUID, p_marks NUMERIC, p_feedback TEXT)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  total NUMERIC;
BEGIN
  IF NOT public.is_teacher() THEN
    RETURN;
  END IF;

  SELECT q.marks INTO total
  FROM answers a JOIN questions q ON q.id = a.question_id
  WHERE a.id = p_answer;

  UPDATE answers
     SET marks_awarded = p_marks,
         feedback = nullif(btrim(coalesce(p_feedback, '')), ''),
         is_correct = CASE WHEN total IS NULL OR total = 0 THEN NULL
                           ELSE p_marks >= total / 2 END,
         marked_by = 'teacher',
         marked_at = now(),
         updated_at = now()
   WHERE id = p_answer;
END;
$$;

REVOKE ALL ON FUNCTION public.mark_answer(UUID, NUMERIC, TEXT) FROM public;
GRANT EXECUTE ON FUNCTION public.mark_answer(UUID, NUMERIC, TEXT) TO authenticated;


-- ---------------------------------------------------------------------
-- PART 4 — A student sees their marked work
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_marked_work(p_student UUID)
RETURNS TABLE (answer_id UUID, question_title TEXT, source_paper TEXT,
               response_text TEXT, marks_awarded NUMERIC, total_marks NUMERIC,
               feedback TEXT, marked_at TIMESTAMPTZ)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT a.id, q.question_text, q.source_paper, a.response_text,
         a.marks_awarded, q.marks, a.feedback, a.marked_at
  FROM answers a
  JOIN attempts t ON t.id = a.attempt_id AND t.student_id = p_student
                 AND t.deleted_at IS NULL
  JOIN questions q ON q.id = a.question_id
  WHERE a.deleted_at IS NULL
    AND q.question_type = 'structured'
    AND a.marked_at IS NOT NULL
  ORDER BY a.marked_at DESC
  LIMIT 30;
$$;

REVOKE ALL ON FUNCTION public.student_marked_work(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_marked_work(UUID) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 5 — Check
-- ---------------------------------------------------------------------

SELECT
  (SELECT count(*) FROM answers a JOIN questions q ON q.id = a.question_id
    WHERE q.question_type = 'structured' AND a.response_text IS NOT NULL
      AND a.deleted_at IS NULL) AS written_answers,
  (SELECT count(*) FROM answers WHERE marked_at IS NOT NULL) AS already_marked;
