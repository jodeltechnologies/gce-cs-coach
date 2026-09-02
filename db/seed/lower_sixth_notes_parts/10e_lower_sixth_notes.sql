-- Part E of 7 — notes 4 of 5: Architectural requirements of an IS → System Implementation and Maintenance.
-- Run the parts in alphabetical order, one at a time.
-- Safe to run again if you lose your place.

BEGIN;

-- 12 notes
INSERT INTO note_sections
  (id, note_source_id, chapter_number, title, body, body_format, sequence)
VALUES
  ('c5fb767c-80b8-5dd1-8bdd-6ec1bf1e29bf', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Architectural requirements of an IS', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Describe a system and an information system</li><li>Distinguish between natural and artificial systems, data and information, manual and computer-based information systems</li><li>Outline the activities of an IS: input, processing, output, storage, and distribution</li></ul></div><div class="def-box"><strong>System:</strong> a set of interrelated components
working together towards a common goal.
<br><strong>Information system:</strong> a system that collects, processes,
stores and distributes information to support decision making and control in an
organisation.</div>

<h3>Natural and artificial systems</h3>
<ul>
<li><strong>Natural</strong> — occurs in nature, not designed by anyone. The
water cycle, the human body, an ecosystem.</li>
<li><strong>Artificial (man-made)</strong> — designed and built for a purpose.
A school, a payroll system, a traffic control system.</li>
<li>Also useful: <strong>open</strong> systems interact with their environment,
<strong>closed</strong> systems do not; <strong>deterministic</strong> systems
behave predictably, <strong>probabilistic</strong> systems do not.</li>
</ul>

<h3>Data and information</h3>
<table>
<tr><th>Data</th><th>Information</th></tr>
<tr><td>Raw, unprocessed facts</td><td>Data that has been processed</td></tr>
<tr><td>No meaning on its own</td><td>Has meaning and context</td></tr>
<tr><td>Not directly useful for a decision</td><td>Supports a decision</td></tr>
<tr><td>"14, 09, 17, 11"</td><td>"The class average is 12.75, a pass"</td></tr>
</table>
<p>Add the third term if you can: <strong>knowledge</strong> is information
combined with experience and understanding, which is what lets someone act on
it.</p>
<p>Good information is accurate, complete, relevant, timely, understandable by
its user, and worth more than it cost to produce. Late information is useless,
however accurate.</p>

<h3>Manual against computer-based information systems</h3>
<table>
<tr><th></th><th>Manual</th><th>Computer-based</th></tr>
<tr><td>Speed</td><td>Slow</td><td>Very fast</td></tr>
<tr><td>Accuracy</td><td>Human error at every step</td><td>Consistent, if input is validated</td></tr>
<tr><td>Volume</td><td>Limited</td><td>Very large</td></tr>
<tr><td>Storage</td><td>Bulky, hard to search</td><td>Compact, searched instantly</td></tr>
<tr><td>Cost</td><td>Low to start, high in wages</td><td>High to start, low to run</td></tr>
<tr><td>Reliability</td><td>Works without power</td><td>Fails without power or network</td></tr>
<tr><td>Security</td><td>Physical locks only</td><td>Passwords, encryption, logs — but also remote attack</td></tr>
</table>

<h3>The activities of an information system</h3>
<figure class="fig">
<svg viewBox="0 0 660 180" role="img" aria-label="The five activities of an information system: input, processing, output, storage and distribution, with feedback">
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="20" y="46" width="105" height="46" rx="6"/>
    <rect x="163" y="46" width="115" height="46" rx="6"/>
    <rect x="316" y="46" width="105" height="46" rx="6"/>
    <rect x="459" y="46" width="130" height="46" rx="6"/>
    <rect x="163" y="118" width="115" height="40" rx="6"/>
  </g>
  <g fill="currentColor" font-size="13" text-anchor="middle">
    <text x="72" y="66">Input</text><text x="72" y="82" font-size="10">collect data</text>
    <text x="220" y="66">Processing</text><text x="220" y="82" font-size="10">calculate, sort, classify</text>
    <text x="368" y="66">Output</text><text x="368" y="82" font-size="10">reports, screens</text>
    <text x="524" y="66">Distribution</text><text x="524" y="82" font-size="10">to those who need it</text>
    <text x="220" y="136">Storage</text><text x="220" y="151" font-size="10">files and databases</text>
  </g>
  <g stroke="currentColor" stroke-width="1.5" fill="none" marker-end="url(#ah7)">
    <path d="M125 69 H157"/><path d="M278 69 H310"/><path d="M421 69 H453"/>
    <path d="M200 92 V112"/><path d="M240 112 V96"/>
    <path d="M524 92 V166 H286"/>
  </g>
  <text x="400" y="176" font-size="11" fill="currentColor" text-anchor="middle">feedback</text>
  <defs><marker id="ah7" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>Input, processing, output, storage and distribution, with feedback closing the loop.</figcaption>
</figure>

<ul>
<li><strong>Input</strong> — capture the raw data, and validate it.</li>
<li><strong>Processing</strong> — calculate, sort, classify, summarise,
compare.</li>
<li><strong>Output</strong> — present the results as reports, screens, charts
or alerts.</li>
<li><strong>Storage</strong> — keep data and results for future use, in files
and databases.</li>
<li><strong>Distribution</strong> — get the information to whoever needs it, in
time to act on it.</li>
<li><strong>Feedback</strong> — output returned as input, to adjust and improve
the system.</li>
</ul>

<h3>In the exam</h3>
<p>Storage and distribution are the two activities candidates forget. If a
question asks for the activities of an information system, list all five, and
add feedback if it asks for a diagram.</p>', 'html', 50),
  ('90657fb7-9376-595b-ba6a-73daa2c532f9', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Role of IS in an Organization', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Components of an IS</li><li>Illustrate the hierarchical structure of an organisation and describe the IS used at each level</li><li>The need of an IS at operational, tactical, and strategic levels</li><li>Key features of GIS, HIS, LIS, TPS, MIS, DSS, EIS and area of application of each</li></ul></div><h3>Components of an information system</h3>
<p>Five, and the last one is the one people leave out.</p>
<ul>
<li><strong>Hardware</strong> — the physical equipment.</li>
<li><strong>Software</strong> — system and application programs.</li>
<li><strong>Data</strong> — the raw material the system works on.</li>
<li><strong>Procedures</strong> — the rules and instructions saying how the
system is used.</li>
<li><strong>People</strong> — users, operators, managers, specialists. The most
important component and the one most often omitted in exam answers.</li>
<li>Add <strong>networks</strong> as a sixth if the question allows it.</li>
</ul>

<h3>The hierarchical structure of an organisation</h3>
<figure class="fig">
<svg viewBox="0 0 620 250" role="img" aria-label="Organisational pyramid showing strategic, tactical and operational levels with the information systems used at each">
  <g stroke="var(--cyan)" fill="var(--cyan-soft)" stroke-width="1.5">
    <path d="M300 20 L370 20 L400 88 L270 88 Z"/>
    <path d="M268 92 L402 92 L432 160 L238 160 Z"/>
    <path d="M236 164 L434 164 L466 232 L204 232 Z"/>
  </g>
  <g fill="currentColor" font-size="13" text-anchor="middle" font-weight="600">
    <text x="335" y="56">Strategic</text><text x="335" y="126">Tactical</text><text x="335" y="200">Operational</text>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="335" y="72">top management</text>
    <text x="335" y="142">middle management</text>
    <text x="335" y="216">supervisors and staff</text>
  </g>
  <g fill="currentColor" font-size="11">
    <text x="446" y="52">EIS / DSS</text><text x="446" y="66">long term, external data</text>
    <text x="476" y="126">MIS</text><text x="476" y="140">summary reports, monthly</text>
    <text x="482" y="200">TPS</text><text x="482" y="214">daily transactions, detailed</text>
  </g>
  <g stroke="currentColor" stroke-width="1.2" fill="none">
    <path d="M405 56 H440"/><path d="M436 128 H470"/><path d="M470 200 H476"/>
  </g>
</svg>
<figcaption>Fewer people towards the top, and the information they need becomes more summarised, longer-term and more external.</figcaption>
</figure>

<ul>
<li><strong>Operational level</strong> — supervisors and staff running
day-to-day activity. Decisions are structured and repetitive: process this
order, record this sale. Information needed: detailed, internal, current, very
frequent.</li>
<li><strong>Tactical level</strong> — middle management, allocating resources
and monitoring performance over weeks and months. Decisions are
semi-structured. Information needed: summarised, mostly internal, with
comparisons against target.</li>
<li><strong>Strategic level</strong> — top management, setting direction over
years. Decisions are unstructured. Information needed: highly summarised, much
of it from outside the organisation, forecast rather than record.</li>
</ul>

<h3>Why each level needs its own system</h3>
<p>Because the same data is useless at the wrong level of detail. A managing
director cannot read three million transactions, and a till operator cannot use
a five-year market forecast. The pyramid summarises upwards.</p>

<h3>The systems named on the syllabus</h3>
<ul>
<li><strong>TPS — Transaction Processing System.</strong> Records and processes
daily transactions: sales, receipts, payroll, stock movements. Operational
level. It is the source of the data everything else uses.</li>
<li><strong>MIS — Management Information System.</strong> Summarises TPS data
into regular structured reports for middle management. Tactical level. Answers
"what happened last month?"</li>
<li><strong>DSS — Decision Support System.</strong> Interactive, model-based,
for semi-structured problems. Lets a manager ask "what if?" — what if we raise
the price by 5%? Tactical and strategic.</li>
<li><strong>EIS — Executive Information System.</strong> Highly summarised
information for top management, with graphics and the ability to drill down.
Combines internal and external data. Strategic.</li>
<li><strong>GIS — Geographic Information System.</strong> Captures, stores and
analyses data tied to location, displayed as maps. Town planning, agriculture,
utilities, epidemic mapping, routing.</li>
<li><strong>HIS — Health Information System.</strong> Patient records,
admissions, pharmacy, laboratory results, billing. Used in hospitals to make
the record available wherever the patient is treated.</li>
<li><strong>LIS — Library Information System.</strong> Catalogue, loans,
returns, reservations, overdue notices, acquisitions.</li>
</ul>

<h3>In the exam</h3>
<p>TPS against MIS against DSS is the classic three-way distinction. TPS
<em>records</em> what happened. MIS <em>reports</em> what happened. DSS
<em>models</em> what might happen. Learn those three verbs and the answer
follows.</p>', 'html', 51),
  ('7708fc20-d7eb-504e-a85f-4629d8e2e640', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'The role of MIS in planning', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Decision making and organization of a company</li><li>Factors affecting the success or failure of MIS</li></ul></div><div class="def-box"><strong>Management Information System:</strong> a system
that collects data from operations, processes it, and produces regular
structured reports that managers use to plan, monitor and control.</div>

<h3>Decision making and the organisation</h3>
<p>Decisions come in three kinds, and each needs different information.</p>
<ul>
<li><strong>Structured</strong> — routine, with a clear rule. Reorder when
stock falls below 50. The computer can make it.</li>
<li><strong>Semi-structured</strong> — part rule, part judgement. Which
supplier to use this quarter. The computer supports it.</li>
<li><strong>Unstructured</strong> — no rule at all. Should we open a branch in
Bamenda? The computer informs it and a person decides.</li>
</ul>
<p>The decision-making process itself: define the problem, gather information,
identify the alternatives, evaluate them, choose, implement, then review. An
MIS supports every stage except the choosing.</p>

<h3>What an MIS contributes to planning</h3>
<ul>
<li><strong>Provides the facts.</strong> Planning on impressions produces plans
that fail. The MIS supplies actual figures.</li>
<li><strong>Shows trends.</strong> Sales over twelve months reveal a direction
that any single month hides.</li>
<li><strong>Compares actual against budget</strong>, so a plan that is drifting
is noticed while there is still time to correct it.</li>
<li><strong>Supports forecasting</strong>, which is the raw material of a
plan.</li>
<li><strong>Highlights exceptions.</strong> Managers do not have time to read
everything; a good MIS reports what is outside the expected range.</li>
<li><strong>Speeds the cycle.</strong> A report available on the first of the
month rather than the twentieth is worth far more.</li>
<li><strong>Coordinates.</strong> Every department plans from the same numbers,
so the plans fit together.</li>
</ul>

<h3>Factors affecting the success of an MIS</h3>
<ul>
<li>Top management commitment and involvement. Without it the system is never
given the authority it needs.</li>
<li>Clear objectives, agreed before the system is built.</li>
<li>Users involved in the design, so the reports are the ones they actually
want.</li>
<li>Accurate, complete and timely input data.</li>
<li>Adequate training, and continuing support.</li>
<li>Reports matched to the level of the manager reading them.</li>
<li>Flexibility, so the system can change as the organisation does.</li>
<li>Reliable hardware, software and network.</li>
</ul>

<h3>Factors causing failure</h3>
<ul>
<li>Poor quality input data. Wrong in, wrong out, and confidence in the system
never recovers.</li>
<li>Users not consulted, so the system does not fit the work and is worked
around.</li>
<li>Too much information rather than too little — a manager buried in reports
reads none of them.</li>
<li>Resistance to change, and fear of monitoring or job loss.</li>
<li>Unrealistic expectations of what an MIS can do; it supports decisions, it
does not make them.</li>
<li>Inadequate training and no ongoing support.</li>
<li>Cost and time overruns during development.</li>
<li>Rigidity: a system that cannot change as the organisation changes becomes
useless within a few years.</li>
</ul>

<h3>In the exam</h3>
<p>"Poor data quality" and "lack of user involvement" are the two failure
causes worth writing first, because almost every real failure includes at least
one of them. And note the boundary: an MIS supports the manager. It does not
replace the manager''s judgement.</p>', 'html', 52),
  ('46e07c05-00e8-5407-89f9-d242a772e2ac', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Introduction to Artificial Intelligence (AI)', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Cognitive science application (expert systems, learning systems)</li><li>Robotics application (visual perception, tactility)</li><li>Natural interface application (natural languages, speech recognition)</li></ul></div><div class="def-box"><strong>Artificial intelligence:</strong> the branch of
computer science concerned with building machines that perform tasks which
would normally require human intelligence — learning, reasoning, problem
solving, perception and understanding language.</div>

<h3>The three application areas on the syllabus</h3>

<h4>1. Cognitive science applications</h4>
<p>Machines that reason and learn.</p>
<ul>
<li><strong>Expert systems</strong> — capture the knowledge of a human expert
in a narrow field and use it to advise. Medical diagnosis, mineral
prospecting, loan assessment. Covered fully in its own lesson.</li>
<li><strong>Learning systems</strong> — improve their performance from
experience or data rather than from being reprogrammed. Shown enough labelled
examples, the system finds the pattern itself. Spam filters, fraud detection,
recommendation systems.</li>
<li><strong>Neural networks</strong> — a structure loosely modelled on the
brain, made of connected nodes with weights adjusted during training. Good at
recognition tasks where the rule is hard to write down.</li>
<li><strong>Intelligent agents</strong> — software that acts on a user''s behalf
towards a goal, with some independence.</li>
</ul>

<h4>2. Robotics applications</h4>
<p>Machines that sense and act in the physical world.</p>
<ul>
<li><strong>Visual perception</strong> — a camera plus software that
interprets what is in the image, not just records it. A robot that identifies
which component is in front of it, or a system that reads a number plate.</li>
<li><strong>Tactility</strong> — touch and force sensing. It lets a robot pick
up an egg without crushing it and a bolt without dropping it, by feeling how
hard it is gripping.</li>
<li><strong>Locomotion and navigation</strong> — moving through an environment
and avoiding obstacles.</li>
</ul>

<h4>3. Natural interface applications</h4>
<p>Machines you communicate with as you would with a person.</p>
<ul>
<li><strong>Natural language processing</strong> — understanding and producing
ordinary human language: translation, question answering, summarising.</li>
<li><strong>Speech recognition</strong> — converting spoken words to text; and
speech synthesis, converting text to speech.</li>
<li><strong>Virtual reality interfaces</strong> — interacting with a system by
moving in it rather than by typing.</li>
<li><strong>Multi-sensory interfaces</strong> — gesture, gaze, handwriting.</li>
</ul>

<h3>Advantages of AI</h3>
<ul>
<li>Works continuously without tiring, and is consistent — it does not have a
bad afternoon.</li>
<li>Handles volumes of data no person could read.</li>
<li>Operates where people cannot: inside a reactor, deep underwater, in
space.</li>
<li>Preserves expertise that would otherwise retire with the expert.</li>
<li>Fast: a diagnosis or a fraud check in a fraction of a second.</li>
</ul>

<h3>Limitations</h3>
<ul>
<li>No common sense, and no understanding outside the task it was built
for.</li>
<li>No genuine creativity or emotion, and no accountability for a decision.</li>
<li>Only as good as its training data — biased data gives biased decisions,
confidently.</li>
<li>Expensive to build and to maintain.</li>
<li>Job displacement, and hard questions about responsibility when it is
wrong.</li>
</ul>

<h3>In the exam</h3>
<p>Give the area, an example, and what makes it "intelligent". "Speech
recognition, in a phone assistant. It is intelligent because it interprets a
signal that varies with accent, speed and background noise, rather than
matching a fixed pattern."</p>', 'html', 53),
  ('20e70965-3a56-50cf-945d-5a64a0a5e59b', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Real life application of Artificial Intelligence', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>In education, health, banking, company, home</li></ul></div><p>Five settings on the syllabus. For each: what the system does, and what it
gains.</p>

<h3>In education</h3>
<ul>
<li><strong>Intelligent tutoring</strong> — the system tracks which questions a
student gets wrong and adjusts what it asks next, so a weak topic is drilled
and a strong one skipped.</li>
<li><strong>Automated marking</strong> of objective work, and increasingly of
short written answers, freeing teacher time.</li>
<li><strong>Plagiarism detection</strong>, comparing submitted work against a
large corpus.</li>
<li><strong>Language learning</strong> with speech recognition that corrects
pronunciation.</li>
<li><em>Gain:</em> teaching adapted to the individual, at a scale no teacher
could manage with sixty students in a class.</li>
</ul>

<h3>In health</h3>
<ul>
<li><strong>Diagnosis support</strong> — expert systems that suggest likely
causes from symptoms and test results.</li>
<li><strong>Medical image analysis</strong> — detecting tumours or fractures on
scans, often finding what the eye misses.</li>
<li><strong>Drug discovery</strong> — screening enormous numbers of candidate
compounds computationally before any laboratory work.</li>
<li><strong>Robotic surgery</strong>, with precision beyond the human hand, and
<strong>patient monitoring</strong> that raises an alarm on a pattern rather
than a single reading.</li>
<li><em>Gain:</em> expertise reaches places without a specialist. A rural
health centre can get a second opinion it could not otherwise have.</li>
</ul>

<h3>In banking</h3>
<ul>
<li><strong>Fraud detection</strong> — a learned model of your normal
behaviour, and an alert when a transaction does not fit it. Your card used in
two countries within an hour.</li>
<li><strong>Credit scoring</strong> — assessing the risk of a loan from
patterns in past lending.</li>
<li><strong>Chatbots</strong> handling routine customer questions at any
hour.</li>
<li><strong>Algorithmic trading</strong>, and cheque reading by OCR.</li>
<li><em>Gain:</em> decisions in milliseconds on volumes no human team could
review. <em>Risk:</em> a model trained on biased history refuses loans to the
same groups the history refused.</li>
</ul>

<h3>In companies</h3>
<ul>
<li><strong>Demand forecasting</strong> and stock optimisation.</li>
<li><strong>Recommendation systems</strong> — customers who bought this also
bought that.</li>
<li><strong>Customer service</strong> chatbots and call routing.</li>
<li><strong>Recruitment screening</strong>, though this is where bias
complaints arise most.</li>
<li><strong>Predictive maintenance</strong> — servicing a machine before it
breaks, from sensor readings.</li>
</ul>

<h3>In the home</h3>
<ul>
<li><strong>Voice assistants</strong>, and smart appliances that learn a
household''s pattern.</li>
<li><strong>Smart thermostats and lighting</strong> that adjust
automatically.</li>
<li><strong>Security</strong> — cameras that distinguish a person from a cat,
and face recognition at the door.</li>
<li><strong>Robot vacuum cleaners</strong> that map the room.</li>
<li><em>Concern:</em> a device with a microphone in a living room is a privacy
question, not just a convenience.</li>
</ul>

<h3>In the exam</h3>
<p>Name the sector, name the application, say what it does, and give one
benefit. Four short clauses. A list of sectors with no application named
scores almost nothing.</p>', 'html', 54),
  ('a5c31da9-da82-5bce-8b53-3d04b3505dec', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Practical: Web Authoring', '<p>Web authoring runs across the last weeks of the year. Build one small site
and improve it each session rather than starting again each time.</p>

<h3>The structure of a page</h3>
<pre>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;title&gt;GHS Mbonjo — ICT&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
  &lt;h1&gt;Lower Sixth ICT&lt;/h1&gt;
  &lt;p&gt;Welcome to our class page.&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;</pre>
<p>Note the parts: <code>head</code> holds information <em>about</em> the page;
<code>body</code> holds what is displayed. The title appears in the browser tab,
not on the page.</p>

<h3>Tags to know</h3>
<ul>
<li>Headings <code>&lt;h1&gt;</code> to <code>&lt;h6&gt;</code>, paragraphs
<code>&lt;p&gt;</code>, line break <code>&lt;br&gt;</code>.</li>
<li>Emphasis <code>&lt;strong&gt;</code> and <code>&lt;em&gt;</code>.</li>
<li>Lists: <code>&lt;ul&gt;</code> unordered, <code>&lt;ol&gt;</code> ordered,
with <code>&lt;li&gt;</code> for each item.</li>
<li>Link: <code>&lt;a href="page2.html"&gt;Next&lt;/a&gt;</code>.</li>
<li>Image: <code>&lt;img src="crest.png" alt="School crest"&gt;</code>. The
<code>alt</code> text is required — it is what a screen reader announces and
what shows if the image fails.</li>
<li>Table: <code>&lt;table&gt;</code>, <code>&lt;tr&gt;</code> for a row,
<code>&lt;th&gt;</code> for a heading cell, <code>&lt;td&gt;</code> for a data
cell.</li>
</ul>

<h3>Separating content from presentation</h3>
<p>HTML says what a thing <em>is</em>. CSS says what it <em>looks like</em>.
Keep them apart, in separate files, because then one stylesheet changes every
page at once.</p>
<pre>&lt;link rel="stylesheet" href="style.css"&gt;

/* style.css */
body   { font-family: sans-serif; margin: 20px; }
h1     { color: #0b2545; }
.note  { border-left: 3px solid #c9a227; padding-left: 10px; }</pre>

<h3>Build this</h3>
<ul>
<li>Three linked pages: home, subjects, contact. Every page links to the other
two.</li>
<li>One shared stylesheet.</li>
<li>A table of the week''s timetable.</li>
<li>An image with proper alt text.</li>
<li>A form with text inputs and a submit button. Note that without a
server-side script the form has nowhere to send its data — say so if
asked.</li>
<li>Validate the pages, and check them in two different browsers.</li>
</ul>

<h3>In the exam</h3>
<p>You may be given HTML with errors and asked to correct it. The usual faults
are an unclosed tag, wrong nesting, a missing quotation mark in an attribute,
and a missing <code>alt</code>. Read the tags as a set of nested boxes: what
opens last must close first.</p>', 'html', 55),
  ('a1f1d0df-3c5f-5bfb-a0c4-71dba18ea74a', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Robotics Application', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Uses in manufacturing, health, home</li><li>Advantages and limitations of robots</li></ul></div><div class="def-box"><strong>Robot:</strong> a reprogrammable, multifunctional
machine designed to move materials, parts or tools through variable programmed
motions to perform a task.</div>
<p>Two words in that definition matter: <em>reprogrammable</em> and
<em>multifunctional</em>. A machine that can only do one fixed thing is
automation, not a robot.</p>

<h3>Parts of a robot</h3>
<ul>
<li><strong>Sensors</strong> — sight, touch, proximity, force. Its input.</li>
<li><strong>Controller</strong> — the computer that decides. Its
processing.</li>
<li><strong>Actuators and effectors</strong> — motors, arms, grippers. Its
output.</li>
<li><strong>Power supply</strong>, and a <strong>manipulator</strong>: the arm
itself, described by its degrees of freedom.</li>
</ul>

<h3>In manufacturing</h3>
<ul>
<li>Welding, paint spraying, assembly, packing, palletising, materials
handling.</li>
<li>Quality inspection with machine vision.</li>
<li>Ideal here because the work is repetitive, precise, heavy, and often
dangerous — welding fumes and paint solvents harm people and do not harm
robots.</li>
</ul>

<h3>In health</h3>
<ul>
<li><strong>Surgical robots</strong> — the surgeon''s hand movements are scaled
down and tremor removed, allowing smaller incisions and faster recovery.</li>
<li><strong>Rehabilitation robots and prosthetics</strong> — exoskeletons that
help a patient walk again, and responsive artificial limbs.</li>
<li><strong>Hospital logistics</strong> — moving supplies, linen and
specimens.</li>
<li><strong>Pharmacy dispensing</strong>, and <strong>telepresence</strong> so
a specialist can attend a ward remotely.</li>
</ul>

<h3>In the home</h3>
<ul>
<li>Vacuum cleaners and lawn mowers that map an area and cover it.</li>
<li>Companion and assistive robots for the elderly, with reminders for
medication.</li>
<li>Toys and educational robots.</li>
</ul>

<h3>Advantages of robots</h3>
<ul>
<li>Work continuously, 24 hours, with no breaks, wages or sick leave.</li>
<li>Consistent quality and accuracy; no fatigue and no lapses in
concentration.</li>
<li>Do dangerous work — chemicals, heat, radiation, heavy loads — so people do
not have to.</li>
<li>Higher output and lower unit cost once installed.</li>
<li>Can be reprogrammed for a new product rather than replaced.</li>
</ul>

<h3>Limitations of robots</h3>
<ul>
<li>Very high initial cost, and skilled maintenance is expensive.</li>
<li>No judgement. A robot handles the situation it was programmed for and
nothing else.</li>
<li>No creativity, and no dealing with the unexpected.</li>
<li>Job losses among the workers replaced, who are rarely the ones hired to
maintain the robots.</li>
<li>Breakdown stops the whole line, and the organisation becomes dependent on
the technology.</li>
<li>Not economic for short production runs or one-off work.</li>
</ul>

<h3>In the exam</h3>
<p>The strongest justification for a robot is a task that is dull, dirty or
dangerous. Use that phrase and give an example of each and the marks come
easily.</p>', 'html', 56),
  ('719f3b35-3807-5e0f-b1b0-4ecf2b723505', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Knowledge-based system (Expert system)', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Components, application, and examples</li><li>Advantages and disadvantages</li></ul></div><div class="def-box"><strong>Expert system:</strong> a computer program that
uses stored expert knowledge and a set of reasoning rules to solve problems, or
give advice, at the level of a human expert in a narrow field.</div>

<figure class="fig">
<svg viewBox="0 0 660 260" role="img" aria-label="Components of an expert system: user interface, inference engine, knowledge base, explanation facility and knowledge acquisition">
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="30" y="98" width="118" height="52" rx="6"/>
    <rect x="216" y="98" width="140" height="52" rx="6"/>
    <rect x="424" y="98" width="140" height="52" rx="6"/>
    <rect x="216" y="14" width="140" height="46" rx="6"/>
    <rect x="424" y="196" width="140" height="46" rx="6"/>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="89" y="120">User</text><text x="89" y="136">interface</text>
    <text x="286" y="120">Inference</text><text x="286" y="136">engine</text>
    <text x="494" y="118">Knowledge base</text><text x="494" y="134" font-size="10">facts + IF-THEN rules</text>
    <text x="286" y="34">Explanation</text><text x="286" y="50">facility</text>
    <text x="494" y="216">Knowledge</text><text x="494" y="232">acquisition</text>
  </g>
  <g stroke="currentColor" stroke-width="1.5" fill="none" marker-end="url(#ah8)">
    <path d="M148 116 H210"/><path d="M210 138 H152"/>
    <path d="M356 116 H418"/><path d="M418 138 H360"/>
    <path d="M286 98 V66"/><path d="M494 196 V156"/>
  </g>
  <text x="600" y="222" font-size="10" fill="currentColor" text-anchor="middle">from the</text>
  <text x="600" y="236" font-size="10" fill="currentColor" text-anchor="middle">human expert</text>
  <defs><marker id="ah8" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>The components. Knowledge and reasoning are deliberately kept apart, so the knowledge can be changed without rewriting the program.</figcaption>
</figure>

<h3>The components</h3>
<ul>
<li><strong>Knowledge base</strong> — the facts and the rules, gathered from
human experts. Rules are written as IF condition THEN conclusion. "IF the
patient has a fever AND a rash THEN consider measles."</li>
<li><strong>Inference engine</strong> — the reasoning part. It applies the
rules to the facts supplied to reach a conclusion. Forward chaining works from
the facts towards a conclusion; backward chaining starts from a possible
conclusion and looks for facts supporting it.</li>
<li><strong>User interface</strong> — asks the user questions and presents the
advice, usually in plain language.</li>
<li><strong>Explanation facility</strong> — tells the user <em>why</em> it
asked a question and <em>how</em> it reached its conclusion. Without this
nobody trusts the advice, which is why it is a component rather than a
luxury.</li>
<li><strong>Knowledge acquisition subsystem</strong> — how new knowledge is
added, by a knowledge engineer working with human experts.</li>
</ul>

<h3>Applications and examples</h3>
<ul>
<li><strong>Medical diagnosis</strong> — MYCIN, which diagnosed blood
infections, is the classic example.</li>
<li><strong>Mineral prospecting</strong> — PROSPECTOR, for geological
data.</li>
<li><strong>Chemical analysis</strong> — DENDRAL, identifying molecular
structures.</li>
<li>Also: fault diagnosis in engines and networks, loan and insurance
assessment, tax advice, and agricultural advice on crops and pests.</li>
</ul>

<h3>Advantages</h3>
<ul>
<li>Expertise is available where no expert is, and at any hour.</li>
<li>Consistent: it gives the same advice on the same facts every time, and is
never tired or distracted.</li>
<li>Preserves knowledge that would otherwise be lost when an expert retires or
dies.</li>
<li>Cheaper than employing a scarce specialist, once built.</li>
<li>Fast, and it can consider more rules than a person holds in mind.</li>
<li>Explains its reasoning, so it can be checked and used for training.</li>
</ul>

<h3>Disadvantages</h3>
<ul>
<li>Expensive and slow to build, because eliciting knowledge from experts is
difficult — experts often cannot say how they know.</li>
<li>No common sense. Outside its narrow domain it fails, and it may fail
without indicating that it has.</li>
<li>Cannot learn from experience unless designed to; the knowledge base must be
updated by hand.</li>
<li>Cannot handle a case the rules do not cover, where a human expert would
improvise.</li>
<li>Raises the question of responsibility when the advice is wrong.</li>
<li>Users may follow it without question, which is a risk in medicine
especially.</li>
</ul>

<h3>In the exam</h3>
<p>The knowledge base and the inference engine, kept separate, are the two
components you must name. The explanation facility is the one candidates
forget, and it is often the third mark.</p>', 'html', 57),
  ('6aa383d1-1edd-54bc-b088-0438d0672748', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Introduction to Simulation', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Definition, application in real life systems or situations</li><li>Advantages and limitations</li></ul></div><div class="def-box"><strong>Model:</strong> a simplified representation of a
real system or situation.
<br><strong>Simulation:</strong> running a model over time to study how the
real system would behave under given conditions.</div>
<p>Every model leaves something out. That is not a flaw, it is the definition —
a model that included everything would be the thing itself.</p>

<h3>Applications</h3>
<ul>
<li><strong>Flight simulators</strong> — pilots trained on engine failures and
bad weather without risking an aircraft or anybody''s life.</li>
<li><strong>Weather forecasting</strong> — the atmosphere modelled on a grid
and run forward in time.</li>
<li><strong>Crash testing</strong> — a vehicle design tested computationally
before a prototype is built.</li>
<li><strong>Queue modelling</strong> — how many tills a supermarket or how many
tellers a bank should open, given the arrival pattern.</li>
<li><strong>Traffic modelling</strong> — the effect of a new junction before it
is built.</li>
<li><strong>Nuclear and chemical processes</strong>, where the real experiment
is unthinkable.</li>
<li><strong>Epidemic modelling</strong> — how a disease would spread under
different interventions.</li>
<li><strong>Financial and business models</strong> — a spreadsheet asking "what
if we raise the price by 5%?" is a simulation.</li>
<li><strong>Training simulators</strong> for surgeons, drivers and plant
operators.</li>
</ul>

<h3>Advantages</h3>
<ul>
<li><strong>Safety.</strong> Dangerous situations rehearsed without danger.</li>
<li><strong>Cost.</strong> Far cheaper than building and destroying the real
thing.</li>
<li><strong>Time.</strong> It can be compressed — fifty years of climate in an
afternoon — or expanded, to study a millisecond of an explosion.</li>
<li><strong>Repeatable.</strong> The same conditions can be run again exactly,
which the real world never allows.</li>
<li><strong>Controllable.</strong> One variable changed at a time, so cause can
be separated from coincidence.</li>
<li><strong>Possible at all</strong> where the real experiment is impossible:
the collision of galaxies, or the collapse of an economy.</li>
</ul>

<h3>Limitations</h3>
<ul>
<li><strong>The model may be wrong.</strong> A simplification that leaves out
something that matters gives a confident, precise, wrong answer.</li>
<li>Expensive to develop, and it needs expertise in both computing and the
subject being modelled.</li>
<li>Needs accurate data to start from; poor data gives poor results.</li>
<li>Complex models need substantial computing power and time.</li>
<li>Results can be trusted too readily because they come from a computer and
look authoritative.</li>
<li>A simulation cannot fully reproduce human behaviour, which is the least
predictable part of most real systems.</li>
</ul>

<h3>In the exam</h3>
<p>State that the results are only as good as the model. That single sentence
is worth a mark in almost every "limitations of simulation" question, and it is
the one most candidates leave out.</p>', 'html', 58),
  ('ced13f4c-cf97-5fdb-ae39-84427c4d6ab9', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Virtual reality (VR) and Augmented Reality (AR)', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Description and role of VR and AR</li><li>Compare AR and VR with examples of each</li></ul></div><div class="def-box"><strong>Virtual reality:</strong> a computer-generated
environment that <em>replaces</em> the real world, which the user experiences
as though present in it.
<br><strong>Augmented reality:</strong> computer-generated information
<em>added to</em> the user''s view of the real world.</div>
<p>One word separates them. VR replaces. AR adds.</p>

<figure class="fig">
<svg viewBox="0 0 620 190" role="img" aria-label="Virtual reality replaces the view entirely while augmented reality overlays information on the real view">
  <text x="160" y="22" font-size="13" fill="currentColor" text-anchor="middle" font-weight="600">VR — the view is replaced</text>
  <text x="460" y="22" font-size="13" fill="currentColor" text-anchor="middle" font-weight="600">AR — the view is overlaid</text>
  <rect x="60" y="38" width="200" height="110" rx="6" fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5"/>
  <text x="160" y="86" font-size="12" fill="currentColor" text-anchor="middle">entirely computer</text>
  <text x="160" y="104" font-size="12" fill="currentColor" text-anchor="middle">generated world</text>
  <rect x="360" y="38" width="200" height="110" rx="6" fill="none" stroke="currentColor" stroke-width="1.5"/>
  <g stroke="currentColor" stroke-width="1.2" fill="none" opacity="0.6">
    <path d="M380 128 L420 92 L450 118 L490 72 L540 128"/>
    <circle cx="410" cy="62" r="10"/>
  </g>
  <rect x="392" y="84" width="96" height="30" rx="4" fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.4"/>
  <text x="440" y="103" font-size="11" fill="currentColor" text-anchor="middle">added label</text>
  <text x="160" y="172" font-size="11" fill="currentColor" text-anchor="middle">headset blocks the real world</text>
  <text x="460" y="172" font-size="11" fill="currentColor" text-anchor="middle">real world still visible underneath</text>
</svg>
<figcaption>VR takes you somewhere else. AR keeps you where you are and writes on it.</figcaption>
</figure>

<h3>Virtual reality</h3>
<ul>
<li><strong>Equipment:</strong> headset with a screen for each eye, head
tracking, hand controllers or gloves, sometimes a treadmill or a motion
platform.</li>
<li><strong>Role:</strong> immersion. The user is placed inside a situation
that is dangerous, expensive, distant or imaginary.</li>
<li><strong>Uses:</strong> flight and surgical training; walking through a
building before it is built; exposure therapy for phobias; games; museum and
heritage tours; rehearsing a military or emergency operation.</li>
</ul>

<h3>Augmented reality</h3>
<ul>
<li><strong>Equipment:</strong> a phone or tablet camera, or smart glasses,
with software that recognises what is in view and positions the overlay.</li>
<li><strong>Role:</strong> information delivered exactly where it is needed,
while you keep working with your hands and eyes on the real thing.</li>
<li><strong>Uses:</strong> a surgeon seeing a scan overlaid on the patient; a
technician seeing repair instructions on the engine in front of them;
navigation arrows drawn on the road ahead; furniture previewed in your own
room; a museum exhibit that labels itself; classroom anatomy over a real
model.</li>
</ul>

<h3>Comparison</h3>
<table>
<tr><th></th><th>VR</th><th>AR</th></tr>
<tr><td>Real world</td><td>Blocked out</td><td>Still visible</td></tr>
<tr><td>Immersion</td><td>Total</td><td>Partial</td></tr>
<tr><td>Typical device</td><td>Headset</td><td>Phone or glasses</td></tr>
<tr><td>Cost</td><td>Higher</td><td>Lower — most people own the device</td></tr>
<tr><td>Best for</td><td>Training and experience in a safe copy of a place</td><td>Guidance while doing a real task</td></tr>
<tr><td>Main risk</td><td>Isolation, motion sickness, cannot see hazards</td><td>Distraction from the real surroundings</td></tr>
</table>

<h3>Advantages and disadvantages</h3>
<ul>
<li><strong>Advantages:</strong> safe practice of dangerous tasks; better
understanding of three-dimensional information; engagement and motivation in
learning; visiting places that are inaccessible or do not exist.</li>
<li><strong>Disadvantages:</strong> equipment cost; motion sickness and eye
strain; VR isolates the user from real hazards and from other people; content
is expensive to produce; and AR raises privacy questions, since a device that
recognises what you look at is also recording it.</li>
</ul>

<h3>In the exam</h3>
<p>Every comparison question is answered by "replaces" against "adds to", plus
one example of each. Write that first, then expand.</p>', 'html', 59),
  ('5724b06f-63e7-525c-b825-cab6783e3010', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Phases of SDLC', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Investigation: problem identification, data collection, feasibility study (economic, technical, operational, organisational, schedule)</li><li>Analysis: detailed study of old system, functional requirement analysis, user and technical documentation</li><li>Design: user interface design, data design, process design</li><li>Development: developing software, integration of modules, unit, system and integration testing</li></ul></div><div class="def-box"><strong>System Development Life Cycle:</strong> the series
of stages followed in building an information system, from first investigation
through to maintenance.</div>

<figure class="fig">
<svg viewBox="0 0 660 250" role="img" aria-label="The six phases of the system development life cycle arranged as a cycle">
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="248" y="12" width="150" height="42" rx="8"/>
    <rect x="446" y="70" width="150" height="42" rx="8"/>
    <rect x="446" y="146" width="150" height="42" rx="8"/>
    <rect x="248" y="200" width="150" height="42" rx="8"/>
    <rect x="52" y="146" width="150" height="42" rx="8"/>
    <rect x="52" y="70" width="150" height="42" rx="8"/>
  </g>
  <g fill="currentColor" font-size="12.5" text-anchor="middle">
    <text x="323" y="38">1. Investigation</text>
    <text x="521" y="96">2. Analysis</text>
    <text x="521" y="172">3. Design</text>
    <text x="323" y="226">4. Development</text>
    <text x="127" y="172">5. Implementation</text>
    <text x="127" y="96">6. Maintenance</text>
  </g>
  <g stroke="currentColor" stroke-width="1.5" fill="none" marker-end="url(#ah9)">
    <path d="M398 38 H424 Q446 38 446 60 V64"/>
    <path d="M521 112 V140"/>
    <path d="M446 188 Q424 200 400 210"/>
    <path d="M248 218 H222 Q202 214 190 192"/>
    <path d="M127 146 V118"/>
    <path d="M202 84 Q232 50 244 40"/>
  </g>
  <text x="323" y="128" font-size="11" fill="currentColor" text-anchor="middle">maintenance can send the system</text>
  <text x="323" y="143" font-size="11" fill="currentColor" text-anchor="middle">back to investigation — hence a cycle</text>
  <defs><marker id="ah9" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>It is a cycle rather than a line because maintenance eventually raises requirements that start the whole thing again.</figcaption>
</figure>

<h3>1. Investigation</h3>
<ul>
<li><strong>Problem identification</strong> — what is actually wrong with the
present system? State it as a problem, not as a solution.</li>
<li><strong>Data collection</strong> — interviews, questionnaires,
observation, and examination of existing documents. Each has a place:
interviews get depth from a few people; questionnaires get breadth from many;
observation shows what people really do rather than what they say they do;
documents show what the system is supposed to produce.</li>
<li><strong>Feasibility study</strong> — five kinds, and the exam asks for
them by name:
<ul>
<li><strong>Economic</strong> — do the benefits justify the cost? A cost-benefit
analysis.</li>
<li><strong>Technical</strong> — does the technology exist, and do we have or
can we get the skills and equipment?</li>
<li><strong>Operational</strong> — will it work in practice, and will the staff
accept and use it?</li>
<li><strong>Organisational</strong> — does it fit the organisation''s structure,
policies and objectives?</li>
<li><strong>Schedule</strong> — can it be delivered in the time available?</li>
</ul></li>
<li>Output: a feasibility report recommending whether to proceed.</li>
</ul>

<h3>2. Analysis</h3>
<ul>
<li><strong>Detailed study of the old system</strong> — how it works now, what
data flows through it, what it costs, where it fails and why.</li>
<li><strong>Functional requirement analysis</strong> — exactly what the new
system must do. Functional requirements say what it does; non-functional
requirements say how well — speed, capacity, security, availability.</li>
<li><strong>Documentation</strong>. Two kinds, and they are for different
readers:
<ul>
<li><strong>User documentation</strong> — for the person operating the system.
How to install, how to log in, how to perform each task, what the error
messages mean, a troubleshooting section, a glossary. Written in plain
language.</li>
<li><strong>Technical documentation</strong> — for the people who will maintain
it. System design, data structures, file and database layouts, algorithms,
program listings, test plans and results, hardware requirements.</li>
</ul></li>
<li>Output: a requirements specification, agreed with the client.</li>
</ul>

<h3>3. Design</h3>
<ul>
<li><strong>User interface design</strong> — input screens, output layouts,
menus and reports. Consistent, clear, with validation on every input and
sensible error messages.</li>
<li><strong>Data design</strong> — files or tables, fields, data types,
lengths, keys, relationships, and the validation rules. Normalisation belongs
here.</li>
<li><strong>Process design</strong> — the algorithms and program structure, in
flowcharts, pseudocode, data flow diagrams and structure charts.</li>
<li>Also decided here: hardware and network requirements, and the security
design.</li>
<li>Output: a design specification detailed enough to build from.</li>
</ul>

<h3>4. Development</h3>
<ul>
<li><strong>Writing the software</strong> — coding each module from the
design.</li>
<li><strong>Integration of modules</strong> — joining the parts into a working
whole.</li>
<li><strong>Testing</strong>, in three levels:
<ul>
<li><strong>Unit testing</strong> — each module alone.</li>
<li><strong>Integration testing</strong> — the modules working together, which
is where interfaces between them fail.</li>
<li><strong>System testing</strong> — the complete system against the
requirements.</li>
</ul></li>
<li>Test data must include <strong>normal</strong> values, <strong>extreme
or boundary</strong> values, and <strong>abnormal or invalid</strong> values.
A test plan with only normal data proves nothing.</li>
</ul>

<h3>In the exam</h3>
<p>The five feasibility studies and the three levels of testing are both
straight recall, and both come up often. Learn them as lists and write them as
lists.</p>', 'html', 60),
  ('3f9100d4-2c17-5961-998d-012d0eb1c619', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'System Implementation and Maintenance', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Implementation strategies: direct (plunge), parallel, phased (piecemeal), and pilot</li><li>Advantages and disadvantages of each type</li><li>Maintenance: debugging, corrective, adaptive maintenance</li></ul></div><h3>Implementation strategies</h3>
<p>Four ways to move from the old system to the new one. Each is a different
answer to one question: how much risk can this organisation carry?</p>

<figure class="fig">
<svg viewBox="0 0 660 290" role="img" aria-label="Four implementation strategies: direct, parallel, phased and pilot">
  <g font-size="12" fill="currentColor">
    <text x="14" y="34">Direct</text><text x="14" y="104">Parallel</text>
    <text x="14" y="182">Phased</text><text x="14" y="256">Pilot</text>
  </g>
  <!-- direct -->
  <rect x="110" y="18" width="180" height="24" fill="none" stroke="currentColor" stroke-width="1.4"/>
  <rect x="290" y="18" width="250" height="24" fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.4"/>
  <text x="200" y="35" font-size="11" fill="currentColor" text-anchor="middle">old system</text>
  <text x="415" y="35" font-size="11" fill="currentColor" text-anchor="middle">new system</text>
  <text x="290" y="58" font-size="10" fill="currentColor" text-anchor="middle">switch</text>
  <!-- parallel -->
  <rect x="110" y="76" width="300" height="22" fill="none" stroke="currentColor" stroke-width="1.4"/>
  <rect x="230" y="102" width="310" height="22" fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.4"/>
  <text x="170" y="92" font-size="11" fill="currentColor" text-anchor="middle">old</text>
  <text x="480" y="118" font-size="11" fill="currentColor" text-anchor="middle">new</text>
  <text x="320" y="140" font-size="10" fill="currentColor" text-anchor="middle">both run together for a period</text>
  <!-- phased -->
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.4">
    <rect x="110" y="164" width="130" height="22"/><rect x="250" y="164" width="130" height="22"/>
    <rect x="390" y="164" width="150" height="22"/>
  </g>
  <g font-size="11" fill="currentColor" text-anchor="middle">
    <text x="175" y="180">module 1</text><text x="315" y="180">module 2</text><text x="465" y="180">module 3</text>
  </g>
  <text x="320" y="202" font-size="10" fill="currentColor" text-anchor="middle">introduced one part at a time</text>
  <!-- pilot -->
  <rect x="110" y="230" width="150" height="22" fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.4"/>
  <rect x="270" y="230" width="270" height="22" fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.4"/>
  <g font-size="11" fill="currentColor" text-anchor="middle">
    <text x="185" y="246">one branch</text><text x="405" y="246">then all branches</text>
  </g>
  <text x="320" y="270" font-size="10" fill="currentColor" text-anchor="middle">whole system, but in one part of the organisation first</text>
</svg>
<figcaption>Phased splits the system; pilot splits the organisation. That is the difference students most often get wrong.</figcaption>
</figure>

<ul>
<li><strong>Direct, or plunge.</strong> The old system stops and the new one
starts, on one date.
<br><em>Advantages:</em> cheapest, fastest, no duplication of work or data
entry.
<br><em>Disadvantages:</em> highest risk by far. If the new system fails there
is nothing to fall back on. Staff have no time to adjust. Suitable only for a
small, well-tested, non-critical system.</li>
<li><strong>Parallel running.</strong> Both systems run side by side for a
period, and the results are compared.
<br><em>Advantages:</em> safest. The old system is a fallback, and comparing
outputs proves the new one is correct. Staff train on the new system while the
old one still works.
<br><em>Disadvantages:</em> most expensive — everything is done twice, so staff
workload doubles. Comparing results takes effort, and deciding when to stop is
awkward.</li>
<li><strong>Phased, or piecemeal.</strong> The new system is introduced one
module at a time — payroll first, then stock, then sales.
<br><em>Advantages:</em> risk is limited to one module at a time; staff learn
in stages; problems are found in a small area; resources are spread over
time.
<br><em>Disadvantages:</em> takes much longer; the old and new systems must be
made to work together during the changeover, which is technically awkward.
Suitable only where the system divides into separate parts.</li>
<li><strong>Pilot.</strong> The whole new system is used, but by one branch,
department or region first.
<br><em>Advantages:</em> problems are found in a small part of the
organisation; the pilot staff become trainers for everyone else; results in a
real setting before full commitment.
<br><em>Disadvantages:</em> slower than direct; the pilot site carries the
risk; and two systems run in the organisation at once.</li>
</ul>

<h3>Choosing a strategy</h3>
<p>Match it to consequence of failure. A hospital or a bank uses parallel,
because failure is unacceptable. A small shop uses direct, because it can
afford a day of trouble. A national organisation with many branches uses pilot.
A large system built of separable modules uses phased.</p>

<h3>Other implementation activities</h3>
<ul>
<li><strong>File conversion</strong> — moving data from the old system to the
new, cleaned and validated. Usually the most underestimated task in the whole
project.</li>
<li><strong>Staff training</strong>, and installing hardware and software.</li>
<li><strong>User acceptance testing</strong> — the client confirms the system
meets the requirements before sign-off.</li>
</ul>

<h3>Maintenance</h3>
<div class="def-box"><strong>Maintenance:</strong> the work done on a system
after it goes live, to correct faults, adapt it to change, and improve it.</div>
<ul>
<li><strong>Debugging and corrective maintenance</strong> — fixing errors found
in use. Testing never catches everything, because real users do things the test
plan did not imagine.</li>
<li><strong>Adaptive maintenance</strong> — changing the system to suit a
changed environment: a new operating system, a new tax rate, a change in the
law, a new hardware platform.</li>
<li><strong>Perfective maintenance</strong> — improving performance or adding
features that users have asked for. In practice this is the largest share.</li>
<li><strong>Preventive maintenance</strong> — restructuring code and updating
documentation so future changes are easier.</li>
</ul>
<p>Maintenance costs more than development over a system''s life — commonly
quoted at 60 to 80 per cent of total cost. That figure is a good one to
quote.</p>

<h3>In the exam</h3>
<p>Phased against pilot: <strong>phased</strong> introduces part of the
<em>system</em> to everyone; <strong>pilot</strong> introduces the whole
<em>system</em> to part of the organisation. Say that sentence and you will not
lose the mark.</p>', 'html', 61)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  body = EXCLUDED.body, body_format = EXCLUDED.body_format,
  chapter_number = EXCLUDED.chapter_number,
  sequence = EXCLUDED.sequence, updated_at = now();

COMMIT;
