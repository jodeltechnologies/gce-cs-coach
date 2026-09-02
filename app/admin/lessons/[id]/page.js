import Link from "next/link";
import { createClient } from "../../../../lib/supabase-server";
import {
  saveLesson,
  addObjective,
  deleteObjective,
  removeResource,
} from "../actions";
import Uploader from "./Uploader";
import {
  formatRange,
  sittingsForWeek,
  weekByNumber,
} from "../../../../lib/school-calendar";

export const metadata = { title: "Edit lesson" };

export const dynamic = "force-dynamic";

const textareaStyle = {
  width: "100%",
  minHeight: 200,
  padding: "10px 12px",
  fontSize: "0.95rem",
  lineHeight: 1.55,
  fontFamily: "inherit",
  color: "var(--ink)",
  background: "var(--surface)",
  border: "1px solid var(--line)",
  borderRadius: 8,
};

export default async function LessonEditor({ params }) {
  const { id } = await params;
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const { data: lesson } = await supabase
    .from("lessons")
    .select(
      "id, lesson_no_start, lesson_no_end, title, term, week_from, lesson_kind, status, content, teacher_notes, duration_minutes, competency_id, syllabus_id, is_theory, is_practical, is_digitalised"
    )
    .eq("id", id)
    .maybeSingle();

  if (!lesson) {
    return (
      <>
        <h2>Lesson not found</h2>
        <p className="lede">
          <Link href="/admin/lessons">Back to lessons</Link>
        </p>
      </>
    );
  }

  const [{ data: objectives }, { data: resources }, { data: category }, { data: syllabus }] =
    await Promise.all([
      supabase
        .from("objectives")
        .select("id, description, kind, bloom_level, sequence")
        .eq("lesson_id", id)
        .is("deleted_at", null)
        .order("sequence"),
      supabase
        .from("lesson_resources")
        .select("id, kind, url, caption, size_bytes, offline_cache")
        .eq("lesson_id", id)
        .is("deleted_at", null),
      lesson.competency_id
        ? supabase
            .from("competencies")
            .select("category_of_action, competency_statement, exam_frequency")
            .eq("id", lesson.competency_id)
            .maybeSingle()
        : Promise.resolve({ data: null }),
      supabase
        .from("syllabi")
        .select("form_level")
        .eq("id", lesson.syllabus_id)
        .maybeSingle(),
    ]);

  const num =
    lesson.lesson_no_start == null
      ? ""
      : lesson.lesson_no_end && lesson.lesson_no_end !== lesson.lesson_no_start
        ? `Lessons ${lesson.lesson_no_start}–${lesson.lesson_no_end}`
        : `Lesson ${lesson.lesson_no_start}`;

  // When this class is actually in front of you for this week.
  const cal = weekByNumber(lesson.week_from);
  const days = syllabus
    ? sittingsForWeek(syllabus.form_level, lesson.week_from)
    : [];

  return (
    <>
      <h2>{lesson.title}</h2>
      <p className="lede">
        {syllabus?.form_level} · {num} · Term {lesson.term}, week{" "}
        {lesson.week_from}
        {cal ? ` · ${formatRange(cal.start, cal.end)}` : ""}
      </p>

      {days.length > 0 && (
        <ul className="sittings" style={{ margin: "0 0 20px" }}>
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

      {category && (
        <div className="notice">
          <h3>{category.category_of_action}</h3>
          {category.competency_statement ? (
            <p style={{ margin: 0 }}>{category.competency_statement}</p>
          ) : (
            <p style={{ margin: 0, color: "var(--muted)" }}>
              This sheet names the category but does not state the competency.
            </p>
          )}
          {category.exam_frequency && (
            <div className="tags">
              <span className="tag gold">
                {category.exam_frequency.replace("_", " ")} in the GCE
              </span>
            </div>
          )}
        </div>
      )}

      <h3>Objectives from the progression sheet</h3>
      {(objectives ?? []).length === 0 && (
        <p className="lede">
          None on the sheet for this row. Add your own below.
        </p>
      )}
      {(objectives ?? []).map((o) => (
        <div className="row" key={o.id}>
          <div className="name">{o.description}</div>
          <div
            style={{
              display: "flex",
              gap: 8,
              alignItems: "center",
              marginTop: 4,
            }}
          >
            {o.bloom_level && (
              <span className="tag plain">{o.bloom_level}</span>
            )}
            {o.kind === "content_point" && (
              <span className="tag plain">content point</span>
            )}
            <form action={deleteObjective}>
              <input type="hidden" name="objective_id" value={o.id} />
              <input type="hidden" name="lesson_id" value={lesson.id} />
              <button className="link" type="submit">
                Remove
              </button>
            </form>
          </div>
        </div>
      ))}

      <form action={addObjective} style={{ marginTop: 14, maxWidth: 520 }}>
        <input type="hidden" name="lesson_id" value={lesson.id} />
        <label className="field">
          <span>Add an objective of your own</span>
          <input
            type="text"
            name="description"
            placeholder="Trace a bubble sort over five values"
            required
          />
        </label>
        <button className="primary" type="submit">
          Add objective
        </button>
      </form>

      <form action={saveLesson} style={{ marginTop: 34 }}>
        <input type="hidden" name="lesson_id" value={lesson.id} />

        <h3>Notes for students</h3>
        <p className="lede" style={{ fontSize: "0.84rem" }}>
          What the class reads. Plain text or Markdown. Nothing appears to a
          student until the status below is set to Published.
        </p>
        <textarea
          name="content"
          defaultValue={lesson.content ?? ""}
          style={textareaStyle}
          placeholder="Write or paste the notes for this lesson."
        />

        <h3 style={{ marginTop: 26 }}>Teacher notes</h3>
        <p className="lede" style={{ fontSize: "0.84rem" }}>
          Private. How to teach it, where the class always trips, what to do
          differently next year. Never shown to students.
        </p>
        <textarea
          name="teacher_notes"
          defaultValue={lesson.teacher_notes ?? ""}
          style={{ ...textareaStyle, minHeight: 130 }}
          placeholder="They confuse the CPU with RAM every single year. Start with the analogy before the diagram."
        />

        <div
          style={{
            display: "flex",
            gap: 14,
            flexWrap: "wrap",
            alignItems: "flex-end",
            marginTop: 18,
          }}
        >
          <label className="field" style={{ marginBottom: 0 }}>
            <span>Status</span>
            <select
              name="status"
              defaultValue={lesson.status}
              style={{
                padding: "10px 12px",
                fontSize: "0.95rem",
                borderRadius: 8,
                border: "1px solid var(--line)",
                background: "var(--surface)",
                color: "var(--ink)",
              }}
            >
              <option value="draft">Draft — only you can see it</option>
              <option value="published">Published — students can read it</option>
              <option value="archived">Archived</option>
            </select>
          </label>

          <label className="field" style={{ marginBottom: 0, width: 150 }}>
            <span>Minutes</span>
            <input
              type="text"
              name="duration_minutes"
              defaultValue={lesson.duration_minutes ?? ""}
              inputMode="numeric"
              placeholder="55"
            />
          </label>
        </div>

        <div className="sticky-save">
          <button className="primary" type="submit">
            Save lesson
          </button>
        </div>
      </form>

      <h3 style={{ marginTop: 34 }}>Attachments</h3>
      <p className="lede" style={{ fontSize: "0.84rem" }}>
        Scanned notes, diagrams, past papers. These are readable by anyone with
        the link, so keep mark sheets and student lists out of here.
      </p>

      {(resources ?? []).map((r) => (
        <div className="row" key={r.id}>
          <div className="name">
            <a href={r.url} target="_blank" rel="noreferrer">
              {r.caption || r.url.split("/").pop()}
            </a>
          </div>
          <div style={{ display: "flex", gap: 8, alignItems: "center", marginTop: 4 }}>
            <span className="tag plain">{r.kind}</span>
            {r.size_bytes && (
              <span className="tag plain">
                {r.size_bytes < 1024 * 1024
                  ? `${Math.round(r.size_bytes / 1024)} KB`
                  : `${(r.size_bytes / 1024 / 1024).toFixed(1)} MB`}
              </span>
            )}
            {r.offline_cache && <span className="tag">cached offline</span>}
            <form action={removeResource}>
              <input type="hidden" name="resource_id" value={r.id} />
              <input type="hidden" name="lesson_id" value={lesson.id} />
              <button className="link" type="submit">
                Remove
              </button>
            </form>
          </div>
        </div>
      ))}

      <Uploader lessonId={lesson.id} />

      <p className="lede" style={{ marginTop: 30 }}>
        <Link href="/admin/lessons">Back to lessons</Link>
        {lesson.status === "published" && (
          <>
            {" · "}
            <Link href={`/lesson/${lesson.id}`}>View as a student sees it</Link>
          </>
        )}
      </p>
    </>
  );
}
