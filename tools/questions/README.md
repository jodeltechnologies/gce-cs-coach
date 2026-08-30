# Where the question bank came from

The school's past-paper pamphlet is a 334-page photocopied compilation of GCE
Computer Science papers (subject code 0595), Ordinary Level, roughly 2010 to the
South West Regional Mock of 2026. It is a scan of a scan in places.

This folder holds everything needed to rebuild the bank from it, so that the
seed file is never the only copy of the work.

```
parse.py        reads the PDF and writes the two JSON files
columns.py      splits two-column exam pages, used by parse.py
mcq_questions.json         419 multiple choice questions
structured_questions.json  861 structured question parts
EXTRACTION_REVIEW.md       what the extraction got right and wrong
```

## Rebuilding

The PDF itself is not in the repository — it is 69 MB and is the school's own
document. Put it somewhere readable and run:

```bash
pdftotext -layout past_questions.pdf pages_layout.txt
python3 parse.py                      # writes the two JSON files
cd ..
python3 load_questions.py questions/mcq_questions.json \
    --structured questions/structured_questions.json --validate
python3 load_questions.py questions/mcq_questions.json \
    --structured questions/structured_questions.json --emit-sql \
    > ../db/seed/04_past_questions.sql

# for another level, pass its name as it appears in syllabi.form_level
python3 load_questions.py questions/mcq_questions.json \
    --form-level "Form 4" --emit-sql > ../db/seed/05_form4_questions.sql
```

`parse.py` also needs the OCR pass for the 125 scanned pages. It expects the
results in `ocr/` (whole page) and `ocr2/` (one column at a time), produced with
`pdftoppm -r 200 -gray -png` and `tesseract`. Those intermediates are not kept
here; regenerating them takes about fifteen minutes.

## What the extraction cannot do

**Diagrams are lost.** Truth tables, logic circuits, flowcharts and screenshots
exist only as images in the pamphlet. The question stem survives, the figure
does not. Where the wording gives it away the question is flagged
`references_figure`, but that is keyword detection and it misses some. A
question that reads oddly and mentions "the table below" is one of these.

**OCR pages carry character errors.** 125 pages had no text layer. Their text
was read by machine and contains things like "sofiware" and "Jinked". Every
question from one is flagged `from_ocr`.

**Most answers were never printed.** The exam booklets in this pamphlet are
blank question papers. Only the loose banks in the later pages carry keys, which
is why 280 of the imported questions have no correct option set and must have
one chosen by hand.

**Attribution is deliberately incomplete.** A paper header only describes the
pages immediately after it, and this pamphlet interleaves loose banks between
real papers. Beyond twelve pages from a header the year and paper are left null
rather than guessed.

None of this is fixable by better parsing. It is fixable by a teacher with the
pamphlet open, which is what `/admin/questions/review` is for.
