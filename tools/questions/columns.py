"""Detect and split two-column exam pages from pdftotext -layout output."""
import re


def find_gutter(lines):
    """Return the character column of a vertical whitespace gutter, or None."""
    body = [ln for ln in lines if len(ln.strip()) > 3]
    if len(body) < 8:
        return None
    width = max(len(ln) for ln in body)
    if width < 60:
        return None
    lo, hi = int(width * 0.30), int(width * 0.70)
    best, best_score = None, 0
    for c in range(lo, hi):
        # a gutter needs whitespace in a band around c on nearly every line,
        # and real text on both sides of it
        band = range(max(c - 2, 0), c + 3)
        blank = sum(1 for ln in body if all(i >= len(ln) or ln[i] == " " for i in band))
        left = sum(1 for ln in body if ln[:c].strip())
        right = sum(1 for ln in body if len(ln) > c and ln[c:].strip())
        if blank / len(body) < 0.93:
            continue
        if left < len(body) * 0.25 or right < len(body) * 0.25:
            continue
        score = blank + min(left, right)
        if score > best_score:
            best, best_score = c, score
    return best


def split_page(text):
    """Return page text with columns linearised, or the original if single-column."""
    lines = text.split("\n")
    g = find_gutter(lines)
    if g is None:
        return dedent(text), False
    left = [ln[:g].rstrip() for ln in lines]
    right = [ln[g:].rstrip() for ln in lines]
    out = dedent("\n".join(left)) + "\n\n" + dedent("\n".join(right))
    return out, True


def dedent(text):
    """Strip the common leading indentation that -layout adds."""
    lines = text.split("\n")
    out = []
    for ln in lines:
        ln = ln.rstrip()
        # collapse big internal runs of spaces (layout padding) to one space,
        # but keep the line's own text intact
        ln = re.sub(r"\s{2,}", " ", ln.strip())
        out.append(ln)
    # drop runs of blank lines
    res, blank = [], 0
    for ln in out:
        if not ln:
            blank += 1
            if blank > 1:
                continue
        else:
            blank = 0
        res.append(ln)
    return "\n".join(res).strip()
