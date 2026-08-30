#!/usr/bin/env python3
"""
Turn the school's O-Level Computer Science notes into readable lesson notes,
keeping the figures.

The hard part is the figures. Most of them are not embedded images at all —
the flowcharts, logic gate symbols, memory hierarchy and flowchart symbol
table are vector drawings made of lines and boxes, so pulling the embedded
images out of the PDF finds only the photographs and misses everything the
syllabus actually depends on.

So figures are found the other way round: by their absence. Text positions
come from pdftohtml's XML, the page is rendered at 200dpi, and any vertical
band inside a column that holds no text but sits between text is a figure. The
band is cropped straight out of the render. That catches vector drawings,
photographs and screenshots alike, and it captures them as they appear on the
page rather than as a reconstruction.

Both source PDFs are laid out in two columns, so reading order is left column
top to bottom, then right column. Getting that wrong scrambles the notes into
nonsense, which is why the column split is done on x position rather than
trusting the order the text appears in the file.
"""

import html
import os
import re
import subprocess
import sys
import xml.etree.ElementTree as ET
from collections import defaultdict

RENDER_DPI = 150
# A band must be this tall (in XML units) to count as a figure. Below this it
# is just paragraph spacing or a blank line.
MIN_FIGURE_HEIGHT = 46
# Captions in these notes are centred, underlined lines sitting directly under
# the drawing. Anything further away belongs to the body text.
CAPTION_GAP = 30


def run(cmd, **kw):
    return subprocess.run(cmd, shell=True, capture_output=True, text=True, **kw)


def parse_pages(pdf):
    """Text boxes with positions, per page."""
    r = run(f'pdftohtml -xml -stdout "{pdf}"')
    xml = r.stdout
    # poppler emits raw ampersands in some documents, which is not valid XML
    xml = re.sub(r"&(?!(amp|lt|gt|quot|apos|#\d+|#x[0-9a-fA-F]+);)", "&amp;", xml)
    root = ET.fromstring(xml)
    pages = []
    for pg in root.findall("page"):
        items = []
        for t in pg.findall("text"):
            txt = "".join(t.itertext())
            if not txt.strip():
                continue
            items.append({
                "top": int(t.get("top")),
                "left": int(t.get("left")),
                "width": int(t.get("width")),
                "height": int(t.get("height")),
                "font": t.get("font"),
                "bold": t.find("b") is not None,
                "italic": t.find("i") is not None,
                "text": html.unescape(txt),
            })
        pages.append({
            "number": int(pg.get("number")),
            "width": int(pg.get("width")),
            "height": int(pg.get("height")),
            "items": items,
        })
    return pages


def column_split(page):
    """Return the x boundary between the two columns, or None if single column."""
    lefts = [i["left"] for i in page["items"]]
    if len(lefts) < 12:
        return None
    mid = page["width"] / 2
    left_side = [x for x in lefts if x < mid]
    right_side = [x for x in lefts if x >= mid]
    # A real two-column page has substantial text on both sides and a clear
    # gutter: nothing starts within a band around the midpoint.
    if len(left_side) < 8 or len(right_side) < 8:
        return None
    return mid


def find_figures(page, col_items, col_left, col_right):
    """Bands of a column that hold a drawing rather than body text.

    Looking for empty bands is not enough. Most figures in these notes are
    vector drawings whose labels are real text — the functional diagram of a
    computer is three boxes containing the words Input, Processing and
    Storage — so the band is not empty at all and a whitespace scan walks
    straight past it.

    What separates them is alignment. Body text returns to one of a few left
    margins over and over: the column edge, the indent for a numbered
    subsection, the indent for a bullet. Text inside a drawing sits wherever
    the drawing puts it. So a line whose left edge is one nobody else shares
    is probably a label, and a run of such lines is a figure.
    """
    body = sorted(col_items, key=lambda i: i["top"])
    if len(body) < 4:
        return []

    margins = defaultdict(int)
    for i in body:
        margins[i["left"]] += 1
    common = {x for x, n in margins.items() if n >= 3}

    def is_flow(i):
        # Headings sit alone at their own indent but are not figure labels.
        if i["height"] >= 17:
            return True
        # Superscripts and subscripts (2^30, 10^6) sit at their own odd left
        # and would otherwise make every exponent look like a drawing.
        if i["height"] <= 11:
            return True
        return any(abs(i["left"] - m) <= 12 for m in common)

    page_top = min(i["top"] for i in body)
    page_bottom = max(i["top"] + i["height"] for i in body)

    def run_text(run):
        return [i["text"].strip() for i in run]

    bands, run = [], []
    for i in body:
        if is_flow(i):
            if run:
                bands.append(run)
                run = []
        else:
            run.append(i)
    if run:
        bands.append(run)

    figs = []
    for run in bands:
        top = min(i["top"] for i in run)
        bottom = max(i["top"] + i["height"] for i in run)
        # A drawing occupies more than one line. A run that sits on a single
        # baseline is a bold lead-in word followed by its sentence, which is
        # how these notes open most paragraphs.
        rows = {i["top"] // 9 for i in run}
        if len(rows) < 2 and bottom - top < MIN_FIGURE_HEIGHT:
            continue
        # The chapter title block at the head of a page is not a figure.
        if bottom < page_top + 90:
            continue
        # The running footer sits at the foot of every page; a band that
        # reaches it is justified body text that drifted, not a drawing.
        if bottom > page["height"] - 45:
            continue
        # Prose gives itself away by length. Drawing labels are words.
        if sum(len(t) for t in run_text(run)) > 130:
            continue
        # widen to swallow the whitespace the drawing sits in
        above = [i["top"] + i["height"] for i in body if i["top"] + i["height"] <= top]
        below = [i["top"] for i in body if i["top"] >= bottom]
        top = max(above) + 2 if above else top
        bottom = min(below) - 2 if below else bottom
        # Widening can swallow a line of body text that happens to sit in the
        # same band, which then appears as a stray sentence pasted across the
        # top of the drawing. Pull the edges back off any flow line.
        for i in body:
            if not is_flow(i):
                continue
            i_top, i_bot = i["top"], i["top"] + i["height"]
            if i_bot <= top or i_top >= bottom:
                continue
            first = min(x["top"] for x in run)
            last = max(x["top"] + x["height"] for x in run)
            if i_bot <= first:
                top = max(top, i_bot + 2)
            elif i_top >= last:
                bottom = min(bottom, i_top - 2)
        if bottom - top < 24:
            continue
        figs.append({
            "top": top,
            "bottom": bottom,
            "left": col_left,
            "right": col_right,
            "labels": [i["text"].strip() for i in run],
        })

    # Also keep genuinely empty bands: photographs and screenshots carry no
    # text of their own, so the alignment test cannot see them.
    for a, b in zip(body, body[1:]):
        gap_top = a["top"] + a["height"]
        gap_bottom = b["top"]
        if gap_bottom - gap_top < MIN_FIGURE_HEIGHT:
            continue
        if gap_bottom > page_bottom - 20:
            continue
        if any(f["top"] <= gap_top and f["bottom"] >= gap_bottom for f in figs):
            continue
        figs.append({
            "top": gap_top, "bottom": gap_bottom,
            "left": col_left, "right": col_right, "labels": [],
        })

    # Two runs separated by one line of flow text are one drawing with a
    # caption through the middle, not two drawings.
    figs.sort(key=lambda f: f["top"])
    merged = []
    for f in figs:
        if merged and f["top"] <= merged[-1]["bottom"] + 8:
            merged[-1]["bottom"] = max(merged[-1]["bottom"], f["bottom"])
            merged[-1]["labels"] += f["labels"]
        else:
            merged.append(f)
    return merged


def crop_figures(pdf, pages, outdir, prefix):
    """Render each page once and cut every figure band out of it."""
    from PIL import Image
    os.makedirs(outdir, exist_ok=True)
    made = []
    for page in pages:
        figs = page.get("figures") or []
        if not figs:
            continue
        n = page["number"]
        run(f'pdftocairo -png -r {RENDER_DPI} -f {n} -l {n} '
            f'-singlefile "{pdf}" /tmp/pg')
        if not os.path.exists("/tmp/pg.png"):
            continue
        img = Image.open("/tmp/pg.png")
        sx = img.width / page["width"]
        sy = img.height / page["height"]
        for k, f in enumerate(figs):
            pad = 6
            box = (
                max(int(f["left"] * sx) - pad, 0),
                max(int(f["top"] * sy) - pad, 0),
                min(int(f["right"] * sx) + pad, img.width),
                min(int(f["bottom"] * sy) + pad, img.height),
            )
            if box[2] - box[0] < 40 or box[3] - box[1] < 30:
                continue
            crop = img.crop(box)
            # A band that is entirely blank is paragraph spacing the gap
            # detector mistook for a drawing. Drop it rather than ship a
            # white rectangle into the notes.
            grey = crop.convert("L")
            hist = grey.histogram()
            dark = sum(hist[:200])
            if dark < (crop.width * crop.height) * 0.004:
                continue
            name = f"{prefix}-p{n:03d}-{k}.png"
            crop.save(os.path.join(outdir, name), optimize=True)
            f["file"] = name
            made.append(name)
        os.remove("/tmp/pg.png")
    return made


def caption_for(fig):
    """The centred line under a drawing is its caption in these notes."""
    b = fig["before"]
    if b["top"] - fig["bottom"] > CAPTION_GAP:
        return None
    text = b["text"].strip()
    if len(text) > 80 or len(text) < 3:
        return None
    # body text starts at the column margin; captions are centred, so they
    # start well inside it
    if b["left"] - fig["left"] < 18:
        return None
    return text
