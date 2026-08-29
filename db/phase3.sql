-- =====================================================================
-- Phase 3 — editing content from the admin page
--
-- Run after phase2.sql. Safe to run more than once.
--
-- Until now the only things you could change without writing SQL were exam
-- frequency and the cross-year links. This opens up lesson notes, teacher
-- notes, objectives, file attachments and the question bank.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — Write access for registered teachers
--
-- Reading the curriculum stays public. Changing it does not.
-- ---------------------------------------------------------------------

DROP POLICY IF EXISTS teacher_edits_lessons ON lessons;
CREATE POLICY teacher_edits_lessons ON lessons
  FOR UPDATE TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_edits_objectives ON objectives;
CREATE POLICY teacher_edits_objectives ON objectives
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_manages_resources ON lesson_resources;
CREATE POLICY teacher_manages_resources ON lesson_resources
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

-- Students need to see attachments on a published lesson.
DROP POLICY IF EXISTS public_reads_resources ON lesson_resources;
CREATE POLICY public_reads_resources ON lesson_resources
  FOR SELECT USING (true);

DROP POLICY IF EXISTS teacher_manages_note_sources ON note_sources;
CREATE POLICY teacher_manages_note_sources ON note_sources
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_manages_note_sections ON note_sections;
CREATE POLICY teacher_manages_note_sections ON note_sections
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_manages_note_links ON lesson_note_sections;
CREATE POLICY teacher_manages_note_links ON lesson_note_sections
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

-- Question bank. Deliberately NOT publicly readable: a student browsing the
-- API should not be able to pull every model answer before the test.
DROP POLICY IF EXISTS teacher_manages_questions ON questions;
CREATE POLICY teacher_manages_questions ON questions
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_manages_question_lessons ON question_lessons;
CREATE POLICY teacher_manages_question_lessons ON question_lessons
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_manages_question_options ON question_options;
CREATE POLICY teacher_manages_question_options ON question_options
  FOR ALL TO authenticated
  USING (public.is_teacher()) WITH CHECK (public.is_teacher());


-- ---------------------------------------------------------------------
-- PART 2 — File storage
--
-- One public bucket for lesson attachments: scanned notes, diagrams, past
-- papers you want students to see.
--
-- "Public" means anyone holding the file's URL can open it, the same as a
-- link to a PDF on a school website. Do not put anything confidential here
-- — no mark sheets, no student lists. Those belong in the database tables,
-- which are locked.
--
-- Uploads go from the browser straight to Supabase, never through the
-- website's server. That matters here: Vercel caps a request at about
-- 4.5 MB, and a scanned chapter of notes is easily larger than that.
-- ---------------------------------------------------------------------

INSERT INTO storage.buckets (id, name, public)
VALUES ('resources', 'resources', true)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS "resources public read"   ON storage.objects;
DROP POLICY IF EXISTS "resources teacher write" ON storage.objects;
DROP POLICY IF EXISTS "resources teacher update" ON storage.objects;
DROP POLICY IF EXISTS "resources teacher delete" ON storage.objects;

CREATE POLICY "resources public read" ON storage.objects
  FOR SELECT USING (bucket_id = 'resources');

CREATE POLICY "resources teacher write" ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'resources' AND public.is_teacher());

CREATE POLICY "resources teacher update" ON storage.objects
  FOR UPDATE TO authenticated
  USING (bucket_id = 'resources' AND public.is_teacher());

CREATE POLICY "resources teacher delete" ON storage.objects
  FOR DELETE TO authenticated
  USING (bucket_id = 'resources' AND public.is_teacher());


-- ---------------------------------------------------------------------
-- PART 3 — Check
-- ---------------------------------------------------------------------

-- The six Form 5 categories with no notes at all. This is the list the
-- admin page now shows you, and the reason the lesson editor exists.
SELECT c.category_of_action, count(l.id) AS lessons
FROM competencies c
JOIN syllabi s ON s.id = c.syllabus_id AND s.form_level = 'Form 5'
JOIN lessons l ON l.competency_id = c.id AND l.lesson_kind = 'content'
WHERE NOT EXISTS (
  SELECT 1 FROM lessons l2
  WHERE l2.competency_id = c.id
    AND coalesce(l2.content, '') <> ''
)
GROUP BY c.category_of_action
ORDER BY c.category_of_action;
