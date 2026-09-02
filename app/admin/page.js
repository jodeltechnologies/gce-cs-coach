import Link from "next/link";
import { createClient, getUser } from "../../lib/supabase-server";
import { signOut } from "./signout";

export const metadata = { title: "Admin" };

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
    .select("id, full_name, grade")
    .eq("auth_user_id", user?.id ?? "")
    .maybeSingle();

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

  const [{ data: competencies }, { data: classes }, { data: contentLessons },
         { count: studentCount }, { count: questionCount }] = await Promise.all([
    supabase
      .from("competencies")
      .select("id, exam_frequency, continues_from_id, link_confirmed")
      .is("deleted_at", null),
    supabase
      .from("classes")
      .select("id, name, academic_year")
      .eq("teacher_id", teacher.id),
    supabase
      .from("lessons")
      .select("id, content, status")
      .is("deleted_at", null)
      .eq("lesson_kind", "content"),
    supabase
      .from("students")
      .select("id", { count: "exact", head: true })
      .is("deleted_at", null),
    supabase
      .from("questions")
      .select("id", { count: "exact", head: true })
      .is("deleted_at", null),
  ]);

  const lessonsTotal = contentLessons?.length ?? 0;
  const withNotes = (contentLessons ?? []).filter(
    (l) => (l.content ?? "").trim().length > 0
  ).length;
  const publishedLessons = (contentLessons ?? []).filter(
    (l) => l.status === "published"
  ).length;

  const total = competencies?.length ?? 0;
  const withFreq = (competencies ?? []).filter((c) => c.exam_frequency).length;

  // Distinguish "nothing to decide" from "no links exist at all". The first
  // version treated both as All decided, which reported success when the
  // links had simply never loaded.
  const linked = (competencies ?? []).filter((c) => c.continues_from_id);
  const pendingLinks = linked.filter((c) => !c.link_confirmed).length;
  const noLinksLoaded = linked.length === 0;

  return (
    <>
      <h2>Admin</h2>
      <p className="lede">
        Signed in as {teacher.full_name}
        {teacher.grade ? `, ${teacher.grade}` : ""}.
      </p>

      <Link className="card" href="/admin/exam-frequency">
        <h3>Exam frequency</h3>
        <div className="meta">
          How often each category of action appears in the GCE. This is what
          lets the system tell a student what to revise first.
        </div>
        <div className="tags">
          <span className={withFreq === total && total > 0 ? "tag" : "tag gold"}>
            {withFreq} of {total} set
          </span>
          {withFreq < total && (
            <span className="tag plain">{total - withFreq} still empty</span>
          )}
        </div>
      </Link>

      <Link className="card" href="/admin/classes">
        <h3>Classes and term planner</h3>
        <div className="meta">
          Track a class against its progression sheet: what is taught, how far
          behind you are, and how many weeks until the next Evaluation.
        </div>
        <div className="tags">
          {classes && classes.length > 0 ? (
            <span className="tag">
              {classes.length} {classes.length === 1 ? "class" : "classes"}
            </span>
          ) : (
            <span className="tag gold">No classes yet</span>
          )}
        </div>
      </Link>

      <Link className="card" href="/admin/lessons">
        <h3>Lesson notes and files</h3>
        <div className="meta">
          Write notes, attach scanned handouts and past papers, and publish them
          to students. Shows you which lessons have nothing prepared.
        </div>
        <div className="tags">
          <span className={withNotes === lessonsTotal && lessonsTotal > 0 ? "tag" : "tag alert"}>
            {lessonsTotal - withNotes} lessons with no notes
          </span>
          <span className="tag plain">{withNotes} of {lessonsTotal} written</span>
          <span className="tag plain">{publishedLessons} published</span>
        </div>
      </Link>

      <Link className="card" href="/admin/students">
        <h3>Students</h3>
        <div className="meta">
          The roll, enrolment into classes, and the short login codes you print
          and hand out.
        </div>
        <div className="tags">
          {studentCount > 0 ? (
            <span className="tag">{studentCount} on the roll</span>
          ) : (
            <span className="tag gold">Nobody yet</span>
          )}
        </div>
      </Link>

      <Link className="card" href="/admin/questions">
        <h3>Question bank</h3>
        <div className="meta">
          Past GCE papers, mocks and your own questions, each tagged to the
          lessons it tests.
        </div>
        <div className="tags">
          {questionCount > 0 ? (
            <span className="tag">{questionCount} questions</span>
          ) : (
            <span className="tag gold">Empty</span>
          )}
        </div>
      </Link>

      <Link className="card" href="/admin/links">
        <h3>Cross-year links</h3>
        <div className="meta">
          Confirm which Form 5 categories continue a Form 4 category, so a
          student&apos;s weak areas carry forward from last year.
        </div>
        <div className="tags">
          {noLinksLoaded ? (
            <span className="tag alert">None loaded — run db/phase2.sql</span>
          ) : pendingLinks > 0 ? (
            <span className="tag gold">{pendingLinks} awaiting your decision</span>
          ) : (
            <span className="tag">{linked.length} confirmed</span>
          )}
        </div>
      </Link>

      <h3 style={{ marginTop: 34 }}>Not built yet</h3>
      <p className="lede">
        Student sign-in, quizzes, marking, and the mastery engine. Students
        cannot log in yet — the codes are generated and stored, so nothing has
        to be redone when that is switched on.
      </p>

      <form action={signOut} style={{ marginTop: 24 }}>
        <button className="link" type="submit">Sign out</button>
      </form>
    </>
  );
}
