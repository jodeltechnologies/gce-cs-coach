"use client";

import { useActionState } from "react";
import { addStudent } from "./actions";

/**
 * The add-student form, with whatever the database said about the attempt.
 *
 * A server action that returns nothing gives the teacher a page that reloads
 * and looks identical whether the student was saved or the write was refused.
 * This shows the outcome either way, and shows the new login code on success
 * so it can be written on the register straight away rather than hunted for
 * in the list afterwards.
 */
export default function AddStudentForm({ classes, defaultClass }) {
  const [state, action, pending] = useActionState(addStudent, {});

  return (
    <form action={action} style={{ maxWidth: 460 }}>
      {state?.error && (
        <div className="notice bad" style={{ marginBottom: 14 }}>
          <h3 style={{ marginTop: 0 }}>Not saved</h3>
          <p style={{ marginBottom: 0 }}>{state.error}</p>
        </div>
      )}

      {state?.ok && (
        <div
          className="notice"
          style={{ borderLeft: "3px solid var(--green)", marginBottom: 14 }}
        >
          <h3 style={{ marginTop: 0 }}>{state.ok}</h3>
          {state.code && (
            <p style={{ marginBottom: 0 }}>
              Login code:{" "}
              <strong style={{ fontFamily: "ui-monospace, monospace" }}>
                {state.code}
              </strong>{" "}
              — write this on the register now; it is how the student signs in.
            </p>
          )}
        </div>
      )}

      <label className="field">
        <span>Full name</span>
        <input type="text" name="full_name" required placeholder="Ngwa Divine Besong" />
      </label>

      <label className="field">
        <span>Enrol into</span>
        <select name="class_id" defaultValue={defaultClass ?? ""}>
          <option value="">Not yet — add to the roll only</option>
          {(classes ?? []).map((c) => (
            <option key={c.id} value={c.id}>
              {c.name} · {c.academic_year}
            </option>
          ))}
        </select>
      </label>

      <div style={{ display: "flex", gap: 12 }}>
        <label className="field" style={{ flex: 1 }}>
          <span>Matricule</span>
          <input type="text" name="matricule" placeholder="MBJ/2024/0187" />
        </label>
        <label className="field" style={{ width: 110 }}>
          <span>Sex</span>
          <select name="sex" defaultValue="">
            <option value="">—</option>
            <option value="F">F</option>
            <option value="M">M</option>
          </select>
        </label>
      </div>

      <label className="field">
        <span>Date of birth</span>
        <input type="text" name="date_of_birth" placeholder="2008-03-14" />
      </label>

      <label className="field">
        <span>Guardian name</span>
        <input type="text" name="guardian_name" />
      </label>

      <div style={{ display: "flex", gap: 12 }}>
        <label className="field" style={{ flex: 1 }}>
          <span>Guardian phone</span>
          <input type="text" name="guardian_phone" placeholder="6xx xx xx xx" />
        </label>
        <label className="field" style={{ flex: 1 }}>
          <span>Student phone</span>
          <input type="text" name="student_phone" />
        </label>
      </div>

      <button className="primary" type="submit" disabled={pending}>
        {pending ? "Saving…" : "Add student"}
      </button>
    </form>
  );
}
