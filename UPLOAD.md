# What to upload

Only the files that changed. Copy them over your repository, keeping the folder
structure. Nothing else is affected.

## 1. SQL first

Two pages call database functions that do not exist yet, so pushing the code
before the SQL gives an error page on those screens.

Check what you have already run:

```sql
SELECT
  to_regprocedure('public.student_structured(uuid,uuid,int)')      IS NOT NULL AS phase10,
  to_regprocedure('public.marking_queue(uuid,boolean)')            IS NOT NULL AS phase11,
  to_regprocedure('public.student_assessments(uuid)')              IS NOT NULL AS phase12;
```

Run whichever comes back false, in order:

| File | What it adds |
|---|---|
| `db/phase10.sql` | Paper 2 practice for students |
| `db/phase11.sql` | Lets you read and mark what students write |
| `db/phase12.sql` | Tests you set for a class |

## 2. Upload

```
app/     pages and components
lib/     helper modules
public/  the note figures — 104 of them, easy to miss
db/      the SQL, for the record
tools/   the generators, for the record
```

If `public/notes/figures/` does not arrive, every diagram in the booklet notes
becomes a broken image. It will not error; it will just look wrong.

## 3. Then try it end to end

1. `/admin/assessments` — set a test. Pick a class, a topic, ten questions, a
   closing date.
2. Sign in as a student. The test appears at the top of their page, above
   everything else.
3. Answer a few questions, close the tab, sign in again, and reopen it. Your
   answers should still be there.
4. Submit. Then look at `/admin/assessments` for the result and for which
   questions caught the class out.

Step 3 is the one worth doing. Resuming a half-finished test is where this
would hurt most if it were broken, and a dropped connection mid-test is not a
rare event.
