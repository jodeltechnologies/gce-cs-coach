# Sheets, notes, and the student side

One download. Four steps, in this order.

| | Where | Roughly |
|---|---|---|
| **1** | GitHub, 72 files | 5 minutes |
| **2** | Supabase, `02_` then `03_` | 5 minutes |
| **3** | Supabase, `11_student_notes_term1.sql` | 2 minutes |
| **4** | Supabase, `phase13.sql` | 2 minutes |

**Take a Supabase backup before step 2.** None of this SQL has been run
against a live database, so treat the first run as untested.

---

## What is new on the student side

**The Admin link is gone for them.** A signed-in student sees Progression and
My revision instead. Sending them to a door that will not open only teaches
them there is a door.

**Progression now means their own progress.** Where they stand, what to go back
over, and the next ten lessons from the current week. Not the whole
thirty-six-week sheet, which is no use to anybody.

**The answers in the notes are hidden.** Each question has a Show the answer
button. Once the answer is showing, the student says whether they had it,
partly had it, or missed it, and that goes to their progress page and to yours.

Nothing here can mark a written answer, so this is the student's own judgement
and it is labelled that way everywhere it appears. It is not a score and it is
not presented as one. What makes it useful is not accuracy about one student.
It is that when eleven of them say they missed the same question, you know what
to reteach on Thursday.

**Students can write to you** from their progress page, and from the foot of
any note, where the message carries the note title with it so you can see what
they were reading.

**Notes are released by you, week by week.** The 43 new ones are staged and
invisible until you release them. Everything already in front of a class stays
exactly as it is.

---

## Step 1, GitHub

**Add file**, then **Upload files**. Drag the `app`, `lib`, `db`, `tools` and
`public` folders in together. Commit message:
`Student progress, messages and staged notes`.

Wait for Vercel to say **Ready** before step 2.

## Step 2, the progression sheets

SQL Editor, new query. Paste whole, one at a time.

1. `db/seed/02_form5_computer_science.sql`
2. `db/seed/03_lower_sixth_ict.sql`

Expect 105 rows and 91 numbered lessons for Form 5, and 125 and 105 for Lower
Sixth. Both are safe to run twice.

## Step 3, the notes

Paste `db/seed/11_student_notes_term1.sql`. Expect **43 notes loaded** and
**43 attached to a lesson**.

These go into two new sources of their own, named for the year. An earlier
version put the Lower Sixth ones into the existing source, which would have
hidden all 71 notes your students already read the moment the source was
staged. They are separate now.

## Step 4, the student side

Paste `db/phase13.sql`. It creates three tables, adds one column, and writes
the functions behind the new pages. The last line marks the two new note
sources as staged.

Run it after step 3, not before. It has to find the sources in order to stage
them.

---

## Then do this, or the class sees nothing

Go to **Admin, Release notes**. Pick a class. Tick the notes for the week you
are on and press Save.

Until you do, the 43 new notes are invisible to students. That is the point of
the feature, but it does mean nothing happens on its own.

---

## Check it worked

**As a teacher.**

- **Admin, Release notes.** Your classes in the dropdown, the staged notes
  listed underneath. Tick two and save, then untick one and save again.
- **Admin, Student progress.** Every student, their practice percentage, how
  many notes they have worked through, and how many questions they said they
  missed. At the top, the questions the class as a whole is finding hard.
- **Admin, Messages.** Empty until somebody writes.

**As a student.** Sign in as one of them, or use a test account.

- The header shows **Progression** and **My revision**. No Admin.
- **Progression** shows where they stand and the next ten lessons.
- Open a released note. The questions at the foot have **Show the answer**
  buttons and no answers visible. Reveal one, mark yourself, then reload the
  page. The choice should still be there.
- Send a message from the foot of the note. It should appear in **Admin,
  Messages** with the note title beside it.
- Check the progress page again. The answered question should now be counted.

**A note you have not released should not appear in the student's list at all.**
That is the check worth doing twice.

---

## Things worth knowing

**Taking a note back does not delete anything.** A student who already answered
its questions keeps those answers, so releasing it again for revision picks up
where they left off.

**Messages are capped** at twenty an hour per student. A stuck key should not
fill a table.

**Nothing here reaches the database directly.** Every student action goes
through a function that takes the student id from a signed cookie the server
checked first. The tables themselves have row level security on and no
policies, so the anon key cannot read them at all.

**The teacher functions are deliberately not SECURITY DEFINER.** A function
that hands back every student's work should not bypass the checks that keep one
teacher out of another's classes.

---

## Still outstanding

- **The Lower Sixth workload.** The sheet asks for 8 periods a week and the
  timetable gives 2. The sheet says so in red. Send me the after-school times
  and I will put them in.
- **The Cameroon law citations** in Lower Sixth lessons 36 and 37. Please
  confirm or correct them before students read them.
- **Terms 2 and 3.** 61 more Lower Sixth notes and 6 more for Form 5.

---

## Rebuilding later

    cd tools
    SHEET_DIR=/path/to/pdfs python3 build_progression.py ..
    python3 load_curriculum.py --validate curriculum/*.yaml   # must be 0 errors

    cd notes
    node render_figures.mjs && cp fig/*.png ../../public/notes/figures/
    python3 style.py                                          # must be 0 problems
    python3 emit_notes.py ../../db/seed/11_student_notes_term1.sql
