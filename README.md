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
  login/            teacher sign in
  admin/            exam frequency editor, cross-year link confirmation
lib/                database connections (browser and server)
middleware.js       keeps /admin closed to strangers
public/             school crest; drop minesec.png here for the ministry emblem
```

## Colours

Sampled from the school shield itself: green `#007A33`, yellow `#F0F060`, red
`#D81818`. Green does the structural work, yellow highlights, red is reserved
for Evaluation and Remediation weeks. Yellow is never put behind body text — it
fails contrast on a phone screen in daylight.

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

## Next

The natural next piece is the **term planner**: a class against its progression
sheet, showing what is taught, what is behind, what has no notes, and how many
weeks remain before the next Evaluation. It needs nothing that is not already
here.
