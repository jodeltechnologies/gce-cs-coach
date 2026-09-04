"use client";

import SelfCheck from "../SelfCheck";
import { recordSelfCheck } from "../actions";

/**
 * A note with its questions made interactive.
 *
 * The prose either side of the questions is the teacher's own HTML and is
 * rendered as it stands. Only the block of questions is replaced, because
 * that is the only part that has to hold something back.
 */
export default function SelfCheckPanel({
  sectionId, before, after, title, questions, saved,
}) {
  const save = (index, question, report) => {
    // Deliberately not awaited. A student tapping "I had it" should not sit
    // watching a spinner; the component already shows the choice, and a save
    // that fails costs one line in a progress table.
    recordSelfCheck(sectionId, index, question, report);
  };

  return (
    <div className="note-html" style={{ maxWidth: "68ch", lineHeight: 1.7 }}>
      <div dangerouslySetInnerHTML={{ __html: before }} />
      <SelfCheck
        title={title}
        questions={questions}
        saved={saved}
        onSave={save}
      />
      {after ? <div dangerouslySetInnerHTML={{ __html: after }} /> : null}
    </div>
  );
}
