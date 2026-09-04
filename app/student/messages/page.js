import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "../../../lib/supabase-server";
import { getStudentSession } from "../../../lib/student-session";
import MessageForm from "./MessageForm";

export const metadata = { title: "Message your teacher" };
export const dynamic = "force-dynamic";

function when(ts) {
  const d = new Date(ts);
  const today = new Date();
  const sameDay = d.toDateString() === today.toDateString();
  return sameDay
    ? d.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })
    : d.toLocaleDateString([], { day: "numeric", month: "short" }) +
      ", " +
      d.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" });
}

export default async function StudentMessages() {
  const session = await getStudentSession();
  if (!session) redirect("/student/login");

  const supabase = await createClient();
  if (!supabase) return <p>Not connected.</p>;

  const { data } = await supabase.rpc("student_messages", {
    p_student: session.id,
  });
  const messages = data ?? [];

  // Opening the page is what marks the teacher's replies as seen. Doing it
  // here rather than on a button means the unread count on the teacher's side
  // means what it says.
  await supabase.rpc("student_mark_read", { p_student: session.id });

  return (
    <main style={{ maxWidth: 640, margin: "0 auto", padding: "28px 20px" }}>
      <p style={{ marginBottom: 10 }}>
        <Link className="link" href="/student">← My revision</Link>
      </p>

      <h2 style={{ marginBottom: 2 }}>Message your teacher</h2>
      <p className="lede">
        For when you have read the note twice and it still will not go in.
      </p>

      {messages.length === 0 ? (
        <div className="notice">
          <p style={{ margin: 0 }}>
            Nothing here yet. Ask about one thing at a time and say which
            lesson it came from. A question your teacher can picture is a
            question they can answer quickly.
          </p>
        </div>
      ) : (
        <div className="thread">
          {messages.map((m) => (
            <div
              key={m.id}
              className={`msg ${m.sender === "student" ? "mine" : "theirs"}`}
            >
              <div className="msg-body">{m.body}</div>
              <div className="msg-meta">
                {m.sender === "student" ? "You" : "Your teacher"} ·{" "}
                {when(m.created_at)}
                {m.lesson_title ? ` · ${m.lesson_title}` : ""}
                {m.note_title && !m.lesson_title ? ` · ${m.note_title}` : ""}
              </div>
            </div>
          ))}
        </div>
      )}

      <MessageForm />

      <p style={{ marginTop: 24, fontSize: "0.84rem", color: "var(--muted)" }}>
        Your teacher sees these on their own page. Replies appear here.
      </p>
    </main>
  );
}
