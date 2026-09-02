# Lower Sixth ICT lesson notes

Seventy-one notes, one for every teaching lesson and every distinct practical
on the Lower Sixth ICT progression sheet. Written by hand, in the same house
style as the Form 5 notes in `../lesson_notes`, and grounded in the school's
own booklet — *Advanced Level Computer Science & ICT*, BGS Molyko, 2014.

```
term1.py   26 notes   Units 1-5, hardware through software classification
term2.py   25 notes   Units 5-8, operating systems through information systems
term3.py   20 notes   Units 8-11, AI, SDLC, project management, e-services
```

Build with:

```bash
cd tools
python3 load_lesson_pages_l6.py                     # validate
python3 load_lesson_pages_l6.py --emit-sql > ../db/seed/10_lesson_pages_l6.sql
```

The validation run prints the note count, the character count, the figure
count, and two lists that must both be empty: titles written here that are not
on the progression sheet, and teachable lessons on the sheet with no note.
Those two lists are the whole point of running it. A title that drifts by one
word stops matching, the note silently detaches from its lesson, and nobody
notices until a student cannot find the reading for a Thursday.

## Why Lower Sixth is not just Form 5 with harder words

The Form 5 paper asks what a thing is. The A/L paper asks the student to
distinguish, to justify, and to state advantages and disadvantages, usually in
pairs. So these notes are built differently:

Every comparison is a table, because the answer is a comparison and a student
who revised from prose writes prose when the question wanted two columns.

Advantages and disadvantages always appear together. A student who has only
read the advantages writes half an answer and cannot see that it is half.

Where the paper is fussy about a word, the word is flagged. "Volatile", not
"it forgets". "Feedback", or the control-systems answer is wrong.

Each note ends with an *In the exam* section naming the specific mistake this
topic invites — phased against pilot, polling against interrupt, OMR against
OCR, the address bus against the data bus. Those pairs are where the marks
actually go.

## The figures are drawn, not cropped

Thirty diagrams, all inline SVG written by hand in the note bodies.

The Form 5 chapters take their figures from the booklets, cropped out of a page
render by `../notes/extract.py`. That was the right decision there: those
figures are the booklet's own, and reproducing them exactly is the point of a
reference copy.

It is the wrong decision here. A crop of a 2014 photocopy is grey, fixed in
size, and unreadable on a phone at night, which is the device and the hour most
of this reading happens. So these are drawn instead — the von Neumann diagram,
the six gate symbols, the machine cycle, the storage hierarchy, the two
scheduling Gantt charts, the waterfall and the V-model, the PERT network, the
project triangle, the workstation posture drawing, and twenty more.

Drawn figures also scale, and they follow the page. Every one strokes and fills
with `currentColor` and the site's own custom properties — `var(--cyan)`,
`var(--cyan-soft)` — and never with a hard-coded hex value, so the same drawing
is legible on the light reading surface and in dark mode. `app/globals.css`
carries the `.note-html figure.fig` rules; a wide diagram scrolls inside its own
box rather than pushing the page sideways on a narrow screen.

Every `<svg>` has a `role="img"` and an `aria-label` describing what it shows,
and every figure has a `<figcaption>` that says what to notice rather than
repeating the title. A caption that reads "Diagram of the machine cycle" is
worth nothing to somebody who cannot see the diagram.

One constraint worth knowing before editing: `NoteBody` strips `<script>`,
`<style>`, `<iframe>` and every `on*` handler before rendering. Inline
`style="..."` attributes survive, `<style>` blocks do not, so an SVG must carry
its styling as presentation attributes. That is why the drawings look the way
they do.

## The head of each note

The Form 5 loader puts the lesson's `objectives` at the head of the note. The
Lower Sixth sheet has no objectives column; it has `content_points`, which are
the syllabus content for the hour rather than learning outcomes. So the block
reads "This lesson covers" instead, and the wording is the sheet's own.

Nothing is invented there. A note that states an objective the scheme of work
does not is a note that will quietly drift away from what is taught in the
room, and the teacher will be the last to find out.

## Practicals

Practical titles repeat: "Practical: Presentation" appears fourteen times on
the sheet, "Practical: Spreadsheet" eight, "Practical: Web Authoring" four.
Six distinct titles across twenty-nine practical lessons. There is
one note per distinct title, attached to every lesson bearing it, which is why
the link count in the seed file is larger than the note count.

They are written as things to do at the machine, with the examinable idea named
at the end — why a slide master earns marks, what absolute referencing is for,
what `alt` text is for. A practical note that only lists steps teaches nobody
what the paper will ask.

## One fix that came with this

`app/student/notes/page.js` calls `student_notes(p_student)`. No function of
that signature existed — the only definition, in `db/seed/08_lesson_notes.sql`,
takes no arguments — so the call matched nothing and every student was shown
"No notes for your class yet".

Both written note sets already set `note_sources.syllabus_id`, and nothing read
it. With one year of notes in the table that was untidy. With two it is wrong:
a Form 5 student would open Notes and be handed the Lower Sixth material with
nothing on the page to tell them so.

So `10_lesson_pages_l6.sql` ends by replacing the function with one that takes
the student, resolves their class's `syllabus_id`, and returns the sources
belonging to that year plus any source with no `syllabus_id` at all. The
scanned booklets have none, so they stay visible to everyone, exactly as now.

It resolves the year from `classes.syllabus_id` rather than `classes.form_level`
the way `student_profile` does. `form_level` is nullable; a class saved without
one would leave that student with an empty Notes page and no clue why.
