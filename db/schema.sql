-- =====================================================================
-- GCE Computer Science Coach — Database Schema v3
-- G.H.S. Mbonjo, Limbe
--
-- Corrected against three real documents:
--   * Annual Harmonised Progression Sheet, Computer Science Form 4 (national)
--   * Annual Harmonised Progression Sheet, Form 5 (national)
--   * Progression Sheet for ICT, Lower Sixth (South West regional)
--
-- Design rules that apply to every table:
--   id UUID      generated on the device, so two phones offline never collide
--   updated_at   lets a device ask "what changed since Tuesday?" instead of
--                re-downloading everything over paid mobile data
--   deleted_at   soft delete, so a deletion propagates to a phone that has
--                been offline for a week, and mistakes can be undone
-- =====================================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ---------------------------------------------------------------------
-- PART A — People and classes
-- ---------------------------------------------------------------------

CREATE TABLE teachers (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name     TEXT NOT NULL,
  email         TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  grade         TEXT,
  phone         TEXT,
  school_name   TEXT NOT NULL DEFAULT 'G.H.S. Mbonjo, Limbe',
  role          TEXT NOT NULL DEFAULT 'teacher' CHECK (role IN ('teacher','admin')),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);

CREATE TABLE students (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name      TEXT NOT NULL,
  matricule      TEXT,
  sex            TEXT CHECK (sex IN ('M','F')),
  date_of_birth  DATE,
  student_phone  TEXT,
  guardian_name  TEXT,
  guardian_phone TEXT,
  -- students here mostly have no email, so password reset by email is useless.
  -- login_code is handed out on paper and reset by the teacher in two clicks.
  login_code     TEXT UNIQUE,
  password_hash  TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at     TIMESTAMPTZ
);

-- ---------------------------------------------------------------------
-- PART B — Curriculum
-- ---------------------------------------------------------------------

CREATE TABLE subjects (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT NOT NULL UNIQUE,
  code       TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE levels (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT NOT NULL UNIQUE,
  short_name TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

-- A specific version of a progression sheet.
-- A curriculum revision creates a NEW row rather than editing this one, so a
-- student's 2026 results keep pointing at the sheet they were actually taught.
--
-- The four shape flags are what let one schema hold three structurally
-- different Ministry documents:
--
--   Form 4 CS  : has_modules=t  uses_competencies=t  statements=t  practical=f
--   Form 5 CS  : has_modules=f  uses_competencies=t  statements=f  practical=f
--   L6 ICT     : has_modules=t  uses_competencies=f  statements=f  practical=t
CREATE TABLE syllabi (
  id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subject_id                UUID NOT NULL REFERENCES subjects(id),
  level_id                  UUID NOT NULL REFERENCES levels(id),
  title                     TEXT NOT NULL,
  form_level                TEXT NOT NULL,
  issuing_authority         TEXT,
  scope                     TEXT CHECK (scope IN ('national','regional','school')),
  region                    TEXT,
  version_label             TEXT NOT NULL,
  effective_from            INTEGER NOT NULL,
  effective_until           INTEGER,
  weekly_periods_theory     INTEGER,
  weekly_periods_practical  INTEGER,
  coefficient               INTEGER,
  total_weeks               INTEGER NOT NULL DEFAULT 36,
  module_label              TEXT NOT NULL DEFAULT 'Module',
  has_modules               BOOLEAN NOT NULL DEFAULT false,
  uses_competencies         BOOLEAN NOT NULL DEFAULT false,
  has_competency_statements BOOLEAN NOT NULL DEFAULT false,
  has_practical_stream      BOOLEAN NOT NULL DEFAULT false,
  source_document_url       TEXT,
  created_at                TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at                TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at                TIMESTAMPTZ,
  UNIQUE (title, version_label)
);

-- "Module" on the Form 4 sheet, "Teaching Unit" on the Lower Sixth sheet.
-- Form 5 has none, which is why lessons.module_id is nullable.
CREATE TABLE modules (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  syllabus_id UUID NOT NULL REFERENCES syllabi(id) ON DELETE CASCADE,
  title       TEXT NOT NULL,
  sequence    INTEGER NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at  TIMESTAMPTZ,
  UNIQUE (syllabus_id, sequence)
);

-- One row per "Category of action".
-- competency_statement is nullable: Form 4 states it, Form 5 does not.
--
-- continues_from_id carries a category forward across school years
-- (Form 4 "Analysing simple logic circuits" -> Form 5 "Analyzing simple logic
-- circuits and expressions"). Names drift and spelling flips between British
-- and American forms, so links are PROPOSED by the loader and only act on
-- recommendations once link_confirmed is set true by the teacher.
CREATE TABLE competencies (
  id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  syllabus_id          UUID NOT NULL REFERENCES syllabi(id) ON DELETE CASCADE,
  module_id            UUID REFERENCES modules(id),
  category_of_action   TEXT NOT NULL,
  competency_statement TEXT,
  sequence             INTEGER NOT NULL,
  exam_frequency       TEXT CHECK (exam_frequency IN
                       ('rare','occasional','frequent','almost_certain')),
  continues_from_id    UUID REFERENCES competencies(id),
  link_confirmed       BOOLEAN NOT NULL DEFAULT false,
  created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at           TIMESTAMPTZ,
  UNIQUE (syllabus_id, sequence)
);

CREATE TABLE lessons (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  syllabus_id      UUID NOT NULL REFERENCES syllabi(id) ON DELETE CASCADE,
  module_id        UUID REFERENCES modules(id),       -- NULL for Form 5
  competency_id    UUID REFERENCES competencies(id),  -- NULL for L6 ICT

  -- The Lower Sixth sheet writes "Lesson 33 & 34" as one row; Form 5 starts
  -- numbering at Lesson 0; Evaluation and Remediation rows carry no number.
  lesson_no_start  INTEGER,
  lesson_no_end    INTEGER,
  title            TEXT NOT NULL,

  -- Prescribed by the Ministry. What actually happened lives in scheme_entries.
  term             INTEGER CHECK (term IN (1,2,3)),
  week_from        INTEGER,
  week_to          INTEGER,

  -- Th / Prac / Dig are three independent checkboxes, not one value.
  is_theory        BOOLEAN NOT NULL DEFAULT false,
  is_practical     BOOLEAN NOT NULL DEFAULT false,
  is_digitalised   BOOLEAN NOT NULL DEFAULT false,

  lesson_kind      TEXT NOT NULL DEFAULT 'content' CHECK (lesson_kind IN
                   ('content','diagnostic_evaluation','integration_activity',
                    'evaluation','remediation','practical')),

  content          TEXT,
  teacher_notes    TEXT,
  duration_minutes INTEGER,
  sequence         INTEGER NOT NULL,
  status           TEXT NOT NULL DEFAULT 'draft'
                   CHECK (status IN ('draft','published','archived')),
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at       TIMESTAMPTZ,
  UNIQUE (syllabus_id, sequence)
);

CREATE INDEX lessons_by_week ON lessons (syllabus_id, term, week_from);

-- Holds Form 4/5 "Objectives" and Lower Sixth nested content bullets alike.
CREATE TABLE objectives (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id   UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  kind        TEXT NOT NULL DEFAULT 'objective'
              CHECK (kind IN ('objective','content_point')),
  description TEXT NOT NULL,
  bloom_level TEXT CHECK (bloom_level IN
              ('remember','understand','apply','analyse','evaluate','create')),
  sequence    INTEGER NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at  TIMESTAMPTZ
);

-- The Lower Sixth sheet runs a second 2-hour stream in a parallel column,
-- aligned to theory lessons by week rather than by topic.
CREATE TABLE practical_sections (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  syllabus_id  UUID NOT NULL REFERENCES syllabi(id) ON DELETE CASCADE,
  title        TEXT NOT NULL,
  sequence     INTEGER NOT NULL,
  workbook_ref TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at   TIMESTAMPTZ
);

CREATE TABLE practical_tasks (
  id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  practical_section_id UUID NOT NULL REFERENCES practical_sections(id) ON DELETE CASCADE,
  description          TEXT NOT NULL,
  term                 INTEGER CHECK (term IN (1,2,3)),
  week_from            INTEGER,
  week_to              INTEGER,
  sequence             INTEGER NOT NULL,
  created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at           TIMESTAMPTZ
);

-- ---------------------------------------------------------------------
-- PART C — Notes
--
-- Notes are chaptered by subject area; the progression sheet is sequenced by
-- competency across the year. Chapter 1 of the O/L notes alone lands at three
-- separate points in Form 5. So the link is many-to-many, not one-to-one.
-- ---------------------------------------------------------------------

CREATE TABLE note_sources (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title       TEXT NOT NULL,
  attribution TEXT,
  file_url    TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at  TIMESTAMPTZ
);

CREATE TABLE note_sections (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  note_source_id UUID NOT NULL REFERENCES note_sources(id) ON DELETE CASCADE,
  chapter_number TEXT,
  title          TEXT NOT NULL,
  body           TEXT,
  page_from      INTEGER,
  page_to        INTEGER,
  sequence       INTEGER NOT NULL,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at     TIMESTAMPTZ
);

CREATE TABLE lesson_note_sections (
  lesson_id       UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  note_section_id UUID NOT NULL REFERENCES note_sections(id) ON DELETE CASCADE,
  coverage        TEXT CHECK (coverage IN ('full','partial','background')),
  PRIMARY KEY (lesson_id, note_section_id)
);

CREATE TABLE lesson_resources (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id     UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  kind          TEXT NOT NULL CHECK (kind IN ('image','video','pdf','link','audio')),
  url           TEXT NOT NULL,
  caption       TEXT,
  size_bytes    BIGINT,
  -- student data costs real money in Limbe: nothing large downloads silently
  offline_cache BOOLEAN NOT NULL DEFAULT false,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);

-- ---------------------------------------------------------------------
-- PART D — Classes and the scheme of work
-- ---------------------------------------------------------------------

CREATE TABLE classes (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  teacher_id    UUID NOT NULL REFERENCES teachers(id),
  syllabus_id   UUID NOT NULL REFERENCES syllabi(id),
  name          TEXT NOT NULL,
  form_level    TEXT,
  academic_year TEXT NOT NULL,
  exam_year     INTEGER,   -- NULL for Form 4: it does not sit the GCE
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);

CREATE TABLE enrolments (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id    UUID NOT NULL REFERENCES classes(id),
  student_id  UUID NOT NULL REFERENCES students(id),
  status      TEXT NOT NULL DEFAULT 'active'
              CHECK (status IN ('active','transferred','withdrawn','repeating')),
  enrolled_on DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at  TIMESTAMPTZ,
  UNIQUE (class_id, student_id)
);

-- Prescribed week lives on lessons; actual week lives here.
-- Subtracting one from the other gives slippage, per class, with no arithmetic
-- on your part: prescribed week 14, taught week 17, three weeks behind.
CREATE TABLE scheme_entries (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id     UUID NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
  lesson_id    UUID NOT NULL REFERENCES lessons(id),
  actual_term  INTEGER CHECK (actual_term IN (1,2,3)),
  actual_week  INTEGER,
  actual_date  DATE,
  periods_used INTEGER,
  status       TEXT NOT NULL DEFAULT 'planned'
               CHECK (status IN ('planned','taught','postponed','skipped')),
  observation  TEXT,   -- mirrors the sheet's own Observation column
  reflection   TEXT,   -- private
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at   TIMESTAMPTZ,
  UNIQUE (class_id, lesson_id)
);

-- ---------------------------------------------------------------------
-- PART E — Assessment
-- ---------------------------------------------------------------------

CREATE TABLE questions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  syllabus_id   UUID NOT NULL REFERENCES syllabi(id),
  question_text TEXT NOT NULL,
  question_type TEXT NOT NULL CHECK (question_type IN
                ('mcq','true_false','short_answer','structured','practical',
                 'algorithm','flowchart','trace_table')),
  marks         NUMERIC(5,2) NOT NULL,
  difficulty    TEXT CHECK (difficulty IN ('easy','medium','hard')),
  source        TEXT CHECK (source IN ('gce_past','mock','textbook','teacher')),
  source_year   INTEGER,
  source_paper  TEXT,
  source_number TEXT,
  model_answer  TEXT,
  marking_guide TEXT,
  media_url     TEXT,
  -- Only MCQ, true/false and trace tables mark themselves. A structured answer
  -- on normalization cannot be marked by string comparison, and a confidently
  -- wrong score is worse than no score.
  auto_markable BOOLEAN NOT NULL DEFAULT false,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);

-- Many-to-many: a real GCE question rarely respects lesson boundaries.
CREATE TABLE question_lessons (
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  lesson_id   UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  is_primary  BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (question_id, lesson_id)
);

CREATE TABLE question_options (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  label       TEXT NOT NULL,
  option_text TEXT NOT NULL,
  is_correct  BOOLEAN NOT NULL DEFAULT false,
  sequence    INTEGER NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at  TIMESTAMPTZ
);

CREATE TABLE assessments (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id         UUID NOT NULL REFERENCES classes(id),
  lesson_id        UUID REFERENCES lessons(id),  -- set when it IS an integration activity
  title            TEXT NOT NULL,
  kind             TEXT NOT NULL CHECK (kind IN
                   ('quiz','homework','class_test','mock_exam','practical',
                    'integration_activity','evaluation')),
  total_marks      NUMERIC(6,2),
  duration_minutes INTEGER,
  opens_at         TIMESTAMPTZ,
  closes_at        TIMESTAMPTZ,
  show_results     TEXT NOT NULL DEFAULT 'after_close'
                   CHECK (show_results IN ('immediately','after_close','manual','never')),
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at       TIMESTAMPTZ
);

CREATE TABLE assessment_questions (
  assessment_id  UUID NOT NULL REFERENCES assessments(id) ON DELETE CASCADE,
  question_id    UUID NOT NULL REFERENCES questions(id),
  sequence       INTEGER NOT NULL,
  marks_override NUMERIC(5,2),
  PRIMARY KEY (assessment_id, question_id)
);

CREATE TABLE attempts (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  assessment_id UUID NOT NULL REFERENCES assessments(id),
  student_id    UUID NOT NULL REFERENCES students(id),
  started_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  submitted_at  TIMESTAMPTZ,
  score         NUMERIC(6,2),
  percentage    NUMERIC(5,2),
  status        TEXT NOT NULL DEFAULT 'in_progress'
                CHECK (status IN ('in_progress','submitted','marking','marked','abandoned')),
  synced_at     TIMESTAMPTZ,
  device_label  TEXT,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);

CREATE TABLE answers (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  attempt_id         UUID NOT NULL REFERENCES attempts(id) ON DELETE CASCADE,
  question_id        UUID NOT NULL REFERENCES questions(id),
  selected_option_id UUID REFERENCES question_options(id),
  response_text      TEXT,
  -- flowcharts and trace tables are drawn by hand; students photograph them
  response_media_url TEXT,
  marks_awarded      NUMERIC(5,2),
  is_correct         BOOLEAN,
  feedback           TEXT,
  marked_by          TEXT CHECK (marked_by IN ('auto','teacher')),
  marked_at          TIMESTAMPTZ,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at         TIMESTAMPTZ,
  UNIQUE (attempt_id, question_id)
);

-- ---------------------------------------------------------------------
-- PART F — Mastery
--
-- Recorded per lesson, rolled up through competency -> module -> syllabus.
-- Expect most individual lessons to read insufficient_data for a long time:
-- 91 lessons at 5 questions each is 455 questions for one level. Competency
-- level is where the number becomes meaningful, which is why the teacher
-- dashboard leads with competencies and drills down into lessons.
-- ---------------------------------------------------------------------

CREATE TABLE lesson_mastery (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  lesson_id        UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  stream           TEXT NOT NULL DEFAULT 'theory'
                   CHECK (stream IN ('theory','practical')),
  attempts_count   INTEGER NOT NULL DEFAULT 0,
  questions_count  INTEGER NOT NULL DEFAULT 0,
  average_score    NUMERIC(5,2),
  weighted_score   NUMERIC(5,2),
  mastery_level    TEXT CHECK (mastery_level IN
                   ('insufficient_data','needs_attention','developing','good','mastered')),
  last_activity_at TIMESTAMPTZ,
  recalculated_at  TIMESTAMPTZ,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at       TIMESTAMPTZ,
  UNIQUE (student_id, lesson_id, stream)
);

-- Records every correction the loader made to a Ministry document, so that if
-- the sheet is reissued we can see what we changed and why.
CREATE TABLE curriculum_load_log (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  syllabus_id UUID REFERENCES syllabi(id) ON DELETE CASCADE,
  severity    TEXT NOT NULL CHECK (severity IN ('info','correction','warning','error')),
  message     TEXT NOT NULL,
  source_ref  TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
