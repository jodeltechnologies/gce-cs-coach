# GCE Computer Science Coach

A curriculum and assessment system for GCE Computer Science and ICT, built for
Government High School (Lycée) de Mbonjo, Limbe.

**To put this online, read [DEPLOYMENT.md](DEPLOYMENT.md).**

---

## What exists today

The complete Cameroon curriculum for three levels, structured and queryable:

| | Form 4 CS | Form 5 CS | Lower Sixth ICT |
|---|---|---|---|
| Modules / Teaching Units | 4 | — | 11 |
| Categories of action | 18 | 23 | — |
| Rows on the sheet | 107 | 108 | 103 |
| Objectives | 161 | 177 | — |
| Content points | — | — | 136 |
| Practical tasks | — | — | 31 |

**318 rows, 338 objectives, 136 content points, 31 practical tasks.** All three
validate with zero errors.

Plus a website that reads it: pick a progression sheet, see the whole year by
term and week with every objective in place. Public pages need no login. Behind
a teacher sign-in there is an admin area with the two editors described below.

---

## Layout

```
db/
  schema.sql        27 tables
  rls.sql           security policies — run this, it is not optional
  auth.sql          teacher login and write access
  seed/             the three curricula, ready to run
tools/
  curriculum/       the progression sheets as readable YAML
  load_curriculum.py  validates them and generates the SQL
app/
  page.js           list of progression sheets
  syllabus/[id]/    a whole year by term and week
  lesson/[id]/      a published lesson, set for reading
  login/            teacher sign in
  admin/            lesson editor, term planner, students, question bank
  opengraph-image.png  the card that appears when the link is shared
  icon.png          browser tab icon
lib/                database connections (browser and server)
middleware.js       keeps /admin closed to strangers
public/             both crests: MINESEC emblem and the school shield
app/icon.png        browser tab icon
```

## Typography

Two faces, each with one job. **Literata** carries anything a student reads for
more than a minute — it was drawn for Google Books, for long passages on a
screen, which is exactly what a lesson note is. **Inter** handles the interface,
where you scan rather than read.

Both are downloaded at build time and served from your own domain, so a
student's phone never makes a request to Google. One less thing to fail on a
weak connection.

The reading column is capped at 680px, which keeps lines near 70 characters —
the width at which sustained reading stays comfortable.

## Colours

Sampled from the MINESEC emblem: green `#1B8A2B` and `#006428`, gold `#F0C000`,
red `#9C2F2F`. The school shield uses the same three, so the two crests sit
together in the masthead without clashing.

Green does the structural work. Gold is a border and badge colour, never text
on white and never a large background — it fails contrast badly and this has to
stay readable on a cheap phone in daylight. Red is reserved for Evaluation and
Remediation weeks, and for anything genuinely wrong.

**`tools/curriculum/` is the part worth your attention.** Those three files are
plain text. Every lesson, every objective, every week. If something is wrong you
correct it there and re-run the loader — nothing about your curriculum is buried
inside code.

---

## Why the schema looks the way it does

Three real constraints shaped it, none of them technical preferences:

**Power cuts and expensive data.** Every table uses generated IDs rather than
counting `1, 2, 3`, so two phones working offline can never overwrite each
other. Every table records when it changed, so a returning device asks "what's
new since Tuesday?" instead of re-downloading everything. Nothing is truly
deleted, so a deletion reaches a phone that has been off for a week.

**Three differently shaped Ministry documents.** Form 4 has Modules, Categories
of action and Competency statements. Form 5 has Categories only. Lower Sixth has
Teaching Units and a parallel practical stream. Four flags on the syllabus row
let one schema hold all three and show your own vocabulary back to you.

**Students without email.** Password reset by email is useless here, so students
log in with a short code you hand out and reset in two clicks.

---

## What is missing, and only you can supply it

**Exam frequency.** Empty on all 41 categories of action. It is the field that
turns this from a record of the syllabus into something that tells a student
what to revise first. **There is now a screen for it:** `/admin/exam-frequency`,
Form 5 first, tappable on a phone, one save for the lot.

**Six unconfirmed cross-year links.** The loader proposes that Form 5's
"Analyzing simple logic circuits and expressions" continues Form 4's "Analysing
simple logic circuits", and five others. Confirm or reject them at
`/admin/links`. They feed no recommendation until you decide.

**Notes for six Form 5 categories.** Assistive technology, network hardware,
data communication, the internet and blockchain, social networks, and digital
identities have no notes at all — 17 lessons running continuously through Second
Term weeks 14 to 22. Also missing inside categories you do have notes for: De
Morgan's laws, Boolean simplification, and normalization to 3NF.

---

## What still has to be built

| | |
|---|---|
| Student sign-in | Codes are generated and stored; the accounts are not created yet |
| Assessments | Assembling questions into a quiz or mock and setting it for a class |
| Marking | MCQ and true/false mark themselves; everything else queues for you |
| Mastery engine | `lesson_mastery` exists and is empty. Nothing computes it yet. |
| Offline | The schema was built for it. No service worker or sync queue exists yet. |

The offline gap is the largest remaining piece and the one that decides whether
students in Limbe actually use this. It was left until last on purpose: a sync
layer built before there was anything to sync would have been wasted work.
