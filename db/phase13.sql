-- Phase 13
--
-- Four things the student side was missing.
--
--   1. The teacher decides when a note is released. Until now every note
--      appeared the moment it was loaded, so a class could read week 12 in
--      week 2.
--   2. The questions at the foot of a note hide their answers until the
--      student has had a go, and what the student says about how they did is
--      recorded.
--   3. A student can write to the teacher and the teacher can write back.
--   4. Both sides can see how a student is doing, the student for themselves
--      and the teacher across the class.
--
-- Safe to run twice.

BEGIN;

-- ------------------------------------------------------------------
-- 1. Releasing notes
--
-- Existing sources keep working exactly as they did. A source is 'open'
-- unless it is marked 'staged', and only a staged source needs a release
-- row. That way loading this file does not make the notes already in front
-- of students disappear.
-- ------------------------------------------------------------------

ALTER TABLE note_sources
  ADD COLUMN IF NOT EXISTS release_mode TEXT NOT NULL DEFAULT 'open'
    CHECK (release_mode IN ('open', 'staged'));

CREATE TABLE IF NOT EXISTS note_releases (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id        UUID NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
  note_section_id UUID NOT NULL REFERENCES note_sections(id) ON DELETE CASCADE,
  released_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  released_by     UUID REFERENCES teachers(id),
  UNIQUE (class_id, note_section_id)
);

CREATE INDEX IF NOT EXISTS note_releases_by_class
  ON note_releases (class_id, note_section_id);

-- ------------------------------------------------------------------
-- 2. The questions at the foot of a note
--
-- These are written questions with a model answer, so nothing here can mark
-- them automatically. The student answers in their head or on paper, reveals
-- the model answer, and then says which of three things happened. That is a
-- self report and it is stored as one. It is not a test score and the column
-- name says so.
-- ------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS self_check_attempts (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id      UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  note_section_id UUID NOT NULL REFERENCES note_sections(id) ON DELETE CASCADE,
  question_index  INTEGER NOT NULL,
  question_text   TEXT,
  self_report     TEXT NOT NULL
                  CHECK (self_report IN ('got_it', 'partly', 'missed')),
  answered_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (student_id, note_section_id, question_index)
);

CREATE INDEX IF NOT EXISTS self_check_by_student
  ON self_check_attempts (student_id, note_section_id);

-- ------------------------------------------------------------------
-- 3. Messages
--
-- One thread for each student. There is one teacher per class here, so
-- threads and recipients would be machinery with nothing to do.
-- ------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS messages (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id  UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  sender      TEXT NOT NULL CHECK (sender IN ('student', 'teacher')),
  body        TEXT NOT NULL CHECK (length(btrim(body)) > 0),
  -- What the student was reading when they asked. A question about a lesson
  -- is far easier to answer when you can see which lesson.
  lesson_id       UUID REFERENCES lessons(id) ON DELETE SET NULL,
  note_section_id UUID REFERENCES note_sections(id) ON DELETE SET NULL,
  read_at     TIMESTAMPTZ,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS messages_by_student
  ON messages (student_id, created_at DESC);

ALTER TABLE note_releases         ENABLE ROW LEVEL SECURITY;
ALTER TABLE self_check_attempts   ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages              ENABLE ROW LEVEL SECURITY;

-- No policies are added, so the anon key reaches none of these tables
-- directly. Everything below is SECURITY DEFINER and takes the student id
-- from a signed cookie the server checked first.

COMMIT;


-- ==================================================================
-- Functions
-- ==================================================================

BEGIN;

-- The class a student belongs to. Used by nearly everything below, so it is
-- written once.
CREATE OR REPLACE FUNCTION public.student_class(p_student UUID)
RETURNS TABLE (class_id UUID, syllabus_id UUID, class_name TEXT,
               form_level TEXT, teacher_id UUID)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $fn$
  SELECT c.id, c.syllabus_id, c.name, c.form_level, c.teacher_id
  FROM students st
  JOIN enrolments e ON e.student_id = st.id
                   AND e.status = 'active' AND e.deleted_at IS NULL
  JOIN classes c ON c.id = e.class_id AND c.deleted_at IS NULL
  WHERE st.id = p_student AND st.deleted_at IS NULL
  ORDER BY e.enrolled_on DESC
  LIMIT 1;
$fn$;

-- ------------------------------------------------------------------
-- Notes a student may read
--
-- Same as before for an open source. A staged source shows only the sections
-- released to that student's class.
-- ------------------------------------------------------------------
DROP FUNCTION IF EXISTS public.student_notes(UUID);
CREATE FUNCTION public.student_notes(p_student UUID)
RETURNS TABLE (id UUID, chapter_number TEXT, title TEXT, body TEXT,
               body_format TEXT, source_title TEXT, source_sequence INT,
               page_from INT, page_to INT, released_at TIMESTAMPTZ)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $fn$
  WITH me AS (SELECT * FROM student_class(p_student))
  SELECT s.id, s.chapter_number, s.title, s.body, s.body_format,
         src.title, src.sequence, s.page_from, s.page_to, r.released_at
  FROM note_sections s
  JOIN note_sources src ON src.id = s.note_source_id
  LEFT JOIN me ON true
  LEFT JOIN note_releases r
         ON r.note_section_id = s.id AND r.class_id = me.class_id
  WHERE s.deleted_at IS NULL
    AND (src.syllabus_id IS NULL OR src.syllabus_id = me.syllabus_id)
    AND (src.release_mode = 'open' OR r.id IS NOT NULL)
  ORDER BY src.sequence, s.sequence;
$fn$;
REVOKE ALL ON FUNCTION public.student_notes(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_notes(UUID) TO anon, authenticated;

-- ------------------------------------------------------------------
-- The next ten lessons
--
-- The whole sheet at once is thirty-six weeks of work and it reads as a
-- wall. What a student can act on is the week they are in and the few after
-- it, so that is what this returns.
-- ------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.student_next_lessons(
  p_student UUID, p_week INTEGER DEFAULT NULL, p_limit INTEGER DEFAULT 10)
RETURNS TABLE (lesson_id UUID, lesson_no INTEGER, title TEXT, term INTEGER,
               week_from INTEGER, lesson_kind TEXT, category TEXT,
               note_section_id UUID, note_title TEXT, note_released BOOLEAN,
               self_checks_done INTEGER, self_checks_missed INTEGER)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $fn$
  WITH me AS (SELECT * FROM student_class(p_student))
  SELECT l.id, l.lesson_no_start, l.title, l.term, l.week_from, l.lesson_kind,
         comp.category_of_action,
         s.id, s.title,
         (src.release_mode = 'open' OR r.id IS NOT NULL),
         coalesce(sc.done, 0), coalesce(sc.missed, 0)
  FROM lessons l
  CROSS JOIN me
  LEFT JOIN competencies comp ON comp.id = l.competency_id
  LEFT JOIN lesson_note_sections lns ON lns.lesson_id = l.id
  LEFT JOIN note_sections s ON s.id = lns.note_section_id AND s.deleted_at IS NULL
  LEFT JOIN note_sources src ON src.id = s.note_source_id
  LEFT JOIN note_releases r ON r.note_section_id = s.id AND r.class_id = me.class_id
  LEFT JOIN LATERAL (
    SELECT count(*) FILTER (WHERE a.self_report <> 'missed')::int AS done,
           count(*) FILTER (WHERE a.self_report = 'missed')::int  AS missed
    FROM self_check_attempts a
    WHERE a.student_id = p_student AND a.note_section_id = s.id) sc ON true
  WHERE l.syllabus_id = me.syllabus_id
    AND l.deleted_at IS NULL
    AND l.week_from >= coalesce(p_week, 1)
  ORDER BY l.sequence
  LIMIT greatest(1, least(coalesce(p_limit, 10), 40));
$fn$;
REVOKE ALL ON FUNCTION public.student_next_lessons(UUID, INTEGER, INTEGER) FROM public;
GRANT EXECUTE ON FUNCTION public.student_next_lessons(UUID, INTEGER, INTEGER)
  TO anon, authenticated;

-- ------------------------------------------------------------------
-- How a student is doing
--
-- Two separate things, kept separate. Practice answers are marked by the
-- app. Self checks are what the student said about themselves. Adding them
-- together would produce a number that means nothing.
-- ------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.student_overview(p_student UUID)
RETURNS TABLE (practice_answered INTEGER, practice_correct INTEGER,
               practice_runs INTEGER,
               checks_answered INTEGER, checks_got_it INTEGER,
               checks_partly INTEGER, checks_missed INTEGER,
               notes_opened INTEGER, notes_available INTEGER)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $fn$
  WITH me AS (SELECT * FROM student_class(p_student)),
  pr AS (
    SELECT count(*)::int AS answered,
           count(*) FILTER (WHERE ans.is_correct)::int AS correct,
           count(DISTINCT ans.attempt_id)::int AS runs
    FROM answers ans
    JOIN attempts at ON at.id = ans.attempt_id
    WHERE at.student_id = p_student),
  ck AS (
    SELECT count(*)::int AS answered,
           count(*) FILTER (WHERE self_report = 'got_it')::int AS got_it,
           count(*) FILTER (WHERE self_report = 'partly')::int AS partly,
           count(*) FILTER (WHERE self_report = 'missed')::int AS missed,
           count(DISTINCT note_section_id)::int AS sections
    FROM self_check_attempts WHERE student_id = p_student),
  av AS (
    SELECT count(*)::int AS n
    FROM note_sections s
    JOIN note_sources src ON src.id = s.note_source_id
    LEFT JOIN me ON true
    LEFT JOIN note_releases r ON r.note_section_id = s.id AND r.class_id = me.class_id
    WHERE s.deleted_at IS NULL
      AND (src.syllabus_id IS NULL OR src.syllabus_id = me.syllabus_id)
      AND (src.release_mode = 'open' OR r.id IS NOT NULL))
  SELECT coalesce(pr.answered, 0), coalesce(pr.correct, 0), coalesce(pr.runs, 0),
         coalesce(ck.answered, 0), coalesce(ck.got_it, 0),
         coalesce(ck.partly, 0), coalesce(ck.missed, 0),
         coalesce(ck.sections, 0), coalesce(av.n, 0)
  FROM pr, ck, av;
$fn$;
REVOKE ALL ON FUNCTION public.student_overview(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_overview(UUID) TO anon, authenticated;

-- Where a student said they struggled, newest first.
CREATE OR REPLACE FUNCTION public.student_check_weak(p_student UUID)
RETURNS TABLE (note_section_id UUID, note_title TEXT, chapter_number TEXT,
               missed INTEGER, partly INTEGER, total INTEGER,
               last_seen TIMESTAMPTZ)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $fn$
  SELECT s.id, s.title, s.chapter_number,
         count(*) FILTER (WHERE a.self_report = 'missed')::int,
         count(*) FILTER (WHERE a.self_report = 'partly')::int,
         count(*)::int, max(a.answered_at)
  FROM self_check_attempts a
  JOIN note_sections s ON s.id = a.note_section_id
  WHERE a.student_id = p_student
  GROUP BY s.id, s.title, s.chapter_number
  HAVING count(*) FILTER (WHERE a.self_report <> 'got_it') > 0
  ORDER BY count(*) FILTER (WHERE a.self_report = 'missed') DESC,
           max(a.answered_at) DESC;
$fn$;
REVOKE ALL ON FUNCTION public.student_check_weak(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_check_weak(UUID) TO anon, authenticated;

-- Recording one answer. Answering again replaces the earlier report rather
-- than adding a second row, because a student who comes back to a question
-- after reading the note is telling you something newer, not something extra.
CREATE OR REPLACE FUNCTION public.record_self_check(
  p_student UUID, p_section UUID, p_index INTEGER,
  p_question TEXT, p_report TEXT)
RETURNS VOID
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $fn$
BEGIN
  IF p_report NOT IN ('got_it', 'partly', 'missed') THEN
    RAISE EXCEPTION 'unknown self report %', p_report;
  END IF;
  INSERT INTO self_check_attempts
    (student_id, note_section_id, question_index, question_text, self_report)
  VALUES (p_student, p_section, p_index, left(coalesce(p_question, ''), 500), p_report)
  ON CONFLICT (student_id, note_section_id, question_index)
  DO UPDATE SET self_report = EXCLUDED.self_report,
                question_text = EXCLUDED.question_text,
                answered_at = now();
END;
$fn$;
REVOKE ALL ON FUNCTION public.record_self_check(UUID, UUID, INTEGER, TEXT, TEXT) FROM public;
GRANT EXECUTE ON FUNCTION public.record_self_check(UUID, UUID, INTEGER, TEXT, TEXT)
  TO anon, authenticated;

-- What this student has already answered in one note, so the page can come
-- back the way they left it.
CREATE OR REPLACE FUNCTION public.student_section_checks(
  p_student UUID, p_section UUID)
RETURNS TABLE (question_index INTEGER, self_report TEXT, answered_at TIMESTAMPTZ)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $fn$
  SELECT question_index, self_report, answered_at
  FROM self_check_attempts
  WHERE student_id = p_student AND note_section_id = p_section
  ORDER BY question_index;
$fn$;
REVOKE ALL ON FUNCTION public.student_section_checks(UUID, UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_section_checks(UUID, UUID)
  TO anon, authenticated;

-- ------------------------------------------------------------------
-- Messages
-- ------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.student_send_message(
  p_student UUID, p_body TEXT, p_lesson UUID DEFAULT NULL,
  p_section UUID DEFAULT NULL)
RETURNS UUID
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $fn$
DECLARE new_id UUID;
BEGIN
  IF coalesce(btrim(p_body), '') = '' THEN
    RAISE EXCEPTION 'empty message';
  END IF;
  -- A cap, so a stuck key or a bored afternoon cannot fill the table.
  IF (SELECT count(*) FROM messages
      WHERE student_id = p_student AND sender = 'student'
        AND created_at > now() - interval '1 hour') >= 20 THEN
    RAISE EXCEPTION 'too many messages in the last hour';
  END IF;
  INSERT INTO messages (student_id, sender, body, lesson_id, note_section_id)
  VALUES (p_student, 'student', left(btrim(p_body), 4000), p_lesson, p_section)
  RETURNING id INTO new_id;
  RETURN new_id;
END;
$fn$;
REVOKE ALL ON FUNCTION public.student_send_message(UUID, TEXT, UUID, UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_send_message(UUID, TEXT, UUID, UUID)
  TO anon, authenticated;

CREATE OR REPLACE FUNCTION public.student_messages(p_student UUID)
RETURNS TABLE (id UUID, sender TEXT, body TEXT, created_at TIMESTAMPTZ,
               read_at TIMESTAMPTZ, lesson_title TEXT, note_title TEXT)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $fn$
  SELECT m.id, m.sender, m.body, m.created_at, m.read_at, l.title, s.title
  FROM messages m
  LEFT JOIN lessons l ON l.id = m.lesson_id
  LEFT JOIN note_sections s ON s.id = m.note_section_id
  WHERE m.student_id = p_student
  ORDER BY m.created_at;
$fn$;
REVOKE ALL ON FUNCTION public.student_messages(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_messages(UUID) TO anon, authenticated;

-- Marks the teacher's replies as seen. Called when the student opens the page.
CREATE OR REPLACE FUNCTION public.student_mark_read(p_student UUID)
RETURNS VOID
LANGUAGE sql SECURITY DEFINER SET search_path = public
AS $fn$
  UPDATE messages SET read_at = now()
  WHERE student_id = p_student AND sender = 'teacher' AND read_at IS NULL;
$fn$;
REVOKE ALL ON FUNCTION public.student_mark_read(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.student_mark_read(UUID) TO anon, authenticated;

COMMIT;

-- What was created.
SELECT 'note_releases' AS table_name, count(*)::text AS rows FROM note_releases
UNION ALL SELECT 'self_check_attempts', count(*)::text FROM self_check_attempts
UNION ALL SELECT 'messages', count(*)::text FROM messages
UNION ALL SELECT 'staged note sources', count(*)::text
  FROM note_sources WHERE release_mode = 'staged';


-- ==================================================================
-- The teacher's side
--
-- These run under the teacher's own session through the anon key, so Row
-- Level Security decides what they may see. They are not SECURITY DEFINER:
-- a function that hands back every student's work should not bypass the
-- checks that keep one teacher out of another's classes.
-- ==================================================================

BEGIN;

-- Who has written in, newest first, with the unread count.
CREATE OR REPLACE FUNCTION public.teacher_inbox()
RETURNS TABLE (student_id UUID, full_name TEXT, class_name TEXT,
               last_body TEXT, last_sender TEXT, last_at TIMESTAMPTZ,
               unread INTEGER, total INTEGER)
LANGUAGE sql STABLE SET search_path = public
AS $fn$
  WITH mine AS (
    SELECT DISTINCT e.student_id
    FROM classes c
    JOIN enrolments e ON e.class_id = c.id
                     AND e.status = 'active' AND e.deleted_at IS NULL
    JOIN teachers t ON t.id = c.teacher_id
    WHERE c.deleted_at IS NULL AND t.auth_user_id = auth.uid())
  SELECT st.id, st.full_name, c.name,
         last.body, last.sender, last.created_at,
         count(*) FILTER (WHERE m.sender = 'student' AND m.read_at IS NULL)::int,
         count(*)::int
  FROM messages m
  JOIN mine ON mine.student_id = m.student_id
  JOIN students st ON st.id = m.student_id
  LEFT JOIN enrolments e ON e.student_id = st.id
                        AND e.status = 'active' AND e.deleted_at IS NULL
  LEFT JOIN classes c ON c.id = e.class_id
  JOIN LATERAL (
    SELECT body, sender, created_at FROM messages m2
    WHERE m2.student_id = m.student_id
    ORDER BY created_at DESC LIMIT 1) last ON true
  GROUP BY st.id, st.full_name, c.name, last.body, last.sender, last.created_at
  ORDER BY last.created_at DESC;
$fn$;
GRANT EXECUTE ON FUNCTION public.teacher_inbox() TO authenticated;

CREATE OR REPLACE FUNCTION public.teacher_thread(p_student UUID)
RETURNS TABLE (id UUID, sender TEXT, body TEXT, created_at TIMESTAMPTZ,
               read_at TIMESTAMPTZ, lesson_title TEXT, note_title TEXT)
LANGUAGE sql STABLE SET search_path = public
AS $fn$
  SELECT m.id, m.sender, m.body, m.created_at, m.read_at, l.title, s.title
  FROM messages m
  LEFT JOIN lessons l ON l.id = m.lesson_id
  LEFT JOIN note_sections s ON s.id = m.note_section_id
  WHERE m.student_id = p_student
  ORDER BY m.created_at;
$fn$;
GRANT EXECUTE ON FUNCTION public.teacher_thread(UUID) TO authenticated;

CREATE OR REPLACE FUNCTION public.teacher_reply(p_student UUID, p_body TEXT)
RETURNS UUID
LANGUAGE plpgsql SET search_path = public
AS $fn$
DECLARE new_id UUID;
BEGIN
  IF coalesce(btrim(p_body), '') = '' THEN
    RAISE EXCEPTION 'empty message';
  END IF;
  INSERT INTO messages (student_id, sender, body)
  VALUES (p_student, 'teacher', left(btrim(p_body), 4000))
  RETURNING id INTO new_id;
  UPDATE messages SET read_at = now()
  WHERE student_id = p_student AND sender = 'student' AND read_at IS NULL;
  RETURN new_id;
END;
$fn$;
GRANT EXECUTE ON FUNCTION public.teacher_reply(UUID, TEXT) TO authenticated;

-- Everybody's standing, in one table.
CREATE OR REPLACE FUNCTION public.teacher_class_performance()
RETURNS TABLE (student_id UUID, full_name TEXT, class_id UUID, class_name TEXT,
               practice_answered INTEGER, practice_correct INTEGER,
               checks_answered INTEGER, checks_missed INTEGER,
               checks_partly INTEGER, notes_opened INTEGER,
               last_active TIMESTAMPTZ, unread_from_student INTEGER)
LANGUAGE sql STABLE SET search_path = public
AS $fn$
  SELECT st.id, st.full_name, c.id, c.name,
         coalesce(pr.answered, 0), coalesce(pr.correct, 0),
         coalesce(ck.answered, 0), coalesce(ck.missed, 0), coalesce(ck.partly, 0),
         coalesce(ck.sections, 0),
         greatest(pr.last_at, ck.last_at),
         coalesce(ms.unread, 0)
  FROM classes c
  JOIN teachers t ON t.id = c.teacher_id AND t.auth_user_id = auth.uid()
  JOIN enrolments e ON e.class_id = c.id
                   AND e.status = 'active' AND e.deleted_at IS NULL
  JOIN students st ON st.id = e.student_id AND st.deleted_at IS NULL
  LEFT JOIN LATERAL (
    SELECT count(*)::int AS answered,
           count(*) FILTER (WHERE a.is_correct)::int AS correct,
           max(at.started_at) AS last_at
    FROM answers a JOIN attempts at ON at.id = a.attempt_id
    WHERE at.student_id = st.id) pr ON true
  LEFT JOIN LATERAL (
    SELECT count(*)::int AS answered,
           count(*) FILTER (WHERE self_report = 'missed')::int AS missed,
           count(*) FILTER (WHERE self_report = 'partly')::int AS partly,
           count(DISTINCT note_section_id)::int AS sections,
           max(answered_at) AS last_at
    FROM self_check_attempts WHERE student_id = st.id) ck ON true
  LEFT JOIN LATERAL (
    SELECT count(*)::int AS unread FROM messages
    WHERE student_id = st.id AND sender = 'student' AND read_at IS NULL) ms ON true
  WHERE c.deleted_at IS NULL
  ORDER BY c.name, st.full_name;
$fn$;
GRANT EXECUTE ON FUNCTION public.teacher_class_performance() TO authenticated;

-- Which questions a class as a whole is finding hard. This is the one that
-- tells the teacher what to go back over in front of everybody, rather than
-- one student at a time.
CREATE OR REPLACE FUNCTION public.teacher_check_hotspots()
RETURNS TABLE (note_section_id UUID, note_title TEXT, chapter_number TEXT,
               question_index INTEGER, question_text TEXT,
               answered INTEGER, missed INTEGER, partly INTEGER)
LANGUAGE sql STABLE SET search_path = public
AS $fn$
  SELECT s.id, s.title, s.chapter_number, a.question_index,
         max(a.question_text),
         count(*)::int,
         count(*) FILTER (WHERE a.self_report = 'missed')::int,
         count(*) FILTER (WHERE a.self_report = 'partly')::int
  FROM self_check_attempts a
  JOIN note_sections s ON s.id = a.note_section_id
  WHERE a.student_id IN (
    SELECT e.student_id FROM classes c
    JOIN teachers t ON t.id = c.teacher_id AND t.auth_user_id = auth.uid()
    JOIN enrolments e ON e.class_id = c.id
                     AND e.status = 'active' AND e.deleted_at IS NULL
    WHERE c.deleted_at IS NULL)
  GROUP BY s.id, s.title, s.chapter_number, a.question_index
  HAVING count(*) FILTER (WHERE a.self_report <> 'got_it') > 0
  ORDER BY count(*) FILTER (WHERE a.self_report = 'missed') DESC,
           count(*) DESC;
$fn$;
GRANT EXECUTE ON FUNCTION public.teacher_check_hotspots() TO authenticated;

COMMIT;


-- ==================================================================
-- Stage the First Term notes
--
-- Only the two sources written for the 2026/2027 sheets. Everything already
-- in front of a class stays open, so running this file changes nothing a
-- student can see today. The new notes wait until they are released on
-- Admin, Release notes.
-- ==================================================================

UPDATE note_sources SET release_mode = 'staged'
WHERE id IN ('947e8ce4-cb63-5847-98b1-d4cc5cf2f67f',
             '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec');

SELECT title, release_mode,
       (SELECT count(*) FROM note_sections s
         WHERE s.note_source_id = note_sources.id AND s.deleted_at IS NULL)::text
         AS sections
FROM note_sources ORDER BY sequence, title;
