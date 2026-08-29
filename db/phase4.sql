-- =====================================================================
-- Phases 4 and 5 — the student roll and the question bank
--
-- Run after phase3.sql. Safe to run more than once.
--
-- Most of the permissions were already granted in phase2 and phase3. What is
-- left is the indexes that keep things quick once there are real numbers of
-- rows, and one constraint that stops a class register going wrong.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — Indexes
--
-- 45 students is nothing. But a question bank of two thousand questions,
-- filtered by lesson, on a phone in Limbe, is a different matter. Without
-- these, every filter reads the whole table.
-- ---------------------------------------------------------------------

CREATE INDEX IF NOT EXISTS students_by_name
  ON students (lower(full_name)) WHERE deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS students_by_matricule
  ON students (matricule) WHERE deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS enrolments_by_class
  ON enrolments (class_id) WHERE deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS enrolments_by_student
  ON enrolments (student_id) WHERE deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS questions_by_syllabus
  ON questions (syllabus_id) WHERE deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS questions_by_source
  ON questions (source, source_year) WHERE deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS question_lessons_by_lesson
  ON question_lessons (lesson_id);

CREATE INDEX IF NOT EXISTS question_options_by_question
  ON question_options (question_id) WHERE deleted_at IS NULL;


-- ---------------------------------------------------------------------
-- PART 2 — One enrolment per student per class
--
-- The schema already has UNIQUE (class_id, student_id). This makes the
-- intent explicit and gives a clearer error if a student is added twice:
-- without it you end up with a register that counts somebody twice and a
-- class average that is quietly wrong.
-- ---------------------------------------------------------------------

-- Already enforced by the table definition. Verify it is there:
SELECT conname, pg_get_constraintdef(oid)
FROM pg_constraint
WHERE conrelid = 'enrolments'::regclass AND contype = 'u';


-- ---------------------------------------------------------------------
-- PART 3 — A note on student logins, which are NOT in this phase
--
-- Students will sign in with the short code you hand out on paper, not an
-- email address. Supabase Auth wants an email, so each student will get a
-- synthetic one behind the scenes (for example MBJ-K4T9WP@pupil.local) that
-- nobody ever types or receives mail at.
--
-- Creating those accounts needs the service_role key, which bypasses every
-- security policy in this database. That key must live only in Vercel's
-- server-side environment, never in a NEXT_PUBLIC_ variable, and never in
-- GitHub. Because getting that wrong would expose everything, it is its own
-- phase rather than something bolted onto this one.
--
-- For now: generate the codes, print them, hand them out. The codes are
-- stored and unique, so nothing has to be redone when logins are switched on.
-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- PART 4 — Check
-- ---------------------------------------------------------------------

SELECT
  (SELECT count(*) FROM students   WHERE deleted_at IS NULL) AS students,
  (SELECT count(*) FROM enrolments WHERE deleted_at IS NULL) AS enrolments,
  (SELECT count(*) FROM questions  WHERE deleted_at IS NULL) AS questions;
