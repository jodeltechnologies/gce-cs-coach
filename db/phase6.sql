-- =====================================================================
-- Phase 6 — letting students in
--
-- Run after phase5.sql. Safe to run more than once.
--
-- Students here mostly have no email address and often share a phone, so the
-- ordinary Supabase auth flow — sign up, confirm by email, reset by email —
-- does not fit. What the school already does is hand out a code on paper, so
-- that is what this uses: a six-character code the teacher reads off the
-- register, plus a PIN the student chooses the first time they sign in.
--
-- The code alone is not enough on its own. It gets written on a board, copied
-- by a friend, left on a desk. So the code identifies the student and the PIN
-- proves it is them, and a student who has not set a PIN yet is asked to set
-- one before anything personal is shown.
--
-- Row Level Security stays shut for students. Rather than opening tables to
-- anonymous readers, everything a student needs comes through the SECURITY
-- DEFINER functions below, which return exactly the columns a student may see
-- and nothing else. In particular question_options.is_correct never crosses
-- the wire while a question is unanswered — otherwise the answers are in the
-- page source and the practice is worthless.
-- =====================================================================

-- pgcrypto supplies crypt() and gen_salt(). On Supabase it is installed into
-- the "extensions" schema, not "public". Any function below that hashes a PIN
-- must therefore have extensions on its search_path, or it fails at run time
-- with "function gen_salt(unknown) does not exist" — which is a deployment
-- problem that only shows up when the first student tries to sign in.
CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- ---------------------------------------------------------------------
-- PART 1 — Columns for the student side of the login
-- ---------------------------------------------------------------------

ALTER TABLE students
  ADD COLUMN IF NOT EXISTS pin_hash      TEXT,
  ADD COLUMN IF NOT EXISTS pin_set_at    TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS last_login_at TIMESTAMPTZ,
  -- Wrong-PIN attempts, so a code found on a desk cannot be brute forced.
  -- Four digits is 10,000 combinations, which is minutes of guessing without
  -- a limit.
  ADD COLUMN IF NOT EXISTS failed_logins INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS locked_until  TIMESTAMPTZ;

COMMENT ON COLUMN students.pin_hash IS
  'bcrypt hash of the student PIN. Never the PIN itself: a teacher with '
  'database access has no business being able to read it, and a leaked '
  'backup should not hand over every account.';


-- ---------------------------------------------------------------------
-- PART 2 — Signing in
--
-- Returns one row on success and no rows on failure. It deliberately does not
-- say which half was wrong: telling an attacker that a code is valid but the
-- PIN is not is telling them where to keep trying.
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_sign_in(p_code TEXT, p_pin TEXT)
RETURNS TABLE (student_id UUID, full_name TEXT, needs_pin BOOLEAN)
LANGUAGE plpgsql
SECURITY DEFINER
-- extensions is on the path for crypt(); see the note at the top of this file
SET search_path = public, extensions
AS $$
DECLARE
  s students%ROWTYPE;
BEGIN
  SELECT * INTO s FROM students
   WHERE upper(login_code) = upper(trim(p_code))
     AND deleted_at IS NULL;

  IF NOT FOUND THEN
    RETURN;
  END IF;

  IF s.locked_until IS NOT NULL AND s.locked_until > now() THEN
    RETURN;
  END IF;

  -- No PIN yet: the code alone gets them as far as choosing one, and no
  -- further. student_set_pin is the only thing the caller can usefully do.
  IF s.pin_hash IS NULL THEN
    RETURN QUERY SELECT s.id, s.full_name, true;
    RETURN;
  END IF;

  IF s.pin_hash = crypt(p_pin, s.pin_hash) THEN
    UPDATE students
       SET last_login_at = now(), failed_logins = 0, locked_until = NULL
     WHERE id = s.id;
    RETURN QUERY SELECT s.id, s.full_name, false;
    RETURN;
  END IF;

  UPDATE students
     SET failed_logins = failed_logins + 1,
         locked_until = CASE WHEN failed_logins + 1 >= 5
                             THEN now() + interval '15 minutes' END
   WHERE id = s.id;
  RETURN;
END;
$$;


CREATE OR REPLACE FUNCTION public.student_set_pin(p_code TEXT, p_pin TEXT)
RETURNS TABLE (student_id UUID, full_name TEXT)
LANGUAGE plpgsql
SECURITY DEFINER
-- extensions is on the path for crypt() and gen_salt()
SET search_path = public, extensions
AS $$
DECLARE
  s students%ROWTYPE;
BEGIN
  IF p_pin !~ '^[0-9]{4,6}$' THEN
    RAISE EXCEPTION 'PIN must be 4 to 6 digits';
  END IF;

  SELECT * INTO s FROM students
   WHERE upper(login_code) = upper(trim(p_code))
     AND deleted_at IS NULL;

  -- Only settable while no PIN exists. Changing a PIN you already have needs
  -- the old one, and a forgotten PIN is cleared by the teacher, who can
  -- confirm in person who is asking.
  IF NOT FOUND OR s.pin_hash IS NOT NULL THEN
    RETURN;
  END IF;

  UPDATE students
     SET pin_hash = crypt(p_pin, gen_salt('bf')),
         pin_set_at = now(),
         last_login_at = now()
   WHERE id = s.id;

  RETURN QUERY SELECT s.id, s.full_name;
END;
$$;


-- ---------------------------------------------------------------------
-- PART 3 — What a signed-in student may read
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.student_profile(p_student UUID)
RETURNS TABLE (full_name TEXT, class_name TEXT, form_level TEXT, syllabus_id UUID)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT st.full_name, c.name, c.form_level, sy.id
  FROM students st
  LEFT JOIN enrolments e ON e.student_id = st.id
                        AND e.status = 'active' AND e.deleted_at IS NULL
  LEFT JOIN classes c ON c.id = e.class_id AND c.deleted_at IS NULL
  LEFT JOIN syllabi sy ON sy.form_level = c.form_level AND sy.deleted_at IS NULL
  WHERE st.id = p_student AND st.deleted_at IS NULL
  LIMIT 1;
$$;


CREATE OR REPLACE FUNCTION public.student_notes()
RETURNS TABLE (id UUID, chapter_number TEXT, title TEXT, body TEXT,
               source_title TEXT, page_from INT, page_to INT)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT s.id, s.chapter_number, s.title, s.body, src.title, s.page_from, s.page_to
  FROM note_sections s
  JOIN note_sources src ON src.id = s.note_source_id
  WHERE s.deleted_at IS NULL
  ORDER BY s.sequence;
$$;


-- Practice questions, with the answer withheld.
--
-- Only questions a teacher has checked are offered. An unreviewed question
-- may have been read wrongly by OCR or have no printed answer at all, and
-- telling a student they are wrong on the strength of that is worse than not
-- asking them.
-- Dropped first so this file can be re-run after phase7.sql, which changes
-- what this function returns. CREATE OR REPLACE cannot change a return
-- type, so replacing without dropping fails with 42P13.
DROP FUNCTION IF EXISTS public.student_practice(UUID, INT);

CREATE FUNCTION public.student_practice(p_syllabus UUID, p_limit INT DEFAULT 10)
RETURNS TABLE (question_id UUID, question_text TEXT, marks NUMERIC,
               figure_name TEXT, lesson_title TEXT,
               options JSONB)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT q.id, q.question_text, q.marks, q.figure_name,
         (SELECT l.title FROM question_lessons ql
            JOIN lessons l ON l.id = ql.lesson_id
           WHERE ql.question_id = q.id
           ORDER BY ql.is_primary DESC LIMIT 1),
         (SELECT jsonb_agg(jsonb_build_object('label', o.label, 'text', o.option_text)
                           ORDER BY o.sequence)
            FROM question_options o WHERE o.question_id = q.id)
  FROM questions q
  WHERE q.syllabus_id = p_syllabus
    AND q.deleted_at IS NULL
    AND q.question_type = 'mcq'
    AND q.auto_markable
    AND NOT q.needs_review
  ORDER BY random()
  LIMIT greatest(least(p_limit, 40), 1);
$$;


-- Marking happens here, not in the browser, because anything sent to the
-- browser can be read by the student.
-- Dropped first so this file can be re-run after phase7.sql, which changes
-- what this function returns. CREATE OR REPLACE cannot change a return
-- type, so replacing without dropping fails with 42P13.
DROP FUNCTION IF EXISTS public.student_check(UUID, TEXT);

CREATE FUNCTION public.student_check(p_question UUID, p_label TEXT)
RETURNS TABLE (correct BOOLEAN, correct_label TEXT, explanation TEXT)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT (o.label = p_label), o.label, q.marking_guide
  FROM question_options o
  JOIN questions q ON q.id = o.question_id
  WHERE o.question_id = p_question AND o.is_correct
    AND q.deleted_at IS NULL AND q.auto_markable AND NOT q.needs_review
  LIMIT 1;
$$;


-- ---------------------------------------------------------------------
-- PART 4 — Grants
--
-- anon may sign in and set a first PIN. Everything else needs a student id,
-- which only the server holds, in a signed cookie the browser cannot forge.
-- ---------------------------------------------------------------------

REVOKE ALL ON FUNCTION public.student_sign_in(TEXT, TEXT) FROM public;
REVOKE ALL ON FUNCTION public.student_set_pin(TEXT, TEXT) FROM public;
REVOKE ALL ON FUNCTION public.student_profile(UUID) FROM public;
REVOKE ALL ON FUNCTION public.student_notes() FROM public;
REVOKE ALL ON FUNCTION public.student_practice(UUID, INT) FROM public;
REVOKE ALL ON FUNCTION public.student_check(UUID, TEXT) FROM public;

GRANT EXECUTE ON FUNCTION public.student_sign_in(TEXT, TEXT) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_set_pin(TEXT, TEXT) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_profile(UUID) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_notes() TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_practice(UUID, INT) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.student_check(UUID, TEXT) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- PART 5 — Teacher clears a forgotten PIN
-- ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.clear_student_pin(p_student UUID)
RETURNS void
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  UPDATE students
     SET pin_hash = NULL, pin_set_at = NULL,
         failed_logins = 0, locked_until = NULL
   WHERE id = p_student AND public.is_teacher();
$$;

REVOKE ALL ON FUNCTION public.clear_student_pin(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.clear_student_pin(UUID) TO authenticated;


-- ---------------------------------------------------------------------
-- PART 6 — Check
--
-- The hashing is exercised here rather than left to be discovered by the
-- first student who tries to sign in. If pgcrypto is not reachable from the
-- functions above, this raises now, while you are still looking at the SQL
-- editor, instead of showing a stranger an error about gen_salt.
-- ---------------------------------------------------------------------

DO $$
DECLARE
  h TEXT;
BEGIN
  SELECT extensions.crypt('1234', extensions.gen_salt('bf')) INTO h;
  IF h IS NULL OR extensions.crypt('1234', h) <> h THEN
    RAISE EXCEPTION 'pgcrypto is present but not hashing correctly.';
  END IF;
EXCEPTION WHEN undefined_function OR invalid_schema_name THEN
  BEGIN
    SELECT public.crypt('1234', public.gen_salt('bf')) INTO h;
    IF h IS NULL THEN
      RAISE EXCEPTION 'pgcrypto not usable';
    END IF;
    -- pgcrypto lives in public on this database, so the functions above need
    -- their search_path corrected to match.
    ALTER FUNCTION public.student_sign_in(TEXT, TEXT) SET search_path = public;
    ALTER FUNCTION public.student_set_pin(TEXT, TEXT) SET search_path = public;
    RAISE NOTICE 'pgcrypto found in public; function search_path adjusted.';
  EXCEPTION WHEN OTHERS THEN
    RAISE EXCEPTION
      'pgcrypto is not installed or not reachable. In the Supabase dashboard '
      'go to Database, Extensions, and enable pgcrypto, then run this file again.';
  END;
END $$;

SELECT
  (SELECT count(*) FROM students WHERE deleted_at IS NULL) AS students,
  (SELECT count(*) FROM students WHERE deleted_at IS NULL AND login_code IS NOT NULL) AS have_a_code,
  (SELECT count(*) FROM students WHERE deleted_at IS NULL AND pin_hash IS NOT NULL) AS have_set_a_pin,
  (SELECT count(*) FROM questions
    WHERE deleted_at IS NULL AND auto_markable AND NOT needs_review) AS practice_questions_available;
