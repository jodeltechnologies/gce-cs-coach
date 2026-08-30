#!/usr/bin/env python3
"""
Assemble the extracted pages into chapter notes.

Reading order is the thing to get right. Both PDFs are set in two columns, so
the order the text appears in the file is not the order a student reads it.
Left column top to bottom, then right column; anything else turns the notes
into scrambled prose that looks fine at a glance and is unusable in a lesson.

Figures are placed by position rather than appended at the end, so the
instruction cycle diagram lands where the instruction cycle is explained.
"""

import os
import pickle
import re
import shutil

FIG_URL = "/notes/figures"

# Chapter titles as they appear, in order. Used to split the run of pages into
# note sections a teacher can attach to a lesson.
CHAPTER = re.compile(r"^\s*(\d{1,2})\s*$")

HEADING = re.compile(r"^\s*(\d{1,2})\.(\d{1,2})\.?(\d{1,2})?\.?\s*$")


def line_rows(items, tol=6):
    """Group text fragments that share a baseline into single lines."""
    rows = []
    for i in sorted(items, key=lambda x: (x["top"], x["left"])):
        if rows and abs(i["top"] - rows[-1][0]["top"]) <= tol:
            rows[-1].append(i)
        else:
            rows.append([i])
    return [sorted(r, key=lambda x: x["left"]) for r in rows]


def row_text(row):
    out = ""
    for i, it in enumerate(row):
        t = it["text"]
        if i and not out.endswith(" ") and not t.startswith(" "):
            gap = it["left"] - (row[i - 1]["left"] + row[i - 1]["width"])
            if gap > 3:
                out += " "
        out += t
    # the notes use Symbol-font glyphs for bullets
    out = out.replace("\uf0b7", "- ").replace("\uf076", "- ").replace("\uf0a7", "- ")
    out = out.replace("\u201c", '"').replace("\u201d", '"')
    out = out.replace("\u2018", "'").replace("\u2019", "'").replace("\u201a", "'")
    out = out.replace("\u201e", "'").replace("\u201f", "'").replace("\u2039", "'")
    return re.sub(r"[ \t]{2,}", " ", out).strip()


def is_heading(row):
    """Numbered section headings are bold and short."""
    txt = row_text(row)
    if len(txt) > 90:
        return False
    return bool(re.match(r"^\d{1,2}\.\d{0,2}\.?\d{0,2}\.?\s+\S", txt))


def build_blocks(page):
    """Text lines and figures for one page, in reading order."""
    width = page["width"]
    mid = width / 2
    lefts = [i["left"] for i in page["items"]]
    two_col = (sum(1 for x in lefts if x < mid) >= 8
               and sum(1 for x in lefts if x >= mid) >= 8)
    cols = [(0, mid), (mid, width)] if two_col else [(0, width)]

    blocks = []
    for ci, (lo, hi) in enumerate(cols):
        items = [i for i in page["items"] if lo <= i["left"] < hi]
        if not items:
            continue
        figs = [f for f in (page.get("figures") or [])
                if lo <= f["left"] < hi or (f["left"] < hi and f["right"] > lo)]
        rows = line_rows(items)
        placed = set()
        for row in rows:
            top = row[0]["top"]
            for k, f in enumerate(figs):
                if k in placed or not f.get("file"):
                    continue
                if f["top"] < top:
                    blocks.append({"kind": "figure", "file": f["file"],
                                   "labels": f.get("labels", [])})
                    placed.add(k)
            txt = row_text(row)
            # Suppress the drawing's own labels, but not a heading that
            # happens to sit in the same band — dropping those silently loses
            # real content, which is worse than a duplicated word.
            inside = [f for f in figs
                      if f.get("file") and f["top"] <= top <= f["bottom"]]
            def norm(x):
                return re.sub(r"[^a-z0-9]+", " ", x.lower()).strip()
            if inside and txt:
                pool = norm(" ".join(l for f in inside for l in f.get("labels", [])))
                words = [w for w in norm(txt).split() if w]
                if words and all(w in pool.split() for w in words):
                    continue
            if not txt:
                continue
            blocks.append({"kind": "text", "text": txt,
                           "bold": any(i["bold"] for i in row),
                           "height": max(i["height"] for i in row),
                           "left": row[0]["left"] - lo})
        for k, f in enumerate(figs):
            if k not in placed and f.get("file"):
                blocks.append({"kind": "figure", "file": f["file"],
                               "labels": f.get("labels", [])})
    return blocks


def strip_furniture(blocks):
    """Drop the copyright line, page numbers and dotted leaders."""
    out = []
    for b in blocks:
        if b["kind"] != "text":
            out.append(b)
            continue
        t = b["text"]
        if re.match(r"^©\s*\d{4}", t):
            continue
        if re.fullmatch(r"\d{1,3}", t):
            continue
        if re.fullmatch(r"[.\u2026\s]+", t):
            continue
        if re.fullmatch(r"[-\u2013\u2014_\s]{4,}", t):
            continue
        out.append(b)
    return out


def to_markdown(blocks):
    """Join lines into paragraphs, keeping headings, bullets and figures."""
    md = []
    para = []
    state = {"bullet": False}

    def flush():
        if not para:
            return
        text = re.sub(r"\s{2,}", " ", " ".join(para)).strip()
        if not text:
            para.clear()
            return
        # Column wrapping glues consecutive lettered points into one block.
        # Break them back apart on the "b. Capital" boundary.
        parts = re.split(r"(?<=[.!?])\s+(?=[a-z]\.\s+[A-Z])", text)
        parts = [q for p_ in parts
                 for q in re.split(r"(?<=[.!?])\s+(?=o\s+[A-Z][a-z]+:)", p_)]
        for n, p_ in enumerate(parts):
            p_ = p_.strip()
            if not p_:
                continue
            if re.match(r"^(?:[a-z]\.|o)\s+[A-Z]", p_):
                md.append("- " + re.sub(r"^(?:[a-z]\.|o)\s+", "", p_))
            elif state["bullet"] and n == 0:
                # continuation of the bullet we are inside; the source wraps
                # a single point across several lines
                md.append("- " + p_)
            else:
                md.append(p_)
        para.clear()
        state["bullet"] = False

    for b in blocks:
        if b["kind"] == "figure":
            flush()
            state["bullet"] = False
            # The caption is the label that reads like a sentence fragment,
            # not the first word that happens to sit inside the drawing:
            # the functional diagram's labels are Input, Output, Processing,
            # Storage and "Functional Diagram of a Computer".
            cands = [l.strip() for l in b.get("labels", [])
                     if 6 <= len(l.strip()) <= 70
                     and not re.fullmatch(r"[\d\s.,]+", l.strip())]
            caption = max(cands, key=lambda l: (l.count(" "), len(l)), default="")
            md.append(f"![{caption}]({FIG_URL}/{b['file']})")
            if caption:
                md.append(f"*{caption}*")
            continue

        t = b["text"]
        m = re.match(r"^(\d{1,2}\.\d{0,2}\.?\d{0,2}\.?)\s+(.*)$", t)
        if m and len(m.group(2)) < 120:
            flush()
            num, rest = m.group(1), m.group(2)
            # Headings in these notes run straight into the sentence that
            # follows them: "1.1. Functional Units of a Computer: A computer
            # performs...". Cut at the colon so the heading is a heading.
            head, sep, tail = rest.partition(": ")
            depth = num.rstrip(".").count(".")
            if sep and len(head) < 70:
                md.append(("#" * min(depth + 3, 5)) + f" {num} {head}")
                if tail.strip():
                    para.append(tail.strip())
            else:
                md.append(("#" * min(depth + 3, 5)) + f" {num} {rest}")
            continue
        # lettered sub-points (a. b. c.) and the "o" sub-bullets are separate
        # points in the source; run together they become a wall of text
        if re.match(r"^[a-z]\.\s+[A-Z]", t) or re.match(r"^o\s+[A-Z]", t):
            flush()
            state["bullet"] = True
            para.append(re.sub(r"^(?:[a-z]\.|o)\s+", "", t))
            continue
        if t.isupper() and len(t) < 60 and not md:
            continue
        if b["height"] >= 17 and len(t) < 60:
            flush()
            md.append("## " + t)
            continue
        if t.startswith("- "):
            flush()
            state["bullet"] = True
            para.append(t[2:])
            continue
        para.append(t)
    flush()

    # rejoin lines that a bullet ran onto
    out, i = [], 0
    while i < len(out) if False else i < len(md):
        out.append(md[i]); i += 1
    return "\n\n".join(out)


def main():
    pages = pickle.load(open("pages.pkl", "rb"))
    os.makedirs("out", exist_ok=True)

    sources = {
        "p1": ("O-Level Computer Science Notes, Part 1",
               "SBC/OL CSC, 2018", "OL_-_Notes_Part_1.pdf"),
        "p2": ("Form 5 Computer Science Notes, Part 2",
               "BGS/OL CSC, 2020", "F5_-_Notes_Part_2__BGS_.pdf"),
    }

    sections = []
    for tag, pglist in pages.items():
        title, attribution, filename = sources[tag]
        # A chapter starts on a page whose first real line is a lone number
        # followed by an all-capitals title, which is how both books are set.
        current = None
        for page in pglist:
            raw = build_blocks(page)
            # Chapter detection runs before the furniture is stripped: a
            # chapter opens with its number alone on a line, which the footer
            # stripper cannot tell from a page number and removes.
            texts = [b["text"] for b in raw if b["kind"] == "text"][:4]
            blocks = strip_furniture(raw)
            start = None
            for a, b in zip(texts, texts[1:]):
                if re.fullmatch(r"\d{1,2}", a.strip()) and b.isupper() and len(b) > 3:
                    start = (a.strip(), b.strip().title())
                    break
            if start or current is None:
                if current:
                    sections.append(current)
                current = {
                    "source": tag,
                    "source_title": title,
                    "attribution": attribution,
                    "chapter": start[0] if start else "",
                    "title": start[1] if start else title,
                    "page_from": page["number"],
                    "page_to": page["number"],
                    "blocks": [],
                }
            current["page_to"] = page["number"]
            current["blocks"] += blocks
        if current:
            sections.append(current)

    for s in sections:
        s["body"] = to_markdown(s["blocks"])
        del s["blocks"]

    sections = [s for s in sections if len(s["body"]) > 400]
    for i, s in enumerate(sections, 1):
        s["sequence"] = i
        print(f"{i:2d}. ch{s['chapter'] or '-':>2} {s['title'][:44]:46s} "
              f"p{s['page_from']}-{s['page_to']}  {len(s['body']):6d} chars  "
              f"{s['body'].count('![')} figures")

    pickle.dump(sections, open("sections.pkl", "wb"))
    for s in sections:
        fn = f"out/{s['sequence']:02d}-{re.sub(r'[^a-z0-9]+', '-', s['title'].lower()).strip('-')}.md"
        open(fn, "w", encoding="utf-8").write(f"# {s['title']}\n\n{s['body']}\n")


if __name__ == "__main__":
    main()
