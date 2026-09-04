import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "../../../lib/supabase-server";
import { getStudentSession } from "../../../lib/student-session";
import { currentWeek } from "../../../lib/school-calendar";

export const metadata = { title: "My progression" };
export const dynamic = "force-dynamic";

const KIND_LABEL = {
  diagnostic_evaluation: "Diagnostic",
  integration_activity: "Integration",
  evaluation: "Evaluation",
  remediation: "Remediation",
  practical: "Practical",
  revision: "Revision",
};

function pct(part, whole) {
  if (!whole) return null;
  return Math.round((Number(part) / Number(whole)) * 100);
}

function Bar({ value, tone = "green" }) {
  return (
    <div className="bar-track" aria-hidden="true">
      <div className={`bar-fill ${tone}`} style={{ width: `${Math.max(2, value)}%` }} />
    </div>
  );
}

export default async function StudentProgress() {
  const session = await getStudentSession();
  if (!session) redirect("/student/login");

  const supabase = await createClient();
  if (!supabase) return <p>Not connected.</p>;

  const week = currentWeek()?.week ?? 1;

  const [{ data: profData }, { data: ovData }, { data: weakData },
         { data: lessonData }, { data: practiceWeak }] = await Promise.all([
    supabase.rpc("student_profile", { p_student: session.id }),
    supabase.rpc("student_overview", { p_student: session.id }),
    supabase.rpc("student_check_weak", { p_student: session.id }),
    supabase.rpc("student_next_lessons", {
      p_student: session.id, p_week: week, p_limit: 10,
    }),
    supabase.rpc("student_weak_topics", { p_student: session.id }),
  ]);

  const profile = Array.isArray(profData) ? profData[0] : profData;
  const o = (Array.isArray(ovData) ? ovData[0] : ovData) ?? {};
  const checkWeak = weakData ?? [];
  const lessons = lessonData ?? [];
  const practice = (practiceWeak ?? []).filter((w) => Number(w.percentage) < 70);

  const answered = Number(o.practice_answered ?? 0);
  const correct = Number(o.practice_correct ?? 0);
  const checks = Number(o.checks_answered ?? 0);
  const gotIt = Number(o.checks_got_it ?? 0);
  const partly = Number(o.checks_partly ?? 0);
  const missed = Number(o.checks_missed ?? 0);

  const practicePct = pct(correct, answered);
  const checkPct = pct(gotIt, checks);

  return (
    <main style={{ maxWidth: 720, margin: "0 auto", padding: "28px 20px" }}>
      <p style={{ marginBottom: 10 }}>
        <Link className="link" href="/student">← My revision</Link>
      </p>

      <h2 style={{ marginBottom: 2 }}>My progression</h2>
      <p className="lede">
        {profile?.class_name
          ? `${profile.class_name} · ${profile.form_level}`
          : "You are not in a class yet. Ask your teacher."}
      </p>

      {/* ---- where you stand ---- */}
      <h3>Where you stand</h3>
      {answered === 0 && checks === 0 ? (
        <div className="notice">
          <p style={{ margin: 0 }}>
            Nothing here yet. Read a note and answer the questions at the foot
            of it, or try some practice questions, and this page fills in.
          </p>
        </div>
      ) : (
        <div className="stat-grid">
          <div className="stat">
            <div className="stat-head">Practice questions</div>
            {answered > 0 ? (
              <>
                <div className="stat-big">{practicePct}%</div>
                <Bar value={practicePct} tone={practicePct >= 70 ? "green" : "gold"} />
                <p className="stat-note">
                  {correct} right out of {answered}, over {o.practice_runs} runs.
                  These are marked by the app.
                </p>
              </>
            ) : (
              <p className="stat-note">You have not practised yet.</p>
            )}
          </div>

          <div className="stat">
            <div className="stat-head">Questions in the notes</div>
            {checks > 0 ? (
              <>
                <div className="stat-big">{checkPct}%</div>
                <Bar value={checkPct} tone={checkPct >= 70 ? "green" : "gold"} />
                <p className="stat-note">
                  You said you had {gotIt} of {checks}, partly had {partly}, and
                  missed {missed}. This is your own judgement, not a mark.
                </p>
              </>
            ) : (
              <p className="stat-note">
                Answer the questions at the foot of a note and they show here.
              </p>
            )}
          </div>
        </div>
      )}

      {Number(o.notes_available ?? 0) > 0 && (
        <p style={{ fontSize: "0.86rem", color: "var(--muted)" }}>
          You have worked through questions in {o.notes_opened} of{" "}
          {o.notes_available} notes your teacher has released.
        </p>
      )}

      {/* ---- what to go back over ---- */}
      {(checkWeak.length > 0 || practice.length > 0) && (
        <>
          <h3 style={{ marginTop: 30 }}>Go back over these</h3>
          <p style={{ fontSize: "0.88rem", color: "var(--muted)", marginTop: 0 }}>
            The point of this page. Not a score, but which note to open next.
          </p>

          {checkWeak.slice(0, 6).map((w) => (
            <div className="row" key={w.note_section_id} style={{ display: "block" }}>
              <div className="name">
                <Link className="link" href={`/student/notes?c=${w.note_section_id}`}>
                  {w.note_title}
                </Link>
              </div>
              <p style={{ margin: "3px 0 0", fontSize: "0.86rem", color: "var(--muted)" }}>
                {w.missed > 0 && `You missed ${w.missed} `}
                {w.missed > 0 && w.partly > 0 && "and "}
                {w.partly > 0 && `partly had ${w.partly} `}
                of {w.total} questions here.
              </p>
            </div>
          ))}

          {practice.slice(0, 4).map((w) => (
            <div className="row" key={w.lesson_id} style={{ display: "block" }}>
              <div className="name">{w.lesson_title}</div>
              <p style={{ margin: "3px 0 0", fontSize: "0.86rem", color: "var(--muted)" }}>
                {w.correct} of {w.answered} practice questions right.
                {w.note_section_id && (
                  <>
                    {" "}
                    <Link className="link" href={`/student/notes?c=${w.note_section_id}`}>
                      Read {w.note_title}
                    </Link>
                  </>
                )}
              </p>
            </div>
          ))}

          <div className="notice" style={{ marginTop: 16 }}>
            <p style={{ margin: 0, fontSize: "0.9rem" }}>
              Still stuck after reading it again?{" "}
              <Link className="link" href="/student/messages">
                Write to your teacher
              </Link>
              . Say which lesson and what part of it lost you.
            </p>
          </div>
        </>
      )}

      {/* ---- the next ten lessons ---- */}
      <h3 style={{ marginTop: 34 }}>What is coming</h3>
      <p style={{ fontSize: "0.88rem", color: "var(--muted)", marginTop: 0 }}>
        The next ten lessons on the sheet, from week {week}. The whole year at
        once is thirty-six weeks of work and it is no use to anybody.
      </p>

      {lessons.length === 0 ? (
        <div className="notice">
          <p style={{ margin: 0 }}>
            No lessons to show. Your teacher may not have put you in a class
            yet.
          </p>
        </div>
      ) : (
        <ol className="next-list">
          {lessons.map((l) => (
            <li key={l.lesson_id}>
              <div className="next-week">wk {l.week_from}</div>
              <div>
                <div className="next-title">
                  {l.lesson_no ? `${l.lesson_no}. ` : ""}
                  {l.title}
                  {l.lesson_kind !== "content" && (
                    <span className="tag" style={{ marginLeft: 8 }}>
                      {KIND_LABEL[l.lesson_kind] ?? l.lesson_kind}
                    </span>
                  )}
                </div>
                {l.category && <div className="next-cat">{l.category}</div>}
                <div className="next-state">
                  {l.note_section_id && l.note_released ? (
                    <Link className="link" href={`/student/notes?c=${l.note_section_id}`}>
                      Read the note
                    </Link>
                  ) : l.note_section_id ? (
                    <span className="muted">
                      Note not released yet
                    </span>
                  ) : (
                    <span className="muted">No note for this one</span>
                  )}
                  {Number(l.self_checks_done) + Number(l.self_checks_missed) > 0 && (
                    <span className="muted">
                      {" · "}
                      {l.self_checks_done} answered
                      {Number(l.self_checks_missed) > 0
                        ? `, ${l.self_checks_missed} to go back over`
                        : ""}
                    </span>
                  )}
                </div>
              </div>
            </li>
          ))}
        </ol>
      )}

      <p style={{ marginTop: 30 }}>
        <Link className="link" href="/student/messages">Message your teacher</Link>
      </p>
    </main>
  );
}
