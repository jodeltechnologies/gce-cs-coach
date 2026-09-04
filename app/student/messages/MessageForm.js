"use client";

import { useActionState, useEffect, useRef } from "react";
import { sendMessage } from "../actions";

export default function MessageForm({ lessonId = null, sectionId = null, compact = false }) {
  const [state, action, pending] = useActionState(sendMessage, {});
  const box = useRef(null);

  // Clear the box once the message is away, so a student who taps send twice
  // does not send the same paragraph twice.
  useEffect(() => {
    if (state?.sent && box.current) box.current.value = "";
  }, [state?.sent]);

  return (
    <form action={action} style={{ marginTop: compact ? 12 : 24 }}>
      {lessonId && <input type="hidden" name="lesson_id" value={lessonId} />}
      {sectionId && <input type="hidden" name="note_section_id" value={sectionId} />}

      <label htmlFor="body" className="field-label">
        {compact ? "Ask your teacher about this note" : "Write your message"}
      </label>
      <textarea
        id="body"
        name="body"
        ref={box}
        rows={compact ? 3 : 5}
        placeholder="Which lesson, and what part of it lost you?"
        required
      />

      <div style={{ display: "flex", alignItems: "center", gap: 12, marginTop: 10 }}>
        <button className="btn" type="submit" disabled={pending}>
          {pending ? "Sending" : "Send"}
        </button>
        {state?.sent && (
          <span style={{ color: "var(--green)", fontSize: "0.88rem" }}>
            Sent. Your teacher will see it on their page.
          </span>
        )}
        {state?.error && (
          <span style={{ color: "var(--red)", fontSize: "0.88rem" }}>
            {state.error}
          </span>
        )}
      </div>
    </form>
  );
}
