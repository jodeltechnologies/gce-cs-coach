import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "../../lib/supabase-server";
import { getStudentSession } from "../../lib/student-session";
import { signOut } from "./actions";

export const metadata = { title: "My revision" };
export const dynamic = "force-dynamic";

export default async function StudentHome() {
  const session = await getStudentSession();
  if (!session) redirect("/student/login");

  const supabase = await createClient();
  if (!supabase) return <p>Not connected.</p>;

  const { data } = await supabase.rpc("student_profile", { p_student: session.id });
  const profile = Array.isArray(data) ? data[0] : data;

  const [{ data: weakData }, { data: progData }, { data: markedData },
         { data: testData }] = await Promise.all([
      supabase.rpc("student_weak_topics", { p_student: session.id }),
      supabase.rpc("student_progress", { p_student: session.id }),
      supabase.rpc("student_marked_work", { p_student: session.id }),
      supabase.rpc("student_assessments", { p_student: session.id }),
    ]);
  // A test the teacher has set outranks anything the student might choose to
  // do, so it goes above everything else on this page.
  const openTests = (testData ?? []).filter(
    (t) => t.is_open && t.attempt_status !== "submitted" && t.attempt_status !== "marked"
  );
  const marked = markedData ?? [];
  const weak = (weakData ?? []).filter((w) => Number(w.percentage) < 70);
  const progress = Array.isArray(progData) ? progData[0] : progData;
  const answered = Number(progress?.answered ?? 0);

  return (
    <main style={{ maxWidth: 640, margin: "0 auto", padding: "32px 20px" }}>
      <h2 style={{ marginBottom: 4 }}>
        {profile?.full_name ?? session.fullName}
      </h2>
      <p style={{ color: "var(--muted)", marginTop: 0 }}>
        {profile?.class_name
          ? `${profile.class_name} · ${profile.form_level}`
          : "You are not in a class yet — ask your teacher."}
      </p>

      {answered > 0 && (
        <p style={{ fontSize: "0.86rem", color: "var(--muted)", marginTop: 14 }}>
          {progress.runs} practice {Number(progress.runs) === 1 ? "run" : "runs"},{" "}
          {progress.correct} right out of {answered}.
        </p>
      )}

      {openTests.length > 0 && (
        <div className="notice" style={{ borderLeft: "3px solid var(--red)", marginTop: 18 }}>
          <h3 style={{ marginTop: 0 }}>
            {openTests.length === 1 ? "Your teacher has set a test" : "Tests set for you"}
          </h3>
          {openTests.map((t) => (
            <div key={t.assessment_id} style={{ marginBottom: 10 }}>
              <Link className="link" href={`/student/test/${t.assessment_id}`}
                    style={{ fontWeight: 600 }}>
                {t.title}
              </Link>
              <span style={{ color: "var(--muted)", fontSize: "0.86rem" }}>
                {" "}— {t.question_count} questions
                {t.total_marks ? `, ${t.total_marks} marks` : ""}
                {t.closes_at
                  ? `, closes ${new Date(t.closes_at).toLocaleDateString()}`
                  : ""}
                {t.attempt_status === "in_progress" ? " · you started this" : ""}
              </span>
            </div>
          ))}
        </div>
      )}

      {/* A mark from the teacher outranks everything the app worked out by
          itself, so it goes first. */}
      {marked.length > 0 && (
        <div className="notice" style={{ borderLeft: "3px solid var(--cyan)", marginTop: 18 }}>
          <h3 style={{ marginTop: 0 }}>Your teacher marked your work</h3>
          {marked.slice(0, 3).map((m) => (
            <div key={m.answer_id} style={{ marginBottom: 10 }}>
              <strong>
                {m.marks_awarded} out of {m.total_marks}
              </strong>{" "}
              <span style={{ color: "var(--muted)", fontSize: "0.86rem" }}>
                — {m.question_title}
              </span>
              {m.feedback && (
                <p style={{ margin: "3px 0 0", fontSize: "0.88rem" }}>{m.feedback}</p>
              )}
            </div>
          ))}
        </div>
      )}

      {/* The point of the whole thing: not a score, but which chapter to open.
          Only topics with enough answers behind them appear — calling a topic
          weak after one wrong answer is noise. */}
      {weak.length > 0 && (
        <div className="notice" style={{ borderLeft: "3px solid var(--gold)", marginTop: 18 }}>
          <h3 style={{ marginTop: 0 }}>Go back over these</h3>
          <ul style={{ margin: 0, paddingLeft: 18 }}>
            {weak.slice(0, 4).map((w) => (
              <li key={w.lesson_id} style={{ marginBottom: 6 }}>
                <strong>{w.lesson_title}</strong>{" "}
                <span style={{ color: "var(--muted)", fontSize: "0.86rem" }}>
                  — {w.correct} of {w.answered} right
                </span>
                {w.note_section_id && (
                  <>
                    {" · "}
                    <Link className="link" href={`/student/notes?c=${w.note_section_id}`}>
                      read {w.note_title}
                    </Link>
                  </>
                )}
              </li>
            ))}
          </ul>
        </div>
      )}

      {answered >= 3 && weak.length === 0 && (
        <p style={{ fontSize: "0.88rem", marginTop: 18 }}>
          Nothing is standing out as weak yet. Keep practising and this will
          fill in.
        </p>
      )}

      <div style={{ display: "grid", gap: 12, marginTop: 26 }}>
        <Link href="/student/notes" className="row" style={{ display: "block", textDecoration: "none" }}>
          <div className="name">Read the notes</div>
          <p style={{ margin: "4px 0 0", fontSize: "0.86rem", color: "var(--muted)" }}>
            Every chapter, with the diagrams from the booklet.
          </p>
        </Link>

        {profile?.syllabus_id ? (
          <Link href="/student/practice" className="row" style={{ display: "block", textDecoration: "none" }}>
            <div className="name">Practise past questions</div>
            <p style={{ margin: "4px 0 0", fontSize: "0.86rem", color: "var(--muted)" }}>
              Real GCE and mock questions, marked as you go. Weighted towards
            what you have been getting wrong.
            </p>
          </Link>
        ) : (
          <div className="notice">
            <p style={{ margin: 0 }}>
              Practice opens once your teacher puts you in a class.
            </p>
          </div>
        )}
      </div>

      <form action={signOut} style={{ marginTop: 30 }}>
        <button className="link" type="submit" style={{ fontSize: "0.86rem" }}>
          Sign out
        </button>
      </form>
    </main>
  );
}
