"use client";

import { useState } from "react";
import { approveHighConfidence } from "../actions";

/**
 * Clears the straightforward half of the queue in one action.
 *
 * It asks first. Approving a few hundred questions at once is not reversible
 * from this screen, and the whole premise of the review queue is that a person
 * decided, so the button that skips the deciding should at least be deliberate.
 */
export default function BulkApprove({ syllabusId, count }) {
  const [confirming, setConfirming] = useState(false);
  const [busy, setBusy] = useState(false);

  return (
    <div
      className="notice"
      style={{ borderLeft: "3px solid var(--green)", marginBottom: 18 }}
    >
      <h3 style={{ marginTop: 0 }}>{count} can be cleared in one go</h3>
      <p style={{ marginBottom: confirming ? 12 : 0 }}>
        These are multiple-choice questions with clean text, four options, and a
        proposed answer that is ordinary syllabus content — first-generation
        computers used valves, a scanner is an input device. Anything from a
        scan, missing an option, or depending on a diagram is left out and stays
        in the queue below.
      </p>

      {!confirming ? (
        <button
          className="link"
          onClick={() => setConfirming(true)}
          style={{ fontSize: "0.88rem", fontWeight: 600, padding: 0 }}
        >
          Review what this does
        </button>
      ) : (
        <>
          <p style={{ fontSize: "0.86rem", marginBottom: 12 }}>
            Accepting these marks them checked and lets them mark students
            automatically, without you having read each one. The answers were
            worked out from the syllabus, not taken from the printed paper, so a
            few may be wrong. You can still open and correct any of them
            afterwards from the question bank.
          </p>
          <div style={{ display: "flex", gap: 12, alignItems: "center" }}>
            <form
              action={async (fd) => {
                setBusy(true);
                await approveHighConfidence(fd);
                setBusy(false);
                setConfirming(false);
              }}
            >
              <input type="hidden" name="syllabus_id" value={syllabusId} />
              <button
                type="submit"
                disabled={busy}
                style={{
                  padding: "8px 18px",
                  borderRadius: 8,
                  border: "none",
                  background: "var(--green)",
                  color: "#fff",
                  fontWeight: 600,
                  fontSize: "0.88rem",
                  cursor: "pointer",
                }}
              >
                {busy ? "Accepting…" : `Accept all ${count}`}
              </button>
            </form>
            <button
              className="link"
              onClick={() => setConfirming(false)}
              style={{ fontSize: "0.86rem" }}
            >
              Not now
            </button>
          </div>
        </>
      )}
    </div>
  );
}
