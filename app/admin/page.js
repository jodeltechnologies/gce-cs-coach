import { createClient, getUser } from "../../lib/supabase-server";
import { signOut } from "./signout";

export const dynamic = "force-dynamic";

export default async function AdminHome() {
  const supabase = await createClient();
  const user = await getUser();

  if (!supabase) {
    return (
      <div className="notice">
        <h3>Not configured</h3>
        <p>Add the Supabase environment variables in Vercel and redeploy.</p>
      </div>
    );
  }

  const { data: teacher } = await supabase
    .from("teachers")
    .select("full_name, grade")
    .eq("auth_user_id", user?.id ?? "")
    .maybeSingle();

  // Signed in with Supabase but no teachers row: the account exists and the
  // curriculum is readable, but nothing can be written. Say so plainly rather
  // than showing an empty page and letting saves fail silently.
  if (!teacher) {
    return (
      <>
        <h2>Account not linked</h2>
        <div className="notice bad">
          <h3>You are signed in, but not registered as a teacher</h3>
          <p>
            Your login exists, but there is no matching row in the{" "}
            <code>teachers</code> table, so the database will refuse every save.
          </p>
          <p>
            Run the <code>INSERT INTO teachers</code> statement at the bottom of{" "}
            <code>db/auth.sql</code> with your email, then reload this page.
          </p>
        </div>
        <form action={signOut}>
          <button className="link" type="submit">Sign out</button>
        </form>
      </>
    );
  }

  const { data: competencies } = await supabase
    .from("competencies")
    .select("id, exam_frequency, continues_from_id, link_confirmed, syllabus_id");

  const total = competencies?.length ?? 0;
  const withFreq = (competencies ?? []).filter((c) => c.exam_frequency).length;
  const pendingLinks = (competencies ?? []).filter(
    (c) => c.continues_from_id && !c.link_confirmed
  ).length;

  return (
    <>
      <h2>Admin</h2>
      <p className="lede">
        Signed in as {teacher.full_name}
        {teacher.grade ? `, ${teacher.grade}` : ""}.
      </p>

      <a className="card" href="/admin/exam-frequency">
        <h3>Exam frequency</h3>
        <div className="meta">
          How often each category of action appears in the GCE. This is what
          lets the system tell a student what to revise first.
        </div>
        <div className="tags">
          <span className={withFreq === total ? "tag" : "tag gold"}>
            {withFreq} of {total} set
          </span>
          {withFreq < total && (
            <span className="tag plain">{total - withFreq} still empty</span>
          )}
        </div>
      </a>

      <a className="card" href="/admin/links">
        <h3>Cross-year links</h3>
        <div className="meta">
          Confirm which Form 5 categories continue a Form 4 category, so a
          student&apos;s weak areas carry forward from last year.
        </div>
        <div className="tags">
          {pendingLinks > 0 ? (
            <span className="tag gold">{pendingLinks} awaiting your decision</span>
          ) : (
            <span className="tag">All decided</span>
          )}
        </div>
      </a>

      <h3 style={{ marginTop: 34 }}>Not built yet</h3>
      <p className="lede">
        Students, question bank, marking and the term planner. The term planner
        is next — it needs nothing that is not already in the database.
      </p>

      <form action={signOut} style={{ marginTop: 24 }}>
        <button className="link" type="submit">Sign out</button>
      </form>
    </>
  );
}
