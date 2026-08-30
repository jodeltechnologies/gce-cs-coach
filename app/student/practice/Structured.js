"use client";

import { useState } from "react";
import { submitPart } from "../actions";

/**
 * Structured questions: a scenario, then parts worth marks.
 *
 * Nothing is scored. The student writes an answer, presses a button, and gets
 * the model answer and the mark allocation to compare against. The button is
 * deliberately not available until something has been written — reading the
 * model answer first is the habit this is meant to break, and making it easy
 * would guarantee it.
 */
export default function Structured({ attemptId, questions }) {
  const [qi, setQi] = useState(0);
  const q = questions[qi];
  const [responses, setResponses] = useState({});
  const [revealed, setRevealed] = useState({});
  const [busy, setBusy] = useState(null);

  if (!q) return null;
  const parts = q.parts ?? [];

  async function reveal(part) {
    const written = (responses[part.id] ?? "").trim();
    if (!written || busy) return;
    setBusy(part.id);
    const r = await submitPart(attemptId, part.id, written);
    setBusy(null);
    setRevealed((s) => ({ ...s, [part.id]: r }));
  }

  const answeredAll = parts.every((p) => revealed[p.id]);

  return (
    <div>
      <p style={{ fontSize: "0.82rem", color: "var(--muted)" }}>
        Question {qi + 1} of {questions.length}
        {q.lesson_title ? ` · ${q.lesson_title}` : ""}
        {q.source_paper ? ` · ${q.source_paper}` : ""}
        {q.marks ? ` · ${q.marks} marks` : ""}
      </p>

      {q.scenario && (
        <div
          style={{
            padding: "14px 16px",
            background: "rgba(0,0,0,0.025)",
            borderLeft: "3px solid var(--gold, #c9a227)",
            borderRadius: "0 6px 6px 0",
            margin: "12px 0 20px",
            lineHeight: 1.7,
            fontFamily: "var(--font-reading), Georgia, serif",
          }}
        >
          {q.scenario}
        </div>
      )}

      {parts.map((p) => {
        const shown = revealed[p.id];
        const written = responses[p.id] ?? "";
        return (
          <div key={p.id} style={{ marginBottom: 26 }}>
            <div style={{ display: "flex", gap: 8, alignItems: "baseline" }}>
              <strong>{p.label}</strong>
              <span style={{ flex: 1 }}>{p.prompt}</span>
              <span style={{ fontSize: "0.82rem", color: "var(--muted)",
                             whiteSpace: "nowrap" }}>
                {p.marks} marks
              </span>
            </div>

            {p.hint && !shown && (
              <p style={{ fontSize: "0.82rem", color: "var(--muted)", margin: "6px 0 0" }}>
                {p.hint}
              </p>
            )}

            <textarea
              rows={Math.max(3, Math.round(Number(p.marks) || 3))}
              value={written}
              disabled={Boolean(shown)}
              onChange={(e) =>
                setResponses((s) => ({ ...s, [p.id]: e.target.value }))
              }
              placeholder="Write your answer here, as you would in the exam."
              style={{ width: "100%", marginTop: 8, font: "inherit",
                       lineHeight: 1.6 }}
            />

            {!shown && (
              <button
                className="primary"
                onClick={() => reveal(p)}
                disabled={!written.trim() || busy === p.id}
                style={{ marginTop: 8 }}
              >
                {busy === p.id ? "Saving…" : "Compare with the answer"}
              </button>
            )}

            {shown?.modelAnswer && (
              <div
                style={{
                  marginTop: 12,
                  padding: "12px 14px",
                  border: "1px solid var(--rule, #e5e2dc)",
                  borderRadius: 6,
                }}
              >
                <p style={{ fontWeight: 600, margin: "0 0 8px", fontSize: "0.9rem" }}>
                  What the marker is looking for
                </p>
                <ul style={{ margin: 0, paddingLeft: 20, lineHeight: 1.65 }}>
                  {String(shown.modelAnswer)
                    .split("\n")
                    .filter((l) => l.trim())
                    .map((l, i) => (
                      <li key={i} style={{ marginBottom: 4 }}>{l}</li>
                    ))}
                </ul>
                <p style={{ fontSize: "0.82rem", color: "var(--muted)",
                            margin: "10px 0 0" }}>
                  Count how many of these points you made. That is roughly your
                  mark out of {p.marks}.
                </p>
              </div>
            )}
          </div>
        );
      })}

      <div style={{ display: "flex", gap: 14, alignItems: "center", marginTop: 10 }}>
        {qi + 1 < questions.length ? (
          <button
            className="primary"
            onClick={() => { setQi(qi + 1); setRevealed({}); setResponses({}); }}
            disabled={!answeredAll}
          >
            Next question
          </button>
        ) : (
          <a className="link" href="/student/practice" style={{ fontSize: "0.9rem" }}>
            Choose something else
          </a>
        )}
        {!answeredAll && (
          <span style={{ fontSize: "0.82rem", color: "var(--muted)" }}>
            Answer every part first.
          </span>
        )}
      </div>

      <p style={{ fontSize: "0.8rem", color: "var(--muted)", marginTop: 20 }}>
        Structured answers are not scored automatically — a paragraph cannot be
        marked by a computer. What you write is saved so your teacher can read
        it.
      </p>
    </div>
  );
}
