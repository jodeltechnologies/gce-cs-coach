-- Part B of 7 — notes 1 of 5: History and Evolution of computers → Data Representation.
-- Run the parts in alphabetical order, one at a time.
-- Safe to run again if you lose your place.

BEGIN;

-- 19 notes
INSERT INTO note_sections
  (id, note_source_id, chapter_number, title, body, body_format, sequence)
VALUES
  ('9debd194-7b58-5fc1-baeb-9cf2918e015b', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'History and Evolution of computers', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Generations of Computers</li></ul></div><p>The word computer comes from <em>compute</em>, meaning calculate. That is
all the first machines did. Everything since has been the same job done faster,
smaller and cheaper.</p>

<div class="def-box"><strong>Computer generation:</strong> a period in the
history of computers in which the machines shared one major technological
development that changed how they were built and used.</div>

<figure class="fig">
<svg viewBox="0 0 660 150" role="img" aria-label="Timeline of the five computer generations">
  <line x1="20" y1="60" x2="640" y2="60" stroke="currentColor" stroke-width="1.5"/>
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <circle cx="80" cy="60" r="9"/><circle cx="205" cy="60" r="9"/>
    <circle cx="330" cy="60" r="9"/><circle cx="455" cy="60" r="9"/>
    <circle cx="580" cy="60" r="9"/>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="80" y="40">1st</text><text x="205" y="40">2nd</text>
    <text x="330" y="40">3rd</text><text x="455" y="40">4th</text>
    <text x="580" y="40">5th</text>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="80" y="88">1945-1955</text><text x="205" y="88">1955-1965</text>
    <text x="330" y="88">1965-1980</text><text x="455" y="88">1980s</text>
    <text x="580" y="88">present</text>
    <text x="80" y="106">vacuum</text><text x="80" y="120">tube</text>
    <text x="205" y="106">transistor</text>
    <text x="330" y="106">integrated</text><text x="330" y="120">circuit</text>
    <text x="455" y="106">micro-</text><text x="455" y="120">processor</text>
    <text x="580" y="106">artificial</text><text x="580" y="120">intelligence</text>
  </g>
</svg>
<figcaption>The five generations, named after the switching component of each.</figcaption>
</figure>

<h3>What changed, generation by generation</h3>
<ul>
<li><strong>First (1945-1955)</strong> — vacuum tubes. A tube was fragile
glass. The machines filled a room, ate electricity and produced heat that
caused most of the faults. Programmed in machine language, one problem at a
time. Input on punched cards, output on printouts. ENIAC, EDSAC, UNIVAC I.</li>
<li><strong>Second (1955-1965)</strong> — transistors. Smaller, faster,
cheaper, cooler, more reliable. Assembly language arrived, then early COBOL and
FORTRAN. These were the first machines to store their instructions in
memory.</li>
<li><strong>Third (1965-1980)</strong> — integrated circuits. Many transistors
on one silicon chip. Keyboards and monitors replaced cards and printouts, and
an operating system ran several programs at once. Computers reached a mass
audience.</li>
<li><strong>Fourth (1980s)</strong> — the microprocessor: thousands of ICs on a
single chip. What filled a room now fits in the hand. Networks, then the
internet, then the GUI, the mouse and handheld devices.</li>
<li><strong>Fifth (present)</strong> — artificial intelligence. Still being
built, but voice recognition is already in use.</li>
</ul>

<h3>In the exam</h3>
<p>The mark is for the <strong>component</strong>, not the date. Vacuum tube,
transistor, IC, microprocessor, AI. If you can only remember one thing per
generation, remember that one.</p>
<p>Watch the trend the question is really testing: each generation is smaller,
faster, cheaper, cooler and more reliable than the last. Say so.</p>', 'html', 1),
  ('4c2cec61-aeb7-5566-a276-778e0a685ba5', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Practical: Identify software and Hardware', '<p>This hour is done at the machine, not in the exercise book. The point is
that you can put your hand on a component and name it, and open a machine and
say what it is running.</p>

<div class="def-box"><strong>Hardware:</strong> the physical parts of a
computer system, the parts you can touch. <strong>Software:</strong> the
programs and data that tell the hardware what to do.</div>

<h3>What to do</h3>
<ul>
<li>Look at the system unit from outside. Name every port: power, VGA or HDMI,
USB, RJ-45, audio jack. Say what plugs into each.</li>
<li>Open the case if the lab allows. Find the motherboard, the processor under
its fan, the RAM sticks in their slots, the hard disk, the power supply.</li>
<li>Handle the peripherals. Sort them into input, output, storage.</li>
<li>Now the software. Right-click This PC then Properties, or run
<code>winver</code>. Note the operating system and its version.</li>
<li>Open the list of installed programs. Sort what you see into system software
and application software.</li>
</ul>

<h3>The test that catches people</h3>
<p>A CD is hardware. The film on the CD is software. The distinction is not
"small and light versus big and heavy" — it is physical versus instructions.</p>
<p>Firmware sits between the two: software written into a chip. The BIOS is
firmware. If asked, say it is software stored permanently in hardware.</p>

<h3>Write up</h3>
<p>A table with three columns: component, hardware or software, what it does.
Fifteen rows. That table is a revision sheet for the whole of Unit 1 and 2, so
write it neatly the first time.</p>', 'html', 2),
  ('9282f2a9-7a16-54ad-8270-5b0038a910bb', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Definition, types and uses of computing systems', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Commercial and general data processing systems, e.g. banking systems, hospital administration, personnel records systems, stock control systems, order processing systems</li></ul></div><p>A computing system is not just the box. It is hardware, software, data,
procedures and the people who use it, working together for one purpose.</p>

<div class="def-box"><strong>Computer:</strong> an electronic device that
accepts data, stores it, processes it and produces information.</div>

<h3>Commercial and general data processing</h3>
<p>This is where most computers in Cameroon actually are. Large volumes of
routine transactions, each one simple, all of them repeated.</p>
<ul>
<li><strong>Banking systems</strong> — accounts, transfers, cheque clearing,
the ATM network. An ATM asks for the card, asks for the PIN, and only then
allows a transaction.</li>
<li><strong>Hospital administration</strong> — admissions, patient records,
bed allocation, billing, pharmacy stock.</li>
<li><strong>Personnel records systems</strong> — staff files, contracts,
payroll, leave. A school''s list of teachers and their salaries.</li>
<li><strong>Stock control systems</strong> — a database that tracks stock and
tells you when to reorder. A shop in Limbe scans a barcode at the till; the
sale updates the stock level and the sales file at the same time.</li>
<li><strong>Order processing systems</strong> — an order arrives, is checked
against stock and credit, is picked, invoiced and dispatched.</li>
</ul>

<h3>Why stock control is the favourite exam example</h3>
<p>Because the reasoning is easy to state. Too much stock costs money to store,
and perishable stock spoils before it sells. Too little stock and you run out
before the next delivery. The system holds the level between the two and
reorders automatically.</p>

<h3>In the exam</h3>
<p>Given a business, name the system and say what it stores and what it
produces. "A stock control system. It stores item codes, descriptions, prices
and quantities in hand, and it produces reorder lists and sales reports."</p>
<p>Do not answer "a computer". Name the <strong>type of system</strong>.</p>', 'html', 3),
  ('f06d4c59-9312-5505-afe5-4a07f5b06d80', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Communication and Information Systems', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Internet, video conferencing, electronic mail, information retrieval systems, home based communication systems, office automation and library systems</li></ul></div><p>The systems in the last lesson process transactions. These ones move
information between people.</p>

<h3>The services named on the syllabus</h3>
<ul>
<li><strong>Internet</strong> — the global network of networks. Everything
below rides on it.</li>
<li><strong>Video conferencing</strong> — live two-way sound and picture. A
meeting between the Buea and Douala offices with nobody on the road. Needs a
camera, a microphone, a screen and enough bandwidth.</li>
<li><strong>Electronic mail</strong> — messages held on a server until the
recipient collects them. Asynchronous: the two people are never both required
to be present.</li>
<li><strong>Information retrieval systems</strong> — a search engine, a legal
database, a library catalogue. You state a query, it returns matching
records.</li>
<li><strong>Home based communication systems</strong> — internet at home, and
the working, banking and shopping people do from there.</li>
<li><strong>Office automation</strong> — word processing, spreadsheets,
shared diaries, document management. The paperwork of an office done
electronically.</li>
<li><strong>Library systems</strong> — catalogue, loans, returns, reservations,
overdue notices, usually with a barcode on every book and every card.</li>
</ul>

<h3>Advantages, and the price paid</h3>
<ul>
<li>Faster, cheaper and not limited by distance. An email to Yaoundé costs the
same as one to Canada.</li>
<li>One copy of a document, shared, instead of many copies drifting apart.</li>
<li>But: it fails when the power or the network fails, it needs training, and
it removes the face-to-face contact some work depends on.</li>
</ul>

<h3>In the exam</h3>
<p>"Distinguish between email and video conferencing." The distinction is
<strong>asynchronous versus synchronous</strong>, and bandwidth. Say both.</p>', 'html', 4),
  ('958c302a-ec10-506e-86cc-ba61bae34d9c', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Practical: computer system', '<p>Last practical you named parts. This hour you trace what happens between
them, so the machine stops being a box and becomes a path.</p>

<h3>Boot and watch</h3>
<ul>
<li>Power on. The BIOS runs the POST — power-on self test — and checks the
hardware before anything else loads.</li>
<li>The operating system loads from disk into RAM. Note that it must be in RAM
before it can run. Nothing runs from disk.</li>
<li>Log in. The desktop is the operating system''s user interface.</li>
</ul>

<h3>Trace one piece of data</h3>
<p>Type your name into a text editor and save it. Then say out loud where it
was at each moment:</p>
<ul>
<li>Keyboard — <strong>input</strong>.</li>
<li>RAM — held while you worked, <strong>volatile</strong>.</li>
<li>Processor — <strong>processing</strong>, every keystroke handled.</li>
<li>Screen — <strong>output</strong>.</li>
<li>Hard disk on save — <strong>storage</strong>, non-volatile.</li>
</ul>
<p>Now close the file without saving a second edit and reopen it. The unsaved
change is gone. That is volatility, demonstrated rather than defined.</p>

<h3>Inspect the running system</h3>
<ul>
<li>Task Manager, or <code>top</code> on Linux. Look at the process list, the
CPU percentage and the memory in use.</li>
<li>Note that many processes are running while you touch one. That is
multiprogramming, and you will meet it properly in Term 2.</li>
<li>Check free disk space. Compare it with the RAM figure. Disk is far larger
and far slower; that gap is the whole reason for the memory hierarchy.</li>
</ul>', 'html', 5),
  ('6951cc42-fede-51a6-82ff-50f838800e7b', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Application and examples of some computer systems', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Automation, control systems, embedded systems, and robotics</li><li>Monitoring patients in hospitals, chemical process control, traffic control, domestic equipment, automatic navigation systems and industrial robots</li></ul></div><p>The systems here do not wait for a person to type. They read the world with
sensors and act on it, usually without anyone present.</p>

<div class="def-box"><strong>Control system:</strong> a system that uses the
output it measures to adjust its own input, so a physical quantity is kept at a
set value. <strong>Embedded system:</strong> a computer built into a larger
device to control it, and doing nothing else.</div>

<figure class="fig">
<svg viewBox="0 0 620 190" role="img" aria-label="Feedback control loop with sensor, processor, actuator and process">
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="30" y="30" width="120" height="52" rx="6"/>
    <rect x="250" y="30" width="130" height="52" rx="6"/>
    <rect x="470" y="30" width="120" height="52" rx="6"/>
    <rect x="250" y="120" width="130" height="46" rx="6"/>
  </g>
  <g fill="currentColor" font-size="13" text-anchor="middle">
    <text x="90" y="52">Sensor</text><text x="90" y="70">(measures)</text>
    <text x="315" y="52">Processor</text><text x="315" y="70">compares with set value</text>
    <text x="530" y="52">Actuator</text><text x="530" y="70">(motor, valve, heater)</text>
    <text x="315" y="140">The process</text><text x="315" y="157">room, tank, engine</text>
  </g>
  <g stroke="currentColor" stroke-width="1.5" fill="none" marker-end="url(#ah1)">
    <path d="M150 56 H244"/><path d="M380 56 H464"/>
    <path d="M530 82 V143 H386"/><path d="M250 143 H90 V82"/>
  </g>
  <defs><marker id="ah1" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>Feedback. The measured output comes back and changes the input. Without that returning arrow it is monitoring, not control.</figcaption>
</figure>

<h3>The four words, kept apart</h3>
<ul>
<li><strong>Automation</strong> — a task done by machine instead of by hand.
The general word.</li>
<li><strong>Monitoring</strong> — sensors read and record. Nothing is
adjusted. A patient monitor showing pulse and blood pressure.</li>
<li><strong>Control</strong> — monitoring plus action. The reading is compared
with a set value and something is changed.</li>
<li><strong>Robotics</strong> — a programmable machine that moves and does
physical work.</li>
</ul>

<h3>The syllabus examples</h3>
<ul>
<li><strong>Patient monitoring</strong> — pulse, temperature, blood pressure
sampled continuously; an alarm when a value leaves its range.</li>
<li><strong>Chemical process control</strong> — temperature and pressure held
at set values by opening and closing valves.</li>
<li><strong>Traffic control</strong> — loop sensors count vehicles and the
light timings change to suit the queue.</li>
<li><strong>Domestic equipment</strong> — a washing machine, a microwave, an
air conditioner. Each holds an embedded system.</li>
<li><strong>Automatic navigation</strong> — an autopilot compares actual
position from GPS with the planned route and corrects.</li>
<li><strong>Industrial robots</strong> — welding and paint spraying on an
assembly line.</li>
</ul>

<h3>In the exam</h3>
<p>If the question says the system "adjusts", "maintains" or "keeps at", it is
control and your answer must contain <strong>feedback</strong>. If it only
"records", "displays" or "warns", it is monitoring. Losing that mark is the
commonest error on this topic.</p>', 'html', 6),
  ('b43160b9-f2a1-532e-90b7-e631251b6421', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Industrial, Technical and scientific application of Computing systems', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Weather forecasting, computer aided design and manufacture, image processing and industrial inspection systems, simulation and modelling</li></ul></div><p>These applications share one property: the calculation is too large, too
repetitive or too dangerous for a person to do.</p>

<h3>Weather forecasting</h3>
<p>The atmosphere is divided into a grid and the physics is solved for every
cell, repeatedly. Millions of calculations per forecast, which is why this runs
on a supercomputer. A forecast that arrives after the rain is worthless, so
speed is the whole point.</p>

<h3>Computer aided design and manufacture</h3>
<ul>
<li><strong>CAD</strong> — the design is drawn and modified on screen. It can
be rotated, dimensioned, tested against stress before any material is cut, and
changed without redrawing.</li>
<li><strong>CAM</strong> — the same design file drives the cutting and shaping
machines directly. No one re-types the measurements, so no one mistypes
them.</li>
<li>Together, CAD/CAM: design once, manufacture from that design.</li>
</ul>

<h3>Image processing and industrial inspection</h3>
<p>A camera photographs every item on the line and software compares it with
the correct pattern. Anything outside tolerance is rejected. It inspects every
item, not a sample, and it does not get tired at four in the afternoon.</p>

<h3>Simulation and modelling</h3>
<div class="def-box"><strong>Model:</strong> a representation of a real system.
<strong>Simulation:</strong> running that model over time to see how the real
system would behave.</div>
<p>Used where the real experiment would be too dangerous, too expensive, too
slow or impossible: a flight simulator, a crash test, a nuclear reaction, the
spread of a disease.</p>
<ul>
<li><strong>Advantages</strong> — safe, cheaper, repeatable, and time can be
compressed. Fifty years of climate in an afternoon.</li>
<li><strong>Disadvantages</strong> — the result is only as good as the model.
A missing factor gives a confident wrong answer, and building the model is
itself expensive.</li>
</ul>

<h3>In the exam</h3>
<p>"Give two reasons why simulation is used." Danger and cost are the two
easiest marks. Add repeatability if a third is asked.</p>', 'html', 7),
  ('7fcad661-de84-574b-9ed3-48bdf0d256a2', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Practical: Word processing', '<p>The examinable skills here are the ones that mark out a document made
properly from one made by pressing the space bar until it looks right.</p>

<h3>Do these, in order</h3>
<ul>
<li>Type a page of text. Do not press Enter at the end of each line — let the
software wrap.</li>
<li>Apply <strong>styles</strong>: Heading 1, Heading 2, Normal. Then change
the Heading 1 style once and watch every heading change. That is why styles
exist.</li>
<li>Insert an automatic <strong>table of contents</strong>. It is built from
the headings, which is your reward for using styles.</li>
<li>Set line spacing, justification, margins and a header with automatic
<strong>page numbers</strong>.</li>
<li>Insert a table. Merge two cells. Add a border.</li>
<li>Insert an image and set text wrapping around it.</li>
<li>Run <strong>spell check</strong>, then use <strong>find and
replace</strong> to change one word everywhere.</li>
<li><strong>Mail merge</strong>: one letter, a list of names, many personalised
letters. Do it with five names.</li>
<li>Save as .docx, then export the same document as PDF. Note that the PDF
keeps its layout everywhere and is awkward to edit. That is the trade.</li>
</ul>

<h3>In the exam</h3>
<p>Mail merge and automatic table of contents are the two features asked about
most often, and both are asked as "state an advantage". For mail merge: one
document serves many recipients, so there is no retyping and no inconsistency.
For the table of contents: it updates itself when the document changes.</p>', 'html', 8),
  ('9d73acd1-d409-5632-a2f7-aec8fe75436f', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Computing applications in the arts and the media', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Applications in music, computer graphics and animation for television and film, production of newspapers</li></ul></div><p>The syllabus names three areas: music, graphics and animation, and
newspaper production.</p>

<h3>Music</h3>
<ul>
<li><strong>Composition and sequencing</strong> — notes are entered from a
keyboard or drawn on screen, arranged in tracks, then played back and edited
without re-recording.</li>
<li><strong>MIDI</strong> — a standard by which instruments and computers
exchange instructions. Important point: MIDI carries the <em>instructions</em>
for a note, not the sound of it. So a MIDI file is tiny and the instrument can
be changed after recording.</li>
<li><strong>Recording and mixing</strong> — many tracks recorded separately,
then balanced, with effects added. A studio in Douala can do work that needed a
room full of equipment before.</li>
<li><strong>Synthesis and sampling</strong> — sounds generated, or real sounds
recorded and replayed at any pitch.</li>
</ul>

<h3>Computer graphics and animation</h3>
<ul>
<li>Objects are modelled in three dimensions, given surfaces and lighting, and
<strong>rendered</strong> into images.</li>
<li>Animation sets key frames; the software fills the frames between them.</li>
<li>Special effects put computer-generated objects into filmed footage, and
remove what should not be there.</li>
<li>The advantage is that a scene too dangerous or too expensive to film can be
built instead. The cost is rendering time — an animated feature can take
thousands of processor-hours.</li>
</ul>

<h3>Production of newspapers</h3>
<ul>
<li><strong>Desktop publishing</strong> lays out text and pictures on the page
exactly as they will print.</li>
<li>Journalists file copy from anywhere; the editor edits on screen; the
finished pages go electronically to the printing plant.</li>
<li>The deadline moves much later, because the page can be changed minutes
before printing.</li>
</ul>

<h3>In the exam</h3>
<p>A word processor arranges <em>text</em>. DTP arranges <em>the page</em> —
text and images in frames, positioned precisely. That is the distinction asked
for.</p>', 'html', 9),
  ('801e56d8-efa1-5ecd-a46d-40e4e5ee142a', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Computer organization (Basic Components of a Computer)', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Classification and description of hardware components (input, processing, output, and storage components)</li></ul></div><p>Every computer, from a phone to a supercomputer, is the same five blocks.
Learn the diagram once and it answers questions all year.</p>

<figure class="fig">
<svg viewBox="0 0 660 260" role="img" aria-label="Functional block diagram of a computer: input, CPU containing control unit and ALU, memory, output and backing store">
  <rect x="200" y="20" width="260" height="110" rx="8" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="5 4"/>
  <text x="330" y="16" font-size="12" fill="currentColor" text-anchor="middle">Central Processing Unit</text>
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="216" y="36" width="110" height="46" rx="6"/>
    <rect x="336" y="36" width="110" height="46" rx="6"/>
    <rect x="216" y="92" width="230" height="30" rx="6"/>
    <rect x="30" y="52" width="120" height="46" rx="6"/>
    <rect x="510" y="52" width="120" height="46" rx="6"/>
    <rect x="230" y="170" width="200" height="44" rx="6"/>
  </g>
  <g fill="currentColor" font-size="13" text-anchor="middle">
    <text x="271" y="58">Control</text><text x="271" y="74">Unit</text>
    <text x="391" y="58">ALU</text><text x="391" y="74">arithmetic + logic</text>
    <text x="331" y="112">Registers</text>
    <text x="90" y="72">Input</text><text x="90" y="88">keyboard, scanner</text>
    <text x="570" y="72">Output</text><text x="570" y="88">screen, printer</text>
    <text x="330" y="190">Main memory (RAM)</text>
    <text x="330" y="207">and backing store</text>
  </g>
  <g stroke="currentColor" stroke-width="1.5" fill="none" marker-end="url(#ah2)">
    <path d="M150 75 H194"/><path d="M466 75 H504"/>
    <path d="M300 130 V164"/><path d="M360 164 V134"/>
  </g>
  <defs><marker id="ah2" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>The functional block diagram. Data flows left to right; the two-way arrow to memory is what makes it a stored-program machine.</figcaption>
</figure>

<h3>The five components</h3>
<ul>
<li><strong>Input</strong> — accepts data from outside and converts it into a
form the computer can use. Keyboard, mouse, scanner, microphone, sensor.</li>
<li><strong>Processing</strong> — the CPU. Inside it the <strong>control
unit</strong> fetches and decodes instructions and directs everything else; the
<strong>ALU</strong> does the arithmetic and the comparisons; the
<strong>registers</strong> hold the few values being worked on right now.</li>
<li><strong>Memory</strong> — main memory, RAM, holds the program and the data
while they are in use. Fast, volatile.</li>
<li><strong>Storage</strong> — backing store. Hard disk, flash drive, DVD.
Slower, much larger, keeps its contents with the power off.</li>
<li><strong>Output</strong> — converts results into a form people can use.
Screen, printer, speaker, actuator.</li>
</ul>

<h3>Why the diagram is drawn this way</h3>
<p>The program is held in the same memory as the data. That is the
<strong>stored-program concept</strong>, and it is why one machine can run a
spreadsheet and then a game without being rewired.</p>

<h3>In the exam</h3>
<p>Asked to draw it, you must show the CU and ALU <em>inside</em> the CPU box,
and arrows in both directions between CPU and memory. A drawing with one arrow
into memory and none out loses the mark.</p>', 'html', 10),
  ('69bfa3de-55e4-525b-88b8-d5ad3591eb82', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Practical: Presentation', '<p>The examinable part of a presentation package is not the animation. It is
the master slide, consistency, and knowing what belongs on a slide.</p>

<h3>Do these</h3>
<ul>
<li>Build a six-slide deck on a topic from this term. Title, four content,
summary.</li>
<li>Edit the <strong>slide master</strong>: set the font, the colours and the
school name once, and see it apply to every slide. Do not format slides
individually.</li>
<li>Use a content <strong>layout</strong> rather than dropping loose text
boxes on a blank slide.</li>
<li>Insert a chart, a table and an image. Add <strong>alt text</strong> to the
image.</li>
<li>Add <strong>speaker notes</strong>. The detail belongs there, not on the
slide.</li>
<li>Set slide transitions and one animation. Then remove half of them.</li>
<li>Rehearse timings, then print as handouts, six per page.</li>
</ul>

<h3>The rules that carry marks</h3>
<ul>
<li>Few words per slide. A slide is a heading for what you say, not a
script.</li>
<li>One idea per slide.</li>
<li>Readable at the back of the room: large sans-serif type, strong contrast.
Yellow on white fails in a bright classroom.</li>
<li>Consistent colours and fonts throughout — which the master gives you for
free.</li>
</ul>

<h3>In the exam</h3>
<p>"State two advantages of using a slide master." Consistency across every
slide, and one change updates the whole presentation. Those are the two.</p>', 'html', 11),
  ('40cf3718-f573-55a0-ac64-0f944d65e437', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Description of peripheral devices and data handling media device', '<div class="def-box"><strong>Peripheral:</strong> any device connected to the
computer but outside the CPU and main memory. Peripherals are input, output, or
storage.</div>

<h3>Input devices, and what each is for</h3>
<ul>
<li><strong>Keyboard</strong> — general text. Slow and error-prone for bulk
data.</li>
<li><strong>Mouse, trackpad, touch screen</strong> — pointing and selecting.</li>
<li><strong>Scanner</strong> — turns a paper document into an image. With OCR
software the image becomes editable text.</li>
<li><strong>Digital camera and webcam</strong> — still and moving images.</li>
<li><strong>Microphone</strong> — sound, and voice input.</li>
<li><strong>Barcode reader</strong> — reads a printed code fast and without
typing errors. The till in a supermarket.</li>
<li><strong>MICR, OMR, OCR</strong> — cheques, multiple-choice answer sheets
and printed text respectively. Next lesson covers these properly.</li>
<li><strong>Sensors</strong> — temperature, pressure, light, movement. The
input devices of a control system.</li>
</ul>

<h3>Output devices</h3>
<ul>
<li><strong>Monitor</strong> — soft copy. Cheap to change, gone when the power
goes.</li>
<li><strong>Printer</strong> — hard copy. Laser is fast and sharp for volume;
inkjet is cheaper to buy and good for colour photographs; dot matrix is slow
and noisy but is the only one that prints through carbon paper, which is why
it survives on multi-part invoices.</li>
<li><strong>Plotter</strong> — large accurate line drawings. Architectural and
engineering plans.</li>
<li><strong>Speakers</strong> — sound.</li>
<li><strong>Actuators</strong> — motors and valves, the output devices of a
control system.</li>
</ul>

<h3>Data handling media</h3>
<p>Keep the two words apart, because the exam does.</p>
<div class="def-box"><strong>Storage device:</strong> the machine that reads
and writes. <strong>Storage medium:</strong> the material the data actually
sits on.</div>
<ul>
<li>DVD drive is the device; the DVD disc is the medium.</li>
<li>Tape drive is the device; the tape cartridge is the medium.</li>
<li>A hard disk is both in one sealed unit, which is why it is the awkward
example — say so if asked.</li>
</ul>

<h3>In the exam</h3>
<p>Choose the device for the job and <em>justify</em> it. "A barcode reader,
because it is fast and avoids the typing errors a keyboard would introduce at
a busy till." The justification is where the mark is.</p>', 'html', 12),
  ('ecd49c3f-380b-5d4a-9234-95399176d06b', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Processor architecture', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Description of processor configuration; control unit; ALU; registers; bus type, role and size</li></ul></div><p>Open the CPU and there are three things inside: a control unit, an
arithmetic and logic unit, and registers. They are connected to the rest of the
machine by buses.</p>

<figure class="fig">
<svg viewBox="0 0 660 250" role="img" aria-label="Processor internals with control unit, ALU, registers, and the address, data and control buses to memory">
  <rect x="24" y="20" width="330" height="150" rx="8" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="5 4"/>
  <text x="189" y="16" font-size="12" fill="currentColor" text-anchor="middle">CPU</text>
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="40" y="36" width="140" height="44" rx="6"/>
    <rect x="198" y="36" width="140" height="44" rx="6"/>
    <rect x="40" y="96" width="298" height="58" rx="6"/>
    <rect x="470" y="60" width="160" height="80" rx="6"/>
  </g>
  <g fill="currentColor" font-size="13" text-anchor="middle">
    <text x="110" y="55">Control Unit</text><text x="110" y="71">fetch, decode, direct</text>
    <text x="268" y="55">ALU</text><text x="268" y="71">add, compare, AND/OR</text>
    <text x="189" y="116">Registers</text>
    <text x="189" y="134" font-size="11">PC · MAR · MDR · CIR · Accumulator</text>
    <text x="550" y="96">Main memory</text><text x="550" y="114">(RAM)</text>
  </g>
  <g stroke="currentColor" stroke-width="1.5" fill="none">
    <path d="M354 72 H466" marker-end="url(#ah3)"/>
    <path d="M466 100 H354" marker-end="url(#ah3)"/>
    <path d="M354 128 H466" marker-end="url(#ah3)"/>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="410" y="64">address bus (one way)</text>
    <text x="410" y="92">data bus (two way)</text>
    <text x="410" y="148">control bus</text>
  </g>
  <defs><marker id="ah3" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>The three buses. Address goes out only; data goes both ways; control carries the signals that say read or write.</figcaption>
</figure>

<h3>Control unit</h3>
<p>Fetches each instruction, decodes it, and sends the timing and control
signals that make every other part act at the right moment. It does no
arithmetic itself. Think of it as the head teacher and the timetable.</p>

<h3>Arithmetic and logic unit</h3>
<p>Does the work: add, subtract, multiply, divide, and the logical operations
AND, OR, NOT and comparison. Every calculation in every program ends up
here.</p>

<h3>Registers</h3>
<p>Very small, very fast storage inside the CPU. Faster than RAM because the
data does not leave the chip.</p>
<ul>
<li><strong>PC</strong>, program counter — address of the next instruction.</li>
<li><strong>MAR</strong>, memory address register — the address being read or
written.</li>
<li><strong>MDR</strong>, memory data register — the value travelling to or
from memory.</li>
<li><strong>CIR</strong>, current instruction register — the instruction being
decoded now.</li>
<li><strong>Accumulator</strong> — where the ALU leaves its result.</li>
</ul>

<h3>The buses: type, role and size</h3>
<ul>
<li><strong>Address bus</strong> — carries the address. One direction, CPU to
memory. Its <em>width</em> fixes how much memory can be addressed: 32 lines
gives 2<sup>32</sup> addresses, which is 4 GB.</li>
<li><strong>Data bus</strong> — carries the value. Two directions. Its width
fixes how many bits move at once, so a 64-bit data bus moves twice as much per
transfer as a 32-bit one.</li>
<li><strong>Control bus</strong> — carries the signals: read, write, interrupt,
clock. Mixed directions.</li>
</ul>

<h3>In the exam</h3>
<p>"What is the effect of increasing the width of the address bus?" More memory
can be addressed. Not "it is faster". Speed is the data bus and the clock. Get
that pair the wrong way round and the whole answer goes.</p>', 'html', 13),
  ('0170855d-3734-5d96-a152-30f29653f186', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Classification of computers based on processor architecture', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>RISC and CISC machines; SISD, SIMD, MIMD</li></ul></div><p>Two different classifications, often confused. RISC and CISC is about the
<em>instruction set</em>. Flynn''s taxonomy is about how many
<em>streams</em> the machine handles at once.</p>

<h3>RISC and CISC</h3>
<table>
<tr><th></th><th>CISC</th><th>RISC</th></tr>
<tr><td>Instructions</td><td>Many, complex</td><td>Few, simple</td></tr>
<tr><td>Instruction length</td><td>Varies</td><td>Fixed</td></tr>
<tr><td>Cycles per instruction</td><td>Several</td><td>Usually one</td></tr>
<tr><td>Work done in</td><td>Hardware</td><td>Software (compiler)</td></tr>
<tr><td>Registers</td><td>Fewer</td><td>Many</td></tr>
<tr><td>Power used</td><td>More</td><td>Less</td></tr>
<tr><td>Typical use</td><td>Desktop, server (Intel x86)</td><td>Phone, tablet (ARM)</td></tr>
</table>
<p>The trade is plain. CISC does more per instruction, so a program is shorter
but each instruction is slower. RISC does less per instruction, so the program
is longer but each instruction is fast and the chip is simpler and cooler. Your
phone is ARM, and it is RISC, because battery life matters more than raw
instruction power.</p>

<h3>Flynn''s taxonomy</h3>
<p>Count the instruction streams, count the data streams.</p>

<figure class="fig">
<svg viewBox="0 0 620 210" role="img" aria-label="Flynn taxonomy grid of SISD, SIMD, MISD and MIMD">
  <g stroke="currentColor" stroke-width="1.5" fill="none">
    <rect x="140" y="40" width="220" height="70"/><rect x="360" y="40" width="220" height="70"/>
    <rect x="140" y="110" width="220" height="70"/><rect x="360" y="110" width="220" height="70"/>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="250" y="30">Single data stream</text><text x="470" y="30">Multiple data streams</text>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="end">
    <text x="132" y="72">Single instruction</text><text x="132" y="88">stream</text>
    <text x="132" y="142">Multiple instruction</text><text x="132" y="158">streams</text>
  </g>
  <g fill="currentColor" font-size="14" text-anchor="middle" font-weight="600">
    <text x="250" y="72">SISD</text><text x="470" y="72">SIMD</text>
    <text x="250" y="142">MISD</text><text x="470" y="142">MIMD</text>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="250" y="94">one ordinary processor</text>
    <text x="470" y="94">same operation, many values</text>
    <text x="250" y="164">rare, almost theoretical</text>
    <text x="470" y="164">multicore, clusters</text>
  </g>
</svg>
<figcaption>Flynn''s four classes. Only three of them are built in quantity.</figcaption>
</figure>

<ul>
<li><strong>SISD</strong> — one instruction acting on one piece of data at a
time. A traditional single-core processor.</li>
<li><strong>SIMD</strong> — one instruction applied to many pieces of data at
once. Brightening every pixel of a photograph. This is what a graphics
processor does.</li>
<li><strong>MISD</strong> — many instructions on the same data. Almost never
built; quoted for completeness, sometimes for fault-tolerant systems that run
the same data through different units and compare.</li>
<li><strong>MIMD</strong> — many processors, each running its own instructions
on its own data. Every multicore computer, and every cluster.</li>
</ul>

<h3>In the exam</h3>
<p>Give an example with each class. SIMD without "image or vector processing"
attached to it rarely earns full marks.</p>', 'html', 14),
  ('a68f63ae-849f-5410-9e2d-604a48fbdc6e', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Identify assorted computer types', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Mainframe, mini and microcomputers, and parallel and distributed computing</li></ul></div><p>Computers are classified by size and capability. Size here means memory,
number of users supported, storage and processor power — not physical bulk.</p>

<h3>The four types</h3>
<ul>
<li><strong>Microcomputer</strong> — the smallest class, meant for public use
and designed for one person at a time. Desktops, laptops, tablets, PDAs, and
small servers. What is in your school lab.</li>
<li><strong>Minicomputer</strong> — larger and faster, supports more than one
user at a time. Used for processing large volumes of data in an organisation,
and as a server on a local network. Also called a mid-range computer. The DEC
VAX and the IBM AS/400 are the classic examples.</li>
<li><strong>Mainframe</strong> — a powerful multi-user machine supporting up to
hundreds of users at once, at very high speed and with very large storage. Used
by banks, meteorological services and statistical institutes for bulk
processing.</li>
<li><strong>Supercomputer</strong> — the fastest and most expensive. Hundreds
of millions of computations per second, for specialised work needing immense
calculation: weather forecasting, scientific simulation, nuclear research,
electronic design, geological analysis. Fujitsu K, IBM Blue Gene, Cray Jaguar,
NEC Earth Simulator.</li>
</ul>

<h3>Mainframe against supercomputer</h3>
<p>This is the distinction the paper asks for. A mainframe handles a very large
number of <em>transactions</em> for very many users. A supercomputer handles
one very large <em>calculation</em> as fast as possible. A bank buys a
mainframe. A meteorological centre buys a supercomputer.</p>

<h3>Parallel and distributed computing</h3>
<div class="def-box"><strong>Parallel computing:</strong> many processors
inside one machine working on parts of the same problem at the same time.
<strong>Distributed computing:</strong> many separate computers, connected by a
network, cooperating on one problem.</div>
<ul>
<li>Parallel: processors share memory, communication is fast, the machine is
expensive.</li>
<li>Distributed: ordinary machines, communication over a network so it is
slower, but it is cheap to add another machine and the failure of one need not
stop the rest.</li>
</ul>

<h3>In the exam</h3>
<p>Do not classify by physical size. A rack of servers is small; a 1970s
minicomputer was the size of a wardrobe. Classify by users supported and
processing power.</p>', 'html', 15),
  ('03a8b2cb-ba45-529c-9fea-d7580dd4b3b1', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Primary and Secondary storage', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Differentiate between storage devices and storage media</li><li>Functions and characteristics of storage devices and media: RAM, ROM, CD ROM, disks and tapes, memory card readers, USB ports</li><li>The role of memory systems: RAM, DRAM, SRAM, ROM, PROM, EPROM, EEPROM, cache, virtual memory</li><li>Performance and characteristics of storage devices (storage hierarchy based on speed and size)</li><li>Units of storage: bits, bytes, kilobytes, MB, GB, terabytes, and conversion between them</li></ul></div><p>Two words first, because half the marks on this topic depend on them.</p>

<div class="def-box"><strong>Storage device:</strong> the hardware that reads
and writes. <strong>Storage medium:</strong> what the data is physically
recorded on. A DVD drive is the device; the DVD disc is the medium.</div>

<h3>Primary against secondary</h3>
<ul>
<li><strong>Primary</strong> — inside the machine, directly reachable by the
CPU, fast, small, expensive per byte. RAM and ROM.</li>
<li><strong>Secondary</strong> — backing store, not directly reachable by the
CPU, slower, large, cheap per byte, and non-volatile. Hard disk, SSD, flash
drive, DVD, tape.</li>
</ul>
<p>The CPU cannot run a program from the hard disk. The program is copied into
RAM first. Always.</p>

<h3>The memory systems named on the syllabus</h3>
<ul>
<li><strong>RAM</strong> — random access memory. Read and write, holds the
programs and data in use, <strong>volatile</strong>: contents are lost when the
power goes. That is why an unsaved document dies when ENEO cuts.</li>
<li><strong>SRAM</strong> — static RAM. Holds its value while powered, no
refreshing, very fast, expensive. Used for cache.</li>
<li><strong>DRAM</strong> — dynamic RAM. Each bit is a tiny capacitor that
leaks, so it must be refreshed thousands of times a second. Slower, cheaper,
denser. Used for main memory.</li>
<li><strong>ROM</strong> — read only memory. Non-volatile, written at
manufacture, holds the bootstrap and the BIOS.</li>
<li><strong>PROM</strong> — programmable ROM. Blank when bought, written once
by the buyer, never again.</li>
<li><strong>EPROM</strong> — erasable PROM. Erased by ultraviolet light through
a window in the chip, then rewritten. Erases the whole chip.</li>
<li><strong>EEPROM</strong> — electrically erasable PROM. Erased and rewritten
electrically, in place, byte by byte. Flash memory is a form of it.</li>
<li><strong>Cache</strong> — a small block of very fast memory between CPU and
RAM, holding the data used most recently. It works because programs reuse the
same instructions and data.</li>
<li><strong>Virtual memory</strong> — part of the hard disk used as though it
were RAM, so programs bigger than RAM can run. It is far slower; when a machine
does too much of it and crawls, that is thrashing.</li>
</ul>

<figure class="fig">
<svg viewBox="0 0 620 250" role="img" aria-label="Storage hierarchy pyramid from registers at the top to tape at the bottom">
  <g stroke="var(--cyan)" fill="var(--cyan-soft)" stroke-width="1.5">
    <path d="M280 20 L360 20 L378 62 L262 62 Z"/>
    <path d="M262 66 L378 66 L396 108 L244 108 Z"/>
    <path d="M244 112 L396 112 L414 154 L226 154 Z"/>
    <path d="M226 158 L414 158 L432 200 L208 200 Z"/>
    <path d="M208 204 L432 204 L450 240 L190 240 Z"/>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="320" y="47">Registers</text><text x="320" y="93">Cache</text>
    <text x="320" y="139">Main memory (RAM)</text>
    <text x="320" y="185">Hard disk / SSD</text>
    <text x="320" y="228">Optical disc, tape</text>
  </g>
  <g stroke="currentColor" stroke-width="1.5" fill="none" marker-end="url(#ah4)">
    <path d="M150 230 V30"/><path d="M500 30 V230"/>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="130" y="130">faster</text><text x="130" y="146">costlier</text>
    <text x="520" y="130">larger</text><text x="520" y="146">cheaper</text>
  </g>
  <defs><marker id="ah4" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>The storage hierarchy. Up is faster, smaller and dearer; down is slower, bigger and cheaper.</figcaption>
</figure>

<h3>Units of storage</h3>
<ul>
<li>8 bits = 1 byte. 1 byte holds one character.</li>
<li>1 KB = 1024 bytes, 1 MB = 1024 KB, 1 GB = 1024 MB, 1 TB = 1024 GB.</li>
<li>To convert down a level, multiply by 1024. Up a level, divide by 1024.</li>
<li>Worked example: 3 GB in KB. 3 × 1024 = 3072 MB, × 1024 = 3 145 728 KB.</li>
</ul>
<p>Some manufacturers use 1000 rather than 1024, which is why a "500 GB" disk
shows as about 465 GB in Windows. Unless the question says otherwise, use
1024.</p>

<h3>In the exam</h3>
<p>"Volatile" and "non-volatile" are the words that earn the mark. And when
asked to compare RAM with ROM, give three points: read/write against read-only,
volatile against non-volatile, and what each holds.</p>', 'html', 16),
  ('321cce91-584f-5490-87d3-070eaeadbf2c', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Machine Cycle', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Description of fetch, decode, execute and store stages</li></ul></div><p>The machine cycle is what the processor does, over and over, millions of
times a second, for as long as it is switched on. Four stages.</p>

<figure class="fig">
<svg viewBox="0 0 620 240" role="img" aria-label="The machine cycle: fetch, decode, execute, store, repeating">
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="60" y="40" width="130" height="56" rx="8"/>
    <rect x="420" y="40" width="130" height="56" rx="8"/>
    <rect x="420" y="150" width="130" height="56" rx="8"/>
    <rect x="60" y="150" width="130" height="56" rx="8"/>
  </g>
  <g fill="currentColor" font-size="14" text-anchor="middle" font-weight="600">
    <text x="125" y="64">1. FETCH</text><text x="485" y="64">2. DECODE</text>
    <text x="485" y="174">3. EXECUTE</text><text x="125" y="174">4. STORE</text>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="125" y="82">instruction from</text><text x="125" y="94">memory into CIR</text>
    <text x="485" y="82">control unit works</text><text x="485" y="94">out what it means</text>
    <text x="485" y="192">ALU performs</text><text x="485" y="204">the operation</text>
    <text x="125" y="192">result written to</text><text x="125" y="204">register or memory</text>
  </g>
  <g stroke="currentColor" stroke-width="1.6" fill="none" marker-end="url(#ah5)">
    <path d="M190 68 H414"/><path d="M485 96 V144"/>
    <path d="M420 178 H196"/><path d="M125 150 V102"/>
  </g>
  <text x="305" y="128" font-size="11" fill="currentColor" text-anchor="middle">PC increments, and the cycle repeats</text>
  <defs><marker id="ah5" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>One turn of the cycle handles one instruction.</figcaption>
</figure>

<h3>Fetch</h3>
<ul>
<li>The address in the <strong>PC</strong> is copied to the <strong>MAR</strong>.</li>
<li>That address goes out on the address bus; a read signal goes out on the
control bus.</li>
<li>Memory puts the instruction on the data bus; it arrives in the
<strong>MDR</strong> and is copied to the <strong>CIR</strong>.</li>
<li>The PC is incremented, so it already points at the next instruction.</li>
</ul>

<h3>Decode</h3>
<p>The control unit splits the instruction into its <strong>opcode</strong>,
which says what to do, and its <strong>operand</strong>, which says what to do
it to. It then works out which signals are needed.</p>

<h3>Execute</h3>
<p>The signals go out. If arithmetic or a comparison is wanted, the ALU does it
and leaves the answer in the accumulator. If the instruction is a jump, the PC
is loaded with a new address instead.</p>

<h3>Store</h3>
<p>The result is written back to a register or to memory. Then the cycle begins
again with the address now in the PC.</p>

<h3>In the exam</h3>
<p>Name the registers as you describe the stages. An answer that says "the
instruction is fetched" scores one mark; an answer that says "the address in
the PC is placed in the MAR, and the instruction returns via the MDR into the
CIR" scores the lot.</p>
<p>Clock speed measures how many cycles happen per second. 3 GHz is three
thousand million cycles a second.</p>', 'html', 17),
  ('b2a327c0-95ca-52d3-8292-86833998cfa1', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Data capture', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Classifying data capture devices: manual and automatic (MICR, OMR, OCR, barcode reader)</li></ul></div><p>Data capture is getting data into the system in the first place. Everything
downstream depends on it, which is why the exam cares.</p>

<div class="def-box"><strong>Data capture:</strong> the collection of data and
its entry into a computer system in a form the system can process.</div>

<h3>Manual capture</h3>
<p>A person reads the data and types it. A clerk entering a paper form, a
teacher typing marks, a cashier keying a price.</p>
<ul>
<li>Cheap to set up, needs no special equipment, flexible.</li>
<li>Slow, expensive in wages for large volumes, and error-prone. Every keyed
character is a chance to make a mistake.</li>
</ul>

<h3>Automatic capture</h3>
<p>A machine reads the data directly from the source. Fast, and it removes
keying errors entirely.</p>
<ul>
<li><strong>MICR</strong> — magnetic ink character recognition. The band of
odd-looking digits along the bottom of a cheque. Read magnetically, so it still
works through a stamp or a signature, and it is very hard to forge. Used almost
only for cheques.</li>
<li><strong>OMR</strong> — optical mark recognition. Reads the
<em>position</em> of a pencil mark, not its shape. Multiple-choice answer
sheets and lottery tickets. Very fast, but it can only capture choices from a
fixed set of boxes.</li>
<li><strong>OCR</strong> — optical character recognition. Reads the shape of
printed or written characters and turns them into text. Passports, utility
bills, scanned documents. Accurate on clean printing, much less so on
handwriting.</li>
<li><strong>Barcode reader</strong> — reads a pattern of bars representing a
code, usually a product number. Point of sale, library books, stock, shipping.
Cheap, fast, reliable. The code identifies the item; the price comes from the
database, so a price change means changing one record rather than relabelling
the shelf.</li>
</ul>

<h3>Choosing between them</h3>
<table>
<tr><th>Situation</th><th>Method</th><th>Why</th></tr>
<tr><td>Bank cheques</td><td>MICR</td><td>Security, and readable when marked</td></tr>
<tr><td>GCE multiple choice</td><td>OMR</td><td>Thousands of sheets, fixed answers</td></tr>
<tr><td>Scanned printed forms</td><td>OCR</td><td>Characters must become text</td></tr>
<tr><td>Supermarket till</td><td>Barcode</td><td>Fast, cheap, links to stock file</td></tr>
</table>

<h3>In the exam</h3>
<p>OMR against OCR is the pair that gets confused. OMR reads <em>where</em> the
mark is. OCR reads <em>what the character is</em>. One sentence each, and both
marks are yours.</p>', 'html', 18),
  ('1088243f-7f0e-5ab9-921b-d5cb58600422', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Data Representation', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Coding schemes (ASCII, EBCDIC, BCD, Unicode)</li><li>Measuring units: bit, nibble, byte, word, word size</li></ul></div><p>Inside the machine there are only two states, on and off. Every number,
letter and image is a pattern of those two states.</p>

<h3>The measuring units</h3>
<figure class="fig">
<svg viewBox="0 0 620 170" role="img" aria-label="Bit, nibble, byte and word shown as boxes of binary digits">
  <g font-size="13" fill="currentColor">
    <text x="20" y="34">bit</text><text x="20" y="80">nibble</text>
    <text x="20" y="126">byte</text>
  </g>
  <g stroke="var(--cyan)" fill="var(--cyan-soft)" stroke-width="1.4">
    <rect x="110" y="18" width="26" height="24" rx="3"/>
  </g>
  <text x="123" y="35" font-size="12" fill="currentColor" text-anchor="middle">1</text>
  <text x="150" y="35" font-size="11" fill="currentColor">one binary digit, 0 or 1</text>
  <g stroke="var(--cyan)" fill="var(--cyan-soft)" stroke-width="1.4">
    <rect x="110" y="64" width="26" height="24" rx="3"/><rect x="138" y="64" width="26" height="24" rx="3"/>
    <rect x="166" y="64" width="26" height="24" rx="3"/><rect x="194" y="64" width="26" height="24" rx="3"/>
  </g>
  <text x="234" y="81" font-size="11" fill="currentColor">4 bits — one hexadecimal digit</text>
  <g stroke="var(--cyan)" fill="var(--cyan-soft)" stroke-width="1.4">
    <rect x="110" y="110" width="26" height="24" rx="3"/><rect x="138" y="110" width="26" height="24" rx="3"/>
    <rect x="166" y="110" width="26" height="24" rx="3"/><rect x="194" y="110" width="26" height="24" rx="3"/>
    <rect x="222" y="110" width="26" height="24" rx="3"/><rect x="250" y="110" width="26" height="24" rx="3"/>
    <rect x="278" y="110" width="26" height="24" rx="3"/><rect x="306" y="110" width="26" height="24" rx="3"/>
  </g>
  <text x="346" y="127" font-size="11" fill="currentColor">8 bits — one character</text>
  <line x1="110" y1="152" x2="470" y2="152" stroke="currentColor" stroke-width="1.2"/>
  <text x="290" y="166" font-size="11" fill="currentColor" text-anchor="middle">word — the number of bits the CPU handles in one go (word size)</text>
</svg>
<figcaption>Bit, nibble, byte and word. Word size is a property of the processor, not a fixed number.</figcaption>
</figure>

<ul>
<li><strong>Bit</strong> — one binary digit, 0 or 1.</li>
<li><strong>Nibble</strong> — 4 bits. Convenient because one nibble is exactly
one hexadecimal digit.</li>
<li><strong>Byte</strong> — 8 bits. Enough for one character.</li>
<li><strong>Word</strong> — the number of bits the processor handles as a
unit. <strong>Word size</strong> is that number: 32-bit and 64-bit machines are
named after it. A larger word size means more data per operation and more
memory addressable.</li>
</ul>

<h3>Coding schemes</h3>
<ul>
<li><strong>ASCII</strong> — American Standard Code for Information
Interchange. 7 bits, 128 characters, usually stored in a byte. ''A'' is 65, ''a''
is 97, ''0'' is 48. Extended ASCII uses the eighth bit for another 128.</li>
<li><strong>EBCDIC</strong> — Extended Binary Coded Decimal Interchange Code.
8 bits, 256 characters, an IBM standard used on mainframes. Not compatible with
ASCII, which is the point of mentioning it.</li>
<li><strong>BCD</strong> — binary coded decimal. Each decimal digit stored
separately in 4 bits. 59 becomes 0101 1001. Wasteful of space, but it converts
to and from decimal without rounding, so it is used where exact decimal
arithmetic matters, such as money and calculator displays.</li>
<li><strong>Unicode</strong> — one code for every writing system in the world.
16 bits and more, over a million code points. It is why a phone can display
Chinese, Arabic and French in the same message. ASCII is a subset of it, so
Unicode is backward compatible.</li>
</ul>

<h3>In the exam</h3>
<p>"Why was Unicode introduced?" Because ASCII''s 128 characters cannot
represent the world''s writing systems. That is the answer.</p>
<p>Two ASCII facts worth memorising: ''A'' = 65 and ''a'' = 97. Given one letter''s
code you can work out any other by counting on.</p>', 'html', 19)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  body = EXCLUDED.body, body_format = EXCLUDED.body_format,
  chapter_number = EXCLUDED.chapter_number,
  sequence = EXCLUDED.sequence, updated_at = now();

COMMIT;
