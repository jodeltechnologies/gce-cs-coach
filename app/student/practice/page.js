import Link from "next/link";
import { redirect } from "next/navigation";
import { getStudentSession } from "../../../lib/student-session";
import { startPractice, startStructured, practiceTopics } from "../actions";
import Quiz from "./Quiz";
import Structured from "./Structured";

export const metadata = { title: "Practice" };
export const dynamic = "force-dynamic";

export default async function Practice({ searchParams }) {
  const session = await getStudentSession();
  if (!session) redirect("/student/login");

  const sp = await searchParams;
  const started = sp?.go === "1";

  // Nothing starts until the student has chosen. Opening this page used to
  // create an attempt straight away, which meant a student who glanced at it
  // and went to the notes left an empty run behind.
  if (!started) {
    const res = await practiceTopics();
    return (
      <main style={{ maxWidth: 640, margin: "0 auto", padding: "28px 20px" }}>
        <p style={{ marginBottom: 10 }}>
          <Link className="link" href="/student">← Back</Link>
        </p>
        <h2>Practice</h2>

        {res.error && (
          <div className="notice bad"><p style={{ margin: 0 }}>{res.error}</p></div>
        )}

        {!res.error && (res.topics ?? []).length === 0 && (
          <div className="notice">
            <h3>No questions ready yet</h3>
            <p style={{ marginBottom: 0 }}>
              Your teacher checks each question before it is used for marking.
              None are ready for your class yet.
            </p>
          </div>
        )}

        {!res.error && (res.topics ?? []).length > 0 && (
          <Chooser topics={res.topics} />
        )}
      </main>
    );
  }

  // Mode is derived rather than posted alongside the lesson. If the form sent
  // both, a topic button and a hidden field would each contribute a "mode" and
  // the value would arrive as an array.
  const lessonId = sp?.lesson || null;
  const wantsStructured = sp?.kind === "structured";

  const run = wantsStructured
    ? await startStructured({ lessonId, count: sp?.n || 2 })
    : await startPractice({
        lessonId,
        count: sp?.n || 10,
        mode: lessonId ? "lesson" : sp?.mode || "mixed",
      });

  return (
    <main style={{ maxWidth: 640, margin: "0 auto", padding: "28px 20px" }}>
      <p style={{ marginBottom: 10 }}>
        <Link className="link" href="/student/practice">← Choose something else</Link>
      </p>

      {run.error && (
        <div className="notice bad"><p style={{ margin: 0 }}>{run.error}</p></div>
      )}

      {!run.error && (run.questions ?? []).length === 0 && (
        <div className="notice">
          <h3>Nothing to ask you there yet</h3>
          <p style={{ marginBottom: 0 }}>
            No checked {wantsStructured ? "structured questions" : "questions"}{" "}
            match that choice. Try another topic.
          </p>
        </div>
      )}

      {!run.error && (run.questions ?? []).length > 0 &&
        (wantsStructured ? (
          <Structured attemptId={run.attemptId} questions={run.questions} />
        ) : (
          <Quiz
            attemptId={run.attemptId}
            questions={run.questions}
            seconds={Number(sp?.t) || 0}
          />
        ))}
    </main>
  );
}

/**
 * One form for everything.
 *
 * The topics were links at first, which meant picking "Logic gates" silently
 * threw away the count and timer the student had just set two inches above.
 * As submit buttons in the same form they carry those settings with them.
 */
function Chooser({ topics }) {
  const total = topics.reduce((n, t) => n + Number(t.available), 0);
  const structuredTotal = topics.reduce((n, t) => n + Number(t.structured ?? 0), 0);

  return (
    <form action="/student/practice" method="get">
      <input type="hidden" name="go" value="1" />
      <p className="lede">
        Pick a topic, or take a mixed set. Choose how many questions and whether
        you want a timer.
      </p>

      <div style={{ display: "flex", gap: 12, flexWrap: "wrap", marginBottom: 20 }}>
          <label className="field" style={{ flex: 1, minWidth: 150 }}>
            <span>How many</span>
            <select name="n" defaultValue="10">
              <option value="5">5 questions</option>
              <option value="10">10 questions</option>
              <option value="20">20 questions</option>
              <option value="30">30 questions</option>
            </select>
          </label>
          <label className="field" style={{ flex: 1, minWidth: 150 }}>
            <span>Timer</span>
            <select name="t" defaultValue="0">
              <option value="0">No timer</option>
              <option value="45">45 seconds each</option>
              <option value="60">60 seconds each</option>
              <option value="90">90 seconds each</option>
            </select>
          </label>
        </div>

        <div style={{ display: "flex", gap: 10, flexWrap: "wrap", marginBottom: 8 }}>
          <button className="primary" type="submit" name="mode" value="mixed">
            Mixed set
          </button>
          <button className="primary" type="submit" name="mode" value="weak"
                  style={{ background: "var(--gold)", color: "#1a1a1a" }}>
            What I keep getting wrong
          </button>
          {structuredTotal > 0 && (
            <button className="primary" type="submit" name="kind" value="structured"
                    style={{ background: "transparent", color: "var(--ink, #2b2b2b)",
                             border: "1px solid var(--rule, #e5e2dc)" }}>
              Paper 2 questions
            </button>
          )}
        </div>
      <p style={{ fontSize: "0.8rem", color: "var(--muted)", marginTop: 0 }}>
        {total} multiple choice
        {structuredTotal > 0 ? ` and ${structuredTotal} Paper 2 questions` : ""}{" "}
        ready across {topics.length} topics. Paper 2 answers are not scored —
        you write them, then compare with the marker&apos;s points.
      </p>

      <h3 style={{ marginTop: 26 }}>Or pick a topic</h3>
      <div style={{ display: "grid", gap: 10,
                    gridTemplateColumns: "repeat(auto-fill, minmax(220px, 1fr))" }}>
        {topics.map((t) => {
          const pct = t.percentage === null ? null : Number(t.percentage);
          return (
            <button
              key={t.lesson_id}
              type="submit"
              name="lesson"
              value={t.lesson_id}
              className="row"
              style={{
                display: "block", textAlign: "left", width: "100%",
                cursor: "pointer", font: "inherit",
              }}
            >
              <div className="name" style={{ fontSize: "0.94rem" }}>
                {t.lesson_title}
              </div>
              <div className="tags" style={{ marginTop: 6 }}>
                <span className="tag plain">{t.available} MCQ</span>
                {Number(t.structured ?? 0) > 0 && (
                  <span className="tag plain">{t.structured} Paper 2</span>
                )}
                {pct !== null && (
                  <span className={pct < 50 ? "tag alert" : "tag"}>{pct}% so far</span>
                )}
              </div>
            </button>
          );
        })}
      </div>
    </form>
  );
}
