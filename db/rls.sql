-- =====================================================================
-- Row Level Security
--
-- READ THIS BEFORE YOU GO LIVE.
--
-- Supabase publishes every table in the `public` schema through an
-- automatic web API. The "anon" key that the app uses is embedded in the
-- browser, so anyone who opens the page can read it and call that API
-- directly. Without the policies below, that means anyone on the internet
-- can read and modify every row you have -- including your students'
-- names, phone numbers and marks.
--
-- Enabling RLS with NO policy means "deny everything". That is the safe
-- default, and it is what most of these tables get. Your server-side code
-- uses the service_role key, which bypasses RLS entirely, so the
-- application still works.
--
-- Run this immediately after schema.sql.
-- =====================================================================

-- Curriculum: public read.
-- The progression sheets are published Ministry documents. Nothing here is
-- confidential, and the app reads them on every page.
ALTER TABLE subjects            ENABLE ROW LEVEL SECURITY;
ALTER TABLE levels              ENABLE ROW LEVEL SECURITY;
ALTER TABLE syllabi             ENABLE ROW LEVEL SECURITY;
ALTER TABLE modules             ENABLE ROW LEVEL SECURITY;
ALTER TABLE competencies        ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons             ENABLE ROW LEVEL SECURITY;
ALTER TABLE objectives          ENABLE ROW LEVEL SECURITY;
ALTER TABLE practical_sections  ENABLE ROW LEVEL SECURITY;
ALTER TABLE practical_tasks     ENABLE ROW LEVEL SECURITY;

CREATE POLICY curriculum_read ON subjects           FOR SELECT USING (true);
CREATE POLICY curriculum_read ON levels             FOR SELECT USING (true);
CREATE POLICY curriculum_read ON syllabi            FOR SELECT USING (true);
CREATE POLICY curriculum_read ON modules            FOR SELECT USING (true);
CREATE POLICY curriculum_read ON competencies       FOR SELECT USING (true);
CREATE POLICY curriculum_read ON lessons            FOR SELECT USING (true);
CREATE POLICY curriculum_read ON objectives         FOR SELECT USING (true);
CREATE POLICY curriculum_read ON practical_sections FOR SELECT USING (true);
CREATE POLICY curriculum_read ON practical_tasks    FOR SELECT USING (true);

-- Everything else: RLS on, no policies, therefore no access through the
-- anon key at all. Students, marks, notes and classes are reachable only
-- from your own server code holding the service_role key.
--
-- When you add student logins later, these get real policies such as
--   USING (student_id = auth.uid())
-- so a student sees their own results and nobody else's.
ALTER TABLE teachers             ENABLE ROW LEVEL SECURITY;
ALTER TABLE students             ENABLE ROW LEVEL SECURITY;
ALTER TABLE classes              ENABLE ROW LEVEL SECURITY;
ALTER TABLE enrolments           ENABLE ROW LEVEL SECURITY;
ALTER TABLE scheme_entries       ENABLE ROW LEVEL SECURITY;
ALTER TABLE note_sources         ENABLE ROW LEVEL SECURITY;
ALTER TABLE note_sections        ENABLE ROW LEVEL SECURITY;
ALTER TABLE lesson_note_sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE lesson_resources     ENABLE ROW LEVEL SECURITY;
ALTER TABLE questions            ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_lessons     ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_options     ENABLE ROW LEVEL SECURITY;
ALTER TABLE assessments          ENABLE ROW LEVEL SECURITY;
ALTER TABLE assessment_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE attempts             ENABLE ROW LEVEL SECURITY;
ALTER TABLE answers              ENABLE ROW LEVEL SECURITY;
ALTER TABLE lesson_mastery       ENABLE ROW LEVEL SECURITY;
ALTER TABLE curriculum_load_log  ENABLE ROW LEVEL SECURITY;

-- Sanity check. Every row this returns should say rowsecurity = true.
-- SELECT tablename, rowsecurity FROM pg_tables
--  WHERE schemaname = 'public' ORDER BY rowsecurity, tablename;
