# Extraction review — GCE Computer Science past questions

Source PDF: 334 pages, 69 MB.

## How the text was obtained

- 209 pages had a real text layer and were read directly.
- 125 pages were image-only scans and were read with OCR (Tesseract).
- 20 pages were two-column and were split at the gutter before parsing;
  20 scanned MCQ pages were re-scanned one column at a time, which fixed
  text bleeding between columns.

**OCR pages carry character errors.** Every question drawn from one is tagged
`"extraction": "ocr"` and flagged `from_ocr`. Read those against the PDF before use.

## What came out

- **419 multiple-choice questions** — `mcq_questions.json`
  - 132 have an answer key; 287 do not (most exam papers in this compilation were printed without answers)
  - 131 parsed cleanly with no review flag
- **861 structured / essay question parts** — `structured_questions.json`
  - 132 sit near an 'Answer Pointers' or marking-guide block
- **Full cleaned text of all 334 pages** — `past_questions_full_text.txt`

## Flags on the MCQs

| Flag | Count | Meaning |
|---|---|---|
| `no_answer_key` | 287 | no answer printed in the source |
| `from_ocr` | 66 | text came from OCR, verify wording |
| `missing_options` | 36 | fewer than four options recovered |
| `references_figure` | 6 | stem refers to a diagram, table or image not captured here |
| `empty_option` | 3 | an option letter was found but its text was blank |

## Known limits

- **Diagrams, truth tables and logic circuits are not captured.** Many questions
  depend on an image; the stem survives, the figure does not. These are flagged
  `references_figure` where detectable, but detection is by keyword and will miss some.
- **Structured questions are fragmentary.** A part like `(ii) ... (2 marks)` has no
  meaning without its parent stem, so each record carries a `context_before` field
  and a page number. Use the full text file for the whole question.
- **Paper attribution is best-effort.** The `paper` field is inferred from the nearest
  preceding header, so pages between papers can inherit the wrong one. Verify against
  the page number before trusting it.
- The compilation repeats questions across sections; identical stems are linked with
  `is_repeat` and `duplicate_of_page`.

## Pages with the most MCQs

p324 (17), p325 (16), p63 (14), p326 (14), p66 (13), p75 (13), p61 (12), p76 (12), p77 (12), p86 (12), p62 (11), p87 (10)
