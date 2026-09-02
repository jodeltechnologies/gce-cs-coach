# Deploying the Lower Sixth notes

No terminal. No commands. Upload files on github.com, paste SQL into Supabase,
click buttons. About twenty-five minutes, most of it waiting.

What you are adding: 71 written notes for Lower Sixth ICT, one for every
teaching lesson and every practical on the progression sheet, with 30 drawn
diagrams. And a fix — Lower Sixth students currently open Notes and are told
their year's notes are not ready. After this they see all 71.

Do the parts in order. **Part 2 is the long one; do not stop in the middle of
it.**

---

## Part 1 — Put the files on GitHub

Sign in at **github.com** and open your `gce-cs-coach` repository.

### 1.1 The notes folder

1. Click **Add file** (top right, next to the green Code button) → **Upload
   files**.
2. Drag the whole **`tools`** folder from the download into the dashed box.
   GitHub keeps the folder structure, so `lesson_notes_l6` and everything in it
   lands in the right place.
3. Scroll down. In the box under **Commit changes**, type:
   `Lower Sixth ICT lesson notes`
4. Click **Commit changes**.

### 1.2 The database files

1. **Add file** → **Upload files** again.
2. Drag the whole **`db`** folder in.
3. Commit message: `Lower Sixth notes SQL`
4. Click **Commit changes**.

### 1.3 The stylesheet

This one replaces a file you already have, so it works differently.

1. In your repository, click into the **`app`** folder, then click
   **`globals.css`** to open it.
2. Click the **pencil** icon (top right of the file) to edit it.
3. Select everything in the box — click inside it, then **Ctrl+A** (**Cmd+A** on
   a Mac) — and press **Delete**.
4. Open the `globals.css` from the download in Notepad or TextEdit, select all,
   copy, and paste it into the empty GitHub box.
5. Scroll down, commit message `Style the drawn diagrams`, click **Commit
   changes**.

Miss this file and the diagrams still appear, but with no border, and a wide one
pushes the whole page sideways on a phone.

### 1.4 The two guides

Same as 1.1: **Add file** → **Upload files**, drag in `UPLOAD.md` and
`DEPLOYMENT.md`, commit.

### 1.5 Let Vercel finish

Nothing to do. Vercel noticed the first commit and is already rebuilding. Open
**vercel.com** → your project → **Deployments** if you want to watch it. Two or
three minutes, and it must say **Ready** before Part 3.

Only the stylesheet affects the website, so there is no new setting and no
environment variable to add.

---

## Part 2 — Load the notes into Supabase

The notes are 280 KB of SQL. That is too much for the web SQL editor in one
paste, so they come as **seven small files** in
`db/seed/lower_sixth_notes_parts/`. You run them one at a time, in alphabetical
order — a, b, c, d, e, f, g.

| File | What it does | Size |
|---|---|---|
| `10a_lower_sixth_notes.sql` | Creates the notes source | 2 KB |
| `10b_lower_sixth_notes.sql` | Notes 1–19 | 56 KB |
| `10c_lower_sixth_notes.sql` | Notes 20–34 | 56 KB |
| `10d_lower_sixth_notes.sql` | Notes 35–49 | 56 KB |
| `10e_lower_sixth_notes.sql` | Notes 50–61 | 55 KB |
| `10f_lower_sixth_notes.sql` | Notes 62–71 | 51 KB |
| `10g_lower_sixth_notes.sql` | Attaches them to lessons, fixes the year | 4 KB |

### Do this seven times

1. Go to **supabase.com/dashboard** → your `gce-cs-coach` project.
2. Click **SQL Editor** in the left sidebar.
3. Click **New query**.
4. Open `10a_lower_sixth_notes.sql` in Notepad or TextEdit. **Ctrl+A**,
   **Ctrl+C**.
5. Click in the Supabase query box, **Ctrl+V**.
6. Click **Run** (or Ctrl+Enter). Wait for **Success**.
7. Repeat from step 3 with `10b`, then `10c`, and so on to `10g`.

Paste each file whole. Do not paste half of one, and do not paste two into the
same query — each file is a single transaction that has to open and close in one
run.

Some of the notes are long, so `10b` to `10f` may take ten or fifteen seconds
each and the browser may look frozen. Leave it. It is finished when the green
**Success** appears.

**If you lose your place, start that file again.** Running any of these twice is
safe: they update what is there rather than adding a second copy. Running all
seven again from the start is also safe.

**`10g` is the important one.** It attaches the notes to the lessons and installs
the fix that keeps each year's notes to that year. If you stop before it, the
notes are in the database but no student can see them.

When `10g` finishes it prints a small table underneath. It should read something
like:

| source | notes |
|---|---|
| Form 5 Computer Science — lesson notes | 19 |
| Lower Sixth ICT lesson notes | **71** |
| O-Level Computer Science Notes, Part 1 | 4 |
| Form 5 Computer Science Notes, Part 2 | 4 |

If the Lower Sixth line says 71, Part 2 worked.

### If a file gives a red error

Read the first line of the message.

**`relation "note_sections" does not exist`** — you are in the wrong Supabase
project, or the schema was never loaded. Check the project name at the top left.

**`syntax error at or near`** — a partial paste. Clear the box and paste that
whole file again.

**`null value in column "note_source_id"`** — you ran a notes file before `10a`.
Run `10a`, then carry on from where you were.

---

## Part 3 — Check it worked

Two accounts, and the answer to both should have changed.

**A Lower Sixth student.** Sign in at `/student/login` with their code. Open
**Notes**. There should be 71 lessons under *Lower Sixth ICT lesson notes*. Open
one with a drawing in it — try **Processor architecture**, **Boolean Logic and
Logic Gates**, or **Phases of SDLC** — and the diagram should be there and
sharp. If your phone is in dark mode, it should still read clearly.

Before today that student saw an empty page saying their year's notes were being
prepared.

**A Form 5 student.** Sign in as one. They should see exactly what they saw
before, and **no Lower Sixth notes at all**. If Lower Sixth material shows up in
a Form 5 account, `10g` did not run — go back and run it.

If you have no student account handy, **SQL Editor → New query**, paste this,
**Run**:

```sql
SELECT src.title AS source, sy.form_level AS belongs_to, count(*) AS notes
FROM note_sections s
JOIN note_sources src ON src.id = s.note_source_id
LEFT JOIN syllabi sy ON sy.id = src.syllabus_id
WHERE s.deleted_at IS NULL
GROUP BY src.title, sy.form_level
ORDER BY src.title;
```

The Lower Sixth line must say **Lower Sixth** under `belongs_to` and **71** under
`notes`. A written source with a blank `belongs_to` is one that will be shown to
every student in the school.

And this should return **94**:

```sql
SELECT count(*) FROM lesson_note_sections lns
JOIN note_sections s ON s.id = lns.note_section_id
WHERE s.note_source_id = '7df11f03-a526-56c6-abb9-562db2871de7';
```

94 links from 71 notes across 103 rows on the sheet. More links than notes
because the practicals repeat — *Practical: Presentation* is fourteen lessons
sharing one note. Fewer than rows because nine rows are the evaluations, the
integration activities and the diagnostic week, which have no reading. A note
there would be padding, and a student who opens one expecting help and finds
padding trusts the next one less.

---

## If you need to undo it

**SQL Editor → New query**, paste, **Run**:

```sql
DELETE FROM note_sources WHERE title = 'Lower Sixth ICT lesson notes';
```

That removes the 71 notes and their links and leaves everything else untouched.
The Form 5 notes, the booklet chapters, your students, marks and classes are all
in other rows. You can re-run Part 2 afterwards.

This does **not** undo the year fix in `10g`, and you would not want it to — that
is what stops a Form 5 student being shown the wrong year.

---

## Correcting a note later

You do not need the terminal for a small fix either.

1. On GitHub, open `tools/lesson_notes_l6/` and click the term file that holds
   the lesson — `term1.py`, `term2.py` or `term3.py`.
2. Click the **pencil**, use **Ctrl+F** to find the lesson title, fix the words,
   commit.

That corrects the written source, which is what the next person to rebuild will
read. It does **not** change what students see — the database still holds the old
wording. To push a correction through to students you need the file rebuilt, and
that does need the command line. Send me the change and I will send back a
replacement part file to paste.

If you only need one note fixed quickly, it is faster to edit it in the app at
**/admin/notes**.

---

## Notes for whoever has a terminal

Everything above has a one-line equivalent.

```bash
psql "YOUR-CONNECTION-STRING" -f db/seed/10_lesson_pages_l6.sql
```

That single file is the same content as the seven parts. Rebuild both after
editing the notes:

```bash
cd tools
python3 load_lesson_pages_l6.py                     # 71 / none / none
python3 load_lesson_pages_l6.py --emit-sql > ../db/seed/10_lesson_pages_l6.sql
python3 load_lesson_pages_l6.py --emit-parts ../db/seed/lower_sixth_notes_parts
```

The first command is the one that matters. It prints two lists that must both be
empty: notes whose title is not on the progression sheet, and lessons on the
sheet with no note. A title that drifts by one word stops matching and the note
silently detaches from its lesson — nobody notices until a student cannot find
the reading for a Thursday.

`10_lesson_pages_l6.sql` must run after `08_lesson_notes.sql` and
`09_lesson_pages.sql`. All three define the function that decides which notes a
student sees, and the last one to run wins. Re-run 08 or 09 later and you must
re-run this one after it. There is no `db/phase13.sql`; that fix now lives at the
foot of this file and in part `10g`.
