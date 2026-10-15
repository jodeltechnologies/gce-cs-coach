# GCE COACH official classes update

The app now uses these official classes:

| Class | Day | Time |
| --- | --- | --- |
| Form 5A Computer Science | Tuesday | 2:40–4:00 p.m. |
| Form 5A Computer Science | Thursday | 11:20 a.m.–12:10 p.m. |
| Form 5B Computer Science | Tuesday | 11:20 a.m.–1:00 p.m. |
| Form 5B Computer Science | Thursday | 1:50–2:40 p.m. |
| Lower Sixth ICT, Arts and Science combined | Thursday | 9:10–10:50 a.m. |
| Lower Sixth Computer Science | Tuesday | 7:30–9:10 a.m. |
| Lower Sixth Computer Science | Wednesday | 1:00–2:40 p.m. |

Form 5's timetable and curriculum remain unchanged. ICT and Computer Science
have separate progression sheets and subject-specific timetable links.

## Apply to an existing installation

1. Replace the repository source with this folder's contents, including deletions.
2. In the existing project's Supabase SQL Editor, run `db/seed/12_lower_sixth_computer_science.sql`.
3. Run `db/retire_form4.sql` to retire Form 4 records from active use. Student history is preserved, with no hard deletion.
4. Deploy the updated repository using its existing environment variables.

No need to reload the Form 5 or ICT curriculum. Their supplied national PDFs
were checked against the existing transcriptions and match exactly.
The ICT import script now identifies its syllabus by subject and class level,
so future imports cannot overwrite the Lower Sixth Computer Science sheet.

## Current week

Opening a progression sheet scrolls to the current teaching week and highlights
it. The homepage also states the current week. Dates use Cameroon time.
For 15 October 2026, the current teaching week is week 6, 12–16 October.
The sheet rechecks its week after midnight and when a suspended tab is reopened.
A supplied page anchor is respected. All weeks remain available by scrolling.
During breaks, the next teaching week opens. After the school year ends, the
page displays an end-of-year message instead of returning to week 1.
Multi-week revision blocks appear in each week they cover.

## Validation

- `npm ci`
- `npm test`: calendar/timetable checks and database execution in isolated PostgreSQL-compatible PGlite.
- `npm run build`: production compilation, route generation, and type checks.
- The database test imports ICT and CS repeatedly, verifies subject separation,
  checks Form 5 preservation, and verifies repeatable retirement of Form 4.
- New CS transcription: 122 numbered lessons, 137 total rows, 345 objectives.
  Wording and numbering from the official PDF are preserved.

These files have not been deployed, and no live database has been modified.
