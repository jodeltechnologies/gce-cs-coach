#!/usr/bin/env python3
"""
Generate db/seed/06_tags.sql: links from questions and note chapters to the
lessons they belong to.

Run after 04_past_questions.sql and 05_notes.sql.

Lesson ids are looked up by title at load time rather than hardcoded, for the
same reason the question seed looks up its syllabus by name: ids are generated
fresh by load_curriculum.py, so they differ between any two databases built
from the same files.

Usage
    python3 tag.py --validate  questions/mcq_questions.json
    python3 tag.py --emit-sql  questions/mcq_questions.json > ../db/seed/06_tags.sql
"""

import argparse
import json
import os
import re
import sys
import uuid
from collections import Counter, defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from topic_map import TOPICS, NOTE_COVERAGE

NS = uuid.UUID("6f4a1d3e-9b2c-4f18-a0d7-5c8e21b7a640")
NOTE_NS = uuid.UUID("2b9f7c14-6e83-4a55-9d21-70f4c8b5e0a3")
BATCH = "gce-pamphlet-2026"

COMPILED = {
    lesson: ([re.compile(p, re.I) for p in prim],
             [re.compile(p, re.I) for p in sup])
    for lesson, (prim, sup) in TOPICS.items()
}


def sql(v):
    if v is None:
        return "NULL"
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, int):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"


def question_id(stem, options):
    key = re.sub(r"[^a-z0-9]", "", stem.lower())
    key += "|" + "|".join(re.sub(r"[^a-z0-9]", "", v.lower())
                          for v in options.values())
    return str(uuid.uuid5(NS, key))


def tags_for(text):
    """Lessons a question touches, strongest first.

    Scored rather than first-match: a question about converting a hexadecimal
    number mentions both "hexadecimal" and "bit", and the encoding lesson
    should not win just because its rule was written earlier in the file.
    """
    scores = {}
    for lesson, (prim, sup) in COMPILED.items():
        hits = sum(1 for r in prim if r.search(text))
        soft = sum(1 for r in sup if r.search(text))
        if hits == 0 and soft == 0:
            continue
        # a primary term is worth far more than a supporting one, so a single
        # decisive word beats three vague ones
        scores[lesson] = hits * 10 + soft
    if not scores:
        return []
    ranked = sorted(scores.items(), key=lambda kv: -kv[1])
    best = ranked[0][1]
    # One supporting word is not evidence. ".pdf stands for" contains the word
    # "document" and nothing else, and tagging it to the word processor lesson
    # would put a wrong question behind a real revision topic. Better untagged.
    if best < 2:
        return []
    # Keep only tags that are close to the best. A question rarely tests four
    # lessons, and a long list is worse than none: it tells a revision report
    # nothing.
    out = [(l, s) for l, s in ranked if s >= max(best * 0.5, 10)][:3]
    if not out:
        out = ranked[:1]
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mcq")
    ap.add_argument("--form-level", default="Form 5")
    ap.add_argument("--validate", action="store_true")
    ap.add_argument("--emit-sql", action="store_true")
    args = ap.parse_args()

    questions = json.load(open(args.mcq, encoding="utf-8"))

    rows = []
    per_lesson = Counter()
    untagged = []
    for q in questions:
        stem = re.sub(r"\s+", " ", q["stem"]).strip()
        options = {k: v for k, v in q["options"].items() if v.strip()}
        if len(stem) < 15 or len(options) < 3:
            continue
        qid = question_id(stem, options)
        haystack = stem + " " + " ".join(options.values())
        tags = tags_for(haystack)
        if not tags:
            untagged.append((q["page"], stem[:70]))
            continue
        for i, (lesson, score) in enumerate(tags):
            rows.append((qid, lesson, i == 0))
            if i == 0:
                per_lesson[lesson] += 1

    # dedupe: the pamphlet repeats questions, and the same id twice would
    # violate the primary key
    seen = set()
    dedup = []
    for r in rows:
        if (r[0], r[1]) in seen:
            continue
        seen.add((r[0], r[1]))
        dedup.append(r)
    rows = dedup

    note_rows = []
    for chapter, covers in NOTE_COVERAGE.items():
        for lesson, coverage in covers:
            note_rows.append((chapter, lesson, coverage))

    if args.validate or not args.emit_sql:
        tagged = len({r[0] for r in rows})
        print(f"questions tagged : {tagged}")
        print(f"links            : {len(rows)}")
        print(f"untagged         : {len(untagged)}")
        print(f"lessons covered  : {len(per_lesson)} of {len(TOPICS)}")
        print(f"note links       : {len(note_rows)}")
        print("\nbusiest lessons (primary tag):")
        for lesson, n in per_lesson.most_common(12):
            print(f"  {n:4d}  {lesson}")
        empty = [l for l in TOPICS if per_lesson[l] == 0]
        if empty:
            print(f"\nno questions landed on {len(empty)} lessons:")
            for l in empty:
                print(f"  - {l}")
        if untagged:
            print(f"\nfirst few untagged:")
            for p, t in untagged[:8]:
                print(f"  p{p:<4} {t}")
        return

    out = []
    w = out.append
    w("BEGIN;")
    w("-- Links from questions and note chapters to the lessons they belong to.")
    w("-- Generated by tools/tag.py. Run after 04_past_questions.sql and")
    w("-- 05_notes.sql.")
    w("--")
    w("-- Lessons are matched by title, not by id: load_curriculum.py generates")
    w("-- fresh ids on every run, so a hardcoded id is wrong on any database but")
    w("-- the one it came from.")
    w("--")
    w("-- These tags are a starting point. A teacher moving one is the system")
    w("-- working, not failing.")
    w("")
    w("DO $$")
    w("BEGIN")
    w("  IF NOT EXISTS (SELECT 1 FROM note_sections WHERE deleted_at IS NULL) THEN")
    w("    RAISE EXCEPTION 'Run db/seed/05_notes.sql before this.';")
    w("  END IF;")
    w("END $$;")
    w("")

    w("-- --------------------------------------------------------------------")
    w(f"-- {len(rows)} question links")
    w("-- --------------------------------------------------------------------")
    w("INSERT INTO question_lessons (question_id, lesson_id, is_primary)")
    w("SELECT v.qid::uuid, l.id, v.primary_tag::boolean")
    w("FROM (VALUES")
    w(",\n".join(f"  ({sql(qid)}, {sql(lesson)}, {sql(prim)})"
                 for qid, lesson, prim in rows))
    w(") AS v(qid, lesson_title, primary_tag)")
    w("JOIN questions q ON q.id = v.qid::uuid AND q.deleted_at IS NULL")
    w("JOIN lessons  l ON l.title = v.lesson_title")
    w("               AND l.syllabus_id = q.syllabus_id")
    w("               AND l.deleted_at IS NULL")
    # A teacher may already have tagged some of these by hand; theirs wins.
    w("ON CONFLICT (question_id, lesson_id) DO NOTHING;")
    w("")

    w("-- --------------------------------------------------------------------")
    w(f"-- {len(note_rows)} note chapter links")
    w("-- --------------------------------------------------------------------")
    w("INSERT INTO lesson_note_sections (lesson_id, note_section_id, coverage)")
    w("SELECT l.id, s.id, v.coverage")
    w("FROM (VALUES")
    w(",\n".join(f"  ({sql(ch)}, {sql(lesson)}, {sql(cov)})"
                 for ch, lesson, cov in note_rows))
    w(") AS v(chapter_title, lesson_title, coverage)")
    w("JOIN note_sections s ON s.title = v.chapter_title AND s.deleted_at IS NULL")
    w("JOIN lessons l ON l.title = v.lesson_title AND l.deleted_at IS NULL")
    w("ON CONFLICT (lesson_id, note_section_id) DO NOTHING;")
    w("")
    w("COMMIT;")
    w("")
    w("-- Lessons with the most questions behind them, and how many are still")
    w("-- waiting on a teacher.")
    w("SELECT l.title,")
    w("       count(*) FILTER (WHERE ql.is_primary) AS questions,")
    w("       count(*) FILTER (WHERE q.needs_review) AS unchecked")
    w("FROM question_lessons ql")
    w("JOIN lessons l ON l.id = ql.lesson_id")
    w("JOIN questions q ON q.id = ql.question_id AND q.deleted_at IS NULL")
    w("GROUP BY l.title ORDER BY questions DESC LIMIT 20;")

    print("\n".join(out))


if __name__ == "__main__":
    main()
