import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "../../../lib/supabase-server";
import { getStudentSession } from "../../../lib/student-session";
import NoteBody from "../../admin/notes/NoteBody";

export const metadata = { title: "Notes" };
export const dynamic = "force-dynamic";

export default async function StudentNotes({ searchParams }) {
  const session = await getStudentSession();
  if (!session) redirect("/student/login");

  const supabase = await createClient();
  if (!supabase) return <p>Not connected.</p>;

  const sp = await searchParams;
  const openId = sp?.c ?? "";

  const { data } = await supabase.rpc("student_notes");
  const chapters = data ?? [];
  const open = chapters.find((c) => c.id === openId);

  return (
    <main style={{ maxWidth: 700, margin: "0 auto", padding: "28px 20px" }}>
      <p style={{ marginBottom: 10 }}>
        <Link className="link" href={open ? "/student/notes" : "/student"}>
          ← {open ? "All chapters" : "Back"}
        </Link>
      </p>

      {!open && (
        <>
          <h2>Notes</h2>
          {chapters.map((c) => (
            <Link key={c.id} href={`/student/notes?c=${c.id}`} className="row"
                  style={{ display: "block", textDecoration: "none" }}>
              <div className="name">
                {c.chapter_number ? `${c.chapter_number}. ` : ""}{c.title}
              </div>
              <div className="tags" style={{ marginTop: 6 }}>
                <span className="tag plain">
                  about {Math.max(Math.round((c.body?.length ?? 0) / 1100), 1)} min
                </span>
              </div>
            </Link>
          ))}
        </>
      )}

      {open && (
        <>
          <h2 style={{ marginBottom: 18 }}>
            {open.chapter_number ? `${open.chapter_number}. ` : ""}{open.title}
          </h2>
          <NoteBody body={open.body} />
        </>
      )}
    </main>
  );
}
