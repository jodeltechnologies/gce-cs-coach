# Where the course notes came from

Two of the school's own booklets:

- `OL_-_Notes_Part_1.pdf` — hardware, number systems, digital electronics, software
- `F5_-_Notes_Part_2__BGS_.pdf` — databases, information systems, algorithms,
  programming, the range and scope of computers

Eight chapters, about 190,000 characters, and 104 figures.

## The figures are the hard part

Pulling the embedded images out of these PDFs finds the photographs and misses
almost everything that matters. The functional diagram of a computer, the
instruction cycle, the memory hierarchy, every logic gate symbol, the flowchart
symbol table, the PERT chart — all of those are vector drawings made of lines
and boxes, not images, so there is nothing to extract.

So figures are found by how they sit on the page instead. `extract.py` reads
text positions from `pdftohtml -xml`, and looks for lines whose left edge is
one no other line shares: body text keeps returning to the same few margins,
while text inside a drawing sits wherever the drawing puts it. A run of such
lines is a figure. The band is then cropped straight out of a 150dpi render of
the page, which captures vector drawings, photographs and screenshots alike,
exactly as they appear in the booklet.

Genuinely empty bands are kept too, since a photograph carries no text of its
own for the alignment test to catch.

## Rebuilding

```bash
cd tools/notes
python3 -c "import extract, pickle; ..."   # see extract.py docstring
python3 assemble.py          # writes chapters/*.md and sections.pkl
python3 load_notes.py > ../../db/seed/05_notes.sql
cp figs/*.png ../../public/notes/figures/
```

`chapters/*.md` is the same text that goes into the database, kept here so the
extraction can be read and corrected without a database in front of you.

## What it does not do

Both booklets are set in two columns, so reading order is left column then
right. Getting that wrong produces text that looks plausible sentence by
sentence and is nonsense as a whole, which is why the column split is done on x
position rather than trusting the order text appears in the file.

Tables are captured as images rather than rebuilt as markup. The ASCII chart,
the storage unit table and the seven-segment truth table are all better read as
the printed page than as a reflowed HTML table, and rebuilding them would risk
silently changing a value.

The chapter numbered 8 in Part 2 runs on from chapter 7 without a page break,
so the two arrive as one section. That is how the booklet is laid out, not a
loss.
