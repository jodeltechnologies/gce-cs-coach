/**
 * The 2026/2027 school year, and when this teacher's classes actually sit.
 *
 * Two things live here.
 *
 * 1. The official calendar (ANNEX I, 2026/2027 Synoptic Calendar, visa'd by the
 *    Prime Minister's Office on 13 August 2026). Thirty-six teaching weeks,
 *    numbered 1-36 straight through, which is exactly how `lessons.week_from`
 *    is numbered in the database — so a lesson's week number is an index into
 *    WEEKS with no mapping table needed.
 *
 * 2. The timetable: which day and hour each class is in front of you.
 *
 * Kept as plain data in one file, deliberately. The alternative is a `weeks`
 * table in Supabase, which means a migration every August and a second place
 * for the dates to be wrong. A calendar that changes once a year belongs in
 * the code, where a diff shows what moved.
 *
 * WHEN NEXT YEAR'S CALENDAR ARRIVES: replace ACADEMIC_YEAR, WEEKS, BREAKS and
 * CLOSURES. Nothing else in the app knows these dates.
 */

export const ACADEMIC_YEAR = "2026/2027";

/* ------------------------------------------------------------------ *
 * Days lost. A holiday on a Tuesday or a Thursday costs this teacher a
 * lesson; one on a Friday costs nothing. The page works out which.
 * ------------------------------------------------------------------ */

export const CLOSURES = {
  "2027-01-01": "New Year's Day",
  "2027-02-11": "Youth Day",
  "2027-03-26": "Good Friday",
  "2027-05-06": "Ascension",
  "2027-05-20": "National Day",
};

/* School open, but the timetable is not running normally. */
export const DISRUPTIONS = {
  "2027-03-11": "Open Day",
  "2027-03-12": "Open Day",
  "2027-04-14": "Mock examinations",
  "2027-04-15": "Mock examinations",
  "2027-04-16": "Mock examinations",
};

/* ------------------------------------------------------------------ *
 * The thirty-six weeks.
 * `note` is the thematic day or event the calendar prints for that week.
 * ------------------------------------------------------------------ */

export const WEEKS = [
  // ---- First term ----
  { week: 1,  term: 1, termWeek: 1,  start: "2026-09-07", end: "2026-09-11", note: "Tue 8 Sep: International Literacy Day" },
  { week: 2,  term: 1, termWeek: 2,  start: "2026-09-14", end: "2026-09-18" },
  { week: 3,  term: 1, termWeek: 3,  start: "2026-09-21", end: "2026-09-25" },
  { week: 4,  term: 1, termWeek: 4,  start: "2026-09-28", end: "2026-10-02", note: "Diagnostic assessment week" },
  { week: 5,  term: 1, termWeek: 5,  start: "2026-10-05", end: "2026-10-09", note: "Mon 5 Oct: World Teachers' Day · Fri 9 Oct: National Day for Local Teaching Materials" },
  { week: 6,  term: 1, termWeek: 6,  start: "2026-10-12", end: "2026-10-16", note: "Thu 15 Oct: World Handwashing Day · Fri 16 Oct: National School Guidance Day" },
  { week: 7,  term: 1, termWeek: 7,  start: "2026-10-19", end: "2026-10-23" },
  { week: 8,  term: 1, termWeek: 8,  start: "2026-10-26", end: "2026-10-30", note: "Formative assessment" },
  { week: 9,  term: 1, termWeek: 9,  start: "2026-11-02", end: "2026-11-06" },
  { week: 10, term: 1, termWeek: 10, start: "2026-11-09", end: "2026-11-13" },
  { week: 11, term: 1, termWeek: 11, start: "2026-11-16", end: "2026-11-20" },
  { week: 12, term: 1, termWeek: 12, start: "2026-11-23", end: "2026-11-27", note: "Summative assessment T1 and end-of-term examination · Thu 26 Nov: World Philosophy Day", endsTerm: true },

  // ---- Second term ----
  { week: 13, term: 2, termWeek: 1,  start: "2026-11-30", end: "2026-12-04" },
  { week: 14, term: 2, termWeek: 2,  start: "2026-12-07", end: "2026-12-11" },
  { week: 15, term: 2, termWeek: 3,  start: "2026-12-14", end: "2026-12-18", note: "Leave for holidays Fri 18 Dec at 3:30 p.m." },
  { week: 16, term: 2, termWeek: 4,  start: "2027-01-04", end: "2027-01-08", note: "Classes resume Mon 4 Jan at 7:30 a.m." },
  { week: 17, term: 2, termWeek: 5,  start: "2027-01-11", end: "2027-01-15" },
  { week: 18, term: 2, termWeek: 6,  start: "2027-01-18", end: "2027-01-22" },
  { week: 19, term: 2, termWeek: 7,  start: "2027-01-25", end: "2027-01-29", note: "National Bilingualism Week" },
  { week: 20, term: 2, termWeek: 8,  start: "2027-02-01", end: "2027-02-05", note: "Formative assessment · Youth Week begins 3 Feb" },
  { week: 21, term: 2, termWeek: 9,  start: "2027-02-08", end: "2027-02-12", note: "Youth Week continues to 11 Feb" },
  { week: 22, term: 2, termWeek: 10, start: "2027-02-15", end: "2027-02-19" },
  { week: 23, term: 2, termWeek: 11, start: "2027-02-22", end: "2027-02-26", note: "Sun 21 Feb: International Mother Language Day" },
  { week: 24, term: 2, termWeek: 12, start: "2027-03-01", end: "2027-03-05", note: "Summative assessment T2 and end-of-term examination · Fri 5 Mar: National Arts and Culture Day", endsTerm: true },

  // ---- Third term ----
  { week: 25, term: 3, termWeek: 1,  start: "2027-03-08", end: "2027-03-12", note: "Open Days Thu 11 – Fri 12 Mar · Mon 8 Mar: International Women's Day" },
  { week: 26, term: 3, termWeek: 2,  start: "2027-03-15", end: "2027-03-19", note: "Sat 20 Mar: Francophonie Day" },
  { week: 27, term: 3, termWeek: 3,  start: "2027-03-22", end: "2027-03-25", note: "Short week — departure Thu 25 Mar at 3:30 p.m." },
  { week: 28, term: 3, termWeek: 4,  start: "2027-04-12", end: "2027-04-16", note: "Classes resume Mon 12 Apr · Mock examinations 14–17 Apr" },
  { week: 29, term: 3, termWeek: 5,  start: "2027-04-19", end: "2027-04-23", note: "Official secondary school examinations begin Mon 19 Apr", examPeriod: true },
  { week: 30, term: 3, termWeek: 6,  start: "2027-04-26", end: "2027-04-30", note: "Official examinations continue · PE practical tests 26 Apr – 7 May", examPeriod: true },
  { week: 31, term: 3, termWeek: 7,  start: "2027-05-03", end: "2027-05-07", note: "Internal examinations 3–21 May · PE practicals end 7 May", examPeriod: true },
  { week: 32, term: 3, termWeek: 8,  start: "2027-05-10", end: "2027-05-14", note: "Official primary examinations from 10 May", examPeriod: true },
  { week: 33, term: 3, termWeek: 9,  start: "2027-05-17", end: "2027-05-21", note: "Official and internal examinations", examPeriod: true },
  { week: 34, term: 3, termWeek: 10, start: "2027-05-24", end: "2027-05-28", note: "Results and deliberations", examPeriod: true },
  { week: 35, term: 3, termWeek: 11, start: "2027-05-31", end: "2027-06-04", note: "Results and deliberations · Sat 5 Jun: World Environment Day", examPeriod: true },
  { week: 36, term: 3, termWeek: 12, start: "2027-06-07", end: "2027-06-11", note: "Teaching stops Fri 11 June at 3:30 p.m.", endsTerm: true },
];

/* Holidays, shown between the weeks they separate. */
export const BREAKS = [
  { afterWeek: 15, title: "First break", start: "2026-12-18", end: "2027-01-04", note: "Christmas 25 Dec · New Year 1 Jan" },
  { afterWeek: 27, title: "Second break", start: "2027-03-25", end: "2027-04-12", note: "Good Friday 26 Mar · Easter 28 Mar" },
];

/* ------------------------------------------------------------------ *
 * The school day.
 *
 * Straight off the aSc timetable sheet. Ten periods, fifty minutes each
 * except period 9, which is thirty because break has to come out of
 * somewhere. This is the ruler everything else is measured against: a class
 * block is not "80 minutes", it is periods 9 and 10.
 * ------------------------------------------------------------------ */

export const SCHOOL = {
  name: "Government High School Mbonjo",
  town: "Limbe",
  teacher: "Ngwana Joshua",
};

export const PERIODS = [
  { no: 1,  start: "07:30", end: "08:20" },
  { no: 2,  start: "08:20", end: "09:10" },
  { no: 3,  start: "09:10", end: "10:00" },
  { no: 4,  start: "10:00", end: "10:50" },
  { no: null, start: "10:50", end: "11:20", isBreak: true },
  { no: 5,  start: "11:20", end: "12:10" },
  { no: 6,  start: "12:10", end: "13:00" },
  { no: 7,  start: "13:00", end: "13:50" },
  { no: 8,  start: "13:50", end: "14:40" },
  { no: 9,  start: "14:40", end: "15:10" },
  { no: 10, start: "15:10", end: "16:00" },
];

export const DAYS = [
  { day: 1, name: "Monday", short: "Mon" },
  { day: 2, name: "Tuesday", short: "Tue" },
  { day: 3, name: "Wednesday", short: "Wed" },
  { day: 4, name: "Thursday", short: "Thu" },
  { day: 5, name: "Friday", short: "Fri" },
];

/* ------------------------------------------------------------------ *
 * The teaching load.
 *
 * `day` is 1 = Monday through 5 = Friday. Times are 24-hour so they sort
 * and subtract; the display turns them back into the a.m./p.m. everyone
 * actually says.
 * ------------------------------------------------------------------ */

export const CLASSES = [
  {
    label: "Form 5A",
    formLevel: "Form 5",
    stream: "5A",
    subject: "Computer Science",
    short: "CSC",
    slots: [
      { day: 2, start: "14:40", end: "16:00" },
      { day: 4, start: "11:20", end: "12:10" },
    ],
  },
  {
    label: "Form 5B",
    formLevel: "Form 5",
    stream: "5B",
    subject: "Computer Science",
    short: "CSC",
    slots: [
      { day: 2, start: "11:20", end: "13:00" },
      { day: 4, start: "13:50", end: "14:40" },
    ],
  },
  {
    label: "Lower Sixth",
    formLevel: "Lower Sixth",
    stream: null,
    subject: "ICT",
    short: "ICT",
    slots: [{ day: 4, start: "09:10", end: "10:50" }],
  },
];

/** Kept in the old shape, because the progression sheet reads it that way. */
export const TIMETABLE = CLASSES.reduce((acc, c) => {
  (acc[c.formLevel] ??= []).push({ stream: c.stream, slots: c.slots });
  return acc;
}, {});

/* Form 4 has no timetable yet. Returning [] is the honest answer, and the
   page then shows dates without inventing periods that do not exist. */
export function timetableFor(formLevel) {
  return TIMETABLE[formLevel] ?? [];
}

/* ------------------------------------------------------------------ *
 * Dates
 * ------------------------------------------------------------------ */

const DAY_NAME = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const MONTH_NAME = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
];

/** "2026-09-07" -> a Date at local midnight. Never `new Date(string)`: that
 *  parses as UTC and lands on the 6th for anyone west of Greenwich. */
export function parseISO(iso) {
  const [y, m, d] = iso.split("-").map(Number);
  return new Date(y, m - 1, d);
}

export function toISO(date) {
  const m = String(date.getMonth() + 1).padStart(2, "0");
  const d = String(date.getDate()).padStart(2, "0");
  return `${date.getFullYear()}-${m}-${d}`;
}

export function formatDay(date, { year = false } = {}) {
  const s = `${DAY_NAME[date.getDay()]} ${date.getDate()} ${MONTH_NAME[date.getMonth()]}`;
  return year ? `${s} ${date.getFullYear()}` : s;
}

/** "7–11 Sep 2026", "28 Sep – 2 Oct 2026", "31 May – 4 Jun 2027". */
export function formatRange(startISO, endISO) {
  const a = parseISO(startISO);
  const b = parseISO(endISO);
  const sameMonth = a.getMonth() === b.getMonth() && a.getFullYear() === b.getFullYear();
  const sameYear = a.getFullYear() === b.getFullYear();
  const left = sameMonth
    ? `${a.getDate()}`
    : `${a.getDate()} ${MONTH_NAME[a.getMonth()]}${sameYear ? "" : ` ${a.getFullYear()}`}`;
  const right = `${b.getDate()} ${MONTH_NAME[b.getMonth()]} ${b.getFullYear()}`;
  return `${left} – ${right}`;
}

/** "2:40 – 4:00 p.m." or "11:20 a.m. – 1:00 p.m." */
export function formatTime(start, end) {
  const part = (hhmm) => {
    const [h, m] = hhmm.split(":").map(Number);
    const h12 = h % 12 === 0 ? 12 : h % 12;
    return { text: `${h12}:${String(m).padStart(2, "0")}`, pm: h >= 12 };
  };
  const a = part(start);
  const b = part(end);
  const suffix = (pm) => (pm ? "p.m." : "a.m.");
  return a.pm === b.pm
    ? `${a.text} – ${b.text} ${suffix(b.pm)}`
    : `${a.text} ${suffix(a.pm)} – ${b.text} ${suffix(b.pm)}`;
}

export function minutesBetween(start, end) {
  const [h1, m1] = start.split(":").map(Number);
  const [h2, m2] = end.split(":").map(Number);
  return h2 * 60 + m2 - (h1 * 60 + m1);
}

/* ------------------------------------------------------------------ *
 * Weeks
 * ------------------------------------------------------------------ */

export function weekByNumber(n) {
  return WEEKS.find((w) => w.week === n) ?? null;
}

export function breakAfter(n) {
  return BREAKS.find((b) => b.afterWeek === n) ?? null;
}

/** The week containing `today`, or the next one if today is in a break or
 *  before the year starts. Null once the year is over. */
export function currentWeek(today = new Date()) {
  const iso = toISO(today);
  for (const w of WEEKS) {
    if (iso >= w.start && iso <= w.end) return w;
  }
  for (const w of WEEKS) {
    if (iso < w.start) return w;
  }
  return null;
}

/**
 * Every time this class sits in a given week, in timetable order, with the
 * real date attached and a reason if it is not going to happen.
 *
 * Returns one entry per day, each carrying the streams that meet that day, so
 * a Thursday reads as one line rather than three.
 */
export function sittingsForWeek(formLevel, weekNo) {
  const week = weekByNumber(weekNo);
  const streams = timetableFor(formLevel);
  if (!week || streams.length === 0) return [];

  const monday = parseISO(week.start);
  const lastDay = parseISO(week.end);
  const byDay = new Map();

  for (const s of streams) {
    for (const slot of s.slots) {
      const date = new Date(monday);
      date.setDate(monday.getDate() + (slot.day - 1));
      if (date > lastDay) continue; // short week — the day is not in the term

      const iso = toISO(date);
      if (!byDay.has(iso)) {
        byDay.set(iso, {
          iso,
          date,
          label: formatDay(date),
          closed: CLOSURES[iso] ?? null,
          disrupted: DISRUPTIONS[iso] ?? null,
          periods: [],
        });
      }
      byDay.get(iso).periods.push({
        stream: s.stream,
        start: slot.start,
        end: slot.end,
        time: formatTime(slot.start, slot.end),
        minutes: minutesBetween(slot.start, slot.end),
      });
    }
  }

  const days = [...byDay.values()].sort((a, b) => a.date - b.date);
  for (const d of days) d.periods.sort((a, b) => a.start.localeCompare(b.start));
  return days;
}

/** Contact minutes per stream per week, for the header. */
export function weeklyLoad(formLevel) {
  return timetableFor(formLevel).map((s) => ({
    stream: s.stream,
    minutes: s.slots.reduce((t, x) => t + minutesBetween(x.start, x.end), 0),
    slots: s.slots.length,
  }));
}

/* ------------------------------------------------------------------ *
 * The weekly grid
 * ------------------------------------------------------------------ */

/** Which entries of PERIODS a block covers, by index. */
function periodSpan(start, end) {
  const out = [];
  PERIODS.forEach((p, i) => {
    if (p.start >= start && p.end <= end) out.push(i);
  });
  return out;
}

/**
 * The timetable as a table: one row per weekday, each row a list of cells in
 * column order. A cell is either a class block (with the number of columns it
 * spans), the break, or a free period.
 *
 * Built rather than hand-written, so that changing a time in CLASSES moves the
 * block on the grid too. Two versions of the same truth is how a timetable
 * ends up disagreeing with itself.
 */
export function weekGrid() {
  return DAYS.map(({ day, name, short }) => {
    const cells = [];
    let i = 0;

    while (i < PERIODS.length) {
      const p = PERIODS[i];

      if (p.isBreak) {
        cells.push({ kind: "break", span: 1, start: p.start, end: p.end });
        i += 1;
        continue;
      }

      const cls = CLASSES.find((c) =>
        c.slots.some((s) => s.day === day && s.start === p.start)
      );
      if (cls) {
        const slot = cls.slots.find((s) => s.day === day && s.start === p.start);
        const span = periodSpan(slot.start, slot.end);
        cells.push({
          kind: "class",
          span: span.length || 1,
          label: cls.label,
          subject: cls.subject,
          short: cls.short,
          formLevel: cls.formLevel,
          start: slot.start,
          end: slot.end,
          time: formatTime(slot.start, slot.end),
          minutes: minutesBetween(slot.start, slot.end),
          periods: span.map((k) => PERIODS[k].no).filter(Boolean),
        });
        i += span.length || 1;
        continue;
      }

      cells.push({ kind: "free", span: 1, start: p.start, end: p.end, no: p.no });
      i += 1;
    }

    const teaching = cells.filter((c) => c.kind === "class");
    return {
      day,
      name,
      short,
      cells,
      teaching,
      periods: teaching.reduce((t, c) => t + c.span, 0),
      minutes: teaching.reduce((t, c) => t + c.minutes, 0),
    };
  });
}

/** Periods and minutes per subject, and the totals underneath. */
export function loadSummary() {
  const bySubject = new Map();
  let periods = 0;
  let minutes = 0;

  for (const c of CLASSES) {
    for (const s of c.slots) {
      const n = periodSpan(s.start, s.end).length || 1;
      const m = minutesBetween(s.start, s.end);
      const row = bySubject.get(c.subject) ?? { subject: c.subject, periods: 0, minutes: 0, classes: new Set() };
      row.periods += n;
      row.minutes += m;
      row.classes.add(c.label);
      bySubject.set(c.subject, row);
      periods += n;
      minutes += m;
    }
  }

  return {
    subjects: [...bySubject.values()].map((r) => ({ ...r, classes: [...r.classes] })),
    periods,
    minutes,
    teachingDays: new Set(CLASSES.flatMap((c) => c.slots.map((s) => s.day))).size,
  };
}

/**
 * The next time this teacher is due in front of a class, with the real date.
 *
 * Walks forward day by day from `from` to the end of the year, skipping breaks
 * and public holidays, and stops at the first block that has not started yet.
 * Null once the year is over.
 */
export function nextLesson(from = new Date()) {
  const grid = weekGrid();
  const nowISO = toISO(from);
  const nowMin = from.getHours() * 60 + from.getMinutes();

  for (const w of WEEKS) {
    if (w.end < nowISO) continue;
    const monday = parseISO(w.start);
    const lastDay = parseISO(w.end);

    for (const row of grid) {
      if (row.teaching.length === 0) continue;
      const date = new Date(monday);
      date.setDate(monday.getDate() + (row.day - 1));
      if (date > lastDay) continue;

      const iso = toISO(date);
      if (iso < nowISO) continue;
      if (CLOSURES[iso]) continue;

      for (const cell of row.teaching) {
        const [h, m] = cell.start.split(":").map(Number);
        if (iso === nowISO && h * 60 + m <= nowMin) continue;
        return {
          ...cell,
          week: w.week,
          term: w.term,
          termWeek: w.termWeek,
          iso,
          date,
          dayLabel: formatDay(date),
          disrupted: DISRUPTIONS[iso] ?? null,
        };
      }
    }
  }
  return null;
}

/** Teaching days this class loses to public holidays across the whole year. */
export function lostDays(formLevel) {
  const out = [];
  for (const w of WEEKS) {
    for (const d of sittingsForWeek(formLevel, w.week)) {
      if (d.closed) out.push({ week: w.week, ...d });
    }
  }
  return out;
}
