"use client";

import { useState } from "react";
import { saveTestAnswer, submitAssessment } from "../../actions";

/**
 * Sitting a test.
 *
 * Every answer is saved to the server the moment it is given, not held in the
 * browser until the end. Phones die and networks drop, and a student who loses
 * power on question eighteen should lose one answer, not all eighteen.
 *
 * Nothing is marked as they go. There is no "correct" until they submit.
 */
export default function Sitting({ attemptId, questions }) {
  // Seeded from what the student already submitted, so resuming after a
  // dropped connection shows their answers instead of a blank paper.
  const [answers, setAnswers] = useState(() => {
    const seed = {};
    for (const q of questions) {
      const prior = q.your_label ?? q.your_response;
      if (prior) seed[q.question_id] = prior;
    }
    return seed;
  });
  const [saving, setSaving] = useState(null);
  const [result, setResult] = useState(null);
  const [confirming, setConfirming] = useState(false);
  const [busy, setBusy] = useState(false);

  async function choose(q, label) {
    setAnswers((s) => ({ ...s, [q.question_id]: label }));
    setSaving(q.question_id);
    await saveTestAnswer(attemptId, q.question_id, label, null);
    setSaving(null);
  }

  async function writeAnswer(q, text) {
    setAnswers((s) => ({ ...s, [q.question_id]: text }));
  }

  async function saveWritten(q) {
    setSaving(q.question_id);
    await saveTestAnswer(attemptId, q.question_id, null, answers[q.question_id] ?? "");
    setSaving(null);
  }

  async function submit() {
    setBusy(true);
    const r = await submitAssessment(attemptId);
    setBusy(false);
    setResult(r);
  }

  if (result) {
    return (
      <div className="notice" style={{ borderLeft: "3px solid var(--green)" }}>
        <h3 style={{ marginTop: 0 }}>Submitted</h3>
        {result.awaitingMarking > 0 ? (
          <p>
            Your multiple choice came to {result.score} out of {result.outOf}.
            {" "}
            {result.awaitingMarking} written{" "}
            {result.awaitingMarking === 1 ? "answer" : "answers"} still need your
            teacher, so this is not your final mark.
          </p>
        ) : (
          <p>
            {result.score} out of {result.outOf}. Whether you see this again
            depends on when your teacher releases the marks.
          </p>
        )}
        <Link className="link" href="/student">Back to my revision</Link>
      </div>
    );
  }

  const answered = questions.filter((q) => answers[q.question_id]).length;

  return (
    <div>
      <div style={{
        position: "sticky", top: 0, zIndex: 2, padding: "10px 0",
        background: "var(--bg)", borderBottom: "1px solid var(--rule, #dbe3ee)",
        marginBottom: 18,
      }}>
        <strong style={{ fontSize: "0.9rem" }}>
          {answered} of {questions.length} answered
        </strong>
        {saving && (
          <span style={{ fontSize: "0.8rem", color: "var(--muted)", marginLeft: 10 }}>
            saving…
          </span>
        )}
      </div>

      {questions.map((q) => (
        <div key={q.question_id} style={{ marginBottom: 30 }}>
          <p style={{ fontSize: "0.8rem", color: "var(--muted)", margin: 0 }}>
            Question {q.sequence} · {q.marks} {Number(q.marks) === 1 ? "mark" : "marks"}
          </p>

          {q.scenario && (
            <div style={{
              padding: "12px 14px", margin: "8px 0",
              background: "rgba(0,0,0,0.025)", borderRadius: 6, lineHeight: 1.65,
              fontFamily: "var(--font-reading), Georgia, serif",
            }}>
              {q.scenario}
            </div>
          )}

          <div style={{
            fontFamily: "var(--font-reading), Georgia, serif",
            fontSize: "1.03rem", lineHeight: 1.6, margin: "8px 0 12px",
          }}>
            {q.question_text}
          </div>

          {q.question_type === "mcq" && (q.options ?? []).map((o) => (
            <label key={o.label} style={{
              display: "flex", gap: 10, alignItems: "flex-start",
              padding: "10px 12px", marginBottom: 8, borderRadius: 8,
              border: "1px solid var(--rule, #dbe3ee)",
              background: answers[q.question_id] === o.label
                ? "var(--cyan-soft)" : "transparent",
              cursor: "pointer",
            }}>
              <input type="radio" name={`q_${q.question_id}`} value={o.label}
                     checked={answers[q.question_id] === o.label}
                     onChange={() => choose(q, o.label)}
                     style={{ width: "auto", marginTop: 3 }} />
              <span><strong style={{ marginRight: 6 }}>{o.label}</strong>{o.text}</span>
            </label>
          ))}

          {q.question_type !== "mcq" && (
            <>
              {(q.parts ?? []).map((p) => (
                <p key={p.id} style={{ fontSize: "0.92rem", margin: "0 0 6px" }}>
                  <strong>{p.label}</strong> {p.prompt}{" "}
                  <span style={{ color: "var(--muted)" }}>({p.marks} marks)</span>
                </p>
              ))}
              <textarea
                rows={6}
                defaultValue={q.your_response ?? ""}
                onChange={(e) => writeAnswer(q, e.target.value)}
                onBlur={() => saveWritten(q)}
                placeholder="Write your answer here. It saves when you tap away."
                style={{ width: "100%", font: "inherit", lineHeight: 1.6 }}
              />
            </>
          )}
        </div>
      ))}

      {!confirming ? (
        <button className="primary" onClick={() => setConfirming(true)}>
          Finish and submit
        </button>
      ) : (
        <div className="notice" style={{ borderLeft: "3px solid var(--gold)" }}>
          <h3 style={{ marginTop: 0 }}>Submit this test?</h3>
          <p>
            You have answered {answered} of {questions.length}. You cannot come
            back to it afterwards.
          </p>
          <div style={{ display: "flex", gap: 12, alignItems: "center" }}>
            <button className="primary" onClick={submit} disabled={busy}>
              {busy ? "Submitting…" : "Yes, submit"}
            </button>
            <button className="link" onClick={() => setConfirming(false)}>
              Not yet
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
