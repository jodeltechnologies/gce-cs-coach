import Link from "next/link";
import { createClient, getUser } from "../../../lib/supabase-server";
import MarkCard from "./MarkCard";

export const metadata = { title: "Marking" };
export const dynamic = "force-dynamic";

export default async function Marking({ searchParams }) {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const user = await getUser();
  const { data: teacher } = await supabase
    .from("teachers").select("id").eq("auth_user_id", user?.id ?? "").maybeSingle();
  if (!teacher) {
    return (
      <div className="notice bad">
        <h3>Account not linked</h3>
        <p>
          Your sign-in is not linked to a teacher record, so the database is
          refusing to show you anything. Run the INSERT INTO teachers step in
          db/auth.sql.
        </p>
      </div>
    );
  }

  const sp = await searchParams;
  const showMarked = sp?.done === "1";

  const { data: classes } = await supabase
    .from("classes")
    .select("id, name")
    .eq("teacher_id", teacher.id)
    .order("name");

  const classId = sp?.class || null;

  const { data, error } = await supabase.rpc("marking_queue", {
    p_class: classId,
    p_include_marked: showMarked,
  });
  const items = data ?? [];

  return (
    <>
      <h2>Marking</h2>
      <p className="lede">
        Paper 2 answers students have written. A computer cannot mark a
        paragraph, so these wait for you. Multiple choice is marked the moment a
        student answers and never appears here.
      </p>

      {error && (
        <div className="notice bad">
          <p style={{ margin: 0 }}>{error.message}</p>
        </div>
      )}

      <div style={{ display: "flex", gap: 6, flexWrap: "wrap", marginBottom: 18 }}>
        <Link href={`/admin/marking${showMarked ? "?done=1" : ""}`}
              className={!classId ? "tag" : "tag plain"} style={{ padding: "6px 13px" }}>
          All classes
        </Link>
        {(classes ?? []).map((c) => (
          <Link key={c.id}
                href={`/admin/marking?class=${c.id}${showMarked ? "&done=1" : ""}`}
                className={c.id === classId ? "tag" : "tag plain"}
                style={{ padding: "6px 13px" }}>
            {c.name}
          </Link>
        ))}
        <Link href={`/admin/marking?${classId ? `class=${classId}&` : ""}${showMarked ? "" : "done=1"}`}
              className="tag plain" style={{ padding: "6px 13px" }}>
          {showMarked ? "Hide marked" : "Show marked too"}
        </Link>
      </div>

      {items.length === 0 && (
        <div className="notice">
          <h3>Nothing waiting</h3>
          <p style={{ marginBottom: 0 }}>
            No written answers to mark. These appear when a student works
            through Paper 2 questions in practice.
          </p>
        </div>
      )}

      {items.map((a) => (
        <MarkCard key={a.answer_id} item={a} />
      ))}

      {items.length > 0 && (
        <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: 20 }}>
          Newest first, up to 60 at a time.
        </p>
      )}
    </>
  );
}
