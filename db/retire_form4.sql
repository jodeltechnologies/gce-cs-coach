-- Remove Form 4 from active use without destroying stored student results.
-- Run once after applying the current curriculum seeds. Safe to repeat.
BEGIN;
CREATE TEMP TABLE retired_form4_ids ON COMMIT DROP AS
  SELECT id FROM syllabi WHERE form_level = 'Form 4';
UPDATE lessons SET deleted_at = COALESCE(deleted_at, now())
  WHERE syllabus_id IN (SELECT id FROM retired_form4_ids);
UPDATE competencies SET deleted_at = COALESCE(deleted_at, now())
  WHERE syllabus_id IN (SELECT id FROM retired_form4_ids);
UPDATE modules SET deleted_at = COALESCE(deleted_at, now())
  WHERE syllabus_id IN (SELECT id FROM retired_form4_ids);
UPDATE classes SET deleted_at = COALESCE(deleted_at, now())
  WHERE form_level = 'Form 4' OR syllabus_id IN (SELECT id FROM retired_form4_ids);
UPDATE note_sources SET deleted_at = COALESCE(deleted_at, now())
  WHERE syllabus_id IN (SELECT id FROM retired_form4_ids);
UPDATE syllabi SET deleted_at = COALESCE(deleted_at, now())
  WHERE id IN (SELECT id FROM retired_form4_ids);
COMMIT;
-- Verification: this must return zero active Form 4 sheets and classes.
SELECT 'syllabi' AS item, count(*) FROM syllabi WHERE form_level = 'Form 4' AND deleted_at IS NULL
UNION ALL
SELECT 'classes', count(*) FROM classes WHERE form_level = 'Form 4' AND deleted_at IS NULL;
