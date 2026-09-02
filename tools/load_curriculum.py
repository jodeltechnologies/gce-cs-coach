#!/usr/bin/env python3
"""
Curriculum loader for the GCE Computer Science Coach.

Turns a Cameroon progression sheet, transcribed as YAML, into rows in the
database defined by schema.sql.

The Ministry's documents contain real data-entry errors (a lesson printed as
"501" that is plainly 50, a lesson printed as "99" sitting between 58 and 60,
two consecutive rows both numbered 87). The loader corrects these and writes
every correction to curriculum_load_log, so that if a sheet is reissued we can
see what we changed and why. It never corrects anything silently.

Usage
    python3 load_curriculum.py --validate curriculum/*.yaml
    python3 load_curriculum.py --emit-sql curriculum/form5_computer_science.yaml > out/form5.sql
"""

import argparse
import glob
import sys
import uuid
from pathlib import Path

import yaml

# ---------------------------------------------------------------------------
# Bloom level inference
#
# The Ministry writes objectives as verb phrases: "Explain...", "Differentiate...",
# "Write simple algorithms...". The leading verb tells us the cognitive demand,
# so 200 Bloom levels per syllabus can be inferred instead of typed by hand.
# A lesson whose objectives are all State and Explain is a recall lesson; one
# reaching Produce and Build demands application and needs practical assessment
# rather than multiple choice.
# ---------------------------------------------------------------------------

BLOOM_VERBS = {
    "remember":   ["state", "list", "outline", "recall", "name", "recognise",
                   "recognize", "define", "give"],
    "understand": ["explain", "describe", "differentiate", "distinguish",
                   "illustrate", "discuss", "summarise", "summarize"],
    "apply":      ["apply", "use", "make use", "perform", "convert", "install",
                   "solve", "write", "produce", "draw", "calculate", "compute",
                   "reproduce", "match", "represent", "enter", "modify",
                   "edit", "insert", "format"],
    "analyse":    ["analyse", "analyze", "identify", "classify", "compare",
                   "deduce", "determine", "test", "trace", "examine"],
    "evaluate":   ["evaluate", "choose", "select", "assess", "justify",
                   "establish", "propose", "appraise"],
    "create":     ["create", "design", "build", "develop", "combine",
                   "construct", "generate"],
}


def infer_bloom(text):
    """Infer a Bloom level from the leading verb of an objective."""
    lowered = text.strip().lower()
    # Check longer, more specific levels first so "make use of" beats "use".
    for level in ("create", "evaluate", "analyse", "apply", "understand", "remember"):
        for verb in BLOOM_VERBS[level]:
            if lowered.startswith(verb + " ") or lowered.startswith(verb + "s "):
                return level
    return None


# ---------------------------------------------------------------------------
# Term and week boundaries used by all three sheets
# ---------------------------------------------------------------------------

TERM_WEEKS = {1: (1, 12), 2: (13, 24), 3: (25, 36)}

CONTENT_KINDS = {"content"}
STRUCTURAL_KINDS = {"diagnostic_evaluation", "integration_activity",
                    "evaluation", "remediation", "practical", "revision"}

# Structural rows that should never carry objectives.
SILENT_KINDS = {"diagnostic_evaluation", "evaluation", "revision"}


class LoadReport:
    def __init__(self, name):
        self.name = name
        self.entries = []

    def add(self, severity, message, ref=None):
        self.entries.append((severity, message, ref))

    def of(self, severity):
        return [e for e in self.entries if e[0] == severity]

    def ok(self):
        return not self.of("error")

    def render(self):
        out = [f"\n=== {self.name} ==="]
        order = ["error", "warning", "correction", "info"]
        symbol = {"error": "ERROR  ", "warning": "WARN   ",
                  "correction": "FIXED  ", "info": "       "}
        for sev in order:
            for _, msg, ref in self.of(sev):
                suffix = f"   [{ref}]" if ref else ""
                out.append(f"  {symbol[sev]}{msg}{suffix}")
        counts = {s: len(self.of(s)) for s in order}
        out.append(f"  -- {counts['error']} errors, {counts['warning']} warnings, "
                   f"{counts['correction']} corrections")
        return "\n".join(out)


def load_file(path):
    with open(path) as fh:
        return yaml.safe_load(fh)


def validate(doc, path):
    """Structural validation. Returns (report, stats)."""
    syl = doc["syllabus"]
    rpt = LoadReport(f"{syl['form_level']} — {syl['subject']}  ({Path(path).name})")

    modules = {m["title"]: m for m in doc.get("modules", [])}
    comps = {c["category"]: c for c in doc.get("competencies", [])}
    lessons = doc.get("lessons", [])

    # --- shape flags must match the data actually present -------------------
    if syl.get("has_modules") and not modules:
        rpt.add("error", "has_modules is true but no modules are defined")
    if not syl.get("has_modules") and modules:
        rpt.add("error", "has_modules is false but modules are defined")
    if syl.get("uses_competencies") and not comps:
        rpt.add("error", "uses_competencies is true but no categories of action defined")
    if syl.get("has_competency_statements"):
        missing = [c for c in comps.values() if not c.get("statement")]
        if missing:
            rpt.add("error",
                    f"has_competency_statements is true but {len(missing)} categories "
                    f"have no statement")
    else:
        stated = [c for c in comps.values() if c.get("statement")]
        if stated:
            rpt.add("warning",
                    f"{len(stated)} statements present though the sheet declares none")

    # --- references ---------------------------------------------------------
    for ls in lessons:
        ref = _ref(ls)
        if ls.get("module") and ls["module"] not in modules:
            rpt.add("error", f"unknown module '{ls['module']}'", ref)
        if ls.get("competency") and ls["competency"] not in comps:
            rpt.add("error", f"unknown category of action '{ls['competency']}'", ref)

    for c in comps.values():
        if c.get("module") and c["module"] not in modules:
            rpt.add("error", f"category '{c['category']}' names unknown module "
                             f"'{c['module']}'")

    # --- lesson numbering ---------------------------------------------------
    numbered = [ls for ls in lessons if ls.get("lesson_no") is not None]
    seen = {}
    previous = None
    for ls in numbered:
        n = ls["lesson_no"]
        key = (n, ls.get("suffix", ""))
        if key in seen:
            rpt.add("error", f"duplicate lesson number {n}", _ref(ls))
        seen[key] = ls
        if previous is not None and n < previous:
            rpt.add("error", f"lesson {n} appears after lesson {previous}", _ref(ls))
        previous = ls.get("lesson_no_end", n)

    # gaps
    plain = sorted({ls["lesson_no"] for ls in numbered})
    if plain:
        covered = set()
        for ls in numbered:
            for n in range(ls["lesson_no"], ls.get("lesson_no_end", ls["lesson_no"]) + 1):
                covered.add(n)
        expected = set(range(min(plain), max(plain) + 1))
        gaps = sorted(expected - covered)
        if gaps:
            rpt.add("warning", f"lesson numbers not present in the sheet: {gaps}")

    # --- corrections declared in the data -----------------------------------
    for ls in numbered:
        if ls.get("printed_as"):
            rpt.add("correction",
                    f"printed as \"{ls['printed_as']}\", loaded as lesson "
                    f"{ls['lesson_no']}{ls.get('suffix','')}", _ref(ls))

    # --- terms and weeks ----------------------------------------------------
    prev_week = 0
    for ls in lessons:
        term, week = ls.get("term"), ls.get("week")
        ref = _ref(ls)
        if term not in TERM_WEEKS:
            rpt.add("error", f"invalid term {term!r}", ref)
            continue
        lo, hi = TERM_WEEKS[term]
        if week is None or not (lo <= week <= hi):
            rpt.add("error", f"week {week} outside term {term} (weeks {lo}-{hi})", ref)
            continue
        if week < prev_week:
            rpt.add("error", f"week {week} goes backwards from {prev_week}", ref)
        prev_week = week
    if prev_week > syl.get("total_weeks", 36):
        rpt.add("error", f"sheet runs to week {prev_week}, declared total is "
                         f"{syl.get('total_weeks')}")

    # --- integration activities --------------------------------------------
    #
    # The Form 5 sheet closes each category of action with one. The Lower Sixth
    # 2026/2027 sheet does not: it has six, placed at module level with no
    # category named. Warning per category there would print 26 lines saying
    # nothing, so the shape is detected once and reported once.
    integration = [ls for ls in lessons if ls.get("kind") == "integration_activity"]
    per_category = [ls for ls in integration if ls.get("competency")]
    if comps and per_category:
        by_comp = {}
        for ls in per_category:
            by_comp.setdefault(ls["competency"], []).append(ls)
        for name in comps:
            n = len(by_comp.get(name, []))
            if n == 0:
                rpt.add("warning", f"category '{name}' has no integration activity")
            elif n > 1:
                rpt.add("info", f"category '{name}' has {n} integration activities")
    elif integration:
        rpt.add("info", f"{len(integration)} integration activities, placed at "
                        f"module level rather than per category of action")

    # --- content lessons should carry objectives ----------------------------
    for ls in lessons:
        kind = ls.get("kind", "content")
        if kind in CONTENT_KINDS and not (ls.get("objectives") or ls.get("content_points")):
            rpt.add("warning", "content lesson has no objectives", _ref(ls))
        # Evaluation and diagnostic rows are a date, not a lesson, so objectives
        # on them are a transcription error. Remediation and integration rows
        # are different: the 2026/2027 sheets spell out what each one covers,
        # and that text is worth keeping.
        if kind in SILENT_KINDS and ls.get("objectives"):
            rpt.add("warning", f"{kind} row unexpectedly carries objectives", _ref(ls))

    # --- proposed cross-year links -----------------------------------------
    for link in doc.get("continues_from", []):
        if link["category"] not in comps:
            rpt.add("error", f"continues_from names unknown category "
                             f"'{link['category']}'")
        else:
            rpt.add("info", f"proposed link (unconfirmed): '{link['category']}' "
                            f"continues '{link['form4']}'")

    stats = summarise(doc)
    return rpt, stats


def _ref(ls):
    n = ls.get("lesson_no")
    if n is None:
        return f"{ls.get('title','?')} wk{ls.get('week','?')}"
    return f"L{n}{ls.get('suffix','')}"


def summarise(doc):
    lessons = doc.get("lessons", [])
    kinds = {}
    for ls in lessons:
        k = ls.get("kind", "content")
        kinds[k] = kinds.get(k, 0) + 1
    objectives = sum(len(ls.get("objectives", [])) for ls in lessons)
    points = sum(len(ls.get("content_points", [])) for ls in lessons)
    tasks = sum(len(s.get("tasks", [])) for s in doc.get("practical_sections", []))
    return {
        "modules": len(doc.get("modules", [])),
        "categories": len(doc.get("competencies", [])),
        "rows": len(lessons),
        "objectives": objectives,
        "content_points": points,
        "practical_sections": len(doc.get("practical_sections", [])),
        "practical_tasks": tasks,
        "kinds": kinds,
    }


# ---------------------------------------------------------------------------
# SQL emission
# ---------------------------------------------------------------------------

def q(value):
    if value is None:
        return "NULL"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)):
        return str(value)
    return "'" + str(value).replace("'", "''") + "'"


def emit_sql(doc):
    syl = doc["syllabus"]
    out = []
    ids = {}
    new = lambda: str(uuid.uuid4())

    out.append("BEGIN;")
    out.append(f"-- {syl['title']}")
    out.append("")

    out.append(f"INSERT INTO subjects (name) VALUES ({q(syl['subject'])}) "
               "ON CONFLICT (name) DO NOTHING;")
    out.append(f"INSERT INTO levels (name, short_name) VALUES "
               f"({q(syl['level'])}, {q(syl['level_short'])}) "
               "ON CONFLICT (name) DO NOTHING;")
    out.append("")

    sid = new()
    ids["syllabus"] = sid
    out.append(f"""INSERT INTO syllabi (
  id, subject_id, level_id, title, form_level, issuing_authority, scope, region,
  version_label, effective_from, total_weeks, weekly_periods_theory,
  weekly_periods_practical, coefficient, module_label, has_modules,
  uses_competencies, has_competency_statements, has_practical_stream
) VALUES (
  {q(sid)},
  (SELECT id FROM subjects WHERE name = {q(syl['subject'])}),
  (SELECT id FROM levels   WHERE name = {q(syl['level'])}),
  {q(syl['title'])}, {q(syl['form_level'])}, {q(syl.get('issuing_authority'))},
  {q(syl.get('scope'))}, {q(syl.get('region'))}, {q(syl['version_label'])},
  {q(syl['effective_from'])}, {q(syl.get('total_weeks', 36))},
  {q(syl.get('weekly_periods_theory'))}, {q(syl.get('weekly_periods_practical'))},
  {q(syl.get('coefficient'))}, {q(syl.get('module_label', 'Module'))},
  {q(syl.get('has_modules', False))}, {q(syl.get('uses_competencies', False))},
  {q(syl.get('has_competency_statements', False))},
  {q(syl.get('has_practical_stream', False))}
);""")
    out.append("")

    for m in doc.get("modules", []):
        mid = new()
        ids[("module", m["title"])] = mid
        out.append(f"INSERT INTO modules (id, syllabus_id, title, sequence) VALUES "
                   f"({q(mid)}, {q(sid)}, {q(m['title'])}, {q(m['sequence'])});")
    if doc.get("modules"):
        out.append("")

    for c in doc.get("competencies", []):
        cid = new()
        ids[("comp", c["category"])] = cid
        mid = ids.get(("module", c.get("module"))) if c.get("module") else None
        stmt = c.get("statement")
        if stmt:
            stmt = " ".join(stmt.split())
        out.append(f"INSERT INTO competencies "
                   f"(id, syllabus_id, module_id, category_of_action, "
                   f"competency_statement, sequence) VALUES "
                   f"({q(cid)}, {q(sid)}, {q(mid)}, {q(c['category'])}, "
                   f"{q(stmt)}, {q(c['sequence'])});")
    if doc.get("competencies"):
        out.append("")

    for seq, ls in enumerate(doc.get("lessons", []), start=1):
        lid = new()
        kind = ls.get("kind", "content")
        nature = ls.get("nature", ["th"])
        mid = ids.get(("module", ls.get("module"))) if ls.get("module") else None
        cid = ids.get(("comp", ls.get("competency"))) if ls.get("competency") else None
        out.append(f"""INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  {q(lid)}, {q(sid)}, {q(mid)}, {q(cid)}, {q(ls.get('lesson_no'))},
  {q(ls.get('lesson_no_end', ls.get('lesson_no')))}, {q(ls['title'])}, {q(ls.get('term'))},
  {q(ls.get('week'))}, {q(ls.get('week_to', ls.get('week')))},
  {q('th' in nature)}, {q('prac' in nature)}, {q('dig' in nature)},
  {q(kind)}, {q(seq)}
);""")
        for i, text in enumerate(ls.get("objectives", []), start=1):
            out.append(f"INSERT INTO objectives (lesson_id, kind, description, "
                       f"bloom_level, sequence) VALUES ({q(lid)}, 'objective', "
                       f"{q(text)}, {q(infer_bloom(text))}, {q(i)});")
        for i, text in enumerate(ls.get("content_points", []), start=1):
            out.append(f"INSERT INTO objectives (lesson_id, kind, description, "
                       f"bloom_level, sequence) VALUES ({q(lid)}, 'content_point', "
                       f"{q(text)}, NULL, {q(i)});")
        if ls.get("printed_as"):
            note = (f"Sheet prints this row as \"{ls['printed_as']}\"; "
                    f"loaded as lesson {ls['lesson_no']}{ls.get('suffix', '')}")
            out.append(f"INSERT INTO curriculum_load_log "
                       f"(syllabus_id, severity, message, source_ref) VALUES "
                       f"({q(sid)}, 'correction', {q(note)}, {q(ls['title'])});")
        out.append("")

    # Cross-year links. Emitted as UPDATEs that look the earlier category up by
    # name, so they work regardless of the UUIDs the previous file generated.
    # link_confirmed stays false: these are proposals until the teacher agrees.
    links = doc.get("continues_from", [])
    if links:
        out.append("-- Proposed continuity with the previous year (unconfirmed).")
        for link in links:
            cid = ids.get(("comp", link["category"]))
            prior = link.get("form4") or link.get("continues")
            out.append(f"""UPDATE competencies SET
  continues_from_id = (
    SELECT c.id FROM competencies c
    JOIN syllabi s ON s.id = c.syllabus_id
    WHERE c.category_of_action = {q(prior)}
      AND s.form_level = {q(link.get('from_form', 'Form 4'))}
    LIMIT 1
  ),
  link_confirmed = false
WHERE id = {q(cid)};""")
        out.append("")

    for s in doc.get("practical_sections", []):
        pid = new()
        out.append(f"INSERT INTO practical_sections "
                   f"(id, syllabus_id, title, sequence, workbook_ref) VALUES "
                   f"({q(pid)}, {q(sid)}, {q(s['title'])}, {q(s['sequence'])}, "
                   f"{q(s.get('workbook_ref'))});")
        for i, t in enumerate(s.get("tasks", []), start=1):
            out.append(f"INSERT INTO practical_tasks (practical_section_id, "
                       f"description, term, week_from, week_to, sequence) VALUES "
                       f"({q(pid)}, {q(t['description'])}, {q(t.get('term'))}, "
                       f"{q(t.get('week'))}, {q(t.get('week'))}, {q(i)});")
        out.append("")

    out.append("COMMIT;")
    return "\n".join(out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("files", nargs="+")
    ap.add_argument("--validate", action="store_true")
    ap.add_argument("--emit-sql", action="store_true")
    args = ap.parse_args()

    paths = []
    for f in args.files:
        paths.extend(sorted(glob.glob(f)) or [f])

    failed = False
    for path in paths:
        doc = load_file(path)
        rpt, stats = validate(doc, path)
        if args.emit_sql:
            if not rpt.ok():
                print(rpt.render(), file=sys.stderr)
                sys.exit(1)
            print(emit_sql(doc))
            continue
        print(rpt.render())
        print(f"  -- would load: {stats['modules']} modules, "
              f"{stats['categories']} categories, {stats['rows']} rows "
              f"({', '.join(f'{v} {k}' for k, v in sorted(stats['kinds'].items()))}), "
              f"{stats['objectives']} objectives, "
              f"{stats['content_points']} content points, "
              f"{stats['practical_tasks']} practical tasks")
        if not rpt.ok():
            failed = True

    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()
