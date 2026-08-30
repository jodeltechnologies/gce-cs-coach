"use client";

import { useEffect, useRef, useState } from "react";
import { checkAnswer, finishPractice } from "../actions";

/**
 * Ten questions, marked one at a time.
 *
 * The correct answer is never sent to the browser with the question. It is
 * asked for after the student has chosen, because anything in the page is
 * readable by anyone who knows where to look, and a practice test whose
 * answers are in the page source is not practice.
 */
export default function Quiz({ attemptId, questions, seconds = 0 }) {
  const [i, setI] = useState(0);
  const [chosen, setChosen] = useState("");
  const [result, setResult] = useState(null);
  const [score, setScore] = useState(0);
  const [busy, setBusy] = useState(false);
  const [left, setLeft] = useState(seconds);
  const submitRef = useRef(null);

  const q = questions[i];

  // The timer marks the question when it runs out rather than skipping it, so
  // running out of time is a wrong answer and not a gap in the record. With no
  // option chosen it submits nothing and simply moves on.
  useEffect(() => {
    if (!seconds || !q || result) return;
    setLeft(seconds);
    const id = setInterval(() => {
      setLeft((t) => {
        if (t <= 1) {
          clearInterval(id);
          submitRef.current?.();
          return 0;
        }
        return t - 1;
      });
    }, 1000);
    return () => clearInterval(id);
  }, [i, seconds, result, q]);
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
        <div style={{ display: "flex", gap: 14, alignItems: "center" }}>
          <button className="primary" onClick={() => window.location.reload()}>
            Another ten
          </button>
          <a className="link" href="/student" style={{ fontSize: "0.88rem" }}>
            See what to revise
          </a>
        </div>
      </div>
    );
  }

  async function submit() {
    if (busy) return;
    if (!chosen) {
      // Out of time with nothing selected: record nothing, show the answer.
      setResult({ correct: false, correctLabel: null, timedOut: true });
      return;
    }
    setBusy(true);
    const r = await checkAnswer(attemptId, q.question_id, chosen);
    setBusy(false);
    if (r.error) {
      setResult({ error: r.error });
      return;
    }
    setResult(r);
    if (r.correct) setScore((s) => s + 1);
  }

  async function next() {
    const last = i + 1 >= questions.length;
    setI((n) => n + 1);
    setChosen("");
    setResult(null);
    // Closing the attempt is what turns ten answers into a score and refreshes
    // the weak-topic list on the way out.
    if (last) await finishPractice(attemptId);
  }

  submitRef.current = submit;

  return (
    <div>
      <div style={{ display: "flex", justifyContent: "space-between",
                    alignItems: "baseline", gap: 10 }}>
        <p style={{ fontSize: "0.82rem", color: "var(--muted)" }}>
          Question {i + 1} of {questions.length}
          {q.lesson_title ? ` · ${q.lesson_title}` : ""}
        </p>
        {seconds > 0 && !result && (
          <span
            style={{
              fontSize: "0.86rem",
              fontVariantNumeric: "tabular-nums",
              fontWeight: 600,
              color: left <= 10 ? "var(--red)" : "var(--muted)",
            }}
          >
            {left}s
          </span>
        )}
      </div>

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
            {result.timedOut
              ? "Time ran out on that one."
              : result.correct
              ? "Correct."
              : `Not this time — the answer is ${result.correctLabel}.`}
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
