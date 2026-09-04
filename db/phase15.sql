-- Phase 15
--
-- Close the progression sheet.
--
-- The sheet has been readable by anybody since the first day, in two separate
-- ways, and closing only one of them would have looked like a fix without
-- being one.
--
--   1. The routes were open. Signing out left /, /syllabus and /lesson still
--      serving the whole year to whoever asked. That is fixed in middleware.js
--      and in the pages themselves.
--
--   2. THE DATA WAS OPEN. This is the part that mattered. Every curriculum
--      table carried a policy reading FOR SELECT USING (true), which means
--      anybody at all, signed in or not. The anon key is in the page source of
--      every visit, so the sheet could be read straight from the API whatever
--      the pages did. Hiding a link does not close a door.
--
-- After this, curriculum reads need a signed-in teacher. Students are
-- unaffected: everything they see comes through SECURITY DEFINER functions
-- that run as their owner and do not consult these policies at all. That was
-- checked function by function before this file was written, not assumed.
--
-- Safe to run twice.

BEGIN;

-- The old policies said "anybody". Replaced rather than edited, so that a
-- database still carrying the old one does not end up with both: PostgreSQL
-- ORs policies together, and one permissive policy left behind would keep the
-- door open while everything looked shut.
DROP POLICY IF EXISTS curriculum_read ON subjects;
DROP POLICY IF EXISTS curriculum_read ON levels;
DROP POLICY IF EXISTS curriculum_read ON syllabi;
DROP POLICY IF EXISTS curriculum_read ON modules;
DROP POLICY IF EXISTS curriculum_read ON competencies;
DROP POLICY IF EXISTS curriculum_read ON lessons;
DROP POLICY IF EXISTS curriculum_read ON objectives;
DROP POLICY IF EXISTS curriculum_read ON practical_sections;
DROP POLICY IF EXISTS curriculum_read ON practical_tasks;

CREATE POLICY curriculum_read_teacher ON subjects
  FOR SELECT TO authenticated USING (public.is_teacher());
CREATE POLICY curriculum_read_teacher ON levels
  FOR SELECT TO authenticated USING (public.is_teacher());
CREATE POLICY curriculum_read_teacher ON syllabi
  FOR SELECT TO authenticated USING (public.is_teacher());
CREATE POLICY curriculum_read_teacher ON modules
  FOR SELECT TO authenticated USING (public.is_teacher());
CREATE POLICY curriculum_read_teacher ON competencies
  FOR SELECT TO authenticated USING (public.is_teacher());
CREATE POLICY curriculum_read_teacher ON lessons
  FOR SELECT TO authenticated USING (public.is_teacher());
CREATE POLICY curriculum_read_teacher ON objectives
  FOR SELECT TO authenticated USING (public.is_teacher());
CREATE POLICY curriculum_read_teacher ON practical_sections
  FOR SELECT TO authenticated USING (public.is_teacher());
CREATE POLICY curriculum_read_teacher ON practical_tasks
  FOR SELECT TO authenticated USING (public.is_teacher());

COMMIT;


-- ==================================================================
-- Check it, in this order
-- ==================================================================

-- 1. As yourself, signed in. Every count should be greater than zero.
SELECT 'signed in as a teacher' AS check, public.is_teacher()::text AS result
UNION ALL SELECT 'syllabi I can read',  count(*)::text FROM syllabi
UNION ALL SELECT 'lessons I can read',  count(*)::text FROM lessons
UNION ALL SELECT 'objectives I can read', count(*)::text FROM objectives;

-- 2. As nobody. This is the one that matters, and it should return four
--    zeros. It asks the database the same question an unauthenticated
--    request from the internet asks.
SET LOCAL ROLE anon;
SELECT 'anon: syllabi'    AS check, count(*)::text AS result FROM syllabi
UNION ALL SELECT 'anon: lessons',    count(*)::text FROM lessons
UNION ALL SELECT 'anon: objectives', count(*)::text FROM objectives
UNION ALL SELECT 'anon: competencies', count(*)::text FROM competencies;
RESET ROLE;

-- 3. And confirm students are untouched. Put a real student id in and the
--    lesson list should still come back, because that function runs as its
--    owner rather than as the caller.
--
-- SELECT count(*) FROM student_next_lessons('paste-a-student-id-here');
