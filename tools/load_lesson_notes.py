#!/usr/bin/env python3
"""
Load the written lesson notes from the earlier static platform.

These are the notes a teacher wrote: headings, definition boxes, bullet lists,
a page you can actually read. The chapters extracted from the PDF booklets are
the booklets — every diagram intact, and the prose of a scanned textbook run
through a column detector, which is to say long and heavy.

Both belong in the app, for different jobs. The written notes are for reading;
the booklet chapters are the reference, and hold the figures. So they load as
two sources, and the written ones are shown first.

The HTML is kept rather than converted to markdown. It is already clean,
semantic and hand-made — <h3>, <ul>, <strong>, and a def-box for definitions —
and round-tripping it through markdown would lose the definition boxes for
nothing.

Usage
    python3 load_lesson_notes.py --emit-sql topics_M1_TOPICS.json ... \
        > ../db/seed/08_lesson_notes.sql
"""

import argparse
import glob
import html
import json
import re
import sys
import uuid

NS = uuid.UUID("8d3c6f11-42b7-4e58-9c04-7fa1b2e35d69")
SOURCE_TITLE = "Form 5 Computer Science — lesson notes"
ATTRIBUTION = "Mr Ngwana Joshua, GHS Mbonjo Limbe"

# Which Form 5 lesson each chapter is the reading for.
COVERAGE = {
    "Information System (IS)": [
        ("Information systems", "full"),
        ("Notions on organizations and information", "full"),
        ("Types of information system", "full"),
    ],
    "Modelling and Simulation": [("Types of information system", "background")],
    "Monitoring and Control Systems": [("Types of information system", "partial")],
    "System Development Life Cycle (SDLC)": [
        ("Stages of SDLC: investigation, analysis, design", "full"),
        ("Stages of SDLC: development, testing, implementation, maintenance", "full"),
        ("Implementation strategies", "full"),
    ],
    "Data Capture and Outsourcing": [
        ("Data capture methods", "full"),
        ("Data verification and validation", "partial"),
    ],
    "Database and Data Resource Management": [
        ("Introduction to databases", "full"),
        ("Relational database design", "full"),
        ("Normalization and Relational models", "partial"),
    ],
    "Project Management": [
        ("Introduction to project management", "full"),
        ("Project management tools", "full"),
        ("Project management concepts and metrics 1", "full"),
    ],
    "Careers in IT and Computer Applications": [
        ("Types of application software", "partial"),
    ],
    "Computer Ergonomics and Health Hazards": [
        ("Assistive technology and disabilities", "full"),
    ],
    "Computer Ethics and Legislation": [
        ("Protecting Intellectual property", "full"),
        ("Assigning and respecting digital licenses", "full"),
    ],
    "Social and Economic Impacts of Computers": [
        ("Notions on digital identities and digital footprints", "partial"),
        ("Notions on social networks", "partial"),
    ],
    "Algorithms and Problem Solving": [
        ("Algorithms to solve common problems 1", "full"),
        ("Algorithms to solve common problems 2", "full"),
        ("Algorithm correctness and efficiency", "full"),
    ],
    "Programming Languages and Paradigms": [
        ("Notions on programming paradigms", "full"),
        ("Coding 1", "full"),
    ],
    "Data Structures": [
        ("Data structures", "full"),
        ("Simple data types", "full"),
    ],
    "Computer Hardware – Peripherals and Components": [
        ("Input and output peripherals", "full"),
        ("Storage and processing devices", "full"),
        ("Other internal components", "full"),
    ],
    "Data Communication and Computer Networks": [
        ("Network hardware", "full"),
        ("Notions on packets", "full"),
        ("Notions on the internet", "partial"),
    ],
    "Logic Gates and Boolean Algebra": [
        ("Logic gates", "full"),
        ("Logic circuits and expressions", "full"),
        ("De Morgan's law and Boolean simplification", "full"),
    ],
    "Number Systems": [
        ("Notions on data encoding", "full"),
        ("Character and positive integers encoding", "full"),
        ("Addition and subtraction in base 2, 8 and 16", "full"),
    ],
    "Web Authoring – HTML": [("Web authoring services", "full")],
}


def q(v):
    if v is None or v == "":
        return "NULL"
    if isinstance(v, int):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"


def clean_html(s):
    """Keep the structure, drop the platform's own chrome.

    The content is already good HTML. The only things removed are the
    top-level <h1>, which duplicates the chapter title the page prints anyway,
    and any inline handler or style attribute, which has no business coming
    out of a database and into a page.
    """
    s = s or ""
    s = re.sub(r"<h1\b[^>]*>.*?</h1>\s*", "", s, flags=re.S | re.I)
    s = re.sub(r"\son\w+\s*=\s*\"[^\"]*\"", "", s, flags=re.I)
    s = re.sub(r"\son\w+\s*=\s*'[^']*'", "", s, flags=re.I)
    s = re.sub(r"<script\b.*?</script>", "", s, flags=re.S | re.I)
    return s.strip()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("files", nargs="+")
    ap.add_argument("--emit-sql", action="store_true")
    a = ap.parse_args()

    topics = []
    for pattern in a.files:
        for path in sorted(glob.glob(pattern)):
            topics.extend(json.load(open(path, encoding="utf-8")))

    src_id = str(uuid.uuid5(NS, "source:" + SOURCE_TITLE))
    rows, links = [], []
    for i, t in enumerate(topics, 1):
        title = t.get("title", "").strip()
        body = clean_html(t.get("content"))
        if not title or len(body) < 200:
            continue
        sid = str(uuid.uuid5(NS, "section:" + title))
        rows.append({
            "id": sid,
            "chapter_number": str(t.get("num") or "").replace("Chapter", "").strip(" :"),
            "title": title,
            "body": body,
            "sequence": i,
        })
        for lesson, coverage in COVERAGE.get(title, []):
            links.append((sid, lesson, coverage))

    if not a.emit_sql:
        print(f"chapters : {len(rows)}")
        print(f"characters: {sum(len(r['body']) for r in rows)}")
        print(f"lesson links: {len(links)}")
        missing = [r["title"] for r in rows if r["title"] not in COVERAGE]
        print(f"chapters with no lesson mapping: {missing or 'none'}")
        return

    o = []
    w = o.append
    w("BEGIN;")
    w("-- The written lesson notes from the earlier static platform.")
    w("-- Generated by tools/load_lesson_notes.py.")
    w("--")
    w("-- These are notes a teacher wrote: headings, definitions, bullet lists.")
    w("-- The chapters extracted from the PDF booklets stay alongside them as the")
    w("-- reference copy, because those hold the diagrams. Two sources, two jobs.")
    w("--")
    w("-- Bodies here are HTML, not markdown. The source is already clean")
    w("-- semantic markup and converting it would lose the definition boxes.")
    w("")
    w("ALTER TABLE note_sections")
    w("  ADD COLUMN IF NOT EXISTS body_format TEXT NOT NULL DEFAULT 'markdown';")
    w("ALTER TABLE note_sections DROP CONSTRAINT IF EXISTS note_sections_format_check;")
    w("ALTER TABLE note_sections")
    w("  ADD CONSTRAINT note_sections_format_check")
    w("  CHECK (body_format IN ('markdown', 'html'));")
    w("")
    w("ALTER TABLE note_sources")
    w("  ADD COLUMN IF NOT EXISTS sequence INTEGER NOT NULL DEFAULT 100;")
    w("")
    w("INSERT INTO note_sources (id, title, attribution, sequence) VALUES")
    w(f"  ({q(src_id)}, {q(SOURCE_TITLE)}, {q(ATTRIBUTION)}, 1)")
    w("ON CONFLICT (id) DO UPDATE SET")
    w("  title = EXCLUDED.title, attribution = EXCLUDED.attribution,")
    w("  sequence = EXCLUDED.sequence, updated_at = now();")
    w("")
    w("-- The booklet chapters sort after the written notes.")
    w("UPDATE note_sources SET sequence = 2 WHERE id <> " + q(src_id) + ";")
    w("")
    w(f"-- {len(rows)} chapters")
    w("INSERT INTO note_sections")
    w("  (id, note_source_id, chapter_number, title, body, body_format, sequence)")
    w("VALUES")
    w(",\n".join(
        "  (" + ", ".join([q(r["id"]), q(src_id), q(r["chapter_number"]),
                           q(r["title"]), q(r["body"]), q("html"),
                           q(r["sequence"])]) + ")"
        for r in rows))
    w("ON CONFLICT (id) DO UPDATE SET")
    w("  title = EXCLUDED.title, body = EXCLUDED.body,")
    w("  body_format = EXCLUDED.body_format,")
    w("  chapter_number = EXCLUDED.chapter_number,")
    w("  sequence = EXCLUDED.sequence, updated_at = now();")
    w("")
    if links:
        w(f"-- {len(links)} links to the lessons they are the reading for")
        w("INSERT INTO lesson_note_sections (lesson_id, note_section_id, coverage)")
        w("SELECT l.id, v.sid::uuid, v.coverage")
        w("FROM (VALUES")
        w(",\n".join(f"  ({q(s)}, {q(l)}, {q(c)})" for s, l, c in links))
        w(") AS v(sid, lesson_title, coverage)")
        w("JOIN lessons l ON l.title = v.lesson_title AND l.deleted_at IS NULL")
        w("ON CONFLICT (lesson_id, note_section_id) DO NOTHING;")
        w("")
    # student_notes returns a fixed set of columns, so adding body_format to
    # the table is not enough; the function has to hand it over too, and it
    # gains a return column, which means dropping rather than replacing.
    w("DROP FUNCTION IF EXISTS public.student_notes();")
    w("CREATE FUNCTION public.student_notes()")
    w("RETURNS TABLE (id UUID, chapter_number TEXT, title TEXT, body TEXT,")
    w("               body_format TEXT, source_title TEXT, source_sequence INT,")
    w("               page_from INT, page_to INT)")
    w("LANGUAGE sql SECURITY DEFINER SET search_path = public")
    w("AS $fn$")
    w("  SELECT s.id, s.chapter_number, s.title, s.body, s.body_format,")
    w("         src.title, src.sequence, s.page_from, s.page_to")
    w("  FROM note_sections s")
    w("  JOIN note_sources src ON src.id = s.note_source_id")
    w("  WHERE s.deleted_at IS NULL")
    w("  -- Written notes first, booklet chapters after: a student opening")
    w("  -- Notes should land on the readable version, not the scan.")
    w("  ORDER BY src.sequence, s.sequence;")
    w("$fn$;")
    w("REVOKE ALL ON FUNCTION public.student_notes() FROM public;")
    w("GRANT EXECUTE ON FUNCTION public.student_notes() TO anon, authenticated;")
    w("")
    w("COMMIT;")
    w("")
    w("SELECT src.title AS source, count(*) AS chapters")
    w("FROM note_sections s JOIN note_sources src ON src.id = s.note_source_id")
    w("WHERE s.deleted_at IS NULL GROUP BY src.title ORDER BY src.title;")
    print("\n".join(o))


if __name__ == "__main__":
    main()
