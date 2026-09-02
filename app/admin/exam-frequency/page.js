import Link from "next/link";
import { createClient } from "../../../lib/supabase-server";
import { saveExamFrequencies } from "../actions";

export const metadata = { title: "Exam frequency" };

export const dynamic = "force-dynamic";

const OPTIONS = [
  { value: "unset", label: "—" },
  { value: "rare", label: "Rare" },
  { value: "occasional", label: "Occasional" },
  { value: "frequent", label: "Frequent" },
  { value: "almost_certain", label: "Almost certain" },
];

export default async function ExamFrequencyPage() {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const { data: syllabi } = await supabase
    .from("syllabi")
    .select("id, form_level, title")
    .order("form_level");

  const { data: competencies } = await supabase
    .from("competencies")
    .select("id, syllabus_id, sequence, category_of_action, competency_statement, exam_frequency")
    .is("deleted_at", null)
    .order("sequence");

  const bySyllabus = new Map();
  for (const c of competencies ?? []) {
    if (!bySyllabus.has(c.syllabus_id)) bySyllabus.set(c.syllabus_id, []);
    bySyllabus.get(c.syllabus_id).push(c);
  }

  // Form 5 first: it is the class sitting the GCE, so it is the one that
  // matters most and the one you are most likely to run out of patience before
  // finishing.
  const ordered = (syllabi ?? [])
    .filter((s) => bySyllabus.has(s.id))
    .sort((a, b) => (a.form_level === "Form 5" ? -1 : b.form_level === "Form 5" ? 1 : 0));

  return (
    <>
      <h2>Exam frequency</h2>
      <p className="lede">
        How often does each category of action actually come up in the GCE? Your
        answer decides what the system tells a weak student to revise first —
        nobody outside your classroom can supply it. Rough is fine; you can
        change it any time.
      </p>

      <form action={saveExamFrequencies}>
        {ordered.map((s) => (
          <section key={s.id} className="term">
            <div className="term-head">{s.form_level}</div>
            {bySyllabus.get(s.id).map((c) => (
              <div className="row" key={c.id}>
                <div className="name">
                  {c.sequence}. {c.category_of_action}
                </div>
                {c.competency_statement && (
                  <div className="sub">{c.competency_statement}</div>
                )}
                <div className="freq">
                  {OPTIONS.map((o) => {
                    const checked =
                      (c.exam_frequency ?? "unset") === o.value;
                    return (
                      <label key={o.value}>
                        <input
                          type="radio"
                          name={`freq:${c.id}`}
                          value={o.value}
                          defaultChecked={checked}
                        />
                        {o.label}
                      </label>
                    );
                  })}
                </div>
              </div>
            ))}
          </section>
        ))}

        <div className="sticky-save">
          <button className="primary" type="submit">
            Save all
          </button>
          <span style={{ marginLeft: 12, fontSize: "0.82rem", color: "var(--muted)" }}>
            Saves every level at once.
          </span>
        </div>
      </form>

      <p className="lede" style={{ marginTop: 26 }}>
        <Link href="/admin">Back to admin</Link>
      </p>
    </>
  );
}
