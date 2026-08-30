import Link from "next/link";
import { createClient } from "../../../../lib/supabase-server";
import ReviewCard from "./ReviewCard";

export const metadata = { title: "Check imported questions" };
export const dynamic = "force-dynamic";

const FLAG_NOTE = {
  from_ocr:
    "This page was a scan, so the text was read by machine. Check the wording letter by letter.",
  no_answer_key:
    "The paper was printed without answers. Choose the correct option.",
  missing_options:
    "Fewer than four options came out. The rest are on the source page.",
  empty_option: "An option letter was found but its text was not.",
  references_figure:
    "This question refers to a diagram or truth table that no scan captured. It cannot be used until you supply it, or it should be removed.",
  answer_key_not_among_options:
    "The printed answer letter does not match any option that was recovered.",
  answer_inferred_from_duplicate:
    "The answer was copied from an identical question elsewhere in the pamphlet. Confirm it.",
  no_marking_guide: "No answer pointers were printed alongside this one.",
  long_stem: "The stem is unusually long and may have absorbed nearby text.",
};

export default async function ReviewPage({ searchParams }) {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const sp = await searchParams;
  const flag = sp?.flag ?? "";

  const { data: syllabi } = await supabase
    .from("syllabi").select("id, form_level").order("form_level");
  const selected =
    sp?.syllabus ?? syllabi?.find((s) => s.form_level === "Form 5")?.id;

  // Oldest page first. Working through the pamphlet in page order means the
  // source is open at the right place, rather than jumping between papers.
  let q = supabase
    .from("questions")
    .select("id, question_text, question_type, marks, source, source_year, source_paper, source_number, import_page, import_flags, question_options(id, label, option_text, is_correct, sequence)")
    .eq("syllabus_id", selected ?? "")
    .eq("needs_review", true)
    .is("deleted_at", null)
    .order("import_page", { ascending: true })
    .limit(25);
  if (flag) q = q.contains("import_flags", [flag]);

  const { data: rows } = await q;
  const items = rows ?? [];

  const { count: remaining } = await supabase
    .from("questions")
    .select("id", { count: "exact", head: true })
    .eq("syllabus_id", selected ?? "")
    .eq("needs_review", true)
    .is("deleted_at", null);

  const { count: done } = await supabase
    .from("questions")
    .select("id", { count: "exact", head: true })
    .eq("syllabus_id", selected ?? "")
    .eq("needs_review", false)
    .not("import_batch", "is", null)
    .is("deleted_at", null);

  const total = (remaining ?? 0) + (done ?? 0);
  const pct = total > 0 ? Math.round(((done ?? 0) / total) * 100) : 0;

  return (
    <>
      <h2>Check imported questions</h2>
      <p className="lede">
        These came out of the past-paper pamphlet by machine. A third of its
        pages were scanned rather than typed, so some wording is wrong, some
        answers were never printed, and some questions point at a diagram that
        no scan captured. Until you confirm one, it will not mark a student.
      </p>

      <div style={{ display: "flex", gap: 6, flexWrap: "wrap", marginBottom: 12 }}>
        {(syllabi ?? []).map((s) => (
          <Link key={s.id} href={`/admin/questions/review?syllabus=${s.id}`}
            className={s.id === selected ? "tag" : "tag plain"}
            style={{ padding: "6px 13px" }}>
            {s.form_level}
          </Link>
        ))}
      </div>

      {total > 0 && (
        <div style={{ marginBottom: 18 }}>
          <div style={{ height: 8, background: "var(--rule, #e5e2dc)", borderRadius: 4, overflow: "hidden" }}>
            <div style={{ height: "100%", width: `${pct}%`, background: "var(--green)" }} />
          </div>
          <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: 6 }}>
            {done ?? 0} checked, {remaining ?? 0} to go. Twenty a day finishes
            this inside a month.
          </p>
        </div>
      )}

      <div style={{ display: "flex", gap: 6, flexWrap: "wrap", marginBottom: 20 }}>
        {[["", "Everything"], ["no_answer_key", "No answer printed"],
          ["from_ocr", "Read by machine"], ["missing_options", "Options missing"],
          ["references_figure", "Needs a diagram"]].map(([v, label]) => (
          <Link key={v || "all"}
            href={`/admin/questions/review?syllabus=${selected}${v ? `&flag=${v}` : ""}`}
            className={flag === v ? "tag gold" : "tag plain"}
            style={{ padding: "5px 12px" }}>
            {label}
          </Link>
        ))}
      </div>

      {items.length === 0 && (
        <div className="notice">
          <h3>Nothing waiting</h3>
          <p>
            Every imported question for this level has been checked. New ones
            appear here if the pamphlet is loaded again.
          </p>
          <p><Link href="/admin/questions">Go to the question bank</Link></p>
        </div>
      )}

      {items.map((x) => (
        <ReviewCard key={x.id} question={x} notes={FLAG_NOTE} />
      ))}

      {items.length > 0 && (
        <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: 24 }}>
          Showing the first {items.length} in page order. Confirming or removing
          one takes it off this list.
        </p>
      )}
    </>
  );
}
