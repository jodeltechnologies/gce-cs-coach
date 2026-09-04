import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "../../../lib/supabase-server";
import { getStudentSession } from "../../../lib/student-session";
import NoteBody, { splitSelfCheck } from "../../admin/notes/NoteBody";
import SelfCheckPanel from "./SelfCheckPanel";
import MessageForm from "../messages/MessageForm";

export const metadata = { title: "Notes" };
export const dynamic = "force-dynamic";

export default async function StudentNotes({ searchParams }) {
  const session = await getStudentSession();
  if (!session) redirect("/student/login");

  const supabase = await createClient();
  if (!supabase) return <p>Not connected.</p>;

  const sp = await searchParams;
  const openId = sp?.c ?? "";

  const { data } = await supabase.rpc("student_notes", {
    p_student: session.id,
  });
  const chapters = data ?? [];
  const open = chapters.find((c) => c.id === openId);

  // What this student already said about the questions in this note, so the
  // page comes back the way they left it rather than asking again.
  let saved = {};
  let parts = null;
  if (open && open.body_format === "html") {
    parts = splitSelfCheck(open.body);
    if (parts.questions.length > 0) {
      const { data: prior } = await supabase.rpc("student_section_checks", {
        p_student: session.id,
        p_section: open.id,
      });
      for (const row of prior ?? []) saved[row.question_index] = row.self_report;
    }
  }

  // Grouped by where they came from, in the order the function returned them:
  // the written notes, then the booklet chapters that hold the figures.
  const grouped = new Map();
  for (const c of chapters) {
    const key = c.source_title ?? "Notes";
    if (!grouped.has(key)) grouped.set(key, []);
    grouped.get(key).push(c);
  }
  const groups = [...grouped.entries()];

  return (
    <main style={{ maxWidth: 700, margin: "0 auto", padding: "28px 20px" }}>
      <p style={{ marginBottom: 10 }}>
        <Link className="link" href={open ? "/student/notes" : "/student"}>
          ← {open ? "All chapters" : "Back"}
        </Link>
      </p>

      {!open && chapters.length === 0 && (
        <div className="notice">
          <h3>No notes for your class yet</h3>
          <p style={{ marginBottom: 0 }}>
            Notes are written per year. If you have just been added to a class,
            ask your teacher — otherwise your year&apos;s notes are still being
            prepared.
          </p>
        </div>
      )}

      {!open && chapters.length > 0 && (
        <>
          <h2>Notes</h2>
          {groups.map(([source, list]) => (
            <div key={source} style={{ marginBottom: 26 }}>
              <h3 style={{ fontSize: "0.95rem", marginBottom: 10 }}>{source}</h3>
              {list.map((c) => (
                <Link key={c.id} href={`/student/notes?c=${c.id}`} className="row"
                      style={{ display: "block", textDecoration: "none" }}>
                  <div className="name">
                    {c.chapter_number ? `${c.chapter_number}. ` : ""}{c.title}
                  </div>
                  <div className="tags" style={{ marginTop: 6 }}>
                    <span className="tag plain">
                      about {Math.max(Math.round((c.body?.length ?? 0) / 1100), 1)} min
                    </span>
                    {c.body?.includes("![") && (
                      <span className="tag">with diagrams</span>
                    )}
                  </div>
                </Link>
              ))}
            </div>
          ))}
        </>
      )}

      {open && (
        <>
          <h2 style={{ marginBottom: 18 }}>
            {open.chapter_number ? `${open.chapter_number}. ` : ""}{open.title}
          </h2>

          {parts && parts.questions.length > 0 ? (
            <SelfCheckPanel
              sectionId={open.id}
              before={parts.before}
              after={parts.after}
              title={parts.title}
              questions={parts.questions}
              saved={saved}
            />
          ) : (
            <NoteBody body={open.body} format={open.body_format} />
          )}

          <div className="notice" style={{ marginTop: 30 }}>
            <h3 style={{ marginTop: 0 }}>Not clear yet?</h3>
            <p style={{ margin: "0 0 4px", fontSize: "0.9rem" }}>
              Read it once more first. If it still will not go in, say so and
              your teacher will see which note you were on.
            </p>
            <MessageForm sectionId={open.id} compact />
          </div>
        </>
      )}
    </main>
  );
}
