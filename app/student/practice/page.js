import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "../../../lib/supabase-server";
import { getStudentSession } from "../../../lib/student-session";
import Quiz from "./Quiz";

export const metadata = { title: "Practice" };
export const dynamic = "force-dynamic";

export default async function Practice() {
  const session = await getStudentSession();
  if (!session) redirect("/student/login");

  const supabase = await createClient();
  if (!supabase) return <p>Not connected.</p>;

  const { data: prof } = await supabase.rpc("student_profile", { p_student: session.id });
  const profile = Array.isArray(prof) ? prof[0] : prof;
  if (!profile?.syllabus_id) redirect("/student");

  const { data } = await supabase.rpc("student_practice", {
    p_syllabus: profile.syllabus_id,
    p_limit: 10,
  });
  const questions = data ?? [];

  return (
    <main style={{ maxWidth: 640, margin: "0 auto", padding: "28px 20px" }}>
      <p style={{ marginBottom: 10 }}>
        <Link className="link" href="/student">← Back</Link>
      </p>
      <h2>Practice</h2>
      {questions.length === 0 ? (
        <div className="notice">
          <h3>No questions ready yet</h3>
          <p style={{ marginBottom: 0 }}>
            Your teacher checks each question before it is used for marking.
            None are ready for your class yet.
          </p>
        </div>
      ) : (
        <Quiz questions={questions} />
      )}
    </main>
  );
}
