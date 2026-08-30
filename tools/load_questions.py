#!/usr/bin/env python3
"""
Question-bank loader for the GCE Computer Science Coach.

Turns the extracted past-question JSON into rows in questions, question_options
and question_lessons.

The pamphlet these questions came from is a photocopied compilation, not a
dataset. A third of its pages were scanned rather than typed, so their text came
from OCR and contains character errors. Many questions refer to a truth table or
a logic circuit that exists only as an image. Most exam booklets were printed
without an answer key.

This loader does not pretend otherwise. Every row it writes carries the page it
came from and a list of what the extractor was unsure about, and anything
uncertain is marked needs_review, which phase5.sql prevents from marking a
student automatically. The teacher clears the doubt one question at a time; the
bank is useful from the first day rather than the day the last page is checked.

IDs are derived from the question text with uuid5, not generated fresh. Running
this twice inserts nothing the second time, so a corrected extract can be
re-loaded without duplicating the bank or orphaning the lesson tags a teacher
has already made.

Usage
    python3 load_questions.py --validate  ../out/mcq_questions.json
    python3 load_questions.py --emit-sql  ../out/mcq_questions.json \
        --structured ../out/structured_questions.json \
        --syllabus d280ec19-0e1f-436e-806e-f8c5fcdf9c6b \
        > ../db/seed/04_past_questions.sql
"""

import argparse
import json
import os
import re
import sys
import uuid

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "questions"))
try:
    from proposed_answers import (ANSWERS as PROPOSED, STEM_FIXES,
                                  FIGURES, REFINEMENTS)
except ImportError:      # answers are optional; the bank loads without them
    PROPOSED, STEM_FIXES, FIGURES, REFINEMENTS = {}, {}, {}, {}

# Namespace for deterministic question IDs. Fixed forever: changing it would
# make every previously loaded question look new and duplicate the bank.
NS = uuid.UUID("6f4a1d3e-9b2c-4f18-a0d7-5c8e21b7a640")

BATCH = "gce-pamphlet-2026"

# Flags that mean the extractor could be wrong about the question itself, as
# opposed to merely noting where it came from.
DOUBT = {"from_ocr", "no_answer_key", "missing_options", "empty_option",
         "references_figure", "answer_inferred_from_duplicate", "long_stem",
         "answer_proposed_high", "answer_proposed_medium", "repaired_by_hand"}


def sql_str(v):
    """Quote a value for SQL, or NULL."""
    if v is None or v == "":
        return "NULL"
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, (int, float)):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"


def sql_text_array(items):
    if not items:
        return "NULL"
    inner = ",".join('"' + str(i).replace('"', '\\"') + '"' for i in items)
    return "'{" + inner + "}'::text[]"


def tidy(text):
    """Normalise whitespace and repair the commonest OCR damage.

    Only substitutions that are unambiguous in this corpus are made here. An
    'l' that should be a '1' is not one of them: it is a judgement call, and a
    loader that quietly rewrites question text is worse than one that leaves
    the teacher something visibly odd to correct.
    """
    text = re.sub(r"\s+", " ", text).strip()
    text = text.replace("\u2019", "'").replace("\u201c", '"').replace("\u201d", '"')
    text = re.sub(r"\uf0b7|\uf0a7", "-", text)          # bullet glyphs from Word
    text = re.sub(r"\s+([,.;:?])", r"\1", text)
    text = re.sub(r"_{3,}", "______", text)              # fill-in-the-blank rules
    return text


def question_id(stem, options):
    """Deterministic ID from the question's own content."""
    key = re.sub(r"[^a-z0-9]", "", stem.lower())
    key += "|" + "|".join(re.sub(r"[^a-z0-9]", "", v.lower())
                          for v in options.values())
    return str(uuid.uuid5(NS, key))


def infer_difficulty(q):
    """A rough first guess, meant to be corrected.

    Recall questions ("what does X stand for") are easy; anything asking for a
    calculation, a conversion or a trace is harder. This is a starting point so
    the field is not uniformly empty, not a claim to know.
    """
    s = q["stem"].lower()
    if re.search(r"\b(calculate|convert|simplify|evaluate the|result of|trace)\b", s):
        return "hard"
    if re.search(r"\b(stands? for|abbreviation|acronym|what is the (full )?meaning|"
                 r"which of the following is a|define)\b", s):
        return "easy"
    return "medium"


def source_fields(paper):
    """Map extracted paper context onto the schema's source columns.

    When attribution is not confident the year and paper are left null rather
    than guessed. A question labelled 'GCE 2010' that is not from 2010 is worse
    than one labelled nothing at all: the teacher would have no reason to doubt
    it.
    """
    exam = (paper or {}).get("exam")
    confident = (paper or {}).get("confident")
    if exam == "GCE Board":
        source = "gce_past"
    elif exam and "Mock" in exam:
        source = "mock"
    else:
        source = "gce_past"       # the whole pamphlet is past papers
    if not confident:
        return source, None, None
    return source, paper.get("year"), (
        f"Paper {paper['paper']}" if paper.get("paper") else None)


def build_mcq_rows(questions):
    rows, opt_rows, skipped = [], [], []
    seen = set()

    for q in questions:
        key = (q["page"], q.get("number"))
        # A scanner error that is unambiguous is repaired here rather than left
        # for a teacher to retype. Only the repairs listed by hand are applied.
        stem = tidy(STEM_FIXES.get(key, q["stem"]))
        options = {k: tidy(v) for k, v in q["options"].items() if tidy(v)}

        # A hand repair replaces the options outright. The scanner ran the
        # four choices together into one, and the original is recoverable from
        # inside the text it produced; see REFINEMENTS for why only those are
        # touched.
        fix = REFINEMENTS.get(key)
        if fix:
            stem = tidy(fix.get("stem", stem))
            options = {k: tidy(v) for k, v in fix["options"].items()}

        # A multiple-choice question needs a stem and at least three options to
        # be worth a teacher's time to fix. Below that there is nothing to
        # correct, only something to retype from the PDF.
        if len(stem) < 15 or len(options) < 3:
            skipped.append((q["page"], stem[:60], "too little recovered"))
            continue

        # A stem that opens with a structured-paper part marker — "(a)", "(i)" —
        # is a Paper 2 question whose sub-parts the extractor mistook for
        # options. These read plausibly enough to survive review by eye, so
        # they are refused here rather than left for a teacher to notice.
        if re.match(r"^\(?\s*(?:[a-e]|i{1,3}|iv|v)\s*\)", stem, re.I):
            skipped.append((q["page"], stem[:60], "structured part, not an MCQ"))
            continue
        if re.search(r"\b(?:Table|Figure|Diagram)\s*[|1I]?\s*(?:is|shows|above|below)\b",
                     stem, re.I) and len(stem) > 120:
            skipped.append((q["page"], stem[:60], "table/figure preamble"))
            continue

        qid = question_id(stem, options)
        if qid in seen:
            continue          # the pamphlet repeats itself; keep the first
        seen.add(qid)

        flags = [f for f in q.get("flags", [])]
        answer = q.get("answer")
        if answer and answer not in options:
            answer = None
            flags.append("answer_key_not_among_options")

        origin = "printed" if answer else None
        confidence = None

        if fix:
            answer = fix["answer"]
            confidence = fix.get("confidence", "medium")
            origin = "proposed"
            flags = [f for f in flags
                     if f not in ("no_answer_key", "missing_options",
                                  "empty_option", "from_ocr")]
            flags.append("repaired_by_hand")
            flags.append(f"answer_proposed_{confidence}")

        # No key was printed, but the question may be ordinary syllabus recall
        # that was worked out during import. Such an answer is offered, never
        # asserted: it is marked proposed, and it still needs review.
        if not answer and key in PROPOSED:
            letter, confidence = PROPOSED[key]
            if letter in options:
                answer = letter
                origin = "proposed"
                if "no_answer_key" in flags:
                    flags.remove("no_answer_key")
                flags.append(f"answer_proposed_{confidence}")

        # A lost figure that has been redrawn is no longer a reason to hold the
        # question back, so the flag goes when the figure is supplied.
        figure = FIGURES.get(key)
        if figure and "references_figure" in flags:
            flags.remove("references_figure")
            flags.append("figure_redrawn")

        needs_review = bool(set(flags) & DOUBT) or not answer or origin == "proposed"
        source, year, paper_label = source_fields(q.get("paper"))

        rows.append({
            "id": qid,
            "question_text": stem,
            "question_type": "mcq",
            "marks": 1,
            "difficulty": infer_difficulty(q),
            "source": source,
            "source_year": year,
            "source_paper": paper_label,
            "source_number": str(q["number"]) if q.get("number") else None,
            # auto_markable stays false until a teacher has looked. phase5.sql
            # enforces this; setting it here would fail the check constraint.
            "auto_markable": False,
            "needs_review": needs_review,
            "import_batch": BATCH,
            "import_page": q["page"],
            "import_flags": flags,
            "answer_origin": origin,
            "answer_confidence": confidence,
            "figure_name": figure,
        })

        for i, (label, text) in enumerate(sorted(options.items())):
            opt_rows.append({
                "question_id": qid,
                "label": label,
                "option_text": text,
                "is_correct": answer == label,
                "sequence": i + 1,
            })

    return rows, opt_rows, skipped


def build_structured_rows(items):
    """Only whole structured questions, not the fragments.

    The extractor found 861 pieces carrying a mark allocation, but most are
    sub-parts like '(ii) ... (2 marks)' which mean nothing without the stem
    above them. Loading those would bury the bank in noise. A piece is taken
    only if it opens with its own question number and carries enough text to
    stand alone.
    """
    rows, skipped = [], []
    seen = set()
    for s in items:
        text = tidy(s["text"])
        if not re.match(r"^\d{1,2}[.)]", text) or len(text) < 70:
            skipped.append((s["page"], text[:60], "fragment without a stem"))
            continue
        qid = str(uuid.uuid5(NS, re.sub(r"[^a-z0-9]", "", text.lower())))
        if qid in seen:
            continue
        seen.add(qid)

        flags = []
        if s.get("extraction") == "ocr":
            flags.append("from_ocr")
        if not s.get("has_answer_pointers"):
            flags.append("no_marking_guide")

        source, year, paper_label = source_fields(s.get("paper"))
        num = re.match(r"^(\d{1,2})", text)
        rows.append({
            "id": qid,
            "question_text": text,
            "question_type": "structured",
            "marks": s.get("marks") or 1,
            "difficulty": None,
            "source": source,
            "source_year": year,
            "source_paper": paper_label,
            "source_number": num.group(1) if num else None,
            "auto_markable": False,
            "needs_review": True,
            "import_batch": BATCH,
            "import_page": s["page"],
            "import_flags": flags,
            "answer_origin": None,
            "answer_confidence": None,
            "figure_name": None,
        })
    return rows, skipped


COLS = ["id", "syllabus_id", "question_text", "question_type", "marks",
        "difficulty", "source", "source_year", "source_paper", "source_number",
        "auto_markable", "needs_review", "import_batch", "import_page",
        "import_flags", "answer_origin", "answer_confidence", "figure_name"]


def emit_sql(qrows, orows, form_level, notes):
    out = []
    w = out.append
    w("BEGIN;")
    w("-- Past GCE and regional mock questions, extracted from the school's")
    w("-- 334-page pamphlet. Generated by tools/load_questions.py — do not edit")
    w("-- this file by hand; correct the extract and regenerate.")
    w("--")
    w("-- Requires db/phase5.sql to have been run first.")
    w("--")
    for line in notes:
        w(f"-- {line}")
    w("")
    w("-- Refuse to run if phase5 is missing, rather than failing halfway")
    w("-- through with a column error and leaving a partial bank behind.")
    w("DO $$")
    w("BEGIN")
    w("  IF NOT EXISTS (SELECT 1 FROM information_schema.columns")
    w("                 WHERE table_name = 'questions' AND column_name = 'needs_review')")
    w("  THEN")
    w("    RAISE EXCEPTION 'Run db/phase5.sql before this seed.';")
    w("  END IF;")
    w("END $$;")
    w("")
    w("-- The syllabus is found by name, not by a hardcoded id. Two databases")
    w("-- built from the same seed files can hold different ids for the same")
    w("-- syllabus, and a seed that assumes one of them is useless on the other.")
    w("DO $$")
    w("BEGIN")
    w("  IF NOT EXISTS (SELECT 1 FROM syllabi")
    w(f"                 WHERE form_level = {sql_str(form_level)} AND deleted_at IS NULL)")
    w("  THEN")
    w(f"    RAISE EXCEPTION 'No {form_level} syllabus found. Run the curriculum "
      "seeds in db/seed/ first (01, then 02, then 03).';")
    w("  END IF;")
    w("END $$;")
    w("")

    w("-- --------------------------------------------------------------------")
    w(f"-- {len(qrows)} questions")
    w("-- --------------------------------------------------------------------")
    w("")
    w("INSERT INTO questions (" + ", ".join(COLS) + ")")
    w("SELECT")
    w("  x.id::uuid, target.id, x.question_text::text, x.question_type::text,")
    w("  x.marks::numeric, x.difficulty::text, x.source::text,")
    w("  x.source_year::integer, x.source_paper::text, x.source_number::text,")
    w("  x.auto_markable::boolean, x.needs_review::boolean,")
    w("  x.import_batch::text, x.import_page::integer, x.import_flags::text[],")
    w("  x.answer_origin::text, x.answer_confidence::text, x.figure_name::text")
    w("FROM (VALUES")
    vals = []
    for r in qrows:
        cells = []
        for c in COLS:
            if c == "syllabus_id":
                continue          # supplied by the lookup below
            v = r[c]
            cells.append(sql_text_array(v) if c == "import_flags" else sql_str(v))
        vals.append("  (" + ", ".join(cells) + ")")
    w(",\n".join(vals))
    w(") AS x(" + ", ".join(c for c in COLS if c != "syllabus_id") + ")")
    w("CROSS JOIN (")
    w("  SELECT id FROM syllabi")
    w(f"  WHERE form_level = {sql_str(form_level)} AND deleted_at IS NULL")
    w("  ORDER BY created_at LIMIT 1")
    w(") AS target")
    # Re-running must not clobber lesson tags or review decisions already made.
    w("ON CONFLICT (id) DO NOTHING;")
    w("")

    w("-- --------------------------------------------------------------------")
    w(f"-- {len(orows)} options")
    w("--")
    w("-- Deleted and rewritten rather than upserted: options have generated")
    w("-- ids, so there is nothing stable to conflict on, and they are always")
    w("-- replaced as a set. Only rows from this batch are touched.")
    w("-- --------------------------------------------------------------------")
    w("")
    w("DELETE FROM question_options WHERE question_id IN (")
    w(f"  SELECT id FROM questions WHERE import_batch = {sql_str(BATCH)}")
    w(");")
    w("")
    if orows:
        w("INSERT INTO question_options (question_id, label, option_text, is_correct, sequence) VALUES")
        ovals = ["  (" + ", ".join([
            sql_str(o["question_id"]), sql_str(o["label"]), sql_str(o["option_text"]),
            sql_str(o["is_correct"]), sql_str(o["sequence"])]) + ")" for o in orows]
        w(",\n".join(ovals))
        w(";")
    w("")
    w("COMMIT;")
    w("")
    w("-- What arrived, and how much of it still needs a human.")
    w("SELECT question_type,")
    w("       count(*) AS loaded,")
    w("       count(*) FILTER (WHERE needs_review) AS needs_review")
    w(f"FROM questions WHERE import_batch = {sql_str(BATCH)} AND deleted_at IS NULL")
    w("GROUP BY question_type ORDER BY question_type;")
    return "\n".join(out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mcq", help="mcq_questions.json")
    ap.add_argument("--structured", help="structured_questions.json")
    ap.add_argument("--form-level", default="Form 5",
                    help="which syllabus these questions belong to, by name "
                         "(default: Form 5). Resolved at load time, so the seed "
                         "works against any database built from db/seed/.")
    ap.add_argument("--validate", action="store_true")
    ap.add_argument("--emit-sql", action="store_true")
    args = ap.parse_args()

    mcqs = json.load(open(args.mcq, encoding="utf-8"))
    qrows, orows, skipped = build_mcq_rows(mcqs)

    srows, sskipped = [], []
    if args.structured:
        srows, sskipped = build_structured_rows(
            json.load(open(args.structured, encoding="utf-8")))

    allrows = qrows + srows
    review = sum(1 for r in allrows if r["needs_review"])
    ready = len(allrows) - review

    notes = [
        f"{len(qrows)} multiple choice, {len(srows)} structured.",
        f"{ready} arrive ready to use; {review} are marked needs_review.",
        "Nothing is auto_markable on import. A question starts marking itself",
        "only after a teacher has checked it against the source page.",
    ]

    if args.validate or not args.emit_sql:
        print(f"multiple choice : {len(qrows)} loadable, {len(skipped)} skipped")
        print(f"structured      : {len(srows)} loadable, {len(sskipped)} fragments skipped")
        print(f"options         : {len(orows)}")
        print(f"needs review    : {review}")
        print(f"ready to use    : {ready}")
        from collections import Counter
        c = Counter(f for r in allrows for f in (r["import_flags"] or []))
        print("\nflags:")
        for f, n in c.most_common():
            print(f"  {f:32s} {n}")
        if skipped:
            print(f"\nfirst few skipped (page, text, reason):")
            for s in skipped[:5]:
                print(f"  p{s[0]:<4} {s[1]!r:64s} {s[2]}")
        return

    print(emit_sql(allrows, orows, args.form_level, notes))


if __name__ == "__main__":
    main()
