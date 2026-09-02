"""Read a Cameroon progression sheet PDF into normalised rows.

pdfplumber's automatic table detection splits cells differently from page to
page on these documents, so the column edges are pinned explicitly. They are
identical on every page of a given sheet; only the sheets differ from one
another.
"""
import pdfplumber, re, json, sys

LAYOUT = {
    # x-edges, then which column holds what
    "form5": dict(
        xs=[31, 64, 104, 149, 207, 333, 450, 667, 724, 752, 780, 811],
        term=0, week=1, module=2, cat=3, stmt=4, title=5, obj=6,
        th=8, prac=9, dig=10),
    "l6": dict(
        xs=[25, 67, 106, 165, 237, 358, 628, 714, 742, 773, 808],
        term=0, week=1, module=2, cat=3, stmt=None, title=4, obj=5,
        th=7, prac=8, dig=9),
}

def unrot(cell):
    """The Module column is printed rotated. pdfplumber returns it as one glyph
    group per line, bottom-to-top; reversing the lines recovers the letters."""
    if not cell: return ""
    return re.sub(r"\s+", " ", "".join(reversed(cell.split("\n")))).strip()

def clean(c):
    return re.sub(r"[ \t]+", " ", (c or "").replace("\n", " ")).strip()

def read(path, layout):
    L = LAYOUT[layout]
    settings = {"vertical_strategy": "explicit", "explicit_vertical_lines": L["xs"],
                "horizontal_strategy": "lines"}
    rows = []
    with pdfplumber.open(path) as pdf:
        for pi, pg in enumerate(pdf.pages):
            for t in pg.extract_tables(settings):
                for r in t:
                    if len(r) < len(L["xs"]) - 1: continue
                    title = r[L["title"]] or ""
                    if clean(title).lower().startswith("lesson title"): continue
                    if clean(r[L["term"]]).lower() == "term": continue
                    rows.append({
                        "page": pi,
                        "term": clean(r[L["term"]]),
                        "week": clean(r[L["week"]]),
                        "module": unrot(r[L["module"]]),
                        "cat": clean(r[L["cat"]]),
                        "stmt": clean(r[L["stmt"]]) if L["stmt"] is not None else "",
                        "title": title,
                        "obj": r[L["obj"]] or "",
                        "th": bool(clean(r[L["th"]])),
                        "prac": bool(clean(r[L["prac"]])),
                        "dig": bool(clean(r[L["dig"]])),
                    })
    return rows

if __name__ == "__main__":
    print(json.dumps(read(sys.argv[1], sys.argv[2]), indent=1))
