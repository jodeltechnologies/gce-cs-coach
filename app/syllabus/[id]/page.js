import { getSupabase } from "../../../lib/supabase";

export const dynamic = "force-dynamic";

const KIND_LABEL = {
  diagnostic_evaluation: "Diagnostic",
  integration_activity: "Integration",
  evaluation: "Evaluation",
  remediation: "Remediation",
  practical: "Practical",
};

const TERM_NAME = { 1: "First term", 2: "Second term", 3: "Third term" };

function lessonNumber(l) {
  if (l.lesson_no_start === null || l.lesson_no_start === undefined) return "";
  if (l.lesson_no_end && l.lesson_no_end !== l.lesson_no_start) {
    return `${l.lesson_no_start}–${l.lesson_no_end}`;
  }
  return String(l.lesson_no_start);
}

export default async function SyllabusPage({ params }) {
  const { id } = await params;
  const supabase = getSupabase();

  if (!supabase) {
    return (
      <div className="notice">
        <h3>Not configured</h3>
        <p>Add the Supabase environment variables in Vercel and redeploy.</p>
      </div>
    );
  }

  const { data: syllabus } = await supabase
    .from("syllabi")
    .select("*")
    .eq("id", id)
    .single();

  if (!syllabus) {
    return (
      <>
        <h2>Not found</h2>
        <p className="lede">
          No progression sheet with that address. <a href="/">Back to the list</a>.
        </p>
      </>
    );
  }

  const [{ data: lessons }, { data: competencies }] = await Promise.all([
    supabase
      .from("lessons")
      .select(
        "id, lesson_no_start, lesson_no_end, title, term, week_from, lesson_kind, competency_id, is_practical, objectives(description, kind, sequence)"
      )
      .eq("syllabus_id", id)
      .order("sequence"),
    supabase
      .from("competencies")
      .select("id, category_of_action, competency_statement, sequence")
      .eq("syllabus_id", id)
      .order("sequence"),
  ]);

  const catById = new Map((competencies ?? []).map((c) => [c.id, c]));

  // Group by term, then by week, preserving sheet order.
  const terms = [];
  for (const l of lessons ?? []) {
    let t = terms[terms.length - 1];
    if (!t || t.term !== l.term) {
      t = { term: l.term, weeks: [] };
      terms.push(t);
    }
    let w = t.weeks[t.weeks.length - 1];
    if (!w || w.week !== l.week_from) {
      w = { week: l.week_from, items: [] };
      t.weeks.push(w);
    }
    w.items.push(l);
  }

  return (
    <>
      <h2>{syllabus.form_level}</h2>
      <p className="lede">{syllabus.title}</p>

      <div className="tags">
        {syllabus.weekly_periods_theory && (
          <span className="tag plain">
            {syllabus.weekly_periods_theory} theory periods
          </span>
        )}
        {syllabus.weekly_periods_practical ? (
          <span className="tag plain">
            {syllabus.weekly_periods_practical} practical periods
          </span>
        ) : null}
        {syllabus.coefficient && (
          <span className="tag plain">Coefficient {syllabus.coefficient}</span>
        )}
        <span className="tag plain">{syllabus.total_weeks} weeks</span>
      </div>

      {terms.map((t) => (
        <section className="term" key={t.term}>
          <div className="term-head">{TERM_NAME[t.term] ?? `Term ${t.term}`}</div>

          {t.weeks.map((w) => {
            // Show the category heading when it changes within the week.
            let lastCat = null;
            return (
              <div key={`${t.term}-${w.week}`} style={{ marginBottom: 18 }}>
                <span className="week">Week {w.week}</span>
                <div style={{ marginTop: 4 }}>
                  {w.items.map((l) => {
                    const cat = catById.get(l.competency_id);
                    const showCat = cat && cat.id !== lastCat;
                    if (cat) lastCat = cat.id;
                    const objectives = (l.objectives ?? []).sort(
                      (a, b) => a.sequence - b.sequence
                    );
                    const structural = l.lesson_kind !== "content";
                    return (
                      <div key={l.id}>
                        {showCat && (
                          <h3 title={cat.competency_statement ?? undefined}>
                            {cat.category_of_action}
                          </h3>
                        )}
                        <div
                          className={`lesson${structural ? " structural" : ""}`}
                        >
                          <span className="num">{lessonNumber(l)}</span>
                          <div className="title">
                            {l.title}
                            {structural && (
                              <span
                                className={`tag ${
                                  l.lesson_kind === "evaluation" ||
                                  l.lesson_kind === "remediation"
                                    ? "warn"
                                    : ""
                                }`}
                                style={{ marginLeft: 8 }}
                              >
                                {KIND_LABEL[l.lesson_kind] ?? l.lesson_kind}
                              </span>
                            )}
                            {l.is_practical && !structural && (
                              <span className="tag" style={{ marginLeft: 8 }}>
                                Practical
                              </span>
                            )}
                            {objectives.length > 0 && (
                              <ul className="objectives">
                                {objectives.map((o, i) => (
                                  <li key={i}>{o.description}</li>
                                ))}
                              </ul>
                            )}
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>
            );
          })}
        </section>
      ))}
    </>
  );
}
