import Link from "next/link";
import { createClient } from "../../../lib/supabase-server";
import { reply } from "./actions";

export const metadata = { title: "Messages" };
export const dynamic = "force-dynamic";

function when(ts) {
  const d = new Date(ts);
  return (
    d.toLocaleDateString([], { day: "numeric", month: "short" }) +
    ", " +
    d.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })
  );
}

export default async function AdminMessages({ searchParams }) {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const sp = await searchParams;
  const openId = sp?.s ?? "";

  const { data: inboxData } = await supabase.rpc("teacher_inbox");
  const inbox = inboxData ?? [];
  const open = inbox.find((t) => t.student_id === openId);

  let thread = [];
  if (open) {
    const { data } = await supabase.rpc("teacher_thread", { p_student: openId });
    thread = data ?? [];
  }

  const unread = inbox.reduce((n, t) => n + Number(t.unread ?? 0), 0);

  return (
    <>
      <h2>Messages</h2>
      <p className="lede">
        {inbox.length === 0
          ? "Nobody has written in yet."
          : `${inbox.length} ${inbox.length === 1 ? "student" : "students"}` +
            (unread > 0 ? `, ${unread} unread` : ", all read")}
      </p>

      {inbox.length > 0 && (
        <div style={{ display: "grid", gap: 8, marginBottom: 26 }}>
          {inbox.map((t) => (
            <Link
              key={t.student_id}
              href={`/admin/messages?s=${t.student_id}`}
              className="row"
              style={{
                display: "block",
                textDecoration: "none",
                borderLeft:
                  Number(t.unread) > 0 ? "3px solid var(--gold)" : undefined,
                background:
                  t.student_id === openId ? "var(--surface)" : undefined,
              }}
            >
              <div className="name">
                {t.full_name}
                {Number(t.unread) > 0 && (
                  <span className="tag alert" style={{ marginLeft: 8 }}>
                    {t.unread} new
                  </span>
                )}
              </div>
              <p style={{ margin: "3px 0 0", fontSize: "0.86rem", color: "var(--muted)" }}>
                {t.class_name ? `${t.class_name} · ` : ""}
                {t.last_sender === "teacher" ? "You: " : ""}
                {String(t.last_body).slice(0, 90)}
                {String(t.last_body).length > 90 ? "…" : ""}
              </p>
            </Link>
          ))}
        </div>
      )}

      {open && (
        <div className="notice">
          <h3 style={{ marginTop: 0 }}>{open.full_name}</h3>

          <div className="thread">
            {thread.map((m) => (
              <div
                key={m.id}
                className={`msg ${m.sender === "teacher" ? "mine" : "theirs"}`}
              >
                <div className="msg-body">{m.body}</div>
                <div className="msg-meta">
                  {m.sender === "teacher" ? "You" : open.full_name} ·{" "}
                  {when(m.created_at)}
                  {m.lesson_title ? ` · ${m.lesson_title}` : ""}
                  {m.note_title && !m.lesson_title ? ` · ${m.note_title}` : ""}
                </div>
              </div>
            ))}
          </div>

          <form action={reply} style={{ marginTop: 16 }}>
            <input type="hidden" name="student_id" value={open.student_id} />
            <label htmlFor="body" className="field-label">Reply</label>
            <textarea id="body" name="body" rows={4} required />
            <button className="btn" type="submit" style={{ marginTop: 10 }}>
              Send reply
            </button>
          </form>
        </div>
      )}
    </>
  );
}
