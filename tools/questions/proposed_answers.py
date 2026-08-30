#!/usr/bin/env python3
"""
Proposed answers for the past questions whose papers carried no answer key.

280 of the imported questions came from exam booklets that were printed blank.
Leaving them for a teacher to key in by hand is hundreds of small decisions,
almost all of which are ordinary O-Level syllabus recall that does not need a
teacher's judgement at all.

So the answers below are proposed, not asserted. Each carries a confidence:

  high    Standard syllabus content with one defensible answer. Confirming
          these should be a glance, not a decision.
  medium  The answer is clear but something is not: the OCR damaged a word,
          or the phrasing admits a second reading, or the question is one of
          those where the expected answer and the strictly correct one differ.

Anything figure-dependent, badly garbled, or genuinely ambiguous is absent from
this file on purpose. A wrong key is worse than a missing one, because a missing
key stops the question from marking anyone, while a wrong key marks a right
answer wrong and the student has no way to argue.

Keys are (page, question number), which is stable across re-extraction in a way
that a row position is not.
"""

# (page, number): (letter, confidence)
ANSWERS = {
    # ---- 2015 paper, pages 46-47 ---------------------------------------
    (47, 21): ("D", "high"),      # multiprogramming: run many programs at a time

    # ---- June 2017 Paper 1, pages 61-64 --------------------------------
    (61, 1):  ("A", "high"),      # valves -> first generation
    (61, 2):  ("B", "high"),      # compiler is the only software
    (61, 3):  ("A", "high"),      # 20 chars x 8 bits = 160
    (61, 4):  ("C", "high"),      # systems analyst
    (61, 6):  ("B", "high"),      # desktop -> microcomputer
    (61, 7):  ("D", "high"),      # weather forecasting -> supercomputer
    (61, 8):  ("A", "high"),      # scanner -> optical device
    (61, 9):  ("B", "high"),      # prompt
    (61, 10): ("B", "high"),      # worm
    (61, 11): ("D", "high"),      # RAM is not part of the CPU
    (61, 14): ("B", "high"),      # LAN
    (62, 15): ("D", "high"),      # File Edit Format View Help -> menu bar
    (62, 16): ("B", "high"),      # A=01000001 so C=01000011
    (62, 17): ("B", "high"),      # e-commerce has no physical contact
    (62, 18): ("B", "high"),      # phased conversion
    (62, 21): ("C", "high"),      # C++ and Java
    (62, 22): ("B", "high"),      # assembler
    (62, 23): ("A", "high"),      # Management Information System
    (62, 24): ("B", "medium"),    # truth table reads 0,1,1,1 -> OR
    (62, 26): ("B", "high"),      # constant: identifier that may not change
    (62, 27): ("D", "high"),      # laser printer
    (63, 28): ("B", "high"),      # WWW is a service over the Internet
    (63, 29): ("B", "high"),      # a program
    (63, 30): ("D", "high"),      # worksheets
    (63, 31): ("A", "high"),      # lag: predecessor to successor
    (63, 32): ("D", "high"),      # scanner
    (63, 34): ("B", "high"),      # word
    (63, 35): ("A", "high"),      # keyboard
    (63, 36): ("B", "high"),      # HTTP
    (63, 37): ("C", "medium"),    # HTML, interpreted by the browser
    (63, 38): ("C", "high"),      # real
    (63, 39): ("B", "high"),      # magnetic tape is sequential
    (63, 40): ("B", "high"),      # full duplex
    (63, 41): ("A", "high"),      # star topology
    (64, 42): ("B", "high"),      # thesaurus
    (64, 44): ("D", "high"),      # feasibility study
    (64, 45): ("D", "high"),      # pseudocode
    (64, 46): ("C", "high"),      # declarative
    (64, 47): ("C", "high"),      # firewall
    (64, 48): ("C", "high"),      # demand for expertise increases
    (64, 49): ("D", "high"),      # execution time

    # ---- pages 66-69 ----------------------------------------------------
    (66, 1):  ("C", "high"),      # A2:C6 = 3 cols x 5 rows = 15
    (66, 2):  ("A", "high"),      # softcopy = electronic output
    (66, 3):  ("C", "high"),      # portable document format
    (66, 4):  ("C", "high"),      # critical path
    (66, 5):  ("C", "high"),      # uploading
    (66, 6):  ("D", "high"),      # icon
    (66, 7):  ("D", "high"),      # Geographic Information System
    (66, 9):  ("A", "high"),      # data type: set of values a variable may hold
    (66, 10): ("D", "high"),      # multiplexing
    (66, 11): ("A", "high"),      # control unit
    (66, 12): ("D", "high"),      # RAM holds data temporarily
    (66, 14): ("C", "high"),      # browsers
    (66, 16): ("D", "high"),      # optic fibre
    (67, 22): ("A", "high"),      # transaction processing system
    (67, 23): ("A", "high"),      # real-time
    (67, 24): ("B", "high"),      # data integrity
    (67, 25): ("B", "high"),      # worm
    (67, 27): ("C", "high"),      # assembler
    (68, 32): ("B", "high"),      # table 1,1,1,0 -> NAND
    (68, 33): ("A", "high"),      # 3 B/s x 10 s = 30 B = 240 bits
    (68, 34): ("A", "high"),      # CRT monitors
    (68, 35): ("C", "high"),      # machine language
    (68, 36): ("C", "high"),      # OS loaded into RAM
    (68, 37): ("B", "high"),      # computer programmer
    (68, 38): ("C", "high"),      # capitals read as shouting
    (68, 39): ("B", "high"),      # system and application software
    (68, 40): ("D", "high"),      # Food4allin mixes case, digits, length
    (69, 42): ("B", "high"),      # insecurity from irresponsible users
    (69, 43): ("A", "high"),      # 101111 - 100110 = 1001
    (69, 44): ("B", "high"),      # <B> and </B>
    (69, 49): ("D", "high"),      # spreadsheet
    (69, 50): ("D", "high"),      # 1MB < 1GB < 1TB

    # ---- pages 75-78 ----------------------------------------------------
    (75, 1):  ("A", "high"),      # spreadsheet recalculates automatically
    (75, 3):  ("C", "high"),      # upgrading
    (75, 4):  ("B", "high"),      # star network
    (75, 5):  ("B", "high"),      # buffer
    (75, 6):  ("A", "high"),      # flow chart
    (75, 7):  ("D", "high"),      # secondary storage
    (75, 8):  ("C", "high"),      # program
    (75, 9):  ("C", "high"),      # browser
    (75, 12): ("A", "high"),      # Short Messaging Service
    (75, 13): ("C", "high"),      # bus
    (75, 14): ("A", "high"),      # http://www.margiestravel.com
    (75, 15): ("A", "high"),      # end-user licence
    (76, 16): ("D", "high"),      # primary key
    (76, 17): ("A", "high"),      # glare and reflection is the ergonomic one
    (76, 19): ("A", "high"),      # SQL
    (76, 22): ("B", "high"),      # netiquette
    (76, 23): ("B", "high"),      # encrypt
    (76, 24): ("C", "high"),      # critical task
    (76, 27): ("B", "high"),      # Extended Binary Coded Decimal Interchange Code
    (76, 28): ("C", "high"),      # dot matrix is an impact printer
    (76, 29): ("D", "high"),      # auxiliary storage
    (77, 30): ("C", "high"),      # web site
    (77, 31): ("A", "high"),      # modulation
    (77, 32): ("D", "high"),      # ARPANET
    (77, 34): ("B", "high"),      # FTP
    (77, 35): ("C", "high"),      # e-commerce
    (77, 36): ("A", "high"),      # protocol
    (77, 37): ("C", "high"),      # system analysts
    (77, 38): ("B", "high"),      # 11011 = 27
    (77, 39): ("B", "high"),      # analysis phase
    (77, 40): ("C", "high"),      # imitates a real life situation
    (77, 42): ("A", "high"),      # PAN
    (77, 43): ("A", "high"),      # repeater amplifies
    (78, 44): ("D", "high"),      # b=01100010 so d=01100100
    (78, 45): ("B", "high"),      # webcam is an input device
    (78, 47): ("A", "high"),      # column header is the field name
    (78, 48): ("B", "high"),      # Z33
    (78, 49): ("C", "high"),      # icon
    (78, 50): ("B", "high"),      # system analysis

    # ---- June 2019 Paper 1, pages 86-87 --------------------------------
    (86, 3):  ("B", "high"),      # encrypt files
    (86, 4):  ("A", "high"),      # booting
    (86, 5):  ("A", "high"),      # Android is an operating system
    (86, 6):  ("B", "high"),      # collect only necessary information
    (86, 7):  ("D", "high"),      # register
    (86, 8):  ("B", "high"),      # pilot: selected users alongside the old
    (86, 9):  ("C", "high"),      # Uniform Resource Locator
    (86, 10): ("D", "high"),      # bandwidth
    (86, 12): ("C", "high"),      # browser
    (86, 13): ("B", "high"),      # NOR is high only when all inputs are low
    (86, 14): ("A", "high"),      # Personal Identification Number
    (86, 16): ("B", "high"),      # vacuum tubes: first generation only
    (87, 17): ("C", "high"),      # System Development Life Cycle
    (87, 18): ("C", "high"),      # integer accepts whole numbers only
    (87, 21): ("B", "medium"),    # the expected answer for a 2GHz dual core
    (87, 29): ("A", "high"),      # key field
    (87, 32): ("A", "high"),      # virtual memory
    (87, 33): ("C", "high"),      # 16 symbols in hexadecimal
    (87, 34): ("B", "high"),      # repeater

    # ---- pages 94-96 (scanned) -----------------------------------------
    (95, 20): ("D", "high"),      # spread of false information
    (95, 23): ("C", "high"),      # consistency check
    (95, 27): ("C", "high"),      # webcam is an input device
    (95, 34): ("C", "high"),      # instructions
    (96, 35): ("A", "medium"),    # syntax
    (96, 39): ("C", "high"),      # motherboard
    (96, 46): ("B", "high"),      # Office is not an operating system
    (96, 47): ("A", "high"),      # moral code followed on the computer
    (96, 49): ("B", "high"),      # sectors

    # ---- pages 101-103 --------------------------------------------------
    (101, 12): ("A", "high"),     # transaction processing system
    (101, 13): ("C", "high"),     # peripheral devices
    (101, 15): ("C", "high"),     # uploading
    (101, 16): ("B", "high"),     # protocol
    (101, 17): ("B", "high"),     # users can manipulate it easily
    (101, 60): ("C", "high"),     # declarative
    (102, 18): ("D", "high"),     # flowchart symbols are universally accepted
    (102, 22): ("D", "high"),     # optic fibre
    (102, 23): ("B", "high"),     # tailor-made software
    (102, 24): ("C", "high"),     # File Transfer Protocol
    (102, 25): ("A", "high"),     # confidentiality
    (103, 36): ("A", "high"),     # planning, analysis, design, implementation, support
    (103, 38): ("A", "high"),     # scanner takes hard copy input
    (103, 39): ("C", "high"),     # node
    (103, 40): ("A", "high"),     # switch addresses a specific machine
    (103, 42): ("A", "high"),     # monitoring system

    # ---- pages 160-163, 171, 190-193 ------------------------------------
    (161, 24): ("B", "high"),     # third generation: integrated circuits
    (162, 29): ("B", "high"),     # NOT has one input
    (163, 50): ("B", "high"),     # ergonomics
    (171, 39): ("A", "medium"),   # phishing, spelled "Bhishing" by the scanner
    (191, 23): ("D", "high"),     # slack time
    (191, 24): ("B", "high"),     # integrated circuits
    (191, 26): ("A", "high"),     # =$A$2
    (192, 29): ("B", "high"),     # NOT
    (193, 45): ("D", "high"),     # device is hardware, driver is software

    # ---- question banks, pages 278-308 ----------------------------------
    (278, 1):  ("B", "high"),     # 1024 bytes
    (279, 7):  ("D", "high"),     # all of the above
    (280, 8):  ("C", "high"),     # 7 bits, the eighth for parity
    (287, 11): ("A", "high"),     # bit
    (289, 8):  ("D", "high"),     # hierarchical model: tree
    (289, 9):  ("C", "high"),     # relations are tables
    (297, 16): ("D", "high"),     # algorithm
    (301, 4):  ("D", "high"),     # all of the above
    (301, 6):  ("B", "high"),     # feasibility study
    (302, 11): ("C", "high"),     # evaluation
    (305, 8):  ("D", "high"),     # worldwide interconnected network using TCP/IP
    (307, 19): ("D", "high"),     # the fullest statement
    (308, 22): ("D", "high"),     # searches using specified search terms
    (308, 23): ("B", "high"),     # Hyper Text Markup Language
    (308, 24): ("A", "medium"),   # conventionally answered "word processing language"

    # ---- South West Regional Mock 2026, pages 324-326 -------------------
    (324, 1):  ("C", "high"),     # ICs replaced transistors
    (324, 2):  ("B", "high"),     # warm boot
    (324, 3):  ("C", "high"),     # machines performing tasks needing human intelligence
    (324, 4):  ("A", "high"),     # softcopy
    (324, 5):  ("D", "high"),     # Internet of Things
    (324, 6):  ("C", "high"),     # octal has 8 digits
    (324, 7):  ("C", "high"),     # f=01100110 so d=01100100
    (324, 11): ("C", "high"),     # <hr>
    (324, 12): ("B", "high"),     # thesaurus
    (324, 13): ("A", "high"),     # .png holds graphics
    (324, 14): ("B", "high"),     # a patch is an update
    (324, 15): ("D", "high"),     # A2:C3 = 3 x 2 = 6
    (324, 16): ("D", "high"),     # an OS is not utility software
    (324, 17): ("A", "high"),     # portability
    (324, 18): ("A", "high"),     # presentation software
    (325, 19): ("D", "medium"),   # free of charge and modifiable: free open-source
    (325, 20): ("A", "high"),     # execution eventually ends
    (325, 21): ("B", "high"),     # two independent processing units
    (325, 22): ("A", "high"),     # clusters
    (325, 23): ("A", "high"),     # ROM is non-volatile primary storage
    (325, 24): ("C", "high"),     # touchscreen is input and output
    (325, 25): ("B", "high"),     # address bus
    (325, 26): ("A", "high"),     # logic error
    (325, 28): ("C", "high"),     # height is real
    (325, 29): ("B", "high"),     # pixels
    (325, 30): ("C", "high"),     # CMOS battery
    (325, 31): ("D", "high"),     # fetch, decode, execute
    (325, 32): ("C", "high"),     # 101 >= 100 so "Pass"
    (325, 33): ("A", "high"),     # scanner to computer is simplex
    (325, 34): ("B", "high"),     # bridge
    (325, 35): ("C", "high"),     # SMTP
    (326, 36): ("B", "high"),     # mesh: improved fault tolerance
    (326, 37): ("A", "high"),     # www.rdsecsc.cm
    (326, 38): ("A", "high"),     # phishing
    (326, 39): ("B", "high"),     # demodulation
    (326, 40): ("B", "high"),     # netiquette
    (326, 41): ("D", "high"),     # parallel conversion
    (326, 42): ("B", "high"),     # proof reading
    (326, 43): ("C", "high"),     # executive information system
    (326, 45): ("D", "high"),     # quantum computing is not an AI domain
    (326, 46): ("A", "high"),     # compiler
    (326, 47): ("B", "high"),     # a rectangle is a process
    (326, 50): ("A", "medium"),   # SN is the only unique-looking field
}


# Stems the scanner mangled badly enough to be worth repairing. Only obvious
# repairs are listed: a word the OCR clearly misread, restored to what the
# syllabus says it must be. Anything requiring a guess about meaning is left
# alone for a teacher to fix against the page.
STEM_FIXES = {
    (47, 21): "The term multiprogramming refers to the ability to:",
    (95, 34): "A program is a sequence of ______ written in a programming language.",
    (96, 39): "What is the name of the largest electronic circuit in a microcomputer?",
    (162, 29): "Which one of the following logic gates has only one input?",
    (171, 39): ("Any attempt by individuals to obtain confidential information by "
                "falsifying their identity through emails is called"),
    (149, 16): ("The act of protecting data by converting it into an unreadable "
                "format by means of an algorithm, so that only the intended "
                "recipient can understand it, is called"),
}


# Questions whose figure was lost to the scanner but whose figure is standard
# syllabus content, so it can be redrawn. The name must match a key in
# app/admin/questions/QuestionFigure.js.
#
# Only listed where the original figure is recoverable with certainty. Where
# the *options* were themselves pictures — "which of these symbols is an AND
# gate", with four drawings to choose between — nothing can be reconstructed,
# because the choices are gone, not just the prompt. Those stay flagged as
# needing a diagram.
FIGURES = {
    (68, 32):  "truth_nand",   # option text preserves 1,1,1,0
    (324, 9):  "truth_xnor",   # option text preserves 1,0,0,1
    (62, 24):  "truth_or",     # option text preserves 0,1,1,1
    (162, 29): "gates_all",    # "which gate has one input" — needs all six shown
    (192, 29): "gates_all",
    (86, 13):  "truth_nor",    # asks when NOR outputs high
}


# ---------------------------------------------------------------------------
# Questions repaired by hand.
#
# A large share of the unanswerable questions are not damaged so much as
# run together: the scanner read a four-option column as one option and
# packed B, C and D inside A. "Sending a file from your computer to a server
# is called" arrived with option A reading "downloading. 13reading. C writing.
# D uploading." — every option is there, in the wrong place.
#
# Those are repaired below, because the original is recoverable from what the
# scan itself contains. Where an option is genuinely gone, the question is left
# alone: writing a plausible replacement would be inventing exam material and
# passing it off as the paper.
#
# Each entry replaces the options wholesale, and may correct the stem.
# ---------------------------------------------------------------------------

REFINEMENTS = {
    (63, 33): {
        "stem": "In a system in which 1 means TRUE and 0 means FALSE, "
                "what is the result of 1 + 1?",
        "options": {"A": "2", "B": "10", "C": "1"},
        "answer": "C", "confidence": "medium",
    },
    (64, 50): {
        "stem": "How many bits are required to encode 32 different characters?",
        "options": {"A": "32", "B": "8", "C": "5", "D": "4"},
        "answer": "C", "confidence": "medium",
    },
    (75, 10): {
        "stem": "Making illegal copies of copyrighted software is known as",
        "options": {"A": "Scamming", "B": "Browsing", "C": "Sharing", "D": "Piracy"},
        "answer": "D", "confidence": "high",
    },
    (87, 19): {
        "stem": "Sending a file from your computer to a server is called",
        "options": {"A": "downloading", "B": "reading", "C": "writing",
                    "D": "uploading"},
        "answer": "D", "confidence": "high",
    },
    (87, 22): {
        "stem": "Which of the following is a program used for locating and "
                "correcting programming errors?",
        "options": {"A": "Compiler", "B": "Assembler", "C": "Debugger",
                    "D": "Linker"},
        "answer": "C", "confidence": "high",
    },
    (87, 30): {
        "stem": "The number 56A3 has been written possibly in base:",
        "options": {"A": "16", "B": "7", "C": "8", "D": "9"},
        "answer": "A", "confidence": "high",
    },
    (94, 2): {
        "stem": "Which of the following mathematical statements is TRUE?",
        "options": {"A": "1KB = 8 Bytes", "B": "1MB = 1000 Bytes",
                    "C": "1KB = 1024 Bytes", "D": "1MB = 1024 Bytes"},
        "answer": "C", "confidence": "high",
    },
    (94, 5): {
        "stem": "A communication channel that is bidirectional but carries "
                "data in only one direction at a time is called a",
        "options": {"A": "Simplex channel", "B": "Half-duplex channel",
                    "C": "Serial transmission channel"},
        "answer": "B", "confidence": "high",
    },
    (94, 8): {
        "stem": "A field which uniquely identifies a record in a database "
                "table is referred to as",
        "options": {"A": "Secondary key", "B": "Foreign key",
                    "C": "Primary key", "D": "Non key field"},
        "answer": "C", "confidence": "high",
    },
    (94, 16): {
        "stem": "The act of protecting data by converting it into an "
                "unreadable format by means of an algorithm, so that only the "
                "intended recipient can understand it, is called",
        "options": {"A": "Compression", "B": "Decryption", "C": "Encryption",
                    "D": "Encapsulation"},
        "answer": "C", "confidence": "high",
    },
    (95, 21): {
        "stem": "Attenuation that occurs during data transmission can be "
                "corrected by using a network device called a",
        "options": {"A": "Modem", "B": "Repeater", "C": "Computer hub",
                    "D": "Computer switch"},
        "answer": "B", "confidence": "high",
    },
    (95, 24): {
        "stem": "In spreadsheet applications, the name given to a "
                "pre-programmed formula is a",
        "options": {"A": "Function", "B": "Operator", "C": "Graph"},
        "answer": "A", "confidence": "high",
    },
    (95, 25): {
        "stem": "Which of the following is in the descending order of the "
                "data hierarchy?",
        "options": {
            "A": "Bit, byte, field, record, file and database",
            "B": "Database, file, record, field, byte and bit",
            "C": "Byte, bit, field, record, file and database"},
        "answer": "B", "confidence": "high",
    },
    (95, 26): {
        "stem": "In which stage of the SDLC is data gathered and scrutinized?",
        "options": {"A": "Preliminary investigation", "B": "System analysis",
                    "C": "System design", "D": "System testing"},
        "answer": "B", "confidence": "high",
    },
    (95, 30): {
        "stem": "Which of the following acronyms refers to the use of "
                "computer systems to assist in industrial design?",
        "options": {"A": "SMS", "B": "E-MAIL", "C": "CAD", "D": "CRT"},
        "answer": "C", "confidence": "high",
    },
    (95, 32): {
        "stem": "The ability of software to run on different platforms is "
                "known as",
        "options": {"A": "Flexibility", "B": "Portability",
                    "C": "Maintainability", "D": "Security"},
        "answer": "B", "confidence": "high",
    },
    (96, 37): {
        "stem": "Which type of data communication mode exists in radio "
                "broadcasting?",
        "options": {"A": "Full duplex", "B": "Simplex", "C": "Half-simplex",
                    "D": "Half-duplex"},
        "answer": "B", "confidence": "medium",
    },
    (96, 38): {
        "stem": "The speed of a computer processor is measured in",
        "options": {"A": "Bits", "B": "Bytes", "C": "Hertz"},
        "answer": "C", "confidence": "high",
    },
    (96, 44): {
        "stem": "Dot matrix printers are examples of ______ printers.",
        "options": {"A": "Laser", "B": "Inkjet", "C": "Impact", "D": "Drum"},
        "answer": "C", "confidence": "high",
    },
    (160, 1): {
        "stem": "A translation tool used to interpret code written in HTML is the",
        "options": {"A": "Interpreter", "B": "Compiler", "C": "Browser",
                    "D": "Assembler"},
        "answer": "C", "confidence": "high",
    },
    (190, 1): {
        "stem": "A translation tool used to interpret code written in HTML is the",
        "options": {"A": "Interpreter", "B": "Compiler", "C": "Browser",
                    "D": "Assembler"},
        "answer": "C", "confidence": "high",
    },
    (160, 6): {
        "stem": "A task that must be completed within the specified time "
                "limit of a project is called a ______ task.",
        "options": {"A": "Dangling", "B": "Floating", "C": "Critical",
                    "D": "Dummy"},
        "answer": "C", "confidence": "high",
    },
    (163, 45): {
        "stem": "Which of the following is true about hardware devices and "
                "device drivers?",
        "options": {"A": "Both are hardware components",
                    "B": "Both are software components",
                    "C": "Drivers manage and control hardware devices"},
        "answer": "C", "confidence": "high",
    },
    (163, 46): {
        "stem": "One of the reasons for increasing the size of RAM is:",
        "options": {"A": "Less virus gets into the computer",
                    "B": "More instructions and data are made available to the CPU",
                    "C": "Reduces the rate of computer breakdown"},
        "answer": "B", "confidence": "high",
    },
    (190, 11): {
        "stem": "A translated code written in a compiled language is called",
        "options": {"A": "Source code", "B": "Object code",
                    "C": "Embedded code", "D": "Executable code"},
        "answer": "B", "confidence": "high",
    },
    (291, 20): {
        "stem": "The terms FIFO and LIFO would most likely arise during a "
                "discussion of:",
        "options": {"A": "Storage media", "B": "Binary trees",
                    "C": "Compiler design", "D": "Queues and stacks"},
        "answer": "D", "confidence": "high",
    },
    (324, 8): {
        "stem": "1000 picoseconds expressed in seconds is:",
        "options": {"A": "10^-10", "B": "10^-12", "C": "10^-9", "D": "10^-6"},
        "answer": "C", "confidence": "medium",
    },
}


# Answers for questions whose options were already readable.
EXTRA_ANSWERS = {
    (275, 3):  ("A", "high"),      # analog beats digital on raw speed
    (276, 9):  ("B", "high"),      # a programmer writes programs
    (281, 4):  ("B", "high"),      # a terminal is a point of entry or exit
    (282, 1):  ("A", "high"),      # memory temporary, storage permanent
    (283, 7):  ("B", "high"),      # internal memory
    (295, 8):  ("C", "high"),      # top-down: the top module first
    (301, 7):  ("A", "high"),      # analysis, design, implementation, evaluation
    (301, 8):  ("A", "high"),      # systems investigation comes first
    (302, 9):  ("C", "high"),      # observation and interviews: analysis
    (302, 10): ("C", "high"),      # parallel running
    (302, 4):  ("A", "high"),      # star needs a hub or switch
    (303, 10): ("C", "high"),      # protocols
    (307, 20): ("B", "high"),      # Uniform Resource Locator
    (324, 9):  ("C", "high"),      # table reads 1,0,0,1 -> XNOR
}
ANSWERS.update(EXTRA_ANSWERS)
