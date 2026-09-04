-- Phase 14
--
-- Two faults in phase 13, both mine.
--
-- 1. MESSAGES NEVER REACHED THE TEACHER.
--
--    Phase 13 turned row level security on for messages, self_check_attempts
--    and note_releases and then added no policies at all. The comment said
--    the anon key would reach none of them, which was true and was the point.
--    What it missed is that the teacher's own session is also subject to
--    those policies. With none written, the teacher could read nothing and
--    write nothing either.
--
--    So a student pressing Send did insert a row, through a SECURITY DEFINER
--    function that bypasses the policies, and the teacher's inbox then looked
--    in the same table through the ordinary path and was told there was
--    nothing there. No error anywhere. The message existed and was
--    unreachable.
--
--    Releasing notes was broken the same way, since the release page reads
--    and writes note_releases directly.
--
-- 2. NOTES STAYED VISIBLE.
--
--    Only the two sources written for 2026/2027 were staged. Every older
--    source kept release_mode 'open', so those chapters carried on showing.
--    That was deliberate, to avoid pulling notes away from a class mid-term,
--    but it is not what was wanted: the teacher should be able to hold back
--    any source. This adds the switch, and leaves the choice to the teacher
--    rather than making it here.
--
-- Safe to run twice. Run it after phase13.sql.

BEGIN;

-- ------------------------------------------------------------------
-- Who counts as mine
--
-- Both helpers are SECURITY DEFINER. A policy that has to read another
-- table to decide is itself subject to that table's policies, so without
-- this the check quietly returns nothing and every row is refused.
-- ------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.is_my_class(p_class UUID)
RETURNS boolean
LANGUAGE sql SECURITY DEFINER SET search_path = public STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM classes c
    JOIN teachers t ON t.id = c.teacher_id
    WHERE c.id = p_class
      AND c.deleted_at IS NULL
      AND t.auth_user_id = auth.uid()
      AND t.deleted_at IS NULL);
$$;
REVOKE ALL ON FUNCTION public.is_my_class(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.is_my_class(UUID) TO authenticated;

CREATE OR REPLACE FUNCTION public.is_my_student(p_student UUID)
RETURNS boolean
LANGUAGE sql SECURITY DEFINER SET search_path = public STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM enrolments e
    JOIN classes c ON c.id = e.class_id AND c.deleted_at IS NULL
    JOIN teachers t ON t.id = c.teacher_id
    WHERE e.student_id = p_student
      AND e.status = 'active' AND e.deleted_at IS NULL
      AND t.auth_user_id = auth.uid()
      AND t.deleted_at IS NULL);
$$;
REVOKE ALL ON FUNCTION public.is_my_student(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.is_my_student(UUID) TO authenticated;

-- ------------------------------------------------------------------
-- Policies
--
-- Only for the teacher. Students still never touch these tables directly:
-- everything they do goes through a SECURITY DEFINER function that takes
-- their id from a signed cookie the server checked first.
-- ------------------------------------------------------------------

DROP POLICY IF EXISTS teacher_reads_messages ON messages;
CREATE POLICY teacher_reads_messages ON messages
  FOR SELECT TO authenticated
  USING (public.is_my_student(student_id));

DROP POLICY IF EXISTS teacher_writes_messages ON messages;
CREATE POLICY teacher_writes_messages ON messages
  FOR INSERT TO authenticated
  WITH CHECK (sender = 'teacher' AND public.is_my_student(student_id));

-- Marking a student's message as read is the only update a teacher makes.
DROP POLICY IF EXISTS teacher_marks_messages_read ON messages;
CREATE POLICY teacher_marks_messages_read ON messages
  FOR UPDATE TO authenticated
  USING (public.is_my_student(student_id))
  WITH CHECK (public.is_my_student(student_id));

DROP POLICY IF EXISTS teacher_reads_self_checks ON self_check_attempts;
CREATE POLICY teacher_reads_self_checks ON self_check_attempts
  FOR SELECT TO authenticated
  USING (public.is_my_student(student_id));

DROP POLICY IF EXISTS teacher_reads_releases ON note_releases;
CREATE POLICY teacher_reads_releases ON note_releases
  FOR SELECT TO authenticated
  USING (public.is_my_class(class_id));

DROP POLICY IF EXISTS teacher_adds_releases ON note_releases;
CREATE POLICY teacher_adds_releases ON note_releases
  FOR INSERT TO authenticated
  WITH CHECK (public.is_my_class(class_id));

DROP POLICY IF EXISTS teacher_removes_releases ON note_releases;
CREATE POLICY teacher_removes_releases ON note_releases
  FOR DELETE TO authenticated
  USING (public.is_my_class(class_id));

-- An upsert needs UPDATE as well as INSERT, or the second save of the same
-- tick fails on the unique index instead of doing nothing.
DROP POLICY IF EXISTS teacher_updates_releases ON note_releases;
CREATE POLICY teacher_updates_releases ON note_releases
  FOR UPDATE TO authenticated
  USING (public.is_my_class(class_id))
  WITH CHECK (public.is_my_class(class_id));

-- Teachers change how a source is released. Reading note_sources is already
-- allowed; this adds the one column they may write.
DROP POLICY IF EXISTS teacher_stages_sources ON note_sources;
CREATE POLICY teacher_stages_sources ON note_sources
  FOR UPDATE TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());

COMMIT;


BEGIN;

-- ------------------------------------------------------------------
-- Staging any source, and releasing in bulk
-- ------------------------------------------------------------------

-- Every source with how much of it this class can currently see. This is
-- what the Release notes page lists.
CREATE OR REPLACE FUNCTION public.teacher_sources(p_class UUID)
RETURNS TABLE (id UUID, title TEXT, release_mode TEXT, sequence INTEGER,
               sections INTEGER, released INTEGER)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $fn$
  SELECT src.id, src.title, src.release_mode, src.sequence,
         count(s.id)::int,
         count(r.id)::int
  FROM note_sources src
  LEFT JOIN note_sections s ON s.note_source_id = src.id AND s.deleted_at IS NULL
  LEFT JOIN note_releases r ON r.note_section_id = s.id AND r.class_id = p_class
  WHERE src.deleted_at IS NULL
    AND public.is_my_class(p_class)
    AND (src.syllabus_id IS NULL
         OR src.syllabus_id = (SELECT syllabus_id FROM classes WHERE id = p_class))
  GROUP BY src.id, src.title, src.release_mode, src.sequence
  HAVING count(s.id) > 0
  ORDER BY src.sequence, src.title;
$fn$;
REVOKE ALL ON FUNCTION public.teacher_sources(UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.teacher_sources(UUID) TO authenticated;

-- Open a source to everybody, or hold it back until released.
CREATE OR REPLACE FUNCTION public.set_source_release_mode(
  p_source UUID, p_mode TEXT)
RETURNS VOID
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $fn$
BEGIN
  IF NOT public.is_teacher() THEN
    RAISE EXCEPTION 'not a teacher';
  END IF;
  IF p_mode NOT IN ('open', 'staged') THEN
    RAISE EXCEPTION 'unknown release mode %', p_mode;
  END IF;
  UPDATE note_sources SET release_mode = p_mode, updated_at = now()
  WHERE id = p_source;
END;
$fn$;
REVOKE ALL ON FUNCTION public.set_source_release_mode(UUID, TEXT) FROM public;
GRANT EXECUTE ON FUNCTION public.set_source_release_mode(UUID, TEXT) TO authenticated;

-- Release or withdraw a whole source in one go. Ticking forty boxes by hand
-- is how a teacher ends up leaving the whole thing open instead.
CREATE OR REPLACE FUNCTION public.release_whole_source(
  p_class UUID, p_source UUID, p_release BOOLEAN)
RETURNS INTEGER
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $fn$
DECLARE n INTEGER;
BEGIN
  IF NOT public.is_my_class(p_class) THEN
    RAISE EXCEPTION 'not your class';
  END IF;

  IF p_release THEN
    INSERT INTO note_releases (class_id, note_section_id, released_by)
    SELECT p_class, s.id,
           (SELECT id FROM teachers WHERE auth_user_id = auth.uid())
    FROM note_sections s
    WHERE s.note_source_id = p_source AND s.deleted_at IS NULL
    ON CONFLICT (class_id, note_section_id) DO NOTHING;
    GET DIAGNOSTICS n = ROW_COUNT;
  ELSE
    DELETE FROM note_releases r
    USING note_sections s
    WHERE r.note_section_id = s.id
      AND s.note_source_id = p_source
      AND r.class_id = p_class;
    GET DIAGNOSTICS n = ROW_COUNT;
  END IF;
  RETURN n;
END;
$fn$;
REVOKE ALL ON FUNCTION public.release_whole_source(UUID, UUID, BOOLEAN) FROM public;
GRANT EXECUTE ON FUNCTION public.release_whole_source(UUID, UUID, BOOLEAN)
  TO authenticated;

-- The sections of one source, with whether this class has them.
CREATE OR REPLACE FUNCTION public.teacher_source_sections(
  p_class UUID, p_source UUID)
RETURNS TABLE (id UUID, chapter_number TEXT, title TEXT, sequence INTEGER,
               released BOOLEAN)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $fn$
  SELECT s.id, s.chapter_number, s.title, s.sequence, (r.id IS NOT NULL)
  FROM note_sections s
  LEFT JOIN note_releases r ON r.note_section_id = s.id AND r.class_id = p_class
  WHERE s.note_source_id = p_source
    AND s.deleted_at IS NULL
    AND public.is_my_class(p_class)
  ORDER BY s.sequence;
$fn$;
REVOKE ALL ON FUNCTION public.teacher_source_sections(UUID, UUID) FROM public;
GRANT EXECUTE ON FUNCTION public.teacher_source_sections(UUID, UUID)
  TO authenticated;

-- Setting the ticks for one source in one call, so a save is one round trip
-- and cannot half-happen.
CREATE OR REPLACE FUNCTION public.set_releases(
  p_class UUID, p_offered UUID[], p_release UUID[])
RETURNS INTEGER
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $fn$
DECLARE n INTEGER;
BEGIN
  IF NOT public.is_my_class(p_class) THEN
    RAISE EXCEPTION 'not your class';
  END IF;

  DELETE FROM note_releases
  WHERE class_id = p_class
    AND note_section_id = ANY (p_offered)
    AND NOT (note_section_id = ANY (coalesce(p_release, '{}'::UUID[])));

  INSERT INTO note_releases (class_id, note_section_id, released_by)
  SELECT p_class, x,
         (SELECT id FROM teachers WHERE auth_user_id = auth.uid())
  FROM unnest(coalesce(p_release, '{}'::UUID[])) AS x
  ON CONFLICT (class_id, note_section_id) DO NOTHING;

  SELECT count(*)::int INTO n FROM note_releases WHERE class_id = p_class;
  RETURN n;
END;
$fn$;
REVOKE ALL ON FUNCTION public.set_releases(UUID, UUID[], UUID[]) FROM public;
GRANT EXECUTE ON FUNCTION public.set_releases(UUID, UUID[], UUID[]) TO authenticated;

COMMIT;


-- ==================================================================
-- Check it
--
-- Run these as yourself, signed in, from the SQL editor while logged into
-- the dashboard as the same account the app uses. The first should be true.
-- ==================================================================

SELECT 'am I a teacher' AS check, public.is_teacher()::text AS result
UNION ALL
SELECT 'messages I can see', count(*)::text FROM messages
UNION ALL
SELECT 'self checks I can see', count(*)::text FROM self_check_attempts
UNION ALL
SELECT 'releases I can see', count(*)::text FROM note_releases
UNION ALL
SELECT 'note sources', count(*)::text FROM note_sources WHERE deleted_at IS NULL
UNION ALL
SELECT 'sources held back', count(*)::text
  FROM note_sources WHERE release_mode = 'staged' AND deleted_at IS NULL;
