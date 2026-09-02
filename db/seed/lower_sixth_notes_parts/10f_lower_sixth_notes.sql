-- Part F of 7 — notes 5 of 5: SDLC Models → E-government.
-- Run the parts in alphabetical order, one at a time.
-- Safe to run again if you lose your place.

BEGIN;

-- 10 notes
INSERT INTO note_sections
  (id, note_source_id, chapter_number, title, body, body_format, sequence)
VALUES
  ('50ad2b62-9edc-5885-9839-a0c3546e87eb', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'SDLC Models', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Describe waterfall, V-shape, prototyping, spiral models</li><li>Waterfall versus V-shape model</li></ul></div><p>The phases are the same. A model is a decision about the <em>order</em> and
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
justification is the mark.</p>', 'html', 62),
  ('fd05e114-3b28-5893-9e88-36956942df86', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Project Management', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Define a project and project management</li><li>Explain project management concepts: task, predecessor, successor, slack task/time, lag, lead, milestone, critical path/task, early finish, late finish, early start, late start</li></ul></div><div class="def-box"><strong>Project:</strong> a temporary undertaking with a
defined beginning and end, carried out to create a unique product, service or
result.
<br><strong>Project management:</strong> the application of knowledge, skills,
tools and techniques to project activities in order to meet the project''s
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
slack, whose length determines the minimum project duration.</p>', 'html', 63),
  ('31b8f710-3e14-5cff-a519-a041808d160c', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Project constraints and Role of project management team', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Scope, time, and cost</li><li>Identify the roles and responsibilities of project management team members</li></ul></div><h3>The triple constraint</h3>
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
the manager cannot. Owns the project''s success at organisation level.</li>
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
answer.</p>', 'html', 64),
  ('f6b3a705-3d8e-594d-8d37-ca7d2e30ecfd', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Project management phases', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Describe the activities of project initiation, planning, execution, control and monitoring, reporting stages</li></ul></div><p>Five phases. They are not the SDLC — the SDLC builds the system, these
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
mark. Draw it as an arrow running alongside.</p>', 'html', 65),
  ('13dcd66e-de08-598b-b23f-e588d413d57a', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Project control and scheduling methods', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>PERT chart, critical path analysis; use the network diagram to determine project deadline, slack or float (free and total), critical path and tasks</li><li>Gantt chart</li><li>Critical Path Method (CPM)</li><li>Differences between PERT and Gantt; advantages and disadvantages of PERT and CPM</li></ul></div><h3>Network diagrams and critical path analysis</h3>
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
is 0. Early finish = early start + duration. A task''s early start is the
<em>latest</em> early finish of all its predecessors, because it cannot begin
until all of them are done.</li>
<li><strong>Backward pass</strong>, right to left. Late finish of the last task
equals its early finish. Late start = late finish − duration. A task''s late
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
levels; and PERT''s formula gives a comforting precision that the underlying
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
  <text x="330" y="216" font-size="11" fill="currentColor" text-anchor="middle">the length of each bar is the task''s duration; position shows when it happens</text>
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
task letters and the duration as a number with units.</p>', 'html', 66),
  ('05293297-b1ce-5861-a6ed-7765099e037d', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'E-commerce', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Definition and types</li><li>E-commerce forms (B2C, B2B)</li><li>Medium of purchase, fund transfer</li><li>Advantages and disadvantages</li></ul></div><div class="def-box"><strong>E-commerce:</strong> the buying and selling of
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
into an answer.</p>', 'html', 67),
  ('61275340-c39b-568d-9815-b17dc96c3af7', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'E-banking', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Describe e-banking activities</li><li>Types: usefulness of ATM, POS, and Internet banking transactions</li><li>Advantages and disadvantages of e-banking to banks and customers</li></ul></div><div class="def-box"><strong>E-banking:</strong> the delivery of banking
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
<p>A terminal in a shop that reads the customer''s card and transfers the money
from their account to the merchant''s at the moment of sale. This is EFTPOS —
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
jobs.</p>', 'html', 68),
  ('1083d194-4a16-56e1-aad1-7e9280c4dc78', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'E-Health', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Define e-health and its applications</li><li>Role, advantages and disadvantages of e-health technologies e.g. medical information system, telemedicine, electronic medical records system</li></ul></div><div class="def-box"><strong>E-health:</strong> the use of information and
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
<p>The patient''s complete history held electronically: diagnoses, prescriptions,
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
consultation. Saying both halves is what makes the answer strong.</p>', 'html', 69),
  ('f0f11e64-0217-53f6-9ca0-113e0a167d53', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'Computer Assisted Learning (CAL)', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Define CAL</li><li>Methods of course delivery e.g. servers, CD-ROM, didactic resources (e-books)</li><li>Advantages and limitations</li></ul></div><div class="def-box"><strong>Computer Assisted Learning:</strong> the use of
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
delivery may be more practical." That answer earns more than a general list.</p>', 'html', 70),
  ('b82d9e85-f374-593f-9acb-57e611077810', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 3', 'E-government', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Define e-government</li><li>Describe forms: e-governance, e-taxation, e-vote</li><li>Implication of e-government to the government and citizens</li></ul></div><div class="def-box"><strong>E-government:</strong> the use of information and
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
marked as one.</p>', 'html', 71)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  body = EXCLUDED.body, body_format = EXCLUDED.body_format,
  chapter_number = EXCLUDED.chapter_number,
  sequence = EXCLUDED.sequence, updated_at = now();

COMMIT;
