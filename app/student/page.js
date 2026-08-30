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

  const [{ data: weakData }, { data: progData }] = await Promise.all([
    supabase.rpc("student_weak_topics", { p_student: session.id }),
    supabase.rpc("student_progress", { p_student: session.id }),
  ]);
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
