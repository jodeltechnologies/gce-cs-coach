"""
Form 5 lesson notes — Term 3.

Same house rules as term1.py.
"""

TERM3 = {

"Notions on data encoding": """
<p>A computer holds everything — text, pictures, sound, video — as 0s and 1s.
Encoding is how a thing humans understand becomes a pattern of bits.</p>

<h3>The units</h3>
<ul>
<li><strong>Bit</strong> — one binary digit, 0 or 1.</li>
<li><strong>Nibble</strong> — 4 bits.</li>
<li><strong>Byte</strong> — 8 bits. Holds one character.</li>
<li><strong>Kilobyte</strong> — 1024 bytes. <strong>Megabyte</strong> — 1024 KB.
<strong>Gigabyte</strong> — 1024 MB. <strong>Terabyte</strong> — 1024 GB.</li>
</ul>
<p>1024, not 1000, because 1024 is 2<sup>10</sup>. An exam option saying
1 KB = 1000 bytes is the wrong one.</p>

<h3>Character sets</h3>
<ul>
<li><strong>ASCII</strong> — 7 bits, so 2<sup>7</sup> = 128 characters. A = 65,
a = 97, '0' = 48.</li>
<li><strong>EBCDIC</strong> — 8 bits, 256 characters, used on mainframes.</li>
<li><strong>Unicode</strong> — 16 bits, 65,536 characters. Covers every writing
system in the world, and its first 128 characters are the same as ASCII.</li>
<li><strong>BCD</strong> — Binary Coded Decimal. Each decimal digit as 4 bits.
Only 0 to 9 are valid.</li>
</ul>

<h3>The two calculations that come up</h3>
<p><strong>Space for text.</strong> 20 characters at 8 bits each is 160 bits, or
20 bytes.</p>
<p><strong>Bits needed for n things.</strong> Find the smallest power of 2 that
reaches n. 32 characters needs 5 bits, because 2<sup>5</sup> = 32. 26 letters
also needs 5, because 4 bits only reach 16.</p>

<h3>Knowing one letter gives you the rest</h3>
<p>If A is 01000001, then C is two further on: 01000011. Count in binary from
the letter you were given. This is a standard question and it is free marks.</p>
""",

"Character and positive integers encoding": """
<p>The <strong>base</strong> of a number system is how many digits it uses. The
digits always run from 0 to base minus one.</p>

<h3>The four</h3>
<ul>
<li><strong>Binary</strong>, base 2 — 0, 1.</li>
<li><strong>Octal</strong>, base 8 — 0 to 7.</li>
<li><strong>Decimal</strong>, base 10 — 0 to 9.</li>
<li><strong>Hexadecimal</strong>, base 16 — 0 to 9, then A to F for 10 to
15.</li>
</ul>
<p>So a number containing an A must be hexadecimal. A number containing an 8
cannot be octal. That reasoning answers a whole family of questions.</p>

<h3>Decimal to binary</h3>
<p>Divide by 2 repeatedly, writing the remainder each time. Read the remainders
<strong>upwards</strong>.</p>
<pre>25 / 2 = 12 r 1
12 / 2 =  6 r 0
 6 / 2 =  3 r 0
 3 / 2 =  1 r 1
 1 / 2 =  0 r 1
Reading up: 11001</pre>

<h3>Binary to decimal</h3>
<p>Multiply each digit by its place value and add.</p>
<pre>11001 = 16 + 8 + 0 + 0 + 1 = 25</pre>
<p>The place values from the right: 1, 2, 4, 8, 16, 32, 64, 128. Learn them.</p>

<h3>Binary to octal and hexadecimal</h3>
<p>Because 8 = 2<sup>3</sup>, group the bits in <strong>threes</strong> from the
right and write each group as one octal digit.</p>
<p>Because 16 = 2<sup>4</sup>, group in <strong>fours</strong> for
hexadecimal.</p>
<pre>1011101 -> 001 011 101 -> 135 (octal)
1011101 -> 0101 1101 -> 5D (hex)</pre>
<p>Pad the left group with zeros. Going the other way, replace each digit with
its 3 or 4 bits.</p>
""",

"Addition and subtraction in base 2, 8 and 16": """
<h3>Binary addition</h3>
<p>Four rules:</p>
<pre>0 + 0 = 0
0 + 1 = 1
1 + 0 = 1
1 + 1 = 10   (write 0, carry 1)
1 + 1 + 1 = 11  (write 1, carry 1)</pre>
<p>The last one is the carry case, and it is where marks are lost.</p>
<pre>  1101
+  101
------
 10010</pre>
<p>Check by converting: 13 + 5 = 18, and 10010 is 16 + 2 = 18. Correct.</p>

<h3>Binary subtraction</h3>
<pre>0 - 0 = 0
1 - 0 = 1
1 - 1 = 0
0 - 1 = borrow 1 from the left, making it 10 - 1 = 1</pre>
<pre>  101111
- 100110
--------
    1001</pre>
<p>47 - 38 = 9, and 1001 is 9. Correct.</p>

<h3>Always check</h3>
<p>Convert both numbers to decimal, do the sum, convert the answer back. It
takes twenty seconds and it catches every carry mistake.</p>

<h3>Octal and hexadecimal</h3>
<p>Same method, different carry point. In octal you carry when the column
reaches 8; in hex when it reaches 16.</p>
<pre>Octal:  5 + 4 = 11   (9 is 8 + 1, so write 1 carry 1)
Hex:    9 + 8 = 11   (17 is 16 + 1, so write 1 carry 1)
Hex:    A + 5 = F    (10 + 5 = 15, and 15 is F)</pre>
<p>If octal or hex arithmetic is unfamiliar, convert to binary, work there, and
convert back. Slower, and reliable.</p>
""",

"Logic gates": """
<p>A logic gate is an electronic switch. It takes one or two binary inputs and
gives one binary output.</p>

<h3>The seven</h3>
<ul>
<li><strong>AND</strong> — output 1 only when <em>all</em> inputs are 1.</li>
<li><strong>OR</strong> — output 1 when <em>any</em> input is 1.</li>
<li><strong>NOT</strong> — one input only. Flips it. Also called an
inverter.</li>
<li><strong>NAND</strong> — AND then NOT. Output 0 only when all inputs are
1.</li>
<li><strong>NOR</strong> — OR then NOT. Output 1 only when all inputs are 0.</li>
<li><strong>XOR</strong> — output 1 when the inputs are <em>different</em>.</li>
<li><strong>XNOR</strong> — output 1 when the inputs are the <em>same</em>.</li>
</ul>

<h3>Truth tables</h3>
<table>
<tr><th>A</th><th>B</th><th>AND</th><th>OR</th><th>NAND</th><th>NOR</th><th>XOR</th><th>XNOR</th></tr>
<tr><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>1</td></tr>
<tr><td>0</td><td>1</td><td>0</td><td>1</td><td>1</td><td>0</td><td>1</td><td>0</td></tr>
<tr><td>1</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>1</td><td>0</td></tr>
<tr><td>1</td><td>1</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td></tr>
</table>

<h3>Reading a table backwards</h3>
<p>You will be given an output column and asked which gate it is. Look at the
last row first:</p>
<ul>
<li>Output 1 only in the last row → <strong>AND</strong>.</li>
<li>Output 0 only in the last row → <strong>NAND</strong>.</li>
<li>Output 1 only in the first row → <strong>NOR</strong>.</li>
<li>Output 0 only in the first row → <strong>OR</strong>.</li>
<li>1 in the two middle rows → <strong>XOR</strong>.</li>
<li>1 in the first and last rows → <strong>XNOR</strong>.</li>
</ul>
<p>Also: the only gate with a single input is <strong>NOT</strong>.</p>

<h3>Rows in a table</h3>
<p>2 inputs give 4 rows. 3 inputs give 8. The rule is 2<sup>n</sup>.</p>
""",

"Logic circuits and expressions": """
<p>Gates joined together make a circuit, and every circuit can be written as a
Boolean expression.</p>

<h3>The notation</h3>
<ul>
<li>AND is written as a dot, or nothing at all: A.B or AB.</li>
<li>OR is written as a plus: A + B.</li>
<li>NOT is a bar over the letter, or a dash after it: A'.</li>
</ul>
<p>The plus does not mean addition and the dot does not mean multiplication. In
Boolean algebra 1 + 1 = 1, because it is OR.</p>

<h3>From circuit to expression</h3>
<p>Work left to right. Label the output of each gate, then feed those labels
into the next gate.</p>
<p>If A and B go into an AND, and that output goes into an OR with C, the
expression is <code>(A.B) + C</code>.</p>

<h3>From expression to truth table</h3>
<p>Make a column for every input, a column for each intermediate result, and a
final column for the whole expression. Fill the input columns with every
combination — for two inputs, 00, 01, 10, 11 — then work across.</p>
<p>Do not try to do it in your head. The intermediate columns are where the
marks are.</p>

<h3>From expression to circuit</h3>
<p>Draw the innermost bracket first, then work outwards. Every letter appearing
more than once still comes from one input line, branching.</p>

<h3>Half adder</h3>
<p>The standard example. Two inputs, two outputs:</p>
<ul>
<li>Sum = A XOR B</li>
<li>Carry = A AND B</li>
</ul>
<p>Check it against binary addition: 1 + 1 gives sum 0, carry 1. XOR of 1 and 1
is 0. AND of 1 and 1 is 1. It matches.</p>
""",

"De Morgan's law and Boolean simplification": """
<p>Simplifying an expression means fewer gates, which means a cheaper and faster
circuit.</p>

<h3>De Morgan's laws</h3>
<p>Two rules, and they are worth memorising exactly:</p>
<pre>(A + B)'  =  A' . B'
(A . B)'  =  A' + B'</pre>
<p>In words: break the bar, and change the sign. NOT of an OR becomes AND of the
NOTs, and the other way round.</p>
<p>Check with a truth table if you doubt it. A = 1, B = 0: (A+B)' = (1)' = 0.
A'.B' = 0.1 = 0. They agree.</p>

<h3>The basic laws</h3>
<pre>A + 0 = A          A . 1 = A
A + 1 = 1          A . 0 = 0
A + A = A          A . A = A
A + A' = 1         A . A' = 0
(A')' = A</pre>

<h3>The useful ones</h3>
<pre>A + AB   = A            (absorption)
A(A + B) = A
A + A'B  = A + B</pre>
<p>That last one saves you most often, and it looks wrong until you check it.</p>

<h3>Worked example</h3>
<pre>A.B + A.B'
= A.(B + B')      take A out
= A.1             because B + B' = 1
= A</pre>
<p>Three gates reduced to a wire.</p>

<h3>Method</h3>
<ol>
<li>Use De Morgan to move every bar onto a single letter.</li>
<li>Expand the brackets.</li>
<li>Look for a common factor.</li>
<li>Apply the basic laws.</li>
<li>Check the answer against the original with a truth table.</li>
</ol>
""",

"Notions on organizations and information": """
<h3>Data and information are not the same word</h3>
<div class="def-box"><strong>Data:</strong> raw facts and figures with no
meaning on their own.<br>
<strong>Information:</strong> data that has been processed so that it means
something useful.</div>
<p>17, 14, 9, 18 is data. "The class average is 14.5" is information. Every mark
in the register is data; the position of a student in class is information.</p>

<h3>Good information</h3>
<ul>
<li><strong>Accurate</strong> — wrong information is worse than none.</li>
<li><strong>Complete</strong>.</li>
<li><strong>Timely</strong> — arriving when the decision is still open.</li>
<li><strong>Relevant</strong> to the person receiving it.</li>
<li><strong>Understandable</strong> by them.</li>
</ul>

<h3>Three levels in an organisation</h3>
<ul>
<li><strong>Strategic</strong> — senior managers. Long term plans. Summarised
information, often from outside the organisation. "Should we open a second
campus?"</li>
<li><strong>Tactical</strong> — middle managers. Medium term. "Which subjects
are failing this term?"</li>
<li><strong>Operational</strong> — workers. Day to day, detailed. "Who is absent
today?"</li>
</ul>
<p>Detail decreases and summary increases as you go up. That relationship is the
usual exam question.</p>

<h3>What an information system is made of</h3>
<p>People, hardware, software, data, networks and procedures. Six things — and
people are one of them, which students forget.</p>
""",

"Information systems": """
<div class="def-box"><strong>Information system:</strong> an integrated set of
components for collecting, storing and processing data, and for providing
information and knowledge.</div>

<h3>What it does</h3>
<p>Five activities: <strong>input</strong>, <strong>processing</strong>,
<strong>storage</strong>, <strong>output</strong>, and
<strong>feedback</strong>.</p>
<p>Feedback is the one that gets left out. It is output returned to the input so
the system can correct itself — a stock system noticing sales have fallen and
adjusting what it orders.</p>

<h3>A computer-based information system</h3>
<p>A CBIS uses computer technology as its main component. A paper register is an
information system. A school management system is a CBIS.</p>

<h3>What it gains a school</h3>
<ul>
<li>Many people can use the same information at once.</li>
<li>Large amounts stored in almost no space.</li>
<li>Fast and accurate processing.</li>
<li>Less duplication.</li>
<li>Better information for decisions.</li>
</ul>

<h3>What it costs</h3>
<ul>
<li>Expensive to build and to maintain.</li>
<li>Staff must be trained.</li>
<li>Security becomes a job somebody has to do.</li>
<li>A crash can lose data.</li>
<li>Personal information can be misused.</li>
</ul>

<h3>Examples worth naming</h3>
<p>School management, hospital records, library catalogue, airline reservations,
banking, payroll, stock control.</p>
""",

"Types of information system": """
<p>Different levels of an organisation need different systems.</p>

<h3>Transaction Processing System</h3>
<p>Captures the day-to-day transactions: sales, payments, enrolments.
Operational level.</p>
<ul>
<li><strong>Batch processing</strong> — data collected and processed together
later, with little human involvement. Payroll, electricity bills, report
cards.</li>
<li><strong>Online processing</strong> — processed the moment it is entered. ATM
withdrawals, seat reservations.</li>
</ul>
<p>Batch suits work that is not urgent and comes in bulk. Online suits work
where the answer must be right this second — two people must not book the same
seat.</p>

<h3>Management Information System</h3>
<p>Takes what the TPS collected and produces reports for middle managers.
Summary reports, and exception reports listing only what is out of the
ordinary. Tactical level.</p>

<h3>Decision Support System</h3>
<p>Helps with decisions where the outcome is uncertain. Builds models and
answers "what if" questions. "What if enrolment falls by 15%?" Uses spreadsheets
and databases heavily.</p>

<h3>Executive Information System</h3>
<p>For senior managers. Highly summarised, often graphical, pulling in outside
information as well as internal. Strategic level.</p>

<h3>Expert System</h3>
<p>Acts like a human specialist in one narrow field. Three parts:</p>
<ul>
<li><strong>Knowledge base</strong> — the facts and rules from human experts.</li>
<li><strong>Inference engine</strong> — searches the knowledge base against the
question.</li>
<li><strong>User interface</strong> — how you ask and how it answers.</li>
</ul>
<p>Used for medical diagnosis, mineral prospecting, fault finding.</p>
""",

"Data capture methods": """
<div class="def-box"><strong>Data capture:</strong> collecting data and getting
it into the system.</div>

<h3>Manual capture</h3>
<p>A person types or clicks. The data comes from forms, questionnaires,
interviews or observation. Flexible, slow, and prone to typing errors.</p>

<h3>Automatic capture</h3>
<p>A device reads the data directly, with no typing. Faster and far more
accurate.</p>
<ul>
<li><strong>OMR</strong> — reads pencil marks in boxes. Multiple-choice exam
papers, lottery tickets.</li>
<li><strong>OCR</strong> — reads printed or handwritten characters and turns
them into editable text. Postal codes, utility bills.</li>
<li><strong>MICR</strong> — reads magnetic ink characters at the bottom of a
cheque. Hard to forge, and readable even if the cheque is written over.</li>
<li><strong>Barcode</strong> — reads stripes at a supermarket till. Gives
country, manufacturer and product code.</li>
<li><strong>RFID</strong> — reads a tag by radio, no contact needed, and can
read many tags at once.</li>
<li><strong>Voice recognition</strong> — speech to text or to commands.</li>
<li><strong>Sensors</strong> — temperature, light, pressure, in monitoring
systems.</li>
</ul>

<h3>Choosing</h3>
<p>Ask what the data looks like. Boxes ticked by hand → OMR. Printed text →
OCR. A product on a shelf → barcode. Something the reader cannot touch or see
directly → RFID.</p>

<h3>Outsourcing</h3>
<p>Paying another company to do the capture. Cheaper and faster than hiring, and
it hands your data to somebody else — which is a security decision, not just a
financial one.</p>
""",

"Data verification and validation": """
<p>Two different checks. Exams test whether you know which is which.</p>

<div class="def-box"><strong>Verification:</strong> checking that data entered
matches the original source.<br>
<strong>Validation:</strong> checking that data entered is sensible and
reasonable.</div>

<h3>Verification</h3>
<ul>
<li><strong>Proofreading</strong> — read what you typed against the source
document.</li>
<li><strong>Double entry</strong> — type it twice and let the computer compare.
This is why a new password is always asked for twice.</li>
</ul>

<h3>Validation</h3>
<ul>
<li><strong>Range check</strong> — the value falls between limits. A mark
between 0 and 20.</li>
<li><strong>Type check</strong> — the value is the right data type. A name
containing digits is rejected.</li>
<li><strong>Length check</strong> — the right number of characters. A phone
number of 9 digits.</li>
<li><strong>Presence check</strong> — the field is not empty. This is what a
required field means.</li>
<li><strong>Format check</strong> — the value matches a pattern, given as an
input mask. LL999LL accepts SW499AO.</li>
<li><strong>Consistency check</strong> — two fields agree with each other. Sex
is Male and title is Mrs is inconsistent.</li>
<li><strong>Check digit</strong> — an extra digit calculated from the rest,
catching a mistyped number.</li>
</ul>

<h3>The limit of validation</h3>
<p>Validation checks that data is <em>possible</em>, not that it is
<em>true</em>. A date of birth of 01/01/1990 passes every check. It is still
wrong if you were born in 2008. Only verification catches that.</p>

<h3>The standard question</h3>
<p>Dates come in as DDMMMYY. Which check rejects each of these?</p>
<ul>
<li><code>3MAR90</code> — length check. It is 6 characters, not 7.</li>
<li><code>OCT2198</code> — format check. The parts are in the wrong order.</li>
<li><code>31NOV02</code> — range check. November has 30 days.</li>
</ul>
""",

"Data integrity": """
<div class="def-box"><strong>Data integrity:</strong> the accuracy and
consistency of data throughout its life.</div>
<p><strong>Accuracy</strong> — the values are correct.
<strong>Consistency</strong> — the same fact is the same everywhere it
appears.</p>

<h3>How integrity is lost</h3>
<ul>
<li>Typing errors at entry.</li>
<li><strong>Data redundancy</strong> — the same fact stored in several places,
so an update changes one copy and not the others.</li>
<li>Transmission errors.</li>
<li>Hardware failure or a crash mid-write.</li>
<li>Malware.</li>
<li>Two people editing the same record at once.</li>
</ul>

<h3>Redundancy causes inconsistency</h3>
<p>If Dr Ako's room number is stored against all 100 of his patients and he
moves office, you must change 100 records. Miss one and the database now holds
two different answers to the same question.</p>
<p>That is why relational databases split repeating data into its own table. It
is not tidiness; it is integrity.</p>

<h3>Protecting it</h3>
<ul>
<li>Validation and verification at entry.</li>
<li>Normalisation, to remove redundancy.</li>
<li><strong>Referential integrity</strong> — a foreign key must point at a
record that exists. You cannot enrol a student who is not on the roll.</li>
<li>Access control, so only the right people can edit.</li>
<li>Backups.</li>
<li><strong>Transactions</strong> — a group of changes that either all happen or
none do. A transfer must not take money from one account and fail to add it to
the other.</li>
</ul>
""",

"Introduction to databases": """
<div class="def-box"><strong>Database:</strong> a collection of related data
stored in an organised form.</div>
<p>A <strong>DBMS</strong> — Database Management System — is the software that
creates, manages and queries it. Microsoft Access, MySQL, Oracle, SQL
Server.</p>

<h3>The hierarchy</h3>
<p>bit → byte (character) → <strong>field</strong> →
<strong>record</strong> → <strong>file (table)</strong> →
<strong>database</strong></p>
<ul>
<li>A <strong>field</strong> is one item: a name, a date of birth. A column.</li>
<li>A <strong>record</strong> is all the fields about one person or thing. A
row.</li>
<li>A <strong>table</strong> is a collection of records.</li>
</ul>
<p>Asked for descending order, start at database and work down. Ascending starts
at bit.</p>

<h3>Key field</h3>
<p>A field whose value is different for every record, so it identifies one
record uniquely. Patient Id, matricule, registration number.</p>
<p>A name is not a key: two students can share a name. A phone number is not a
key either, because numbers change and get reassigned. The key must be unique
<em>and</em> stable.</p>

<h3>Flat file databases</h3>
<p>Everything in one table. Fine for something small, like a personal address
book. The problems arrive with size:</p>
<ul>
<li>Data is duplicated, wasting space and slowing queries.</li>
<li>Updates must be made in many places.</li>
<li>More typing, so more errors.</li>
<li>Duplicated data drifts out of step — inconsistency.</li>
</ul>
<p>The fix is a relational database, which is the next lesson.</p>
""",

"Relational database design": """
<p>A relational database splits data into several tables and links them, so no
fact is stored twice.</p>

<h3>Keys</h3>
<ul>
<li><strong>Primary key</strong> — the field that uniquely identifies each
record in <em>this</em> table. Underlined in a diagram.</li>
<li><strong>Foreign key</strong> — a field in this table that is the primary key
of <em>another</em> table. It is what creates the link.</li>
</ul>
<p>A Patients table with Patient Id as primary key, and Doctor Id as a foreign
key pointing at the Doctors table. Doctor Id is primary in Doctors and foreign
in Patients. Same field, two roles.</p>

<h3>Why it is better</h3>
<ul>
<li>Duplicated data is reduced.</li>
<li>Inconsistency is reduced.</li>
<li>Space is not wasted.</li>
<li>Entry is quicker.</li>
<li>An update happens in one place.</li>
</ul>
<p>Dr Ako's room number is stored once. He moves, you change one field, and
every patient record is correct.</p>

<h3>Relationships</h3>
<ul>
<li><strong>One to one</strong> — one student, one exam number.</li>
<li><strong>One to many</strong> — one doctor, many patients. The most
common.</li>
<li><strong>Many to many</strong> — many students take many subjects. This
cannot be built directly; it needs a third table joining the two.</li>
</ul>

<h3>The rule to remember</h3>
<p>To link two tables the common field must be the primary key in one of
them.</p>
""",

"Normalization and Relational models": """
<div class="def-box"><strong>Normalisation:</strong> organising the tables of a
database to reduce redundancy and improve integrity.</div>
<p>It is done in stages called normal forms.</p>

<h3>First normal form (1NF)</h3>
<p>No repeating groups, and every cell holds a single value.</p>
<p>A Student table with Subject1, Subject2, Subject3 breaks 1NF. So does one
Subjects field containing "Maths, Physics, Chemistry". Split the subjects into
their own table with one row each.</p>

<h3>Second normal form (2NF)</h3>
<p>In 1NF, and every non-key field depends on the <em>whole</em> primary key,
not just part of it.</p>
<p>This only bites when the key is made of two fields. If the key is
(StudentId, SubjectId) and you also store StudentName, the name depends only on
StudentId — half the key. Move it to the Students table.</p>

<h3>Third normal form (3NF)</h3>
<p>In 2NF, and no non-key field depends on another non-key field.</p>
<p>If a Patients table stores DoctorId and also DoctorName, the name depends on
the doctor, not on the patient. Move both to a Doctors table.</p>

<h3>The summary line</h3>
<p>Every field depends on the key, the whole key, and nothing but the key.</p>

<h3>What it buys, and what it costs</h3>
<p>Buys: less duplication, fewer inconsistencies, easier updates.</p>
<p>Costs: more tables, so a query has to join them, which takes longer. Very
large systems sometimes denormalise deliberately for speed. Knowing that is
worth a mark in a discussion question.</p>
""",

"Use an RDBMS to create tables": """
<p>Practical. Building the tables in Microsoft Access, or the equivalent.</p>

<h3>Design view first</h3>
<p>Create the table in Design View, not by typing into a datasheet. Design View
is where you set the field names, data types and properties, and those are what
the marks are for.</p>

<h3>Choosing data types</h3>
<ul>
<li><strong>Short Text</strong> — names, addresses, matricules, phone
numbers.</li>
<li><strong>Number</strong> — anything you will calculate with.</li>
<li><strong>Date/Time</strong> — dates of birth, dates of admission.</li>
<li><strong>Currency</strong> — fees, prices.</li>
<li><strong>Yes/No</strong> — a Boolean field.</li>
<li><strong>AutoNumber</strong> — a number the database allocates, useful as a
primary key when nothing natural fits.</li>
</ul>
<p>Phone number is text. It never gets added, and a leading zero must
survive.</p>

<h3>Field properties</h3>
<ul>
<li><strong>Field Size</strong> — a matricule of exactly 6 characters.</li>
<li><strong>Required</strong> — Yes makes it a presence check.</li>
<li><strong>Validation Rule</strong> — <code>&gt;=0 And &lt;=20</code> for a
mark.</li>
<li><strong>Validation Text</strong> — the message shown when the rule
fails.</li>
<li><strong>Input Mask</strong> — the pattern for a format check.</li>
<li><strong>Default Value</strong>.</li>
</ul>

<h3>Primary key</h3>
<p>Select the field and click the key icon. A table without a primary key cannot
take part in a relationship, so this is not optional.</p>

<h3>Typical instruction</h3>
<p>"Add a field MATRICULE, set it as primary key, data type Number, field size
6, Required Yes." Do all four parts. Each is a mark.</p>
""",

"Use an RDBMS to create relationships": """
<p>Practical. Joining the tables you built.</p>

<h3>Before you start</h3>
<ul>
<li>Every table has a primary key.</li>
<li>The linking fields are the <strong>same data type</strong> in both tables.
This is the usual reason a relationship refuses to be created — Number in one
table and Text in the other.</li>
<li>Close every table. Access will not change relationships while a table is
open.</li>
</ul>

<h3>Creating one</h3>
<p>Database Tools → Relationships. Add the tables. Drag the primary key of one
onto the matching foreign key of the other. A dialog opens.</p>

<h3>Enforce referential integrity</h3>
<p>Tick it. It means the database refuses to hold a record whose foreign key
points at nothing — no patient assigned to a doctor who does not exist.</p>
<p>Two further options:</p>
<ul>
<li><strong>Cascade Update</strong> — change a primary key and every reference
to it changes too.</li>
<li><strong>Cascade Delete</strong> — delete a record and everything referring
to it goes as well. Powerful, and dangerous: deleting one doctor could remove
every one of their patients. Think before ticking it.</li>
</ul>

<h3>Reading the diagram</h3>
<p>The <strong>1</strong> and the <strong>∞</strong> on the join line show which
side is one and which is many. One doctor, many patients: the 1 sits at the
Doctors end.</p>

<h3>If it will not join</h3>
<p>Check the data types match, check the field on the "one" side is the primary
key, and check for existing data that already breaks the rule.</p>
""",

"Use an RDBMS to create queries and reports": """
<p>A database is only as useful as the questions you can ask it.</p>

<h3>Queries</h3>
<div class="def-box"><strong>Query:</strong> a request that selects records
matching stated conditions.</div>
<p>In Design View: choose the tables, choose the fields, then put conditions in
the Criteria row.</p>
<pre>&gt;=10                  marks of 10 and above
"Form 5"              exactly Form 5
Like "N*"             names beginning with N
Between 10 And 15
Is Null               the field is empty
&lt;&gt;"Limbe"             not Limbe</pre>
<p>Criteria on the <strong>same row</strong> are AND — both must be true.
Criteria on <strong>different rows</strong> are OR.</p>

<h3>Sorting and totals</h3>
<p>Set Ascending or Descending on any field. Turn on Totals to group and count,
sum or average — how many students per class, the average mark per subject.</p>

<h3>The same thing in SQL</h3>
<pre>SELECT Name, Mark
FROM Students
WHERE Mark &gt;= 10
ORDER BY Mark DESC;</pre>
<p>SELECT the fields, FROM the table, WHERE the condition, ORDER BY the
sort.</p>

<h3>Reports</h3>
<p>A report is a query formatted for printing. Built from a table or from a
query — usually a query, because that is where the filtering lives.</p>
<ul>
<li><strong>Grouping</strong> — break the report by class, with each group
together.</li>
<li><strong>Sorting</strong> within each group.</li>
<li><strong>Totals</strong> in a group footer.</li>
<li><strong>Page header and footer</strong> — title, date, page numbers.</li>
</ul>
<p>A form is for entering data on screen. A report is for printing it out. Do
not mix the two words up in the exam.</p>
""",

"Stages of SDLC: investigation, analysis, design": """
<div class="def-box"><strong>SDLC:</strong> System Development Life Cycle — the
stages a new information system goes through from idea to working
system.</div>
<p>Investigation → Analysis → Design → Development → Implementation →
Maintenance. Learn them in order.</p>

<h3>Investigation</h3>
<p>A short study of the current system to see whether a new one is worth
building.</p>
<ul>
<li>Gather information: interviews, questionnaires, observation, existing
documents.</li>
<li>Identify what is wrong with the current system.</li>
<li>Carry out a <strong>feasibility study</strong>.</li>
</ul>
<p><strong>Output: the feasibility report.</strong></p>
<p>Feasibility asks: is it technically possible, can we afford it, is there
time, will the staff accept it, is it legal?</p>

<h3>Analysis</h3>
<p>A detailed study of what users actually need. Analysis says <strong>what</strong>
the system must do — never how.</p>
<ul>
<li>Collect data about the current system.</li>
<li>Identify its inputs, processing and outputs.</li>
<li>State the requirements of the new system.</li>
</ul>
<p><strong>Output: the requirements specification.</strong></p>

<h3>Design</h3>
<p>Design says <strong>how</strong> it will do it.</p>
<ul>
<li>Design the input forms.</li>
<li>Design the printed reports and the screen outputs.</li>
<li>Design the data structures: tables, fields, types.</li>
<li>Write the validation rules.</li>
<li>Write the test plan and the test data.</li>
</ul>
<p><strong>Output: the system specification.</strong></p>

<h3>The distinction that is examined</h3>
<p>Analysis = what. Design = how. If a question describes drawing a data entry
form, that is design. If it describes interviewing users, that is
investigation.</p>
""",

"Stages of SDLC: development, testing, implementation, maintenance": """
<h3>Development</h3>
<p>Building it. Buying the hardware, writing the programs, testing them, and
producing documentation.</p>
<p>Two kinds of documentation, and the exam wants both distinguished:</p>
<ul>
<li><strong>User documentation</strong> — how to install it, how to run it,
what the errors mean, how to back up. Written for the person using it.</li>
<li><strong>Technical documentation</strong> — data structures, code listings,
flowcharts, test plans, validation rules. Written for the person who will
maintain it.</li>
</ul>

<h3>Testing</h3>
<p>Test with three kinds of data:</p>
<ul>
<li><strong>Normal</strong> — a mark of 15 where the range is 0 to 20.</li>
<li><strong>Extreme (boundary)</strong> — 0 and 20. The edges are where the
mistakes live.</li>
<li><strong>Abnormal</strong> — 25, or the word "twelve". The system should
reject these politely, not crash.</li>
</ul>

<h3>Implementation</h3>
<p>Moving from the old system to the new one. Install, load the data, train the
users.</p>

<h3>Maintenance</h3>
<p>Keeping it working after delivery. Three kinds:</p>
<ul>
<li><strong>Corrective</strong> — fixing faults found in use.</li>
<li><strong>Perfective</strong> — improving performance.</li>
<li><strong>Adaptive</strong> — changing it to meet new requirements, such as a
new law.</li>
</ul>
<p>Maintenance is the longest stage. A system runs for years and is built in
months.</p>
""",

"Implementation strategies": """
<p>Four ways to change over from the old system to the new. Each question asks
you to choose one and justify it.</p>

<h3>Direct changeover (plunge)</h3>
<p>Switch the old off on Friday, switch the new on on Monday.</p>
<p><strong>For:</strong> fastest, cheapest, no duplicated work.<br>
<strong>Against:</strong> no fallback. If the new system fails you have nothing,
and data can be lost.</p>

<h3>Parallel running</h3>
<p>Both systems run side by side, with everything entered into both, until you
are confident.</p>
<p><strong>For:</strong> the old system is a safety net, and the two outputs can
be compared to prove the new one is right.<br>
<strong>Against:</strong> everything is done twice, so it is expensive and
tiring for staff.</p>

<h3>Pilot running</h3>
<p>The new system is used by one part of the organisation first — one office,
one class — then rolled out.</p>
<p><strong>For:</strong> a failure affects only a small group, and the pilot
staff can train everyone else.<br>
<strong>Against:</strong> slow, and the pilot group has no fallback.</p>

<h3>Phased implementation (piecemeal)</h3>
<p>One module at a time. Accounts this term, enrolment next.</p>
<p><strong>For:</strong> staff train gradually, and errors are easier to locate
because only one part is new.<br>
<strong>Against:</strong> no backup for the part being changed, and it only
works where the system splits into modules.</p>

<h3>Choosing in an exam</h3>
<p>Life-critical or money-critical — a bank, a hospital — argue for
<strong>parallel</strong>. Small, low risk, tight budget —
<strong>direct</strong>. Large organisation with branches —
<strong>pilot</strong>. A system built in clear modules —
<strong>phased</strong>. Name the method, then give one advantage and one
disadvantage.</p>
""",

"Introduction to project management": """
<div class="def-box"><strong>Project:</strong> a temporary piece of work with a
specific objective, a set of related tasks, and a definite end.</div>
<p>Temporary is the key word. Running a school is not a project. Building a new
computer lab is.</p>

<h3>The triple constraint</h3>
<ul>
<li><strong>Scope</strong> — what the project will deliver.</li>
<li><strong>Time</strong> — the schedule.</li>
<li><strong>Cost</strong> — the budget and resources.</li>
</ul>
<p>They are connected. Widen the scope and either time or cost must rise. That
relationship is what makes it a constraint and not just a list.</p>

<h3>Vocabulary</h3>
<ul>
<li><strong>Task</strong> — something that needs doing, taking time and
resources.</li>
<li><strong>Dependent task</strong> — one that cannot start until another
finishes. You cannot roof a building before the walls are up.</li>
<li><strong>Milestone</strong> — an event marking the completion of something
significant. Milestones take no time themselves.</li>
<li><strong>Deliverable</strong> — the thing produced.</li>
<li><strong>Resource</strong> — people, money, equipment.</li>
</ul>

<h3>What the manager does</h3>
<p>Plans the tasks and their order, estimates times, allocates people, tracks
progress against the plan, and manages the risks.</p>

<h3>Why projects fail</h3>
<ul>
<li>Unclear scope, or scope that grows without the budget growing.</li>
<li>Times estimated optimistically.</li>
<li>Poor communication.</li>
<li>Not enough people or money.</li>
<li>Risks nobody planned for.</li>
</ul>
""",

"Project management tools": """
<p>Two diagrams. Know which is used when, because that is the question.</p>

<h3>PERT chart</h3>
<p>Project Evaluation and Review Technique. A network diagram: nodes are
activities, lines show what must come before what, and the number on each line
is a duration.</p>
<p>It shows <strong>dependencies</strong> — what has to wait for what. Used
<strong>before</strong> the project starts, to work out the total time
needed.</p>
<p>Reading one: a line from A to B means A must finish before B can start. Lines
from both B and C into D means both must finish before D begins.</p>

<h3>Gantt chart</h3>
<p>A bar chart against a timeline. Tasks down the left, time across the top, one
horizontal bar per task showing when it starts and ends.</p>
<p>It shows <strong>timing and progress</strong> — what should be happening now,
and what overlaps. Used <strong>during</strong> the project, to track it.</p>

<h3>Which one</h3>
<p>Dependencies and total duration, before starting → PERT. Schedule and
tracking, during → Gantt. That single sentence answers most of these
questions.</p>

<h3>Software</h3>
<p>Microsoft Project is the usual example; there are many others. They calculate
the critical path for you and redraw the chart when a task slips.</p>
""",

"Project management concepts and metrics 1": """
<p>The numbers behind the chart.</p>

<h3>Slack (float) time</h3>
<div class="def-box"><strong>Slack time:</strong> how long a task can be delayed
without delaying the whole project.</div>
<p>Tasks A and B both start now, and C needs both finished. A takes 3 days, B
takes 5. C waits for B either way, so A has <strong>2 days of slack</strong>.</p>

<h3>Critical task</h3>
<p>A task with <strong>zero slack</strong>. Delay it by one day and the whole
project is one day late. B, in the example above.</p>

<h3>Critical path</h3>
<div class="def-box"><strong>Critical path:</strong> the sequence of tasks that
determines the earliest possible completion date of the project.</div>
<p>It is the <em>longest</em> path through the network, which is the part
students find backwards. The longest path is the shortest possible project,
because everything else can happen alongside it.</p>
<p>Every task on the critical path is critical, and has zero slack.</p>

<h3>Lag time</h3>
<p>Deliberate waiting between two dependent tasks. Laying blocks then building
on them needs the cement to dry. That gap is lag, and it is planned, not
wasted.</p>

<h3>Finding the critical path</h3>
<ol>
<li>List every path from start to finish.</li>
<li>Add up the durations along each.</li>
<li>The longest total is the critical path, and that total is the project
duration.</li>
</ol>

<h3>Where the manager looks</h3>
<p>At the critical path. A task with slack can slip quietly; a critical task
slipping moves the finish date, so that is where attention and spare resources
go.</p>
""",

"Project management concepts and metrics 2": """
<p>Tracking a project once it is running, and reporting on it.</p>

<h3>Baseline</h3>
<p>The approved plan, saved before work starts. Everything afterwards is
measured against it. Without a baseline "we are behind" means nothing, because
there is nothing to be behind.</p>

<h3>Progress</h3>
<ul>
<li><strong>Percentage complete</strong> per task.</li>
<li><strong>Actual versus planned</strong> — the same comparison for time and
for cost.</li>
<li><strong>Variance</strong> — the difference. Negative variance means over
budget or behind schedule.</li>
<li><strong>Slippage</strong> — how far behind the baseline you are.</li>
</ul>

<h3>Resource levelling</h3>
<p>Adjusting the schedule so nobody is asked to do two things at once. If one
technician is booked on three tasks in the same week, either move a task using
its slack or find another technician.</p>

<h3>Risk</h3>
<p>List what could go wrong, judge how likely it is and how bad it would be, and
plan what you would do. Power cuts, a supplier that does not deliver, a key
person falling ill.</p>
<p>The point of the plan is that the decision is made calmly in advance rather
than in a panic on the day.</p>

<h3>Closing a project</h3>
<ul>
<li>Confirm every deliverable is finished and accepted.</li>
<li>Hand over the documentation.</li>
<li>Train the users.</li>
<li>Release the resources.</li>
<li>Write down what went well and what did not, so the next project starts
better informed.</li>
</ul>
""",

}
