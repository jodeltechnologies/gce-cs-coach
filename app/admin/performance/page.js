import Link from "next/link";
import { createClient } from "../../../lib/supabase-server";

export const metadata = { title: "Student progress" };
export const dynamic = "force-dynamic";

function pct(part, whole) {
  if (!whole) return null;
  return Math.round((Number(part) / Number(whole)) * 100);
}

export default async function AdminPerformance() {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const [{ data: rowData }, { data: hotData }] = await Promise.all([
    supabase.rpc("teacher_class_performance"),
    supabase.rpc("teacher_check_hotspots"),
  ]);
  const rows = rowData ?? [];
  const hotspots = hotData ?? [];

  const byClass = new Map();
  for (const r of rows) {
    const key = r.class_name ?? "No class";
    if (!byClass.has(key)) byClass.set(key, []);
    byClass.get(key).push(r);
  }

  return (
    <>
      <h2>How the class is doing</h2>
      <p className="lede">
        Two different things here, kept apart. Practice answers are marked by
        the app. The questions in the notes are marked by the student against a
        model answer, so they are a report rather than a score.
      </p>

      {/* The one that tells you what to reteach in front of everybody. */}
      {hotspots.length > 0 && (
        <div className="notice" style={{ borderLeft: "3px solid var(--gold)" }}>
          <h3 style={{ marginTop: 0 }}>What the class as a whole is finding hard</h3>
          <p style={{ fontSize: "0.88rem", color: "var(--muted)", marginTop: 0 }}>
            Questions where more than one student said they missed it. Worth
            twenty minutes at the board rather than twenty replies.
          </p>
          {hotspots.slice(0, 8).map((h) => (
            <div key={`${h.note_section_id}-${h.question_index}`}
                 style={{ marginBottom: 12 }}>
              <div style={{ fontSize: "0.92rem" }}>
                {h.question_text || `Question ${Number(h.question_index) + 1}`}
              </div>
              <div style={{ fontSize: "0.84rem", color: "var(--muted)" }}>
                {h.note_title} · {h.missed} missed
                {Number(h.partly) > 0 ? `, ${h.partly} partly` : ""} of{" "}
                {h.answered} who tried it
              </div>
            </div>
          ))}
        </div>
      )}

      {rows.length === 0 && (
        <div className="notice">
          <p style={{ margin: 0 }}>
            No students yet, or none of them has done anything to report.
          </p>
        </div>
      )}

      {[...byClass.entries()].map(([className, list]) => (
        <section key={className} style={{ marginTop: 28 }}>
          <div className="term-head">{className}</div>
          <div className="tt-scroll">
            <table className="tt-load" style={{ minWidth: 640 }}>
              <thead>
                <tr>
                  <th>Student</th>
                  <th>Practice</th>
                  <th>Notes read</th>
                  <th>Said they missed</th>
                  <th>Last seen</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                {list.map((r) => {
                  const p = pct(r.practice_correct, r.practice_answered);
                  return (
                    <tr key={r.student_id}>
                      <td>
                        {r.full_name}
                        {Number(r.unread_from_student) > 0 && (
                          <span className="tag alert" style={{ marginLeft: 8 }}>
                            wrote to you
                          </span>
                        )}
                      </td>
                      <td className="num">
                        {r.practice_answered > 0
                          ? `${p}% of ${r.practice_answered}`
                          : "—"}
                      </td>
                      <td className="num">{r.notes_opened}</td>
                      <td className="num">
                        {Number(r.checks_answered) > 0
                          ? `${r.checks_missed} of ${r.checks_answered}`
                          : "—"}
                      </td>
                      <td className="num">
                        {r.last_active
                          ? new Date(r.last_active).toLocaleDateString([], {
                              day: "numeric",
                              month: "short",
                            })
                          : "—"}
                      </td>
                      <td className="num">
                        <Link className="link" href={`/admin/messages?s=${r.student_id}`}>
                          message
                        </Link>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </section>
      ))}

      <p style={{ marginTop: 26, fontSize: "0.85rem", color: "var(--muted)" }}>
        A student with nothing in the practice column has not been idle
        necessarily. They may have been reading. The notes column is the one to
        read alongside it.
      </p>
    </>
  );
}
