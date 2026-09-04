"use client";

import { useState, useTransition } from "react";

/**
 * The questions at the foot of a lesson note.
 *
 * The answer stays hidden until the student says they have had a go at it.
 * An answer sitting in plain view below the question is not a question at
 * all: the eye reaches it before the mind has started, and the student comes
 * away certain they knew something they had only just read.
 *
 * Nothing here can mark a written answer, so the student marks themselves
 * once the model answer is showing. That report is what feeds the progress
 * page, and it is stored and labelled as a self report rather than as a
 * score, because that is what it is.
 */

const REPORTS = [
  { value: "got_it", label: "I had it", hint: "My answer said the same thing" },
  { value: "partly", label: "Partly", hint: "I had some of it" },
  { value: "missed", label: "I missed it", hint: "Go back over this" },
];

function Question({ index, question, answer, saved, onSave, disabled }) {
  const [revealed, setRevealed] = useState(Boolean(saved));
  const [report, setReport] = useState(saved ?? null);
  const [pending, startTransition] = useTransition();

  const choose = (value) => {
    setReport(value);
    startTransition(() => onSave(index, question, value));
  };

  return (
    <li className={`sc-item${report ? ` sc-${report}` : ""}`}>
      <p className="sc-q">{question}</p>

      {!revealed && (
        <div className="sc-actions">
          <button type="button" className="btn small" onClick={() => setRevealed(true)}>
            Show the answer
          </button>
          <span className="sc-hint">Work it out first, on paper or in your head.</span>
        </div>
      )}

      {revealed && (
        <>
          <p className="sc-a">{answer}</p>
          {disabled ? (
            <p className="sc-hint">Sign in to keep a record of how you did.</p>
          ) : (
            <div className="sc-report">
              <span className="sc-hint">How did you do?</span>
              <div className="sc-buttons">
                {REPORTS.map((r) => (
                  <button
                    key={r.value}
                    type="button"
                    title={r.hint}
                    className={`sc-pick${report === r.value ? " on" : ""}`}
                    onClick={() => choose(r.value)}
                  >
                    {r.label}
                  </button>
                ))}
              </div>
              {pending && <span className="sc-hint">Saving</span>}
            </div>
          )}
        </>
      )}
    </li>
  );
}

export default function SelfCheck({ title, questions, saved = {}, onSave, disabled = false }) {
  const [store, setStore] = useState(saved);

  const handle = (index, question, value) => {
    setStore((s) => ({ ...s, [index]: value }));
    if (onSave) onSave(index, question, value);
  };

  const done = Object.keys(store).length;

  return (
    <div className="quiz sc">
      <h3>{title || "Test yourself"}</h3>
      <ol>
        {questions.map((q, i) => (
          <Question
            key={i}
            index={i}
            question={q.question}
            answer={q.answer}
            saved={store[i]}
            onSave={handle}
            disabled={disabled}
          />
        ))}
      </ol>
      {done > 0 && (
        <p className="sc-done">
          {done} of {questions.length} answered. This shows on your progress
          page.
        </p>
      )}
    </div>
  );
}
