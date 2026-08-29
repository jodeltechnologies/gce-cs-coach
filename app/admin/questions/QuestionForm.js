"use client";

import { useState } from "react";

const TYPES = [
  { value: "mcq", label: "Multiple choice" },
  { value: "true_false", label: "True or false" },
  { value: "short_answer", label: "Short answer" },
  { value: "structured", label: "Structured" },
  { value: "algorithm", label: "Algorithm / pseudocode" },
  { value: "flowchart", label: "Flowchart" },
  { value: "trace_table", label: "Trace table" },
  { value: "practical", label: "Practical" },
];

const AUTO = new Set(["mcq", "true_false"]);

/**
 * One form for both adding and editing.
 *
 * It is a client component only because the option boxes have to appear and
 * disappear as the question type changes. Everything it submits goes to a
 * server action, so the database still decides whether the save is allowed.
 */
export default function QuestionForm({
  action,
  syllabi,
  lessons,
  question = null,
  options = [],
  taggedLessonIds = [],
}) {
  const [type, setType] = useState(question?.question_type ?? "structured");
  const [syllabusId, setSyllabusId] = useState(
    question?.syllabus_id ?? syllabi[0]?.id ?? ""
  );

  const byLabel = Object.fromEntries(options.map((o) => [o.label, o]));
  const correctMcq = options.find((o) => o.is_correct)?.label ?? "A";
  const correctTf = options.find((o) => o.is_correct)?.option_text === "False"
    ? "false"
    : "true";

  const visibleLessons = lessons.filter((l) => l.syllabus_id === syllabusId);

  return (
    <form action={action}>
      {question && <input type="hidden" name="question_id" value={question.id} />}

      <label className="field">
        <span>Level</span>
        <select
          name="syllabus_id"
          value={syllabusId}
          onChange={(e) => setSyllabusId(e.target.value)}
        >
          {syllabi.map((s) => (
            <option key={s.id} value={s.id}>
              {s.form_level}
            </option>
          ))}
        </select>
      </label>

      <label className="field">
        <span>Question</span>
        <textarea
          name="question_text"
          defaultValue={question?.question_text ?? ""}
          required
          style={{ minHeight: 130, fontFamily: "var(--font-reading), Georgia, serif", lineHeight: 1.6 }}
          placeholder="Write an algorithm to calculate the average of five numbers."
        />
      </label>

      <div style={{ display: "flex", gap: 12, flexWrap: "wrap" }}>
        <label className="field" style={{ flex: 1, minWidth: 180 }}>
          <span>Type</span>
          <select name="question_type" value={type} onChange={(e) => setType(e.target.value)}>
            {TYPES.map((t) => (
              <option key={t.value} value={t.value}>
                {t.label}
              </option>
            ))}
          </select>
        </label>

        <label className="field" style={{ width: 100 }}>
          <span>Marks</span>
          <input
            type="text"
            name="marks"
            inputMode="numeric"
            defaultValue={question?.marks ?? 1}
            required
          />
        </label>

        <label className="field" style={{ width: 130 }}>
          <span>Difficulty</span>
          <select name="difficulty" defaultValue={question?.difficulty ?? ""}>
            <option value="">—</option>
            <option value="easy">Easy</option>
            <option value="medium">Medium</option>
            <option value="hard">Hard</option>
          </select>
        </label>
      </div>

      <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: -6 }}>
        {AUTO.has(type)
          ? "This type marks itself."
          : "This type comes to you for marking, with the model answer beside the student's response."}
      </p>

      {type === "mcq" && (
        <div style={{ marginTop: 18 }}>
          <h3>Options</h3>
          <p style={{ fontSize: "0.82rem", color: "var(--muted)" }}>
            Leave C and D empty for a two-option question. Choose the correct one.
          </p>
          {["A", "B", "C", "D"].map((label) => (
            <div
              key={label}
              style={{ display: "flex", gap: 10, alignItems: "center", marginBottom: 8 }}
            >
              <label style={{ display: "flex", alignItems: "center", gap: 5, fontSize: "0.85rem" }}>
                <input
                  type="radio"
                  name="mcq_correct"
                  value={label}
                  defaultChecked={correctMcq === label}
                  style={{ width: "auto" }}
                />
                {label}
              </label>
              <input
                type="text"
                name={`option_${label}`}
                defaultValue={byLabel[label]?.option_text ?? ""}
                placeholder={`Option ${label}`}
              />
            </div>
          ))}
        </div>
      )}

      {type === "true_false" && (
        <div style={{ marginTop: 18 }}>
          <h3>Correct answer</h3>
          <div className="freq">
            <label>
              <input type="radio" name="tf_correct" value="true" defaultChecked={correctTf === "true"} />
              True
            </label>
            <label>
              <input type="radio" name="tf_correct" value="false" defaultChecked={correctTf === "false"} />
              False
            </label>
          </div>
        </div>
      )}

      <h3 style={{ marginTop: 26 }}>Where it comes from</h3>
      <div style={{ display: "flex", gap: 12, flexWrap: "wrap" }}>
        <label className="field" style={{ flex: 1, minWidth: 160 }}>
          <span>Source</span>
          <select name="source" defaultValue={question?.source ?? "teacher"}>
            <option value="gce_past">Past GCE paper</option>
            <option value="mock">Mock</option>
            <option value="textbook">Textbook</option>
            <option value="teacher">My own</option>
          </select>
        </label>
        <label className="field" style={{ width: 100 }}>
          <span>Year</span>
          <input type="text" name="source_year" inputMode="numeric" defaultValue={question?.source_year ?? ""} placeholder="2024" />
        </label>
        <label className="field" style={{ width: 100 }}>
          <span>Paper</span>
          <input type="text" name="source_paper" defaultValue={question?.source_paper ?? ""} placeholder="1" />
        </label>
        <label className="field" style={{ width: 110 }}>
          <span>Number</span>
          <input type="text" name="source_number" defaultValue={question?.source_number ?? ""} placeholder="4b" />
        </label>
      </div>

      <h3 style={{ marginTop: 26 }}>Which lessons does it test?</h3>
      <p style={{ fontSize: "0.82rem", color: "var(--muted)" }}>
        Tick every lesson it draws on — a real exam question rarely respects
        one. This tagging is what lets the system say a student is weak on a
        particular competency rather than just weak overall. An untagged
        question can still be asked, but it teaches the system nothing.
      </p>
      <div className="lesson-picker">
        {visibleLessons.map((l) => (
          <label key={l.id} className="lesson-pick">
            <input
              type="checkbox"
              name="lesson_ids"
              value={l.id}
              defaultChecked={taggedLessonIds.includes(l.id)}
            />
            <span>
              {l.lesson_no_start != null && (
                <span className="pick-num">{l.lesson_no_start}</span>
              )}
              {l.title}
            </span>
          </label>
        ))}
        {visibleLessons.length === 0 && (
          <p style={{ color: "var(--muted)", fontSize: "0.86rem" }}>
            No content lessons on this level yet.
          </p>
        )}
      </div>

      <h3 style={{ marginTop: 26 }}>Model answer</h3>
      <textarea
        name="model_answer"
        defaultValue={question?.model_answer ?? ""}
        style={{ minHeight: 120, fontFamily: "var(--font-reading), Georgia, serif", lineHeight: 1.6 }}
        placeholder="What a full-mark answer looks like."
      />

      <h3 style={{ marginTop: 20 }}>Marking guide</h3>
      <textarea
        name="marking_guide"
        defaultValue={question?.marking_guide ?? ""}
        style={{ minHeight: 90 }}
        placeholder="1 mark for correct initialisation, 2 for the loop, 1 for the output."
      />

      <div className="sticky-save">
        <button className="primary" type="submit">
          {question ? "Save question" : "Add question"}
        </button>
      </div>
    </form>
  );
}
