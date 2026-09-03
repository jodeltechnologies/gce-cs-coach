# -*- coding: utf-8 -*-
"""All the student notes, in sheet order."""
import student_a, student_b, student_c  # noqa: F401  (each appends on import)
from student_a import NOTES

NOTES.sort(key=lambda n: (0 if n["form"] == "Form 5" else 1, n["no"]))
