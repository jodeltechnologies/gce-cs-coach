# Paper 3 teaching guide and MINESEC archive

Admin → Paper 3 teaching guide provides 29 teacher-authored sessions:
7 word-processing sessions, 10 spreadsheet sessions, 4 C/programming sessions,
3 HTML/CSS sessions, 3 database sessions and 2 presentation sessions.
Each session includes objectives, demonstration steps, independent practice,
checks and common errors. Word processing and spreadsheets have full worked
classroom tasks, teacher keys and 20-mark practice rubrics. Progress is saved
on the current browser. The page can print the current lesson or worked task.

The guide follows Form 5 progression lessons 50–54 for office work, lessons
19–24 for databases, lessons 40–42 for Python and the HTML/CSS objective.
C practice and the Python bridge distinguish the language in past papers from
the current progression. The actual examination instructions take precedence.

Admin → Past papers provides all 53 Computer Science source listings found
through the supplied Ordinary Level index on 15 October 2026. These resolve
to 39 distinct PDF byte hashes. The original PDF links retain diagrams.
The archive stores the complete extracted source text and records both the
website's year label and the printed year when confirmed. Several listed
years are wrong. Five files contain only covers or instructions and therefore
have no questions added to practice.

There are 510 unique extracted question/task records in the reviewed dataset
and 565 paper-specific occurrences. Existing exact matches are reused, not
overwritten. New questions require teacher checking and have no invented
answer key. The deployed import added 508 active new questions, reusing
existing bank records for the remaining matches.

## Database setup for another installation

Apply db/phase16_past_paper_archive.sql. It adds three archive tables with
teacher-only SELECT policies and row-level security. Then run:

    python3 tools/load_minesec_archive.py db/imports/minesec/computer_science_ol.json /tmp/minesec-import

Run the emitted SQL files in filename order. The loader is repeatable and
preserves existing reviewed questions. The existing GCE COACH installation
already has the schema and data applied.

## Validation

- Production build and all six guide areas rendered successfully.
- The C example compiles with warnings treated as errors and passes numeric,
  zero, fractional and invalid-input cases.
- Worked spreadsheet expected values were checked, including the 49,200 FCFA
  net total, 33,300 practical-pupil total and 3 High-category records.
- Database imports were executed twice in isolated PostgreSQL-compatible
  PGlite, checking source counts, duplicate prevention and review gating.
- Run node tests/minesec-archive.mjs to repeat the archive test.
