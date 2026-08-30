import Link from "next/link";
import { createClient } from "../../../lib/supabase-server";

export const metadata = { title: "Question bank" };
export const dynamic = "force-dynamic";

const TYPE_LABEL = {
  mcq: "MCQ", true_false: "True/False", short_answer: "Short answer",
  structured: "Structured", practical: "Practical", algorithm: "Algorithm",
  flowchart: "Flowchart", trace_table: "Trace table",
};

export default async function QuestionsPage({ searchParams }) {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const sp = await searchParams;
  const { data: syllabi } = await supabase
    .from("syllabi").select("id, form_level").order("form_level");

  const selected = sp?.syllabus ?? syllabi?.find((s) => s.form_level === "Form 5")?.id;
  const sourceFilter = sp?.source ?? "";

  let q = supabase
    .from("questions")
    .select("id, question_text, question_type, marks, difficulty, source, source_year, source_paper, source_number, auto_markable, needs_review, import_page, question_lessons(lesson_id)")
    .eq("syllabus_id", selected ?? "")
    .is("deleted_at", null)
    .order("created_at", { ascending: false })
    .limit(200);
  if (sourceFilter) q = q.eq("source", sourceFilter);

  const { data: questions } = await q;
  const all = questions ?? [];

  // The list above is capped, so counting it would describe the page rather
  // than the bank. With 522 questions loaded, a cap of 200 reported "200
  // questions, 199 unchecked" and looked like a failed import. Count in the
  // database instead.
  const tally = async (extra) => {
    let c = supabase
      .from("questions")
      .select("id", { count: "exact", head: true })
      .eq("syllabus_id", selected ?? "")
      .is("deleted_at", null);
    if (sourceFilter) c = c.eq("source", sourceFilter);
    if (extra) c = extra(c);
    const { count } = await c;
    return count ?? 0;
  };

  const [total, autoCount, uncheckedCount] = await Promise.all([
    tally(),
    tally((c) => c.eq("auto_markable", true)),
    tally((c) => c.eq("needs_review", true)),
  ]);

  // Untagged has no column to count on, so it is counted through the join
  // table instead of by filtering the capped list.
  const { data: taggedRows } = await supabase
    .from("question_lessons")
    .select("question_id, questions!inner(syllabus_id, deleted_at)")
    .eq("questions.syllabus_id", selected ?? "")
    .is("questions.deleted_at", null);
  const taggedCount = new Set((taggedRows ?? []).map((r) => r.question_id)).size;
  const untaggedCount = Math.max(total - taggedCount, 0);

  return (
    <>
      <h2>Question bank</h2>
      <p className="lede">
        Past GCE papers, mocks and your own questions, each tagged to the
        lessons it tests. The tagging is what turns a pile of questions into
        something that can tell a student where they are weak.
      </p>

      <div style={{ display: "flex", gap: 6, flexWrap: "wrap", marginBottom: 12 }}>
        {(syllabi ?? []).map((s) => (
          <Link key={s.id} href={`/admin/questions?syllabus=${s.id}`}
            className={s.id === selected ? "tag" : "tag plain"}
            style={{ padding: "6px 13px" }}>
            {s.form_level}
          </Link>
        ))}
      </div>

      <div className="tags" style={{ marginBottom: 16 }}>
        <span className="tag plain">{total} questions</span>
        <span className="tag">{autoCount} mark themselves</span>
        {untaggedCount > 0 && (
          <span className="tag alert">{untaggedCount} not tagged to a lesson</span>
        )}
      </div>

      {uncheckedCount > 0 && (
        <div className="notice" style={{ borderLeft: "3px solid var(--gold)", marginBottom: 18 }}>
          <h3 style={{ marginTop: 0 }}>
            {uncheckedCount} imported questions are waiting to be checked
          </h3>
          <p style={{ marginBottom: 8 }}>
            They came out of the past-paper pamphlet by machine, so some wording
            is wrong and many answers were never printed. None of them will mark
            a student until you confirm it.
          </p>
          <Link className="link" href={`/admin/questions/review?syllabus=${selected}`}>
            Work through them
          </Link>
        </div>
      )}

      <div style={{ display: "flex", gap: 6, flexWrap: "wrap", marginBottom: 18 }}>
        {[["", "All sources"], ["gce_past", "Past GCE"], ["mock", "Mock"],
          ["textbook", "Textbook"], ["teacher", "My own"]].map(([v, label]) => (
          <Link key={v || "all"}
            href={`/admin/questions?syllabus=${selected}${v ? `&source=${v}` : ""}`}
            className={sourceFilter === v ? "tag gold" : "tag plain"}
            style={{ padding: "5px 12px" }}>
            {label}
          </Link>
        ))}
      </div>

      <Link className="primary" href={`/admin/questions/new?syllabus=${selected}`}
        style={{ display: "inline-block", padding: "10px 20px", borderRadius: 8,
                 background: "var(--green)", color: "#fff", fontWeight: 600,
                 fontSize: "0.95rem", marginBottom: 20 }}>
        Add a question
      </Link>

      {all.length === 0 && (
        <div className="notice">
          <h3>Nothing here yet</h3>
          <p>
            Start with one past paper. Twenty tagged questions is enough for the
            system to say something useful about a topic.
          </p>
        </div>
      )}

      {all.map((x) => (
        <Link className="row" key={x.id} href={`/admin/questions/${x.id}`}
          style={{ display: "block", color: "inherit" }}>
          <div className="name" style={{ fontFamily: "var(--font-reading), Georgia, serif" }}>
            {x.question_text.length > 150
              ? x.question_text.slice(0, 150) + "…"
              : x.question_text}
          </div>
          <div className="tags" style={{ marginTop: 6 }}>
            <span className="tag plain">{TYPE_LABEL[x.question_type] ?? x.question_type}</span>
            <span className="tag plain">{x.marks} marks</span>
            {x.difficulty && <span className="tag plain">{x.difficulty}</span>}
            {x.source === "gce_past" && (
              <span className="tag gold">
                GCE {x.source_year ?? ""}{x.source_paper ? ` P${x.source_paper}` : ""}
                {x.source_number ? ` Q${x.source_number}` : ""}
              </span>
            )}
            {x.needs_review && <span className="tag alert">Not checked</span>}
            {(x.question_lessons ?? []).length === 0
              ? <span className="tag alert">Not tagged</span>
              : <span className="tag">{x.question_lessons.length} lessons</span>}
          </div>
        </Link>
      ))}
      {total > all.length && (
        <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: 20 }}>
          Showing the {all.length} most recently added of {total}. Use the review
          queue to work through the imported ones in pamphlet page order.
        </p>
      )}
    </>
  );
}