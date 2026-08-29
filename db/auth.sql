-- =====================================================================
-- Teacher login and write access
--
-- Run this AFTER schema.sql and rls.sql.
--
-- Supabase has its own users table (auth.users) that handles passwords and
-- sessions. This file connects it to your teachers table, and grants write
-- access only to people who have a row there.
--
-- IMPORTANT, do this first:
--   Supabase dashboard -> Authentication -> Sign In / Providers
--   turn OFF "Allow new users to sign up".
--
-- Without that, anyone on the internet can create an account. The policies
-- below would still stop them writing anything, because they would have no
-- teachers row -- but there is no reason to let strangers create accounts on
-- a school system at all.
-- =====================================================================

ALTER TABLE teachers
  ADD COLUMN IF NOT EXISTS auth_user_id UUID UNIQUE REFERENCES auth.users(id);

-- Why a function instead of a subquery inside each policy:
-- teachers has RLS enabled, so a plain subquery against it from inside
-- another policy returns nothing and every check silently fails. SECURITY
-- DEFINER runs the check as the function owner, which bypasses that.
CREATE OR REPLACE FUNCTION public.is_teacher()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.teachers
    WHERE auth_user_id = auth.uid()
      AND deleted_at IS NULL
  );
$$;

REVOKE ALL ON FUNCTION public.is_teacher() FROM public;
GRANT EXECUTE ON FUNCTION public.is_teacher() TO authenticated;

-- A signed-in teacher can read their own row and nobody else's.
DROP POLICY IF EXISTS teacher_reads_self ON teachers;
CREATE POLICY teacher_reads_self ON teachers
  FOR SELECT TO authenticated
  USING (auth_user_id = auth.uid());

-- Teachers may edit the curriculum judgements: exam frequency, and the
-- cross-year links between categories of action. Reading stays public.
DROP POLICY IF EXISTS teacher_edits_competencies ON competencies;
CREATE POLICY teacher_edits_competencies ON competencies
  FOR UPDATE TO authenticated
  USING (public.is_teacher())
  WITH CHECK (public.is_teacher());

-- Teachers may read the record of corrections the loader made.
DROP POLICY IF EXISTS teacher_reads_load_log ON curriculum_load_log;
CREATE POLICY teacher_reads_load_log ON curriculum_load_log
  FOR SELECT TO authenticated
  USING (public.is_teacher());


-- =====================================================================
-- Creating your account
--
-- 1. Authentication -> Users -> Add user -> Create new user.
--    Use your real email and a strong password.
--    Tick "Auto Confirm User" so you can sign in immediately.
--
-- 2. Come back here and run this, with your own email and name:
-- =====================================================================

-- INSERT INTO teachers (full_name, email, password_hash, grade, auth_user_id)
-- SELECT 'YOUR FULL NAME',
--        'you@example.com',
--        'managed-by-supabase-auth',
--        'YOUR GRADE',
--        id
-- FROM auth.users
-- WHERE email = 'you@example.com';

-- Check it linked. Should return exactly one row:
-- SELECT t.full_name, t.email, u.email AS login_email
-- FROM teachers t JOIN auth.users u ON u.id = t.auth_user_id;

-- password_hash is filled with a placeholder on purpose. Supabase Auth holds
-- the real password; this system never sees or stores it. The column stays in
-- the schema for the student login codes, which are handled separately.
