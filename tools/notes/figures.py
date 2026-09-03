# -*- coding: utf-8 -*-
"""Diagrams for the lesson notes.

Drawn here rather than fetched from the web. A photograph of a processor
teaches nothing that a labelled block diagram does not teach better, and
anything found online would carry someone else's copyright into a document
meant for classroom use.

Each diagram uses the same colours as the notes so that the page holds
together: navy for structure, gold for the thing being emphasised, grey for
supporting detail.
"""

NAVY = "#10192B"
GOLD = "#8A6A00"
GOLDBG = "#FBF4E0"
MUTED = "#5A6B85"
RULE = "#C9D3E0"
SOFT = "#F4F7FB"
RED = "#A33A3A"
REDBG = "#FBEFEF"
WHITE = "#FFFFFF"

FONT = "Segoe UI, Calibri, Helvetica, Arial, sans-serif"
MONO = "Consolas, DejaVu Sans Mono, monospace"

DIAGRAMS = {}


def svg(name, width, height, body):
    DIAGRAMS[name] = (
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" '
        f'height="{height}" viewBox="0 0 {width} {height}" '
        f'font-family="{FONT}">'
        f'<rect width="{width}" height="{height}" fill="{WHITE}"/>'
        f'{body}</svg>'
    )


def box(x, y, w, h, fill=SOFT, stroke=RULE, r=6, sw=1.4):
    return (f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{r}" '
            f'fill="{fill}" stroke="{stroke}" stroke-width="{sw}"/>')


def txt(x, y, s, size=15, fill=NAVY, anchor="middle", weight="normal",
        font=None, style="normal"):
    return (f'<text x="{x}" y="{y}" font-size="{size}" fill="{fill}" '
            f'text-anchor="{anchor}" font-weight="{weight}" '
            f'font-style="{style}" '
            f'font-family="{font or FONT}">{s}</text>')


def arrow(x1, y1, x2, y2, color=NAVY, w=2, marker="a"):
    return (f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="{color}" '
            f'stroke-width="{w}" marker-end="url(#{marker})"/>')


DEFS = (
    f'<defs>'
    f'<marker id="a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" '
    f'markerHeight="7" orient="auto-start-reverse">'
    f'<path d="M 0 0 L 10 5 L 0 10 z" fill="{NAVY}"/></marker>'
    f'<marker id="g" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" '
    f'markerHeight="7" orient="auto-start-reverse">'
    f'<path d="M 0 0 L 10 5 L 0 10 z" fill="{GOLD}"/></marker>'
    f'<marker id="m" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" '
    f'markerHeight="7" orient="auto-start-reverse">'
    f'<path d="M 0 0 L 10 5 L 0 10 z" fill="{MUTED}"/></marker>'
    f'</defs>'
)

# =====================================================================
# 1. AI, machine learning and deep learning as nested circles
# =====================================================================
svg("ai_circles", 900, 420, DEFS +
    f'<ellipse cx="330" cy="195" rx="300" ry="158" fill="{SOFT}" '
    f'stroke="{NAVY}" stroke-width="2"/>'
    f'<ellipse cx="360" cy="200" rx="205" ry="115" fill="{GOLDBG}" '
    f'stroke="{GOLD}" stroke-width="2"/>'
    f'<ellipse cx="392" cy="205" rx="110" ry="72" fill="{WHITE}" '
    f'stroke="{MUTED}" stroke-width="2"/>'
    + txt(160, 78, "Artificial intelligence", 17, NAVY, "middle", "bold")
    + txt(255, 130, "Machine learning", 16, GOLD, "middle", "bold")
    + txt(392, 200, "Deep", 15, MUTED, "middle", "bold")
    + txt(392, 220, "learning", 15, MUTED, "middle", "bold")
    + txt(690, 120, "Any technique that makes a machine", 14, MUTED, "start")
    + txt(690, 141, "behave intelligently, including plain", 14, MUTED, "start")
    + txt(690, 162, "rules with no learning at all.", 14, MUTED, "start")
    + txt(690, 205, "Learns its rules from data instead", 14, MUTED, "start")
    + txt(690, 226, "of being given them.", 14, MUTED, "start")
    + txt(690, 269, "Machine learning using neural", 14, MUTED, "start")
    + txt(690, 290, "networks with many layers.", 14, MUTED, "start")
    + f'<line x1="640" y1="140" x2="675" y2="140" stroke="{RULE}" stroke-width="2"/>'
    + f'<line x1="640" y1="215" x2="675" y2="215" stroke="{RULE}" stroke-width="2"/>'
    + f'<line x1="640" y1="280" x2="675" y2="280" stroke="{RULE}" stroke-width="2"/>'
    + txt(450, 400, "Every deep learning system is machine learning. Every machine "
          "learning system is AI. The reverse is not true.", 14, NAVY, "middle",
          "normal", None, "italic"))

# =====================================================================
# 2. The four parts of a prompt
# =====================================================================
_parts = [("Role", "Who the tool should be", "You are a Form 5\nComputer Science teacher."),
          ("Task", "What you want done", "Explain data validation."),
          ("Context", "Who it is for", "For a student who has\njust met databases."),
          ("Format", "How it should come back", "Five bullet points,\nunder 150 words.")]
_b = ""
for i, (h, sub, ex) in enumerate(_parts):
    x = 30 + i * 215
    _b += box(x, 60, 195, 190, WHITE, NAVY if i == 0 else RULE, 8, 1.6)
    _b += box(x, 60, 195, 40, GOLDBG, GOLD, 8, 1.4)
    _b += f'<rect x="{x}" y="88" width="195" height="12" fill="{GOLDBG}"/>'
    _b += txt(x + 97, 87, h, 17, GOLD, "middle", "bold")
    _b += txt(x + 97, 122, sub, 13, MUTED)
    for j, line in enumerate(ex.split("\n")):
        _b += txt(x + 97, 160 + j * 22, line, 13.5, NAVY, "middle", "normal", MONO)
    if i < 3:
        _b += f'<text x="{x + 203}" y="160" font-size="20" fill="{RULE}">+</text>'
svg("prompt_parts", 900, 300, DEFS + _b
    + txt(450, 285, "Leave a part out and the tool fills the gap with a guess.",
          14, MUTED, "middle", "normal", None, "italic"))

# =====================================================================
# 3. The five generations
# =====================================================================
_gen = [("First", "1945-55", "Vacuum tube", "Filled a room"),
        ("Second", "1955-65", "Transistor", "Room to cupboard"),
        ("Third", "1965-80", "Integrated circuit", "Cupboard to desk"),
        ("Fourth", "1980-", "Microprocessor", "Desk to hand"),
        ("Fifth", "now", "AI, parallel", "Hand to everywhere")]
_b = f'<line x1="45" y1="150" x2="855" y2="150" stroke="{RULE}" stroke-width="3"/>'
for i, (g, yr, comp, size) in enumerate(_gen):
    x = 60 + i * 165
    _b += f'<circle cx="{x + 72}" cy="150" r="9" fill="{GOLD}"/>'
    _b += box(x, 30, 144, 95, SOFT, RULE, 6)
    _b += txt(x + 72, 55, g, 15, NAVY, "middle", "bold")
    _b += txt(x + 72, 76, yr, 13, MUTED)
    _b += txt(x + 72, 104, comp, 13.5, GOLD, "middle", "bold")
    _b += txt(x + 72, 195, size, 13, MUTED)
_b += box(60, 225, 780, 46, GOLDBG, GOLD, 6)
_b += txt(450, 254, "Smaller  ·  Faster  ·  Cheaper  ·  Cooler  ·  More reliable",
          16, GOLD, "middle", "bold")
svg("generations", 900, 300, DEFS + _b)

# =====================================================================
# 4. Von Neumann against Harvard
# =====================================================================
_b = ""
# Von Neumann
_b += txt(215, 32, "Von Neumann", 17, NAVY, "middle", "bold")
_b += box(140, 55, 150, 52, SOFT, RULE)
_b += txt(215, 87, "CPU", 16, NAVY, "middle", "bold")
_b += box(140, 215, 150, 62, SOFT, RULE)
_b += txt(215, 240, "One memory", 14, NAVY)
_b += txt(215, 260, "code + data", 13, MUTED)
_b += f'<line x1="215" y1="107" x2="215" y2="215" stroke="{RED}" stroke-width="7"/>'
_b += txt(305, 155, "one bus", 13, RED, "start", "bold")
_b += txt(305, 175, "they take turns", 12.5, RED, "start")
_b += box(105, 300, 220, 40, REDBG, RED, 6)
_b += txt(215, 325, "Von Neumann bottleneck", 14, RED, "middle", "bold")
# divider
_b += f'<line x1="450" y1="20" x2="450" y2="350" stroke="{RULE}" stroke-width="1.5" stroke-dasharray="5 5"/>'
# Harvard
_b += txt(680, 32, "Harvard", 17, NAVY, "middle", "bold")
_b += box(605, 55, 150, 52, SOFT, RULE)
_b += txt(680, 87, "CPU", 16, NAVY, "middle", "bold")
_b += box(520, 215, 140, 62, SOFT, RULE)
_b += txt(590, 240, "Instruction", 14, NAVY)
_b += txt(590, 260, "memory", 14, NAVY)
_b += box(700, 215, 140, 62, SOFT, RULE)
_b += txt(770, 240, "Data", 14, NAVY)
_b += txt(770, 260, "memory", 14, NAVY)
_b += f'<line x1="640" y1="107" x2="590" y2="215" stroke="{GOLD}" stroke-width="6"/>'
_b += f'<line x1="720" y1="107" x2="770" y2="215" stroke="{GOLD}" stroke-width="6"/>'
_b += box(570, 300, 220, 40, GOLDBG, GOLD, 6)
_b += txt(680, 325, "Two buses, both move at once", 14, GOLD, "middle", "bold")
svg("vn_harvard", 900, 365, DEFS + _b)

# =====================================================================
# 5. The three kinds of machine learning
# =====================================================================
_ml = [("Supervised", "Labelled data", "Every example carries\nthe right answer.",
        "Spam filtering,\ncredit scoring"),
       ("Unsupervised", "Unlabelled data", "No answers given. It finds\nthe groupings itself.",
        "Grouping customers,\nspotting oddities"),
       ("Reinforcement", "No data set", "It acts, then gets a reward\nor a penalty.",
        "Games,\nrobot control")]
_b = ""
for i, (h, d, how, use) in enumerate(_ml):
    x = 25 + i * 288
    _b += box(x, 25, 265, 265, WHITE, NAVY, 8, 1.6)
    _b += box(x, 25, 265, 46, GOLDBG, GOLD, 8, 1.4)
    _b += f'<rect x="{x}" y="58" width="265" height="13" fill="{GOLDBG}"/>'
    _b += txt(x + 132, 55, h, 17, GOLD, "middle", "bold")
    _b += txt(x + 132, 97, d, 14.5, NAVY, "middle", "bold")
    for j, line in enumerate(how.split("\n")):
        _b += txt(x + 132, 130 + j * 21, line, 13.5, MUTED)
    _b += f'<line x1="{x + 40}" y1="192" x2="{x + 225}" y2="192" stroke="{RULE}" stroke-width="1.4"/>'
    for j, line in enumerate(use.split("\n")):
        _b += txt(x + 132, 222 + j * 21, line, 13.5, NAVY)
svg("ml_types", 900, 320, DEFS + _b
    + txt(450, 310, "The question that divides them: does the training data carry "
          "labels?", 14, MUTED, "middle", "normal", None, "italic"))

# =====================================================================
# 6. Four types of computer
# =====================================================================
_b = ""
_rows = [("Supercomputer", "One vast calculation at the greatest possible speed.",
          "Weather, nuclear research, training large AI models", 700),
         ("Mainframe", "Millions of small transactions, without stopping.",
          "Banking, airline booking, tax and census", 560),
         ("Minicomputer", "A department or a medium organisation.",
          "Departmental servers, small business systems", 420),
         ("Microcomputer", "One user at a time.",
          "Desktops, laptops, tablets, phones", 280)]
for i, (n, p, ex, w) in enumerate(_rows):
    y = 25 + i * 82
    x = 450 - w / 2
    _b += box(x, y, w, 66, GOLDBG if i == 0 else SOFT, GOLD if i == 0 else RULE, 6)
    _b += txt(450, y + 27, n, 16, NAVY, "middle", "bold")
    _b += txt(450, y + 50, p, 13.5, MUTED)
_b += f'<line x1="60" y1="30" x2="60" y2="345" stroke="{RULE}" stroke-width="2" marker-end="url(#m)"/>'
_b += (f'<text x="46" y="190" font-size="13.5" fill="{MUTED}" text-anchor="middle" '
       f'transform="rotate(-90 46 190)">size, power and cost fall</text>')
svg("computer_types", 900, 375, DEFS + _b
    + txt(450, 368, "A bank needs a mainframe, not a supercomputer, however rich the "
          "bank is.", 14, GOLD, "middle", "bold"))

# =====================================================================
# 7. Input, process, output, storage
# =====================================================================
_b = ""
_b += box(40, 100, 175, 90, SOFT, RULE)
_b += txt(127, 132, "INPUT", 16, NAVY, "middle", "bold")
_b += txt(127, 156, "keyboard, scanner,", 12.5, MUTED)
_b += txt(127, 174, "sensor, camera", 12.5, MUTED)
_b += box(330, 100, 195, 90, GOLDBG, GOLD, 6, 1.8)
_b += txt(427, 132, "PROCESS", 16, GOLD, "middle", "bold")
_b += txt(427, 156, "CPU: control unit,", 12.5, MUTED)
_b += txt(427, 174, "ALU, registers", 12.5, MUTED)
_b += box(640, 100, 175, 90, SOFT, RULE)
_b += txt(727, 132, "OUTPUT", 16, NAVY, "middle", "bold")
_b += txt(727, 156, "monitor, printer,", 12.5, MUTED)
_b += txt(727, 174, "speaker, actuator", 12.5, MUTED)
_b += box(300, 265, 255, 82, SOFT, RULE)
_b += txt(427, 295, "STORAGE", 16, NAVY, "middle", "bold")
_b += txt(427, 318, "primary: RAM, ROM, cache", 12.5, MUTED)
_b += txt(427, 336, "secondary: disk, SSD, flash", 12.5, MUTED)
_b += arrow(220, 145, 325, 145)
_b += arrow(530, 145, 635, 145)
_b += arrow(427, 195, 427, 260, MUTED, 2, "m")
_b += arrow(470, 260, 470, 197, MUTED, 2, "m")
_b += txt(497, 232, "saved", 12, MUTED, "start")
_b += txt(345, 232, "loaded", 12, MUTED, "end")
svg("ipos", 900, 375, DEFS
    + txt(450, 45, "Every computer is these four things, arranged this way",
          16, NAVY, "middle", "bold") + _b)

# =====================================================================
# 8. Memory hierarchy
# =====================================================================
_b = ""
_lv = [("Registers", "inside the CPU", "a few dozen words", 200),
       ("Cache", "beside the CPU, L1 L2 L3", "kilobytes to megabytes", 340),
       ("RAM", "on the motherboard", "4 to 32 gigabytes", 480),
       ("Secondary storage", "disk, SSD, flash", "terabytes", 620)]
for i, (n, where, size, w) in enumerate(_lv):
    y = 35 + i * 78
    x = 330 - w / 2
    fill = GOLDBG if i == 0 else SOFT
    _b += box(x, y, w, 62, fill, GOLD if i == 0 else RULE, 6)
    _b += txt(330, y + 27, n, 15.5, NAVY, "middle", "bold")
    _b += txt(330, y + 48, where, 12.5, MUTED)
    _b += txt(690, y + 27, size, 13.5, MUTED, "start")
_b += f'<line x1="680" y1="40" x2="680" y2="345" stroke="{RULE}" stroke-width="1.4"/>'
_b += arrow(60, 340, 60, 45, GOLD, 2, "g")
_b += (f'<text x="44" y="195" font-size="13" fill="{GOLD}" text-anchor="middle" '
       f'transform="rotate(-90 44 195)">faster, smaller, dearer per byte</text>')
svg("memory_pyramid", 900, 375, DEFS + _b
    + txt(330, 366, "The closer to the processor, the faster and the smaller.",
          14, MUTED, "middle", "normal", None, "italic"))

# =====================================================================
# 9. The machine instruction cycle
# =====================================================================
_b = ""
_st = [("FETCH", ["PC address goes to MAR.", "Instruction comes back into",
                  "MDR, then into CIR.", "PC moves on by one."]),
       ("DECODE", ["The control unit works out", "what the instruction means",
                   "and what data it needs."]),
       ("EXECUTE", ["The ALU does the sum or the", "comparison. The result lands",
                    "in the accumulator."]),
       ("STORE", ["Where a result must be kept,", "it is written back to memory.",
                  "Then the cycle begins again."])]
for i, (h, lines) in enumerate(_st):
    x = 25 + i * 220
    _b += box(x, 60, 196, 175, WHITE, GOLD if i == 0 else NAVY, 8, 1.6)
    _b += box(x, 60, 196, 40, GOLDBG if i == 0 else SOFT, GOLD if i == 0 else RULE, 8, 1.4)
    _b += f'<rect x="{x}" y="86" width="196" height="14" fill="{GOLDBG if i == 0 else SOFT}"/>'
    _b += txt(x + 98, 87, h, 16, GOLD if i == 0 else NAVY, "middle", "bold")
    for j, ln in enumerate(lines):
        _b += txt(x + 98, 128 + j * 22, ln, 12.5, MUTED)
    if i < 3:
        _b += arrow(x + 200, 148, x + 218, 148)
_b += f'<path d="M 781 240 L 781 265 L 123 265 L 123 240" fill="none" stroke="{MUTED}" stroke-width="1.8" stroke-dasharray="6 4" marker-end="url(#m)"/>'
svg("cpu_cycle", 900, 300, DEFS
    + txt(450, 35, "The loop every computer runs, billions of times a second",
          16, NAVY, "middle", "bold") + _b
    + txt(450, 290, "and round again", 13, MUTED, "middle", "normal", None, "italic"))

# =====================================================================
# 10. Flynn's classification
# =====================================================================
_b = ""
_b += txt(300, 32, "Single data stream", 14, MUTED, "middle", "bold")
_b += txt(600, 32, "Multiple data streams", 14, MUTED, "middle", "bold")
_b += (f'<text x="42" y="140" font-size="14" fill="{MUTED}" text-anchor="middle" '
       f'font-weight="bold" transform="rotate(-90 42 140)">One instruction</text>')
_b += (f'<text x="42" y="270" font-size="14" fill="{MUTED}" text-anchor="middle" '
       f'font-weight="bold" transform="rotate(-90 42 270)">Many instructions</text>')
_cells = [("SISD", "One instruction on one\npiece of data.",
           "The ordinary single-core\ncomputer.", 160, 55, SOFT, RULE),
          ("SIMD", "The same instruction on\nmany pieces of data at once.",
           "A GPU treating every pixel\nthe same way.", 460, 55, GOLDBG, GOLD),
          ("MISD", "Several instructions on\nthe same data.",
           "Rare. Flight control, where\nresults are cross-checked.", 160, 190, SOFT, RULE),
          ("MIMD", "Independent processors on\nindependent data.",
           "Multi-core machines\nand clusters.", 460, 190, SOFT, RULE)]
for h, d, ex, x, y, fill, stroke in _cells:
    _b += box(x, y, 280, 120, fill, stroke, 6, 1.6)
    _b += txt(x + 140, y + 30, h, 17, NAVY, "middle", "bold")
    for j, ln in enumerate(d.split("\n")):
        _b += txt(x + 140, y + 55 + j * 19, ln, 12.5, MUTED)
    for j, ln in enumerate(ex.split("\n")):
        _b += txt(x + 140, y + 97 + j * 17, ln, 12, NAVY, "middle", "normal", None, "italic")
svg("flynn", 900, 330, DEFS + _b)

# =====================================================================
# 11. Storage units ladder
# =====================================================================
_b = ""
_u = ["bit", "nibble (4 bits)", "byte (8 bits)", "kilobyte", "megabyte",
      "gigabyte", "terabyte", "petabyte"]
for i, u in enumerate(_u):
    y = 300 - i * 36
    w = 130 + i * 18
    _b += box(300 - w / 2 + 130, y, w, 28, GOLDBG if i >= 3 else SOFT,
              GOLD if i >= 3 else RULE, 4)
    _b += txt(430, y + 19, u, 13.5, NAVY, "middle", "bold" if i >= 3 else "normal")
    if i >= 3:
        _b += txt(650, y + 19, "x 1024", 13, GOLD, "start", "bold", MONO)
_b += f'<line x1="628" y1="45" x2="628" y2="300" stroke="{RULE}" stroke-width="1.4"/>'
_b += arrow(180, 300, 180, 48, GOLD, 2, "g")
_b += (f'<text x="164" y="175" font-size="13" fill="{GOLD}" text-anchor="middle" '
       f'transform="rotate(-90 164 175)">divide going up</text>')
_b += arrow(240, 48, 240, 300, MUTED, 2, "m")
_b += (f'<text x="256" y="175" font-size="13" fill="{MUTED}" text-anchor="middle" '
       f'transform="rotate(-90 256 175)">multiply going down</text>')
svg("units_ladder", 900, 385, DEFS
    + txt(430, 28, "Storage steps in 1024. Processing steps in 1000.",
          15.5, NAVY, "middle", "bold") + _b
    + box(300, 336, 500, 38, REDBG, RED, 6)
    + txt(550, 361, "b is a bit.  B is a byte.  8 bits make 1 byte.", 14, RED,
          "middle", "bold"))

# =====================================================================
# 12. A Gantt chart for FCFS
# =====================================================================
_b = ""
_procs = [("P1", 0, 6, 0), ("P2", 6, 3, 1), ("P3", 9, 1, 2), ("P4", 10, 4, 3)]
SC = 55
X0 = 90
for n, start, burst, arr in _procs:
    x = X0 + start * SC
    w = burst * SC
    _b += box(x, 70, w, 58, GOLDBG if n == "P3" else SOFT,
              GOLD if n == "P3" else RULE, 4, 1.6)
    _b += txt(x + w / 2, 106, n, 16, NAVY, "middle", "bold")
for t in range(0, 15):
    x = X0 + t * SC
    _b += f'<line x1="{x}" y1="128" x2="{x}" y2="138" stroke="{RULE}" stroke-width="1.4"/>'
    _b += txt(x, 158, str(t), 12.5, MUTED)
_b += f'<line x1="{X0}" y1="128" x2="{X0 + 14 * SC}" y2="128" stroke="{RULE}" stroke-width="1.4"/>'
_b += txt(X0 - 18, 106, "CPU", 13.5, MUTED, "end", "bold")
_b += txt(X0 - 18, 158, "time", 13, MUTED, "end")
_b += box(90, 190, 770, 105, SOFT, RULE, 6)
_b += txt(115, 218, "Waiting time  =  start time  -  arrival time", 14.5, NAVY, "start", "bold")
_b += txt(115, 246, "P1 = 0 - 0 = 0        P2 = 6 - 1 = 5        P3 = 9 - 2 = 7        P4 = 10 - 3 = 7",
          14, MUTED, "start", "normal", MONO)
_b += txt(115, 276, "Average  =  (0 + 5 + 7 + 7) / 4  =  4.75", 14.5, GOLD, "start", "bold")
svg("gantt", 900, 345, DEFS
    + txt(450, 40, "First Come First Served, and the convoy effect", 16, NAVY,
          "middle", "bold") + _b
    + txt(450, 328, "P3 needed one unit of time and waited seven, because P1 sat "
          "in front of it.", 13.5, MUTED, "middle", "normal", None, "italic"))

# =====================================================================
# 13. Buffering against spooling
# =====================================================================
_b = ""
_b += txt(225, 35, "Buffering", 17, GOLD, "middle", "bold")
_b += txt(225, 58, "in memory, one flowing stream", 13, MUTED)
_b += box(80, 80, 110, 52, SOFT, RULE)
_b += txt(135, 112, "Network", 14, NAVY)
_b += box(230, 80, 110, 52, GOLDBG, GOLD)
_b += txt(285, 105, "Buffer", 14, GOLD, "middle", "bold")
_b += txt(285, 124, "in RAM", 11.5, MUTED)
_b += box(380, 80, 110, 52, SOFT, RULE)
_b += txt(435, 112, "Screen", 14, NAVY)
_b += arrow(193, 106, 227, 106)
_b += arrow(343, 106, 377, 106)
_b += txt(225, 165, "Data arrives unevenly. It leaves at a steady rate.", 13, MUTED)
_b += f'<line x1="545" y1="20" x2="545" y2="300" stroke="{RULE}" stroke-width="1.5" stroke-dasharray="5 5"/>'
_b += txt(722, 35, "Spooling", 17, GOLD, "middle", "bold")
_b += txt(722, 58, "on disk, a queue of whole jobs", 13, MUTED)
for i in range(3):
    _b += box(590, 80 + i * 34, 92, 27, SOFT, RULE, 4)
    _b += txt(636, 99 + i * 34, f"job {i + 1}", 12.5, NAVY)
_b += box(700, 80, 96, 95, GOLDBG, GOLD)
_b += txt(748, 118, "Spool", 13.5, GOLD, "middle", "bold")
_b += txt(748, 137, "on disk", 11.5, MUTED)
_b += box(812, 100, 74, 55, SOFT, RULE)
_b += txt(849, 125, "Printer", 13, NAVY)
_b += txt(849, 143, "slow", 11.5, MUTED)
_b += arrow(686, 128, 697, 128)
_b += arrow(799, 128, 809, 128)
_b += txt(722, 200, "You send five documents and go back to work at once.", 13, MUTED)
svg("buffer_spool", 900, 230, DEFS + _b)

# =====================================================================
# 14. Virtual memory
# =====================================================================
_b = ""
_b += box(90, 70, 290, 150, SOFT, RULE, 6, 1.6)
_b += txt(235, 100, "RAM", 17, NAVY, "middle", "bold")
_b += txt(235, 122, "fast, small, volatile", 13, MUTED)
for i in range(4):
    _b += box(115 + i * 63, 145, 52, 46, GOLDBG if i < 3 else WHITE,
              GOLD if i < 3 else RULE, 4)
    if i < 3:
        _b += txt(141 + i * 63, 174, f"page", 12, GOLD)
_b += box(520, 70, 290, 150, SOFT, RULE, 6, 1.6)
_b += txt(665, 100, "Secondary storage", 17, NAVY, "middle", "bold")
_b += txt(665, 122, "slow, large, permanent", 13, MUTED)
_b += box(545, 145, 240, 46, WHITE, RULE, 4)
_b += txt(665, 174, "swap file, pages waiting", 13, MUTED)
_b += arrow(385, 150, 514, 150, GOLD, 2.4, "g")
_b += arrow(514, 185, 385, 185, GOLD, 2.4, "g")
_b += txt(450, 141, "swapped out", 12.5, GOLD)
_b += txt(450, 208, "swapped in", 12.5, GOLD)
svg("virtual_memory", 900, 300, DEFS
    + txt(450, 38, "Virtual memory: disk borrowed and used as though it were RAM",
          15.5, NAVY, "middle", "bold") + _b
    + box(200, 245, 500, 42, REDBG, RED, 6)
    + txt(450, 271, "Too much swapping and the machine crawls. That is thrashing.",
          14, RED, "middle", "bold"))

# =====================================================================
# 15. The ergonomic workstation
# =====================================================================
_b = ""
_b += f'<line x1="120" y1="330" x2="800" y2="330" stroke="{MUTED}" stroke-width="2.5"/>'
_b += f'<rect x="330" y="232" width="330" height="9" fill="{MUTED}"/>'
_b += f'<rect x="352" y="241" width="9" height="89" fill="{MUTED}"/>'
_b += f'<rect x="630" y="241" width="9" height="89" fill="{MUTED}"/>'
_b += box(455, 95, 165, 112, SOFT, NAVY, 4, 1.8)
_b += f'<rect x="525" y="207" width="24" height="25" fill="{MUTED}"/>'
_b += f'<rect x="495" y="232" width="84" height="7" fill="{MUTED}"/>'
_b += f'<rect x="360" y="222" width="105" height="10" rx="3" fill="{NAVY}"/>'
_b += f'<circle cx="500" cy="320" r="16" fill="none" stroke="{MUTED}" stroke-width="2"/>'
_b += f'<rect x="215" y="200" width="88" height="12" rx="4" fill="{NAVY}"/>'
_b += f'<rect x="252" y="212" width="10" height="70" fill="{MUTED}"/>'
_b += f'<rect x="222" y="282" width="72" height="9" rx="3" fill="{MUTED}"/>'
_b += f'<path d="M 262 200 L 262 150 L 300 150" fill="none" stroke="{NAVY}" stroke-width="10" stroke-linecap="round"/>'
_b += f'<circle cx="300" cy="128" r="21" fill="none" stroke="{NAVY}" stroke-width="3"/>'
_b += f'<path d="M 300 150 L 340 205" fill="none" stroke="{NAVY}" stroke-width="6" stroke-linecap="round"/>'
_b += f'<path d="M 262 282 L 262 315 L 300 315" fill="none" stroke="{NAVY}" stroke-width="6" stroke-linecap="round"/>'
_b += f'<line x1="322" y1="128" x2="450" y2="140" stroke="{GOLD}" stroke-width="1.6" stroke-dasharray="5 4"/>'
_b += txt(720, 118, "Top of screen at or just", 13, GOLD, "start", "bold")
_b += txt(720, 136, "below eye level", 13, GOLD, "start", "bold")
_b += txt(720, 168, "About an arm's length away", 13, MUTED, "start")
_b += txt(720, 196, "Elbows at a right angle,", 13, MUTED, "start")
_b += txt(720, 214, "wrists straight", 13, MUTED, "start")
_b += txt(720, 246, "Lower back supported", 13, MUTED, "start")
_b += txt(720, 278, "Feet flat, thighs level", 13, MUTED, "start")
_b += f'<line x1="700" y1="100" x2="700" y2="290" stroke="{RULE}" stroke-width="1.4"/>'
svg("workstation", 900, 400, DEFS
    + txt(410, 45, "How to sit at a machine for years without injury", 16, NAVY,
          "middle", "bold") + _b
    + box(160, 350, 560, 38, GOLDBG, GOLD, 6)
    + txt(440, 375, "Every 20 minutes, look 20 feet away for 20 seconds.",
          14.5, GOLD, "middle", "bold"))

# =====================================================================
# 16. The spreadsheet grid
# =====================================================================
_b = ""
COLS = ["A", "B", "C", "D", "E"]
CW, CH, GX, GY = 108, 34, 150, 95
_b += box(GX - 46, GY - 32, 46, 32, SOFT, RULE, 0)
for i, c in enumerate(COLS):
    _b += box(GX + i * CW, GY - 32, CW, 32, SOFT, RULE, 0)
    _b += txt(GX + i * CW + CW / 2, GY - 10, c, 14, NAVY, "middle", "bold")
for r in range(6):
    _b += box(GX - 46, GY + r * CH, 46, CH, SOFT, RULE, 0)
    _b += txt(GX - 23, GY + r * CH + 23, str(r + 1), 13.5, NAVY, "middle", "bold")
    for i in range(len(COLS)):
        _b += box(GX + i * CW, GY + r * CH, CW, CH, WHITE, RULE, 0, 1)
# range B2:C4 highlighted
_b += (f'<rect x="{GX + CW}" y="{GY + CH}" width="{CW * 2}" height="{CH * 3}" '
       f'fill="{GOLDBG}" fill-opacity="0.85" stroke="{GOLD}" stroke-width="2.4"/>')
_b += txt(GX + CW * 2, GY + CH * 2 + 24, "range B2:C4", 14, GOLD, "middle", "bold")
# active cell E5
_b += (f'<rect x="{GX + CW * 4}" y="{GY + CH * 4}" width="{CW}" height="{CH}" '
       f'fill="{WHITE}" stroke="{NAVY}" stroke-width="3"/>')
_b += txt(GX + CW * 4 + CW / 2, GY + CH * 4 + 23, "E5", 13.5, NAVY, "middle", "bold")
_b += arrow(760, GY + CH * 4 + 17, GX + CW * 5 + 4, GY + CH * 4 + 17, NAVY, 1.8)
_b += txt(770, GY + CH * 4 + 5, "active cell", 13, NAVY, "start", "bold")
_b += txt(770, GY + CH * 4 + 24, "column then row", 12.5, MUTED, "start")
_b += txt(104, GY - 48, "columns run down, lettered", 12.5, MUTED, "start")
_b += txt(30, GY + 130, "rows run", 12.5, MUTED, "start")
_b += txt(30, GY + 148, "across,", 12.5, MUTED, "start")
_b += txt(30, GY + 166, "numbered", 12.5, MUTED, "start")
svg("spreadsheet_grid", 900, 340, DEFS
    + txt(400, 38, "The parts of a worksheet", 16, NAVY, "middle", "bold") + _b)

# =====================================================================
# 17. Relative against absolute referencing
# =====================================================================
_b = ""
_b += txt(228, 38, "Relative:  = B2 * E1", 16, RED, "middle", "bold")
_b += txt(672, 38, "Absolute:  = B2 * $E$1", 16, GOLD, "middle", "bold")
_rows_r = [("C2", "= B2 * E1", "correct", False),
           ("C3", "= B3 * E2", "points at an empty cell", True),
           ("C4", "= B4 * E3", "points at an empty cell", True)]
_rows_a = [("C2", "= B2 * $E$1", "correct", False),
           ("C3", "= B3 * $E$1", "correct", False),
           ("C4", "= B4 * $E$1", "correct", False)]
for i, (cell, f, note, bad) in enumerate(_rows_r):
    y = 72 + i * 62
    _b += box(60, y, 340, 50, REDBG if bad else SOFT, RED if bad else RULE, 5)
    _b += txt(88, y + 31, cell, 13.5, MUTED, "start", "bold")
    _b += txt(140, y + 31, f, 14.5, NAVY, "start", "bold", MONO)
    _b += txt(392, y + 31, note, 11.5, RED if bad else MUTED, "end")
for i, (cell, f, note, bad) in enumerate(_rows_a):
    y = 72 + i * 62
    _b += box(500, y, 340, 50, GOLDBG, GOLD, 5)
    _b += txt(528, y + 31, cell, 13.5, MUTED, "start", "bold")
    _b += txt(580, y + 31, f, 14.5, NAVY, "start", "bold", MONO)
    _b += txt(832, y + 31, note, 11.5, GOLD, "end")
_b += f'<line x1="450" y1="25" x2="450" y2="255" stroke="{RULE}" stroke-width="1.5" stroke-dasharray="5 5"/>'
svg("cell_ref", 900, 320, DEFS + _b
    + box(120, 268, 660, 40, SOFT, RULE, 6)
    + txt(450, 294, "The rate sits in E1. The dollar signs stop that reference "
          "moving as the formula is copied down.", 13.5, NAVY, "middle", "bold"))

# =====================================================================
# 18. Virus against worm
# =====================================================================
_b = ""
_b += txt(225, 38, "Virus", 17, NAVY, "middle", "bold")
_b += box(120, 62, 210, 46, SOFT, RULE, 6)
_b += txt(225, 91, "attaches to a host file", 13.5, MUTED)
_b += f'<rect x="175" y="130" width="100" height="52" rx="5" fill="{WHITE}" stroke="{NAVY}" stroke-width="1.6"/>'
_b += txt(225, 152, "host file", 12.5, MUTED)
_b += f'<circle cx="225" cy="168" r="7" fill="{RED}"/>'
_b += arrow(225, 190, 225, 222, MUTED, 2, "m")
_b += box(120, 228, 210, 46, REDBG, RED, 6)
_b += txt(225, 248, "a person runs it", 13.5, RED, "middle", "bold")
_b += txt(225, 266, "nothing happens until then", 11.5, RED)
_b += arrow(225, 282, 225, 312, MUTED, 2, "m")
_b += txt(225, 335, "then it spreads", 13.5, NAVY, "middle", "bold")
_b += f'<line x1="450" y1="25" x2="450" y2="350" stroke="{RULE}" stroke-width="1.5" stroke-dasharray="5 5"/>'
_b += txt(675, 38, "Worm", 17, NAVY, "middle", "bold")
_b += box(570, 62, 210, 46, SOFT, RULE, 6)
_b += txt(675, 91, "stands alone, no host", 13.5, MUTED)
_b += f'<circle cx="675" cy="155" r="16" fill="{RED}"/>'
for dx, dy in [(-80, 55), (0, 68), (80, 55)]:
    _b += arrow(675, 173, 675 + dx, 155 + dy, MUTED, 1.8, "m")
    _b += f'<circle cx="{675 + dx}" cy="{155 + dy + 18}" r="12" fill="{RED}" fill-opacity="0.75"/>'
for dx in (-80, 0, 80):
    for ddx in (-26, 26):
        _b += arrow(675 + dx, 191 + dy, 675 + dx + ddx, 268, MUTED, 1.4, "m")
        _b += f'<circle cx="{675 + dx + ddx}" cy="280" r="8" fill="{RED}" fill-opacity="0.5"/>'
_b += box(570, 300, 210, 46, GOLDBG, GOLD, 6)
_b += txt(675, 320, "no person needed", 13.5, GOLD, "middle", "bold")
_b += txt(675, 338, "it copies itself across a network", 11.5, MUTED)
svg("virus_worm", 900, 365, DEFS + _b)

# =====================================================================
# 19. Three kinds of backup
# =====================================================================
_b = ""
_days = ["Sun", "Mon", "Tue", "Wed", "Thu"]
_sets = [("Full", "every file, every time", [5, 5, 5, 5, 5], GOLD, GOLDBG),
         ("Incremental", "only what changed since the last backup of any kind",
          [5, 1, 1, 1, 1], NAVY, SOFT),
         ("Differential", "everything changed since the last full backup",
          [5, 1, 2, 3, 4], MUTED, SOFT)]
for si, (name, desc, sizes, col, bg) in enumerate(_sets):
    y = 70 + si * 100
    _b += txt(30, y + 24, name, 15, NAVY, "start", "bold")
    _b += txt(30, y + 46, desc, 12, MUTED, "start")
    for di, s in enumerate(sizes):
        x = 420 + di * 92
        h = 14 + s * 8
        _b += box(x, y + 58 - h, 66, h, bg, col, 4)
        if si == 0:
            _b += txt(x + 33, y + 78, _days[di], 12, MUTED)
        else:
            _b += txt(x + 33, y + 78, _days[di], 12, MUTED)
svg("backup_types", 900, 400, DEFS
    + txt(450, 38, "How much each kind copies, day by day", 16, NAVY, "middle", "bold")
    + _b
    + box(60, 350, 780, 40, GOLDBG, GOLD, 6)
    + txt(450, 375, "Three copies, on two kinds of media, one of them off site.",
          14.5, GOLD, "middle", "bold"))

# =====================================================================
# 20. Text wrapping options
# =====================================================================
_b = ""
_wr = [("In line with text", "treated as one large letter"),
       ("Square", "text flows round a rectangle"),
       ("Tight", "text follows the shape"),
       ("Behind text", "picture sits underneath")]
for i, (name, note) in enumerate(_wr):
    x = 25 + i * 220
    _b += box(x, 55, 200, 150, WHITE, RULE, 6)
    for ln in range(7):
        _b += f'<rect x="{x + 14}" y="{72 + ln * 18}" width="172" height="6" rx="3" fill="{RULE}"/>'
    if i == 0:
        _b += f'<rect x="{x + 14}" y="{72 + 3 * 18 - 6}" width="60" height="26" fill="{GOLD}" fill-opacity="0.65"/>'
        _b += f'<rect x="{x + 78}" y="{72 + 3 * 18}" width="108" height="6" rx="3" fill="{RULE}"/>'
    elif i == 1:
        for ln in range(2, 6):
            _b += f'<rect x="{x + 14}" y="{72 + ln * 18}" width="86" height="6" rx="3" fill="{WHITE}"/>'
        _b += f'<rect x="{x + 14}" y="{104}" width="80" height="74" fill="{GOLD}" fill-opacity="0.65"/>'
    elif i == 2:
        for ln in range(2, 6):
            _b += f'<rect x="{x + 14}" y="{72 + ln * 18}" width="{50 + abs(ln - 4) * 22}" height="6" rx="3" fill="{WHITE}"/>'
        _b += f'<circle cx="{x + 56}" cy="141" r="38" fill="{GOLD}" fill-opacity="0.65"/>'
    else:
        _b += f'<rect x="{x + 40}" y="98" width="120" height="80" fill="{GOLD}" fill-opacity="0.35"/>'
    _b += txt(x + 100, 228, name, 14, NAVY, "middle", "bold")
    _b += txt(x + 100, 248, note, 12, MUTED)
svg("text_wrap", 900, 270, DEFS + _b)

# =====================================================================
# 21. Automatic data capture
# =====================================================================
_b = ""
_rd = [("Barcode", "bars, line of sight needed"), ("QR code", "holds far more"),
       ("MICR", "magnetic ink, cheques"), ("OMR", "reads where a mark is"),
       ("OCR", "reads characters"), ("RFID", "radio, no line of sight")]
for i, (n, d) in enumerate(_rd):
    x = 25 + (i % 3) * 292
    y = 60 + (i // 3) * 100
    hi = n == "RFID"
    _b += box(x, y, 268, 78, GOLDBG if hi else SOFT, GOLD if hi else RULE, 6)
    _b += txt(x + 134, y + 32, n, 16, NAVY, "middle", "bold")
    _b += txt(x + 134, y + 56, d, 12.5, MUTED)
svg("data_capture", 900, 320, DEFS
    + txt(450, 36, "Letting a machine read the data instead of typing it",
          16, NAVY, "middle", "bold") + _b
    + box(90, 262, 720, 42, SOFT, RULE, 6)
    + txt(450, 288, "AI image recognition reads the thing itself, with no code or "
          "tag attached first.", 14, NAVY, "middle", "bold"))

# =====================================================================
# 22. What an operating system does
# =====================================================================
_b = ""
_b += f'<circle cx="450" cy="185" r="82" fill="{GOLDBG}" stroke="{GOLD}" stroke-width="2.2"/>'
_b += txt(450, 178, "Operating", 16, GOLD, "middle", "bold")
_b += txt(450, 200, "system", 16, GOLD, "middle", "bold")
_fn = [("Process management", 450, 42), ("Memory management", 748, 108),
       ("File management", 748, 262), ("Device management", 450, 328),
       ("Security", 152, 262), ("User interface", 152, 108)]
import math
for name, cx, cy in _fn:
    w = 214
    _b += box(cx - w / 2, cy - 22, w, 44, SOFT, RULE, 6)
    _b += txt(cx, cy + 6, name, 13.5, NAVY, "middle", "bold")
    dx, dy = cx - 450, cy - 185
    d = math.hypot(dx, dy)
    ux, uy = dx / d, dy / d
    _b += f'<line x1="{450 + ux * 84:.0f}" y1="{185 + uy * 84:.0f}" x2="{cx - ux * 112:.0f}" y2="{cy - uy * 30:.0f}" stroke="{RULE}" stroke-width="1.8"/>'
svg("os_functions", 900, 375, DEFS + _b)
