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
              Real GCE and mock questions, marked as you go.
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
