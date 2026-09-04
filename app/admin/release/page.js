import Link from "next/link";
import { createClient, getUser } from "../../../lib/supabase-server";
import { setRelease } from "./actions";

export const metadata = { title: "Release notes" };
export const dynamic = "force-dynamic";

/**
 * Which notes a class can see.
 *
 * A source is either open, meaning everything in it is visible, or staged,
 * meaning nothing is visible until it is released here. Only staged sources
 * appear on this page, so turning this feature on did not hide the notes
 * students already had.
 */
export default async function ReleaseNotes({ searchParams }) {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const sp = await searchParams;

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
          Go back to <Link href="/admin">Admin</Link> for the fix.
        </p>
      </div>
    );
  }

  const { data: classData } = await supabase
    .from("classes")
    .select("id, name, form_level, syllabus_id, academic_year")
    .eq("teacher_id", teacher.id)
    .is("deleted_at", null)
    .order("name");
  const classes = classData ?? [];
  const classId = sp?.class || classes[0]?.id || "";
  const klass = classes.find((c) => c.id === classId);

  let sections = [];
  let released = new Set();
  if (klass) {
    const { data: secData } = await supabase
      .from("note_sections")
      .select("id, chapter_number, title, sequence, note_sources!inner(id, title, release_mode, syllabus_id)")
      .is("deleted_at", null)
      .eq("note_sources.release_mode", "staged")
      .order("sequence");

    sections = (secData ?? []).filter(
      (s) =>
        !s.note_sources?.syllabus_id ||
        s.note_sources.syllabus_id === klass.syllabus_id
    );

    const { data: relData } = await supabase
      .from("note_releases")
      .select("note_section_id")
      .eq("class_id", classId);
    released = new Set((relData ?? []).map((r) => r.note_section_id));
  }

  return (
    <>
      <h2>Release notes</h2>
      <p className="lede">
        Tick a note to let this class read it. Untick it to take it back. A
        student who has already answered the questions keeps their answers
        either way.
      </p>

      {classes.length === 0 && (
        <div className="notice">
          <p style={{ margin: 0 }}>You have no classes yet.</p>
        </div>
      )}

      {classes.length > 0 && (
        <form method="get" style={{ marginBottom: 22 }}>
          <label htmlFor="class" className="field-label">Class</label>
          <select id="class" name="class" defaultValue={classId}>
            {classes.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
                {c.form_level ? ` · ${c.form_level}` : ""}
              </option>
            ))}
          </select>
          <button className="btn ghost" type="submit" style={{ marginLeft: 10 }}>
            Show
          </button>
        </form>
      )}

      {klass && sections.length === 0 && (
        <div className="notice">
          <h3 style={{ marginTop: 0 }}>Nothing staged for this class</h3>
          <p style={{ margin: 0 }}>
            Every note source for {klass.name} is set to open, so the class can
            already read all of it. Only sources marked staged appear here.
          </p>
        </div>
      )}

      {klass && sections.length > 0 && (
        <form action={setRelease}>
          <input type="hidden" name="class_id" value={classId} />

          <p style={{ fontSize: "0.88rem", color: "var(--muted)" }}>
            {released.size} of {sections.length} released to {klass.name}.
          </p>

          <div style={{ display: "grid", gap: 2, margin: "16px 0 20px" }}>
            {sections.map((s) => (
              <label key={s.id} className="release-row">
                <input type="hidden" name="offered" value={s.id} />
                <input
                  type="checkbox"
                  name="release"
                  value={s.id}
                  defaultChecked={released.has(s.id)}
                />
                <span className="release-no">{s.chapter_number ?? ""}</span>
                <span className="release-title">{s.title}</span>
                <span className="release-src">{s.note_sources?.title}</span>
              </label>
            ))}
          </div>

          <button className="btn" type="submit">Save</button>
          <span style={{ marginLeft: 12, fontSize: "0.85rem", color: "var(--muted)" }}>
            Nothing changes for the class until you press this.
          </span>
        </form>
      )}
    </>
  );
}
