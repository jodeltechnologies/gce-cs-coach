"use client";

import { useActionState } from "react";
import { createAssessment } from "./actions";

/**
 * One form that creates the test and fills it.
 *
 * The topic list shows how many checked questions sit behind each lesson, so
 * asking for twenty questions on a topic that has six is a visible mistake
 * rather than a silent short paper.
 */
export default function NewAssessment({ classes, lessons }) {
  const [state, action, pending] = useActionState(createAssessment, {});

  return (
    <form action={action} style={{ maxWidth: 520 }}>
      {state?.error && (
        <div className="notice bad" style={{ marginBottom: 14 }}>
          <p style={{ margin: 0 }}>{state.error}</p>
        </div>
      )}

      <label className="field">
        <span>Title</span>
        <input type="text" name="title" required
               placeholder="Logic gates — end of week test" />
      </label>

      <div style={{ display: "flex", gap: 12 }}>
        <label className="field" style={{ flex: 1 }}>
          <span>Class</span>
          <select name="class_id" required defaultValue="">
            <option value="" disabled>Choose…</option>
            {classes.map((c) => (
              <option key={c.id} value={c.id}>{c.name} · {c.academic_year}</option>
            ))}
          </select>
        </label>
        <label className="field" style={{ width: 150 }}>
          <span>Kind</span>
          <select name="kind" defaultValue="quiz">
            <option value="quiz">Quiz</option>
            <option value="homework">Homework</option>
            <option value="class_test">Class test</option>
            <option value="mock_exam">Mock exam</option>
          </select>
        </label>
      </div>

      <label className="field">
        <span>Questions from</span>
        <select name="lesson_id" defaultValue="">
          <option value="">Anywhere in the syllabus</option>
          {lessons.map((l) => (
            <option key={l.id} value={l.id}>{l.title} ({l.n})</option>
          ))}
        </select>
      </label>

      <div style={{ display: "flex", gap: 12 }}>
        <label className="field" style={{ width: 130 }}>
          <span>How many</span>
          <select name="count" defaultValue="10">
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="30">30</option>
          </select>
        </label>
        <label className="field" style={{ width: 150 }}>
          <span>Time limit</span>
          <select name="duration" defaultValue="">
            <option value="">No limit</option>
            <option value="15">15 minutes</option>
            <option value="30">30 minutes</option>
            <option value="45">45 minutes</option>
            <option value="60">1 hour</option>
          </select>
        </label>
        <label className="field" style={{ flex: 1 }}>
          <span>Closes</span>
          <input type="date" name="closes_at" />
        </label>
      </div>

      <label className="field">
        <span>Students see their marks</span>
        <select name="show_results" defaultValue="after_close">
          <option value="after_close">After the test closes</option>
          <option value="immediately">As soon as they submit</option>
          <option value="manual">Only when I release them</option>
          <option value="never">Never</option>
        </select>
      </label>

      <label style={{ display: "flex", gap: 8, alignItems: "center",
                      fontSize: "0.88rem", marginBottom: 14 }}>
        <input type="checkbox" name="structured" style={{ width: "auto" }} />
        Include Paper 2 questions (you will have to mark these yourself)
      </label>

      <button className="primary" type="submit" disabled={pending}>
        {pending ? "Setting…" : "Set the test"}
      </button>
      <p style={{ fontSize: "0.8rem", color: "var(--muted)", marginTop: 10 }}>
        Questions are chosen now and fixed, so every student sits the same
        paper. Only questions you have already checked are used.
      </p>
    </form>
  );
}
