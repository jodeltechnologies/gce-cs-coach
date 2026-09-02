# Loading the 2026/2027 progression sheets

Two parts. **Part 1 is GitHub, Part 2 is Supabase.** Both are needed and Part 1
must go first — the SQL in Part 2 loads rows the old code would display wrongly.

Allow twenty minutes. **Take a Supabase backup before Part 2** (Dashboard →
Database → Backups). I could not run this SQL against a live database while
writing it, so treat the first run as untested.

---

## Read this before you start

### 1. The Lower Sixth workload does not add up

The new ICT sheet asks for **8 periods a week**. Your timetable gives Lower
Sixth **2** — one Thursday double period.

The sheet holds 105 numbered lessons across 31 teaching weeks. At one double
period a week, minus the three Thursdays lost to public holidays, that is about
28 sittings for 105 lessons. It cannot be taught as timetabled, and no amount
of work on this app changes that. It is worth raising with your HOD now rather
than in February.

Form 5 is fine: the sheet asks for 3 periods and both 5A and 5B get 3.

After Part 1 the Lower Sixth sheet says this in red at the top of the page, so
you have something to point at.

### 2. Most Lower Sixth notes will come off their lessons

The new ICT sheet is not a revision of the old one, it is a different document.
Of the 71 notes loaded in August, **3** have a lesson of the same name on the
new sheet. Seventy-two lesson titles have simply gone.

**The notes themselves are safe and students keep seeing them.** They are
scoped by source, not by lesson, so every Lower Sixth student still opens
**Notes** and finds all 71 under *Lower Sixth ICT lesson notes*. What is lost is
the "reading for this lesson" link from the progression sheet. You can rebuild
those by hand at **/admin/notes**, a few at a time, as you reach them.

Form 5 comes through much better: **61 of 68** lessons keep their attachments.

### 3. Nothing is deleted

Seven tables hang off lessons — including your uploaded handouts, your question
tagging and student progress. Five would be destroyed by a delete and two would
refuse it outright. So the old rows are **archived**, not removed, and every
attachment is carried across to the new row of the same name.

Where a title is not unique the attachment stays put rather than being guessed
at. Twenty-three Form 5 rows are called "Integration activities"; there is no
way to tell which old one is which new one. Those rows carry no reading anyway.

---

## Part 1 — GitHub

Sign in at **github.com**, open your `gce-cs-coach` repository.

1. **Add file** → **Upload files**.
2. Drag the `app`, `lib`, `db` and `tools` folders from the download in
   together. GitHub keeps the structure and overwrites only the 24 files
   listed below.
3. Commit message: `2026/2027 national progression sheets`
4. **Commit changes**.

Wait for Vercel to say **Ready** (vercel.com → your project → Deployments)
before starting Part 2. Two or three minutes.

### What is in the download

| Area | Files |
|---|---|
| The sheets themselves | `db/seed/02_form5_computer_science.sql`, `db/seed/03_lower_sixth_ict.sql` |
| Transcriptions | `tools/curriculum/form5_computer_science.yaml`, `tools/curriculum/lower_sixth_ict.yaml` |
| Rebuild tools | `tools/build_progression.py`, `tools/extract_progression.py`, `tools/load_curriculum.py` |
| Schema | `db/schema.sql` — adds the `revision` lesson kind |
| Pages | 15 files under `app/`, plus `lib/school-calendar.js` |

Twelve of those page files change for one reason: **they now ignore archived
rows.** Nothing had ever been archived before, so the filter was never needed.
Without it you would see the old sheet and the new one interleaved on every
screen.

---

## Part 2 — Supabase

**SQL Editor** → **New query**. Two files, in this order, whole, one at a time.

1. `db/seed/02_form5_computer_science.sql` — paste, **Run**, wait for the
   result table.
2. `db/seed/03_lower_sixth_ict.sql` — same.

Each is a single transaction: it either does all of it or none of it. Paste each
file whole and do not put both in one query.

Both are **safe to run twice.** The row ids are derived from the sheet, so a
second run recognises what it already loaded and changes nothing.

### What each one prints

A table of counts. These are the numbers to expect:

**Form 5**

| item | value |
|---|---|
| rows on the new sheet | 105 |
| numbered lessons | 91 |
| objectives | 172 |
| categories of action | 23 |
| modules | 7 |
| notes attached to a lesson | around 19 |

**Lower Sixth**

| item | value |
|---|---|
| rows on the new sheet | 125 |
| numbered lessons | 105 |
| objectives | 376 |
| categories of action | 26 |
| modules | 4 |
| notes with no lesson on the new sheet | around 68 |

That last line is the expected outcome described above, not a failure.
`uploaded files still attached` should match whatever you had before.

### If a file gives a red error

**`new row for relation "lessons" violates check constraint`** — the
`ALTER TABLE` at the top did not run. You pasted from partway down the file.
Clear the box and paste the whole thing.

**`relation "new_lesson_ids" already exists`** — a previous run stopped
halfway. Harmless: run the file again from the top.

**`duplicate key value violates unique constraint "lessons_syllabus_id_sequence_key"`**
— stop and send me the message. Do not re-run.

---

## Check it worked

Open the site.

- **Form 5** — 91 numbered lessons, ending at *Lesson 91: Integration
  activities* in week 34, then Evaluation, Remediation and a Revision block.
  Module bands in small capitals above the categories: NETWORK SYSTEMS 2,
  HARDWARE AND SOFTWARE SYSTEMS 3, and so on. Each category now carries the
  Ministry's competency statement — hover the category heading to read it.
- **Lower Sixth** — 105 lessons, the red workload note at the top, four module
  bands, six Integration Activities, six Evaluation/Remediation pairs.
- **Admin → My timetable** — unchanged, but the load column now reads in
  periods against what each sheet asks for: 5A and 5B show `3 periods ✓`,
  Lower Sixth shows `2 periods of 8` in red.
- **A Lower Sixth student** — sign in, open **Notes**. Still 71 notes. This is
  the important check; if a student sees an empty Notes page, tell me before
  doing anything else.

---

## What was corrected in the Ministry's text

Five line-break errors, all in the Category of Action column, where the PDF
broke a word across two lines inside a cell:

| Printed | Loaded as |
|---|---|
| Representin g data in the computer | Representing data in the computer |
| Designing and implementi ng simple databases | Designing and implementing simple databases |
| Exploring the concepts related to data communicat ion | Exploring the concepts related to data communication |
| Describing internal component s of the computer | Describing internal components of the computer |
| Securing data, computers, and networks. | Securing data, computers, and networks |

The Lower Sixth module printed as "Practical Problem solving in the digital
word" is loaded as **world**.

Nothing else was changed. Every lesson title, every objective and every
competency statement is the Ministry's own wording. The corrections are listed
in `tools/build_progression.py` and printed every time it runs, so they can
never become silent.

---

## Next time a sheet is reissued

Do not hand-edit the YAML or the SQL. Put the new PDF next to the old one and
rebuild:

```bash
cd tools
pip install pdfplumber pyyaml
SHEET_DIR=/path/to/pdfs python3 build_progression.py ..
python3 load_curriculum.py --validate curriculum/*.yaml
```

That rewrites both YAML files and both SQL files. The validate step must print
**0 errors** — it checks lesson numbering for gaps, duplicates and rows out of
order, and it caught real problems while this was being built.

Then upload the four regenerated files and run the SQL as in Part 2. Because
the ids come from the sheet, a lesson that has not changed keeps its id, its
notes and its uploaded files.
