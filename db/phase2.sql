-- =====================================================================
-- Phase 2 — link repair, plus classes and the term planner
--
-- Run this in the Supabase SQL Editor after the six files from Step 2.
-- It is safe to run more than once.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — Repair the cross-year links
--
-- Why this is needed: the links are written by UPDATE statements at the end
-- of the Form 5 seed file, and they look Form 4's categories up by name. If
-- Form 5 was loaded before Form 4, or from a seed file generated before the
-- loader learned to emit them, the lookup found nothing and left them null.
--
-- Matching on the names directly here means load order stops mattering.
-- ---------------------------------------------------------------------

WITH pairs(form5_category, form4_category) AS (
  VALUES
    ('Writing algorithms',                           'Using control structures'),
    ('Converting an algorithm into a program',       'Writing of source code'),
    ('Describing peripheral devices',                'Choosing appropriate peripheral devices'),
    ('Representing data in the computer',            'Operations on number systems'),
    ('Analyzing simple logic circuits and expressions','Analysing simple logic circuits'),
    ('Creating digital content using software',      'Creating digital content')
)
UPDATE competencies c
SET continues_from_id = f4.id,
    updated_at        = now()
FROM pairs p
JOIN syllabi s5      ON s5.form_level = 'Form 5'
JOIN competencies c5 ON c5.syllabus_id = s5.id AND c5.category_of_action = p.form5_category
JOIN syllabi s4      ON s4.form_level = 'Form 4'
JOIN competencies f4 ON f4.syllabus_id = s4.id AND f4.category_of_action = p.form4_category
WHERE c.id = c5.id
  AND c.continues_from_id IS DISTINCT FROM f4.id
  AND c.link_confirmed = false;

-- Should return 6 rows, all with link_confirmed = false.
-- If it returns 0, check that BOTH Form 4 and Form 5 seed files were loaded:
--   SELECT form_level FROM syllabi ORDER BY form_level;
SELECT c.category_of_action AS form5,
       p.category_of_action AS continues,
       c.link_confirmed
FROM competencies c
JOIN competencies p ON p.id = c.continues_from_id
ORDER BY c.sequence;


-- ---------------------------------------------------------------------
-- PART 2 — Let teachers manage classes, students and the scheme of work
--
-- These tables had RLS enabled with no policies, which means deny
-- everything. That was the right default while nothing wrote to them.
-- Now the planner needs to.
-- ---------------------------------------------------------------------

DROP POLICY IF EXISTS teacher_manages_classes ON classes;
CREATE POLICY teacher_manages_classes ON classes
  FOR ALL TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_manages_students ON students;
CREATE POLICY teacher_manages_students ON students
  FOR ALL TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_manages_enrolments ON enrolments;
CREATE POLICY teacher_manages_enrolments ON enrolments
  FOR ALL TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());

DROP POLICY IF EXISTS teacher_manages_scheme ON scheme_entries;
CREATE POLICY teacher_manages_scheme ON scheme_entries
  FOR ALL TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());

-- Note on scope. These say "any registered teacher", not "the teacher who
-- owns this class". That is correct today, because there is exactly one of
-- you. The moment a colleague at Mbonjo is added to the teachers table, these
-- four policies need tightening to something like:
--
--   USING (EXISTS (SELECT 1 FROM classes c
--                  JOIN teachers t ON t.id = c.teacher_id
--                  WHERE c.id = classes.id AND t.auth_user_id = auth.uid()))
--
-- Writing it down now so it is a decision later, not a surprise.


-- ---------------------------------------------------------------------
-- PART 3 — Check
-- ---------------------------------------------------------------------

-- Every row should still say true.
SELECT tablename, rowsecurity FROM pg_tables
WHERE schemaname = 'public' ORDER BY rowsecurity, tablename;
