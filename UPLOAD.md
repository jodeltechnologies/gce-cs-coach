# Progression sheets, timetable and student notes

Everything in one download. Three parts, in this order.

| | Where | Roughly |
|---|---|---|
| **Part 1** | GitHub, 56 files | 5 minutes |
| **Part 2** | Supabase, 2 files | 5 minutes |
| **Part 3** | Supabase, 1 file | 2 minutes |

**Take a Supabase backup before Part 2.** Dashboard, then Database, then
Backups. I could not run any of this SQL against a live database while writing
it, so treat the first run as untested.

---

## Read this first

### The Lower Sixth workload does not add up

The new ICT sheet asks for **8 periods a week**. Your timetable gives Lower
Sixth **2**, being one Thursday double period. The sheet holds 105 numbered
lessons across 31 teaching weeks. At one double period a week, less the three
Thursdays lost to public holidays, that is about 28 sittings for 105 lessons.

It cannot be taught as timetabled, and no work on this app changes that. After
Part 1 the Lower Sixth sheet says so in red at the top of the page, so you have
something to point at. Form 5 is fine. The sheet asks for 3 periods and both 5A
and 5B get 3.

You mentioned extra periods after school on Tuesday and Thursday. Send me the
times and I will put them in, which is a four line change to
`lib/school-calendar.js`.

### Most Lower Sixth notes will come off their lessons

The new ICT sheet is a different document from the old one, not a revision of
it. Of the 71 notes loaded in August, **3** have a lesson of the same name on
the new sheet.

The notes themselves are safe and students keep seeing them, because they are
scoped by source rather than by lesson. What is lost is the reading link from
the progression sheet, and Part 3 replaces that for all 43 First Term lessons
anyway. Form 5 comes through far better, keeping **61 of 68**.

### Nothing is deleted

Seven tables hang off lessons, including your uploaded handouts, your question
tagging and student progress. Five would be destroyed by a delete and two would
refuse it outright. So old rows are archived instead, and attachments are
carried across to the new row of the same name.

---

## Part 1, GitHub

Sign in at **github.com** and open your `gce-cs-coach` repository.

1. **Add file**, then **Upload files**.
2. Drag the `app`, `lib`, `db`, `tools` and `public` folders in together.
   GitHub keeps the structure and overwrites only the files listed below.
3. Commit message: `2026/2027 sheets, timetable and student notes`
4. **Commit changes**.

Wait for Vercel to say **Ready** before starting Part 2. Two or three minutes.

### What is in it

| Area | Files |
|---|---|
| The sheets | `db/seed/02_...sql`, `db/seed/03_...sql`, and their two YAML files |
| The notes | `db/seed/11_student_notes_term1.sql` |
| Figures | 22 PNG diagrams under `public/notes/figures` |
| Tools | `tools/build_progression.py`, `tools/extract_progression.py`, `tools/notes/` |
| Pages | 15 files under `app/`, plus `lib/school-calendar.js` |

Twelve of the page files change for one reason. They now ignore archived rows.
Nothing had ever been archived before, so the filter was never needed. Without
it you would see the old sheet and the new one mixed together on every screen.

`app/globals.css` also carries two fixes. Figures in notes were styled only for
inline drawings, so the new images would not have been sized. And every `h3`
heading on the site asked for `--navy`, which in dark mode is darker than the
page background, so **every heading was invisible in dark mode**. That was there
before today and it affected the notes you already had.

---

## Part 2, the progression sheets

**SQL Editor**, then **New query**. Two files, whole, one at a time, in this
order.

1. `db/seed/02_form5_computer_science.sql`
2. `db/seed/03_lower_sixth_ict.sql`

Each is one transaction. It either does all of it or none of it. Both are safe
to run twice, because the row ids come from the sheet.

Expect these counts.

| | Form 5 | Lower Sixth |
|---|---|---|
| rows on the new sheet | 105 | 125 |
| numbered lessons | 91 | 105 |
| objectives | 172 | 376 |
| categories of action | 23 | 26 |
| modules | 7 | 4 |

### If a file gives a red error

**`violates check constraint`** means the `ALTER TABLE` at the top did not run,
so you pasted from partway down. Clear the box and paste the whole file.

**`relation "new_lesson_ids" already exists`** means a previous run stopped
halfway. Harmless. Run the file again from the top.

**`Key (syllabus_id)=(...) is not present in table "syllabi"`** should no longer
happen. An earlier version of these files hard-coded a syllabus id from the
August seed. They now look the row up by form level.

Anything else, stop and send me the message.

---

## Part 3, the student notes

Same place. Paste `db/seed/11_student_notes_term1.sql` whole and run it.

Expect **43 notes loaded** and **43 attached to a lesson**. If the third line,
`not matched to any lesson`, is anything other than zero, tell me which ones.

Part 2 must be done first. The notes attach themselves to lessons by name, so
the lessons have to exist.

---

## Check it worked

- **Form 5** and **Lower Sixth** sheets. Module bands in small capitals above
  the categories. Competency statements on the Form 5 categories, which the old
  sheet did not have. The red workload note at the top of Lower Sixth.
- **Admin, then My timetable.** 5A and 5B show `3 periods` with a tick. Lower
  Sixth shows `2 periods of 8` in red.
- **Open any First Term lesson.** The note should be there, with its diagram.
  Try Lesson 13 on the instruction cycle, or Lesson 34 on cell referencing.
- **Switch your phone to dark mode** and open a note. Headings should be
  readable. Before this upload they were not.
- **Sign in as a Lower Sixth student and open Notes.** All 71 old notes should
  still be listed, plus the new ones. If a student sees an empty Notes page,
  tell me before doing anything else.

---

## The notes

43 of them, covering every First Term lesson on the new sheets that had none.
40 for Lower Sixth and 3 for Form 5, being the new AI lessons.

They are written for the student rather than for you. There is nothing in them
about examiners, mark schemes or losing marks. A note that spends its last
paragraph coaching a candidate teaches the reader that the topic is worth
guessing at rather than worth knowing.

Each one opens with what the lesson covers, taken from the sheet itself, and
closes with **In short** and **Test yourself**, where the answer sits under each
question rather than at the back.

`tools/notes/style.py` holds the writing rules and fails the build when they are
broken. No em dashes, no semicolons, no ellipses, plain words in place of formal
ones, and no exam coaching. All 43 pass with nothing flagged.

The **Word document** is separate and is your copy. It keeps the exam guidance,
because that is useful to you and not to them.

### The figures

22 diagrams, drawn rather than taken from the web. A photograph of a processor
teaches nothing that a labelled diagram does not teach better, and anything
found online would carry someone else's copyright into your classroom.

They cover the topics that were hardest to follow as plain words. The fetch,
decode and execute cycle. The order of memory. Von Neumann against Harvard. A
worked Gantt chart showing the convoy effect. Flynn's four categories. The
storage ladder with the bit and byte trap. The nested circles of AI and machine
learning. The workstation. The spreadsheet grid. Relative against absolute
referencing side by side. How a virus spreads against how a worm spreads.

---

## Things to check yourself

- **The Cameroon law references.** Law No. 2010/012 of 21 December 2010, Law
  No. 2010/013, and OAPI for copyright, in Lower Sixth lessons 36 and 37. The
  notes tell students to confirm them with you. Please confirm or correct them.
- **The local examples.** Mobile money fraud detection, crop disease apps, power
  supply and surge protection. Swap any that do not land with your students.
- **Terms 2 and 3** are not written yet. That is 61 more Lower Sixth notes and 6
  more for Form 5.

---

## Rebuilding later

Nothing here should be hand edited. Everything generated comes from a tool.

    cd tools
    pip install pdfplumber pyyaml
    SHEET_DIR=/path/to/pdfs python3 build_progression.py ..
    python3 load_curriculum.py --validate curriculum/*.yaml     # must be 0 errors

    cd notes
    node render_figures.mjs && cp fig/*.png ../../public/notes/figures/
    python3 style.py                                            # must be 0 problems
    python3 emit_notes.py ../../db/seed/11_student_notes_term1.sql
