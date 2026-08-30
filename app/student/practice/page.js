import Link from "next/link";
import { redirect } from "next/navigation";
import { getStudentSession } from "../../../lib/student-session";
import { startPractice } from "../actions";
import Quiz from "./Quiz";

export const metadata = { title: "Practice" };
export const dynamic = "force-dynamic";

export default async function Practice() {
  const session = await getStudentSession();
  if (!session) redirect("/student/login");

  const run = await startPractice();

  return (
    <main style={{ maxWidth: 640, margin: "0 auto", padding: "28px 20px" }}>
      <p style={{ marginBottom: 10 }}>
        <Link className="link" href="/student">← Back</Link>
      </p>
      <h2>Practice</h2>

      {run.error && (
        <div className="notice bad">
          <p style={{ margin: 0 }}>{run.error}</p>
        </div>
      )}

      {!run.error && (run.questions ?? []).length === 0 && (
        <div className="notice">
          <h3>No questions ready yet</h3>
          <p style={{ marginBottom: 0 }}>
            Your teacher checks each question before it is used for marking.
            None are ready for your class yet.
          </p>
        </div>
      )}

      {!run.error && (run.questions ?? []).length > 0 && (
        <Quiz attemptId={run.attemptId} questions={run.questions} />
      )}
    </main>
  );
}
