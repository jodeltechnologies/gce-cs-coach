import Link from "next/link";
import { createClient, getUser } from "../../../lib/supabase-server";
import { setMode, releaseAll, setRelease } from "./actions";

export const metadata = { title: "Release notes" };
export const dynamic = "force-dynamic";

/**
 * What a class is allowed to read.
 *
 * Every source is either open, meaning the class sees all of it, or held
 * back, meaning it sees only the chapters ticked here. Any source can be
 * either. The first version only offered this for the notes written this
 * year, which left the older booklets permanently visible and made the
 * feature look broken.
 */
export default async function ReleaseNotes({ searchParams }) {
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
        <p>Go back to <Link href="/admin">Admin</Link> for the fix.</p>
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

  const sp = await searchParams;
  const classId = sp?.class || classes[0]?.id || "";
  const klass = classes.find((c) => c.id === classId);
  const openSourceId = sp?.source || "";

  let sources = [];
  let sections = [];
  if (klass) {
    const { data } = await supabase.rpc("teacher_sources", { p_class: classId });
    sources = data ?? [];
    if (openSourceId) {
      const { data: secs } = await supabase.rpc("teacher_source_sections", {
        p_class: classId,
        p_source: openSourceId,
      });
      sections = secs ?? [];
    }
  }
  const openSource = sources.find((s) => s.id === openSourceId);

  return (
    <>
      <h2>Release notes</h2>
      <p className="lede">
        A source your class can see all of is <strong>open</strong>. One they
        see only part of is <strong>held back</strong>, and you decide which
        chapters. Taking a chapter back never deletes what a student has
        already written about it.
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
                {c.name}{c.form_level ? ` · ${c.form_level}` : ""}
              </option>
            ))}
          </select>
          <button className="btn ghost" type="submit" style={{ marginLeft: 10 }}>
            Show
          </button>
        </form>
      )}

      {klass && sources.length === 0 && (
        <div className="notice">
          <p style={{ margin: 0 }}>No notes exist for {klass.name} yet.</p>
        </div>
      )}

      {klass && sources.map((s) => {
        const staged = s.release_mode === "staged";
        const all = Number(s.sections);
        const out = Number(s.released);
        return (
          <div className="src-card" key={s.id}>
            <div className="src-head">
              <div>
                <div className="src-title">{s.title}</div>
                <div className="src-sub">
                  {all} {all === 1 ? "chapter" : "chapters"} ·{" "}
                  {staged ? (
                    <>
                      held back, <strong>{out} released</strong> to {klass.name}
                    </>
                  ) : (
                    <span style={{ color: "var(--red)" }}>
                      open, the class sees all {all}
                    </span>
                  )}
                </div>
              </div>
              <form action={setMode}>
                <input type="hidden" name="source_id" value={s.id} />
                <input type="hidden" name="mode" value={staged ? "open" : "staged"} />
                <button className="btn ghost small" type="submit">
                  {staged ? "Open to all" : "Hold back"}
                </button>
              </form>
            </div>

            {staged && (
              <div className="src-actions">
                <Link
                  className="link"
                  href={`/admin/release?class=${classId}&source=${s.id}`}
                >
                  {openSourceId === s.id ? "Hide chapters" : "Choose chapters"}
                </Link>
                <form action={releaseAll} style={{ display: "inline" }}>
                  <input type="hidden" name="class_id" value={classId} />
                  <input type="hidden" name="source_id" value={s.id} />
                  <input type="hidden" name="release" value="yes" />
                  <button className="btn ghost small" type="submit">Release all</button>
                </form>
                <form action={releaseAll} style={{ display: "inline" }}>
                  <input type="hidden" name="class_id" value={classId} />
                  <input type="hidden" name="source_id" value={s.id} />
                  <input type="hidden" name="release" value="no" />
                  <button className="btn ghost small" type="submit">Take all back</button>
                </form>
              </div>
            )}

            {openSourceId === s.id && sections.length > 0 && (
              <form action={setRelease} style={{ marginTop: 14 }}>
                <input type="hidden" name="class_id" value={classId} />
                <div style={{ display: "grid", gap: 2, marginBottom: 14 }}>
                  {sections.map((sec) => (
                    <label key={sec.id} className="release-row">
                      <input type="hidden" name="offered" value={sec.id} />
                      <input
                        type="checkbox"
                        name="release"
                        value={sec.id}
                        defaultChecked={sec.released}
                      />
                      <span className="release-no">{sec.chapter_number ?? ""}</span>
                      <span className="release-title">{sec.title}</span>
                      <span className="release-src">
                        {sec.released ? "released" : ""}
                      </span>
                    </label>
                  ))}
                </div>
                <button className="btn" type="submit">Save these chapters</button>
                <span style={{ marginLeft: 12, fontSize: "0.85rem", color: "var(--muted)" }}>
                  Nothing changes for the class until you press this.
                </span>
              </form>
            )}
          </div>
        );
      })}
    </>
  );
}
