import Link from "next/link";
import { createClient } from "../../../lib/supabase-server";

export const metadata = { title: "Course notes" };
export const dynamic = "force-dynamic";

export default async function NotesIndex() {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const { data: sections } = await supabase
    .from("note_sections")
    .select("id, chapter_number, title, page_from, page_to, body, body_format, note_sources(title, attribution, sequence)")
    .is("deleted_at", null)
    .order("sequence");

  const items = sections ?? [];
  const bySource = new Map();
  for (const s of items) {
    const key = s.note_sources?.title ?? "Notes";
    if (!bySource.has(key)) bySource.set(key, []);
    bySource.get(key).push(s);
  }

  return (
    <>
      <h2>Course notes</h2>
      <p className="lede">
        Your course notes, chapter by chapter, with every diagram kept as it
        appears in the booklets the class already uses.
      </p>

      {items.length === 0 && (
        <div className="notice">
          <h3>Nothing loaded</h3>
          <p>Run <code>db/seed/05_notes.sql</code> to load the chapters.</p>
        </div>
      )}

      {[...bySource.entries()].map(([source, list]) => (
        <div key={source} style={{ marginBottom: 26 }}>
          <h3 style={{ fontSize: "1rem", marginBottom: 4 }}>{source}</h3>
          <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: 0 }}>
            {list[0]?.note_sources?.attribution}
          </p>
          {list.map((s) => {
            const figures = (s.body?.match(/!\[/g) ?? []).length;
            return (
              <Link key={s.id} href={`/admin/notes/${s.id}`} className="row"
                    style={{ display: "block", textDecoration: "none" }}>
                <div className="name">
                  {s.chapter_number ? `${s.chapter_number}. ` : ""}{s.title}
                </div>
                <div className="tags" style={{ marginTop: 6 }}>
                  <span className="tag plain">pp. {s.page_from}–{s.page_to}</span>
                  {figures > 0 && (
                    <span className="tag">{figures} figures</span>
                  )}
                  <span className="tag plain">
                    about {Math.max(Math.round((s.body?.length ?? 0) / 1100), 1)} min read
                  </span>
                </div>
              </Link>
            );
          })}
        </div>
      ))}
    </>
  );
}
