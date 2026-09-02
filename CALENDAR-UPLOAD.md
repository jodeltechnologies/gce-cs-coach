# Putting dates on the progression sheet

Six files. All of it is GitHub — **no SQL, no Supabase, no new setting in
Vercel**. About five minutes.

The sheet has been printing "Week 21" and leaving you to work out what that
means. After this it prints:

> **Week 21** · 8 – 12 Feb 2027 · Term 2, week 9
> **Tue 9 Feb** — 5B 11:20 a.m. – 1:00 p.m. · 5A 2:40 – 4:00 p.m.
> **Thu 11 Feb** — No lesson (Youth Day)

---

## What is in the download

| File | New or replaces |
|---|---|
| `lib/school-calendar.js` | **New** — the 2026/2027 calendar and your timetable |
| `app/syllabus/[id]/page.js` | Replaces |
| `app/lesson/[id]/page.js` | Replaces |
| `app/admin/lessons/page.js` | Replaces |
| `app/admin/lessons/[id]/page.js` | Replaces |
| `app/globals.css` | Replaces |

---

## Upload

Sign in at **github.com**, open your `gce-cs-coach` repository.

1. Click **Add file** (top right, beside the green Code button) → **Upload
   files**.
2. Drag **both** the `lib` folder and the `app` folder from the download into
   the dashed box, together. GitHub keeps the folder structure and overwrites
   only the six files above — everything else in `app/` is untouched.
3. Under **Commit changes**, type: `Dates and timetable on the progression sheet`
4. Click **Commit changes**.

That is the whole job. Vercel sees the commit and rebuilds. Two or three
minutes; open **vercel.com** → your project → **Deployments** if you want to
watch it say **Ready**.

If dragging two folders at once misbehaves in your browser, do `lib` first,
commit, then `app`, commit. Two commits, same result.

---

## What to check

Open the site and click into **Form 5**.

- At the top, a **When this class sits** box: 5A on Tue and Thu, 5B on Tue and
  Thu, with the minutes each gets a week.
- Under it, a line about the three teaching days you lose to public holidays.
- Every week now carries its dates, and under them the actual days and times.
- Between week 15 and week 16, a dashed **First break** bar; another between
  27 and 28.
- Week 1 is marked **This week** once term starts. That marker moves on its own
  as the year goes; nothing to update.

Then open **Lower Sixth**. One sitting a week, Thursday 9:10 – 10:50 a.m.

**Form 4** has no timetable in the file, so it shows dates but no sittings. If
you teach it, send me the days and times and I will send back a one-line change.

---

## The timetable I was given

Check this before you trust the rest of it.

| Class | Tuesday | Thursday | Total |
|---|---|---|---|
| **Form 5A** | 2:40 – 4:00 p.m. | 11:20 a.m. – 12:10 p.m. | 130 min |
| **Form 5B** | 11:20 a.m. – 1:00 p.m. | 1:50 – 2:40 p.m. | 150 min |
| **Lower Sixth** | — | 9:10 – 10:50 a.m. | 100 min |

If a line is wrong, it is one edit: on GitHub open `lib/school-calendar.js`,
click the pencil, find `TIMETABLE` near the bottom, change the time, commit.
`day: 2` is Tuesday, `day: 4` is Thursday, and times are 24-hour — 2:40 p.m. is
`"14:40"`.

---

## The three lessons you lose

All three fall on a Thursday, which is the day every one of your classes meets.
Lower Sixth loses its only sitting that week outright.

| Week | Day | |
|---|---|---|
| 21 | Thu 11 Feb 2027 | Youth Day |
| 31 | Thu 6 May 2027 | Ascension |
| 33 | Thu 20 May 2027 | National Day |

Two more days are flagged amber rather than red, because school is open but the
timetable is not really running: **Thu 11 Mar** (Open Day) and **Thu 15 Apr**
(mock examinations).

Good Friday and New Year's Day both fall inside a break or on a Friday, so
they cost you nothing.

---

## Where the dates came from

ANNEX I of the 2026/2027 synoptic calendar, the one visa'd by the Prime
Minister's Office on 13 August 2026. Thirty-six weeks running from **Mon 7 Sep
2026** to **Fri 11 Jun 2027**, numbered 1–36 straight through — which is
already how `week_from` is numbered in your database, so week 21 on the sheet
is week 21 in the file with nothing in between to get out of step.

---

## Next August

One file. Open `lib/school-calendar.js`, replace `ACADEMIC_YEAR`, the `WEEKS`
list, `BREAKS` and `CLOSURES` with next year's, commit. Nothing else in the app
knows these dates, so nothing else can disagree with them.

The reason this lives in the code rather than in a `weeks` table in Supabase:
a table means a migration every August and a second place for the dates to be
wrong. A diff on one file shows exactly what moved.
