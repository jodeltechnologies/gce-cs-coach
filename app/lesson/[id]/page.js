import Link from "next/link";
import { createClient } from "../../../lib/supabase-server";
import {
  formatRange,
  sittingsForWeek,
  weekByNumber,
} from "../../../lib/school-calendar";

export const metadata = { title: "Lesson" };
export const dynamic = "force-dynamic";

/**
 * Turn plain text or light Markdown into readable blocks.
 *
 * Deliberately small. A full Markdown library is another dependency and
 * another way for a build to fail, and notes pasted out of a PDF are mostly
 * paragraphs, headings and bullets. This covers those and leaves everything
 * else alone.
 */
function render(text) {
  const blocks = text.replace(/\r\n/g, "\n").split(/\n{2,}/);
  return blocks.map((block, i) => {
    const lines = block.split("\n").filter((l) => l.trim());
    if (lines.length === 0) return null;

    const heading = lines[0].match(/^(#{1,4})\s+(.*)$/);
    if (heading && lines.length === 1) {
      const level = Math.min(heading[1].length + 1, 4);
      const Tag = `h${level}`;
      return <Tag key={i}>{heading[2]}</Tag>;
    }

    const bulleted = lines.every((l) => /^\s*([-*•]|\d+[.)])\s+/.test(l));
    if (bulleted && lines.length > 1) {
      const numbered = /^\s*\d+[.)]\s+/.test(lines[0]);
      const items = lines.map((l, j) => (
        <li key={j}>{l.replace(/^\s*([-*•]|\d+[.)])\s+/, "")}</li>
      ));
      return numbered ? <ol key={i}>{items}</ol> : <ul key={i}>{items}</ul>;
    }

    // A short line on its own that is not a sentence reads as a heading.
    if (lines.length === 1 && lines[0].length < 70 && !/[.!?]$/.test(lines[0])) {
      return <h3 key={i}>{lines[0]}</h3>;
    }

    return <p key={i}>{lines.join(" ")}</p>;
  });
}

export default async function LessonReader({ params }) {
  const { id } = await params;
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const { data: lesson } = await supabase
    .from("lessons")
    .select(
      "id, lesson_no_start, lesson_no_end, title, term, week_from, status, content, duration_minutes, competency_id, syllabus_id"
    )
    .is("deleted_at", null)
    .eq("id", id)
    .maybeSingle();

  if (!lesson || lesson.status !== "published") {
    return (
      <>
        <h2>Not available</h2>
        <p className="lede">
          This lesson has not been published yet.{" "}
          <Link href="/">Back to the progression sheets</Link>.
        </p>
      </>
    );
  }

  const [{ data: objectives }, { data: resources }, { data: category }, { data: syllabus }] =
    await Promise.all([
      supabase
        .from("objectives")
        .select("description, sequence")
        .eq("lesson_id", id)
        .is("deleted_at", null)
        .order("sequence"),
      supabase
        .from("lesson_resources")
        .select("id, kind, url, caption, size_bytes")
        .eq("lesson_id", id)
        .is("deleted_at", null),
      lesson.competency_id
        ? supabase
            .from("competencies")
            .select("category_of_action")
            .is("deleted_at", null)
            .eq("id", lesson.competency_id)
            .maybeSingle()
        : Promise.resolve({ data: null }),
      supabase
        .from("syllabi")
        .select("id, form_level")
        .eq("id", lesson.syllabus_id)
        .maybeSingle(),
    ]);

  // The week this lesson falls in, and when this class actually sits in it.
  // The syllabus page has the same block; a lesson opened from a bookmark or a
  // student's Notes list arrives without that context.
  const cal = weekByNumber(lesson.week_from);
  const days = syllabus
    ? sittingsForWeek(syllabus.form_level, lesson.week_from)
    : [];

  const num =
    lesson.lesson_no_start == null
      ? ""
      : lesson.lesson_no_end && lesson.lesson_no_end !== lesson.lesson_no_start
        ? `Lessons ${lesson.lesson_no_start}–${lesson.lesson_no_end}`
        : `Lesson ${lesson.lesson_no_start}`;

  return (
    <article className="reading">
      <p className="crumbs">
        <Link href="/">Progression</Link>
        {syllabus && (
          <>
            {" · "}
            <Link href={`/syllabus/${syllabus.id}`}>{syllabus.form_level}</Link>
          </>
        )}
        {category && <> · {category.category_of_action}</>}
      </p>

      <h1>{lesson.title}</h1>
      <p className="byline">
        {num} · Term {lesson.term}, week {lesson.week_from}
        {cal ? ` · ${formatRange(cal.start, cal.end)}` : ""}
        {lesson.duration_minutes ? ` · ${lesson.duration_minutes} minutes` : ""}
      </p>

      {days.length > 0 && (
        <ul className="sittings reading-sittings">
          {days.map((d) => (
            <li key={d.iso} className={d.closed ? "off" : d.disrupted ? "warn" : ""}>
              <span className="sit-day">{d.label}</span>
              {d.closed ? (
                <span className="sit-note">No lesson — {d.closed}</span>
              ) : (
                <>
                  {d.periods.map((p, i) => (
                    <span className="sit-slot" key={i}>
                      {p.stream ? <b>{p.stream}</b> : null} {p.time}
                    </span>
                  ))}
                  {d.disrupted && <span className="sit-note">{d.disrupted}</span>}
                </>
              )}
            </li>
          ))}
        </ul>
      )}

      {(objectives ?? []).length > 0 && (
        <aside className="objectives-box">
          <h3>By the end of this lesson you should be able to</h3>
          <ul>
            {objectives.map((o, i) => (
              <li key={i}>{o.description}</li>
            ))}
          </ul>
        </aside>
      )}

      <div className="prose">{render(lesson.content ?? "")}</div>

      {(resources ?? []).length > 0 && (
        <section className="attachments">
          <h3>Files for this lesson</h3>
          {resources.map((r) => (
            <a key={r.id} href={r.url} target="_blank" rel="noreferrer" className="attachment">
              <span className="attachment-name">
                {r.caption || r.url.split("/").pop()}
              </span>
              <span className="attachment-meta">
                {r.kind}
                {r.size_bytes
                  ? r.size_bytes < 1024 * 1024
                    ? ` · ${Math.round(r.size_bytes / 1024)} KB`
                    : ` · ${(r.size_bytes / 1024 / 1024).toFixed(1)} MB`
                  : ""}
              </span>
            </a>
          ))}
        </section>
      )}

      {syllabus && (
        <p className="lede" style={{ marginTop: 36 }}>
          <Link href={`/syllabus/${syllabus.id}`}>
            Back to the {syllabus.form_level} progression sheet
          </Link>
        </p>
      )}
    </article>
  );
}
