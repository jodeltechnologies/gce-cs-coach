# -*- coding: utf-8 -*-
"""House style for the student notes, and a check that enforces it.

The rules, taken from the brief:

  * No em dashes, no semicolons, no ellipses.
  * No "not this, but that" constructions.
  * Plain words in place of formal ones where the plain word will do.
  * Traditional grammar, sentence lengths varied, no filler.
  * Nothing about examiners, mark schemes or losing marks. These notes are
    written for the student who is trying to understand the topic, not for a
    candidate being coached through a paper.

The last rule is the reason this file exists. Advice about what an examiner
wants belongs in a teacher's copy. Put it in front of a learner and the topic
stops being a thing worth knowing and becomes a thing worth guessing at.
"""
import re
import sys

BANNED_CHARS = {
    "\u2014": "em dash",
    "\u2013": "en dash",
    ";": "semicolon",
    "\u2026": "ellipsis",
}

BANNED_WORDS = [
    (r"\bexaminer", "examiner"),
    (r"\bmark scheme", "mark scheme"),
    (r"\blose (?:a |the )?marks?\b", "losing marks"),
    (r"\bearns? (?:the |a )?marks?\b", "earning marks"),
    (r"\bcarries? (?:a |the )?marks?\b", "carrying marks"),
    (r"\bin the exam\b", "exam coaching"),
    (r"\bcandidates?\b", "candidate"),
    (r"\bpast papers?\b", "past papers"),
    (r"\bfull marks?\b", "full marks"),
    (r"\bscores? (?:well|poorly|one|nothing)\b", "scoring talk"),
    (r"\bnot only\b.{0,40}\bbut\b", "not-only-but construction"),
    (r"\bdelve\b|\bleverage\b|\bseamless\b|\brobust solution\b|\bgame.chang",
     "marketing filler"),
]

# Words replaced by plainer ones throughout.
PLAIN = {
    "utilise": "use", "utilize": "use", "commence": "begin",
    "terminate": "end", "endeavour": "try", "ascertain": "find out",
    "sufficient": "enough", "numerous": "many", "purchase": "buy",
    "obtain": "get", "requires": "needs", "additional": "extra",
    "assist": "help", "demonstrate": "show", "component": "part",
    "utilising": "using", "facilitate": "help", "subsequently": "later",
    "prior to": "before", "in order to": "to", "a number of": "several",
}


def check(name, html):
    """Return a list of style problems in one note."""
    import html as _html
    # Entities such as &gt; end in a semicolon. Turn them back into
    # characters before checking, or every formula looks like a fault.
    text = _html.unescape(re.sub(r"<[^>]+>", " ", html))
    problems = []
    for ch, label in BANNED_CHARS.items():
        if ch in text:
            i = text.index(ch)
            problems.append(f"{label}: ...{text[max(0, i - 45):i + 45].strip()}...")
    low = text.lower()
    for pat, label in BANNED_WORDS:
        m = re.search(pat, low)
        if m:
            i = m.start()
            problems.append(f"{label}: ...{text[max(0, i - 45):i + 55].strip()}...")
    for formal, plain in PLAIN.items():
        if re.search(r"\b" + formal + r"\b", low):
            problems.append(f"formal word '{formal}', use '{plain}'")
    return problems


def check_all(notes):
    bad = 0
    for n in notes:
        html = n["html"]
        problems = check(n["title"], html)
        if problems:
            bad += 1
            print(f"\n[{n['form']} L{n['no']}] {n['title']}")
            for p in problems[:6]:
                print("   ", p)
    print(f"\n{len(notes)} notes checked, {bad} with problems.")
    return bad == 0


if __name__ == "__main__":
    import student_notes
    ok = check_all(student_notes.NOTES)
    sys.exit(0 if ok else 1)
