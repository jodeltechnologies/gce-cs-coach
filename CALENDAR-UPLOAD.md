# Dates on the progression sheet, and a timetable page

Eight files. All of it is GitHub — **no SQL, no Supabase, no new setting in
Vercel**. About five minutes.

This replaces the earlier download. If you already uploaded that one, upload
this over the top; if you have not, this is the complete set and you can skip
the old one entirely.

---

## What is in the download

| File | New or replaces |
|---|---|
| `lib/school-calendar.js` | **New** — the 2026/2027 calendar, the school day, your timetable |
| `app/admin/timetable/page.js` | **New** — the timetable page |
| `app/admin/AdminNav.js` | Replaces — adds **My timetable** to the menu |
| `app/globals.css` | Replaces |
| `app/syllabus/[id]/page.js` | Replaces |
| `app/lesson/[id]/page.js` | Replaces |
| `app/admin/lessons/page.js` | Replaces |
| `app/admin/lessons/[id]/page.js` | Replaces |

---

## Upload

Sign in at **github.com**, open your `gce-cs-coach` repository.

1. Click **Add file** (top right, beside the green Code button) → **Upload
   files**.
2. Drag **both** the `lib` folder and the `app` folder from the download into
   the dashed box, together. GitHub keeps the folder structure and overwrites
   only the eight files above — everything else in `app/` is untouched.
3. Under **Commit changes**, type: `Timetable page and dated progression sheets`
4. Click **Commit changes**.

Vercel sees the commit and rebuilds. Two or three minutes; open **vercel.com** →
your project → **Deployments** if you want to watch it say **Ready**.

If dragging two folders at once misbehaves in your browser, do `lib` first,
commit, then `app`, commit. Two commits, same result.

---

## What to check

### The timetable — **Admin → My timetable**

The full week as a grid: ten periods across, Monday to Friday down, break as a
dashed gutter. Computer Science blocks in navy, ICT in gold. A two-period block
covers two columns, the way it does on the aSc sheet.

Above it, one of three things depending on the day:

- **Today** — your blocks for today, if there are any.
- **No school today** — on a public holiday, with the next lesson underneath.
- **Next lesson** — otherwise, with the real date and the week number.

It skips holidays properly. On Thursday 11 February it will not offer you a
Thursday lesson; it jumps to Tuesday 16 February.

Underneath: your two teaching days written out with full times and a link
through to each progression sheet, then the load table.

### The progression sheets — **Form 5** and **Lower Sixth**

Every week now carries its dates and the sittings for that week:

> **Week 21** · 8 – 12 Feb 2027 · Term 2, week 9
> **Tue 9 Feb** — 5B 11:20 a.m. – 1:00 p.m. · 5A 2:40 – 4:00 p.m.
> **Thu 11 Feb** — No lesson (Youth Day)

Dashed break bars sit between weeks 15 and 16, and between 27 and 28. Week 1 is
marked **This week** once term starts, and that marker moves on its own.

On a phone the grid slides sideways inside its own box; the day names stay
pinned on the left. The page itself does not move.

---

## The timetable I read off your aSc sheet

| | Period | Time | |
|---|---|---|---|
| **Tue** | 5–6 | 11:20 a.m. – 1:00 p.m. | Form 5B — CSC |
| **Tue** | 9–10 | 2:40 – 4:00 p.m. | Form 5A — CSC |
| **Thu** | 3–4 | 9:10 – 10:50 a.m. | Lower Sixth — ICT |
| **Thu** | 5 | 11:20 a.m. – 12:10 p.m. | Form 5A — CSC |
| **Thu** | 8 | 1:50 – 2:40 p.m. | Form 5B — CSC |

Eight periods a week, 6 h 20 min of contact, across two days. Six periods of
Computer Science, two of ICT.

If a line is wrong, it is one edit: on GitHub open `lib/school-calendar.js`,
click the pencil, find `CLASSES`, change the time, commit. `day: 2` is Tuesday,
`day: 4` is Thursday, and times are 24-hour — 2:40 p.m. is `"14:40"`. The grid
and the progression sheets both read that one list, so they cannot drift apart.

**Form 4** is not on it. If you teach it, send me the days and times and it is a
four-line addition.

---

## The three lessons you lose

All three fall on a Thursday, which is the heavier of your two days. Lower Sixth
loses its only sitting of the week outright each time.

| Week | Day | |
|---|---|---|
| 21 | Thu 11 Feb 2027 | Youth Day |
| 31 | Thu 6 May 2027 | Ascension |
| 33 | Thu 20 May 2027 | National Day |

Two more Thursdays are flagged amber rather than red, because school is open but
the timetable is not really running: **Thu 11 Mar** (Open Day) and **Thu 15 Apr**
(mock examinations).

Good Friday and New Year's Day both fall inside a break or on a Friday, so they
cost you nothing.

---

## Where the dates came from

ANNEX I of the 2026/2027 synoptic calendar, the one visa'd by the Prime
Minister's Office on 13 August 2026. Thirty-six weeks from **Mon 7 Sep 2026** to
**Fri 11 Jun 2027**, numbered 1–36 straight through — which is already how
`week_from` is numbered in your database, so week 21 on the sheet is week 21 in
the file with nothing in between to get out of step.

The period times come from your aSc timetable sheet. Periods 1–8 and 10 run
fifty minutes; period 9 runs thirty, which is where break comes from.

---

## Next August

One file. Open `lib/school-calendar.js`, replace `ACADEMIC_YEAR`, `WEEKS`,
`BREAKS` and `CLOSURES` with next year's, and `CLASSES` with next year's
timetable. Nothing else in the app knows these dates, so nothing else can
disagree with them.

The reason this lives in the code rather than in a table in Supabase: a table
means a migration every August and a second place for the dates to be wrong. A
diff on one file shows exactly what moved.
