-- =====================================================================
-- Phase 7 — telling a student why their answer was wrong
--
-- Run after phase6.sql. Safe to run more than once.
--
-- The static platform that preceded this app carried something the imported
-- pamphlet questions do not: for every wrong option, a sentence explaining why
-- that particular choice is wrong. Not "the answer is B" — "the Control Bus
-- carries control signals, not addresses."
--
-- That distinction is the difference between a score and a lesson. A student
-- who picks the Control Bus has a specific wrong idea, and the sentence that
-- corrects it is the one written against that option. There was nowhere in the
-- schema to keep it, so it gets a column.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — Feedback per option
-- ---------------------------------------------------------------------

ALTER TABLE question_options
  ADD COLUMN IF NOT EXISTS feedback TEXT;

COMMENT ON COLUMN question_options.feedback IS
  'Why a student who chose this option was wrong. Written per option, not per '
  'question: the misconception behind picking C is not the one behind picking D.';


-- ---------------------------------------------------------------------
-- PART 2 — Parts of a structured question
--
-- A Paper 2 question is a scenario followed by (a), (b), (c), each with its
-- own marks and model answer. Flattening that into one row loses the mark
-- allocation, which is most of what makes a structured question teachable.
-- ---------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS question_parts (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id  UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  label        TEXT NOT NULL,              -- '(a)', '(b)(i)'
  prompt       TEXT NOT NULL,
  marks        NUMERIC(5,2) NOT NULL,
  model_answer TEXT,                       -- one point per line
  hint         TEXT,
  sequence     INTEGER NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at   TIMESTAMPTZ,
  UNIQUE (question_id, label)
);

CREATE INDEX IF NOT EXISTS question_parts_by_question
  ON question_parts (question_id, sequence) WHERE deleted_at IS NULL;

ALTER TABLE question_parts ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS teacher_manages_question_parts ON question_parts;
CREATE POLICY teacher_manages_question_parts ON question_parts
  FOR ALL TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());


-- ---------------------------------------------------------------------
-- PART 3 — The scenario a structured question hangs off
-- ---------------------------------------------------------------------

ALTER TABLE questions
  ADD COLUMN IF NOT EXISTS scenario TEXT;

COMMENT ON COLUMN questions.scenario IS
  'The case study a structured question refers to, shared by all its parts.';


-- ---------------------------------------------------------------------
-- PART 4 — Students read the feedback for the option they chose
--
-- student_check returned only whether the answer was right. It now returns the
-- explanation for the question and the feedback written against the option the
-- student actually picked, which is the part that teaches.
--
-- Feedback for options the student did NOT pick is deliberately withheld:
-- handing over every wrong-answer note turns the next attempt into a lookup.
-- ---------------------------------------------------------------------

-- Dropped rather than replaced: this function gains a fourth returned column,
-- and CREATE OR REPLACE cannot change a return type. Dropping also drops the
-- grants, so they are reapplied below.
DROP FUNCTION IF EXISTS public.student_check(UUID, TEXT);

CREATE FUNCTION public.student_check(p_question UUID, p_label TEXT)
RETURNS TABLE (correct BOOLEAN, correct_label TEXT,
               explanation TEXT, your_feedback TEXT)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    (right_option.label = p_label),
    right_option.label,
    q.marking_guide,
    (SELECT o.feedback FROM question_options o
      WHERE o.question_id = p_question AND o.label = p_label)
  FROM question_options right_option
  JOIN questions q ON q.id = right_option.question_id
  WHERE right_option.question_id = p_question
    AND right_option.is_correct
    AND q.deleted_at IS NULL
    AND q.auto_markable
    AND NOT q.needs_review
  LIMIT 1;
$$;

REVOKE ALL ON FUNCTION public.student_check(UUID, TEXT) FROM public;
GRANT EXECUTE ON FUNCTION public.student_check(UUID, TEXT) TO anon, authenticated;


-- Practice can now say which topic a question came from even before it is
-- tagged to a lesson, which the authored questions already carry.
--
-- Dropped for the same reason, and because a default argument value cannot be
-- changed by CREATE OR REPLACE either.
DROP FUNCTION IF EXISTS public.student_practice(UUID, INT);

CREATE FUNCTION public.student_practice(p_syllabus UUID, p_limit INT DEFAULT 10)
RETURNS TABLE (question_id UUID, question_text TEXT, marks NUMERIC,
               figure_name TEXT, lesson_title TEXT, options JSONB)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT q.id, q.question_text, q.marks, q.figure_name,
         coalesce(
           (SELECT l.title FROM question_lessons ql
              JOIN lessons l ON l.id = ql.lesson_id
             WHERE ql.question_id = q.id
             ORDER BY ql.is_primary DESC LIMIT 1),
           q.source_paper),
         (SELECT jsonb_agg(jsonb_build_object('label', o.label, 'text', o.option_text)
                           ORDER BY o.sequence)
            FROM question_options o WHERE o.question_id = q.id)
  FROM questions q
  WHERE q.syllabus_id = p_syllabus
    AND q.deleted_at IS NULL
    AND q.question_type = 'mcq'
    AND q.auto_markable
    AND NOT q.needs_review
  ORDER BY random()
  LIMIT greatest(least(p_limit, 40), 1);
$$;

REVOKE ALL ON FUNCTION public.student_practice(UUID, INT) FROM public;
GRANT EXECUTE ON FUNCTION public.student_practice(UUID, INT) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 5 — Check
-- ---------------------------------------------------------------------

SELECT
  (SELECT count(*) FROM question_options WHERE feedback IS NOT NULL) AS options_with_feedback,
  (SELECT count(*) FROM question_parts WHERE deleted_at IS NULL) AS structured_parts,
  (SELECT count(*) FROM questions
    WHERE deleted_at IS NULL AND auto_markable AND NOT needs_review) AS practice_ready;
