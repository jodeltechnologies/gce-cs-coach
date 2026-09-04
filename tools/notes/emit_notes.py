# -*- coding: utf-8 -*-
"""Turn the student notes into SQL for the app.

One note_section per lesson, attached to the matching lesson by title so that
the note shows on the progression sheet and in the student Notes list.

Two sources are used, one for each form level, because note_sources.syllabus_id
is what scopes a note to a class. Both are given fixed ids so that running this
twice updates the same rows rather than making a second copy.

Figures are PNG files under public/notes/figures, referenced by path. They are
drawn by tools/figures.py and have to be uploaded with the SQL.
"""
import re
import uuid

import student_notes
from figures import DIAGRAMS

NS = uuid.UUID("7df11f03-a526-56c6-abb9-562db2871de7")

# Their own sources, not the ones already in the database.
#
# The first version of this file reused the existing Lower Sixth source id.
# That put the new notes in with the old ones, which was harmless until the
# source was staged for release: staging it would have hidden all seventy-one
# notes students were already reading. Separate sources keep the two sets
# independent, and let the old ones stay open while the new ones are released
# week by week.
SOURCES = {
    "Form 5": dict(
        id="947e8ce4-cb63-5847-98b1-d4cc5cf2f67f",
        title="Form 5 Computer Science, First Term 2026/2027",
        attribution="One note per lesson, written for the 2026/2027 "
                    "progression sheet",
        form_level="Form 5", sequence=1),
    "Lower Sixth": dict(
        id="394dbea1-e9d4-5da2-b9db-e2fe1953c8ec",
        title="Lower Sixth ICT, First Term 2026/2027",
        attribution="One note per lesson, written for the 2026/2027 "
                    "progression sheet",
        form_level="Lower Sixth", sequence=1),
}


def q(v):
    if v is None:
        return "NULL"
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, int):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"


def head(note):
    """The content points from the sheet, printed at the top of the note."""
    items = "".join(f"<li>{c}</li>" for c in note["covers"])
    return (f'<div class="objectives"><h3>This lesson covers</h3>'
            f'<ul>{items}</ul></div>')


def check_figures(notes):
    """Every figure named in a note must actually have been drawn."""
    missing = []
    for n in notes:
        for name in re.findall(r'/notes/figures/([a-z0-9_]+)\.png', n["html"]):
            if name not in DIAGRAMS:
                missing.append((n["title"], name))
    return missing


def emit(notes, path):
    out = []
    W = out.append

    W("-- Student lesson notes for the 2026/2027 progression sheets, First Term.")
    W("--")
    W("-- One note for each lesson that had none. Written to be read by the")
    W("-- learner rather than by the teacher, so there is nothing here about")
    W("-- examiners or marks. A note that spends its last paragraph coaching a")
    W("-- candidate teaches the reader that the topic is worth guessing at")
    W("-- rather than worth knowing.")
    W("--")
    W("-- Bodies are HTML. Figures are PNG files under public/notes/figures and")
    W("-- must be uploaded alongside this file, or the pictures will not load.")
    W("--")
    W("-- Ids are fixed, so running this a second time updates the same rows.")
    W("")
    W("BEGIN;")
    W("")
    W("ALTER TABLE note_sections")
    W("  ADD COLUMN IF NOT EXISTS body_format TEXT NOT NULL DEFAULT 'markdown';")
    W("ALTER TABLE note_sources")
    W("  ADD COLUMN IF NOT EXISTS sequence INTEGER NOT NULL DEFAULT 100,")
    W("  ADD COLUMN IF NOT EXISTS syllabus_id UUID REFERENCES syllabi(id);")
    W("")

    for form, src in SOURCES.items():
        W(f"-- {src['title']}")
        W("INSERT INTO note_sources (id, title, attribution, sequence) VALUES")
        W(f"  ({q(src['id'])}, {q(src['title'])}, {q(src['attribution'])}, "
          f"{q(src['sequence'])})")
        W("ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,")
        W("  attribution = EXCLUDED.attribution, sequence = EXCLUDED.sequence,")
        W("  deleted_at = NULL, updated_at = now();")
        W("")
        W("UPDATE note_sources SET syllabus_id = (")
        W(f"  SELECT id FROM syllabi WHERE form_level = {q(src['form_level'])}")
        W("    AND deleted_at IS NULL ORDER BY created_at LIMIT 1)")
        W(f"WHERE id = {q(src['id'])};")
        W("")

    seq = {"Form 5": 0, "Lower Sixth": 0}
    for n in notes:
        src = SOURCES[n["form"]]
        seq[n["form"]] += 1
        sid = str(uuid.uuid5(NS, f"{src['id']}/{n['form']}/{n['no']}/{n['title']}"))
        body = head(n) + "\n" + n["html"]
        W(f"-- {n['form']} lesson {n['no']}: {n['title']}")
        W("INSERT INTO note_sections (id, note_source_id, chapter_number, title,")
        W("                           body, body_format, sequence) VALUES")
        W(f"  ({q(sid)}, {q(src['id'])}, {q('Lesson ' + str(n['no']))},")
        W(f"   {q(n['title'])},")
        W(f"   {q(body)},")
        W(f"   'html', {q(seq[n['form']])})")
        W("ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,")
        W("  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,")
        W("  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,")
        W("  deleted_at = NULL, updated_at = now();")
        W("")

    W("-- Attach each note to the lesson of the same name, so it appears on the")
    W("-- progression sheet and in the reader. Rebuilt from the sheet each time")
    W("-- rather than stored by hand.")
    W("INSERT INTO lesson_note_sections (lesson_id, note_section_id, coverage)")
    W("SELECT l.id, s.id, 'full'")
    W("  FROM note_sections s")
    W("  JOIN note_sources src ON src.id = s.note_source_id")
    W("  JOIN lessons l")
    W("    ON l.syllabus_id = src.syllabus_id")
    W("   AND lower(regexp_replace(l.title, '[^a-zA-Z0-9]', '', 'g'))")
    W("     = lower(regexp_replace(s.title, '[^a-zA-Z0-9]', '', 'g'))")
    W(f" WHERE src.id IN ({', '.join(q(s['id']) for s in SOURCES.values())})")
    W("   AND s.deleted_at IS NULL AND l.deleted_at IS NULL")
    W("ON CONFLICT (lesson_id, note_section_id) DO NOTHING;")
    W("")
    W("COMMIT;")
    W("")
    W("-- What happened. Read every row.")
    W("SELECT 'notes loaded' AS item, count(*)::text AS value")
    W("  FROM note_sections s JOIN note_sources src ON src.id = s.note_source_id")
    W(f" WHERE src.id IN ({', '.join(q(s['id']) for s in SOURCES.values())})")
    W("   AND s.deleted_at IS NULL")
    W("UNION ALL SELECT 'attached to a lesson', count(*)::text")
    W("  FROM lesson_note_sections lns")
    W("  JOIN note_sections s ON s.id = lns.note_section_id")
    W("  JOIN note_sources src ON src.id = s.note_source_id")
    W(f" WHERE src.id IN ({', '.join(q(s['id']) for s in SOURCES.values())})")
    W("UNION ALL SELECT 'not matched to any lesson', count(*)::text")
    W("  FROM note_sections s JOIN note_sources src ON src.id = s.note_source_id")
    W(f" WHERE src.id IN ({', '.join(q(s['id']) for s in SOURCES.values())})")
    W("   AND s.deleted_at IS NULL")
    W("   AND NOT EXISTS (SELECT 1 FROM lesson_note_sections x")
    W("                    WHERE x.note_section_id = s.id);")

    open(path, "w").write("\n".join(out) + "\n")
    return len(notes)


if __name__ == "__main__":
    import sys
    notes = student_notes.NOTES
    missing = check_figures(notes)
    if missing:
        for t, f in missing:
            print(f"missing figure {f} in {t}")
        sys.exit(1)
    n = emit(notes, sys.argv[1])
    used = {f for x in notes
            for f in re.findall(r'/notes/figures/([a-z0-9_]+)\.png', x["html"])}
    print(f"{n} notes written, {len(used)} figures referenced, "
          f"{len(DIAGRAMS) - len(used)} drawn but unused")
