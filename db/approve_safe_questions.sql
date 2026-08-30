-- =====================================================================
-- Approving the safe imported questions, from the SQL editor
--
-- The same thing the "Accept all" button on /admin/questions/review does,
-- available here because the button depends on answer_origin being set, and a
-- database loaded from an early version of the question seed does not have it.
--
-- Run PART 1 first and read the numbers. Then run PART 2.
-- Safe to run more than once.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — What is actually in there
--
-- Run this on its own first. If proposed_high is 0 but no_answer_key is
-- large, your question rows predate the answer work: re-run
-- db/seed/04_past_questions.sql from the current zip, which now updates
-- existing rows instead of skipping them, then come back.
-- ---------------------------------------------------------------------

SELECT
  count(*)                                                   AS imported,
  count(*) FILTER (WHERE needs_review)                       AS awaiting_review,
  count(*) FILTER (WHERE answer_origin = 'printed')          AS answer_printed,
  count(*) FILTER (WHERE answer_origin = 'proposed'
                     AND answer_confidence = 'high')         AS proposed_high,
  count(*) FILTER (WHERE answer_origin = 'proposed'
                     AND answer_confidence = 'medium')       AS proposed_medium,
  count(*) FILTER (WHERE answer_origin IS NULL)              AS no_answer_recorded,
  count(*) FILTER (WHERE 'from_ocr' = ANY(import_flags))     AS from_a_scan
FROM questions
WHERE import_batch = 'gce-pamphlet-2026' AND deleted_at IS NULL;


-- ---------------------------------------------------------------------
-- PART 2 — Approve the ones that are safe to approve
--
-- The same rules the button applies, and the reasoning behind each is worth
-- keeping in view, because this is the step where a wrong question becomes a
-- question that marks a student wrong:
--
--   Multiple choice only. Nothing else can be marked automatically.
--   Exactly one correct option. Zero would fail every student who answered;
--     two would be ambiguous.
--   High confidence only. The medium ones are the questions where the answer
--     is clear but something else is not, and those want a person.
--   Nothing from a scan, missing an option, or depending on a diagram.
--
-- Everything excluded here stays in the review queue at
-- /admin/questions/review, which is where your judgement is actually needed.
-- ---------------------------------------------------------------------

WITH safe AS (
  SELECT q.id
  FROM questions q
  WHERE q.import_batch = 'gce-pamphlet-2026'
    AND q.deleted_at IS NULL
    AND q.needs_review
    AND q.question_type = 'mcq'
    AND q.answer_origin = 'proposed'
    AND q.answer_confidence = 'high'
    AND NOT (q.import_flags && ARRAY['from_ocr', 'missing_options',
                                     'empty_option', 'references_figure',
                                     'answer_key_not_among_options'])
    -- Exactly one option marked correct, and at least three options present.
    AND (SELECT count(*) FROM question_options o
          WHERE o.question_id = q.id AND o.is_correct) = 1
    AND (SELECT count(*) FROM question_options o
          WHERE o.question_id = q.id) >= 3
)
UPDATE questions q
   SET needs_review = false,
       reviewed_at = now(),
       reviewed_by = (SELECT id FROM teachers
                       WHERE auth_user_id = auth.uid() LIMIT 1),
       answer_origin = 'teacher',
       auto_markable = true,
       updated_at = now()
  FROM safe
 WHERE q.id = safe.id;


-- ---------------------------------------------------------------------
-- PART 3 — What is left
--
-- The remaining ones are not leftovers. They are the questions where the
-- machine had a reason to doubt itself, which is exactly the set worth your
-- time.
-- ---------------------------------------------------------------------

SELECT
  count(*) FILTER (WHERE needs_review)                    AS still_to_check,
  count(*) FILTER (WHERE NOT needs_review)                AS checked,
  count(*) FILTER (WHERE auto_markable)                   AS now_marking_students
FROM questions
WHERE import_batch = 'gce-pamphlet-2026' AND deleted_at IS NULL;

-- And why each of those is still waiting.
SELECT unnest(import_flags) AS reason, count(*)
FROM questions
WHERE import_batch = 'gce-pamphlet-2026' AND deleted_at IS NULL AND needs_review
GROUP BY 1 ORDER BY 2 DESC;
