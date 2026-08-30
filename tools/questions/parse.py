#!/usr/bin/env python3
"""Parse GCE Computer Science past questions PDF into clean text + JSON."""
import json
import os
import re
import sys

SRC = "past_questions.pdf"

# --- 1. assemble pages: text layer where present, OCR where not -------------

import columns

raw_pages = open("pages_layout.txt", encoding="utf-8", errors="replace").read().split("\f")
if raw_pages and not raw_pages[-1].strip():
    raw_pages = raw_pages[:-1]

# pages whose *raw* text layer was empty — these are scans and need OCR,
# even though -layout may emit a few watermark characters for them
NEEDS_OCR = {int(x) for x in open("empty_pages.txt").read().split()}

pages = []
for i, p in enumerate(raw_pages):
    n = i + 1
    src = "text-layer"
    two_col = False
    if n in NEEDS_OCR:
        # column-split OCR, where we produced it, beats the whole-page pass
        f2 = f"ocr2/{n:03d}.txt"
        f = f2 if os.path.exists(f2) else f"ocr/{n:03d}.txt"
        if os.path.exists(f):
            p = open(f, encoding="utf-8", errors="replace").read()
            src = "ocr"
        else:
            src = "blank"
            p = ""
    if src == "text-layer":
        p, two_col = columns.split_page(p)
    pages.append({"page": n, "source": src, "text": p, "two_column": two_col})

# --- 2. clean watermarks / footers / page furniture -------------------------

NOISE = [
    r'for more past que?str?ions?, ?corrections? and notes,? download the app "?kawlo"?.*',
    r"https?://www\.gcerevision\.com",
    r"GCE PAST QUESTIONS\.pdf",
    r"file:///E:\\GCE.*",
    r"©\s*TRU/RPI-CSC/SWATIC",
    r"Turn Over",
    r"^\s*\d{1,3}\s*$",          # bare page numbers
    r"^\s*[_\-=]{5,}\s*$",       # separator rules
    r"Page\s+\d+\s+of\s+\d+",
    r"Go on to the next page",
    r"END\.?\s*GO BACK AND CHECK YOUR WORK\.?",
    r"T/\s*(?:0595|COMPUTER SCIENCE)[/\w\s]*",
    r"\b\d{4}/0595/\d/\w+",
    r"STOP[!\.]?\s*END OF (?:PAPER|EXAMINATION)",
]
NOISE_RE = [re.compile(x, re.I | re.M) for x in NOISE]

# vertically-set watermark letters ("gc / er / ev / is / io / n / .c o / m")
WM_FRAG = re.compile(r"^\s*(gc|er|ev|is|io|ion|isi|on|n|\.c|\.co|o|om|m|c|\.com)\s*$", re.I)


def clean(text):
    for r in NOISE_RE:
        text = r.sub("", text)
    lines = [ln.rstrip() for ln in text.split("\n")]
    lines = [ln for ln in lines if not WM_FRAG.match(ln)]
    out, blank = [], 0
    for ln in lines:
        if not ln.strip():
            blank += 1
            if blank > 1:
                continue
        else:
            blank = 0
        out.append(ln)
    return "\n".join(out).strip()


for p in pages:
    p["clean"] = clean(p["text"])

# --- 3. detect which paper each page belongs to -----------------------------

PAPER_PATTERNS = [
    (re.compile(r"SOUTH\s*WEST\s*REGIONAL\s*MOCK", re.I), "South West Regional Mock"),
    (re.compile(r"NORTH\s*WEST\s*REGIONAL\s*MOCK", re.I), "North West Regional Mock"),
    (re.compile(r"CAMEROON GENERAL CERTIFICATE OF EDUCATION BOARD", re.I), "GCE Board"),
]
YEAR = re.compile(r"\b(19[89]\d|20[0-3]\d)\b")
SESSION = re.compile(r"\b(JUNE|JULY|MAY|MARCH)\b", re.I)
PAPERNO = re.compile(r"COMPUTER SCIENCE\s*([123])\b|Paper\s*(?:Number\s*)?([123])\b", re.I)
LEVEL = re.compile(r"\b(ORDINARY|ADVANCED)\s*/?\s*(?:ITVE\s*)?LEVEL\b", re.I)

current = {"exam": None, "year": None, "session": None, "paper": None, "level": None}
header_page = None
for p in pages:
    t = p["clean"]
    head = t[:1200]
    hit = False
    for rx, name in PAPER_PATTERNS:
        if rx.search(head):
            current = dict(current)
            current["exam"] = name
            hit = True
            break
    if hit or re.search(r"COMPUTER SCIENCE\s*[123]\b", head, re.I):
        y = YEAR.search(head)
        s = SESSION.search(head)
        pn = PAPERNO.search(head)
        lv = LEVEL.search(head)
        current = dict(current)
        if y:
            current["year"] = int(y.group(1))
        if s:
            current["session"] = s.group(1).title()
        if pn:
            current["paper"] = int(pn.group(1) or pn.group(2))
        if lv:
            current["level"] = lv.group(1).title() + " Level"
        header_page = p["page"]
    # A header only describes the pages that follow it closely. This compilation
    # interleaves loose question banks between real papers, and without a limit
    # a 2010 header ends up stamped on 160 questions that have nothing to do
    # with 2010. Past 12 pages we say we do not know rather than guess.
    ctx = dict(current)
    ctx["confident"] = header_page is not None and (p["page"] - header_page) <= 12
    ctx["header_page"] = header_page
    if not ctx["confident"]:
        ctx = {"exam": None, "year": None, "session": None, "paper": None,
               "level": None, "confident": False, "header_page": header_page}
    p["paper_context"] = ctx

# --- 4. MCQ extraction ------------------------------------------------------

# question number at line start
QNUM = re.compile(r"^\s*(\d{1,3})\s*[\.\)]?\s*(.*)$")
# option line: A / A. / A) / (A) / A- followed by text (or bare letter)
OPT = re.compile(r"^\s*\(?([A-Ea-e])\)?\s*[\.\)\-:]?\s+(.+?)\s*$")
OPT_BARE = re.compile(r"^\s*\(?([A-Ea-e])\)?\s*[\.\)]?\s*$")
ANS = re.compile(
    r"^\s*(?:Ans(?:wer)?)\s*[\.:\-]?\s*\(?([A-Da-d])\)?\b(.*)$", re.I)
ANS_INLINE = re.compile(r"\bANS(?:WER)?\s*[\.:\-]?\s*\(?([A-Da-d])\)?", re.I)
# "ANSWER: X – STACK" style where letter is wrong but text follows
ANS_TEXT = re.compile(r"^\s*ANSWER\s*[:\-]\s*\S+\s*[\-–—]+\s*(.+?)\s*$", re.I)


def parse_mcqs(page):
    """Return list of MCQ dicts found on one page."""
    lines = [ln for ln in page["clean"].split("\n")]
    out = []
    i = 0
    n = len(lines)
    while i < n:
        m = QNUM.match(lines[i])
        if not m or not lines[i].strip():
            i += 1
            continue
        qnum = int(m.group(1))
        if qnum > 120:
            i += 1
            continue
        stem_parts = [m.group(2).strip()] if m.group(2).strip() else []
        j = i + 1
        # gather stem until first option marker
        while j < n:
            ln = lines[j]
            if not ln.strip():
                j += 1
                continue
            om = OPT.match(ln)
            ob = OPT_BARE.match(ln)
            if (om and om.group(1).upper() == "A") or (ob and ob.group(1).upper() == "A"):
                break
            if QNUM.match(ln) and re.match(r"^\s*\d{1,3}\s*[\.\)]", ln):
                break
            stem_parts.append(ln.strip())
            j += 1
            if j - i > 14:
                break
        if j >= n:
            i += 1
            continue
        # collect options A..D/E
        opts = {}
        expected = "A"
        k = j
        pending_letter = None
        while k < n and expected <= "E":
            ln = lines[k]
            if not ln.strip():
                k += 1
                continue
            if re.match(r"^\s*\d{1,3}\s*[\.\)]\s", ln) and len(opts) >= 2:
                break
            if ANS.match(ln) or ANS_TEXT.match(ln) or ANS_INLINE.match(ln.strip()):
                break
            ob = OPT_BARE.match(ln)
            om = OPT.match(ln)
            if ob and ob.group(1).upper() == expected:
                pending_letter = expected
                opts[expected] = ""
                expected = chr(ord(expected) + 1)
                k += 1
                continue
            if om and om.group(1).upper() == expected:
                opts[expected] = om.group(2).strip()
                pending_letter = expected
                expected = chr(ord(expected) + 1)
                k += 1
                continue
            if pending_letter and not OPT.match(ln):
                opts[pending_letter] = (opts[pending_letter] + " " + ln.strip()).strip()
                k += 1
                continue
            if pending_letter:
                opts[pending_letter] = (opts[pending_letter] + " " + ln.strip()).strip()
                k += 1
                continue
            break
        if len([v for v in opts.values()]) < 3:
            i += 1
            continue
        # reject structured/essay questions masquerading as MCQs:
        # real options are short and never carry their own mark allocation
        vals = list(opts.values())
        if any(re.search(r"\(\s*\d+\s*(?:marks?|mks?)\s*\)", v, re.I) for v in vals):
            i = k
            continue
        if max(len(v) for v in vals) > 220:
            i = k
            continue
        if sum(len(v) for v in vals) / max(len(vals), 1) > 130:
            i = k
            continue
        if re.search(r"\(\s*\d+\s*(?:marks?|mks?)\s*\)", " ".join(stem_parts), re.I):
            i = k
            continue
        # look for an answer key in the next few lines
        answer = None
        answer_text = None
        for z in range(k, min(k + 4, n)):
            am = ANS.match(lines[z])
            if am:
                answer = am.group(1).upper()
                break
            at = ANS_TEXT.match(lines[z])
            if at:
                answer_text = at.group(1).strip()
                break
            ai = ANS_INLINE.search(lines[z])
            if ai:
                answer = ai.group(1).upper()
                break
        stem = " ".join(stem_parts).strip()
        stem = re.sub(r"\s{2,}", " ", stem)
        if len(stem) < 8:
            i = k
            continue
        rec = {
            "number": qnum,
            "page": page["page"],
            "extraction": page["source"],
            "stem": stem,
            "options": {kk: re.sub(r"\s{2,}", " ", vv) for kk, vv in sorted(opts.items())},
            "answer": answer,
            "paper": page["paper_context"],
        }
        if answer_text:
            rec["answer_text"] = answer_text
            # try to match answer text back to an option letter
            for kk, vv in rec["options"].items():
                if vv and vv.lower().strip(" .").startswith(answer_text.lower()[:12].strip(" .")):
                    rec["answer"] = kk
                    break
        out.append(rec)
        i = k
    return out


mcqs = []
for p in pages:
    mcqs.extend(parse_mcqs(p))

# duplicate detection — this compilation repeats many questions across papers
def norm(s):
    return re.sub(r"[^a-z0-9 ]", "", s.lower())[:90]


groups = {}
for idx, q in enumerate(mcqs):
    groups.setdefault(norm(q["stem"]), []).append(idx)
for key, idxs in groups.items():
    if len(idxs) > 1:
        for rank, idx in enumerate(idxs):
            mcqs[idx]["duplicate_of_page"] = mcqs[idxs[0]]["page"] if rank else None
            mcqs[idx]["is_repeat"] = rank > 0

# quality flags
for q in mcqs:
    flags = []
    if not q["answer"]:
        flags.append("no_answer_key")
    if len(q["options"]) < 4:
        flags.append("missing_options")
    if any(not v for v in q["options"].values()):
        flags.append("empty_option")
    if q["extraction"] == "ocr":
        flags.append("from_ocr")
    if len(q["stem"]) > 400:
        flags.append("long_stem")
    if re.search(r"(table below|diagram|figure|shown below|given logic gates|screen image)", q["stem"], re.I):
        flags.append("references_figure")
    q["flags"] = flags
    q["needs_review"] = bool(set(flags) - {"from_ocr"})

# --- 5. structured (Paper 2 / essay) questions ------------------------------

MARKS = re.compile(r"\((\d{1,2})\s*(?:marks?|mks?|pts?|points?)\)", re.I)
STRUCT_Q = re.compile(r"^\s*(\d{1,2})[\.\)]\s*(?:\(([a-z])\))?\s*(.+)$")

structured = []
for p in pages:
    lines = p["clean"].split("\n")
    for idx, ln in enumerate(lines):
        if not MARKS.search(ln):
            continue
        # walk back to the start of the question
        start = idx
        for b in range(idx, max(idx - 8, -1), -1):
            if STRUCT_Q.match(lines[b]) or re.match(r"^\s*\(?[a-z ivx]{1,4}\)", lines[b]):
                start = b
                break
        text = " ".join(x.strip() for x in lines[start:idx + 1]).strip()
        text = re.sub(r"\s{2,}", " ", text)
        if len(text) < 25 or len(text) > 900:
            continue
        marks = int(MARKS.search(ln).group(1))
        # is an answer pointer block nearby?
        window = "\n".join(lines[idx:idx + 25])
        has_answer = bool(re.search(r"Answer\s*Pointers?|Suggested answers|Marking Guide", window, re.I))
        # sub-parts like "(ii) ... (2 marks)" are meaningless without the parent
        # stem, so carry a few preceding lines along for the reviewer
        ctx = " ".join(x.strip() for x in lines[max(start - 4, 0):start]).strip()
        structured.append({
            "page": p["page"],
            "extraction": p["source"],
            "text": text,
            "context_before": re.sub(r"\s{2,}", " ", ctx)[:400],
            "marks": marks,
            "has_answer_pointers": has_answer,
            "paper": p["paper_context"],
        })

# dedupe structured by (page, text)
seen = set()
uniq = []
for s in structured:
    key = (s["page"], s["text"][:80])
    if key in seen:
        continue
    seen.add(key)
    uniq.append(s)
structured = uniq

# --- 6. write outputs -------------------------------------------------------

# writes alongside this script

with open("./past_questions_full_text.txt", "w", encoding="utf-8") as f:
    f.write("GCE COMPUTER SCIENCE PAST QUESTIONS - EXTRACTED TEXT\n")
    f.write(f"Source: past_questions.pdf ({len(pages)} pages)\n")
    f.write("Pages marked [OCR] were image-only scans and were read with Tesseract;\n")
    f.write("expect character errors there. Pages marked [TEXT] came from the PDF text layer.\n")
    f.write("=" * 78 + "\n\n")
    for p in pages:
        tag = {"text-layer": "TEXT", "ocr": "OCR", "blank": "BLANK/UNREADABLE"}[p["source"]]
        ctx = p["paper_context"]
        bits = [str(v) for v in (ctx.get("exam"), ctx.get("session"), ctx.get("year"),
                                 f"Paper {ctx['paper']}" if ctx.get("paper") else None,
                                 ctx.get("level")) if v]
        f.write(f"\n{'-'*78}\n[PAGE {p['page']}] [{tag}] {' | '.join(bits)}\n{'-'*78}\n")
        f.write(p["clean"] + "\n")

# if one copy of a repeated question carries an answer key, share it with the
# others but mark where it came from, so a reviewer can accept or reject it
for key, idxs in groups.items():
    if len(idxs) < 2:
        continue
    keyed = [mcqs[i] for i in idxs if mcqs[i]["answer"]]
    if not keyed:
        continue
    src_ans = keyed[0]["answer"]
    src_page = keyed[0]["page"]
    for i in idxs:
        if not mcqs[i]["answer"]:
            mcqs[i]["answer"] = src_ans
            mcqs[i]["answer_source"] = f"copied from duplicate on page {src_page}"
            if "no_answer_key" in mcqs[i]["flags"]:
                mcqs[i]["flags"].remove("no_answer_key")
                mcqs[i]["flags"].append("answer_inferred_from_duplicate")
            mcqs[i]["needs_review"] = True

json.dump(mcqs, open("./mcq_questions.json", "w", encoding="utf-8"),
          indent=2, ensure_ascii=False)
json.dump(structured, open("./structured_questions.json", "w", encoding="utf-8"),
          indent=2, ensure_ascii=False)

# --- 7. review report -------------------------------------------------------

from collections import Counter

flag_counts = Counter(f for q in mcqs for f in q["flags"])
by_page = Counter(q["page"] for q in mcqs)
n_ocr_pages = sum(1 for p in pages if p["source"] == "ocr")
n_two_col = sum(1 for p in pages if p.get("two_column"))

rep = []
rep.append("# Extraction review — GCE Computer Science past questions\n")
rep.append(f"Source PDF: 334 pages, 69 MB.\n")
rep.append("## How the text was obtained\n")
rep.append(f"- {len(pages) - n_ocr_pages} pages had a real text layer and were read directly.")
rep.append(f"- {n_ocr_pages} pages were image-only scans and were read with OCR (Tesseract).")
rep.append(f"- {n_two_col} pages were two-column and were split at the gutter before parsing;")
rep.append("  20 scanned MCQ pages were re-scanned one column at a time, which fixed")
rep.append("  text bleeding between columns.\n")
rep.append("**OCR pages carry character errors.** Every question drawn from one is tagged")
rep.append('`"extraction": "ocr"` and flagged `from_ocr`. Read those against the PDF before use.\n')
rep.append("## What came out\n")
rep.append(f"- **{len(mcqs)} multiple-choice questions** — `mcq_questions.json`")
rep.append(f"  - {sum(1 for q in mcqs if q['answer'])} have an answer key; "
           f"{len(mcqs) - sum(1 for q in mcqs if q['answer'])} do not "
           "(most exam papers in this compilation were printed without answers)")
rep.append(f"  - {sum(1 for q in mcqs if not q['needs_review'])} parsed cleanly with no review flag")
rep.append(f"- **{len(structured)} structured / essay question parts** — `structured_questions.json`")
rep.append(f"  - {sum(1 for s in structured if s['has_answer_pointers'])} sit near an "
           "'Answer Pointers' or marking-guide block")
rep.append("- **Full cleaned text of all 334 pages** — `past_questions_full_text.txt`\n")
rep.append("## Flags on the MCQs\n")
rep.append("| Flag | Count | Meaning |")
rep.append("|---|---|---|")
meaning = {
    "no_answer_key": "no answer printed in the source",
    "from_ocr": "text came from OCR, verify wording",
    "missing_options": "fewer than four options recovered",
    "empty_option": "an option letter was found but its text was blank",
    "references_figure": "stem refers to a diagram, table or image not captured here",
    "long_stem": "stem over 400 characters, likely absorbed neighbouring text",
    "answer_inferred_from_duplicate": "answer copied from an identical question elsewhere",
}
for f, c in flag_counts.most_common():
    rep.append(f"| `{f}` | {c} | {meaning.get(f, '')} |")
rep.append("")
rep.append("## Known limits\n")
rep.append("- **Diagrams, truth tables and logic circuits are not captured.** Many questions")
rep.append("  depend on an image; the stem survives, the figure does not. These are flagged")
rep.append("  `references_figure` where detectable, but detection is by keyword and will miss some.")
rep.append("- **Structured questions are fragmentary.** A part like `(ii) ... (2 marks)` has no")
rep.append("  meaning without its parent stem, so each record carries a `context_before` field")
rep.append("  and a page number. Use the full text file for the whole question.")
rep.append("- **Paper attribution is best-effort.** The `paper` field is inferred from the nearest")
rep.append("  preceding header, so pages between papers can inherit the wrong one. Verify against")
rep.append("  the page number before trusting it.")
rep.append("- The compilation repeats questions across sections; identical stems are linked with")
rep.append("  `is_repeat` and `duplicate_of_page`.\n")
rep.append("## Pages with the most MCQs\n")
rep.append(", ".join(f"p{p} ({c})" for p, c in by_page.most_common(12)))
rep.append("")

open("./EXTRACTION_REVIEW.md", "w", encoding="utf-8").write("\n".join(rep))

# summary
n_ocr = sum(1 for p in pages if p["source"] == "ocr")
n_blank = sum(1 for p in pages if p["source"] == "blank")
with_ans = sum(1 for q in mcqs if q["answer"])
clean_q = sum(1 for q in mcqs if not q["needs_review"])
print(f"pages: {len(pages)} (text {len(pages)-n_ocr-n_blank}, ocr {n_ocr}, blank {n_blank})")
print(f"MCQs: {len(mcqs)}  with answer key: {with_ans}  clean (no review flag): {clean_q}")
print(f"structured questions: {len(structured)}  with answer pointers: {sum(1 for s in structured if s['has_answer_pointers'])}")
from collections import Counter
print(Counter(f for q in mcqs for f in q["flags"]).most_common())
