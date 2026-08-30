"use client";

import Link from "next/link";
import { useState } from "react";
import { approveQuestion, rejectQuestion } from "../actions";
import QuestionFigure from "../QuestionFigure";

/**
 * One question, checked in place.
 *
 * The whole point of this screen is that confirming a correct question costs
 * one tap. If it needed a round trip to the edit form it would not get done:
 * there are several hundred of these and the teacher has a timetable to teach.
 * So the common case — the text is fine, pick the answer, confirm — happens
 * here, and only genuinely broken ones are sent to the full editor.
 */
export default function ReviewCard({ question: q, notes }) {
  const options = [...(q.question_options ?? [])].sort(
    (a, b) => a.sequence - b.sequence
  );
  const [correct, setCorrect] = useState(
    options.find((o) => o.is_correct)?.label ?? ""
  );
  const [busy, setBusy] = useState(false);

  const isMcq = q.question_type === "mcq";
  // Flags about the proposed answer are shown by the badge below, so listing
  // them again as warnings would be noise.
  const flags = (q.import_flags ?? []).filter(
    (f) => !f.startsWith("answer_proposed_")
  );
  const proposed = q.answer_origin === "proposed";
  const printed = q.answer_origin === "printed";
  // Confirming an MCQ without saying which option is right would create a
  // question that marks every student wrong.
  const canApprove = !isMcq || correct !== "";

  return (
    <div className="row" style={{ display: "block", marginBottom: 14 }}>
      <div
        className="name"
        style={{
          fontFamily: "var(--font-reading), Georgia, serif",
          lineHeight: 1.55,
        }}
      >
        {q.question_text}
      </div>

      <QuestionFigure name={q.figure_name} />

      {isMcq && (proposed || printed) && (
        <p
          style={{
            fontSize: "0.8rem",
            color: "var(--muted)",
            margin: "10px 0 0",
          }}
        >
          {printed
            ? "Answer taken from the key printed on the source page."
            : q.answer_confidence === "high"
            ? "No answer was printed. The one selected below was worked out from the syllabus — check it and confirm."
            : "No answer was printed. The one selected below was worked out from the syllabus, but this question is ambiguous enough to be worth reading carefully."}
        </p>
      )}

      {isMcq && (
        <div style={{ marginTop: 10 }}>
          {options.map((o) => (
            <label
              key={o.id}
              style={{
                display: "flex",
                gap: 9,
                alignItems: "flex-start",
                padding: "5px 0",
                fontSize: "0.9rem",
                cursor: "pointer",
              }}
            >
              <input
                type="radio"
                name={`correct_${q.id}`}
                value={o.label}
                checked={correct === o.label}
                onChange={() => setCorrect(o.label)}
                style={{ width: "auto", marginTop: 3 }}
              />
              <span>
                <strong style={{ marginRight: 6 }}>{o.label}</strong>
                {o.option_text}
              </span>
            </label>
          ))}
        </div>
      )}

      {flags.length > 0 && (
        <ul
          style={{
            margin: "12px 0 0",
            paddingLeft: 18,
            fontSize: "0.82rem",
            color: "var(--muted)",
          }}
        >
          {flags.map((f) => (
            <li key={f} style={{ marginBottom: 3 }}>
              {notes[f] ?? f}
            </li>
          ))}
        </ul>
      )}

      <div className="tags" style={{ marginTop: 10 }}>
        <span className="tag plain">{q.marks} marks</span>
        {q.import_page && (
          <span className="tag plain">Pamphlet p.{q.import_page}</span>
        )}
        {proposed && (
          <span className={q.answer_confidence === "high" ? "tag" : "tag alert"}>
            {q.answer_confidence === "high"
              ? "Answer proposed"
              : "Answer proposed — check"}
          </span>
        )}
        {q.source_year ? (
          <span className="tag gold">
            {q.source === "mock" ? "Mock" : "GCE"} {q.source_year}
            {q.source_paper ? ` ${q.source_paper}` : ""}
          </span>
        ) : (
          <span className="tag plain">Year not established</span>
        )}
      </div>

      <div
        style={{
          display: "flex",
          gap: 10,
          alignItems: "center",
          flexWrap: "wrap",
          marginTop: 14,
        }}
      >
        <form
          action={async (fd) => {
            setBusy(true);
            await approveQuestion(fd);
            setBusy(false);
          }}
        >
          <input type="hidden" name="question_id" value={q.id} />
          <input type="hidden" name="correct_label" value={correct} />
          <button
            type="submit"
            disabled={!canApprove || busy}
            style={{
              padding: "8px 18px",
              borderRadius: 8,
              border: "none",
              background: canApprove ? "var(--green)" : "var(--rule, #ddd)",
              color: canApprove ? "#fff" : "var(--muted)",
              fontWeight: 600,
              fontSize: "0.88rem",
              cursor: canApprove ? "pointer" : "not-allowed",
            }}
          >
            {busy ? "Saving…" : "Correct — add to bank"}
          </button>
        </form>

        <Link
          className="link"
          href={`/admin/questions/${q.id}`}
          style={{ fontSize: "0.86rem" }}
        >
          Needs editing
        </Link>

        <form
          action={async (fd) => {
            setBusy(true);
            await rejectQuestion(fd);
            setBusy(false);
          }}
        >
          <input type="hidden" name="question_id" value={q.id} />
          <button
            className="link"
            type="submit"
            disabled={busy}
            style={{ color: "var(--red)", fontSize: "0.86rem" }}
          >
            Too damaged — remove
          </button>
        </form>
      </div>

      {isMcq && !canApprove && (
        <p style={{ fontSize: "0.8rem", color: "var(--muted)", marginTop: 8 }}>
          Choose the correct option before confirming.
        </p>
      )}
    </div>
  );
}
