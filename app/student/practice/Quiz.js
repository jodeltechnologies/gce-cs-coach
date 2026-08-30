"use client";

import { useState } from "react";
import { checkAnswer } from "../actions";

/**
 * Ten questions, marked one at a time.
 *
 * The correct answer is never sent to the browser with the question. It is
 * asked for after the student has chosen, because anything in the page is
 * readable by anyone who knows where to look, and a practice test whose
 * answers are in the page source is not practice.
 */
export default function Quiz({ questions }) {
  const [i, setI] = useState(0);
  const [chosen, setChosen] = useState("");
  const [result, setResult] = useState(null);
  const [score, setScore] = useState(0);
  const [busy, setBusy] = useState(false);

  const q = questions[i];
  const done = i >= questions.length;

  if (done) {
    return (
      <div className="notice" style={{ borderLeft: "3px solid var(--green)" }}>
        <h3 style={{ marginTop: 0 }}>
          {score} out of {questions.length}
        </h3>
        <p>
          {score === questions.length
            ? "All correct. Try another set."
            : "Go back over the ones you missed in the notes, then try again."}
        </p>
        <button className="primary" onClick={() => window.location.reload()}>
          Another ten
        </button>
      </div>
    );
  }

  async function submit() {
    if (!chosen || busy) return;
    setBusy(true);
    const r = await checkAnswer(q.question_id, chosen);
    setBusy(false);
    if (r.error) {
      setResult({ error: r.error });
      return;
    }
    setResult(r);
    if (r.correct) setScore((s) => s + 1);
  }

  function next() {
    setI((n) => n + 1);
    setChosen("");
    setResult(null);
  }

  return (
    <div>
      <p style={{ fontSize: "0.82rem", color: "var(--muted)" }}>
        Question {i + 1} of {questions.length}
        {q.lesson_title ? ` · ${q.lesson_title}` : ""}
      </p>

      <div
        style={{
          fontFamily: "var(--font-reading), Georgia, serif",
          fontSize: "1.05rem",
          lineHeight: 1.6,
          margin: "10px 0 16px",
        }}
      >
        {q.question_text}
      </div>

      {(q.options ?? []).map((o) => {
        const isChosen = chosen === o.label;
        const isRight = result && result.correctLabel === o.label;
        const isWrongPick = result && isChosen && !result.correct;
        return (
          <label
            key={o.label}
            style={{
              display: "flex",
              gap: 10,
              alignItems: "flex-start",
              padding: "10px 12px",
              marginBottom: 8,
              borderRadius: 8,
              border: "1px solid var(--rule, #e5e2dc)",
              background: isRight
                ? "rgba(40,140,80,0.10)"
                : isWrongPick
                ? "rgba(190,60,60,0.10)"
                : isChosen
                ? "rgba(0,0,0,0.03)"
                : "transparent",
              cursor: result ? "default" : "pointer",
            }}
          >
            <input
              type="radio"
              name="answer"
              value={o.label}
              checked={isChosen}
              disabled={Boolean(result)}
              onChange={() => setChosen(o.label)}
              style={{ width: "auto", marginTop: 3 }}
            />
            <span>
              <strong style={{ marginRight: 6 }}>{o.label}</strong>
              {o.text}
            </span>
          </label>
        );
      })}

      {!result && (
        <button className="primary" onClick={submit} disabled={!chosen || busy}>
          {busy ? "Checking…" : "Check"}
        </button>
      )}

      {result?.error && (
        <div className="notice bad" style={{ marginTop: 12 }}>
          <p style={{ margin: 0 }}>{result.error}</p>
        </div>
      )}

      {result && !result.error && (
        <div style={{ marginTop: 14 }}>
          <p style={{ fontWeight: 600, marginBottom: 6 }}>
            {result.correct ? "Correct." : `Not this time — the answer is ${result.correctLabel}.`}
          </p>

          {/* Why their own choice was wrong comes first. A student who picked
              the Control Bus needs that specific correction more than they
              need the general explanation. */}
          {!result.correct && result.yourFeedback && (
            <p
              style={{
                fontSize: "0.9rem",
                margin: "0 0 8px",
                padding: "9px 12px",
                borderLeft: "3px solid var(--gold, #c9a227)",
                background: "rgba(0,0,0,0.02)",
              }}
            >
              {result.yourFeedback}
            </p>
          )}

          {result.explanation && (
            <p style={{ fontSize: "0.9rem", color: "var(--muted)", marginTop: 0 }}>
              {result.explanation}
            </p>
          )}
          <button className="primary" onClick={next}>
            {i + 1 === questions.length ? "See my score" : "Next question"}
          </button>
        </div>
      )}
    </div>
  );
}
