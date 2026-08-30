# What to upload, and in what order

This folder contains **only the files that changed today**. Everything else in
your repository is untouched — do not delete anything, just copy these over the
top, keeping the same folder structure.

179 files. 104 of them are the note figures under `public/`.

---

## 1. Run the SQL first

Two of the code changes below will show an error page if the database has not
been updated first, because they call functions that do not exist yet. So the
SQL goes first.

In the Supabase SQL editor, check what you have already run:

```sql
SELECT
  to_regprocedure('public.student_structured(uuid,uuid,int)') IS NOT NULL AS phase10_done,
  to_regprocedure('public.marking_queue(uuid,boolean)')       IS NOT NULL AS phase11_done;
```

Run whichever comes back `false`:

| File | What it adds |
|---|---|
| `db/phase10.sql` | Paper 2 practice for students |
| `db/phase11.sql` | Lets you read and mark what students write |

Then, if you have not already:

| File | What it adds |
|---|---|
| `db/seed/09_lesson_pages.sql` | 67 notes, one per lesson |
| `db/seed/04_past_questions.sql` | Re-run only if MCQs are not 408 |

`db/approve_safe_questions.sql` is not part of the sequence — it is the
one-click clearing of the review queue, and you have already run it.

---

## 2. Upload to GitHub

Copy the folders over your repository, keeping the structure:

```
app/          the pages and components
lib/          two helper modules
public/       the note figures  ← easy to forget, see below
db/           the SQL, for the record
tools/        the generators, for the record
README.md
DEPLOYMENT.md
```

**`public/notes/figures/` matters.** 104 images, and if they are missed every
diagram in the booklet notes becomes a broken image. It will not error — it
will just quietly look wrong. Check that folder arrived.

If your repository has a `.gitignore` that excludes images, that is the thing
to check first.

---

## 3. What you should see after Vercel redeploys

| Where | What is new |
|---|---|
| Admin nav | A **Marking** tab |
| `/admin/marking` | Written Paper 2 answers waiting for a mark |
| `/student/practice` | A **Paper 2 questions** button beside the topic grid |
| `/student` | A teacher's mark appears at the top when you have marked one |
| `/student/notes` | 67 notes, one per lesson, ahead of the chapter-length ones |
| Everywhere | Navy masthead and buttons, Outfit headings |

---

## 4. The one test worth doing carefully

Sign in as a student, answer one Paper 2 part, then open `/admin/marking`.

If their words appear there, the whole loop works — student writes, you mark,
they see it. That is the first time student effort has been visible to you at
all, and it is the piece I would least trust without watching it happen.
