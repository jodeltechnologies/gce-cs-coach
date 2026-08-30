"""
Form 5 lesson notes — Term 1.

One note per lesson on the progression sheet, sized for the hour it is taught
in. Not one note per chapter: a chapter is three or four lessons of material,
and handing a student a chapter the night before a test is why nobody reads it.

House rules for the writing, which matter more than they sound:

  Short sentences. A Form 5 student reading in their second or third language
  should not have to unpick a clause.

  Say the thing, then the example. "RAM forgets everything when the power
  goes. That is why you lose an unsaved document when the light goes off."

  Cameroonian examples where one fits naturally — MTN, a shop in Limbe, a
  school register — because an example you recognise is one you remember.

  No filler. No "in today's digital world", no "it is important to note that",
  no sentence that would survive being deleted.

  Exam wording where the exam is fussy about it, flagged as such, because a
  student who writes "it forgets" instead of "volatile" loses the mark.

Each entry: the lesson title exactly as it appears on the progression sheet,
and HTML using <h3>, <p>, <ul>, and <div class="def-box"> for a definition.
"""

TERM1 = {

"Simple data types": """
<p>Every piece of data in a program has a <strong>type</strong>. The type says
what kind of value it is, what you can do with it, and how much memory it
takes.</p>

<div class="def-box"><strong>Data type:</strong> a set of values, together with
the operations you are allowed to perform on them.</div>

<h3>The simple types</h3>
<ul>
<li><strong>Integer</strong> — whole numbers, no decimal point. 0, 47, -12.
Number of students in a class. Number of goals.</li>
<li><strong>Real</strong> (also called float) — numbers with a decimal point.
1.75, -0.5. A height, a price, an average.</li>
<li><strong>Character</strong> — one single symbol. 'A', '7', '?'. Note that
the character '7' is not the number 7. You cannot add it.</li>
<li><strong>String</strong> — a run of characters. "Ngwa Divine", "MBJ/2024".
A name, an address, a matricule.</li>
<li><strong>Boolean</strong> — only two values, true or false. Is the student
present? Is the mark above 10?</li>
</ul>

<h3>Choosing the right one</h3>
<p>Ask two questions. Will it ever need a decimal point? Then it is real, not
integer. Will you ever do arithmetic on it?</p>
<p>That second question catches people. A phone number looks like a number, but
you never add two phone numbers together, and 677112233 stored as a number
loses a leading zero. A phone number is a <strong>string</strong>. So is a
matricule. So is a bank account number.</p>

<h3>In the exam</h3>
<p>You will be given a table and asked for the data type of each field. Watch
for:</p>
<ul>
<li>Date of birth — <strong>date</strong>, not string, if date is offered.</li>
<li>Price or salary — <strong>currency</strong> if offered, otherwise real.</li>
<li>Sex, or Yes/No fields — <strong>Boolean</strong>.</li>
<li>Anything with letters in it — <strong>string</strong>, however numeric it
looks.</li>
</ul>
""",

"Data structures": """
<p>A data type describes <em>one</em> value. A data structure holds
<em>many</em> values together and gives them an arrangement.</p>

<div class="def-box"><strong>Data structure:</strong> a way of organising a
collection of data so it can be stored and used efficiently.</div>

<h3>Array</h3>
<p>A numbered row of boxes, all the same type. If you have the marks of 40
students, you do not want 40 separate variables. You want one array of 40.</p>
<p>You reach a value by its <strong>index</strong>: marks[0] is the first,
marks[1] the second. Counting starts at 0 in most languages, which is the
single most common place to lose a mark.</p>
<p>A <strong>two-dimensional array</strong> is a table — rows and columns. Marks
for 40 students across 6 subjects.</p>

<h3>Record</h3>
<p>A group of related values that are <em>not</em> the same type, kept
together. One student: name (string), age (integer), fees paid (Boolean). An
array holds many of one thing; a record holds one of many things.</p>

<h3>Stack</h3>
<p>Last In, First Out. Like a pile of plates — the last one you put on is the
first one you take off. Used for the undo button, and for the back button in a
browser.</p>

<h3>Queue</h3>
<p>First In, First Out. Like the line at a bank — first to arrive is first
served. Used for a printer: jobs print in the order they were sent.</p>

<h3>Remember the pair</h3>
<p>Stack = LIFO. Queue = FIFO. If the question mentions undo, back button, or
reversing something, it is a stack. If it mentions waiting, a line, or a
printer, it is a queue.</p>
""",

"Notions on programming paradigms": """
<p>A paradigm is a <em>style</em> of programming — a way of thinking about how
to describe a solution to the computer.</p>

<div class="def-box"><strong>Programming paradigm:</strong> a model or approach
that a class of programming languages follows.</div>

<h3>Imperative</h3>
<p>You write the steps, in order, and the computer follows them. "Get the
price. Multiply by the quantity. Print the total." Most of what you write is
imperative.</p>
<p><strong>Procedural</strong> is imperative with the steps grouped into named
blocks you can reuse — procedures and functions. Examples: C, Pascal, COBOL,
FORTRAN.</p>

<h3>Declarative</h3>
<p>You describe <em>what</em> you want, not how to get it. The language works
out the how. A database query says "give me all students in Form 5" and never
says how to search the table.</p>
<p>Examples: SQL, Prolog, LISP, Haskell.</p>

<h3>Object oriented</h3>
<p>You model the problem as <strong>objects</strong> that hold both data and the
operations on that data. A Student object holds a name and a mark, and knows how
to calculate its own average.</p>
<p>Examples: Java, C++, Python, Visual Basic.</p>

<h3>Telling them apart in the exam</h3>
<p>The question is almost always: which paradigm says what to do rather than how
to do it? The answer is <strong>declarative</strong>. Or: which is based on
objects that contain data and methods? <strong>Object oriented</strong>.</p>
<p>Note that some languages fit more than one. Python is object oriented and
procedural. That is normal and not a trick.</p>
""",

"Algorithms to solve common problems 1": """
<p>An algorithm is a plan. Before you write any code, you write the plan — in
pseudocode, or as a flowchart.</p>

<div class="def-box"><strong>Algorithm:</strong> a set of step-by-step
instructions that solves a problem in a finite amount of time.</div>

<h3>Pseudocode</h3>
<p>English, written with the structure of a program. No language rules, no
semicolons, nothing to compile. You write it so a human can check the logic.</p>
<pre>BEGIN
  Get price, P
  Get quantity, N
  Total &larr; P * N
  Print Total
END</pre>

<h3>Flowchart</h3>
<p>The same plan drawn as a picture. The symbols are fixed, and the exam expects
the right one:</p>
<ul>
<li><strong>Oval</strong> — start or stop.</li>
<li><strong>Parallelogram</strong> — input or output.</li>
<li><strong>Rectangle</strong> — a process: a calculation, an assignment.</li>
<li><strong>Diamond</strong> — a decision, with Yes and No coming out.</li>
<li><strong>Arrow</strong> — the direction of flow.</li>
</ul>

<h3>Which to use</h3>
<p>Pseudocode is faster to write and easier to turn into code. A flowchart shows
the shape of the logic at a glance, and its symbols mean the same thing to
everyone. That last point is the one the exam asks about: flowcharts have the
advantage that their symbols are <strong>universally accepted</strong>.</p>

<h3>A good algorithm</h3>
<ul>
<li><strong>Correct</strong> — gives the right answer for every valid input.</li>
<li><strong>Finite</strong> — it stops. It does not loop forever.</li>
<li><strong>Unambiguous</strong> — every step has exactly one meaning.</li>
<li><strong>Efficient</strong> — does not waste time or memory.</li>
<li><strong>General</strong> — solves every case, not just the one example.</li>
</ul>
""",

"Algorithms to solve common problems 2": """
<p>Two problems come up again and again, and the exam expects both by name:
searching and sorting.</p>

<h3>Linear search</h3>
<p>Start at the first item. Compare. Not it? Move to the next. Keep going until
you find it or run out of list.</p>
<pre>Found &larr; False
FOR each item in the list
    IF item = target THEN
        Found &larr; True
    ENDIF
ENDFOR</pre>
<p>It works on any list, sorted or not. On a list of 1000 names you might check
all 1000. That is its weakness.</p>

<h3>Binary search</h3>
<p>Only works on a <strong>sorted</strong> list. Look at the middle item. Too
big? Throw away the whole top half. Too small? Throw away the bottom half.
Repeat on what is left.</p>
<p>This is how you find a name in a phone book — you do not start at A. A list
of 1000 takes about 10 checks instead of 1000.</p>
<p><strong>The condition matters.</strong> If the list is not sorted, binary
search gives a wrong answer. Say that in the exam.</p>

<h3>Bubble sort</h3>
<p>Go along the list comparing each pair of neighbours. If they are in the wrong
order, swap them. Go along again. Keep going until a whole pass makes no
swaps.</p>
<p>It is called bubble sort because the largest value rises to the end of the
list on each pass, like a bubble.</p>
<p>It is simple and slow. That is the honest summary, and it is what the exam
wants: easy to write, poor on long lists.</p>
""",

"Notions on subroutines": """
<p>A subroutine is a block of code with a name, written once and used many
times.</p>

<div class="def-box"><strong>Subroutine:</strong> a named sequence of statements
that performs a specific task and can be called whenever that task is
needed.</div>

<h3>Two kinds</h3>
<ul>
<li>A <strong>function</strong> returns a value. You call it inside an
expression: <code>average &larr; mean(a, b)</code>.</li>
<li>A <strong>procedure</strong> does something but returns nothing. You call it
as a statement: <code>PrintHeader()</code>.</li>
</ul>

<h3>Why bother</h3>
<ul>
<li>Write once, use many times. Less typing, fewer mistakes.</li>
<li>Fix a bug in one place instead of six.</li>
<li>The main program stays short and readable.</li>
<li>Two people can work on different subroutines at the same time.</li>
</ul>

<h3>Parameters</h3>
<p>A <strong>formal parameter</strong> is the name in the subroutine's
definition — the empty box. An <strong>actual parameter</strong> is the value
you pass in when you call it — what goes in the box.</p>
<pre>FUNCTION area(length, width)      // formal
   RETURN length * width
ENDFUNCTION

a &larr; area(5, 3)                    // actual</pre>

<h3>Local and global</h3>
<p>A <strong>local variable</strong> exists only inside its subroutine. It is
created when the subroutine runs and destroyed when it finishes. Nothing outside
can see it.</p>
<p>A <strong>global variable</strong> exists everywhere in the program.</p>
<p>Prefer local. A global can be changed by any part of the program, so when it
holds a wrong value you have to search everywhere to find out who did it.</p>
""",

"Algorithms as subroutines": """
<p>The small algorithms you use most are worth writing as subroutines once, and
calling forever after. Learn the shape of each — they come up in the exam with
different names on the variables.</p>

<h3>Totalling</h3>
<pre>Total &larr; 0
FOR each number in the list
    Total &larr; Total + number
ENDFOR
RETURN Total</pre>
<p>The line that matters is <code>Total &larr; 0</code> before the loop. Forget
it and your total is whatever was in memory.</p>

<h3>Counting</h3>
<pre>Count &larr; 0
FOR each mark in the list
    IF mark >= 10 THEN
        Count &larr; Count + 1
    ENDIF
ENDFOR</pre>
<p>Totalling adds the values. Counting adds one each time. Do not mix them up —
it is a common slip under pressure.</p>

<h3>Maximum</h3>
<pre>Max &larr; first item
FOR each remaining item
    IF item > Max THEN
        Max &larr; item
    ENDIF
ENDFOR</pre>
<p>Start with the first item, not with zero. If every mark is negative, starting
at zero gives you zero, which is not in the list.</p>
<p>Minimum is the same with <code>&lt;</code> instead of <code>&gt;</code>.</p>

<h3>Swap</h3>
<pre>temp &larr; a
a &larr; b
b &larr; temp</pre>
<p>Three lines, and you need the temporary variable. Write <code>a &larr; b</code>
first and the old value of a is gone forever.</p>
""",

"Algorithm correctness and efficiency": """
<p>An algorithm that runs is not the same as an algorithm that is right. You
check it by hand before you trust it.</p>

<h3>Dry running</h3>
<div class="def-box"><strong>Dry run:</strong> working through an algorithm by
hand, step by step, keeping track of the value of every variable.</div>
<p>You do it with a <strong>trace table</strong>: one column per variable, one
row per step.</p>
<pre>Sum &larr; 0
Count &larr; 1
WHILE Count &lt;= 3 DO
    Sum &larr; Sum + Count
    Count &larr; Count + 1
ENDWHILE</pre>
<table>
<tr><th>Step</th><th>Sum</th><th>Count</th><th>Count &lt;= 3?</th></tr>
<tr><td>start</td><td>0</td><td>1</td><td>Yes</td></tr>
<tr><td>loop 1</td><td>1</td><td>2</td><td>Yes</td></tr>
<tr><td>loop 2</td><td>3</td><td>3</td><td>Yes</td></tr>
<tr><td>loop 3</td><td>6</td><td>4</td><td>No</td></tr>
</table>
<p>Fill one row per line executed. Do not skip rows because you can see the
answer — the marks are for the table, and the mistakes hide in the rows you
skipped.</p>

<h3>Efficiency</h3>
<p>Two algorithms can both be correct and one still be much better.</p>
<ul>
<li><strong>Time</strong> — how many steps it takes. Usually measured by
counting comparisons.</li>
<li><strong>Space</strong> — how much memory it needs.</li>
</ul>
<p>Linear search on 1000 items: up to 1000 comparisons. Binary search on the
same sorted 1000: about 10. Same answer, very different cost.</p>
<p>Efficiency is usually measured by <strong>execution time</strong>. That is
the exam's phrase.</p>
""",

"Coding 1": """
<p>Now the algorithm becomes a program. The logic does not change — only the
rules for writing it down.</p>

<h3>What translates your code</h3>
<ul>
<li>A <strong>compiler</strong> translates the whole program at once, then runs
it. Fast to run, and you get the errors in one long list.</li>
<li>An <strong>interpreter</strong> translates and runs one line at a time.
Slower, but it stops exactly where the problem is.</li>
<li>An <strong>assembler</strong> translates assembly language into machine
code, one instruction to one instruction.</li>
</ul>
<p>Source code is what you write. Object code is what the compiler produces.</p>

<h3>Two kinds of error</h3>
<ul>
<li>A <strong>syntax error</strong> breaks the rules of the language — a missing
semicolon, a misspelled keyword. The program will not run at all.</li>
<li>A <strong>logic error</strong> follows the rules but does the wrong thing.
It runs happily and gives you the wrong answer. Writing <code>+</code> where you
meant <code>-</code>.</li>
</ul>
<p>The compiler catches syntax errors. Nothing catches logic errors except you,
dry running.</p>

<h3>Writing code people can read</h3>
<ul>
<li>Give variables names that say what they hold. <code>total_marks</code>, not
<code>t</code>.</li>
<li>Comment the <em>why</em>, not the what. Everyone can see it adds one.</li>
<li>Indent inside every loop and every IF.</li>
<li>Keep subroutines short enough to see at once.</li>
<li>Initialise variables before you use them.</li>
</ul>

<h3>Totalling and counting in C</h3>
<pre>int total = 0, count = 0, mark, i;
for (i = 0; i &lt; 10; i++) {
    scanf("%d", &amp;mark);
    total = total + mark;
    if (mark &gt;= 10) {
        count = count + 1;
    }
}
printf("Total = %d, Passes = %d", total, count);</pre>
""",

"Coding 2": """
<p>Maximum, minimum and swap, written as subroutines you can call.</p>

<h3>Maximum</h3>
<pre>int maximum(int list[], int n) {
    int max = list[0];
    int i;
    for (i = 1; i &lt; n; i++) {
        if (list[i] &gt; max) {
            max = list[i];
        }
    }
    return max;
}</pre>
<p>Start at <code>list[0]</code>, then loop from <code>1</code>. Starting the
loop at 0 works too but compares the first item with itself, which wastes a
step.</p>

<h3>Minimum</h3>
<p>Identical, with <code>&lt;</code> in place of <code>&gt;</code>. Do not write
it from scratch — copy the maximum and change one symbol.</p>

<h3>Swap</h3>
<pre>void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}</pre>
<p>In C you must pass the <em>addresses</em> for a swap to stick. Pass the
values and the function swaps its own copies, and nothing changes outside. In
pseudocode you can ignore this; in C you cannot.</p>

<h3>Why subroutines here</h3>
<p>You will need maximum inside your sort. You will need swap inside your sort
too. Writing them once now means the sort is four lines instead of fifteen.</p>
""",

"Coding 3": """
<p>Linear search and bubble sort, as code.</p>

<h3>Linear search</h3>
<pre>int search(int list[], int n, int target) {
    int i;
    for (i = 0; i &lt; n; i++) {
        if (list[i] == target) {
            return i;          /* found: give back the position */
        }
    }
    return -1;                 /* not found */
}</pre>
<p>Returning -1 for "not found" is the usual convention, because -1 is never a
valid position. Say what your function returns when it fails — an exam answer
that ignores the not-found case loses a mark.</p>

<h3>Bubble sort</h3>
<pre>void bubble(int list[], int n) {
    int i, j;
    for (i = 0; i &lt; n - 1; i++) {
        for (j = 0; j &lt; n - 1 - i; j++) {
            if (list[j] &gt; list[j + 1]) {
                swap(&amp;list[j], &amp;list[j + 1]);
            }
        }
    }
}</pre>
<p>Two loops. The outer one counts the passes; the inner one does the comparing.
The <code>- i</code> is there because after each pass the largest value is
already parked at the end, so there is no point looking at it again.</p>

<h3>Trace it</h3>
<p>Take the list 5, 2, 9, 1 and dry run the first pass on paper. You should get
2, 5, 1, 9. If you get something else, your swap is wrong, not your loop.</p>
""",

"Coding 4": """
<p>Every language ships with routines already written. Using them is not
cheating — it is faster and less buggy than writing your own.</p>

<h3>Input and output</h3>
<pre>printf("Enter your age: ");
scanf("%d", &amp;age);</pre>
<p>The format specifier says what type you are reading or printing:
<code>%d</code> integer, <code>%f</code> real, <code>%c</code> character,
<code>%s</code> string. Use the wrong one and you get nonsense, not an error.</p>
<p>The <code>&amp;</code> in scanf is the address of the variable. Leave it out
and the program usually crashes.</p>

<h3>Maths</h3>
<pre>#include &lt;math.h&gt;
sqrt(x)     /* square root */
pow(x, y)   /* x to the power y */
abs(x)      /* absolute value */</pre>
<p>You must include the header, or the compiler does not know the function
exists.</p>

<h3>Strings</h3>
<pre>#include &lt;string.h&gt;
strlen(s)        /* how many characters */
strcpy(a, b)     /* copy b into a */
strcmp(a, b)     /* 0 if the two are the same */</pre>
<p>Note <code>strcmp</code> returns <strong>0</strong> when the strings match.
That reads backwards the first few times.</p>

<h3>Integer division</h3>
<p><code>7 / 2</code> gives 3, not 3.5, because both are integers. If you want
3.5, one of them must be real: <code>7.0 / 2</code>.</p>
<p><code>%</code> gives the remainder. <code>7 % 2</code> is 1. Use it to test
whether a number is even: <code>if (n % 2 == 0)</code>.</p>
""",

"Input and output peripherals": """
<p>Input devices bring data in. Output devices send information out. A few do
both.</p>

<h3>Readers you should know by name</h3>
<ul>
<li><strong>OMR</strong> — Optical Mark Reader. Reads pencil marks in boxes.
Used to mark multiple-choice exams.</li>
<li><strong>OCR</strong> — Optical Character Reader. Reads printed or written
text and turns it into text you can edit. Used on bills and forms.</li>
<li><strong>MICR</strong> — Magnetic Ink Character Recognition. Reads the
special ink at the bottom of a cheque. Hard to forge, which is the point.</li>
<li><strong>Barcode reader</strong> — reads the stripes on a product in a shop.
Gives the country, the manufacturer and the product code.</li>
<li><strong>QR code reader</strong> — reads a square code. Holds much more than
a barcode, and a phone camera can read it.</li>
<li><strong>RFID reader</strong> — reads a tag using radio, with no contact and
no line of sight. Used in stock control and staff badges.</li>
<li><strong>Contactless card reader</strong> — RFID at short range, for
payment.</li>
</ul>

<h3>Output</h3>
<ul>
<li><strong>Monitor</strong> — softcopy output. Measured by resolution (number
of pixels), refresh rate (Hz) and size (inches, diagonally).</li>
<li><strong>Printer</strong> — hardcopy output. <strong>Impact</strong> printers
strike the paper: dot matrix, daisy wheel. <strong>Non-impact</strong> do not:
laser, inkjet, thermal.</li>
<li><strong>Speaker, plotter, projector.</strong></li>
</ul>

<h3>Both at once</h3>
<p>A <strong>touchscreen</strong> takes input and shows output. So does an
electronic whiteboard. This is a favourite exam question: name an input/output
device and give two examples.</p>

<h3>The words that earn marks</h3>
<p>Softcopy means on screen. Hardcopy means on paper. A scanner turns hardcopy
into softcopy; a printer does the reverse.</p>
""",

"Storage and processing devices": """
<h3>The CPU</h3>
<p>The processor does the work. Inside it:</p>
<ul>
<li><strong>Control Unit</strong> — fetches instructions, works out what they
mean, and tells everything else what to do. It coordinates; it does not
calculate.</li>
<li><strong>ALU</strong> — Arithmetic and Logic Unit. Does the adding,
subtracting and the comparisons.</li>
<li><strong>Registers</strong> — very small, very fast storage inside the CPU
for what it is working on right now.</li>
</ul>
<p>Speed is measured in hertz — cycles per second. 2.3 GHz is 2.3 billion cycles
each second.</p>

<h3>The machine instruction cycle</h3>
<p>Three steps, repeated for every instruction:</p>
<ul>
<li><strong>Fetch</strong> — the Control Unit copies the instruction from memory
into the CPU.</li>
<li><strong>Decode</strong> — the Control Unit works out what it means.</li>
<li><strong>Execute</strong> — the ALU carries it out.</li>
</ul>
<p>Learn the three words in order. It is asked most years.</p>

<h3>Primary storage</h3>
<ul>
<li><strong>RAM</strong> — holds what is in use now. It is
<strong>volatile</strong>: everything goes when the power goes. That is why an
unsaved document dies when the light goes off.</li>
<li><strong>ROM</strong> — holds the BIOS, the instructions for starting up. It
is <strong>non-volatile</strong> and cannot be changed by the user.</li>
<li><strong>Cache</strong> — a small amount of very fast memory between the CPU
and RAM, holding what has been used most recently.</li>
</ul>

<h3>Secondary storage</h3>
<ul>
<li><strong>Magnetic</strong> — hard disk, magnetic tape. Tape is
<strong>sequential</strong>: to reach the end you pass everything before it.</li>
<li><strong>Optical</strong> — CD (700 MB), DVD (4.7 GB and up), Blu-ray. Read
by laser: a pit reads as 1, a land as 0.</li>
<li><strong>Solid state</strong> — flash drive, memory card, SSD. No moving
parts.</li>
</ul>
<p>On a disk: a <strong>track</strong> is a ring, a <strong>sector</strong> is a
piece of a ring (512 bytes), a <strong>cluster</strong> is a group of sectors,
and a <strong>cylinder</strong> is the same track on every platter.</p>

<h3>Virtual memory</h3>
<p>When RAM is full, the operating system uses part of the hard disk as extra
RAM. It works, and it is slow, because the disk is far slower than RAM.</p>
""",

"Other internal components": """
<h3>The motherboard</h3>
<p>The main circuit board. Everything plugs into it, and it carries the wiring
that lets the parts talk to each other.</p>

<h3>Buses</h3>
<div class="def-box"><strong>Bus:</strong> a set of wires that carries data
between the components of a computer.</div>
<ul>
<li><strong>Address bus</strong> — carries the address of where data should go
or come from. <strong>One direction only</strong>, CPU to memory.</li>
<li><strong>Data bus</strong> — carries the data itself.
<strong>Two directions</strong>.</li>
<li><strong>Control bus</strong> — carries control signals: read, write, ready.
Two directions.</li>
</ul>
<p>The exam asks which bus carries the location of data. Address bus. The trap
answer is "location bus", which does not exist.</p>

<h3>Expansion slots and cards</h3>
<p>A slot is the socket; a card is what goes in it, adding a capability the
motherboard does not have.</p>
<ul>
<li><strong>Graphics card</strong> — drives the monitor.</li>
<li><strong>Sound card</strong> — drives the speakers and takes microphone
input.</li>
<li><strong>Network card (NIC)</strong> — connects to a network.</li>
<li><strong>TV tuner card</strong> — receives television signals.</li>
</ul>

<h3>Ports</h3>
<ul>
<li><strong>USB</strong> — Universal Serial Bus. Almost everything.</li>
<li><strong>VGA / HDMI</strong> — monitor. HDMI carries sound as well.</li>
<li><strong>Ethernet (RJ-45)</strong> — network cable.</li>
<li><strong>Modem (RJ-11)</strong> — telephone line. Looks like RJ-45 but
smaller.</li>
<li><strong>PS/2</strong> — older keyboard and mouse.</li>
</ul>
<p>Ports are the pathway between the computer and its peripherals. That phrasing
is what the mark scheme wants.</p>
""",

"Types of application software": """
<p>System software runs the machine. Application software does the work you
actually wanted done.</p>

<h3>System software</h3>
<ul>
<li><strong>Operating system</strong> — manages memory, tasks, files, users and
security, and gives you an interface. Windows, Linux, Android, macOS.</li>
<li><strong>Utility software</strong> — small tools that keep the system tidy:
disk defragmenter, backup, compression, antivirus.</li>
<li><strong>Device drivers</strong> — let the OS talk to a piece of hardware.
No driver, no printer.</li>
<li><strong>Translators</strong> — compiler, interpreter, assembler.</li>
</ul>

<h3>Application software</h3>
<ul>
<li><strong>Word processor</strong> — letters, reports. Word, LibreOffice
Writer.</li>
<li><strong>Spreadsheet</strong> — calculations, charts. Excel, Calc.</li>
<li><strong>Database</strong> — storing and querying records. Access, MySQL.</li>
<li><strong>Presentation</strong> — slides. PowerPoint.</li>
<li><strong>Desktop publishing</strong> — posters, newsletters. Publisher.</li>
<li><strong>Graphics</strong> — images. Photoshop.</li>
<li><strong>Browser</strong> — web pages. Chrome, Firefox.</li>
</ul>

<h3>Three ways to get application software</h3>
<ul>
<li><strong>General purpose</strong> — does many jobs, sold off the shelf. A
word processor.</li>
<li><strong>Special purpose</strong> — does one job well, still off the shelf.
Accounting software.</li>
<li><strong>Custom written</strong> (bespoke, tailor-made) — built for one
organisation's exact needs. Expensive, and fits perfectly.</li>
</ul>

<h3>A distinction worth keeping straight</h3>
<p>An operating system is <strong>not</strong> utility software, and it is not
application software. If a question lists Windows among a set of utilities, the
odd one out is Windows.</p>
""",

"Methods to obtain software": """
<p>How you get software decides what you are allowed to do with it.</p>

<h3>The licences</h3>
<ul>
<li><strong>Public domain</strong> — no owner, no copyright. Copy it, sell it,
change it. Often poor quality.</li>
<li><strong>Freeware</strong> — free to use, but still copyrighted. You may not
sell it or change it. The owner keeps control.</li>
<li><strong>Shareware</strong> — free for a trial period, then you pay. Some
versions stop after 30 days; some have features switched off until you buy.</li>
<li><strong>Open source</strong> — the source code is published, so anyone can
read it and improve it. Linux, MySQL, Mozilla, LibreOffice.</li>
<li><strong>All rights reserved</strong> (commercial, proprietary) — you buy a
licence to use it under the terms in the agreement. You do not own it.</li>
</ul>

<h3>Free and open source are different things</h3>
<p>Freeware costs nothing but you cannot see or change the code. Open source
lets you see and change the code, and does not have to be free. Questions play
on this difference, so read them carefully.</p>

<h3>What the licence forbids</h3>
<p>When you buy software you normally may not:</p>
<ul>
<li>give a copy to a friend</li>
<li>make copies and sell them</li>
<li>put it on a network unless the licence says you may</li>
<li>rent it out</li>
</ul>
<p>Making and distributing illegal copies is <strong>software piracy</strong>,
and it is the most widely practised computer crime.</p>

<h3>Choosing</h3>
<p>A school with no budget and forty machines: open source. A business needing
support and someone to blame: commercial. Trying something before committing:
shareware.</p>
""",

"Using a word processor 1": """
<p>A practical lesson. You will be marked on whether the document looks like the
one in the question paper, so work through the instructions in the order
given.</p>

<h3>Formatting text</h3>
<ul>
<li><strong>Font</strong> — the typeface, the size in points, and bold, italic
or underline.</li>
<li><strong>Alignment</strong> — left, centre, right, justified.</li>
<li><strong>Line spacing</strong> — single, 1.5, double.</li>
<li><strong>Indent</strong> — how far the text starts from the margin.</li>
</ul>
<p>Select the text <em>first</em>, then apply the formatting. Applying it first
and typing afterwards catches people out under time pressure.</p>

<h3>Tables</h3>
<p>Insert, then choose rows and columns. Afterwards you can:</p>
<ul>
<li><strong>Merge cells</strong> — join several into one. Used for a heading
across the top of a table.</li>
<li>Add or delete a row or column.</li>
<li>Change borders and shading.</li>
</ul>
<p>"Merge and centre cells A1 to D1" is a standard instruction. It means select
those cells, merge them, then centre the text.</p>

<h3>Graphics</h3>
<p>Insert a picture, then set <strong>text wrapping</strong> so the words flow
around it. <strong>Cropping</strong> cuts off part of an image — and it is
reversible, because the cut part is hidden rather than deleted.</p>

<h3>Tools that earn easy marks</h3>
<ul>
<li><strong>Spell check</strong> — finds misspelled words.</li>
<li><strong>Thesaurus</strong> — suggests words with the same meaning.</li>
<li><strong>Find and replace</strong> — changes every occurrence at once.</li>
<li><strong>Word wrap</strong> — moves the cursor to the next line automatically
when the current line is full. You never press Enter at the end of a line.</li>
<li><strong>Watermark</strong> — faint text or an image behind the page.</li>
</ul>

<h3>Save properly</h3>
<p>Save with the exact file name the question asks for, in the exact format.
A file the examiner cannot find scores nothing.</p>
""",

"Using a word processor 2": """
<p>This lesson is one task: reproduce a document of up to two pages from a
printed copy. Everything is in the detail.</p>

<h3>Work in this order</h3>
<ul>
<li>Set the page up first — size, orientation, margins. Doing it last reflows
everything you have already placed.</li>
<li>Type all the text, plainly, with no formatting.</li>
<li>Then format: headings, bold, sizes, alignment.</li>
<li>Then insert tables and pictures.</li>
<li>Then headers, footers and page numbers.</li>
<li>Save with the name you were given.</li>
</ul>
<p>Typing everything first is the important one. Formatting as you go means
redoing it every time the text moves.</p>

<h3>What examiners look at</h3>
<ul>
<li>Is the text correct, with no spelling mistakes you introduced?</li>
<li>Are headings the right size, weight and alignment?</li>
<li>Does the table have the right number of rows and columns, with the right
cells merged?</li>
<li>Is the picture in the right place, at a sensible size, with text wrapping
around it?</li>
<li>Is there a header or footer if one was asked for?</li>
<li>Is the file named exactly as instructed?</li>
</ul>

<h3>Habits that save you</h3>
<ul>
<li>Press Ctrl+S every few minutes. Power cuts do not wait.</li>
<li>Use the ruler to line things up rather than pressing space repeatedly.</li>
<li>Use the paragraph mark button to see the spaces and returns you cannot
otherwise see.</li>
<li>Compare against the printed copy at the end, line by line.</li>
</ul>
""",

"Solve problems with spreadsheets 1": """
<p>A spreadsheet is a grid. Columns have letters, rows have numbers, and a cell
is named by the two together: C5 is column C, row 5.</p>

<h3>Formulas</h3>
<p>Every formula starts with <code>=</code>. Without it you have typed text.</p>
<pre>=B2+C2          add two cells
=B2*C2          multiply
=SUM(B2:B10)    add a range
=AVERAGE(B2:B10)
=MAX(B2:B10)   =MIN(B2:B10)
=COUNT(B2:B10)  how many numbers
=IF(B2&gt;=10, "Pass", "Fail")</pre>

<div class="def-box"><strong>Function:</strong> a pre-programmed formula built
into the spreadsheet, such as SUM or AVERAGE.</div>

<h3>Ranges</h3>
<p>A colon means "everything from here to there". <code>A2:C6</code> is
3 columns by 5 rows, which is <strong>15 cells</strong>. Count carefully:
C minus A is 2, plus 1, gives 3 columns. 6 minus 2 is 4, plus 1, gives 5
rows.</p>

<h3>Relative and absolute</h3>
<p>Copy <code>=B2*C2</code> down one row and it becomes <code>=B3*C3</code>. The
references move with it. That is <strong>relative</strong>, and usually what you
want.</p>
<p>Sometimes it is not. If the tax rate sits in F1 and you copy
<code>=B2*F1</code> down, the second row looks in F2, which is empty. Lock it
with dollar signs: <code>=B2*$F$1</code>. That is
<strong>absolute</strong>.</p>
<p>The dollar sign locks what follows it. <code>$F1</code> locks the column,
<code>F$1</code> locks the row, <code>$F$1</code> locks both.</p>

<h3>Formatting</h3>
<ul>
<li>Bold a heading row; merge and centre a title across the table.</li>
<li>Set decimal places, or currency, on number cells.</li>
<li>Widen a column showing <code>#####</code> — that means the number does not
fit, not that anything is wrong.</li>
</ul>
""",

}
