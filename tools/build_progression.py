"""Build the progression-sheet YAML and the replacement SQL from the Ministry PDFs.

    python3 tools/build_progression.py .          # writes both YAML and both SQL
    python3 tools/load_curriculum.py --validate tools/curriculum/*.yaml

Reads the two 2026/2027 PDFs, transcribes them, and writes:

    tools/curriculum/form5_computer_science.yaml
    tools/curriculum/lower_sixth_ict.yaml
    db/seed/02_form5_computer_science.sql
    db/seed/03_lower_sixth_ict.sql

Do not hand-edit the four generated files; edit this one and re-run, so that
the sheet in the database and the sheet in the PDF cannot drift apart.

Every change made to the Ministry's own text is declared in CAT_FIX or
MODULE_FIX below and printed on every run. Nothing is corrected silently.

Requires: pdfplumber, pyyaml. Set SHEET_DIR to wherever the PDFs are.
"""
import os
SHEET_DIR = os.environ.get("SHEET_DIR", ".")

import json, re, collections, sys
from extract_progression import read

# --------------------------------------------------------------------------
# Corrections. Left side is what the sheet prints, right side what we load.
# Almost all are the PDF breaking a word across a line inside a table cell.
# --------------------------------------------------------------------------
CAT_FIX = {
    "Designing and implementi ng simple databases": "Designing and implementing simple databases",
    "Representin g data in the computer": "Representing data in the computer",
    "Exploring the concepts related to data communicat ion": "Exploring the concepts related to data communication",
    "Describing internal component s of the computer": "Describing internal components of the computer",
    "Securing data, computers, and networks.": "Securing data, computers, and networks",
    "Creating digital content using a software": "Creating digital content using a software",
}
MODULE_FIX = {
    # The sheet prints "digital word"; plainly "digital world".
    "Practical Problem solving in the digital word": "Practical Problem solving in the digital world",
}
# Where a category sits under a module band whose rotated label starts lower
# down the page than the category does, the forward-fill picks up the previous
# band. These two are corrected against the printed module headings.
F5_MODULE_OVERRIDE = {
    "Securing data, computers, and networks": "System Security",
    "Analysing simple logic circuits and logic expressions": "Data Manipulation 2",
}

CORRECTIONS = []

def note(msg):
    CORRECTIONS.append(msg)

def clean_cat(c):
    c = re.sub(r"\s+", " ", c).strip()
    # Rotated module glyphs sometimes bleed into the category cell.
    c = re.sub(r"(?:\s+[a-z]{1,2}){2,6}$", "", c).strip()
    if c in CAT_FIX and CAT_FIX[c] != c:
        note(f"category printed as {c!r}, loaded as {CAT_FIX[c]!r}")
        return CAT_FIX[c]
    return CAT_FIX.get(c, c)

def bullets(text):
    if not text or not text.strip(): return []
    parts, cur = [], []
    for line in text.replace("\u2022", "\n\u2022").split("\n"):
        line = line.strip()
        if not line: continue
        if line.startswith("\u2022"):
            if cur: parts.append(" ".join(cur))
            cur = [line.lstrip("\u2022 ").strip()]
        else:
            cur.append(line)
    if cur: parts.append(" ".join(cur))
    out = []
    for p in parts:
        p = re.sub(r"\s+", " ", p).strip()
        p = re.sub(r"\s+([,.;:])", r"\1", p)
        if p and p[-1] not in ".!?\u2026": p += "."
        if p: out.append(p)
    return out

MODULES = {
    "form5": ["Network Systems 2", "Hardware and Software Systems 3",
              "Problem Solving and Coding 3", "Data Manipulation",
              "Data Manipulation 2", "System Security",
              "Ethics, Society and Legal Issues 3"],
    "l6": ["Computing Systems and Components",
           "Impacting society with digital technologies",
           "Practical Problem solving in the digital world",
           "Building ICT systems"],
}

def sig(s): return sorted(re.sub(r"[^A-Za-z0-9]", "", s).lower())

def make_module_of(names):
    sigs = [(sig(n), n) for n in names]
    def module_of(raw):
        if not raw or not raw.strip(): return None
        got = sig(raw)
        for sg, n in sigs:
            if sg == got: return n
        need = collections.Counter(got)
        best = None
        for sg, n in sigs:
            have = collections.Counter(sg)
            if all(have[c] >= k for c, k in need.items()):
                if best is None or len(sg) < len(sig(best)): best = n
        return best
    return module_of

HEAD = (r"(?i)^(lesson\s*\d|diagnostic|evaluation|remediation|"
        r"integration activit|revision|end of program)")

def parse(path, layout):
    module_of = make_module_of(MODULES[layout])
    rows = read(path, layout)

    merged, week, cat, stmt, mod = [], None, None, None, None
    for r in rows:
        if r["week"]: week = int(r["week"])
        if r["cat"]:
            cat = clean_cat(r["cat"])
            stmt = re.sub(r"\s+", " ", r["stmt"]).strip() or None
        if r["module"]:
            m = module_of(r["module"])
            if m:
                if m in MODULE_FIX:
                    note(f"module printed as {m!r}, loaded as {MODULE_FIX[m]!r}")
                    m = MODULE_FIX[m]
                mod = m
        title = re.sub(r"\s+", " ", r["title"].replace("\n", " ")).strip()
        if not title and not r["obj"].strip(): continue
        if (not title or not re.match(HEAD, title)) and merged:
            if title: merged[-1]["title"] += " " + title
            merged[-1]["obj_raw"] += "\n" + r["obj"]
            continue
        merged.append(dict(week=week, cat=cat, stmt=stmt, module=mod,
                           title=title, obj_raw=r["obj"],
                           nature=[k for k in ("th", "prac", "dig") if r[k]]))

    # A single cell can hold "Diagnostic Evaluation" and "Lesson 1: ..." , or
    # "Remediation No 6" and the REVISION banner. Split those apart.
    split = []
    for m in merged:
        t = m["title"]
        d = re.match(r"(?i)^(diagnostic evaluations?)\s*(.*)$", t)
        if d:
            split.append({**m, "title": "Diagnostic evaluation", "obj_raw": "",
                          "kind": "diagnostic_evaluation", "no": None})
            t = d.group(2).strip()
            if not t: continue
            m = {**m, "title": t}
        # "END OF PROGRAM" is a closing banner printed across the last cells,
        # not a row of the sheet. It lands in whatever cell it overlaps.
        t = re.sub(r"(?i)\s*(RE\s*)?END\s*OF(\s*PROGRAM)?\.?\s*$", "", t).strip()
        split.append({**m, "title": t})

    out = []
    for m in split:
        if "kind" in m: out.append(m); continue
        t = m["title"]
        n = re.match(r"(?i)^lesson\s*(\d+)\s*:?\s*(.*)$", t)
        if n:
            title = n.group(2).strip()
            kind = "integration_activity" if title.lower().startswith("integration") else "content"
            out.append({**m, "no": int(n.group(1)), "title": title, "kind": kind})
        elif re.match(r"(?i)^integration activit", t):
            out.append({**m, "no": None, "title": t, "kind": "integration_activity", "cat": None})
        elif re.match(r"(?i)^evaluation", t):
            out.append({**m, "no": None, "title": t, "kind": "evaluation", "obj_raw": ""})
        elif re.match(r"(?i)^remediation", t):
            out.append({**m, "no": None, "title": t, "kind": "remediation"})
        elif re.match(r"(?i)^revision|^end of program", t):
            out.append({**m, "no": None, "title": t.title(), "kind": "revision"})
        else:
            out.append({**m, "no": None, "title": t, "kind": "content"})

    BANNER = re.compile(r"(?i)^(revision|end of program)\b")
    for m in out:
        obj = bullets(m.pop("obj_raw", ""))
        if m["kind"] in ("remediation", "evaluation", "revision"):
            obj = [o for o in obj if not BANNER.match(o)]
        m["objectives"] = obj
        if layout == "form5" and m["cat"] in F5_MODULE_OVERRIDE:
            want = F5_MODULE_OVERRIDE[m["cat"]]
            if m["module"] != want:
                m["module"] = want
    return out



import re, uuid, yaml, sys

SHEETS = {
    "form5": dict(
        pdf=os.path.join(SHEET_DIR, "2026-2027_National_progression_sheet_for_Fom_5.pdf"),
        # Reused, not regenerated: note_sources.syllabus_id and classes.syllabus_id
        # point here, and a new id would orphan every note and every class.
        syllabus_id="d280ec19-0e1f-436e-806e-f8c5fcdf9c6b",
        yaml_name="form5_computer_science",
        sql_name="02_form5_computer_science",
        syllabus=dict(
            title="National Harmonised Progression Sheet for Computer Science Form 5",
            subject="Computer Science", level="GCE Ordinary Level", level_short="O/L",
            form_level="Form 5",
            issuing_authority="Inspectorate General of Education, Inspectorate of Pedagogy in charge of the Teaching of Computer Science",
            scope="national", region=None,
            version_label="National Harmonised Progression 2026/2027",
            effective_from=2026, total_weeks=36,
            weekly_periods_theory=3, weekly_periods_practical=None,
            coefficient=None, module_label="Module",
            has_modules=True, uses_competencies=True,
            has_competency_statements=True, has_practical_stream=False),
        tail=[dict(title="Revision", kind="revision", week=35, week_to=36)],
    ),
    "l6": dict(
        pdf=os.path.join(SHEET_DIR, "2026-2027_ICT_Lower_Sixth_Progression_Sheet.pdf"),
        syllabus_id="b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c",
        yaml_name="lower_sixth_ict",
        sql_name="03_lower_sixth_ict",
        syllabus=dict(
            title="National Harmonised Lower Sixth Progression Sheet for Information & Communication Technology",
            subject="Information and Communication Technology",
            level="GCE Advanced Level", level_short="A/L",
            form_level="Lower Sixth",
            issuing_authority="Inspectorate General of Education, Inspectorate of Pedagogy in charge of the Teaching of Computer Science",
            scope="national", region=None,
            version_label="National Harmonised Progression 2026/2027",
            effective_from=2026, total_weeks=36,
            weekly_periods_theory=8, weekly_periods_practical=None,
            coefficient=None, module_label="Module",
            has_modules=True, uses_competencies=True,
            has_competency_statements=False, has_practical_stream=False),
        tail=[dict(title="Revision", kind="revision", week=32, week_to=36)],
    ),
}

BLOOM = {
    "remember": ["state", "list", "outline", "recall", "name", "recognise",
                 "recognize", "define", "give", "sketch"],
    "understand": ["explain", "describe", "differentiate", "distinguish",
                   "illustrate", "discuss", "summarise", "summarize", "review"],
    "apply": ["apply", "use", "make use", "perform", "convert", "install",
              "solve", "write", "produce", "draw", "calculate", "compute",
              "reproduce", "match", "represent", "enter", "modify", "edit",
              "insert", "format", "carry out", "derive", "simplify", "train",
              "transform", "reinforce", "support"],
    "analyse": ["analyse", "analyze", "identify", "classify", "compare",
                "deduce", "determine", "test", "trace", "examine", "categorise",
                "categorize", "verify", "associate", "relate", "break down"],
    "evaluate": ["evaluate", "choose", "select", "assess", "justify",
                 "establish", "propose", "appraise", "suggest"],
    "create": ["create", "design", "build", "develop", "combine", "construct",
               "generate", "formulate", "adapt", "refine", "model"],
}

def bloom(text):
    t = text.strip().lower()
    for level in ("create", "evaluate", "analyse", "apply", "understand", "remember"):
        for verb in BLOOM[level]:
            if t.startswith(verb + " ") or t.startswith(verb + "s "):
                return level
    return None

def term_of(week):
    return 1 if week <= 12 else 2 if week <= 24 else 3

def build(key):
    cfg = SHEETS[key]
    rows = parse(cfg["pdf"], key)

    modules, cats = [], []
    for r in rows:
        if r["module"] and r["module"] not in modules:
            modules.append(r["module"])
    for r in rows:
        if r["cat"] and not any(c["category"] == r["cat"] for c in cats):
            cats.append({"sequence": len(cats) + 1, "category": r["cat"],
                         "statement": r["stmt"], "module": r["module"]})

    lessons = []
    for r in rows:
        ls = {"title": r["title"], "kind": r["kind"],
              "term": term_of(r["week"]), "week": r["week"]}
        if r["no"] is not None:
            ls["lesson_no"] = r["no"]
        if r["module"]:
            ls["module"] = r["module"]
        if r["cat"]:
            ls["competency"] = r["cat"]
        nature = r.get("nature") or []
        ls["nature"] = nature if nature else ["th"]
        if r["objectives"]:
            ls["objectives"] = r["objectives"]
        lessons.append(ls)

    last = lessons[-1]
    for t in cfg["tail"]:
        lessons.append({"title": t["title"], "kind": t["kind"],
                        "term": term_of(t["week"]), "week": t["week"],
                        "week_to": t.get("week_to", t["week"]),
                        "module": last.get("module"), "nature": ["th"]})

    doc = {"syllabus": dict(cfg["syllabus"]),
           "modules": [{"title": m, "sequence": i} for i, m in enumerate(modules, 1)],
           "competencies": cats,
           "lessons": lessons}
    return doc


# ---------------------------------------------------------------------------
# SQL
# ---------------------------------------------------------------------------

def q(v):
    if v is None: return "NULL"
    if isinstance(v, bool): return "true" if v else "false"
    if isinstance(v, (int, float)): return str(v)
    return "'" + str(v).replace("'", "''") + "'"

def emit_sql(key, doc):
    cfg = SHEETS[key]
    sid = cfg["syllabus_id"]
    syl = doc["syllabus"]
    o = []
    W = o.append

    def uid(kind, name):
        return str(uuid.uuid5(uuid.NAMESPACE_URL, f"{sid}/{kind}/{name}"))

    ids = {}
    for m in doc["modules"]:
        ids[("m", m["title"])] = uid("module", m["title"])
    for c in doc["competencies"]:
        ids[("c", c["category"])] = uid("comp", c["category"])
    lesson_ids = []
    for seq, ls in enumerate(doc["lessons"], 1):
        lesson_ids.append(uid("lesson", f"{seq}/{ls['title']}"))

    W(f"-- {syl['title']}")
    W("--")
    W("-- The 2026/2027 national sheet. It replaces the sheet previously loaded")
    W("-- for this form level, IN PLACE.")
    W("--")
    W("-- The syllabus row keeps its id. note_sources.syllabus_id and")
    W("-- classes.syllabus_id both point at it, so a new id would cut every")
    W("-- student off from their notes and every class from its sheet.")
    W("--")
    W("-- Nothing is deleted. Seven tables hang off lessons(id): objectives,")
    W("-- lesson_note_sections, lesson_resources (the uploaded handouts),")
    W("-- question_lessons (question tagging), lesson_mastery (student progress),")
    W("-- scheme_entries and assessments. Five would cascade and two would refuse")
    W("-- the delete outright. So old rows are archived instead, and every")
    W("-- attachment is carried across to the new row of the same name.")
    W("--")
    W("-- Ids are derived from the sheet, so running this twice changes nothing.")
    W("")
    W("BEGIN;")
    W("")
    W("-- Both 2026/2027 sheets close with a Revision block. 'revision' is a new")
    W("-- lesson kind; without this the inserts below fail the check constraint.")
    W("ALTER TABLE lessons DROP CONSTRAINT IF EXISTS lessons_lesson_kind_check;")
    W("ALTER TABLE lessons ADD CONSTRAINT lessons_lesson_kind_check CHECK (")
    W("  lesson_kind IN ('content','diagnostic_evaluation','integration_activity',")
    W("                  'evaluation','remediation','practical','revision'));")
    W("")
    W("-- ------------------------------------------------------------------")
    W("-- 1. What this sheet is going to consist of.")
    W("-- ------------------------------------------------------------------")
    W("")
    W("DROP TABLE IF EXISTS new_lesson_ids;")
    W("CREATE TEMP TABLE new_lesson_ids (id UUID PRIMARY KEY);")
    W("INSERT INTO new_lesson_ids (id) VALUES")
    W(",\n".join(f"  ({q(i)})" for i in lesson_ids) + ";")
    W("")
    W("DROP TABLE IF EXISTS new_comp_ids;")
    W("CREATE TEMP TABLE new_comp_ids (id UUID PRIMARY KEY);")
    W("INSERT INTO new_comp_ids (id) VALUES")
    W(",\n".join(f"  ({q(ids[('c', c['category'])])})" for c in doc["competencies"]) + ";")
    W("")
    W("DROP TABLE IF EXISTS new_module_ids;")
    W("CREATE TEMP TABLE new_module_ids (id UUID PRIMARY KEY);")
    W("INSERT INTO new_module_ids (id) VALUES")
    W(",\n".join(f"  ({q(ids[('m', m['title'])])})" for m in doc["modules"]) + ";")
    W("")
    W("-- The outgoing sheet, captured before anything moves. On a second run")
    W("-- this comes back empty, which is what makes the re-run a no-op.")
    W("DROP TABLE IF EXISTS old_lessons;")
    W("CREATE TEMP TABLE old_lessons AS")
    W("SELECT id, title, status, content FROM lessons")
    W(f" WHERE syllabus_id = {q(sid)} AND deleted_at IS NULL")
    W("   AND id NOT IN (SELECT id FROM new_lesson_ids);")
    W("")
    W("-- Exam frequency is the teacher's judgement, not the Ministry's, and it")
    W("-- is keyed by the name of the category of action rather than by id.")
    W("DROP TABLE IF EXISTS old_freq;")
    W("CREATE TEMP TABLE old_freq AS")
    W("SELECT category_of_action, exam_frequency, continues_from_id, link_confirmed")
    W(f"  FROM competencies WHERE syllabus_id = {q(sid)} AND exam_frequency IS NOT NULL;")
    W("")
    W("-- ------------------------------------------------------------------")
    W("-- 2. The sheet header")
    W("-- ------------------------------------------------------------------")
    W("")
    W(f"INSERT INTO subjects (name) VALUES ({q(syl['subject'])}) ON CONFLICT (name) DO NOTHING;")
    W(f"INSERT INTO levels (name, short_name) VALUES ({q(syl['level'])}, {q(syl['level_short'])}) ON CONFLICT (name) DO NOTHING;")
    W("")
    W("UPDATE syllabi SET")
    W(f"  subject_id = (SELECT id FROM subjects WHERE name = {q(syl['subject'])}),")
    W(f"  level_id   = (SELECT id FROM levels   WHERE name = {q(syl['level'])}),")
    W(f"  title = {q(syl['title'])},")
    W(f"  form_level = {q(syl['form_level'])},")
    W(f"  issuing_authority = {q(syl['issuing_authority'])},")
    W(f"  scope = {q(syl['scope'])}, region = {q(syl['region'])},")
    W(f"  version_label = {q(syl['version_label'])},")
    W(f"  effective_from = {q(syl['effective_from'])},")
    W(f"  total_weeks = {q(syl['total_weeks'])},")
    W(f"  weekly_periods_theory = {q(syl['weekly_periods_theory'])},")
    W(f"  weekly_periods_practical = {q(syl['weekly_periods_practical'])},")
    W(f"  coefficient = {q(syl['coefficient'])},")
    W(f"  module_label = {q(syl['module_label'])},")
    W(f"  has_modules = {q(syl['has_modules'])},")
    W(f"  uses_competencies = {q(syl['uses_competencies'])},")
    W(f"  has_competency_statements = {q(syl['has_competency_statements'])},")
    W(f"  has_practical_stream = {q(syl['has_practical_stream'])},")
    W("  updated_at = now()")
    W(f"WHERE id = {q(sid)};")
    W("")
    W("-- ------------------------------------------------------------------")
    W("-- 3. Archive the outgoing rows.")
    W("--")
    W("-- The sequence has to move because of UNIQUE (syllabus_id, sequence),")
    W("-- which a soft delete does not exempt a row from. Offsetting past the")
    W("-- current maximum leaves room for this to be run again.")
    W("-- ------------------------------------------------------------------")
    W("")
    for tbl, tmp in (("lessons", "new_lesson_ids"), ("competencies", "new_comp_ids"),
                     ("modules", "new_module_ids")):
        extra = ", status = 'archived'" if tbl == "lessons" else ""
        W(f"UPDATE {tbl} SET deleted_at = now(){extra},")
        W(f"  sequence = sequence + 1000 + (SELECT coalesce(max(sequence), 0)")
        W(f"                                  FROM {tbl} WHERE syllabus_id = {q(sid)})")
        W(f" WHERE syllabus_id = {q(sid)} AND deleted_at IS NULL")
        W(f"   AND id NOT IN (SELECT id FROM {tmp});")
        W("")
    W("-- ------------------------------------------------------------------")
    W("-- 4. The new sheet")
    W("-- ------------------------------------------------------------------")
    W("")
    for m in doc["modules"]:
        W(f"INSERT INTO modules (id, syllabus_id, title, sequence) VALUES "
          f"({q(ids[('m', m['title'])])}, {q(sid)}, {q(m['title'])}, {q(m['sequence'])})")
        W("ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, "
          "sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();")
    W("")
    for c in doc["competencies"]:
        stmt = " ".join(c["statement"].split()) if c.get("statement") else None
        W(f"INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, "
          f"competency_statement, sequence) VALUES ({q(ids[('c', c['category'])])}, "
          f"{q(sid)}, {q(ids.get(('m', c.get('module'))))}, {q(c['category'])}, "
          f"{q(stmt)}, {q(c['sequence'])})")
        W("ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, "
          "category_of_action = EXCLUDED.category_of_action, competency_statement = "
          "EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, "
          "deleted_at = NULL, updated_at = now();")
    W("")
    W("-- Objectives are rebuilt wholesale rather than matched: they are the")
    W("-- Ministry's text and carry nothing of the teacher's.")
    W("DELETE FROM objectives WHERE lesson_id IN (SELECT id FROM new_lesson_ids);")
    W("")
    for seq, (ls, lid) in enumerate(zip(doc["lessons"], lesson_ids), 1):
        nature = ls.get("nature", ["th"])
        W(f"""INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  {q(lid)}, {q(sid)}, {q(ids.get(('m', ls.get('module'))))},
  {q(ids.get(('c', ls.get('competency'))))},
  {q(ls.get('lesson_no'))}, {q(ls.get('lesson_no'))}, {q(ls['title'])},
  {q(ls['term'])}, {q(ls['week'])}, {q(ls.get('week_to', ls['week']))},
  {q('th' in nature)}, {q('prac' in nature)}, {q('dig' in nature)},
  {q(ls['kind'])}, {q(seq)}
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();""")
        for i, text in enumerate(ls.get("objectives", []), 1):
            W(f"INSERT INTO objectives (lesson_id, kind, description, bloom_level, "
              f"sequence) VALUES ({q(lid)}, 'objective', {q(text)}, {q(bloom(text))}, {q(i)});")

    W("")
    W("-- ------------------------------------------------------------------")
    W("-- 5. Carry the attachments across.")
    W("--")
    W("-- Matched on the lesson title, stripped of case and punctuation, and")
    W("-- ONLY where that title is unique on both sides. Twenty-three rows are")
    W("-- called \"Integration activities\"; there is no way to tell which old one")
    W("-- is which new one, so those keep their attachments on the archived row")
    W("-- rather than being guessed at.")
    W("-- ------------------------------------------------------------------")
    W("")
    W("DROP TABLE IF EXISTS moved;")
    W("CREATE TEMP TABLE moved AS")
    W("WITH k AS (SELECT '[^a-zA-Z0-9]' AS strip),")
    W("old_u AS (")
    W("  SELECT id, key, status, content FROM (")
    W("    SELECT o.id, o.status, o.content,")
    W("           lower(regexp_replace(o.title, '[^a-zA-Z0-9]', '', 'g')) AS key,")
    W("           count(*) OVER (PARTITION BY lower(regexp_replace(o.title, '[^a-zA-Z0-9]', '', 'g'))) AS n")
    W("      FROM old_lessons o) t WHERE n = 1),")
    W("new_u AS (")
    W("  SELECT id, key FROM (")
    W("    SELECT n.id,")
    W("           lower(regexp_replace(n.title, '[^a-zA-Z0-9]', '', 'g')) AS key,")
    W("           count(*) OVER (PARTITION BY lower(regexp_replace(n.title, '[^a-zA-Z0-9]', '', 'g'))) AS c")
    W(f"      FROM lessons n WHERE n.syllabus_id = {q(sid)} AND n.deleted_at IS NULL) t")
    W("  WHERE c = 1)")
    W("SELECT o.id AS old_id, n.id AS new_id, o.status AS old_status, o.content AS old_content")
    W("  FROM old_u o JOIN new_u n USING (key);")
    W("")
    W("-- One old row maps to at most one new row and vice versa, so none of")
    W("-- these can collide with the composite keys on lesson_id.")
    for tbl in ("lesson_resources", "question_lessons", "lesson_mastery",
                "lesson_note_sections", "scheme_entries", "assessments", "attempts"):
        W(f"UPDATE {tbl} t SET lesson_id = m.new_id FROM moved m WHERE t.lesson_id = m.old_id;")
    W("")
    W("-- A lesson that had notes written and published keeps them.")
    W("UPDATE lessons n SET status = 'published', content = m.old_content, updated_at = now()")
    W("  FROM moved m")
    W(" WHERE n.id = m.new_id AND m.old_status = 'published'")
    W("   AND coalesce(m.old_content, '') <> '' AND coalesce(n.content, '') = '';")
    W("")
    W("UPDATE competencies c SET exam_frequency = f.exam_frequency,")
    W("       continues_from_id = f.continues_from_id, link_confirmed = f.link_confirmed")
    W("  FROM old_freq f")
    W(f" WHERE c.syllabus_id = {q(sid)} AND c.deleted_at IS NULL")
    W("   AND c.category_of_action = f.category_of_action;")
    W("")
    W("-- Written notes attach to the lesson of the same name, rebuilt from the")
    W("-- sheet each time rather than stored by hand.")
    W("INSERT INTO lesson_note_sections (lesson_id, note_section_id, coverage)")
    W("SELECT l.id, s.id, 'full'")
    W("  FROM note_sections s")
    W("  JOIN note_sources src ON src.id = s.note_source_id")
    W("  JOIN lessons l ON lower(regexp_replace(l.title, '[^a-zA-Z0-9]', '', 'g'))")
    W("                 = lower(regexp_replace(s.title, '[^a-zA-Z0-9]', '', 'g'))")
    W(f" WHERE l.syllabus_id = {q(sid)} AND l.deleted_at IS NULL")
    W(f"   AND src.syllabus_id = {q(sid)} AND s.deleted_at IS NULL")
    W("ON CONFLICT (lesson_id, note_section_id) DO NOTHING;")
    W("")
    W("COMMIT;")
    W("")
    W("-- ------------------------------------------------------------------")
    W("-- What happened. One result table; read every row.")
    W("-- ------------------------------------------------------------------")
    W("")
    W("SELECT 'rows on the new sheet' AS item, count(*)::text AS value FROM lessons")
    W(f" WHERE syllabus_id = {q(sid)} AND deleted_at IS NULL")
    W("UNION ALL SELECT 'numbered lessons', count(*)::text FROM lessons")
    W(f" WHERE syllabus_id = {q(sid)} AND deleted_at IS NULL AND lesson_no_start IS NOT NULL")
    W("UNION ALL SELECT 'objectives', count(*)::text FROM objectives o")
    W(f" JOIN lessons l ON l.id = o.lesson_id WHERE l.syllabus_id = {q(sid)} AND l.deleted_at IS NULL")
    W("UNION ALL SELECT 'categories of action', count(*)::text FROM competencies")
    W(f" WHERE syllabus_id = {q(sid)} AND deleted_at IS NULL")
    W("UNION ALL SELECT 'modules', count(*)::text FROM modules")
    W(f" WHERE syllabus_id = {q(sid)} AND deleted_at IS NULL")
    W("UNION ALL SELECT 'rows archived from the old sheet', count(*)::text FROM lessons")
    W(f" WHERE syllabus_id = {q(sid)} AND deleted_at IS NOT NULL")
    W("UNION ALL SELECT 'notes attached to a lesson', count(*)::text")
    W("  FROM lesson_note_sections lns JOIN lessons l ON l.id = lns.lesson_id")
    W(f" WHERE l.syllabus_id = {q(sid)} AND l.deleted_at IS NULL")
    W("UNION ALL SELECT 'notes with no lesson on the new sheet', count(*)::text")
    W("  FROM note_sections s JOIN note_sources src ON src.id = s.note_source_id")
    W(f" WHERE src.syllabus_id = {q(sid)} AND s.deleted_at IS NULL")
    W("   AND NOT EXISTS (SELECT 1 FROM lesson_note_sections lns")
    W("                     JOIN lessons l ON l.id = lns.lesson_id AND l.deleted_at IS NULL")
    W("                    WHERE lns.note_section_id = s.id)")
    W("UNION ALL SELECT 'uploaded files still attached', count(*)::text")
    W("  FROM lesson_resources r JOIN lessons l ON l.id = r.lesson_id")
    W(f" WHERE l.syllabus_id = {q(sid)} AND l.deleted_at IS NULL AND r.deleted_at IS NULL;")
    return "\n".join(o) + "\n"


class Dumper(yaml.SafeDumper):
    pass

def _str(dumper, data):
    style = ">" if len(data) > 95 else None
    return dumper.represent_scalar("tag:yaml.org,2002:str", data, style=style)
Dumper.add_representer(str, _str)

if __name__ == "__main__":
    import pathlib
    root = pathlib.Path(sys.argv[1])
    for key in SHEETS:
        doc = build(key)
        cfg = SHEETS[key]
        y = root / "tools/curriculum" / f"{cfg['yaml_name']}.yaml"
        y.write_text(
            f"# {doc['syllabus']['title']}\n"
            f"# Transcribed from the Ministry PDF by tools/extract_progression.py.\n"
            f"# Regenerate rather than hand-edit: python3 tools/build_progression.py\n\n"
            + yaml.dump(doc, Dumper=Dumper, sort_keys=False, allow_unicode=True, width=100))
        s = root / "db/seed" / f"{cfg['sql_name']}.sql"
        s.write_text(emit_sql(key, doc))
        print(f"{cfg['yaml_name']:24} modules {len(doc['modules']):2}  "
              f"categories {len(doc['competencies']):2}  rows {len(doc['lessons']):3}  "
              f"objectives {sum(len(l.get('objectives', [])) for l in doc['lessons']):4}")
    print("\nCorrections applied:")
    for c in sorted(set(CORRECTIONS)):
        print("  -", c)
