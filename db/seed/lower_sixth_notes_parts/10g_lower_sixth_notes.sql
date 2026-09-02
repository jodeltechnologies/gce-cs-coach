-- Part G of 7 — links the notes to lessons and fixes the year.
-- Run the parts in alphabetical order, one at a time.
-- Safe to run again if you lose your place.

BEGIN;

-- Each note is the reading for the lesson of the same name. Matching on
-- title rather than a stored id keeps the two in step: rename a lesson on
-- the sheet and the link is rebuilt from the sheet.
--
-- Practical titles repeat across the year, so one note attaches to several
-- lessons. That is intended.
INSERT INTO lesson_note_sections (lesson_id, note_section_id, coverage)
SELECT l.id, s.id, 'full'
FROM note_sections s
JOIN lessons l ON l.title = s.title AND l.deleted_at IS NULL
-- Lower Sixth lessons only; lesson titles are not unique across years.
JOIN syllabi sy ON sy.id = l.syllabus_id AND sy.form_level = 'Lower Sixth'
WHERE s.note_source_id = '7df11f03-a526-56c6-abb9-562db2871de7' AND s.deleted_at IS NULL
ON CONFLICT (lesson_id, note_section_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- What a student sees when they open Notes.
--
-- app/student/notes/page.js calls student_notes(p_student), and no such
-- function existed: the only definition takes no arguments, so the call
-- resolved to nothing and every student was told their year's notes were
-- still being prepared.
--
-- Both written sets also set note_sources.syllabus_id and nothing read it.
-- With two years of notes in the table that stops being a tidiness matter:
-- a Form 5 student opening Notes would be handed the Lower Sixth material,
-- and would have no way to tell.
--
-- A source with no syllabus_id is not year-specific and is shown to
-- everyone. That is how the scanned booklets behave today and this keeps
-- them behaving that way.
--
-- Dropped before creating: the old signature has to go or the two overloads
-- sit side by side, and a caller that passes no argument silently gets the
-- unscoped one back.
DROP FUNCTION IF EXISTS public.student_notes();
DROP FUNCTION IF EXISTS public.student_notes(UUID);
CREATE FUNCTION public.student_notes(p_student UUID)
RETURNS TABLE (id UUID, chapter_number TEXT, title TEXT, body TEXT,
               body_format TEXT, source_title TEXT, source_sequence INT,
               page_from INT, page_to INT)
LANGUAGE sql SECURITY DEFINER SET search_path = public
AS $fn$
  SELECT s.id, s.chapter_number, s.title, s.body, s.body_format,
         src.title, src.sequence, s.page_from, s.page_to
  FROM note_sections s
  JOIN note_sources src ON src.id = s.note_source_id
  WHERE s.deleted_at IS NULL
    AND (src.syllabus_id IS NULL OR src.syllabus_id = (
      -- The class's own syllabus_id, not its form_level. form_level is
      -- nullable and student_profile matches on it; a class saved without
      -- one would show that student nothing at all.
      SELECT c.syllabus_id
      FROM students st
      JOIN enrolments e ON e.student_id = st.id
                       AND e.status = 'active' AND e.deleted_at IS NULL
      JOIN classes c ON c.id = e.class_id AND c.deleted_at IS NULL
      WHERE st.id = p_student AND st.deleted_at IS NULL
      ORDER BY e.enrolled_on DESC
      LIMIT 1))
  -- Written notes first, scanned booklets after: a student opening Notes
  -- should land on the readable version, not the photocopy.
  ORDER BY src.sequence, s.sequence;
$fn$;
REVOKE ALL ON FUNCTION public.student_notes(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_notes(UUID) TO anon, authenticated;

SELECT src.title AS source, count(*) AS notes
FROM note_sections s JOIN note_sources src ON src.id = s.note_source_id
WHERE s.deleted_at IS NULL GROUP BY src.title ORDER BY min(src.sequence);

COMMIT;
