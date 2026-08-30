#!/usr/bin/env python3
"""
Load the hand-authored questions from the earlier static platform.

Those questions are the opposite of the pamphlet import in every way that
matters. They were written rather than scanned, so the text is clean. They
carry a verified answer, an explanation of why it is right, and — the part
nothing else has — a sentence per wrong option saying why that particular
choice is wrong.

So they arrive reviewed and marking. Sending 75 known-good questions through a
review queue built for OCR damage would waste a teacher's evening confirming
things that were never in doubt.

Usage
    python3 load_authored.py --validate authored_mcq.json authored_structured.json
    python3 load_authored.py --emit-sql authored_mcq.json authored_structured.json \
        > ../db/seed/07_authored_questions.sql
"""

import argparse
import json
import re
import sys
import uuid

NS = uuid.UUID("c1e5b7a2-3f46-4d90-8b17-9a2e4c6d8051")
BATCH = "ghs-mbonjo-static-2025"

# The static platform's topic names, mapped onto Form 5 lesson titles. Its
# topics are exam-paper headings ("Logic Gates"); the progression sheet uses
# teaching units. They are close but not the same words.
TOPIC_TO_LESSON = {
    "Computer Hardware": "Storage and processing devices",
    "Number Systems": "Character and positive integers encoding",
    "Logic Gates": "Logic gates",
    "Networks & Internet": "Network hardware",
    "Databases": "Introduction to databases",
    "Information Systems": "Information systems",
    "SDLC & Project Management": "Stages of SDLC: investigation, analysis, design",
    "Algorithms & Programming": "Algorithms to solve common problems 1",
    "Ethics & Legislation": "Protecting Intellectual property",
    "Information Systems & SDLC": "Information systems",
    "Algorithms, Programming & Data Types": "Algorithms to solve common problems 1",
    "Networks, Security & Communication": "Network hardware",
    "Logic Gates & Number Systems": "Logic gates",
    "Computer Ethics, Legislation & Social Impact": "Protecting Intellectual property",
}

SOURCE_KIND = {
    "GCE Past": ("gce_past", None),
    "HIHS Mock 2024": ("mock", 2024),
    "HIHS Mock 2025": ("mock", 2025),
    "Littoral Mock 2025": ("mock", 2025),
    "SW Mock 2026": ("mock", 2026),
}


def q(v):
    if v is None or v == "":
        return "NULL"
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, (int, float)):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"


def strip_html(s):
    """The scenarios carry <strong> and <em>; keep the words, drop the markup."""
    s = re.sub(r"<br\s*/?>", "\n", s or "")
    s = re.sub(r"</p>\s*<p>", "\n\n", s)
    s = re.sub(r"<[^>]+>", "", s)
    s = (s.replace("&amp;", "&").replace("&lt;", "<").replace("&gt;", ">")
          .replace("&nbsp;", " ").replace("&quot;", '"'))
    return re.sub(r"[ \t]+", " ", s).strip()


def strip_label(opt):
    """Options are stored as "B. Address Bus"; the letter is a separate column."""
    return re.sub(r"^\s*[A-Da-d][.)]\s*", "", opt).strip()


def build(mcq, structured):
    questions, options, parts, links = [], [], [], []

    for item in mcq:
        stem = strip_html(item["q"])
        opts = [strip_label(o) for o in item["opts"]]
        qid = str(uuid.uuid5(NS, "mcq:" + re.sub(r"[^a-z0-9]", "", stem.lower())))
        src, year = SOURCE_KIND.get(item.get("source", ""), ("teacher", None))
        questions.append({
            "id": qid,
            "question_text": stem,
            "question_type": "mcq",
            "marks": 1,
            "difficulty": None,
            "source": src,
            "source_year": year,
            "source_paper": item.get("source"),
            "source_number": str(item.get("id") or ""),
            "model_answer": None,
            "marking_guide": strip_html(item.get("exp")),
            "scenario": None,
            # Written, checked, and carrying their own explanations. Nothing
            # here needs a teacher to confirm it before it can mark.
            "auto_markable": True,
            "needs_review": False,
            "answer_origin": "teacher",
            "answer_confidence": "high",
            "import_batch": BATCH,
        })
        wrong = item.get("wrong") or {}
        for i, text in enumerate(opts):
            label = chr(ord("A") + i)
            options.append({
                "question_id": qid,
                "label": label,
                "option_text": text,
                "is_correct": i == item["ans"],
                "sequence": i + 1,
                "feedback": strip_html(wrong.get(label)) or None,
            })
        lesson = TOPIC_TO_LESSON.get(item.get("topic"))
        if lesson:
            links.append((qid, lesson, True))

    for item in structured:
        scenario = strip_html(item.get("context"))
        title = f"{item.get('topic', 'Structured question')} — {item.get('source', '')}".strip(" —")
        qid = str(uuid.uuid5(NS, "struct:" + re.sub(r"[^a-z0-9]", "", (scenario or title).lower())[:120]))
        year = None
        m = re.search(r"(20\d\d)", str(item.get("source", "")))
        if m:
            year = int(m.group(1))
        questions.append({
            "id": qid,
            "question_text": title,
            "question_type": "structured",
            "marks": item.get("marks") or 0,
            "difficulty": None,
            "source": "mock" if "Mock" in str(item.get("source")) else "gce_past",
            "source_year": year,
            "source_paper": item.get("source"),
            "source_number": str(item.get("num") or ""),
            "model_answer": None,
            "marking_guide": None,
            "scenario": scenario,
            # A structured answer cannot be marked by comparing strings, so it
            # stays manual however good the model answer is.
            "auto_markable": False,
            "needs_review": False,
            "answer_origin": "teacher",
            "answer_confidence": "high",
            "import_batch": BATCH,
        })
        for i, p in enumerate(item.get("parts") or []):
            model = p.get("modelAnswer")
            if isinstance(model, list):
                model = "\n".join(strip_html(x) for x in model)
            parts.append({
                "question_id": qid,
                "label": p.get("label") or f"({chr(97 + i)})",
                "prompt": strip_html(p.get("q")),
                "marks": p.get("marks") or 0,
                "model_answer": model,
                "hint": strip_html(p.get("hint")),
                "sequence": i + 1,
            })
        lesson = TOPIC_TO_LESSON.get(item.get("topic"))
        if lesson:
            links.append((qid, lesson, True))

    return questions, options, parts, links


QCOLS = ["id", "question_text", "question_type", "marks", "difficulty", "source",
         "source_year", "source_paper", "source_number", "model_answer",
         "marking_guide", "scenario", "auto_markable", "needs_review",
         "answer_origin", "answer_confidence", "import_batch"]


def emit(questions, options, parts, links, form_level):
    o = []
    w = o.append
    w("BEGIN;")
    w("-- Questions written for the earlier static GHS Mbonjo platform.")
    w("-- Generated by tools/load_authored.py. Run after db/phase7.sql.")
    w("--")
    w("-- Unlike the pamphlet import, these were written rather than scanned.")
    w("-- Every one carries a verified answer, an explanation, and a sentence")
    w("-- per wrong option saying why that choice is wrong. They arrive ready")
    w("-- to mark; there is nothing for a teacher to check.")
    w("")
    w("DO $$")
    w("BEGIN")
    w("  IF NOT EXISTS (SELECT 1 FROM information_schema.columns")
    w("                 WHERE table_name='question_options' AND column_name='feedback') THEN")
    w("    RAISE EXCEPTION 'Run db/phase7.sql before this seed.';")
    w("  END IF;")
    w(f"  IF NOT EXISTS (SELECT 1 FROM syllabi WHERE form_level={q(form_level)}"
      " AND deleted_at IS NULL) THEN")
    w(f"    RAISE EXCEPTION 'No {form_level} syllabus found. Run db/seed/ first.';")
    w("  END IF;")
    w("END $$;")
    w("")

    w(f"-- {len(questions)} questions")
    w("INSERT INTO questions (" + ", ".join(
        ["id", "syllabus_id"] + [c for c in QCOLS if c != "id"]) + ")")
    w("SELECT x.id::uuid, target.id, x.question_text::text, x.question_type::text,")
    w("       x.marks::numeric, x.difficulty::text, x.source::text,")
    w("       x.source_year::integer, x.source_paper::text, x.source_number::text,")
    w("       x.model_answer::text, x.marking_guide::text, x.scenario::text,")
    w("       x.auto_markable::boolean, x.needs_review::boolean,")
    w("       x.answer_origin::text, x.answer_confidence::text, x.import_batch::text")
    w("FROM (VALUES")
    w(",\n".join("  (" + ", ".join(q(r[c]) for c in QCOLS) + ")" for r in questions))
    w(") AS x(" + ", ".join(QCOLS) + ")")
    w("CROSS JOIN (SELECT id FROM syllabi")
    w(f"            WHERE form_level={q(form_level)} AND deleted_at IS NULL")
    w("            ORDER BY created_at LIMIT 1) AS target")
    # Re-running should improve an existing row, not skip it: the text here is
    # authoritative in a way the OCR import never was.
    w("ON CONFLICT (id) DO UPDATE SET")
    w("  question_text = EXCLUDED.question_text,")
    w("  marking_guide = EXCLUDED.marking_guide,")
    w("  scenario = EXCLUDED.scenario,")
    w("  updated_at = now();")
    w("")

    w(f"-- {len(options)} options, each with the feedback for choosing it")
    w(f"DELETE FROM question_options WHERE question_id IN (")
    w(f"  SELECT id FROM questions WHERE import_batch = {q(BATCH)});")
    w("INSERT INTO question_options (question_id, label, option_text, is_correct, sequence, feedback)")
    w("VALUES")
    w(",\n".join("  (" + ", ".join([
        q(r["question_id"]), q(r["label"]), q(r["option_text"]),
        q(r["is_correct"]), q(r["sequence"]), q(r["feedback"])]) + ")"
        for r in options))
    w(";")
    w("")

    if parts:
        w(f"-- {len(parts)} parts of structured questions")
        w(f"DELETE FROM question_parts WHERE question_id IN (")
        w(f"  SELECT id FROM questions WHERE import_batch = {q(BATCH)});")
        w("INSERT INTO question_parts (question_id, label, prompt, marks, model_answer, hint, sequence)")
        w("VALUES")
        w(",\n".join("  (" + ", ".join([
            q(r["question_id"]), q(r["label"]), q(r["prompt"]), q(r["marks"]),
            q(r["model_answer"]), q(r["hint"]), q(r["sequence"])]) + ")"
            for r in parts))
        w(";")
        w("")

    if links:
        w(f"-- {len(links)} lesson tags")
        w("INSERT INTO question_lessons (question_id, lesson_id, is_primary)")
        w("SELECT v.qid::uuid, l.id, v.p::boolean")
        w("FROM (VALUES")
        w(",\n".join(f"  ({q(a)}, {q(b)}, {q(c)})" for a, b, c in links))
        w(") AS v(qid, lesson_title, p)")
        w("JOIN questions qq ON qq.id = v.qid::uuid")
        w("JOIN lessons l ON l.title = v.lesson_title")
        w("            AND l.syllabus_id = qq.syllabus_id AND l.deleted_at IS NULL")
        w("ON CONFLICT (question_id, lesson_id) DO NOTHING;")
        w("")

    w("COMMIT;")
    w("")
    w("SELECT question_type, count(*) AS loaded,")
    w("       count(*) FILTER (WHERE auto_markable) AS mark_themselves")
    w(f"FROM questions WHERE import_batch = {q(BATCH)} AND deleted_at IS NULL")
    w("GROUP BY question_type ORDER BY question_type;")
    return "\n".join(o)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mcq")
    ap.add_argument("structured")
    ap.add_argument("--form-level", default="Form 5")
    ap.add_argument("--validate", action="store_true")
    ap.add_argument("--emit-sql", action="store_true")
    a = ap.parse_args()

    mcq = json.load(open(a.mcq, encoding="utf-8"))
    structured = json.load(open(a.structured, encoding="utf-8"))
    questions, options, parts, links = build(mcq, structured)

    if a.validate or not a.emit_sql:
        print(f"questions      : {len(questions)}")
        print(f"options        : {len(options)}")
        print(f"  with feedback: {sum(1 for o in options if o['feedback'])}")
        print(f"structured parts: {len(parts)}")
        print(f"lesson tags    : {len(links)}")
        bad = [x for x in questions if x["question_type"] == "mcq"
               and sum(1 for o in options if o["question_id"] == x["id"] and o["is_correct"]) != 1]
        print(f"mcqs without exactly one correct option: {len(bad)}")
        untagged = {x["id"] for x in questions} - {l[0] for l in links}
        print(f"questions with no lesson tag: {len(untagged)}")
        return

    print(emit(questions, options, parts, links, a.form_level))


if __name__ == "__main__":
    main()
