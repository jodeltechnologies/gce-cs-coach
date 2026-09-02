import Link from "next/link";
import { createClient } from "../../../lib/supabase-server";
import {
  ACADEMIC_YEAR,
  CLASSES,
  CLOSURES,
  DISRUPTIONS,
  PERIODS,
  SCHOOL,
  currentWeek,
  formatDay,
  formatRange,
  formatTime,
  loadSummary,
  nextLesson,
  parseISO,
  toISO,
  weekGrid,
} from "../../../lib/school-calendar";

export const metadata = { title: "My timetable" };
export const dynamic = "force-dynamic";

/**
 * The week as a grid, one row per day, one column per period.
 *
 * Wrapped in its own horizontal scroller. Eleven columns will not fit on a
 * phone at a readable size, and the fix is to let this one box slide rather
 * than shrink the type to nothing or push the whole page sideways.
 */
function Grid({ todayDay }) {
  const grid = weekGrid();

  return (
    <div className="tt-scroll">
      <table className="tt">
        <thead>
          <tr>
            <th className="tt-corner" />
            {PERIODS.map((p, i) => (
              <th key={i} className={p.isBreak ? "tt-break-col" : ""}>
                <span className="tt-no">{p.isBreak ? "" : p.no}</span>
                <span className="tt-time">
                  {p.isBreak ? "Break" : `${p.start}–${p.end}`}
                </span>
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          {grid.map((row) => (
            <tr key={row.day} className={row.day === todayDay ? "tt-today" : ""}>
              <th className="tt-day">
                <span className="tt-day-name">{row.short}</span>
                {row.periods > 0 && (
                  <span className="tt-day-count">{row.periods}p</span>
                )}
              </th>
              {row.cells.map((c, i) => {
                if (c.kind === "break") {
                  return (
                    <td key={i} className="tt-break-col">
                      <span className="tt-break-mark" />
                    </td>
                  );
                }
                if (c.kind === "free") {
                  return <td key={i} className="tt-free" />;
                }
                return (
                  <td
                    key={i}
                    colSpan={c.span}
                    className={`tt-block tt-${c.short.toLowerCase()}`}
                  >
                    <span className="tt-block-class">{c.label}</span>
                    <span className="tt-block-sub">{c.short}</span>
                    {/* A one-period block is only 68px wide and the column
                        header above it already gives the time. Print it only
                        on the wide blocks, where the span is the thing you
                        want to see. */}
                    {c.span > 1 && (
                      <span className="tt-block-time">
                        {c.start}–{c.end}
                      </span>
                    )}
                  </td>
                );
              })}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default async function TimetablePage() {
  const supabase = await createClient();

  // Only to turn "Form 5" into a link. A missing sheet is not an error here —
  // the timetable is still the timetable without it.
  let syllabusByLevel = new Map();
  if (supabase) {
    const { data } = await supabase.from("syllabi").select("id, form_level");
    syllabusByLevel = new Map((data ?? []).map((s) => [s.form_level, s.id]));
  }

  const now = new Date();
  const todayISO = toISO(now);
  const todayDay = now.getDay() >= 1 && now.getDay() <= 5 ? now.getDay() : null;
  const week = currentWeek(now);
  const next = nextLesson(now);
  const load = loadSummary();
  const grid = weekGrid();
  const teachingDays = grid.filter((r) => r.teaching.length > 0);

  const closedToday = CLOSURES[todayISO] ?? null;
  const disruptedToday = DISRUPTIONS[todayISO] ?? null;
  const todayRow = grid.find((r) => r.day === todayDay) ?? null;
  const inTerm = week && todayISO >= week.start && todayISO <= week.end;

  return (
    <>
      <h2>My timetable</h2>
      <p className="lede">
        {SCHOOL.teacher} · {SCHOOL.name}, {SCHOOL.town} · {ACADEMIC_YEAR}
      </p>

      <div className="tags" style={{ marginBottom: 20 }}>
        <span className="tag">{load.periods} periods a week</span>
        <span className="tag plain">
          {Math.floor(load.minutes / 60)} h {load.minutes % 60} min contact
        </span>
        <span className="tag plain">
          {load.teachingDays} teaching {load.teachingDays === 1 ? "day" : "days"}
        </span>
        <span className="tag plain">{CLASSES.length} classes</span>
      </div>

      {/* Today, or the next time you are due in a room. */}
      <div className="notice tt-next">
        {inTerm && todayRow && todayRow.teaching.length > 0 && !closedToday ? (
          <>
            <h3>Today — {formatDay(now)}</h3>
            <ul className="sittings" style={{ margin: 0 }}>
              {todayRow.teaching.map((c, i) => (
                <li key={i}>
                  <span className="sit-day">{c.label}</span>
                  <span className="sit-slot">
                    <b>P{c.periods.join("+")}</b> {c.time}
                  </span>
                  <span className="sit-slot">{c.subject}</span>
                </li>
              ))}
            </ul>
            {disruptedToday && (
              <p style={{ margin: "10px 0 0", fontSize: "0.82rem" }}>
                {disruptedToday} — the timetable may not run as printed.
              </p>
            )}
          </>
        ) : closedToday ? (
          <>
            <h3>No school today — {closedToday}</h3>
            {next && (
              <p style={{ margin: 0 }}>
                Next in front of a class: <strong>{next.dayLabel}</strong>,{" "}
                {next.time} — {next.label}
              </p>
            )}
          </>
        ) : next ? (
          <>
            <h3>Next lesson</h3>
            <p style={{ margin: 0 }}>
              <strong>{next.dayLabel}</strong>, {next.time} —{" "}
              <strong>{next.label}</strong>, {next.subject}, period{" "}
              {next.periods.join(" and ")}. That is week {next.week} of the
              year, term {next.term} week {next.termWeek}.
              {next.disrupted ? ` ${next.disrupted} that day.` : ""}
            </p>
          </>
        ) : (
          <>
            <h3>The year is over</h3>
            <p style={{ margin: 0 }}>
              No teaching left on the {ACADEMIC_YEAR} calendar.
            </p>
          </>
        )}
      </div>

      {week && (
        <p className="lede" style={{ marginTop: -6 }}>
          {inTerm ? "This week" : "Next up"}: week {week.week},{" "}
          {formatRange(week.start, week.end)} — term {week.term}, week{" "}
          {week.termWeek}.
        </p>
      )}

      <Grid todayDay={inTerm ? todayDay : null} />

      <h3 style={{ marginTop: 28 }}>Your teaching days</h3>
      {teachingDays.map((row) => (
        <div className="row" key={row.day} style={{ display: "block" }}>
          <div className="name">
            {row.name}
            <span className="tag plain" style={{ marginLeft: 10 }}>
              {row.periods} periods · {row.minutes} min
            </span>
          </div>
          <ul className="sittings" style={{ marginTop: 8 }}>
            {row.teaching.map((c, i) => {
              const sid = syllabusByLevel.get(c.formLevel);
              return (
                <li key={i}>
                  <span className="sit-day">{c.label}</span>
                  <span className="sit-slot">
                    <b>P{c.periods.join("+")}</b> {c.time}
                  </span>
                  <span className="sit-slot">{c.minutes} min</span>
                  <span className="sit-slot">
                    {sid ? (
                      <Link href={`/syllabus/${sid}`}>{c.subject} sheet</Link>
                    ) : (
                      c.subject
                    )}
                  </span>
                </li>
              );
            })}
          </ul>
        </div>
      ))}

      <h3 style={{ marginTop: 28 }}>Load</h3>
      <div className="tt-scroll">
        <table className="tt-load">
          <thead>
            <tr>
              <th>Subject</th>
              <th>Classes</th>
              <th>Periods</th>
              <th>Minutes</th>
            </tr>
          </thead>
          <tbody>
            {load.subjects.map((s) => (
              <tr key={s.subject}>
                <td>{s.subject}</td>
                <td>{s.classes.join(", ")}</td>
                <td className="num">{s.periods}</td>
                <td className="num">{s.minutes}</td>
              </tr>
            ))}
            <tr className="tt-total">
              <td>Total</td>
              <td>{CLASSES.length} classes</td>
              <td className="num">{load.periods}</td>
              <td className="num">{load.minutes}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <p style={{ fontSize: "0.8rem", color: "var(--muted)", marginTop: 20 }}>
        Periods 1–8 and 10 run fifty minutes; period 9 runs thirty, which is
        where break comes from. The grid is built from the same times the
        progression sheets use, so a change in one shows up in the other.
      </p>
    </>
  );
}
