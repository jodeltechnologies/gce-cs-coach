import Link from "next/link";
import { createClient, getUser } from "../../../lib/supabase-server";

export const metadata = { title: "Class progress" };
export const dynamic = "force-dynamic";

export default async function ClassProgress({ searchParams }) {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const user = await getUser();
  const { data: teacher } = await supabase
    .from("teachers").select("id").eq("auth_user_id", user?.id ?? "").maybeSingle();
  if (!teacher) {
    return (
      <div className="notice bad">
        <h3>Account not linked</h3>
        <p>Go back to <Link href="/admin">Admin</Link> for the fix.</p>
      </div>
    );
  }

  const { data: classes } = await supabase
    .from("classes")
    .select("id, name, academic_year")
    .eq("teacher_id", teacher.id)
    .order("academic_year", { ascending: false });

  const sp = await searchParams;
  const selected = sp?.class ?? classes?.[0]?.id ?? "";

  const { data: rows } = selected
    ? await supabase.rpc("class_weak_topics", { p_class: selected })
    : { data: [] };
  const topics = rows ?? [];

  return (
    <>
      <h2>Class progress</h2>
      <p className="lede">
        What this class is getting wrong, from the questions they have actually
        answered. A topic appears once five answers have gone through it, so
        the list is quiet until students have practised.
      </p>

      <div style={{ display: "flex", gap: 6, flexWrap: "wrap", marginBottom: 18 }}>
        {(classes ?? []).map((c) => (
          <Link key={c.id} href={`/admin/progress?class=${c.id}`}
                className={c.id === selected ? "tag" : "tag plain"}
                style={{ padding: "6px 13px" }}>
            {c.name}
          </Link>
        ))}
      </div>

      {topics.length === 0 && (
        <div className="notice">
          <h3>Nothing to show yet</h3>
          <p style={{ marginBottom: 0 }}>
            No practice has been recorded for this class. Give the students
            their login codes and this fills itself in.
          </p>
        </div>
      )}

      {topics.map((t) => {
        const pct = Number(t.percentage);
        return (
          <div key={t.lesson_id} className="row" style={{ display: "block" }}>
            <div className="name">{t.lesson_title}</div>
            <div style={{ display: "flex", alignItems: "center", gap: 12, marginTop: 8 }}>
              <div style={{ flex: 1, height: 8, background: "var(--rule, #e5e2dc)",
                            borderRadius: 4, overflow: "hidden" }}>
                <div style={{
                  height: "100%", width: `${pct}%`,
                  background: pct < 40 ? "var(--red)" : pct < 70 ? "var(--gold)" : "var(--green)",
                }} />
              </div>
              <span style={{ fontSize: "0.86rem", width: 46, textAlign: "right" }}>
                {pct}%
              </span>
            </div>
            <div className="tags" style={{ marginTop: 8 }}>
              <span className="tag plain">{t.students} students</span>
              <span className="tag plain">{t.correct} of {t.answered} right</span>
              {pct < 40 && <span className="tag alert">Reteach</span>}
            </div>
          </div>
        );
      })}

      {topics.length > 0 && (
        <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: 20 }}>
          Weakest first. This counts self-directed practice, so it reflects who
          has been revising as much as who understands — read it as a signal,
          not a mark.
        </p>
      )}
    </>
  );
}
