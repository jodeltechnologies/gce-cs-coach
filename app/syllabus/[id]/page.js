import Link from "next/link";
import { requireTeacher } from "../../../lib/guards";
import {
  ACADEMIC_YEAR,
  breakAfter,
  currentWeek,
  formatRange,
  formatTime,
  lostDays,
  sittingsForWeek,
  timetableFor,
  weekByNumber,
  weeklyLoad,
} from "../../../lib/school-calendar";

export const metadata = { title: "Progression sheet" };

export const dynamic = "force-dynamic";

const KIND_LABEL = {
  diagnostic_evaluation: "Diagnostic",
  integration_activity: "Integration",
  evaluation: "Evaluation",
  remediation: "Remediation",
  practical: "Practical",
  revision: "Revision",
};

const TERM_NAME = { 1: "First term", 2: "Second term", 3: "Third term" };
const DAY_SHORT = ["", "Mon", "Tue", "Wed", "Thu", "Fri"];

function lessonNumber(l) {
  if (l.lesson_no_start === null || l.lesson_no_start === undefined) return "";
  if (l.lesson_no_end && l.lesson_no_end !== l.lesson_no_start) {
    return `${l.lesson_no_start}–${l.lesson_no_end}`;
  }
  return String(l.lesson_no_start);
}

/**
 * The dated header for one week: calendar dates, then the sittings this class
 * actually has, then whatever the official calendar says is happening.
 *
 * A week number on its own is a fiction the teacher has to translate every
 * time. Printing "Week 21 · 8 – 12 Feb 2027 · Thu 11 Feb: no lesson, Youth
 * Day" is the whole point of this change.
 */
function WeekHead({ weekNo, formLevel, isNow }) {
  const cal = weekByNumber(weekNo);
  const days = sittingsForWeek(formLevel, weekNo);

  return (
    <div className={`week-head${isNow ? " now" : ""}`}>
      <div className="week-line">
        <span className="week">Week {weekNo}</span>
        {cal && <span className="week-dates">{formatRange(cal.start, cal.end)}</span>}
        {cal && (
          <span className="week-sub">
            Term {cal.term}, week {cal.termWeek}
          </span>
        )}
        {isNow && <span className="tag alert">This week</span>}
      </div>

      {days.length > 0 && (
        <ul className="sittings">
          {days.map((d) => (
            <li key={d.iso} className={d.closed ? "off" : d.disrupted ? "warn" : ""}>
              <span className="sit-day">{d.label}</span>
              {d.closed ? (
                <span className="sit-note">No lesson — {d.closed}</span>
              ) : (
                <>
                  {d.periods.map((p, i) => (
                    <span className="sit-slot" key={i}>
                      {p.stream ? <b>{p.stream}</b> : null} {p.time}
                    </span>
                  ))}
                  {d.disrupted && <span className="sit-note">{d.disrupted}</span>}
                </>
              )}
            </li>
          ))}
        </ul>
      )}

      {cal?.note && <div className="week-note">{cal.note}</div>}
    </div>
  );
}

function BreakBar({ brk }) {
  return (
    <div className="break-bar">
      <strong>{brk.title}</strong>
      <span>{formatRange(brk.start, brk.end)}</span>
      {brk.note && <span className="break-note">{brk.note}</span>}
    </div>
  );
}

function TimetableCard({ formLevel, prescribed }) {
  const streams = timetableFor(formLevel);
  if (streams.length === 0) return null;
  const load = weeklyLoad(formLevel);
  const lost = lostDays(formLevel);

  // The Ministry states a workload in periods. Comparing it against what the
  // timetable actually gives is the one check on this page that can tell you
  // the sheet is undeliverable before you are eight weeks behind it.
  const short = prescribed
    ? load.filter((l) => l.periods < prescribed)
    : [];

  return (
    <div className="timetable-card">
      <h3>When this class sits</h3>
      <table className="timetable">
        <tbody>
          {streams.map((s, i) => (
            <tr key={i}>
              <th>{s.stream ?? formLevel}</th>
              <td>
                {s.slots.map((slot, j) => (
                  <span className="sit-slot" key={j}>
                    <b>{DAY_SHORT[slot.day]}</b> {formatTime(slot.start, slot.end)}
                  </span>
                ))}
              </td>
              <td className="load">
                {load[i].periods} {load[i].periods === 1 ? "period" : "periods"}
                {prescribed ? (
                  <span className={load[i].periods < prescribed ? "load-short" : "load-ok"}>
                    {load[i].periods < prescribed
                      ? ` of ${prescribed}`
                      : " \u2713"}
                  </span>
                ) : null}
                <span className="load-min"> · {load[i].minutes} min</span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {short.length > 0 && (
        <p className="timetable-short">
          <strong>The sheet asks for {prescribed} periods a week.</strong>{" "}
          {short.length === load.length
            ? `The timetable gives ${short.map((l) => `${l.periods}`).join(" and ")}.`
            : `${short.map((l) => l.stream ?? formLevel).join(" and ")} ${
                short.length === 1 ? "gets" : "get"
              } ${short.map((l) => l.periods).join(" and ")}.`}{" "}
          At that rate the year&apos;s lessons will not fit into the year, which
          is a timetable question rather than a planning one.
        </p>
      )}

      {lost.length > 0 && (
        <p className="timetable-lost">
          {lost.length} teaching {lost.length === 1 ? "day" : "days"} fall on a
          public holiday this year —{" "}
          {lost.map((d, i) => (
            <span key={d.iso}>
              {i > 0 ? "; " : ""}
              week {d.week}, {d.label} ({d.closed})
            </span>
          ))}
          . Worth planning the catch-up before you reach them.
        </p>
      )}
    </div>
  );
}

export default async function SyllabusPage({ params }) {
  const { id } = await params;
  const { supabase } = await requireTeacher();

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
          No progression sheet with that address. <Link href="/">Back to the list</Link>.
        </p>
      </>
    );
  }

  const [{ data: lessons }, { data: competencies }, { data: modules }] =
    await Promise.all([
    supabase
      .from("lessons")
      .select(
        "id, lesson_no_start, lesson_no_end, title, term, week_from, lesson_kind, competency_id, is_practical, status, objectives(description, kind, sequence)"
      )
      .is("deleted_at", null)
      .eq("syllabus_id", id)
      .order("sequence"),
    supabase
      .from("competencies")
      .select("id, category_of_action, competency_statement, sequence, module_id")
      .is("deleted_at", null)
      .eq("syllabus_id", id)
      .order("sequence"),
    supabase
      .from("modules")
      .select("id, title, sequence")
      .is("deleted_at", null)
      .eq("syllabus_id", id)
      .order("sequence"),
  ]);

  const catById = new Map((competencies ?? []).map((c) => [c.id, c]));
  const modById = new Map((modules ?? []).map((m) => [m.id, m]));

  // The 2026/2027 sheets group categories of action under a Module band. A
  // module runs for weeks at a time, so it is announced once, at the row where
  // it turns over. Worked out here in sheet order rather than during render:
  // the render walks week by week, and a per-week variable would reprint the
  // band at the top of every week.
  const moduleStartsAt = new Set();
  let seenModule = null;
  for (const l of lessons ?? []) {
    const m = catById.get(l.competency_id)?.module_id ?? null;
    if (m && m !== seenModule) {
      moduleStartsAt.add(l.id);
      seenModule = m;
    }
  }
  const formLevel = syllabus.form_level;
  const now = currentWeek();

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
        <span className="tag gold">{ACADEMIC_YEAR}</span>
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

      <TimetableCard
        formLevel={formLevel}
        prescribed={syllabus.weekly_periods_theory}
      />

      {terms.map((t) => (
        <section className="term" key={t.term}>
          <div className="term-head">{TERM_NAME[t.term] ?? `Term ${t.term}`}</div>

          {t.weeks.map((w) => {
            // Show the category heading when it changes within the week.
            let lastCat = null;
            const brk = breakAfter(w.week);
            return (
              <div key={`${t.term}-${w.week}`}>
                <div style={{ marginBottom: 18 }}>
                  <WeekHead
                    weekNo={w.week}
                    formLevel={formLevel}
                    isNow={now?.week === w.week}
                  />
                  <div style={{ marginTop: 4 }}>
                    {w.items.map((l) => {
                      const cat = catById.get(l.competency_id);
                      const showCat = cat && cat.id !== lastCat;
                      if (cat) lastCat = cat.id;
                      const mod = modById.get(cat?.module_id);
                      const showMod = moduleStartsAt.has(l.id);
                      const objectives = (l.objectives ?? []).sort(
                        (a, b) => a.sequence - b.sequence
                      );
                      const structural = l.lesson_kind !== "content";
                      return (
                        <div key={l.id}>
                          {showMod && <div className="module-band">{mod.title}</div>}
                          {showCat && (
                            <h3 title={cat.competency_statement ?? undefined}>
                              {cat.category_of_action}
                            </h3>
                          )}
                          <div className={`lesson${structural ? " structural" : ""}`}>
                            <span className="num">{lessonNumber(l)}</span>
                            <div className="title">
                              {l.status === "published" ? (
                                <Link href={`/lesson/${l.id}`}>{l.title}</Link>
                              ) : (
                                l.title
                              )}
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
                {brk && <BreakBar brk={brk} />}
              </div>
            );
          })}
        </section>
      ))}
    </>
  );
}
