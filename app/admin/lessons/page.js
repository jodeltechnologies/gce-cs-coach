import Link from "next/link";
import { createClient } from "../../../lib/supabase-server";
import {
  currentWeek,
  formatRange,
  weekByNumber,
} from "../../../lib/school-calendar";

export const metadata = { title: "Lesson notes" };

export const dynamic = "force-dynamic";

export default async function LessonsPage({ searchParams }) {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  // Which calendar week we are actually in, so the row for it stands out.
  const thisWeek = currentWeek();

  const sp = await searchParams;
  const filter = sp?.filter ?? "gaps";

  const { data: syllabi } = await supabase
    .from("syllabi")
    .select("id, form_level")
    .order("form_level");

  const selected = sp?.syllabus ?? syllabi?.find((s) => s.form_level === "Form 5")?.id;

  const { data: lessons } = await supabase
    .from("lessons")
    .select(
      "id, sequence, lesson_no_start, lesson_no_end, title, term, week_from, lesson_kind, status, content, competency_id"
    )
    .eq("syllabus_id", selected ?? "")
    .eq("lesson_kind", "content")
    .order("sequence");

  const { data: competencies } = await supabase
    .from("competencies")
    .select("id, category_of_action, sequence")
    .eq("syllabus_id", selected ?? "")
    .order("sequence");

  const catById = new Map((competencies ?? []).map((c) => [c.id, c]));

  const hasContent = (l) => (l.content ?? "").trim().length > 0;
  const all = lessons ?? [];
  const missing = all.filter((l) => !hasContent(l));
  const written = all.filter(hasContent);
  const published = written.filter((l) => l.status === "published");

  const shown = filter === "all" ? all : filter === "written" ? written : missing;

  // Group the visible lessons by their category of action, so a gap reads as
  // "this whole competency is empty" rather than a scattering of rows.
  const groups = [];
  for (const l of shown) {
    const cat = catById.get(l.competency_id);
    const key = cat?.id ?? "none";
    let g = groups[groups.length - 1];
    if (!g || g.key !== key) {
      g = { key, title: cat?.category_of_action ?? "Uncategorised", items: [] };
      groups.push(g);
    }
    g.items.push(l);
  }

  return (
    <>
      <h2>Lesson notes</h2>
      <p className="lede">
        Every content lesson on the sheet. Anything without notes is a lesson
        you will reach one week and have nothing prepared for.
      </p>

      <div style={{ display: "flex", gap: 8, flexWrap: "wrap", marginBottom: 14 }}>
        {(syllabi ?? []).map((s) => (
          <Link
            key={s.id}
            href={`/admin/lessons?syllabus=${s.id}&filter=${filter}`}
            className={s.id === selected ? "tag" : "tag plain"}
            style={{ padding: "6px 14px", fontSize: "0.82rem" }}
          >
            {s.form_level}
          </Link>
        ))}
      </div>

      <div className="tags" style={{ marginBottom: 20 }}>
        <Link
          href={`/admin/lessons?syllabus=${selected}&filter=gaps`}
          className={filter === "gaps" ? "tag alert" : "tag plain"}
          style={{ padding: "5px 12px" }}
        >
          {missing.length} with no notes
        </Link>
        <Link
          href={`/admin/lessons?syllabus=${selected}&filter=written`}
          className={filter === "written" ? "tag" : "tag plain"}
          style={{ padding: "5px 12px" }}
        >
          {written.length} written
        </Link>
        <Link
          href={`/admin/lessons?syllabus=${selected}&filter=all`}
          className={filter === "all" ? "tag gold" : "tag plain"}
          style={{ padding: "5px 12px" }}
        >
          all {all.length}
        </Link>
        <span className="tag plain">{published.length} published to students</span>
      </div>

      {shown.length === 0 && (
        <div className="notice">
          <h3>Nothing here</h3>
          <p>
            {filter === "gaps"
              ? "Every content lesson on this sheet has notes. That is a real achievement."
              : "No lessons match this filter yet."}
          </p>
        </div>
      )}

      {groups.map((g) => (
        <section className="term" key={g.key}>
          <div className="term-head">{g.title}</div>
          {g.items.map((l) => {
            const num =
              l.lesson_no_start == null
                ? ""
                : l.lesson_no_end && l.lesson_no_end !== l.lesson_no_start
                  ? `${l.lesson_no_start}–${l.lesson_no_end}`
                  : String(l.lesson_no_start);
            return (
              <Link className="row" key={l.id} href={`/admin/lessons/${l.id}`} style={{ display: "block", color: "inherit" }}>
                <div className="name">
                  <span style={{ color: "var(--muted)", fontSize: "0.8rem", marginRight: 8 }}>
                    {num}
                  </span>
                  {l.title}
                </div>
                <div className="tags" style={{ marginTop: 6 }}>
                  <span className="tag plain">
                    Term {l.term}, week {l.week_from}
                  </span>
                  {weekByNumber(l.week_from) && (
                    <span
                      className={
                        thisWeek?.week === l.week_from ? "tag alert" : "tag plain"
                      }
                    >
                      {formatRange(
                        weekByNumber(l.week_from).start,
                        weekByNumber(l.week_from).end
                      )}
                    </span>
                  )}
                  {!hasContent(l) ? (
                    <span className="tag alert">No notes</span>
                  ) : l.status === "published" ? (
                    <span className="tag">Published</span>
                  ) : (
                    <span className="tag gold">Draft</span>
                  )}
                </div>
              </Link>
            );
          })}
        </section>
      ))}

      <p className="lede" style={{ marginTop: 26 }}>
        <Link href="/admin">Back to admin</Link>
      </p>
    </>
  );
}
