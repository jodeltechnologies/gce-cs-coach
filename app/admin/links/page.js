import Link from "next/link";
import { createClient } from "../../../lib/supabase-server";
import { decideLink } from "../actions";

export const metadata = { title: "Cross-year links" };

export const dynamic = "force-dynamic";

export default async function LinksPage() {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  // Self-join through the foreign key: each row carries the category it is
  // proposed to continue.
  const { data: rows } = await supabase
    .from("competencies")
    .select(
      "id, category_of_action, link_confirmed, continues_from_id, syllabi(form_level), previous:continues_from_id(category_of_action, syllabi(form_level))"
    )
    .is("deleted_at", null)
    .not("continues_from_id", "is", null)
    .order("sequence");

  const pending = (rows ?? []).filter((r) => !r.link_confirmed);
  const confirmed = (rows ?? []).filter((r) => r.link_confirmed);

  return (
    <>
      <h2>Cross-year links</h2>
      <p className="lede">
        These say that a Form 5 category continues one from Form 4. Confirmed
        links let the system carry a student&apos;s weak areas forward — in
        September, before you have taught a single lesson, you can see who
        arrived weak on logic circuits. Names drift between the two sheets and
        one even changes spelling, so a computer should not decide these alone.
      </p>

      {pending.length === 0 && (
        <div className="notice">
          <h3>Nothing waiting</h3>
          <p>Every proposed link has been decided.</p>
        </div>
      )}

      {pending.map((r) => (
        <div className="card" key={r.id}>
          <h3>{r.category_of_action}</h3>
          <div className="meta">
            {r.syllabi?.form_level} · proposed to continue{" "}
            <strong>{r.previous?.category_of_action}</strong> from{" "}
            {r.previous?.syllabi?.form_level}
          </div>
          <div style={{ display: "flex", gap: 8, marginTop: 12 }}>
            <form action={decideLink}>
              <input type="hidden" name="id" value={r.id} />
              <input type="hidden" name="decision" value="confirm" />
              <button className="primary" type="submit">
                Yes, it continues
              </button>
            </form>
            <form action={decideLink}>
              <input type="hidden" name="id" value={r.id} />
              <input type="hidden" name="decision" value="reject" />
              <button className="link" type="submit" style={{ padding: "10px 8px" }}>
                No, unrelated
              </button>
            </form>
          </div>
        </div>
      ))}

      {confirmed.length > 0 && (
        <>
          <h3 style={{ marginTop: 34 }}>Confirmed</h3>
          {confirmed.map((r) => (
            <div className="row" key={r.id}>
              <div className="name">{r.category_of_action}</div>
              <div className="sub">
                continues {r.previous?.category_of_action} (
                {r.previous?.syllabi?.form_level})
              </div>
            </div>
          ))}
        </>
      )}

      <p className="lede" style={{ marginTop: 26 }}>
        <Link href="/admin">Back to admin</Link>
      </p>
    </>
  );
}
