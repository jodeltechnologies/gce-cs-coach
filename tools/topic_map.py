#!/usr/bin/env python3
"""
Tag questions and note chapters to the lessons they belong to.

Tagging is the step that turns a pile of questions into something that can tell
a student what to revise. Untagged, a wrong answer is just a wrong answer;
tagged, it points at a lesson.

The map below is written by hand rather than derived by string similarity,
because the two vocabularies do not overlap. The lesson is called "Storage and
processing devices"; the question says "Which of these hardware components is
generally used to hold data temporarily?" and never uses either word. Fuzzy
matching on titles produces confident nonsense here. What works is naming, per
lesson, the words a question on that lesson actually contains.

A question can legitimately test two lessons, so a question may carry several
tags. The strongest match is marked primary, which is the one a weak-topic
report should attribute the mistake to.

Nothing here is asserted as correct. Tags land on questions that are already
marked needs_review, and a teacher retagging one is expected, not a failure.
"""

# lesson title -> (primary patterns, supporting patterns)
#
# Primary patterns are terms that only appear in questions on that lesson.
# Supporting patterns are terms that suggest it but also occur elsewhere, so
# they tag the lesson without claiming to be the main topic.
TOPICS = {
    "Simple data types": (
        [r"\bdata type\b", r"\bboolean\b", r"\binteger\b", r"\breal number",
         r"\balphanumeric\b"],
        [r"\bvariable\b", r"\bconstant\b"],
    ),
    "Data structures": (
        [r"\bdata structure", r"\barrays?\b", r"\brecord\b.*\bfield\b",
         r"\bstack\b", r"\bqueue\b", r"\blinked list\b"],
        [r"\bhierarch"],
    ),
    "Notions on programming paradigms": (
        [r"\bparadigm", r"\bdeclarative\b", r"\bimperative\b", r"\bprocedural\b",
         r"\bobject orient", r"\bobject-orient"],
        [r"\bC\+\+", r"\bprolog\b", r"\bhaskell\b"],
    ),
    "Algorithms to solve common problems 1": (
        [r"\balgorithm\b", r"\bpseudo ?codes?\b", r"\bflow ?charts?\b"],
        [r"\bfinite\b", r"\bunambiguous\b"],
    ),
    "Algorithm correctness and efficiency": (
        [r"\bdry run\b", r"\btrace table\b",
         r"execute the program by hand", r"efficiency of an algorithm", r"\bexecution time\b",
         r"\bterminates\b", r"\bfinite time\b"],
        [r"\bcorrectness\b"],
    ),
    "Notions on subroutines": (
        [r"\bsubroutine\b", r"\bsubprogram\b", r"\bprocedure\b.*\bfunction\b"],
        [],
    ),
    "Coding 1": (
        [r"\bcontrol structure", r"\bloop(?:ing|s)?\b", r"\biteration\b",
         r"\brecursi", r"\btop[- ]down\b", r"\bassignment\b",
         r"\bprogramming language\b", r"\bhigh[- ]level language\b",
         r"\blow[- ]level language\b", r"\bmachine language\b",
         r"\bassembly language\b", r"\bcompiler\b", r"\binterpreter\b",
         r"\bassembler\b", r"\bsyntax\b", r"\bdebugger\b", r"\bsource code\b"],
        [r"\bobject code\b", r"\bkeyword"],
    ),
    "Input and output peripherals": (
        [r"\binput device\b", r"\boutput device\b", r"\bperipheral",
         r"\bscanner\b", r"\bprinter\b", r"\bmonitor\b", r"\bkeyboard\b",
         r"\bwebcam\b", r"\btouch ?screen\b", r"\bplotter\b", r"\bmouse\b",
         r"\bimpact printer\b", r"\bresolution\b", r"\bpixel"],
        [r"\bhard ?copy\b", r"\bsoft ?copy\b", r"\bOMR\b", r"\bOCR\b"],
    ),
    "Storage and processing devices": (
        [r"\bRAM\b", r"\bROM\b", r"\bcache\b", r"\bvirtual memory\b",
         r"\bsecondary storage\b", r"\bprimary storage\b", r"\bmagnetic tape\b",
         r"\bhard disk\b", r"\bfloppy\b", r"\bsectors?\b", r"\btracks?\b",
         r"\bclusters?\b", r"\bCPU\b", r"\bcontrol unit\b", r"\bALU\b",
         r"\bregisters?\b", r"\bsequential access\b", r"\brandom access\b",
         r"\bvolatile\b", r"\bmemory\b",
         r"\bmillisecond\b", r"\bmicrosecond\b", r"\bnanosecond\b",
         r"\bpicosecond\b", r"\baccess time\b"],
        [r"\bstorage\b", r"\bprocessor\b", r"\bfetch\b", r"\bword\b"],
    ),
    "Other internal components": (
        [r"\bconnector\b", r"\bmotherboard\b", r"\bexpansion (?:slot|card)\b", r"\bbus(?:es)?\b",
         r"\baddress bus\b", r"\bdata bus\b", r"\bcontrol bus\b",
         r"\bgraphics card\b", r"\bsound card\b", r"\bports?\b", r"\bBIOS\b",
         r"\bCMOS\b", r"\bdual core\b"],
        [r"\bcircuit\b"],
    ),
    "Types of application software": (
        [r"\bmultiprogram", r"\bmultitask", r"\bmultiprocess",
         r"\bMS[- ]?DOS\b", r"\bUNIX\b", r"\bLinux\b", r"\bAndroid\b",
         r"\bOS/2\b", r"\bgraphical user interface\b", r"\bGUI\b",
         r"\bcommand line\b", r"\bmenu[- ]driven\b", r"\bicons?\b",
         r"\bapplication software\b", r"\bsystem software\b",
         r"\bword process", r"\bspreadsheet\b", r"\bpresentation software\b",
         r"\bdesktop publish", r"\butility software\b", r"\boperating system\b",
         r"\bdevice driver\b", r"\bbrowser\b", r"\bdefragment"],
        [r"\bsoftware\b", r"\bthesaurus\b", r"\bworksheet"],
    ),
    "Methods to obtain software": (
        [r"\bfreeware\b", r"\bshareware\b", r"\bopen[- ]source\b",
         r"\bpublic domain\b", r"\ball rights reserved\b",
         r"\blicen[cs]e\b", r"\bupgrad", r"\bpiracy\b"],
        [r"\bfree of charge\b"],
    ),
    "Using a word processor 1": (
        [r"\bword wrap\b", r"\bmail merge\b", r"\bthesaurus\b",
         r"\bcrop\b", r"\bfont\b"],
        [r"\bdocument\b"],
    ),
    "Solve problems with spreadsheets 1": (
        [r"\bcell (?:range|address|reference)\b", r"\bA2:C\d", r"\b=\$?[A-Z]\$?\d",
         r"\bformula\b", r"\bworkbook\b", r"\bworksheet\b",
         r"\babsolute cell\b", r"\bcolumn header\b"],
        [r"\bspreadsheet\b", r"\bbar chart"],
    ),
    "Network hardware": (
        [r"\btopolog", r"\bLAN\b", r"\bWAN\b", r"\bPAN\b", r"\bMAN\b",
         r"\bswitch\b", r"\bhub\b", r"\brouter\b", r"\brepeater\b",
         r"\bbridge\b", r"\bnetwork adapter\b", r"\bNIC\b", r"\bnodes?\b",
         r"\bcoaxial\b", r"\btwisted pair\b", r"\boptic(?:al)? fibre\b",
         r"\bbluetooth\b", r"\bserver\b.*\bclient\b"],
        [r"\bnetwork\b", r"\bbandwidth\b"],
    ),
    "Notions on packets": (
        [r"\bpackets?\b", r"\bprotocols?\b", r"\bmultiplex", r"\bmodulat",
         r"\bdemodulat", r"\bsimplex\b", r"\bduplex\b", r"\btransmission mode\b",
         r"\battenuation\b", r"\bmodem\b"],
        [r"\btransmission\b", r"\bsignal"],
    ),
    "Error detection and packet security": (
        [r"\bparity\b", r"\berror check", r"\berror detect", r"\bchecksum\b"],
        [],
    ),
    "Notions on the internet": (
        [r"\belectronic commerce\b", r"\binternet\b", r"\bworld wide web\b", r"\bWWW\b", r"\bHTTP\b",
         r"\bFTP\b", r"\bURL\b", r"\bSMTP\b", r"\bweb ?page\b", r"\bweb ?site\b",
         r"\bsearch engine\b", r"\bARPANET\b", r"\be-?commerce\b",
         r"\bdomain name\b", r"\bISP\b", r"\bupload", r"\bdownload"],
        [r"\bemail\b", r"\bonline\b"],
    ),
    "Web authoring services": (
        [r"\bHTML\b", r"\bXML\b", r"\btags?\b", r"<[a-z]{1,4}>", r"\bhyperlink\b"],
        [r"\bmarkup\b"],
    ),
    "Notions on social networks": (
        [r"\bsocial network", r"\bsocial media\b", r"\bnetiquette\b"],
        [],
    ),
    "Notions on security": (
        [r"\bauthenticat", r"\bpasswords?\b", r"\bbiometric", r"\bPIN\b",
         r"\bsmart card\b", r"\bencrypt", r"\bdecrypt", r"\bcipher\b",
         r"\bfirewall\b", r"\bbackup\b"],
        [r"\bsecurity\b", r"\bconfidential"],
    ),
    "Threats and attacks on computer systems": (
        [r"\bvirus(?:es)?\b", r"\bworms?\b", r"\btrojan\b", r"\bmalware\b",
         r"\bspyware\b", r"\bhack", r"\bphishing\b", r"\bspoofing\b",
         r"\bcyber ?bullying\b", r"\bspam\b"],
        [r"\bthreat\b", r"\battack\b"],
    ),
    "Data, computer, and network security measures": (
        [r"\banti[- ]?virus\b", r"\bsecurity measure"],
        [r"\bprotect"],
    ),
    "Notions on digital identities and digital footprints": (
        [r"\bdigital (?:identity|identities|footprint)\b", r"\bprivacy\b"],
        [],
    ),
    "Protecting Intellectual property": (
        [r"\bcopyright\b", r"\bintellectual property\b", r"\bpatent\b",
         r"\bplagiar"],
        [r"\bethic", r"\bcommandment"],
    ),
    "Notions on data encoding": (
        [r"\bASCII\b", r"\bEBCDIC\b", r"\bunicode\b", r"\bBCD\b",
         r"\bcharacter set\b", r"\bencoding\b", r"\bbits?\b", r"\bbytes?\b",
         r"\bnibble\b", r"\bkilobyte\b", r"\bmegabyte\b", r"\bgigabyte\b",
         r"\bterabyte\b", r"\b1024\b"],
        [r"\bbinary code\b", r"\bcharacter\b"],
    ),
    "Character and positive integers encoding": (
        [r"\bbase (?:2|8|10|16)\b", r"\bbinary number\b", r"\bhexadecimal\b",
         r"\boctal\b", r"\bdecimal equivalent\b", r"\bconvert\b.*\bbase\b",
         r"\bplace value\b", r"\bradix\b"],
        [r"\bbinary\b", r"\bnumber system\b"],
    ),
    "Addition and subtraction in base 2, 8 and 16": (
        [r"binary (?:addition|subtraction)", r"\b1[01]{3,}\s*[-+]\s*[01]{3,}",
         r"\badd\b.*\bbinary\b", r"\bsubtract\b.*\bbinary\b"],
        [],
    ),
    "Logic gates": (
        [r"\bAND gate\b", r"\bOR gate\b", r"\bNOT gate\b", r"\bNAND\b",
         r"\bNOR\b", r"\bXOR\b", r"\bXNOR\b", r"\blogic gate", r"\btruth table\b",
         r"\binverter\b"],
        [r"\blogic high\b", r"\blogic low\b"],
    ),
    "Logic circuits and expressions": (
        [r"\blogic circuit\b", r"\blogic expression\b", r"\bboolean expression\b"],
        [r"\bboolean\b"],
    ),
    "De Morgan's law and Boolean simplification": (
        [r"de ?morgan", r"\bsimplify\b.*\bexpression\b", r"\bequivalent to\b.*\+"],
        [],
    ),
    "Notions on organizations and information": (
        [r"\bdata are raw\b", r"\braw facts\b",
         r"\bdata\b.*\bprocessed\b.*\binformation\b"],
        [r"\binformation\b"],
    ),
    "Information systems": (
        [r"\binformation system\b", r"\bstrategic level\b", r"\btactical\b",
         r"\boperational level\b"],
        [],
    ),
    "Types of information system": (
        [r"\btransaction processing\b", r"\bTPS\b", r"\bMIS\b",
         r"\bmanagement information system\b", r"\bdecision support\b",
         r"\bDSS\b", r"\bexpert system\b", r"\bexecutive information\b",
         r"\bknowledge base\b", r"\binference engine\b",
         r"\bbatch process", r"\breal[- ]time\b", r"\bonline processing\b"],
        [],
    ),
    "Data capture methods": (
        [r"\bdata capture\b", r"\bOMR\b", r"\bOCR\b", r"\bMICR\b",
         r"\bbar ?code\b", r"\bvoice recognition\b", r"\bmagnetic ink\b"],
        [],
    ),
    "Data verification and validation": (
        [r"\bvalidation\b", r"\bverification\b", r"\brange check\b",
         r"\blength check\b", r"\bpresence check\b", r"\bformat check\b",
         r"\btype check\b", r"\bconsistency check\b", r"\bproof ?read",
         r"\bdouble entry\b", r"\binput mask\b"],
        [],
    ),
    "Data integrity": (
        [r"\bdata integrity\b", r"\baccuracy and consistency\b"],
        [r"\bintegrity\b"],
    ),
    "Introduction to databases": (
        [r"\bdatabase\b", r"\bDBMS\b", r"\bflat[- ]file\b", r"\btable\b.*\brecord\b",
         r"\bfields?\b", r"\brecords?\b", r"\bdata redundancy\b"],
        [r"\bquery\b", r"\breport generator\b"],
    ),
    "Relational database design": (
        [r"\bprimary key\b", r"\bforeign key\b", r"\bkey field\b",
         r"\brelational\b", r"\brelationship\b", r"\bcommon field\b",
         r"\btuple\b", r"\battribute"],
        [],
    ),
    "Use an RDBMS to create queries and reports": (
        [r"\bSQL\b", r"\bquery\b", r"\bMicrosoft Access\b", r"\bMySQL\b",
         r"\bOracle\b"],
        [],
    ),
    "Stages of SDLC: investigation, analysis, design": (
        [r"\bSDLC\b", r"\bsystem development life cycle\b",
         r"\bfeasibility (?:study|report)\b", r"\bpreliminary investigation\b",
         r"\bsystem analysis\b", r"\bsystem design\b", r"\bsystems analyst\b",
         r"\brequirements\b"],
        [r"\binterviews and questionnaires\b"],
    ),
    "Stages of SDLC: development, testing, implementation, maintenance": (
        [r"\bmaintenance\b", r"\bdocumentation\b", r"\btest plan\b",
         r"\bcorrective maintenance\b", r"\bperfective\b", r"\badaptive\b"],
        [],
    ),
    "Implementation strategies": (
        [r"\bparallel (?:run|conversion)\b", r"\bphased (?:conversion|implementation)\b",
         r"\bpilot (?:run|conversion)\b", r"\bdirect changeover\b",
         r"\bplunge\b", r"\bchange ?over\b", r"\bconversion\b"],
        [],
    ),
    "Introduction to project management": (
        [r"\bproject management\b", r"\bmilestone\b", r"\btriple constraint\b",
         r"\bscope\b.*\bcost\b"],
        [r"\bproject\b"],
    ),
    "Project management tools": (
        [r"\bPERT\b", r"\bgantt\b", r"\bnetwork diagram\b"],
        [],
    ),
    "Project management concepts and metrics 1": (
        [r"\bcritical path\b", r"\bslack (?:time)?\b", r"\bfloat time\b",
         r"\blag time\b", r"\bcritical task\b", r"\bdependent task\b",
         r"\bpredecessor\b", r"\bsuccessor\b"],
        [],
    ),
    "Assistive technology and disabilities": (
        [r"\bassistive\b", r"\bdisabilit", r"\bscreen reader\b",
         r"\bergonomic", r"\brepetitive strain\b", r"\bRSI\b",
         r"\bcarpal tunnel\b", r"\beye ?strain\b"],
        [],
    ),
}

# Which note chapter covers which lessons, and how completely.
NOTE_COVERAGE = {
    "Hardware": [
        ("Input and output peripherals", "full"),
        ("Storage and processing devices", "full"),
        ("Other internal components", "full"),
    ],
    "Number Systems And Representation Of Data": [
        ("Notions on data encoding", "full"),
        ("Character and positive integers encoding", "full"),
        ("Addition and subtraction in base 2, 8 and 16", "full"),
    ],
    "Digital Electronics": [
        ("Logic gates", "full"),
        ("Logic circuits and expressions", "full"),
        ("De Morgan's law and Boolean simplification", "partial"),
    ],
    "Software": [
        ("Types of application software", "full"),
        ("Methods to obtain software", "full"),
        ("Notions on programming paradigms", "partial"),
        ("Assistive technology and disabilities", "background"),
    ],
    "Database Organisation": [
        ("Introduction to databases", "full"),
        ("Relational database design", "full"),
        ("Normalization and Relational models", "partial"),
        ("Simple data types", "partial"),
        ("Use an RDBMS to create tables", "background"),
        ("Notions on security", "background"),
    ],
    "Information Systems": [
        ("Notions on organizations and information", "full"),
        ("Information systems", "full"),
        ("Types of information system", "full"),
        ("Data capture methods", "full"),
        ("Data verification and validation", "full"),
        ("Data integrity", "full"),
        ("Stages of SDLC: investigation, analysis, design", "full"),
        ("Stages of SDLC: development, testing, implementation, maintenance", "full"),
        ("Implementation strategies", "full"),
        ("Introduction to project management", "full"),
        ("Project management tools", "full"),
        ("Project management concepts and metrics 1", "full"),
    ],
    "Algorithms": [
        ("Algorithms to solve common problems 1", "full"),
        ("Algorithms to solve common problems 2", "full"),
        ("Algorithm correctness and efficiency", "full"),
        ("Notions on subroutines", "partial"),
        ("Coding 1", "full"),
        ("Coding 2", "partial"),
        ("Simple data types", "partial"),
        ("Notions on programming paradigms", "full"),
    ],
    "The Range And Scope Of Computers": [
        ("Notions on security", "partial"),
        ("Threats and attacks on computer systems", "full"),
        ("Protecting Intellectual property", "full"),
        ("Assistive technology and disabilities", "full"),
        ("Notions on social networks", "partial"),
    ],
}
