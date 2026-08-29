import { createClient, getUser } from "../../../lib/supabase-server";
import { createClass } from "./actions";

export const metadata = { title: "Classes" };

export const dynamic = "force-dynamic";

export default async function ClassesPage() {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const user = await getUser();
  const { data: teacher } = await supabase
    .from("teachers")
    .select("id")
    .eq("auth_user_id", user?.id ?? "")
    .maybeSingle();

  if (!teacher) {
    return (
      <div className="notice bad">
        <h3>Account not linked</h3>
        <p>
          Go back to <a href="/admin">Admin</a> for the fix.
        </p>
      </div>
    );
  }

  const [{ data: classes }, { data: syllabi }] = await Promise.all([
    supabase
      .from("classes")
      .select("id, name, form_level, academic_year, exam_year, syllabus_id")
      .eq("teacher_id", teacher.id)
      .order("academic_year", { ascending: false }),
    supabase.from("syllabi").select("id, form_level, title").order("form_level"),
  ]);

  // Progress per class, so the list is useful at a glance rather than
  // being a set of names you have to click through.
  const progress = await Promise.all(
    (classes ?? []).map(async (c) => {
      const [{ count: totalContent }, { count: taught }] = await Promise.all([
        supabase
          .from("lessons")
          .select("id", { count: "exact", head: true })
          .eq("syllabus_id", c.syllabus_id)
          .eq("lesson_kind", "content"),
        supabase
          .from("scheme_entries")
          .select("id", { count: "exact", head: true })
          .eq("class_id", c.id)
          .eq("status", "taught"),
      ]);
      return { total: totalContent ?? 0, taught: taught ?? 0 };
    })
  );

  const thisYear = new Date().getFullYear();
  const defaultAcademic = `${thisYear}/${thisYear + 1}`;

  return (
    <>
      <h2>Classes</h2>
      <p className="lede">
        A class is one teaching group for one academic year. Progress is tracked
        against the progression sheet you attach to it.
      </p>

      {(classes ?? []).map((c, i) => (
        <a className="card" key={c.id} href={`/admin/classes/${c.id}`}>
          <h3>{c.name}</h3>
          <div className="meta">
            {c.form_level} · {c.academic_year}
            {c.exam_year ? ` · sits GCE ${c.exam_year}` : " · no GCE this year"}
          </div>
          <div className="tags">
            <span className={progress[i].taught > 0 ? "tag" : "tag plain"}>
              {progress[i].taught} of {progress[i].total} lessons taught
            </span>
          </div>
        </a>
      ))}

      {(!classes || classes.length === 0) && (
        <div className="notice">
          <h3>No classes yet</h3>
          <p>Create one below to start using the term planner.</p>
        </div>
      )}

      <h3 style={{ marginTop: 34 }}>Add a class</h3>
      <form action={createClass} style={{ maxWidth: 420 }}>
        <label className="field">
          <span>Class name</span>
          <input type="text" name="name" placeholder="Form 5A" required />
        </label>

        <label className="field">
          <span>Progression sheet</span>
          <select
            name="syllabus_id"
            required
            style={{
              width: "100%",
              padding: "10px 12px",
              fontSize: "1rem",
              borderRadius: 8,
              border: "1px solid var(--line)",
              background: "var(--surface)",
              color: "var(--ink)",
            }}
          >
            {(syllabi ?? []).map((s) => (
              <option key={s.id} value={s.id}>
                {s.form_level}
              </option>
            ))}
          </select>
        </label>

        <label className="field">
          <span>Academic year</span>
          <input
            type="text"
            name="academic_year"
            defaultValue={defaultAcademic}
            required
          />
        </label>

        <label className="field">
          <span>GCE exam year — leave empty for Form 4 and Lower Sixth</span>
          <input type="text" name="exam_year" placeholder={String(thisYear + 1)} />
        </label>

        <button className="primary" type="submit">
          Create class
        </button>
      </form>

      <p className="lede" style={{ marginTop: 26 }}>
        <a href="/admin">Back to admin</a>
      </p>
    </>
  );
}
