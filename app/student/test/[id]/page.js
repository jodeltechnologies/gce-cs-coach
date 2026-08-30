import Link from "next/link";
import { redirect } from "next/navigation";
import { getStudentSession } from "../../../../lib/student-session";
import { openAssessment } from "../../actions";
import Sitting from "./Sitting";

export const metadata = { title: "Test" };
export const dynamic = "force-dynamic";

export default async function TakeTest({ params }) {
  const session = await getStudentSession();
  if (!session) redirect("/student/login");

  const { id } = await params;
  const run = await openAssessment(id);

  return (
    <main style={{ maxWidth: 640, margin: "0 auto", padding: "28px 20px" }}>
      {run.error ? (
        <>
          <p style={{ marginBottom: 10 }}>
            <Link className="link" href="/student">← Back</Link>
          </p>
          <div className="notice bad">
            <h3 style={{ marginTop: 0 }}>Cannot open this test</h3>
            <p style={{ marginBottom: 0 }}>{run.error}</p>
          </div>
        </>
      ) : (
        <Sitting attemptId={run.attemptId} questions={run.questions} />
      )}
    </main>
  );
}
