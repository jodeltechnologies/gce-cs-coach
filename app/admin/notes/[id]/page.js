import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "../../../../lib/supabase-server";
import NoteBody from "../NoteBody";

export const dynamic = "force-dynamic";

export default async function NotePage({ params }) {
  const { id } = await params;
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const { data: s } = await supabase
    .from("note_sections")
    .select("id, chapter_number, title, body, page_from, page_to, note_sources(title, attribution)")
    .eq("id", id)
    .is("deleted_at", null)
    .maybeSingle();

  if (!s) notFound();

  return (
    <>
      <p style={{ marginBottom: 6 }}>
        <Link className="link" href="/admin/notes">← All chapters</Link>
      </p>
      <h2 style={{ marginBottom: 4 }}>
        {s.chapter_number ? `${s.chapter_number}. ` : ""}{s.title}
      </h2>
      <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: 0, marginBottom: 22 }}>
        {s.note_sources?.title} · pp. {s.page_from}–{s.page_to}
        {s.note_sources?.attribution ? ` · ${s.note_sources.attribution}` : ""}
      </p>
      <NoteBody body={s.body} />
    </>
  );
}
