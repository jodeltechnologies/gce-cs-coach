import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "../../../../lib/supabase-server";
import { removeQuestion, closeAssessment, addMoreQuestions } from "../actions";

export const dynamic = "force-dynamic";

export default async function AssessmentDetail({ params }) {
  const { id } = await params;
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const { data: a } = await supabase
    .from("assessments")
    .select("id, title, kind, total_marks, duration_minutes, opens_at, closes_at, show_results, classes(name)")
    .eq("id", id)
    .is("deleted_at", null)
    .maybeSingle();
  if (!a) notFound();

  const [{ data: results }, { data: analysis }, { data: paper }] =
    await Promise.all([
      supabase.rpc("assessment_results", { p_assessment: id }),
      supabase.rpc("assessment_question_analysis", { p_assessment: id }),
      supabase
        .from("assessment_questions")
        .select("sequence, question_id, questions(question_text, question_type, marks)")
        .eq("assessment_id", id)
        .order("sequence"),
    ]);

  const rows = results ?? [];
  const sat = rows.filter((r) => r.submitted_at);
  const open = (!a.closes_at || new Date(a.closes_at).getTime() > Date.now());
  const pending = rows.reduce((n, r) => n + Number(r.awaiting_marking ?? 0), 0);
  const average = sat.length
    ? Math.round(sat.reduce((n, r) => n + Number(r.percentage ?? 0), 0) / sat.length)
    : null;

  return (
    <>
      <p style={{ marginBottom: 6 }}>
        <Link className="link" href="/admin/assessments">← All tests</Link>
      </p>
      <h2 style={{ marginBottom: 4 }}>{a.title}</h2>
      <div className="tags" style={{ marginBottom: 18 }}>
        <span className="tag plain">{a.classes?.name}</span>
        <span className="tag plain">{a.kind.replace("_", " ")}</span>
        <span className="tag plain">{a.total_marks ?? 0} marks</span>
        {a.duration_minutes && <span className="tag plain">{a.duration_minutes} min</span>}
        <span className={open ? "tag" : "tag plain"}>{open ? "Open" : "Closed"}</span>
      </div>

      <div className="tags" style={{ marginBottom: 20 }}>
        <span className="tag plain">{sat.length} of {rows.length} have sat it</span>
        {average !== null && <span className="tag">class average {average}%</span>}
        {pending > 0 && (
          <Link className="tag alert" href="/admin/marking">
            {pending} written answers to mark
          </Link>
        )}
      </div>

      {open && (
        <form action={closeAssessment} style={{ marginBottom: 22 }}>
          <input type="hidden" name="assessment_id" value={a.id} />
          <button className="link" type="submit">Close it now</button>
        </form>
      )}

      <h3>Results</h3>
      {rows.length === 0 && (
        <p style={{ color: "var(--muted)" }}>
          Nobody is enrolled in that class yet.
        </p>
      )}
      {rows.map((r) => (
        <div key={r.student_id} className="row" style={{ display: "flex",
             justifyContent: "space-between", alignItems: "center", gap: 12 }}>
          <span className="name" style={{ flex: 1 }}>{r.student_name}</span>
          {r.submitted_at ? (
            <>
              <span style={{ fontSize: "0.86rem" }}>
                {r.score ?? 0} / {a.total_marks ?? 0}
              </span>
              <span style={{
                fontWeight: 600, width: 52, textAlign: "right",
                color: Number(r.percentage) < 40 ? "var(--red)"
                     : Number(r.percentage) < 70 ? "var(--gold-ink)" : "var(--green)",
              }}>
                {Math.round(Number(r.percentage ?? 0))}%
              </span>
            </>
          ) : (
            <span className="tag plain">
              {r.status === "in_progress" ? "Started" : "Not started"}
            </span>
          )}
        </div>
      ))}

      {/* The reason to set a test rather than only look at totals: a question
          most of the class got wrong is a lesson to reteach. */}
      {(analysis ?? []).some((q) => q.answered > 0) && (
        <>
          <h3 style={{ marginTop: 32 }}>Which questions caught them out</h3>
          <p style={{ fontSize: "0.84rem", color: "var(--muted)", marginTop: 0 }}>
            Hardest first. Anything under half the class is worth going over
            again in front of everybody.
          </p>
          {(analysis ?? []).filter((q) => q.answered > 0).slice(0, 10).map((q) => (
            <div key={q.question_id} className="row" style={{ display: "block" }}>
              <div style={{ fontSize: "0.92rem" }}>{q.question_text}</div>
              <div className="tags" style={{ marginTop: 6 }}>
                <span className={Number(q.percentage) < 50 ? "tag alert" : "tag plain"}>
                  {q.correct} of {q.answered} right
                </span>
                {q.lesson_title && <span className="tag plain">{q.lesson_title}</span>}
              </div>
            </div>
          ))}
        </>
      )}

      <h3 style={{ marginTop: 32 }}>The paper ({(paper ?? []).length} questions)</h3>
      {(paper ?? []).map((p) => (
        <div key={p.question_id} className="row" style={{ display: "flex",
             gap: 10, alignItems: "flex-start" }}>
          <span style={{ color: "var(--muted)", fontSize: "0.86rem", width: 24 }}>
            {p.sequence}
          </span>
          <span style={{ flex: 1, fontSize: "0.92rem" }}>
            {p.questions?.question_text}
          </span>
          <span className="tag plain">{p.questions?.marks} mk</span>
          {sat.length === 0 && (
            <form action={removeQuestion}>
              <input type="hidden" name="assessment_id" value={a.id} />
              <input type="hidden" name="question_id" value={p.question_id} />
              <button className="link" type="submit" style={{ color: "var(--red)" }}>
                Remove
              </button>
            </form>
          )}
        </div>
      ))}

      {sat.length === 0 ? (
        <form action={addMoreQuestions} style={{ marginTop: 16, display: "flex",
              gap: 10, alignItems: "flex-end" }}>
          <input type="hidden" name="assessment_id" value={a.id} />
          <label className="field" style={{ width: 130, marginBottom: 0 }}>
            <span>Add more</span>
            <select name="count" defaultValue="5">
              <option value="5">5 questions</option>
              <option value="10">10 questions</option>
            </select>
          </label>
          <button className="primary" type="submit">Add</button>
        </form>
      ) : (
        <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: 14 }}>
          The paper is locked because students have already sat it. Changing the
          questions now would mean comparing marks from two different tests.
        </p>
      )}
    </>
  );
}
