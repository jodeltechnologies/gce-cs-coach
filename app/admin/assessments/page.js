import Link from "next/link";
import { createClient, getUser } from "../../../lib/supabase-server";
import NewAssessment from "./NewAssessment";

export const metadata = { title: "Tests" };
export const dynamic = "force-dynamic";

export default async function Assessments() {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const user = await getUser();
  const { data: teacher } = await supabase
    .from("teachers").select("id").eq("auth_user_id", user?.id ?? "").maybeSingle();
  if (!teacher) {
    return (
      <div className="notice bad">
        <h3>Account not linked</h3>
        <p>
          Your sign-in is not linked to a teacher record. Run the
          INSERT INTO teachers step in db/auth.sql.
        </p>
      </div>
    );
  }

  const { data: classes } = await supabase
    .from("classes")
    .select("id, name, academic_year, form_level")
    .eq("teacher_id", teacher.id)
    .order("name");

  // Topics to draw from. Only lessons that actually have checked questions
  // behind them, so a teacher cannot set a test on a topic with nothing in it.
  const { data: topics } = await supabase
    .from("question_lessons")
    .select("lesson_id, is_primary, lessons!inner(id, title, syllabus_id), questions!inner(needs_review, auto_markable, deleted_at)")
    .eq("is_primary", true)
    .eq("questions.needs_review", false)
    .eq("questions.auto_markable", true)
    .is("questions.deleted_at", null);

  const counts = new Map();
  for (const r of topics ?? []) {
    const t = r.lessons?.title;
    if (!t) continue;
    counts.set(t, { id: r.lesson_id, title: t, n: (counts.get(t)?.n ?? 0) + 1 });
  }
  const lessons = [...counts.values()].sort((a, b) => a.title.localeCompare(b.title));

  const { data: assessments } = await supabase
    .from("assessments")
    .select("id, title, kind, total_marks, opens_at, closes_at, class_id, classes(name)")
    .is("deleted_at", null)
    .order("created_at", { ascending: false })
    .limit(30);

  const now = Date.now();

  return (
    <>
      <h2>Tests</h2>
      <p className="lede">
        A test you set, for one class, from questions you choose. Unlike
        practice, everyone sits the same paper, so the results can be compared.
      </p>

      {(assessments ?? []).length === 0 && (
        <div className="notice">
          <h3>No tests yet</h3>
          <p style={{ marginBottom: 0 }}>
            Set one below. It draws from the questions you have already checked.
          </p>
        </div>
      )}

      {(assessments ?? []).map((a) => {
        const open = (!a.opens_at || new Date(a.opens_at).getTime() <= now)
          && (!a.closes_at || new Date(a.closes_at).getTime() > now);
        return (
          <Link key={a.id} href={`/admin/assessments/${a.id}`} className="row"
                style={{ display: "block", textDecoration: "none" }}>
            <div className="name">{a.title}</div>
            <div className="tags" style={{ marginTop: 6 }}>
              <span className="tag plain">{a.classes?.name ?? "class"}</span>
              <span className="tag plain">{a.kind.replace("_", " ")}</span>
              {a.total_marks ? <span className="tag plain">{a.total_marks} marks</span> : null}
              <span className={open ? "tag" : "tag plain"}>
                {open ? "Open" : "Closed"}
              </span>
              {a.closes_at && (
                <span className="tag plain">
                  {open ? "closes " : "closed "}
                  {new Date(a.closes_at).toLocaleDateString()}
                </span>
              )}
            </div>
          </Link>
        );
      })}

      <h3 style={{ marginTop: 34 }}>Set a new test</h3>
      <NewAssessment classes={classes ?? []} lessons={lessons} />
    </>
  );
}
