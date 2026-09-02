"""
Lower Sixth ICT lesson notes — Term 3.

Three blocks. Artificial intelligence and simulation, then the system
development life cycle and project management, then the electronic services.

The middle block is the one that carries most marks in the paper and is the one
students find driest, so it is written with the diagrams first: a student who
can draw the waterfall, the V-model and a PERT network from memory can answer
most of what is asked about them.

The e-services block looks easy and is where answers go thin. Every one of
those lessons is written to give named types, named examples, and advantages
and disadvantages from both sides — the provider's and the customer's —
because that is how the question is set.

Same house rules as Terms 1 and 2. Figures are inline SVG.

Source for the content: "Advanced Level Computer Science & ICT", BGS Molyko,
2014.
"""

TERM3 = {

"The role of MIS in planning": """
<div class="def-box"><strong>Management Information System:</strong> a system
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
replace the manager's judgement.</p>
""",

"Introduction to Artificial Intelligence (AI)": """
<div class="def-box"><strong>Artificial intelligence:</strong> the branch of
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
<li><strong>Intelligent agents</strong> — software that acts on a user's behalf
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
matching a fixed pattern."</p>
""",

"Real life application of Artificial Intelligence": """
<p>Five settings on the syllabus. For each: what the system does, and what it
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
household's pattern.</li>
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
scores almost nothing.</p>
""",

"Practical: Web Authoring": """
<p>Web authoring runs across the last weeks of the year. Build one small site
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
<li>A table of the week's timetable.</li>
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
opens last must close first.</p>
""",

"Robotics Application": """
<div class="def-box"><strong>Robot:</strong> a reprogrammable, multifunctional
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
<li><strong>Surgical robots</strong> — the surgeon's hand movements are scaled
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
easily.</p>
""",

"Knowledge-based system (Expert system)": """
<div class="def-box"><strong>Expert system:</strong> a computer program that
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
forget, and it is often the third mark.</p>
""",

"Introduction to Simulation": """
<div class="def-box"><strong>Model:</strong> a simplified representation of a
real system or situation.
<br><strong>Simulation:</strong> running a model over time to study how the
real system would behave under given conditions.</div>
<p>Every model leaves something out. That is not a flaw, it is the definition —
a model that included everything would be the thing itself.</p>

<h3>Applications</h3>
<ul>
<li><strong>Flight simulators</strong> — pilots trained on engine failures and
bad weather without risking an aircraft or anybody's life.</li>
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
the one most candidates leave out.</p>
""",

"Virtual reality (VR) and Augmented Reality (AR)": """
<div class="def-box"><strong>Virtual reality:</strong> a computer-generated
environment that <em>replaces</em> the real world, which the user experiences
as though present in it.
<br><strong>Augmented reality:</strong> computer-generated information
<em>added to</em> the user's view of the real world.</div>
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
one example of each. Write that first, then expand.</p>
""",

"Phases of SDLC": """
<div class="def-box"><strong>System Development Life Cycle:</strong> the series
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
<li><strong>Organisational</strong> — does it fit the organisation's structure,
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
lists.</p>
""",

"System Implementation and Maintenance": """
<h3>Implementation strategies</h3>
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
<p>Maintenance costs more than development over a system's life — commonly
quoted at 60 to 80 per cent of total cost. That figure is a good one to
quote.</p>

<h3>In the exam</h3>
<p>Phased against pilot: <strong>phased</strong> introduces part of the
<em>system</em> to everyone; <strong>pilot</strong> introduces the whole
<em>system</em> to part of the organisation. Say that sentence and you will not
lose the mark.</p>
""",

"SDLC Models": """
<p>The phases are the same. A model is a decision about the <em>order</em> and
the <em>repetition</em>.</p>

<h3>Waterfall model</h3>
<figure class="fig">
<svg viewBox="0 0 620 230" role="img" aria-label="The waterfall model as descending steps from requirements to maintenance">
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="30" y="20" width="130" height="34" rx="5"/>
    <rect x="122" y="60" width="130" height="34" rx="5"/>
    <rect x="214" y="100" width="130" height="34" rx="5"/>
    <rect x="306" y="140" width="130" height="34" rx="5"/>
    <rect x="398" y="180" width="130" height="34" rx="5"/>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="95" y="42">Requirements</text><text x="187" y="82">Design</text>
    <text x="279" y="122">Implementation</text><text x="371" y="162">Testing</text>
    <text x="463" y="202">Maintenance</text>
  </g>
  <g stroke="currentColor" stroke-width="1.4" fill="none" marker-end="url(#ah10)">
    <path d="M122 54 V60"/><path d="M214 94 V100"/><path d="M306 134 V140"/><path d="M398 174 V180"/>
  </g>
  <text x="560" y="42" font-size="11" fill="currentColor" text-anchor="middle">each stage</text>
  <text x="560" y="56" font-size="11" fill="currentColor" text-anchor="middle">completes before</text>
  <text x="560" y="70" font-size="11" fill="currentColor" text-anchor="middle">the next begins</text>
  <defs><marker id="ah10" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>Water does not flow uphill, which is the whole point and the whole problem.</figcaption>
</figure>
<ul>
<li>Each phase must finish before the next starts, and each produces a document
that is signed off.</li>
<li><strong>Advantages:</strong> simple to understand and to manage; clear
milestones and documentation; easy to estimate cost and time; works well when
the requirements are fully known and stable.</li>
<li><strong>Disadvantages:</strong> requirements are almost never fully known
at the start; going back to an earlier stage is expensive; nothing working is
seen until very late; the user is involved at the beginning and then not again
until the end, so a misunderstanding survives the whole project.</li>
</ul>

<h3>V-shape model</h3>
<figure class="fig">
<svg viewBox="0 0 620 240" role="img" aria-label="The V model with development stages descending on the left and matching test stages ascending on the right">
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="30" y="16" width="126" height="30" rx="5"/>
    <rect x="86" y="66" width="126" height="30" rx="5"/>
    <rect x="142" y="116" width="126" height="30" rx="5"/>
    <rect x="238" y="176" width="140" height="34" rx="5"/>
    <rect x="352" y="116" width="126" height="30" rx="5"/>
    <rect x="408" y="66" width="126" height="30" rx="5"/>
    <rect x="464" y="16" width="126" height="30" rx="5"/>
  </g>
  <g fill="currentColor" font-size="11.5" text-anchor="middle">
    <text x="93" y="36">Requirements</text><text x="149" y="86">System design</text>
    <text x="205" y="136">Module design</text><text x="308" y="197">Coding</text>
    <text x="415" y="136">Unit testing</text><text x="471" y="86">Integration testing</text>
    <text x="527" y="36">Acceptance testing</text>
  </g>
  <g stroke="currentColor" stroke-width="1.3" fill="none" stroke-dasharray="4 3">
    <path d="M156 31 H464"/><path d="M212 81 H408"/><path d="M268 131 H352"/>
  </g>
  <g stroke="currentColor" stroke-width="1.4" fill="none">
    <path d="M93 46 L149 66 M149 96 L205 116 M205 146 L268 176"/>
    <path d="M348 176 L415 146 M415 116 L471 96 M471 66 L527 46"/>
  </g>
  <text x="308" y="228" font-size="11" fill="currentColor" text-anchor="middle">each design stage is verified by the test stage opposite it</text>
</svg>
<figcaption>The V model. Every stage on the left has a matching test on the right, planned at the same time.</figcaption>
</figure>
<ul>
<li>The waterfall bent into a V, with testing planned during the corresponding
design stage rather than at the end.</li>
<li><strong>Advantages:</strong> testing is planned early, so defects are found
sooner and more cheaply; each stage has explicit verification; highly
disciplined, which suits safety-critical systems.</li>
<li><strong>Disadvantages:</strong> as rigid as the waterfall; no early
prototype; changing requirements are handled badly; documentation-heavy.</li>
</ul>

<h3>Waterfall against V-shape</h3>
<table>
<tr><th></th><th>Waterfall</th><th>V-shape</th></tr>
<tr><td>Shape</td><td>A descending sequence</td><td>Two arms meeting at coding</td></tr>
<tr><td>Testing</td><td>One phase, near the end</td><td>Planned with each design stage, executed on the way up</td></tr>
<tr><td>Defects found</td><td>Late, so expensive</td><td>Earlier, so cheaper</td></tr>
<tr><td>Verification</td><td>At the end</td><td>At every level</td></tr>
<tr><td>Both</td><td colspan="2">Sequential, rigid, and poor with changing requirements</td></tr>
</table>

<h3>Prototyping model</h3>
<ul>
<li>A working model is built quickly, shown to the user, and refined from their
feedback, repeatedly.</li>
<li>A <strong>throwaway</strong> prototype is discarded once the requirements
are understood; an <strong>evolutionary</strong> prototype is refined into the
final system.</li>
<li><strong>Advantages:</strong> the user sees something real early and can say
what is wrong; misunderstood requirements are caught before they are built into
everything; users are engaged.</li>
<li><strong>Disadvantages:</strong> users may mistake the prototype for a
finished system and expect delivery next week; it encourages skipping analysis
and documentation; the scope can grow without limit; and an evolutionary
prototype often carries a poor internal structure into the final product.</li>
</ul>

<h3>Spiral model</h3>
<ul>
<li>Development goes round a spiral, and each loop has four quadrants:
determine objectives, identify and resolve risks, develop and test, then plan
the next iteration.</li>
<li>Its distinguishing feature is that <strong>risk is assessed explicitly on
every loop</strong>. That is the answer if asked what makes the spiral model
different.</li>
<li><strong>Advantages:</strong> best for large, expensive, high-risk projects;
risks are addressed early; requirements can change between loops; the customer
sees progress at each cycle.</li>
<li><strong>Disadvantages:</strong> complex to manage; needs genuine expertise
in risk assessment; costly; and it can spiral without ever concluding if no one
sets an end.</li>
</ul>

<h3>In the exam</h3>
<p>Choose the model for the situation and justify it. Requirements clear and
fixed, safety critical — waterfall or V. Requirements unclear, user cannot
describe what they want — prototyping. Large, expensive and risky — spiral. The
justification is the mark.</p>
""",

"Project Management": """
<div class="def-box"><strong>Project:</strong> a temporary undertaking with a
defined beginning and end, carried out to create a unique product, service or
result.
<br><strong>Project management:</strong> the application of knowledge, skills,
tools and techniques to project activities in order to meet the project's
requirements.</div>
<p>Two words in the definition of a project do the work: <strong>temporary</strong>
and <strong>unique</strong>. Running the school every day is an operation.
Building the new science block is a project.</p>

<h3>The concepts, defined</h3>
<p>These are pure recall marks. Learn them exactly.</p>
<ul>
<li><strong>Task, or activity</strong> — a piece of work with a duration,
forming part of the project.</li>
<li><strong>Predecessor</strong> — a task that must be completed, or started,
before another task can begin.</li>
<li><strong>Successor</strong> — a task that cannot begin until another is
completed.</li>
<li><strong>Milestone</strong> — a significant point or event in the project,
with <em>zero duration</em>. It marks an achievement; it is not work.</li>
<li><strong>Early start (ES)</strong> — the earliest time a task can begin,
given its predecessors.</li>
<li><strong>Early finish (EF)</strong> — early start plus duration.</li>
<li><strong>Late finish (LF)</strong> — the latest a task can finish without
delaying the project.</li>
<li><strong>Late start (LS)</strong> — late finish minus duration.</li>
<li><strong>Slack, or float</strong> — how long a task can be delayed without
delaying the project. Slack = LS − ES = LF − EF.</li>
<li><strong>Critical task</strong> — a task with zero slack. Delay it by one
day and the project is one day late.</li>
<li><strong>Critical path</strong> — the sequence of critical tasks running
through the project. It is the <em>longest</em> path through the network, and
its length is the shortest possible project duration. Both halves of that
sentence matter.</li>
<li><strong>Lag</strong> — a deliberate delay between two tasks. Pour the
concrete, then wait three days before building on it.</li>
<li><strong>Lead</strong> — the opposite: a successor allowed to start before
its predecessor finishes, so the two overlap.</li>
</ul>

<h3>Why manage a project at all</h3>
<ul>
<li>To finish on time, within budget, and to the agreed quality.</li>
<li>To allocate people and equipment where they are needed, and to see clashes
before they happen.</li>
<li>To identify risks early and plan for them.</li>
<li>To know, at any moment, whether the project is ahead or behind, and by how
much.</li>
<li>To keep everyone working towards the same goal, and to communicate progress
honestly to the client.</li>
</ul>

<h3>In the exam</h3>
<p>The definition of the critical path is worth two marks and most candidates
give one. Say: the longest path through the network, made of tasks with zero
slack, whose length determines the minimum project duration.</p>
""",

"Project constraints and Role of project management team": """
<h3>The triple constraint</h3>
<figure class="fig">
<svg viewBox="0 0 620 230" role="img" aria-label="The project management triangle of scope, time and cost with quality at the centre">
  <path d="M310 26 L520 196 L100 196 Z" fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.8"/>
  <g fill="currentColor" font-size="14" font-weight="600" text-anchor="middle">
    <text x="310" y="18">SCOPE</text>
    <text x="76" y="214">TIME</text>
    <text x="544" y="214">COST</text>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="310" y="130">QUALITY</text>
    <text x="310" y="148">sits inside; change any</text>
    <text x="310" y="162">side and it moves</text>
    <text x="180" y="98">how long</text>
    <text x="440" y="98">how much</text>
  </g>
</svg>
<figcaption>Change one side and at least one other must change with it. That is the whole of project negotiation.</figcaption>
</figure>

<ul>
<li><strong>Scope</strong> — what the project will deliver: the features, the
work, the boundaries. Uncontrolled additions to scope are called
<strong>scope creep</strong>, and it is the commonest cause of overrun.</li>
<li><strong>Time</strong> — the schedule and the deadline. Fixed deadlines are
common and often external: an academic year, a rainy season, a launch
date.</li>
<li><strong>Cost</strong> — the budget: staff, equipment, software, training,
contingency.</li>
<li><strong>Quality</strong> sits in the middle. It is affected by all three,
which is why it suffers first when the other three are squeezed.</li>
</ul>
<p>The rule to state: you cannot change one without affecting the others. Add
features without more time or money and quality falls. Cut the deadline without
cutting scope and you must add cost, or accept lower quality. Adding people to
a late project often makes it later, because they must be trained by the people
already working.</p>

<h3>The project management team</h3>
<ul>
<li><strong>Project sponsor</strong> — usually a senior manager. Provides the
funding and the authority, approves the business case, and resolves issues that
the manager cannot. Owns the project's success at organisation level.</li>
<li><strong>Project manager</strong> — plans, schedules, assigns work, tracks
progress, manages risk, budget and scope, and communicates with everyone.
Responsible for delivery. The single point of accountability.</li>
<li><strong>Systems analyst</strong> — investigates the current system,
gathers and documents requirements, designs the new system, and acts as the
bridge between the users and the developers.</li>
<li><strong>Designer / architect</strong> — turns requirements into a technical
design: structure, data, interfaces.</li>
<li><strong>Programmers / developers</strong> — write and unit-test the code
from the design.</li>
<li><strong>Testers / quality assurance</strong> — write the test plans, run
the tests, report defects, and verify fixes. Kept separate from the developers,
because people do not find their own mistakes.</li>
<li><strong>Database administrator</strong> — designs, builds, secures, tunes
and backs up the database.</li>
<li><strong>Network / systems administrator</strong> — provides and maintains
the infrastructure the system runs on.</li>
<li><strong>Technical writer</strong> — produces the user and technical
documentation.</li>
<li><strong>Trainer</strong> — prepares materials and trains the users before
go-live.</li>
<li><strong>End users</strong> — supply the requirements, review the design,
and carry out acceptance testing. They are part of the team, not an audience
for it.</li>
<li><strong>Steering committee</strong> — senior representatives who approve
major changes and monitor progress at intervals.</li>
</ul>

<h3>In the exam</h3>
<p>Given a scenario — "the client asks for three extra features two weeks
before the deadline" — answer with the triangle. Either the deadline moves, or
the budget rises, or something else is dropped from scope; and if none of those
is permitted, quality will fall. Naming the constraint that must give is the
answer.</p>
""",

"Project management phases": """
<p>Five phases. They are not the SDLC — the SDLC builds the system, these
manage the work of building it.</p>

<h3>1. Initiation</h3>
<ul>
<li>Identify the need or the problem, and define the project at a high
level.</li>
<li>Produce a business case, with expected costs and benefits.</li>
<li>Carry out a feasibility study.</li>
<li>Identify the stakeholders — everyone affected by or interested in the
project.</li>
<li>Appoint the project manager and obtain authority to proceed.</li>
<li>Output: a project charter, defining objectives, scope and authority.</li>
</ul>

<h3>2. Planning</h3>
<ul>
<li>Define the scope in detail, and state what is <em>not</em> included. That
sentence prevents most later arguments.</li>
<li>Break the work down into tasks — a work breakdown structure.</li>
<li>Estimate the duration and resources for each task, and establish
dependencies.</li>
<li>Build the schedule: Gantt chart, network diagram, critical path.</li>
<li>Prepare the budget, and plan for quality, communication, procurement and
risk.</li>
<li>Identify risks, assess likelihood and impact, and decide the response for
each.</li>
<li>Output: the project plan, which everything afterwards is measured
against.</li>
</ul>

<h3>3. Execution</h3>
<ul>
<li>Assemble and lead the team; assign the tasks.</li>
<li>Carry out the work in the plan, and produce the deliverables.</li>
<li>Manage the team: motivation, training, resolving conflicts.</li>
<li>Manage suppliers and contracts, and keep stakeholders informed.</li>
<li>Assure quality as work proceeds, not after it.</li>
<li>This is where most of the budget and most of the time is spent.</li>
</ul>

<h3>4. Control and monitoring</h3>
<p>Runs alongside execution, not after it.</p>
<ul>
<li>Measure actual progress against the plan: time, cost, scope, quality.</li>
<li>Identify variances and their causes.</li>
<li>Take corrective action — reassign resources, re-sequence work, renegotiate
scope.</li>
<li>Manage change requests formally, assessing the effect of each on time, cost
and scope before approving it.</li>
<li>Monitor risks, and update the register as new ones appear.</li>
<li>Update the schedule and re-baseline where the change is agreed.</li>
</ul>

<h3>5. Closure and reporting</h3>
<ul>
<li>Complete the final deliverables and obtain formal client acceptance.</li>
<li>Hand over the system, the documentation and the support arrangements.</li>
<li>Release the team and close contracts and accounts.</li>
<li>Hold a review: what went well, what did not, and what should be done
differently. Record the lessons learned, because the next project inherits
them.</li>
<li>Produce the final report, comparing planned against actual for time, cost
and scope.</li>
</ul>

<h3>Reporting throughout</h3>
<ul>
<li><strong>Status reports</strong> — regular, showing progress against plan,
work completed, work planned next, issues and risks.</li>
<li><strong>Exception reports</strong> — raised when something goes outside an
agreed tolerance, so managers read about what has gone wrong rather than about
everything.</li>
<li><strong>Milestone reports</strong> at each significant point.</li>
</ul>

<h3>In the exam</h3>
<p>Control and monitoring runs <em>parallel</em> to execution. Candidates who
draw the five phases as a straight line with control after execution lose a
mark. Draw it as an arrow running alongside.</p>
""",

"Project control and scheduling methods": """
<h3>Network diagrams and critical path analysis</h3>
<p>A network diagram shows tasks, their durations, and which must precede
which. From it you find the shortest possible project duration and the tasks
that cannot slip.</p>

<figure class="fig">
<svg viewBox="0 0 660 260" role="img" aria-label="A network diagram with tasks A to F showing the critical path">
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <circle cx="60" cy="130" r="24"/><circle cx="200" cy="70" r="24"/>
    <circle cx="200" cy="190" r="24"/><circle cx="360" cy="130" r="24"/>
    <circle cx="510" cy="130" r="24"/><circle cx="620" cy="130" r="24"/>
  </g>
  <g fill="currentColor" font-size="13" text-anchor="middle" font-weight="600">
    <text x="60" y="135">1</text><text x="200" y="75">2</text><text x="200" y="195">3</text>
    <text x="360" y="135">4</text><text x="510" y="135">5</text><text x="620" y="135">6</text>
  </g>
  <g stroke="currentColor" stroke-width="1.4" fill="none" marker-end="url(#ah11)">
    <path d="M82 120 L176 80"/>
    <path d="M224 84 L338 120"/>
    <path d="M384 130 H484"/>
    <path d="M534 130 H594"/>
  </g>
  <g stroke="currentColor" stroke-width="1.4" fill="none" marker-end="url(#ah11)" stroke-dasharray="5 4">
    <path d="M78 148 L177 182"/>
    <path d="M223 180 L340 145"/>
  </g>
  <g fill="currentColor" font-size="11.5" text-anchor="middle">
    <text x="120" y="88">A, 4</text><text x="285" y="86">B, 6</text>
    <text x="120" y="184">C, 3</text><text x="285" y="184">D, 4</text>
    <text x="434" y="120">E, 5</text><text x="566" y="120">F, 2</text>
  </g>
  <text x="330" y="236" font-size="12" fill="currentColor" text-anchor="middle">Critical path 1-2-4-5-6 (A,B,E,F) = 4+6+5+2 = 17 days</text>
  <text x="330" y="252" font-size="11" fill="currentColor" text-anchor="middle">Path through C and D takes 3+4=7 against 10, so C and D have 3 days of float</text>
  <defs><marker id="ah11" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>The critical path is the longest route through the network. Everything off it has float.</figcaption>
</figure>

<h3>How to work it out</h3>
<ol>
<li><strong>Forward pass</strong>, left to right. Early start of the first task
is 0. Early finish = early start + duration. A task's early start is the
<em>latest</em> early finish of all its predecessors, because it cannot begin
until all of them are done.</li>
<li><strong>Backward pass</strong>, right to left. Late finish of the last task
equals its early finish. Late start = late finish − duration. A task's late
finish is the <em>earliest</em> late start of its successors.</li>
<li><strong>Float</strong> = late start − early start. Any task with zero float
is critical.</li>
<li>The chain of zero-float tasks from start to finish is the critical
path.</li>
</ol>
<p><strong>Free float</strong> is how long a task can be delayed without
delaying any successor. <strong>Total float</strong> is how long it can be
delayed without delaying the project. Total float is the larger; free float is
what you can use without upsetting anyone downstream.</p>

<h3>PERT</h3>
<p>Program Evaluation and Review Technique. It is a network method for
projects where durations are uncertain, so each task gets three estimates:</p>
<ul>
<li><strong>Optimistic (O)</strong>, <strong>most likely (M)</strong>,
<strong>pessimistic (P)</strong>.</li>
<li>Expected time = (O + 4M + P) ÷ 6.</li>
<li>Example: O = 4, M = 6, P = 14. Expected = (4 + 24 + 14) ÷ 6 = 7 days.</li>
</ul>
<p>PERT is event-oriented and probabilistic; it was developed for research and
development work where nobody has done the task before.</p>

<h3>CPM</h3>
<p>Critical Path Method. The same network analysis, but with a single
<em>deterministic</em> duration for each task, used where the work is familiar
and durations are known — construction, maintenance. CPM also handles
<strong>crashing</strong>: shortening a critical task by adding resources, and
weighing the extra cost against the days saved.</p>

<h3>PERT against CPM</h3>
<table>
<tr><th></th><th>PERT</th><th>CPM</th></tr>
<tr><td>Time estimates</td><td>Three, probabilistic</td><td>One, deterministic</td></tr>
<tr><td>Focus</td><td>Time</td><td>Time and cost trade-off</td></tr>
<tr><td>Suits</td><td>Research, new and uncertain work</td><td>Repetitive, well-understood work</td></tr>
<tr><td>Oriented around</td><td>Events</td><td>Activities</td></tr>
</table>
<ul>
<li><strong>Advantages of both:</strong> they show dependencies clearly, find
the critical path, identify float, and support "what if" analysis.</li>
<li><strong>Disadvantages:</strong> both depend entirely on the accuracy of the
estimates; both become hard to read on a large project; neither shows resource
levels; and PERT's formula gives a comforting precision that the underlying
guesses do not justify.</li>
</ul>

<h3>Gantt chart</h3>
<figure class="fig">
<svg viewBox="0 0 660 230" role="img" aria-label="A Gantt chart with six tasks drawn as horizontal bars against a time axis">
  <g font-size="12" fill="currentColor">
    <text x="16" y="46">A</text><text x="16" y="74">B</text><text x="16" y="102">C</text>
    <text x="16" y="130">D</text><text x="16" y="158">E</text><text x="16" y="186">F</text>
  </g>
  <g stroke="currentColor" stroke-width="0.5" opacity="0.4">
    <path d="M60 26 V196 M130 26 V196 M200 26 V196 M270 26 V196 M340 26 V196 M410 26 V196 M480 26 V196 M550 26 V196 M620 26 V196"/>
  </g>
  <g font-size="10" fill="currentColor" text-anchor="middle">
    <text x="60" y="20">0</text><text x="130" y="20">2</text><text x="200" y="20">4</text>
    <text x="270" y="20">6</text><text x="340" y="20">8</text><text x="410" y="20">10</text>
    <text x="480" y="20">12</text><text x="550" y="20">14</text><text x="620" y="20">16</text>
  </g>
  <g stroke="var(--cyan)" stroke-width="1.4" fill="var(--cyan-soft)">
    <rect x="60" y="36" width="140" height="16" rx="3"/>
    <rect x="200" y="64" width="210" height="16" rx="3"/>
    <rect x="60" y="92" width="105" height="16" rx="3"/>
    <rect x="165" y="120" width="140" height="16" rx="3"/>
    <rect x="410" y="148" width="175" height="16" rx="3"/>
    <rect x="585" y="176" width="70" height="16" rx="3"/>
  </g>
  <text x="330" y="216" font-size="11" fill="currentColor" text-anchor="middle">the length of each bar is the task's duration; position shows when it happens</text>
</svg>
<figcaption>A Gantt chart. Easy to read at a glance, which is why managers prefer it — but the dependencies are not visible in it.</figcaption>
</figure>
<ul>
<li>A horizontal bar chart: tasks down the side, time across the top, each bar
positioned and sized by when the task runs and how long it takes.</li>
<li><strong>Advantages:</strong> immediately understandable, even by people
outside the project; shows progress against plan if actual bars are drawn
beneath planned ones; shows overlap and resource loading clearly.</li>
<li><strong>Disadvantages:</strong> dependencies are not shown, or shown
awkwardly with arrows; the critical path is not visible; it becomes unwieldy on
a large project; and it must be redrawn whenever the schedule changes.</li>
</ul>

<h3>Gantt against PERT</h3>
<table>
<tr><th></th><th>Gantt chart</th><th>PERT / network diagram</th></tr>
<tr><td>Form</td><td>Horizontal bars on a timescale</td><td>Nodes and arrows</td></tr>
<tr><td>Shows duration</td><td>Yes, by bar length</td><td>Yes, as a figure on the task</td></tr>
<tr><td>Shows dependencies</td><td>Poorly</td><td>Clearly — that is its purpose</td></tr>
<tr><td>Shows critical path</td><td>No</td><td>Yes</td></tr>
<tr><td>To scale in time</td><td>Yes</td><td>No</td></tr>
<tr><td>Best for</td><td>Communicating and tracking progress</td><td>Analysing the schedule and finding float</td></tr>
</table>
<p>In practice both are used: the network to work out the schedule, the Gantt
chart to show it to everyone else.</p>

<h3>In the exam</h3>
<p>You will be given a table of tasks, durations and predecessors, and asked to
draw the network, state the critical path, give the project duration and
calculate the float on one task. Do it in that order, show the forward and
backward pass figures on the diagram, and state the critical path as a list of
task letters and the duration as a number with units.</p>
""",
"E-commerce": """
<div class="def-box"><strong>E-commerce:</strong> the buying and selling of
goods and services, and the transfer of funds, carried out over an electronic
network, principally the internet.</div>

<h3>The forms</h3>
<figure class="fig">
<svg viewBox="0 0 660 180" role="img" aria-label="Forms of e-commerce: business to consumer, business to business, consumer to consumer and business to government">
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.5">
    <rect x="30" y="40" width="120" height="44" rx="6"/>
    <rect x="270" y="40" width="120" height="44" rx="6"/>
    <rect x="510" y="40" width="120" height="44" rx="6"/>
    <rect x="150" y="112" width="120" height="42" rx="6"/>
    <rect x="390" y="112" width="120" height="42" rx="6"/>
  </g>
  <g fill="currentColor" font-size="12.5" text-anchor="middle">
    <text x="90" y="67">Business</text><text x="330" y="67">Business</text><text x="570" y="67">Consumer</text>
    <text x="210" y="138">Government</text><text x="450" y="138">Consumer</text>
  </g>
  <g stroke="currentColor" stroke-width="1.5" fill="none" marker-end="url(#ah12)">
    <path d="M150 54 H264"/><path d="M390 54 H504"/>
    <path d="M510 84 Q470 100 462 108"/><path d="M280 40 Q250 20 214 108" stroke-dasharray="0"/>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="207" y="42">B2B</text><text x="447" y="42">B2C</text>
    <text x="516" y="112">C2C</text><text x="238" y="30">B2G</text>
  </g>
  <defs><marker id="ah12" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>Who is selling to whom. The two on the syllabus are B2C and B2B.</figcaption>
</figure>

<ul>
<li><strong>B2C — business to consumer.</strong> A business sells directly to
the public. An online shop, an airline selling tickets, a streaming
subscription. Many small transactions, standard prices shown openly, the site
must be simple enough for anyone.</li>
<li><strong>B2B — business to business.</strong> One business sells to another:
a wholesaler to a retailer, a manufacturer to a distributor. Fewer, larger
transactions; negotiated prices and credit terms; the systems are often
integrated so orders pass between them automatically.</li>
<li><strong>C2C — consumer to consumer.</strong> Individuals trading through a
platform that provides the marketplace and takes a fee.</li>
<li><strong>B2G — business to government.</strong> Tendering and supply to
public bodies.</li>
</ul>

<h3>Medium of purchase</h3>
<ul>
<li>A website with a catalogue, search, a shopping cart and a checkout.</li>
<li>A mobile application — how most purchases are now made in Cameroon.</li>
<li>Online marketplaces that host many sellers.</li>
<li>Social media selling, and ordering by messaging.</li>
</ul>

<h3>Fund transfer</h3>
<ul>
<li><strong>Mobile money</strong> — MTN Mobile Money and Orange Money. The
dominant method here, because it needs no bank account and no card.</li>
<li><strong>Debit and credit cards</strong>, processed through a payment
gateway.</li>
<li><strong>Bank transfer</strong>, and electronic funds transfer between
accounts.</li>
<li><strong>Digital wallets</strong>, holding a balance or card details.</li>
<li><strong>Cash on delivery</strong> — still widely used, and the reason is
trust: the buyer pays only when the goods arrive.</li>
</ul>
<p>Security in payment: HTTPS with SSL/TLS encryption on the connection, a
payment gateway so the merchant never holds the card number, and
authentication such as a one-time code.</p>

<h3>Advantages</h3>
<ul>
<li><strong>To the customer:</strong> open all hours, from anywhere; prices
easily compared; a far wider choice than any local shop; no travel; reviews
from other buyers; delivery to the door.</li>
<li><strong>To the business:</strong> no shop premises or shop staff, so lower
costs; a national or global market from one location; automatic stock and sales
records; data about customer behaviour; easy price and catalogue changes.</li>
</ul>

<h3>Disadvantages</h3>
<ul>
<li><strong>To the customer:</strong> the goods cannot be examined before
buying; delivery takes time and costs money; returns are awkward; risk of fraud
and of sites that do not deliver; personal and payment data must be trusted to
the seller; no personal advice.</li>
<li><strong>To the business:</strong> needs reliable internet, power and
delivery logistics; competition from everyone; the cost of building and
securing the site; charge-backs and fraud; and customers who compare on price
alone.</li>
<li><strong>Wider:</strong> local shops close, with the jobs in them; and
people without internet access or a payment method are excluded.</li>
</ul>

<h3>In the exam</h3>
<p>When asked for advantages, say whose. "An advantage to the seller is a
market beyond the local town; an advantage to the buyer is the ability to
compare prices in minutes." Separating the two parties is what turns a list
into an answer.</p>
""",

"E-banking": """
<div class="def-box"><strong>E-banking:</strong> the delivery of banking
services and transactions through electronic channels, without the customer
visiting a branch or dealing with a clerk.</div>

<h3>E-banking activities</h3>
<ul>
<li>Checking balances and viewing statements.</li>
<li>Transferring funds between accounts, and to other people.</li>
<li>Paying bills — electricity, water, school fees, subscriptions.</li>
<li>Buying airtime and data.</li>
<li>Setting up standing orders and direct debits.</li>
<li>Applying for loans and cards, and checking their status.</li>
<li>Cheque book requests, card blocking, and changing personal details.</li>
</ul>

<h3>The three types on the syllabus</h3>

<h4>ATM — automated teller machine</h4>
<p>A machine that dispenses cash and performs basic transactions. The customer
inserts a card and enters a PIN; on successful entry the transaction may
proceed.</p>
<ul>
<li><strong>Usefulness:</strong> cash available 24 hours, including weekends
and holidays; no queue at a counter; machines in many locations, not just at
branches; balance enquiries and mini-statements; it works when the branch is
closed.</li>
<li><strong>Limits:</strong> withdrawal limits; the machine can be empty or out
of service; card skimming and shoulder-surfing; no help with anything
unusual.</li>
</ul>

<h4>POS — point of sale</h4>
<p>A terminal in a shop that reads the customer's card and transfers the money
from their account to the merchant's at the moment of sale. This is EFTPOS —
electronic funds transfer at the point of sale.</p>
<ul>
<li><strong>Usefulness:</strong> the customer need not carry cash; the transfer
is immediate and recorded; the merchant handles less cash, so there is less to
steal and less to bank; the sale can update the stock system at the same
time.</li>
<li><strong>Limits:</strong> it needs a network connection; merchants pay a
transaction fee; and it depends on the customer holding a card.</li>
</ul>

<h4>Internet banking</h4>
<p>Full account access through a website or mobile application.</p>
<ul>
<li><strong>Usefulness:</strong> the widest range of services, from anywhere,
at any hour; statements downloadable; transfers to anyone; no travel to a
branch at all.</li>
<li><strong>Limits:</strong> needs internet access and a device; phishing and
malware target it directly; and cash still cannot come out of a screen.</li>
</ul>

<h3>Advantages to the customer</h3>
<ul>
<li>Available at any hour, from any place, with no travel and no queue.</li>
<li>Transactions are immediate, and every one is recorded.</li>
<li>Balances and history are always visible, which makes budgeting easier.</li>
<li>Lower charges than counter service, generally.</li>
<li>Safer than carrying cash.</li>
</ul>

<h3>Disadvantages to the customer</h3>
<ul>
<li>Depends on power, network and a working device.</li>
<li>Vulnerable to phishing, card cloning and account takeover.</li>
<li>Excludes those without internet access, a card, or the confidence to use
them — which in practice means the elderly and the rural poor.</li>
<li>No person to explain a problem, and disputes are harder to resolve
remotely.</li>
<li>Errors — a wrong account number — are hard to reverse.</li>
</ul>

<h3>Advantages to the bank</h3>
<ul>
<li>Far lower cost per transaction than a counter.</li>
<li>Fewer branches and fewer tellers needed.</li>
<li>Customers reached without opening premises in every town.</li>
<li>Transaction data supports marketing and credit decisions.</li>
<li>Fewer errors than manual processing.</li>
</ul>

<h3>Disadvantages to the bank</h3>
<ul>
<li>Large investment in systems, security and maintenance.</li>
<li>Constant exposure to fraud and to attack, and liability when it
succeeds.</li>
<li>Reputational damage from any outage or breach.</li>
<li>Less personal contact, so it is harder to sell other services and easier
for customers to leave.</li>
<li>Job losses among counter staff, and the industrial relations that
follow.</li>
</ul>

<h3>In the exam</h3>
<p>The question almost always says "to the bank and to the customer". Write two
short lists under two headings. And note the recurring point: every advantage
of automation to the bank has a matching cost — usually in security, or in
jobs.</p>
""",

"E-Health": """
<div class="def-box"><strong>E-health:</strong> the use of information and
communication technology to deliver, support and manage health care and health
information.</div>

<h3>Applications</h3>

<h4>Medical information systems</h4>
<p>Hospital systems handling admissions, appointments, bed allocation,
pharmacy stock, laboratory results and billing. They coordinate a hospital in
the way an MIS coordinates a business.</p>
<ul>
<li><em>Advantages:</em> less waiting, fewer lost files, stock and staff
planned from real figures, and billing that matches what was actually
done.</li>
<li><em>Disadvantages:</em> expensive; the whole hospital stops when the system
does; and staff must be trained on top of clinical work.</li>
</ul>

<h4>Electronic medical records</h4>
<p>The patient's complete history held electronically: diagnoses, prescriptions,
allergies, test results, images.</p>
<ul>
<li><em>Advantages:</em> available instantly wherever the patient is treated;
legible, unlike handwriting; cannot be lost or eaten by damp; automatic warnings
about drug interactions and allergies; the whole history visible at once;
searchable for research and for public health.</li>
<li><em>Disadvantages:</em> the most sensitive data there is, so a breach is
serious; needs power, network and backup; costly to introduce; and entering
data takes clinical time away from the patient.</li>
</ul>

<h4>Telemedicine</h4>
<p>Diagnosis, consultation and monitoring at a distance, by video, messaging or
transmitted images and readings.</p>
<ul>
<li><em>Advantages:</em> a specialist opinion reaches a rural health centre
that has none; no long journey for a patient who is ill; a scarce specialist is
shared across many centres; cheaper follow-up appointments; reduced infection
risk from waiting rooms.</li>
<li><em>Disadvantages:</em> no physical examination is possible; it depends on
reliable connectivity and power, which is precisely what rural areas lack; the
personal relationship suffers; the technology excludes those who cannot use it;
and questions of liability across borders are unsettled.</li>
</ul>

<h4>Other e-health technologies</h4>
<ul>
<li><strong>Remote patient monitoring</strong> — wearable or home devices
sending readings automatically, so a change is noticed before it becomes an
emergency.</li>
<li><strong>Health information websites and helplines</strong> — public
education, and the counterweight: misinformation and self-diagnosis.</li>
<li><strong>E-prescribing</strong> — prescriptions sent electronically to the
pharmacy, removing handwriting errors.</li>
<li><strong>Disease surveillance</strong> — reported cases mapped and analysed,
so an outbreak is detected early. This matters in a country where an epidemic
can move faster than paper reporting.</li>
<li><strong>Medical imaging systems</strong> — scans stored and transmitted
digitally, viewable by a specialist anywhere.</li>
</ul>

<h3>The role of e-health</h3>
<ul>
<li>Extends the reach of scarce medical expertise.</li>
<li>Improves the quality and safety of care through complete records and
automatic checks.</li>
<li>Reduces cost and duplication — a test is not repeated because the result
was lost.</li>
<li>Supports planning and research with data that was previously unreachable in
paper files.</li>
<li>Gives patients access to their own health information.</li>
</ul>

<h3>Concerns</h3>
<ul>
<li>Privacy and confidentiality above everything else.</li>
<li>Reliability: a system failure in a hospital is a safety issue, not an
inconvenience.</li>
<li>Cost, and the risk of widening the gap between well-resourced urban
hospitals and rural centres.</li>
<li>Over-reliance on technology instead of clinical judgement.</li>
</ul>

<h3>In the exam</h3>
<p>Telemedicine questions want the local reality: a village with no doctor
gains access to one, but only if there is a network and power to carry the
consultation. Saying both halves is what makes the answer strong.</p>
""",

"Computer Assisted Learning (CAL)": """
<div class="def-box"><strong>Computer Assisted Learning:</strong> the use of
computers to deliver instruction and support learning, with the computer
presenting material, setting exercises and giving feedback.</div>
<p>Related terms sometimes wanted: <strong>CAI</strong>, computer assisted
instruction, and <strong>CBT</strong>, computer based training. Treat them as
the same idea unless a question separates them.</p>

<h3>Methods of course delivery</h3>
<ul>
<li><strong>Servers and networks</strong> — a learning management system on a
school or institutional server. Students log in, read materials, submit work
and take tests; teachers track progress. Content is updated in one place for
everyone. Requires a network, and access is limited to where it reaches.</li>
<li><strong>CD-ROM and DVD</strong> — the course on a disc. Needs no network at
all, which is why it still matters where connectivity is poor. It can carry
video and audio. But it cannot be updated, and it does not report progress to
anyone.</li>
<li><strong>Didactic resources and e-books</strong> — electronic textbooks and
reference material, searchable, carried in quantity on one device, often with
audio and embedded links. Cheaper than printing and instantly distributed. Needs
a device and a charged battery.</li>
<li><strong>Online and web-based delivery</strong> — courses over the internet,
including video lessons and virtual classrooms. The widest reach and the most
demanding on connectivity.</li>
<li><strong>Mobile learning</strong> — delivery to phones, which in Cameroon
reaches more students than any other device.</li>
</ul>

<h3>Advantages</h3>
<ul>
<li><strong>Self-paced.</strong> A slower student repeats a section without
embarrassment; a faster one moves ahead without waiting.</li>
<li><strong>Immediate feedback</strong> on exercises, while the attempt is
still fresh, rather than a week later.</li>
<li><strong>Consistent quality.</strong> Every student gets the same material,
regardless of which teacher or which school.</li>
<li><strong>Available at any time and place</strong>, which suits students who
work, and reaches those far from a school.</li>
<li><strong>Multimedia</strong> makes abstract material visible — animation of
a machine cycle, a simulated experiment.</li>
<li><strong>Simulations</strong> allow dangerous or expensive practicals that a
school could not otherwise offer.</li>
<li><strong>Patient and non-judgemental.</strong> It will repeat something
twenty times.</li>
<li><strong>Progress tracking</strong> shows the teacher exactly where a class
is weak.</li>
<li>Cheaper per student once developed, and it scales to any number.</li>
</ul>

<h3>Limitations</h3>
<ul>
<li>Requires computers, power and often internet — the largest obstacle
here.</li>
<li>High cost to develop good material; poor material is worse than a
textbook.</li>
<li>No human interaction, and no teacher noticing that a student is struggling
for reasons unrelated to the subject.</li>
<li>Cannot answer an unexpected question, or explain the same thing a different
way when the first explanation fails.</li>
<li>Demands self-discipline; without it students do not finish.</li>
<li>Poor for practical skills that need physical apparatus, and for discussion
and debate.</li>
<li>Technical faults interrupt learning, and both students and teachers need
training.</li>
<li>Health issues from long screen use.</li>
</ul>

<h3>The honest conclusion</h3>
<p>CAL supplements a teacher; it does not replace one. Say this if asked to
evaluate: the strongest results come from blended learning, where CAL handles
drill, revision and simulation, and the teacher handles explanation,
motivation and the questions the software cannot anticipate.</p>

<h3>In the exam</h3>
<p>Tie the limitations to the local setting. "CAL requires a reliable power
supply and internet connection, which many schools do not have, so CD-based
delivery may be more practical." That answer earns more than a general list.</p>
""",

"E-government": """
<div class="def-box"><strong>E-government:</strong> the use of information and
communication technology by government to deliver services, share information
and interact with citizens, businesses and other arms of government.</div>

<h3>The forms</h3>

<h4>E-governance</h4>
<p>The wider idea: using ICT to change how government itself works — how
decisions are made, how citizens participate, and how government is held
accountable. E-government is about delivering services; e-governance is about
the process of governing.</p>
<ul>
<li>Publishing budgets, laws, contracts and performance data.</li>
<li>Online consultation on proposed policies.</li>
<li>Citizen feedback and complaint channels.</li>
<li>Digital record keeping that can be audited.</li>
</ul>

<h4>E-taxation</h4>
<p>Registration, filing of returns, assessment and payment of tax
electronically.</p>
<ul>
<li><em>To the citizen or business:</em> file from the office at any hour, no
queue, calculations checked automatically, and a receipt that cannot be
lost.</li>
<li><em>To government:</em> lower processing cost, fewer errors, faster
collection, a complete audit trail, and fewer opportunities for a payment to be
diverted between the payer and the treasury.</li>
</ul>

<h4>E-voting</h4>
<p>Casting and counting votes electronically, either on machines at polling
stations or remotely.</p>
<ul>
<li><em>Advantages:</em> counting is fast and arithmetic errors disappear;
results come within hours; spoilt ballots can be prevented by the interface;
voters with disabilities can vote unaided; remote voting could raise
turnout.</li>
<li><em>Disadvantages, and they are serious:</em> the system must be trusted by
people who cannot inspect it; a software fault or an attack could change an
outcome invisibly; there may be no paper record to recount; secrecy and
verifiability pull against each other; and citizens without access or skills
are disadvantaged. This is why many countries that tried it went back to
paper.</li>
</ul>

<h3>Other services</h3>
<ul>
<li>Birth, death and marriage certificates; national identity cards.</li>
<li>Business registration and licensing.</li>
<li>Land registry and title searches.</li>
<li>Driving licences and vehicle registration.</li>
<li>Applications to public schools and universities, and publication of
results.</li>
<li>Health and social service applications.</li>
<li>Public procurement and tendering.</li>
</ul>

<h3>Implications for government</h3>
<ul>
<li>Lower cost per transaction and fewer offices and staff needed.</li>
<li>Faster processing and less duplication between departments.</li>
<li>Better data for planning, and a record of every transaction.</li>
<li>Reduced corruption, because there are fewer face-to-face points where money
can change hands informally, and because the trail is recorded.</li>
<li>But: heavy investment in systems, connectivity and training; the need for
serious security, since government data is a target; resistance from staff who
benefited from the old arrangements; and a legal framework — for electronic
signatures and data protection — that must exist first.</li>
</ul>

<h3>Implications for citizens</h3>
<ul>
<li>Services available at any hour without travelling to the capital.</li>
<li>No queuing, and no repeated visits to be told the officer is absent.</li>
<li>Transparent status: you can see where your application is.</li>
<li>Predictable, published fees, which is itself an anti-corruption
measure.</li>
<li>But: it requires internet access, a device and literacy, so the digital
divide decides who benefits; personal data is concentrated in one place; and
those who cannot use the online route must not be left without any route at
all.</li>
</ul>

<h3>Barriers to e-government in a developing country</h3>
<ul>
<li>Limited and unreliable internet and electricity outside the towns.</li>
<li>Low digital literacy, and the cost of devices and data.</li>
<li>The cost of the systems themselves.</li>
<li>Missing legal framework for electronic transactions and records.</li>
<li>Resistance to change within the administration.</li>
<li>Language: services offered only in one language exclude those who do not
read it.</li>
</ul>

<h3>In the exam</h3>
<p>Distinguish e-government from e-governance in one sentence — service
delivery against the process of governing — and always give both the benefit
and the barrier. An answer that lists only benefits reads as a brochure, and is
marked as one.</p>
""",
}
