# GCE Computer Science Coach

A curriculum and assessment system for GCE Computer Science and ICT, built for
Government High School (Lycée) de Mbonjo, Limbe.

**To put this online, read [DEPLOYMENT.md](DEPLOYMENT.md).**

---

## What exists today

The complete Cameroon curriculum for three levels, structured and queryable:

| | Form 4 CS | Form 5 CS | Lower Sixth ICT |
|---|---|---|---|
| Modules / Teaching Units | 4 | — | 11 |
| Categories of action | 18 | 23 | — |
| Rows on the sheet | 107 | 108 | 103 |
| Objectives | 161 | 177 | — |
| Content points | — | — | 136 |
| Practical tasks | — | — | 31 |

**318 rows, 338 objectives, 136 content points, 31 practical tasks.** All three
validate with zero errors.

Plus a website that reads it: pick a progression sheet, see the whole year by
term and week with every objective in place. Public pages need no login. Behind
a teacher sign-in there is an admin area with the two editors described below.

---

## Layout

```
db/
  schema.sql        27 tables
  rls.sql           security policies — run this, it is not optional
  auth.sql          teacher login and write access
  phase5.sql        provenance and review columns for imported questions
  seed/             the three curricula and the past-question bank
tools/
  curriculum/       the progression sheets as readable YAML
  load_curriculum.py  validates them and generates the SQL
  load_questions.py   turns extracted past questions into the seed
app/
  page.js           list of progression sheets
  syllabus/[id]/    a whole year by term and week
  lesson/[id]/      a published lesson, set for reading
  login/            teacher sign in
  admin/            lesson editor, term planner, students, question bank,
                    review queue for imported questions
  opengraph-image.png  the card that appears when the link is shared
  icon.png          browser tab icon
lib/                database connections (browser and server)
middleware.js       keeps /admin closed to strangers
public/             both crests: MINESEC emblem and the school shield
app/icon.png        browser tab icon
```

## Typography

Two faces, each with one job. **Literata** carries anything a student reads for
more than a minute — it was drawn for Google Books, for long passages on a
screen, which is exactly what a lesson note is. **Inter** handles the interface,
where you scan rather than read.

Both are downloaded at build time and served from your own domain, so a
student's phone never makes a request to Google. One less thing to fail on a
weak connection.

The reading column is capped at 680px, which keeps lines near 70 characters —
the width at which sustained reading stays comfortable.

## Colours

Sampled from the MINESEC emblem: green `#1B8A2B` and `#006428`, gold `#F0C000`,
red `#9C2F2F`. The school shield uses the same three, so the two crests sit
together in the masthead without clashing.

Green does the structural work. Gold is a border and badge colour, never text
on white and never a large background — it fails contrast badly and this has to
stay readable on a cheap phone in daylight. Red is reserved for Evaluation and
Remediation weeks, and for anything genuinely wrong.

**`tools/curriculum/` is the part worth your attention.** Those three files are
plain text. Every lesson, every objective, every week. If something is wrong you
correct it there and re-run the loader — nothing about your curriculum is buried
inside code.

---

## Why the schema looks the way it does

Three real constraints shaped it, none of them technical preferences:

**Power cuts and expensive data.** Every table uses generated IDs rather than
counting `1, 2, 3`, so two phones working offline can never overwrite each
other. Every table records when it changed, so a returning device asks "what's
new since Tuesday?" instead of re-downloading everything. Nothing is truly
deleted, so a deletion reaches a phone that has been off for a week.

**Three differently shaped Ministry documents.** Form 4 has Modules, Categories
of action and Competency statements. Form 5 has Categories only. Lower Sixth has
Teaching Units and a parallel practical stream. Four flags on the syllabus row
let one schema hold all three and show your own vocabulary back to you.

**Students without email.** Password reset by email is useless here, so students
log in with a short code you hand out and reset in two clicks.

---

## What is missing, and only you can supply it

**Exam frequency.** Empty on all 41 categories of action. It is the field that
turns this from a record of the syllabus into something that tells a student
what to revise first. **There is now a screen for it:** `/admin/exam-frequency`,
Form 5 first, tappable on a phone, one save for the lot.

**Six unconfirmed cross-year links.** The loader proposes that Form 5's
"Analyzing simple logic circuits and expressions" continues Form 4's "Analysing
simple logic circuits", and five others. Confirm or reject them at
`/admin/links`. They feed no recommendation until you decide.

**Notes for six Form 5 categories.** Assistive technology, network hardware,
data communication, the internet and blockchain, social networks, and digital
identities have no notes at all — 17 lessons running continuously through Second
Term weeks 14 to 22. Also missing inside categories you do have notes for: De
Morgan's laws, Boolean simplification, and normalization to 3NF.

---

## What still has to be built

| | |
|---|---|
| Student sign-in | Codes are generated and stored; the accounts are not created yet |
| Assessments | Assembling questions into a quiz or mock and setting it for a class. Self-directed practice is recorded; a test a teacher sets is not built yet. |
| Marking | MCQ and true/false mark themselves; everything else queues for you |
| Mastery engine | Computed from recorded answers by `refresh_lesson_mastery`. |
| Offline | The schema was built for it. No service worker or sync queue exists yet. |

---

## What a student does is remembered

Every practice answer is recorded against the question, the attempt and the
student. That is what the tagging was for: a wrong answer names a lesson.

- **`/student`** leads with which topics to go back over, and links straight to
  the chapter that covers each one. Only topics with at least three answers
  behind them appear — calling a topic weak after one wrong answer is noise,
  and a revision list that changes every session teaches a student to ignore it.
- **Students choose what to practise**: a topic, a mixed set, or "what I keep
  getting wrong", with 5 to 30 questions and an optional 45, 60 or 90 second
  timer per question. Each topic shows how many questions sit behind it and how
  the student has done there so far.
- **A mixed set is weighted** towards what a student has been getting wrong, and
  away from questions they have already answered correctly. Not exclusively:
  a set drawn only from weak topics never confirms that anything has been
  learned.
- **`/admin/progress`** is the same roll-up across a class, weakest first. A
  topic appears once five answers have gone through it.

`lesson_mastery` is a cache of the answers, refreshed when a run finishes
rather than maintained by a trigger on every answer.

Read the class view as a signal rather than a mark: it counts self-directed
practice, so it reflects who has been revising as much as who understands.

## The course notes

Three sets, in the order a student meets them.

**One note per lesson** — 67 of them, one for every teachable lesson on the
Form 5 progression sheet, sized for the hour it is taught in. Each opens with
that lesson's own objectives, taken from the sheet rather than invented, so the
notes and the scheme of work cannot drift apart. Written plainly: short
sentences, the point then the example, and the exam's own wording flagged where
the mark scheme is fussy about it.

Notes per chapter came first and were a mistake. A chapter is three or four
lessons of material, and a student handed a whole chapter the night before a
test does not read it. These two older sets remain underneath:

**The written chapters** — 19 chapters from the earlier static platform,
covering the same ground at chapter length.

**The booklet chapters** — the school's two PDF booklets, extracted. Long, and
in the register of a scanned textbook, but they hold all 104 figures. They sit
underneath as the reference copy.

Loading the second without the first was a mistake worth naming: a wall of
extracted prose is worse to read than the source it came from, and it was
presented as the main reading for a while.

The school's two O-Level booklets are loaded as eight chapters, about 190,000
characters, readable at `/admin/notes`.

**The diagrams are kept.** The functional diagram of a computer, the instruction
cycle, the memory hierarchy, every logic gate symbol, the flowchart symbol
table, the PERT and Gantt charts — 104 figures in all, cropped straight out of
the printed page and served from `public/notes/figures`. They are not redrawn
and not described in words; a student sees what is in the booklet in front of
them.

Most of those are vector drawings rather than images, so extracting the
embedded pictures would have found the photographs and missed the syllabus.
`tools/notes/README.md` explains how they are found instead.

Copy `public/notes/figures` along with the seed or every image in the notes is
a broken link.

---

## The question bank

522 questions from the school's 334-page past-paper pamphlet are loaded and
tagged to Form 5. 408 multiple choice, 114 structured.

They are not clean. A third of the pamphlet was photocopied rather than typed,
so that text came out of OCR and carries character errors. Many questions point
at a truth table or logic circuit that no scan captured. Most exam booklets were
printed without an answer key at all.

Rather than hold the bank back until every page had been retyped, the doubt is
recorded alongside each question and as much of the gap as possible is filled in
before a teacher ever sees it:

- **349 of the 408 multiple-choice questions arrive with an answer.** 128 were
  printed on the paper. The other 221 were worked out from the syllabus during
  import and are marked `answer_origin = 'proposed'` — offered, not asserted.
- **Six lost figures were redrawn.** Where a question depended on a picture the
  scanner could not read, and that picture is standard syllabus content (a NAND
  symbol, an XOR truth table), it is redrawn in `QuestionFigure.js` and attached
  by name. Question-specific artwork is still lost and stays flagged.
- **Obvious scanner damage was repaired** where the correct reading is not in
  doubt: "Theterin multiprogramining" back to "The term multiprogramming".

A database constraint stops any unreviewed question from marking a student,
whatever its type. `/admin/questions/review` shows each one with its proposed
answer pre-selected, and offers to accept the clean high-confidence ones in a
single action, so the queue starts at roughly sixty questions that genuinely
need a teacher rather than four hundred that mostly do not.

Every imported row keeps the page it came from, so when a question looks wrong
you know exactly where to look.

```
tools/load_questions.py   turns the extracted JSON into the seed
db/phase5.sql             adds the provenance and review columns — run first
db/seed/04_past_questions.sql   generated, do not edit by hand
```

Question ids are derived from the question text, so re-running the seed after
correcting the extract inserts nothing twice and does not disturb lesson tags or
review decisions already made.

## The authored questions

The static platform that preceded this app carried 75 multiple-choice questions
and 5 structured ones, written rather than scanned. They are in
`db/seed/07_authored_questions.sql`, and they are worth more than their number
suggests.

**They arrive marking.** Verified answers, an explanation on every question, and
a lesson tag. Nothing to review. Where the 522 pamphlet questions needed a
teacher before they could score anybody, these were correct the day they were
written.

**Every wrong option has its own feedback.** Not "the answer is B" but "the
Control Bus carries control signals, not addresses." A student who picks the
Control Bus holds a specific wrong idea, and the sentence written against that
option is the one that corrects it. 225 of them. `question_options.feedback`
exists for this, and the practice screen shows a student the note for the option
they actually chose — and only that one, so the next attempt is not a lookup.

The 5 structured questions come with their scenario, their parts, the marks per
part, and a model answer for each. Those live in `question_parts`.

## Tagging

Untagged, a wrong answer is just a wrong answer. Tagged, it points at a lesson,
which is the whole point of the bank.

`db/seed/06_tags.sql` links **354 questions to 36 Form 5 lessons**, and each of
the eight note chapters to the lessons it covers, marked `full`, `partial` or
`background`.

The map in `tools/topic_map.py` is written by hand, because the two vocabularies
do not overlap. The lesson is called "Storage and processing devices"; the
question says "which of these hardware components is generally used to hold data
temporarily" and uses neither word. Matching lesson titles against question text
produces confident nonsense. What works is naming, per lesson, the words a
question on that lesson actually contains.

56 questions are left untagged on purpose. Most are Form 4 material that drifted
into the pamphlet — computer generations, Babbage, valves — and have no Form 5
lesson to attach to. A few matched only one vague word, and a wrong tag is worse
than none: it puts a misleading question behind a real revision topic.

**Where the questions came from is only partly known.** The pamphlet interleaves
loose question banks between real papers, and a header only reliably describes
the dozen pages after it. Where attribution was not certain the year and paper
are left empty rather than guessed — a question wrongly labelled *GCE 2010* is
worse than one labelled nothing, because you would have no reason to doubt it.

The offline gap is the largest remaining piece and the one that decides whether
students in Limbe actually use this. It was left until last on purpose: a sync
layer built before there was anything to sync would have been wasted work.
