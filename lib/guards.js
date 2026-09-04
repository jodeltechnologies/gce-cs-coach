import { redirect } from "next/navigation";
import { createClient, getUser } from "./supabase-server";
import { getStudentSession } from "./student-session";

/**
 * Who is allowed to look at the progression sheet.
 *
 * The sheet is the teacher's planning document. It carries the whole year,
 * every objective and every assessment week, which is more than a student
 * needs and more than a passer-by should have. Students get the next ten
 * lessons on their own page instead.
 *
 * There are three layers between an anonymous visitor and this data, and each
 * one is there because the others can fail:
 *
 *   1. middleware.js turns the request away at the door. Cheap, and it means
 *      no page work happens at all.
 *   2. This function, called by the page itself. A route the middleware
 *      matcher forgets is still closed.
 *   3. Row level security in the database. If both of the above were deleted
 *      the anon key still reads nothing.
 *
 * Only the third is real protection. The first two are for tidiness and for
 * sending people somewhere useful.
 */
export async function requireTeacher() {
  // A signed-in student goes to their own page rather than being told no.
  // Being refused by a site you are legitimately signed into reads as a
  // fault, and the student will try again rather than go where they meant.
  let student = null;
  try {
    student = await getStudentSession();
  } catch {
    student = null;
  }
  if (student) redirect("/student/progress");

  const user = await getUser();
  if (!user) redirect("/login");

  const supabase = await createClient();
  if (!supabase) return { supabase: null, teacher: null };

  const { data: teacher } = await supabase
    .from("teachers")
    .select("id, full_name")
    .eq("auth_user_id", user.id)
    .maybeSingle();

  return { supabase, teacher, user };
}
