-- =====================================================================
-- Phase 5 — importing the past-question pamphlet
--
-- Run after phase4.sql. Safe to run more than once.
--
-- The 334-page pamphlet of past papers is not clean data. A third of it was
-- scanned rather than typed, so the text came out of OCR and carries character
-- errors. Many questions depend on a diagram that no scanner captured. Most
-- exam booklets were printed without answers at all.
--
-- All of that could be fixed by hand before loading. It would take weeks, and
-- until it was finished the bank would stay empty. The alternative, taken here,
-- is to load it with the doubt attached: every imported question records where
-- it came from and what is wrong with it, and nothing unverified is allowed to
-- mark a student automatically.
--
-- These columns describe the import, not the question. A question you type
-- yourself leaves all of them null.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PART 1 — Provenance and review state
-- ---------------------------------------------------------------------

ALTER TABLE questions
  ADD COLUMN IF NOT EXISTS needs_review  BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS reviewed_at   TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS reviewed_by   UUID REFERENCES teachers(id),
  ADD COLUMN IF NOT EXISTS import_batch  TEXT,
  ADD COLUMN IF NOT EXISTS import_page   INTEGER,
  ADD COLUMN IF NOT EXISTS import_flags  TEXT[],
  ADD COLUMN IF NOT EXISTS answer_origin TEXT,
  ADD COLUMN IF NOT EXISTS answer_confidence TEXT;

-- Where the answer key came from. This matters more than it looks: an answer
-- read off the printed paper and an answer worked out from the syllabus are
-- not the same kind of fact, and a teacher deciding how carefully to check
-- one needs to know which it is.
ALTER TABLE questions
  DROP CONSTRAINT IF EXISTS questions_answer_origin_check;
ALTER TABLE questions
  ADD CONSTRAINT questions_answer_origin_check
  CHECK (answer_origin IS NULL
         OR answer_origin IN ('printed', 'proposed', 'teacher'));

ALTER TABLE questions
  DROP CONSTRAINT IF EXISTS questions_answer_confidence_check;
ALTER TABLE questions
  ADD CONSTRAINT questions_answer_confidence_check
  CHECK (answer_confidence IS NULL
         OR answer_confidence IN ('high', 'medium', 'low'));

COMMENT ON COLUMN questions.answer_origin IS
  'printed  = the key was on the source page. '
  'proposed = worked out from the syllabus during import, never verified. '
  'teacher  = a teacher chose or confirmed it.';

COMMENT ON COLUMN questions.needs_review IS
  'Imported and not yet checked by a teacher against the source page.';
COMMENT ON COLUMN questions.import_page IS
  'Page of the source PDF this question was read from. This is the only way '
  'back to the original when the text or a missing diagram looks wrong.';
COMMENT ON COLUMN questions.import_flags IS
  'What the importer was unsure about: from_ocr, no_answer_key, '
  'missing_options, references_figure, empty_option.';


-- ---------------------------------------------------------------------
-- PART 2 — An unreviewed question may not mark a student
--
-- This is the constraint that makes the rest of the compromise safe. A
-- multiple-choice question whose answer key was never printed, or was read by
-- OCR from a blurred scan, must not be allowed to score anybody. If it has not
-- been reviewed, marking stays manual regardless of type.
-- ---------------------------------------------------------------------

ALTER TABLE questions
  DROP CONSTRAINT IF EXISTS questions_unreviewed_not_auto;

ALTER TABLE questions
  ADD CONSTRAINT questions_unreviewed_not_auto
  CHECK (NOT (auto_markable AND needs_review));


-- ---------------------------------------------------------------------
-- PART 3 — Indexes
--
-- The review queue is the screen a teacher will open most often in the first
-- weeks, and it is always the same query: this syllabus, needs review, oldest
-- first. A partial index costs almost nothing because reviewed rows are not
-- in it at all, and it shrinks as the work gets done.
-- ---------------------------------------------------------------------

CREATE INDEX IF NOT EXISTS questions_review_queue
  ON questions (syllabus_id, import_page)
  WHERE needs_review AND deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS questions_by_import_batch
  ON questions (import_batch) WHERE deleted_at IS NULL;


-- ---------------------------------------------------------------------
-- PART 4 — Check
-- ---------------------------------------------------------------------

SELECT
  (SELECT count(*) FROM questions WHERE deleted_at IS NULL) AS questions,
  (SELECT count(*) FROM questions WHERE deleted_at IS NULL AND needs_review) AS awaiting_review,
  (SELECT count(*) FROM questions WHERE deleted_at IS NULL AND auto_markable) AS mark_themselves;


-- ---------------------------------------------------------------------
-- PART 5 — Figures that did not survive scanning
--
-- Some questions turn on a picture the scanner could not read. Where the
-- picture is standard syllabus content — a NAND gate symbol, an XOR truth
-- table — it can be redrawn once in the app and pointed at by name. Where it
-- is specific to one paper, it is genuinely lost and the question stays
-- flagged.
--
-- Names must match a key in app/admin/questions/QuestionFigure.js. An unknown
-- name renders nothing rather than breaking the page.
-- ---------------------------------------------------------------------

ALTER TABLE questions
  ADD COLUMN IF NOT EXISTS figure_name TEXT;

COMMENT ON COLUMN questions.figure_name IS
  'Named standard figure to render with this question, redrawn because the '
  'scanned original was unreadable. Null for questions that need no figure '
  'or whose figure was specific to the paper and is lost.';
