"use client";

import { useActionState, useState } from "react";
import { importStudents } from "./actions";

/**
 * Import a class list.
 *
 * Deliberately forgiving about what it is given. A teacher has a register in
 * Excel, or a column of names they can copy, and the shape it arrives in is
 * not something they should have to think about: the columns are matched by
 * their headings, and a list with no headings at all is read as names.
 *
 * The result is reported name by name. A bulk import that says "34 imported"
 * and nothing else leaves the teacher to work out which six are missing.
 */
export default function ImportStudents({ classes, defaultClass }) {
  const [state, action, pending] = useActionState(importStudents, {});
  const [open, setOpen] = useState(false);

  if (!open) {
    return (
      <button
        className="link"
        onClick={() => setOpen(true)}
        style={{ fontSize: "0.88rem", fontWeight: 600, padding: 0 }}
      >
        Import a class list from Excel
      </button>
    );
  }

  return (
    <div style={{ maxWidth: 520 }}>
      {state?.error && (
        <div className="notice bad" style={{ marginBottom: 14 }}>
          <p style={{ margin: 0 }}>{state.error}</p>
        </div>
      )}

      {state?.added && (
        <div
          className="notice"
          style={{ borderLeft: "3px solid var(--green)", marginBottom: 14 }}
        >
          <h3 style={{ marginTop: 0 }}>
            {state.added.length} added
            {state.skipped.length > 0 ? `, ${state.skipped.length} skipped` : ""}
          </h3>

          {state.added.length > 0 && (
            <>
              <p style={{ marginBottom: 6 }}>
                Write these codes on the register — each student needs theirs to
                sign in.
              </p>
              <ul style={{ margin: "0 0 10px", paddingLeft: 18, fontSize: "0.86rem" }}>
                {state.added.map((a) => (
                  <li key={a.code}>
                    {a.name} —{" "}
                    <strong style={{ fontFamily: "ui-monospace, monospace" }}>
                      {a.code}
                    </strong>
                  </li>
                ))}
              </ul>
            </>
          )}

          {state.skipped.length > 0 && (
            <>
              <p style={{ marginBottom: 6, fontSize: "0.86rem" }}>Not added:</p>
              <ul style={{ margin: 0, paddingLeft: 18, fontSize: "0.86rem",
                           color: "var(--muted)" }}>
                {state.skipped.map((s, i) => (
                  <li key={i}>
                    {s.name} — {s.why}
                  </li>
                ))}
              </ul>
            </>
          )}
        </div>
      )}

      <form action={action}>
        <p style={{ fontSize: "0.86rem", color: "var(--muted)", marginTop: 0 }}>
          An .xlsx or .csv file, or paste a column of names straight from Excel.
          Columns named Name, Matricule, Sex, Date of birth, Guardian and Phone
          are picked up automatically; a list with no headings is read as names.
        </p>

        <label className="field">
          <span>Enrol everyone into</span>
          <select name="class_id" defaultValue={defaultClass ?? ""}>
            <option value="">Not yet — add to the roll only</option>
            {(classes ?? []).map((c) => (
              <option key={c.id} value={c.id}>
                {c.name} · {c.academic_year}
              </option>
            ))}
          </select>
        </label>

        <label className="field">
          <span>Excel or CSV file</span>
          <input type="file" name="file" accept=".xlsx,.xlsm,.csv,.txt,.tsv" />
        </label>

        <label className="field">
          <span>…or paste the names</span>
          <textarea
            name="pasted"
            rows={6}
            placeholder={"Ngwa Divine Besong\nTabi Peter Arrey\nEpee Manga Sarah"}
            style={{ fontFamily: "inherit" }}
          />
        </label>

        <div style={{ display: "flex", gap: 12, alignItems: "center" }}>
          <button className="primary" type="submit" disabled={pending}>
            {pending ? "Importing…" : "Import"}
          </button>
          <button
            className="link"
            type="button"
            onClick={() => setOpen(false)}
            style={{ fontSize: "0.86rem" }}
          >
            Close
          </button>
        </div>

        <p style={{ fontSize: "0.8rem", color: "var(--muted)", marginTop: 10 }}>
          Safe to run twice: a student already on the roll is skipped, not
          duplicated.
        </p>
      </form>
    </div>
  );
}
