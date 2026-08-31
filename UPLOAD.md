# What to upload

Only the files that changed. Copy over your repository, keeping the structure.

## 1. SQL first

Check what you have already run:

```sql
SELECT
  to_regprocedure('public.student_structured(uuid,uuid,int)') IS NOT NULL AS phase10,
  to_regprocedure('public.marking_queue(uuid,boolean)')       IS NOT NULL AS phase11,
  to_regprocedure('public.student_assessments(uuid)')         IS NOT NULL AS phase12,
  to_regprocedure('public.student_notes(uuid)')               IS NOT NULL AS phase13;
```

Run whichever comes back false, in order:

| File | What it adds |
|---|---|
| `db/phase10.sql` | Paper 2 practice |
| `db/phase11.sql` | Reading and marking written work |
| `db/phase12.sql` | Tests you set for a class |
| `db/phase13.sql` | Notes belong to one year |

`phase13` is the fix for Lower Sixth showing Form 5 notes. It prints two tables
at the end: the first should show Form 5 only, and the second should show notes
attached to Form 5 lessons only. A count against Form 4 or Lower Sixth means
something is still crossing years — say so.

## 2. Upload

`app/`, `lib/`, `public/`, `db/`, `tools/`, and the two markdown files.

`public/notes/figures/` is 104 images. Miss it and every diagram in the booklet
notes silently becomes a broken image.

## 3. Check

Sign in as a Lower Sixth student. Notes should be **empty**, with a line saying
their year's notes are not ready. That is the correct answer — the wrong notes
were worse than none, because a student would have revised from them.

A Form 5 student should see all three sets as before.
