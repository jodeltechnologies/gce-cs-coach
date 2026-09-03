# Lesson notes

The notes the students read, and the figures that go with them.

    student_a.py, student_b.py, student_c.py   the notes themselves
    student_notes.py                           gathers them in sheet order
    figures.py                                 draws every diagram as SVG
    render_figures.mjs                         turns the SVG into PNG
    style.py                                   checks the house style
    emit_notes.py                              writes the SQL

## Rebuilding

    cd tools/notes
    python3 -c "import figures; [open('fig/%s.svg' % k, 'w').write(v) for k, v in figures.DIAGRAMS.items()]"
    node render_figures.mjs                    # writes fig/*.png
    cp fig/*.png ../../public/notes/figures/
    python3 style.py                           # must report 0 problems
    python3 emit_notes.py ../../db/seed/11_student_notes_term1.sql

## House style

`style.py` holds the rules and fails the build when they are broken. No em
dashes, no semicolons, no ellipses, plain words in place of formal ones, and
nothing about examiners or marks.

That last rule is the important one. Advice on what an examiner wants belongs
in a teacher's copy. Put it in front of a learner and the topic stops being
something worth knowing and becomes something worth guessing at.

## Figures

Drawn here rather than taken from the web. A photograph of a processor teaches
nothing that a labelled diagram does not teach better, and anything found
online would carry someone else's copyright into a classroom.
