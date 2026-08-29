import { createClient, getUser } from "../../../../lib/supabase-server";
import { saveScheme } from "../actions";

export const metadata = { title: "Term planner" };

export const dynamic = "force-dynamic";

const TERM_NAME = { 1: "First term", 2: "Second term", 3: "Third term" };

const KIND_LABEL = {
  diagnostic_evaluation: "Diagnostic",
  integration_activity: "Integration",
  evaluation: "Evaluation",
  remediation: "Remediation",
  practical: "Practical",
};

const STATUSES = [
  { value: "planned", label: "Planned" },
  { value: "taught", label: "Taught" },
  { value: "postponed", label: "Postponed" },
  { value: "skipped", label: "Skipped" },
];

const selectStyle = {
  padding: "6px 8px",
  fontSize: "0.85rem",
  borderRadius: 7,
  border: "1px solid var(--line)",
  background: "var(--surface)",
  color: "var(--ink)",
};

export default async function ClassPlanner({ params, searchParams }) {
  const { id } = await params;
  const sp = await searchParams;
  const term = Number(sp?.term ?? 1) || 1;

  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const user = await getUser();
  const { data: teacher } = await supabase
    .from("teachers")
    .select("id")
    .eq("auth_user_id", user?.id ?? "")
    .maybeSingle();
  if (!teacher) {
    return (
      <div className="notice bad">
        <h3>Account not linked</h3>
        <p>
          Go back to <a href="/admin">Admin</a> for the fix.
        </p>
      </div>
    );
  }

  const { data: klass } = await supabase
    .from("classes")
    .select("id, name, form_level, academic_year, exam_year, syllabus_id")
    .eq("id", id)
    .maybeSingle();

  if (!klass) {
    return (
      <>
        <h2>Class not found</h2>
        <p className="lede">
          <a href="/admin/classes">Back to classes</a>
        </p>
      </>
    );
  }

  const [{ data: allLessons }, { data: entries }, { data: competencies }] =
    await Promise.all([
      supabase
        .from("lessons")
        .select(
          "id, sequence, lesson_no_start, lesson_no_end, title, term, week_from, lesson_kind, competency_id"
        )
        .eq("syllabus_id", klass.syllabus_id)
        .order("sequence"),
      supabase
        .from("scheme_entries")
        .select("lesson_id, status, actual_week, observation")
        .eq("class_id", klass.id),
      supabase
        .from("competencies")
        .select("id, category_of_action, exam_frequency")
        .eq("syllabus_id", klass.syllabus_id),
    ]);

  const lessons = allLessons ?? [];
  const byLesson = new Map((entries ?? []).map((e) => [e.lesson_id, e]));
  const catById = new Map((competencies ?? []).map((c) => [c.id, c]));

  // ---- the numbers worth showing at the top --------------------------------

  const contentLessons = lessons.filter((l) => l.lesson_kind === "content");
  const taught = lessons.filter((l) => byLesson.get(l.id)?.status === "taught");
  const taughtContent = taught.filter((l) => l.lesson_kind === "content");

  const lastTaught = taught.length
    ? taught.reduce((a, b) => (a.sequence > b.sequence ? a : b))
    : null;

  let slippage = null;
  if (lastTaught) {
    const actual = byLesson.get(lastTaught.id)?.actual_week;
    if (actual != null && lastTaught.week_from != null) {
      slippage = actual - lastTaught.week_from;
    }
  }

  const nextEvaluation = lessons.find(
    (l) =>
      l.lesson_kind === "evaluation" &&
      (!lastTaught || l.sequence > lastTaught.sequence)
  );

  const contentBeforeEvaluation = nextEvaluation
    ? contentLessons.filter(
        (l) =>
          l.sequence < nextEvaluation.sequence &&
          (!lastTaught || l.sequence > lastTaught.sequence)
      ).length
    : null;

  const termLessons = lessons.filter((l) => l.term === term);

  // group by week, preserving sheet order
  const weeks = [];
  for (const l of termLessons) {
    let w = weeks[weeks.length - 1];
    if (!w || w.week !== l.week_from) {
      w = { week: l.week_from, items: [] };
      weeks.push(w);
    }
    w.items.push(l);
  }

  return (
    <>
      <h2>{klass.name}</h2>
      <p className="lede">
        {klass.form_level} · {klass.academic_year}
        {klass.exam_year ? ` · sits GCE ${klass.exam_year}` : ""}
      </p>

      <div className="tags" style={{ marginBottom: 6 }}>
        <span className="tag">
          {taughtContent.length} of {contentLessons.length} lessons taught
        </span>

        {slippage === null ? (
          <span className="tag plain">No week recorded yet</span>
        ) : slippage > 0 ? (
          <span className="tag alert">
            {slippage} {slippage === 1 ? "week" : "weeks"} behind
          </span>
        ) : slippage < 0 ? (
          <span className="tag">{-slippage} ahead</span>
        ) : (
          <span className="tag">On schedule</span>
        )}

        {nextEvaluation && (
          <span className="tag gold">
            Next Evaluation: week {nextEvaluation.week_from}
            {contentBeforeEvaluation != null &&
              ` · ${contentBeforeEvaluation} lessons to cover first`}
          </span>
        )}
      </div>

      <p className="lede" style={{ fontSize: "0.84rem" }}>
        {slippage !== null && slippage > 0
          ? `Your last taught lesson was prescribed for week ${lastTaught.week_from} and you taught it in week ${byLesson.get(lastTaught.id)?.actual_week}.`
          : "Mark a lesson taught and record the week you actually taught it — that is what tells you how far behind the sheet you are."}
      </p>

      <div style={{ display: "flex", gap: 8, margin: "22px 0 4px" }}>
        {[1, 2, 3].map((t) => (
          <a
            key={t}
            href={`/admin/classes/${klass.id}?term=${t}`}
            className={t === term ? "tag" : "tag plain"}
            style={{ padding: "6px 14px", fontSize: "0.82rem" }}
          >
            {TERM_NAME[t]}
          </a>
        ))}
      </div>

      <form action={saveScheme}>
        <input type="hidden" name="class_id" value={klass.id} />
        <input type="hidden" name="term" value={term} />

        {weeks.map((w) => {
          let lastCat = null;
          return (
            <section className="term" key={w.week}>
              <span className="week">Week {w.week}</span>
              <div style={{ marginTop: 8 }}>
                {w.items.map((l) => {
                  const cat = catById.get(l.competency_id);
                  const showCat = cat && cat.id !== lastCat;
                  if (cat) lastCat = cat.id;
                  const entry = byLesson.get(l.id);
                  const structural = l.lesson_kind !== "content";
                  const num =
                    l.lesson_no_start == null
                      ? ""
                      : l.lesson_no_end && l.lesson_no_end !== l.lesson_no_start
                        ? `${l.lesson_no_start}–${l.lesson_no_end}`
                        : String(l.lesson_no_start);

                  return (
                    <div key={l.id}>
                      {showCat && (
                        <h3>
                          {cat.category_of_action}
                          {cat.exam_frequency && (
                            <span className="tag gold" style={{ marginLeft: 8 }}>
                              {cat.exam_frequency.replace("_", " ")}
                            </span>
                          )}
                        </h3>
                      )}
                      <div className="row">
                        <div className="name">
                          <span
                            style={{
                              color: "var(--muted)",
                              fontSize: "0.8rem",
                              marginRight: 8,
                            }}
                          >
                            {num}
                          </span>
                          <span style={structural ? { fontStyle: "italic" } : undefined}>
                            {l.title}
                          </span>
                          {structural && (
                            <span
                              className={
                                l.lesson_kind === "evaluation" ||
                                l.lesson_kind === "remediation"
                                  ? "tag alert"
                                  : "tag"
                              }
                              style={{ marginLeft: 8 }}
                            >
                              {KIND_LABEL[l.lesson_kind] ?? l.lesson_kind}
                            </span>
                          )}
                        </div>

                        <div
                          style={{
                            display: "flex",
                            gap: 8,
                            marginTop: 8,
                            flexWrap: "wrap",
                            alignItems: "center",
                          }}
                        >
                          <select
                            name={`status:${l.id}`}
                            defaultValue={entry?.status ?? "planned"}
                            style={selectStyle}
                          >
                            {STATUSES.map((s) => (
                              <option key={s.value} value={s.value}>
                                {s.label}
                              </option>
                            ))}
                          </select>

                          <input
                            type="text"
                            name={`week:${l.id}`}
                            defaultValue={entry?.actual_week ?? ""}
                            placeholder={`wk ${l.week_from}`}
                            inputMode="numeric"
                            style={{ ...selectStyle, width: 76 }}
                          />

                          <input
                            type="text"
                            name={`obs:${l.id}`}
                            defaultValue={entry?.observation ?? ""}
                            placeholder="Observation"
                            style={{ ...selectStyle, flex: 1, minWidth: 140 }}
                          />
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </section>
          );
        })}

        <div className="sticky-save">
          <button className="primary" type="submit">
            Save {TERM_NAME[term].toLowerCase()}
          </button>
          <span
            style={{ marginLeft: 12, fontSize: "0.82rem", color: "var(--muted)" }}
          >
            One save for the whole term.
          </span>
        </div>
      </form>

      <p className="lede" style={{ marginTop: 26 }}>
        <a href="/admin/classes">Back to classes</a>
      </p>
    </>
  );
}
