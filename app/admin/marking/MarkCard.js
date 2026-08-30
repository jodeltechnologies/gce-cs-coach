"use client";

import { useActionState, useState } from "react";
import { markAnswer } from "./actions";

/**
 * One written answer, with the model answer beside it.
 *
 * The model answer is shown collapsed by default and opens on click. Marking
 * forty scripts means reading the same mark scheme forty times, and having it
 * permanently expanded pushes the student's actual words off the screen —
 * which is the thing being marked.
 */
export default function MarkCard({ item }) {
  const [state, action, pending] = useActionState(markAnswer, {});
  const [showModel, setShowModel] = useState(false);

  const parts = item.parts ?? [];
  const total = Number(item.total_marks ?? 0);
  const marked = Boolean(item.marked_at) || Boolean(state?.ok);

  return (
    <div
      className="row"
      style={{
        display: "block",
        marginBottom: 16,
        opacity: marked && !state?.ok ? 0.72 : 1,
      }}
    >
      <div style={{ display: "flex", justifyContent: "space-between", gap: 12 }}>
        <div className="name">{item.student_name}</div>
        <span style={{ fontSize: "0.8rem", color: "var(--muted)" }}>
          {item.class_name ?? "no class"}
        </span>
      </div>

      <p style={{ fontSize: "0.84rem", color: "var(--muted)", margin: "4px 0 10px" }}>
        {item.question_title}
        {item.source_paper ? ` · ${item.source_paper}` : ""}
        {total ? ` · ${total} marks` : ""}
      </p>

      {item.scenario && (
        <details style={{ marginBottom: 10 }}>
          <summary style={{ cursor: "pointer", fontSize: "0.84rem" }}>
            The scenario they were given
          </summary>
          <div style={{
            padding: "10px 12px", marginTop: 8, fontSize: "0.88rem",
            background: "rgba(0,0,0,0.02)", borderRadius: 6, lineHeight: 1.65,
          }}>
            {item.scenario}
          </div>
        </details>
      )}

      {/* What the student wrote, kept in a reading face and preserving their
          line breaks, because the labels (a), (b) are part of the answer. */}
      <div
        style={{
          whiteSpace: "pre-wrap",
          fontFamily: "var(--font-reading), Georgia, serif",
          lineHeight: 1.7,
          padding: "12px 14px",
          border: "1px solid var(--rule, #dbe3ee)",
          borderRadius: 8,
          background: "var(--surface)",
        }}
      >
        {item.response_text}
      </div>

      {parts.length > 0 && (
        <div style={{ marginTop: 10 }}>
          <button
            className="link"
            onClick={() => setShowModel((v) => !v)}
            style={{ fontSize: "0.84rem" }}
          >
            {showModel ? "Hide the mark scheme" : "Show the mark scheme"}
          </button>
          {showModel && (
            <div style={{
              marginTop: 8, padding: "12px 14px", fontSize: "0.88rem",
              border: "1px solid var(--cyan)", borderRadius: 8,
              background: "var(--cyan-soft)",
            }}>
              {parts.map((p, i) => (
                <div key={i} style={{ marginBottom: 10 }}>
                  <strong>{p.label}</strong> {p.prompt}{" "}
                  <span style={{ color: "var(--muted)" }}>({p.marks} marks)</span>
                  {p.model_answer && (
                    <ul style={{ margin: "4px 0 0", paddingLeft: 20 }}>
                      {String(p.model_answer)
                        .split("\n")
                        .filter((l) => l.trim())
                        .map((l, j) => <li key={j}>{l}</li>)}
                    </ul>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {state?.error && (
        <p style={{ color: "var(--red)", fontSize: "0.86rem", margin: "10px 0 0" }}>
          {state.error}
        </p>
      )}

      <form action={action} style={{ marginTop: 12 }}>
        <input type="hidden" name="answer_id" value={item.answer_id} />
        <input type="hidden" name="total" value={total} />
        <div style={{ display: "flex", gap: 10, alignItems: "flex-end", flexWrap: "wrap" }}>
          <label className="field" style={{ width: 110, marginBottom: 0 }}>
            <span>Mark{total ? ` / ${total}` : ""}</span>
            <input
              type="number" name="marks" min="0" max={total || undefined}
              step="0.5" required
              defaultValue={item.marks_awarded ?? ""}
            />
          </label>
          <label className="field" style={{ flex: 1, minWidth: 200, marginBottom: 0 }}>
            <span>Comment</span>
            <input
              type="text" name="feedback"
              defaultValue={item.feedback ?? ""}
              placeholder="What would move this up a mark?"
            />
          </label>
          <button className="primary" type="submit" disabled={pending}>
            {pending ? "Saving…" : marked ? "Update" : "Save mark"}
          </button>
        </div>
      </form>

      {(state?.ok || item.marked_at) && (
        <p style={{ fontSize: "0.8rem", color: "var(--muted)", margin: "8px 0 0" }}>
          {state?.ok ??
            `Marked ${item.marks_awarded} out of ${total}. The student can see this.`}
        </p>
      )}
    </div>
  );
}
