"""
Lower Sixth ICT lesson notes — Term 2.

Software, then people. The first half of the term is the operating system and
the files it manages; the second half is what happens when computers meet
society — crime, ethics, law, health — and it ends on information systems.

The second half is where students write vaguely and lose marks. "It is bad for
society" is not an answer. So those notes are built around named things: named
Acts, named codes of conduct, named disorders, named threats. A student who
can name the thing has something to write.

Same house rules as Term 1: short sentences, the thing then the example,
advantages and disadvantages in pairs, exam wording flagged where the exam is
fussy about it. Figures are inline SVG so they scale and follow the page
colours.

Source for the content: "Advanced Level Computer Science & ICT", BGS Molyko,
2014.
"""

TERM2 = {

"System software": """
<p>Software divides in two. Application software does a job for you. System
software runs the machine so that application software can.</p>

<div class="def-box"><strong>System software:</strong> programs that manage and
control the computer's hardware and provide a platform on which application
software runs.</div>

<figure class="fig">
<svg viewBox="0 0 620 220" role="img" aria-label="Layers from user down through application software, system software and hardware">
  <g stroke="var(--cyan)" fill="var(--cyan-soft)" stroke-width="1.5">
    <rect x="150" y="16" width="320" height="38" rx="6"/>
    <rect x="120" y="62" width="380" height="38" rx="6"/>
    <rect x="90" y="108" width="440" height="38" rx="6"/>
    <rect x="60" y="154" width="500" height="38" rx="6"/>
  </g>
  <g fill="currentColor" font-size="13" text-anchor="middle">
    <text x="310" y="40">User</text>
    <text x="310" y="86">Application software — Word, browser, payroll</text>
    <text x="310" y="132">System software — OS, utilities, drivers, translators</text>
    <text x="310" y="178">Hardware — CPU, memory, disks, peripherals</text>
  </g>
  <text x="580" y="112" font-size="11" fill="currentColor" text-anchor="middle" transform="rotate(90 580 112)">each layer uses the one below</text>
</svg>
<figcaption>The layers. An application never speaks to the hardware directly; it asks the system software.</figcaption>
</figure>

<h3>Why system software is needed</h3>
<p>Without it, every program would have to contain its own code for reading a
disk, driving a printer and sharing the processor. Every program would be
written for one exact machine. The system software does that work once, for
everybody.</p>

<h3>The four kinds</h3>
<ul>
<li><strong>Operating system</strong> — manages the processor, memory, files
and devices, and gives the user an interface. Windows, Linux, Android,
macOS.</li>
<li><strong>Utility software</strong> — small programs that maintain the
system: antivirus, disk defragmenter, backup, file compression, disk
cleaner.</li>
<li><strong>Device drivers</strong> — a small program that tells the operating
system how to talk to one particular piece of hardware. A new printer needs its
driver; without it the OS knows a device is there and not what to say to
it.</li>
<li><strong>Language translators</strong> — turn source code into machine
code.</li>
</ul>

<h3>The three translators</h3>
<table>
<tr><th></th><th>Assembler</th><th>Compiler</th><th>Interpreter</th></tr>
<tr><td>Input</td><td>Assembly language</td><td>High-level language</td><td>High-level language</td></tr>
<tr><td>Translates</td><td>One line to one instruction</td><td>Whole program at once</td><td>One line at a time, while running</td></tr>
<tr><td>Output</td><td>Machine code file</td><td>Machine code file</td><td>No file kept</td></tr>
<tr><td>Speed of running</td><td>Fast</td><td>Fast</td><td>Slow, retranslated each time</td></tr>
<tr><td>Errors</td><td>Listed after the pass</td><td>Listed after compiling</td><td>Stops at the first one</td></tr>
</table>
<p>The trade in one sentence: a compiler is faster to run, an interpreter is
easier to debug.</p>

<h3>In the exam</h3>
<p>"State two functions of system software." Do not answer "it helps the
computer work". Name a function: it manages memory; it controls peripherals
through device drivers. Named functions score.</p>
""",

"Operating systems (OS)": """
<div class="def-box"><strong>Operating system:</strong> the set of programs
that manage the computer's resources, control the running of other programs,
and provide an interface between the user and the hardware.</div>

<h3>How operating systems developed</h3>
<ul>
<li><strong>No OS at all</strong> — the earliest machines were set up by hand
for one job. The operator loaded the program, ran it, and set up the next one.
The machine sat idle between jobs, and the machine was the expensive part.</li>
<li><strong>Batch systems</strong> — jobs with similar requirements were
collected and run one after another without operator intervention. The setup
time disappeared. But there was no interaction: you submitted a job and came
back for the printout.</li>
<li><strong>Multiprogramming</strong> — several programs held in memory at
once. When one waits for input or output, the processor switches to another,
so it is never idle. This is where memory protection and scheduling become
necessary.</li>
<li><strong>Time-sharing and multi-access</strong> — the processor is given to
each user in turn for a small slice of time. Switching is fast enough that each
user believes the machine is theirs. This gave interactive computing:
terminals, then conversation with the machine.</li>
<li><strong>Personal computers and the GUI</strong> — one machine per person,
and an interface made of windows, icons and a pointer rather than typed
commands.</li>
<li><strong>Networked, mobile and distributed systems</strong> — network
operating systems, then Android and iOS, where power and touch matter more
than raw throughput.</li>
</ul>

<h3>The pattern behind the history</h3>
<p>Each step is about keeping the expensive resource busy. Early on the
expensive resource was the processor, so batch and multiprogramming were
invented to keep it fed. Once processors became cheap, the expensive resource
became the user's time, and the interface became the thing worth improving.
That sentence answers a lot of "why" questions.</p>

<h3>In the exam</h3>
<p>The OS is the interface between user and hardware, and it manages resources.
Both halves of that definition are needed for full marks. And when asked why
batch processing was introduced, the answer is to remove idle setup time
between jobs — not "to make it faster", which is too vague to mark.</p>
""",

"Types of OS": """
<p>Operating systems are grouped by how they take work in and how many things
they handle at once.</p>

<h3>By how work arrives</h3>
<ul>
<li><strong>Batch</strong> — jobs are collected and processed together with no
user interaction while they run. Payroll at the end of the month, ENEO bills
for a whole town. Efficient for large regular volumes, but you wait for the
result.</li>
<li><strong>Online</strong> — the user is connected and interacts with the
program while it runs.</li>
<li><strong>Real time transaction processing</strong> — each transaction is
handled immediately and files are updated at once, so the data is always
current. Airline seat booking; a Mobile Money transfer. The point is that no
one else can be sold the same seat a second later.</li>
<li><strong>Real time process control</strong> — the system must respond
within a guaranteed time because something physical depends on it. Aircraft
control, a hospital ventilator, an anti-lock braking system. Late is the same
as wrong.</li>
<li><strong>Multi-access, or time sharing</strong> — many users at terminals
share one processor by taking turns in time slices.</li>
<li><strong>Network OS</strong> — runs on a server, manages shared files,
printers, users and security across a network. Windows Server, Linux
server distributions.</li>
</ul>

<h3>The three "multi" words</h3>
<p>These are confused constantly, and the paper knows it.</p>
<table>
<tr><th>Term</th><th>Meaning</th><th>Processors</th></tr>
<tr><td>Multiprogramming</td><td>Several programs in memory; the CPU switches
when one waits for I/O</td><td>One</td></tr>
<tr><td>Multitasking</td><td>Several tasks appear to run at once by rapid
switching in time slices</td><td>One</td></tr>
<tr><td>Multiprocessing</td><td>Two or more processors genuinely executing at
the same instant</td><td>Two or more</td></tr>
</table>
<p>The distinction that carries the mark: multiprogramming and multitasking are
<em>apparent</em> simultaneity on one processor. Multiprocessing is
<em>real</em> simultaneity on several.</p>

<h3>In the exam</h3>
<p>"Real time" alone is not enough. Say whether it is real-time transaction
processing or real-time process control, because the examples and the
consequences of delay are different.</p>
""",

"Functions of the operating system": """
<p>Five jobs. Learn them as five headings and the detail hangs off them.</p>

<h3>1. Process management</h3>
<div class="def-box"><strong>Process:</strong> a program that is being
executed, together with its current state.</div>
<p>The OS creates processes, suspends and resumes them, and removes them when
they finish. A process is <em>ready</em>, <em>running</em>, or
<em>blocked</em> — blocked meaning it is waiting for something, usually input
or output.</p>

<h3>2. Process scheduling</h3>
<p>Deciding which ready process gets the processor next.</p>
<ul>
<li><strong>Non-pre-emptive</strong> — a process keeps the processor until it
finishes or blocks itself. Simple, but one long job holds everyone up.</li>
<li><strong>Pre-emptive</strong> — the OS can take the processor away, on a
timer or when a more urgent process arrives. Fairer and responsive, but
switching costs time.</li>
</ul>
<p>The four algorithms named on the syllabus:</p>
<ul>
<li><strong>First Come First Served (FCFS)</strong> — in arrival order.
Non-pre-emptive. Simple and fair in order, but a long job at the front makes
everything behind it wait. That is the convoy effect.</li>
<li><strong>Shortest Job First (SJF)</strong> — the shortest job runs next.
Non-pre-emptive. Gives the best average waiting time, but long jobs may starve,
and you must know the run times in advance, which in practice you do not.</li>
<li><strong>Shortest Remaining Time (SRT)</strong> — the pre-emptive version:
if an arriving job is shorter than what remains of the running one, switch.</li>
<li><strong>Round Robin</strong> — each process gets a fixed time slice, or
quantum, in turn. Pre-emptive. Nobody starves and response is even, which is
why interactive systems use it. A quantum too short wastes time switching; too
long and it becomes FCFS.</li>
</ul>

<figure class="fig">
<svg viewBox="0 0 620 170" role="img" aria-label="Gantt charts comparing first come first served with round robin scheduling">
  <text x="20" y="26" font-size="12" fill="currentColor">FCFS</text>
  <g stroke="var(--cyan)" stroke-width="1.4">
    <rect x="80" y="14" width="230" height="26" fill="var(--cyan-soft)"/>
    <rect x="310" y="14" width="80" height="26" fill="var(--cyan-soft)"/>
    <rect x="390" y="14" width="60" height="26" fill="var(--cyan-soft)"/>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="195" y="32">P1 (long)</text><text x="350" y="32">P2</text><text x="420" y="32">P3</text>
  </g>
  <text x="80" y="58" font-size="11" fill="currentColor">P2 and P3 wait a long time for one long job</text>

  <text x="20" y="110" font-size="12" fill="currentColor">Round</text>
  <text x="20" y="124" font-size="12" fill="currentColor">Robin</text>
  <g stroke="var(--cyan)" stroke-width="1.4" fill="var(--cyan-soft)">
    <rect x="80" y="98" width="52" height="26"/><rect x="132" y="98" width="52" height="26"/>
    <rect x="184" y="98" width="52" height="26"/><rect x="236" y="98" width="52" height="26"/>
    <rect x="288" y="98" width="52" height="26"/><rect x="340" y="98" width="52" height="26"/>
    <rect x="392" y="98" width="52" height="26"/>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="106" y="116">P1</text><text x="158" y="116">P2</text><text x="210" y="116">P3</text>
    <text x="262" y="116">P1</text><text x="314" y="116">P2</text><text x="366" y="116">P1</text>
    <text x="418" y="116">P1</text>
  </g>
  <text x="80" y="142" font-size="11" fill="currentColor">every process is served early; the quantum is one slice</text>
  <line x1="80" y1="152" x2="460" y2="152" stroke="currentColor" stroke-width="1.2" marker-end="url(#ah6)"/>
  <text x="470" y="156" font-size="11" fill="currentColor">time</text>
  <defs><marker id="ah6" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto">
    <path d="M0,0 L8,4 L0,8 z" fill="currentColor"/></marker></defs>
</svg>
<figcaption>The same three processes under two algorithms. Round robin shares the processor; FCFS makes everyone queue behind the first job.</figcaption>
</figure>

<h3>3. Memory management</h3>
<ul>
<li>Allocates memory to each process and frees it afterwards.</li>
<li>Keeps processes apart, so a fault in one cannot corrupt another. That is
memory protection.</li>
<li>Provides <strong>virtual memory</strong>: part of the disk used as
extra RAM, so programs larger than physical memory can run. Pages are swapped
in and out. Too much swapping is called thrashing, and the machine crawls.</li>
</ul>

<h3>4. File management</h3>
<p>Creates, opens, reads, writes, renames, deletes and moves files. Keeps the
directory structure. Enforces access rights, so a student cannot read a
teacher's folder. Allocates disk space and tracks free space.</p>

<h3>5. Device management</h3>
<p>Controls every peripheral through its driver, and uses five techniques the
syllabus names:</p>
<ul>
<li><strong>Interrupt</strong> — a device signals the CPU that it needs
attention; the CPU saves what it was doing, runs the handler, and returns. The
device does not have to be checked constantly.</li>
<li><strong>Polling</strong> — the opposite: the CPU asks each device in turn
whether it needs service. Simple, but wasteful, because most answers are
no.</li>
<li><strong>Buffering</strong> — a block of memory holds data temporarily so a
fast device and a slow one can work together. Video streaming buffers for
exactly this reason.</li>
<li><strong>Spooling</strong> — Simultaneous Peripheral Operation On Line.
Output is written to disk and printed later, so the program need not wait for
the printer, and many users share one printer through a queue.</li>
<li><strong>Handshaking</strong> — signals exchanged between two devices to
agree that one is ready to send and the other ready to receive.</li>
</ul>

<h3>In the exam</h3>
<p>Interrupt against polling is the pair asked most. Interrupt: the device
calls the CPU. Polling: the CPU asks the device. Say which way the request
travels and you have the mark.</p>
""",

"Operating system user interfaces": """
<div class="def-box"><strong>User interface:</strong> the part of the system
through which the user and the computer communicate.</div>

<h3>The four types</h3>
<ul>
<li><strong>Command driven (CLI)</strong> — the user types commands.
<code>dir</code>, <code>cd</code>, <code>copy</code>, or on Linux
<code>ls</code>, <code>cd</code>, <code>cp</code>.
<br><strong>Strengths:</strong> fast for an expert, very little memory and
processing needed, and commands can be combined into scripts that run
automatically.
<br><strong>Weaknesses:</strong> you must know the commands and their exact
syntax, error messages are unhelpful, and it is intimidating for a
beginner.</li>
<li><strong>Menu driven</strong> — the user chooses from a list. An ATM, a
Mobile Money USSD menu, a set-top box.
<br><strong>Strengths:</strong> nothing to memorise, hard to enter something
invalid, good where the user is untrained or the device has few keys.
<br><strong>Weaknesses:</strong> slow if the option you want is four menus
deep, and you can only do what the menu offers.</li>
<li><strong>Graphical (GUI)</strong> — windows, icons, menus, pointer.
<br><strong>Strengths:</strong> easy to learn, consistent between programs, no
commands to remember, and several tasks visible at once.
<br><strong>Weaknesses:</strong> needs much more memory and processing power,
and is slower than typing for a skilled user doing a repetitive job.</li>
<li><strong>Natural language and voice</strong> — the user speaks or writes
ordinary language.
<br><strong>Strengths:</strong> nothing to learn at all, hands-free, and it
opens the machine to users who cannot type or see the screen.
<br><strong>Weaknesses:</strong> accents and ambiguity cause errors, it needs
a quiet environment, and it needs substantial processing.</li>
</ul>

<h3>Choosing an interface</h3>
<p>Match it to the user and the machine, and say why:</p>
<ul>
<li>A bank ATM: menu driven. The user is untrained, has a few seconds, and
must not be able to type something wrong.</li>
<li>A system administrator managing fifty servers: command line. Repetitive
work that can be scripted, and no screen needed.</li>
<li>A primary school pupil: GUI. Nothing to memorise; icons carry the
meaning.</li>
<li>A driver, or a blind user: voice. Hands and eyes are unavailable.</li>
<li>An embedded washing machine controller: menu, because it has six buttons
and no room for anything else.</li>
</ul>

<h3>In the exam</h3>
<p>The question is almost always "choose an interface for this user and justify
it". The justification must mention the <em>user's</em> circumstances, not the
interface's general qualities. "GUI because it is easy" scores less than "GUI
because the staff are not trained in computing and will use it occasionally".</p>
""",

"Server Concepts": """
<div class="def-box"><strong>Server:</strong> a computer, or a program, that
provides a service to other computers called clients over a network.</div>

<h3>Stand-alone against server operating systems</h3>
<table>
<tr><th></th><th>Stand-alone (desktop) OS</th><th>Server OS</th></tr>
<tr><td>Users</td><td>Usually one at a time</td><td>Many concurrent users</td></tr>
<tr><td>Designed for</td><td>Responsiveness for the person at the keyboard</td><td>Throughput and uptime</td></tr>
<tr><td>Runs</td><td>Applications with a GUI</td><td>Services: file, print, web, mail, database</td></tr>
<tr><td>Security</td><td>Local accounts</td><td>Central accounts, groups, permissions, auditing</td></tr>
<tr><td>Hardware</td><td>Ordinary</td><td>Redundant power, RAID disks, ECC memory</td></tr>
<tr><td>Expected uptime</td><td>Switched off at night</td><td>Continuous</td></tr>
</table>

<h3>Types of server</h3>
<ul>
<li><strong>File server</strong> — shared storage for documents.</li>
<li><strong>Print server</strong> — manages the print queue for shared
printers.</li>
<li><strong>Web server</strong> — serves web pages on request.</li>
<li><strong>Mail server</strong> — holds and forwards email.</li>
<li><strong>Database server</strong> — answers queries against a shared
database.</li>
<li><strong>Proxy server</strong> — sits between the network and the internet,
caching pages and filtering requests.</li>
</ul>

<h3>Connecting to a network</h3>
<ul>
<li><strong>Wired</strong> — plug in the RJ-45 cable. Either accept an address
from DHCP automatically, or set a static IP address, subnet mask, gateway and
DNS server by hand. A server usually gets a static address, because clients
need to find it at the same place every time.</li>
<li><strong>Wireless</strong> — select the SSID, choose the security type
(WPA2 or WPA3, never WEP, which is broken), and enter the key.</li>
<li>Test with <code>ipconfig</code> or <code>ifconfig</code> to see the address,
then <code>ping</code> the gateway to prove the link works.</li>
</ul>

<h3>Setting the OS up against unauthorised access</h3>
<ul>
<li>Give every user their own account. Shared accounts destroy
accountability.</li>
<li>Enforce strong passwords and expiry, and lock the account after a number of
failed attempts.</li>
<li>Apply <strong>least privilege</strong>: each user gets the minimum rights
the job needs, and administrator rights are used only for administration.</li>
<li>Set file and folder permissions by group rather than by person.</li>
<li>Turn on the firewall and switch off services that are not being used —
every running service is another way in.</li>
<li>Keep the system patched, enable auditing, and read the logs.</li>
<li>Lock the screen on idle, and lock the server room door. Physical access
defeats every software control.</li>
</ul>

<h3>In the exam</h3>
<p>"Give two reasons a school would use a server rather than stand-alone
machines." Central storage so work is available from any machine and can be
backed up in one place; and central user accounts so access can be controlled
and monitored.</p>
""",

"Utility Software": """
<div class="def-box"><strong>Utility software:</strong> system software that
performs a specific maintenance or housekeeping task to keep the computer
running well.</div>
<p>A utility does not do the user's work and does not run the machine. It looks
after the machine. That is what puts it between the OS and applications.</p>

<h3>The utilities named on the syllabus</h3>
<ul>
<li><strong>Disk defragmenter</strong> — over time a file is written in pieces
scattered across the disk, and the read head must move to each piece.
Defragmenting rearranges the pieces so each file is contiguous, which cuts head
movement and speeds up reading. Note: never defragment an SSD. It has no head
to move, and the extra writing shortens its life.</li>
<li><strong>Virus checker (antivirus)</strong> — scans files against a
database of known virus signatures, and watches for suspicious behaviour.
Quarantines or deletes what it finds. Useless if the signature database is not
updated, which is the point the exam wants.</li>
<li><strong>File compression</strong> — reduces file size for storage and for
transmission.</li>
<li><strong>Disk cleaner</strong> — removes temporary files, browser caches,
installers and emptied recycle bins to recover space.</li>
</ul>

<h3>Other utilities worth naming</h3>
<ul>
<li><strong>Backup</strong> — copies data so it can be recovered after loss.
Can be scheduled and incremental.</li>
<li><strong>Disk formatting and partitioning</strong> — prepares a disk to hold
a file system, and divides it into logical drives.</li>
<li><strong>File manager</strong> — copy, move, rename, delete, search.</li>
<li><strong>Firewall</strong> — controls what network traffic is allowed in and
out.</li>
<li><strong>Diagnostic and system monitor</strong> — reports on hardware
health, memory use and processor load.</li>
</ul>

<h3>Effect on system performance</h3>
<p>Say what each one actually improves:</p>
<ul>
<li>Defragmenter — faster file access on a mechanical hard disk.</li>
<li>Disk cleaner — more free space, and a disk that is nearly full is a slow
disk.</li>
<li>Antivirus — prevents the loss of performance and data that malware
causes, though scanning itself costs some processor time.</li>
<li>Compression — more files fit, and transfers finish sooner.</li>
</ul>

<h3>In the exam</h3>
<p>Do not confuse a utility with an application. A disk defragmenter maintains
the computer; a spreadsheet does the user's work. If a question asks for
"two utility programs and their purpose", name and purpose both, one line
each.</p>
""",

"Graphic software": """
<p>There are two ways to store a picture, and every graphics question comes
back to which one was used.</p>

<figure class="fig">
<svg viewBox="0 0 620 220" role="img" aria-label="A bitmap circle made of square pixels beside a vector circle defined by centre and radius">
  <text x="150" y="20" font-size="13" fill="currentColor" text-anchor="middle" font-weight="600">Bitmap</text>
  <text x="450" y="20" font-size="13" fill="currentColor" text-anchor="middle" font-weight="600">Vector</text>
  <g fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="0.8">
    <rect x="110" y="46" width="16" height="16"/><rect x="126" y="46" width="16" height="16"/>
    <rect x="142" y="46" width="16" height="16"/><rect x="158" y="46" width="16" height="16"/>
    <rect x="94" y="62" width="16" height="16"/><rect x="174" y="62" width="16" height="16"/>
    <rect x="78" y="78" width="16" height="16"/><rect x="190" y="78" width="16" height="16"/>
    <rect x="78" y="94" width="16" height="16"/><rect x="190" y="94" width="16" height="16"/>
    <rect x="94" y="110" width="16" height="16"/><rect x="174" y="110" width="16" height="16"/>
    <rect x="110" y="126" width="16" height="16"/><rect x="126" y="126" width="16" height="16"/>
    <rect x="142" y="126" width="16" height="16"/><rect x="158" y="126" width="16" height="16"/>
  </g>
  <g stroke="currentColor" stroke-width="0.4" opacity="0.45">
    <path d="M78 46 H206 M78 62 H206 M78 78 H206 M78 94 H206 M78 110 H206 M78 126 H206 M78 142 H206"/>
    <path d="M78 46 V142 M94 46 V142 M110 46 V142 M126 46 V142 M142 46 V142 M158 46 V142 M174 46 V142 M190 46 V142 M206 46 V142"/>
  </g>
  <circle cx="450" cy="94" r="52" fill="var(--cyan-soft)" stroke="var(--cyan)" stroke-width="1.6"/>
  <g stroke="currentColor" stroke-width="1" stroke-dasharray="3 3"><path d="M450 94 L502 94"/></g>
  <circle cx="450" cy="94" r="2.5" fill="currentColor"/>
  <text x="476" y="88" font-size="11" fill="currentColor" text-anchor="middle">r</text>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="150" y="168">stored as a grid of coloured pixels</text>
    <text x="150" y="184">enlarge it and the squares show</text>
    <text x="450" y="168">stored as: centre (450,94), radius 52,</text>
    <text x="450" y="184">line colour, fill colour — redrawn at any size</text>
  </g>
</svg>
<figcaption>Same circle, two storage methods. The bitmap keeps pixels; the vector keeps the instructions for drawing it.</figcaption>
</figure>

<h3>Bitmap, also called raster</h3>
<p>The image is a grid of pixels, each with a colour value. Photographs are
bitmaps, because a photograph is not made of shapes.</p>
<ul>
<li><strong>Advantages:</strong> can represent any image, including continuous
tone and subtle shading; easy to edit pixel by pixel; every device and program
can open the common formats.</li>
<li><strong>Disadvantages:</strong> large files, because every pixel is stored;
resolution dependent, so enlarging makes it blocky, called pixelation; text and
lines lose their sharpness when scaled.</li>
<li><strong>Formats:</strong> JPEG, GIF, TIFF, BMP, PNG.</li>
<li><strong>Software:</strong> Adobe Photoshop, GIMP, Paint.</li>
</ul>

<h3>Vector</h3>
<p>The image is stored as a list of objects and their properties: lines,
curves, shapes, with coordinates, thickness and colour. The picture is redrawn
from that description each time it is displayed.</p>
<ul>
<li><strong>Advantages:</strong> small files; resolution independent, so it can
be scaled to any size with no loss of quality; each object stays separately
editable; ideal for logos, diagrams, plans and typefaces.</li>
<li><strong>Disadvantages:</strong> cannot store a photograph well; complex
images take processing to redraw; fewer programs open the formats.</li>
<li><strong>Formats:</strong> SVG, EPS, CGM, AI, and the drawings in this
page.</li>
<li><strong>Software:</strong> Adobe Illustrator, Inkscape, CorelDRAW,
AutoCAD.</li>
</ul>

<h3>Which to choose</h3>
<ul>
<li>A school logo, to be printed on a pen and on a banner — vector. It must
scale.</li>
<li>A photograph of the sports day — bitmap. There is no other option.</li>
<li>A circuit diagram or an architectural plan — vector.</li>
<li>A scanned document — bitmap, then OCR if the text is needed.</li>
</ul>

<h3>In the exam</h3>
<p>Note that PNG is a <em>bitmap</em> format, despite where it sometimes
appears on syllabus lists. If your syllabus lists it under vector, learn the
list as printed for the exam and know the truth for yourself. The safe answer
about PNG is that it is a lossless format supporting transparency.</p>
""",

"File and Data Security": """
<p>Data is usually worth more than the machine it sits on. A stolen laptop
costs a few hundred thousand francs; a lost student database costs a year of
work.</p>

<h3>Backup</h3>
<div class="def-box"><strong>Backup:</strong> a copy of data kept separately,
so the data can be restored if the original is lost or damaged.</div>
<ul>
<li><strong>Full</strong> — everything, every time. Slow, large, simplest to
restore.</li>
<li><strong>Incremental</strong> — only what changed since the last backup of
any kind. Fast to make, slow to restore, because you need the full backup plus
every increment since.</li>
<li><strong>Differential</strong> — everything changed since the last full
backup. Middle ground: bigger than incremental, but restoring needs only two
sets.</li>
<li>Keep at least one copy <strong>off site</strong>. A backup on a shelf
beside the server burns in the same fire.</li>
<li>Test the restore. An untested backup is a hope, not a backup.</li>
</ul>

<h3>Transaction logs and archive files</h3>
<ul>
<li>A <strong>transaction log</strong> records every change made to the data,
in order, with a timestamp. After a failure the last backup is restored and the
log is replayed to bring the data back to the moment of the crash.</li>
<li>An <strong>archive file</strong> holds data that is no longer in daily use
but must be kept — old students, closed accounts. It is moved off the live
system, which keeps that system small and fast. An archive is not a backup:
the archive is the only copy of that data, so it needs backing up too.</li>
<li><strong>Audit logs</strong> record who did what and when. They do not
prevent misuse; they let you prove it happened and identify who is
responsible.</li>
</ul>

<h3>Data integrity</h3>
<div class="def-box"><strong>Data integrity:</strong> the accuracy,
completeness and consistency of data over its whole life.</div>
<p>Protected by validation at input, verification of what was typed, controlled
access so only authorised people can change data, transaction logging, and
checks such as parity and checksums during transmission.</p>

<h3>Access rights management</h3>
<ul>
<li>Each user has an individual <strong>user ID</strong>, so actions can be
traced to a person.</li>
<li>A <strong>password</strong> authenticates them. It should be long, mixed,
not a dictionary word, changed periodically, and never shared or written on the
desk.</li>
<li>Rights are set per file or folder: read, write, execute, delete. Assign by
group, and give the minimum needed.</li>
<li>Two-factor authentication adds something you have — a code to a phone — to
something you know.</li>
</ul>

<h3>Encryption</h3>
<p>Data is scrambled with a key so that anyone intercepting it cannot read it.
Encryption does not stop the data being stolen. It stops the thief
understanding it. That distinction is worth a mark on its own.</p>

<h3>Physical protection and disaster planning</h3>
<ul>
<li>Locked server rooms, guards, CCTV, cable locks, biometric door
controls.</li>
<li>Fire detection and suppression, an uninterruptible power supply, a
generator, air conditioning.</li>
<li>A <strong>disaster recovery plan</strong>: who does what, in what order,
after fire, flood, theft or a long power cut. It names a standby site, the
restore procedure, and a recovery time target. Written in advance, because
nobody plans well at two in the morning.</li>
</ul>

<h3>In the exam</h3>
<p>Sort your answer into <em>preventive</em>, <em>detective</em> and
<em>corrective</em> measures. Locks and passwords prevent; audit logs and
intrusion detection detect; backups and the recovery plan correct. That
structure alone reads as a stronger answer.</p>
""",

"File compression": """
<div class="def-box"><strong>File compression:</strong> encoding data so that
it occupies fewer bits than the original representation.</div>

<h3>The two methods</h3>
<ul>
<li><strong>Lossless</strong> — nothing is thrown away. The original file can
be reconstructed bit for bit. Used where every bit matters: text, programs,
spreadsheets, databases. ZIP, RAR, PNG, GIF, FLAC.
<br>How it works: repetition is replaced by a shorter reference. Run-length
encoding turns "AAAAAAA" into "7A". Huffman coding gives the commonest symbols
the shortest codes. Dictionary methods replace repeated strings with an index
into a table built as the file is read.</li>
<li><strong>Lossy</strong> — detail judged unimportant is discarded
permanently. The file cannot be restored exactly. Used for images, sound and
video, where the eye and the ear will not notice. JPEG, MP3, MP4, MPEG.
<br>How it works: it removes what human senses are poor at detecting — fine
colour variation, sounds masked by louder sounds nearby.</li>
</ul>
<p>The decision rule: if losing any detail would matter, use lossless. A
compressed program that has lost a bit will not run. A photograph that has lost
a shade still looks like the photograph.</p>

<h3>Advantages of compressing a file</h3>
<ul>
<li>Less storage space used, so more files fit on the same disk.</li>
<li>Faster transmission over a network, and less bandwidth used — which
matters when data is bought by the megabyte.</li>
<li>Faster backup, because there is less to write.</li>
<li>Many files can be gathered into one archive, so a folder can be sent as a
single attachment.</li>
</ul>

<h3>And the costs</h3>
<ul>
<li>Processing time to compress and to decompress.</li>
<li>Lossy compression permanently reduces quality, and compressing an
already-compressed file again makes it worse.</li>
<li>A compressed file is unusable until it is decompressed, and a single
corrupted byte can damage far more of the file than it would uncompressed.</li>
</ul>

<h3>File systems</h3>
<p>A file system decides how files are named, stored and found on a medium.</p>
<ul>
<li><strong>FAT32</strong> — old, understood by everything, so it is the safe
choice for a flash drive shared between machines. Cannot hold a file larger
than 4 GB.</li>
<li><strong>NTFS</strong> — the Windows file system. Permissions, encryption,
compression, journaling, and no practical file size limit.</li>
<li><strong>ext4</strong> — the usual Linux file system, journaled.</li>
<li><strong>exFAT</strong> — made for flash media, no 4 GB limit, widely
supported.</li>
</ul>
<p>Journaling means the file system records what it is about to do before doing
it, so an interrupted write can be finished or undone after a power cut instead
of leaving the disk corrupted. Useful to name if a question mentions
reliability.</p>

<h3>In the exam</h3>
<p>"Why is MP3 lossy?" Because it discards sound the human ear cannot easily
hear, which gives a much smaller file at the cost of some quality — and the
discarded sound cannot be recovered.</p>
""",

"File Format": """
<div class="def-box"><strong>File format:</strong> the particular way in which
information is encoded and arranged inside a file, so that a program knows how
to read it.</div>

<h3>Why formats matter</h3>
<ul>
<li>The program must know how to interpret the bytes. The same bytes are a
picture in one format and nonsense in another.</li>
<li>The extension tells the operating system which program to open the file
with.</li>
<li>Formats decide compatibility: whether the person you send the file to can
open it at all.</li>
<li>Formats decide file size and quality, which decides how long it takes to
send.</li>
<li><strong>Open</strong> formats are published, so any program may implement
them (PNG, HTML, ODF). <strong>Proprietary</strong> formats belong to a
company, which is a risk if you want to read the file in twenty years.</li>
</ul>

<h3>Bitmap image formats</h3>
<ul>
<li><strong>JPEG (.jpg)</strong> — lossy, millions of colours, adjustable
compression. The right choice for photographs. Wrong for text or line art,
where it produces smudges around the edges. No transparency.</li>
<li><strong>TIFF (.tif)</strong> — lossless, very high quality, large files.
Used in publishing, professional photography and archiving, and by
scanners.</li>
<li><strong>GIF</strong> — lossless but limited to 256 colours. Supports
transparency and simple animation. Good for small logos and icons; poor for
photographs, which look banded.</li>
<li><strong>BMP</strong> — uncompressed Windows bitmap. Simple and very
large.</li>
<li><strong>PNG</strong> — lossless, millions of colours, full transparency.
Made as a free replacement for GIF. It is the safe choice for screenshots,
diagrams and logos on the web. It does not animate.</li>
</ul>

<h3>Vector graphics formats</h3>
<ul>
<li><strong>SVG</strong> — Scalable Vector Graphics. An open, text-based format
that every browser understands, so it scales perfectly on any screen. The
diagrams in these notes are SVG.</li>
<li><strong>CGM</strong> — Computer Graphics Metafile. An international
standard used in technical and engineering documentation.</li>
<li><strong>EPS</strong> — Encapsulated PostScript. The printing industry's
format, used for logos and artwork sent to a press.</li>
<li><strong>AI</strong>, <strong>CDR</strong> — the native formats of Adobe
Illustrator and CorelDRAW. Proprietary.</li>
</ul>

<h3>Choosing an image format</h3>
<table>
<tr><th>You have</th><th>Use</th><th>Because</th></tr>
<tr><td>A photograph for a website</td><td>JPEG</td><td>Small file, and quality loss is invisible</td></tr>
<tr><td>A screenshot with text</td><td>PNG</td><td>Lossless, so the text stays sharp</td></tr>
<tr><td>A logo for a banner</td><td>SVG or EPS</td><td>Vector, so it scales without pixelating</td></tr>
<tr><td>A scan for the archive</td><td>TIFF</td><td>Lossless, highest quality retained</td></tr>
</table>

<h3>In the exam</h3>
<p>Always give the format <em>and</em> the reason. "JPEG" is one mark at best;
"JPEG, because it compresses photographs to a small size and the loss of
quality is not noticeable on screen" is the full answer.</p>
""",

"File Format (continued)": """
<h3>Sound formats</h3>
<ul>
<li><strong>WAV</strong> — uncompressed, CD quality, very large. About 10 MB
per minute. Used in recording studios and where quality must not be
touched.</li>
<li><strong>MP3</strong> — lossy compression, roughly a tenth of the size of
WAV, and good enough that most listeners hear no difference. The format that
made portable music players possible.</li>
<li><strong>MP4</strong> — properly a container, not just audio. It can hold
video, audio, subtitles and still images in one file. When a syllabus lists it
under sound it means the AAC audio inside it.</li>
<li>Also worth naming: <strong>MIDI</strong>, which stores instructions for
notes rather than recorded sound, so the files are tiny; and
<strong>FLAC</strong>, lossless compression at about half the size of WAV.</li>
</ul>

<h3>Video formats</h3>
<ul>
<li><strong>AVI</strong> — an old Microsoft container. Widely supported,
usually large, and it does not stream well.</li>
<li><strong>MPEG</strong> — a family of compression standards. MPEG-2 is DVD
and digital television; MPEG-4 is the internet and mobile video.</li>
<li>Remember the distinction the exam likes: a <strong>container</strong>
(AVI, MP4, MKV) is the box; a <strong>codec</strong> (H.264, MPEG-2) is the
method used to compress what is inside it.</li>
</ul>

<h3>Text and document formats</h3>
<ul>
<li><strong>TXT</strong> — plain text, no formatting, readable by every
program on every system. The most portable format there is.</li>
<li><strong>RTF</strong> — Rich Text Format. Basic formatting, readable by all
word processors. The safe interchange format.</li>
<li><strong>DOC / DOCX</strong> — Microsoft Word. DOCX is XML-based and
compressed, so it is smaller and more resistant to corruption than the old
DOC.</li>
<li><strong>PDF</strong> — Portable Document Format. Preserves the exact
layout, fonts and images on every device and printer, and can be locked against
editing. The right format for a document to be read or printed rather than
edited.</li>
</ul>

<h3>Common application formats</h3>
<ul>
<li><strong>DBF</strong> — dBase database file, an old but widely readable
table format.</li>
<li><strong>MDB / ACCDB</strong> — Microsoft Access database. ACCDB is the
newer one.</li>
<li><strong>XLS / XLSX</strong> — Microsoft Excel workbook, holding sheets,
formulas, formatting and charts.</li>
<li><strong>CSV</strong> — comma separated values. Plain text, one record per
line. No formatting and no formulas, but every spreadsheet and database on
earth can read it, which is why data is exchanged in it.</li>
</ul>

<h3>Hypermedia formats</h3>
<ul>
<li><strong>SGML</strong> — Standard Generalized Markup Language, the parent
standard from which the others descend. Powerful and complicated.</li>
<li><strong>HTML</strong> — HyperText Markup Language. Describes the
<em>structure and presentation</em> of a web page using fixed tags:
<code>&lt;p&gt;</code>, <code>&lt;h1&gt;</code>, <code>&lt;a&gt;</code>.</li>
<li><strong>XML</strong> — eXtensible Markup Language. Describes
<em>data</em>, and you define your own tags:
<code>&lt;student&gt;&lt;name&gt;...&lt;/name&gt;&lt;/student&gt;</code>. Used
to exchange data between different systems, and inside DOCX and XLSX.</li>
</ul>
<p>The distinction, in one line: HTML says how a page should look; XML says
what the data means.</p>

<h3>In the exam</h3>
<p>HTML against XML comes up almost every year. Fixed tags for presentation
against user-defined tags for data. Say both halves.</p>
""",

"Ergonomics": """
<div class="def-box"><strong>Ergonomics:</strong> the study of designing
equipment and the working environment to fit the people who use them, so that
work is done safely, comfortably and efficiently.</div>
<p>The principle is that the workplace is adjusted to the worker, not the
worker to the workplace.</p>

<figure class="fig">
<svg viewBox="0 0 620 260" role="img" aria-label="Correct posture at a computer workstation showing screen height, arm and knee angles and foot support">
  <g stroke="currentColor" stroke-width="1.6" fill="none">
    <rect x="300" y="46" width="130" height="82" rx="4"/>
    <path d="M365 128 V146 M338 146 H392"/>
    <rect x="270" y="150" width="190" height="8"/>
    <path d="M290 158 V236 M450 158 V236"/>
    <circle cx="170" cy="70" r="22"/>
    <path d="M170 92 V168"/>
    <path d="M170 110 L232 148"/>
    <path d="M232 148 L282 148"/>
    <path d="M170 168 H236"/>
    <path d="M236 168 V228 M236 228 H272"/>
    <path d="M138 168 H180 M138 168 V200 M126 200 H150"/>
    <rect x="222" y="228" width="60" height="8"/>
  </g>
  <g stroke="var(--cyan)" stroke-width="1.3" fill="none" stroke-dasharray="4 3">
    <path d="M192 66 H298"/>
  </g>
  <g fill="currentColor" font-size="11">
    <text x="440" y="40">screen top at or just below eye level</text>
    <text x="440" y="150">arm's length away</text>
    <text x="292" y="142">wrists straight,</text><text x="292" y="155">elbows about 90°</text>
    <text x="106" y="216">adjustable</text><text x="106" y="229">chair, lumbar</text><text x="106" y="242">support</text>
    <text x="200" y="252">feet flat or on a footrest, knees about 90°</text>
  </g>
</svg>
<figcaption>A workstation set up correctly. Every measurement here exists to prevent one of the disorders below.</figcaption>
</figure>

<h3>A good working environment</h3>
<ul>
<li><strong>Chair</strong> — adjustable height, backrest with lumbar support,
five castors for stability.</li>
<li><strong>Desk</strong> — enough depth for the screen at arm's length, and
room for documents.</li>
<li><strong>Screen</strong> — top of the screen at or just below eye level,
tilted slightly, positioned to avoid reflections from windows and lights.</li>
<li><strong>Keyboard and mouse</strong> — directly in front, elbows at about
90°, wrists straight and supported.</li>
<li><strong>Lighting</strong> — even, indirect, no glare on the screen; blinds
on the windows.</li>
<li><strong>Environment</strong> — comfortable temperature, ventilation, low
noise, cables routed safely.</li>
<li><strong>Breaks</strong> — away from the screen regularly. This is a control
measure, not a luxury.</li>
</ul>

<h3>Computer related health hazards</h3>
<ul>
<li><strong>RSI — repetitive strain injury.</strong> Pain, weakness and
stiffness in the hands, wrists, arms and shoulders, caused by the same small
movements repeated for long periods in a poor posture.
<br><em>Prevention:</em> wrist rest, correct keyboard height, regular breaks,
stretching, a keyboard and mouse that suit the hand.</li>
<li><strong>CTS — carpal tunnel syndrome.</strong> A specific form of RSI. The
median nerve is compressed where it passes through the wrist, giving numbness,
tingling and pain in the thumb and fingers. Severe cases need surgery.
<br><em>Prevention:</em> keep the wrist straight and unbent while typing, use
a wrist support, do not rest the wrist on a hard edge, take breaks.</li>
<li><strong>Eye strain.</strong> Tired, dry, sore eyes and headaches, from
staring at a fixed distance, glare and poor lighting.
<br><em>Prevention:</em> the 20-20-20 rule — every 20 minutes, look at
something about 20 feet away for 20 seconds. Also anti-glare screens, correct
brightness, and an eye test.</li>
<li><strong>Back and neck pain</strong> — from a chair without support, a
screen at the wrong height, or sitting still for hours.</li>
<li><strong>Headaches</strong> — from glare, screen flicker, eye strain and
stress.</li>
<li><strong>Deep vein thrombosis</strong> and general ill health — from sitting
without moving for long periods.</li>
</ul>

<h3>In the exam</h3>
<p>Every question here wants <strong>hazard, cause, prevention</strong> — three
parts. Naming RSI earns one mark; saying what causes it and one practical
prevention earns the other two. Never answer "sit properly" on its own.</p>
""",

"Practical: Spreadsheet": """
<p>The spreadsheet practicals run for most of Terms 2 and 3, so treat this as
the list to work through rather than one hour's worth.</p>

<h3>Formulas and functions</h3>
<ul>
<li>Every formula begins with <code>=</code>. Arithmetic uses
<code>+ - * / ^</code> and brackets, in the usual order of precedence.</li>
<li>Basic functions: <code>SUM</code>, <code>AVERAGE</code>, <code>MAX</code>,
<code>MIN</code>, <code>COUNT</code>, <code>COUNTA</code>,
<code>ROUND</code>.</li>
<li>Conditions: <code>IF</code>, nested <code>IF</code>, <code>COUNTIF</code>,
<code>SUMIF</code>, and <code>AND</code> / <code>OR</code> inside them.
<br><code>=IF(B2&gt;=10,"Pass","Fail")</code></li>
<li>Lookup: <code>VLOOKUP</code> to fetch a value from a table by its key.
<br><code>=VLOOKUP(A2,Grades!$A$2:$B$8,2,TRUE)</code></li>
</ul>

<h3>The single most examined idea: references</h3>
<ul>
<li><strong>Relative</strong> — <code>B2</code>. Copy the formula down and it
becomes B3, B4. This is what you want most of the time.</li>
<li><strong>Absolute</strong> — <code>$B$2</code>. Copy it anywhere and it
still points at B2. Use it for a rate, a constant, or a lookup table.</li>
<li><strong>Mixed</strong> — <code>$B2</code> or <code>B$2</code>. One part
fixed, the other free. This is what makes a multiplication table work from one
formula.</li>
<li>Press F4 to cycle through them.</li>
</ul>

<h3>Build this</h3>
<p>A mark sheet for a class: names, five subjects, total, average, position
using <code>RANK</code>, and a pass/fail column using <code>IF</code>. Then:</p>
<ul>
<li>Format as a table; freeze the header row.</li>
<li><strong>Conditional formatting</strong> so that any mark below 10 turns
red.</li>
<li><strong>Sort</strong> by total descending, then <strong>filter</strong> to
show only those who failed.</li>
<li>A <strong>column chart</strong> of averages by subject, with a title and
axis labels.</li>
<li><strong>Data validation</strong> so a mark outside 0-20 cannot be
entered.</li>
<li>A <strong>what-if</strong> model: change the pass mark in one cell and
watch every pass/fail result change. That is the whole reason a spreadsheet
exists.</li>
</ul>

<h3>In the exam</h3>
<p>You will be shown a formula and asked what it becomes when copied to another
cell. Work it out by moving each relative reference by the same number of rows
and columns as the copy, and leaving anything with a <code>$</code> alone. Then
say why absolute referencing was needed there.</p>
""",

"Social and economic effects on people and organization": """
<p>Answer these questions in balance. Every change listed here has helped
somebody and hurt somebody else, and a one-sided answer scores half.</p>

<h3>Changes to existing methods</h3>
<ul>
<li>Manual, paper methods replaced by electronic ones: ledgers by databases,
filing cabinets by servers, letters by email.</li>
<li>Processing is faster, more accurate, and available all day rather than only
in office hours.</li>
<li>But it depends entirely on power and network. When ENEO cuts and there is
no generator, the paper system that would still have worked is gone.</li>
</ul>

<h3>Changes to products and services</h3>
<ul>
<li>New products that could not exist before: mobile money, streaming,
e-learning, online banking, GPS navigation.</li>
<li>Existing products made better: cars with engine management, phones that are
computers, cameras with no film.</li>
<li>Services delivered at a distance: telemedicine to a village without a
doctor, and a bank account for someone who lives nowhere near a branch.</li>
<li>Customers expect immediate service, so businesses that cannot provide it
lose them.</li>
</ul>

<h3>Changes to the working environment</h3>
<ul>
<li><strong>Teleworking</strong> — working from home over a network. No
commuting, flexible hours, and an employer who needs less office space. Against
that: isolation, no clear line between work and home, and work that follows
you into the evening.</li>
<li>Communication is instant and constant, which raises expectations of
response.</li>
<li>Work is monitored more closely than before: keystrokes, call times,
locations.</li>
<li>New health hazards, which is why ergonomics is on the syllabus.</li>
<li>Continuous retraining, because the tools change every few years.</li>
</ul>

<h3>Changes to employment</h3>
<p>This is where the marks are, so be precise:</p>
<ul>
<li><strong>Jobs lost</strong> — routine and repetitive work is the first to
go. Assembly line workers replaced by robots, filing clerks, typists, telephone
operators, bank tellers replaced by ATMs and apps.</li>
<li><strong>Jobs created</strong> — programmers, network administrators, data
analysts, technicians, web designers, security specialists, and everyone who
maintains the machines.</li>
<li><strong>Jobs changed</strong> — most jobs. A secretary now runs office
software; a mechanic reads engine diagnostics; a teacher prepares digital
resources.</li>
<li><strong>Deskilling and reskilling</strong> — some work needs less skill
than it did, because the machine holds the expertise. Other work needs far
more.</li>
<li>The people who lose the jobs are usually not the people who get the new
ones. Say that: it is the honest heart of the topic.</li>
</ul>

<h3>Economic effects on organisations</h3>
<ul>
<li>Lower running costs after the initial investment; fewer staff for the same
output.</li>
<li>Large purchase and training costs before any benefit appears.</li>
<li>Small businesses can reach national or global customers cheaply.</li>
<li>Competition increases, because customers can compare prices in
seconds.</li>
</ul>

<h3>In the exam</h3>
<p>When asked to "discuss", write both sides and finish with a short judgement.
An answer listing only advantages cannot reach the top band, however many
points it contains.</p>
""",

"System security, reliability and resilience": """
<p>Three words that sound alike and mean different things. Define them apart
and the rest of the answer writes itself.</p>

<div class="def-box"><strong>Security:</strong> protecting a system and its
data from unauthorised access, damage or disruption.
<br><strong>Reliability:</strong> the ability of a system to perform correctly
and consistently over time, without failing.
<br><strong>Resilience:</strong> the ability of a system to keep working, or to
recover quickly, when part of it fails.</div>
<p>Put simply: security keeps attackers out, reliability keeps it from
breaking, resilience keeps it running when something does break.</p>

<h3>How reliability is achieved</h3>
<ul>
<li>Tested hardware and software, with the whole system tested before it goes
live.</li>
<li>Regular maintenance and updates.</li>
<li>Clean, stable power through a UPS, and a controlled environment.</li>
<li>Validation and verification of every input, because bad data crashes more
systems than bad hardware.</li>
<li>Measured by <strong>MTBF</strong>, mean time between failures, and by
availability as a percentage of uptime.</li>
</ul>

<h3>How resilience is achieved</h3>
<ul>
<li><strong>Redundancy</strong> — a spare for anything that would stop the
system: two power supplies, two network links, two servers.</li>
<li><strong>RAID</strong> — data spread or mirrored across several disks so
that one disk can fail without any data being lost.</li>
<li><strong>Failover</strong> — a standby system that takes over automatically
when the main one stops.</li>
<li><strong>Load balancing</strong> — work spread across several servers, so no
single one is critical.</li>
<li><strong>Backups and a disaster recovery plan</strong>, including an
alternative site.</li>
<li>Fault tolerance: the system continues, perhaps more slowly, rather than
stopping.</li>
</ul>

<h3>Safe working practices</h3>
<ul>
<li>Do not use an administrator account for ordinary work.</li>
<li>Lock the screen when you leave the desk.</li>
<li>Do not open unexpected attachments or plug in a flash drive you found.</li>
<li>Follow the backup schedule; do not keep the only copy of anything on a
laptop.</li>
<li>Report anything odd immediately rather than hoping it goes away.</li>
</ul>

<h3>Consequences of system failure</h3>
<ul>
<li><strong>Financial</strong> — lost sales, idle staff, penalties, cost of
recovery.</li>
<li><strong>Data</strong> — records lost or corrupted, and the work of
recreating them.</li>
<li><strong>Operational</strong> — the organisation cannot function. A hospital
without records, a bank with no ATMs.</li>
<li><strong>Reputation</strong> — customers leave and do not come back.</li>
<li><strong>Legal</strong> — breach of data protection law, and the fines and
liability that follow.</li>
<li><strong>Safety</strong> — in a control system, failure can kill. An air
traffic system or a ventilator is not a financial problem.</li>
</ul>

<h3>In the exam</h3>
<p>Grade the consequence to the system in the question. A failure in a school
library system is an inconvenience; the same failure in an aircraft control
system is fatal. Saying that explicitly is what separates a top answer.</p>
""",
"Computer crime and Protection": """
<div class="def-box"><strong>Computer crime:</strong> any illegal act in which
a computer is the target of the crime, or the tool used to commit it.</div>

<h3>The crimes named on the syllabus</h3>
<ul>
<li><strong>Unauthorised access to confidential data</strong> — hacking.
Gaining entry to a system, or to data within it, without permission. It is a
crime whether or not anything is changed; looking is enough.</li>
<li><strong>Fraud</strong> — using a computer to deceive for gain. Altering
payroll records, phishing for bank details, cloning a card, or the advance-fee
messages everyone has received.</li>
<li><strong>Unauthorised copying of copyrighted material</strong> — piracy.
Copying and distributing software, music, film or books without a licence.
Includes installing one licensed copy on twenty machines.</li>
<li><strong>Plagiarism</strong> — presenting another person's work as your own.
Copying from a website into an assignment without citing it. Not always a
criminal offence, but always an academic and professional one.</li>
<li><strong>Illegal storage and use of personal data</strong> — holding data
about people without consent or lawful reason, keeping it after it is needed,
or using it for a purpose it was not collected for. This is what data
protection law exists to stop.</li>
</ul>
<p>Also worth naming: identity theft, denial-of-service attacks, cyberstalking
and harassment, and the deliberate spreading of malware.</p>

<h3>Preventive measures</h3>
<ul>
<li><strong>Physical security</strong> — locked rooms and cabinets, guards,
CCTV, cable locks, secure disposal of old disks. If someone can carry the
server out, nothing else you did matters.</li>
<li><strong>Security codes and passwords</strong> — individual user IDs, strong
passwords, forced expiry, lockout after failed attempts, and no shared
accounts.</li>
<li><strong>Encryption</strong> — data scrambled so that intercepting or
stealing it does not mean reading it. Essential on laptops and on anything
crossing a network.</li>
<li><strong>Biometrics</strong> — fingerprint, iris, face or voice. The
credential cannot be lent, forgotten or written on a note. But it cannot be
changed after a breach, and readers can reject a legitimate user with a cut
finger.</li>
<li><strong>Monitoring access attempts</strong> — audit logs of who logged in,
from where, and what they touched; alerts on repeated failures; regular review
of the logs. Detects the attack you failed to prevent, and provides the
evidence afterwards.</li>
<li>Plus: firewalls, antivirus, prompt patching, access rights by least
privilege, and staff training — because most successful attacks start with a
person, not a machine.</li>
</ul>

<h3>In the exam</h3>
<p>Match the measure to the crime in the question. Against unauthorised access:
passwords, access rights, firewall, monitoring. Against theft of a laptop:
physical security <em>and</em> encryption, because the machine will be stolen
eventually and encryption is what protects the data when it is.</p>
""",

"Natural and software threats to computer systems": """
<p>Threats divide into those that come from nature, those that come from
software, and those that come from people. The syllabus asks for the first
two.</p>

<h3>Natural threats</h3>
<ul>
<li><strong>Fire</strong> — destroys hardware and any backup stored beside it.
Prevention: smoke detectors, gas suppression rather than water, fireproof
safes, and off-site backups.</li>
<li><strong>Flood and water</strong> — a burst pipe or heavy rain. Prevention:
equipment above ground level, raised floors, water sensors, and no server room
under a bathroom.</li>
<li><strong>Lightning and power surges</strong> — very relevant here. A surge
destroys power supplies and disks. Prevention: surge protectors, proper
earthing, a UPS.</li>
<li><strong>Power failure</strong> — data in RAM is lost and disks can be
corrupted mid-write. Prevention: UPS for a clean shutdown, generator for
continuous running, journaling file systems.</li>
<li><strong>Dust, heat and humidity</strong> — a real problem in a Cameroonian
lab. Prevention: air conditioning, filters, regular cleaning.</li>
<li><strong>Earthquake and storm</strong> — prevention is a disaster recovery
plan and a geographically separate backup site.</li>
</ul>

<h3>Software threats — malware</h3>
<div class="def-box"><strong>Malware:</strong> malicious software, written to
damage, disrupt or gain unauthorised access to a computer system.</div>
<ul>
<li><strong>Virus</strong> — attaches itself to another program or file, and
spreads when that host is run or copied. It needs a host and it needs a user
action.</li>
<li><strong>Worm</strong> — spreads by itself across a network, needing no host
file and no user action. That is why worms spread so much faster than viruses,
and why they consume bandwidth.</li>
<li><strong>Trojan horse</strong> — appears to be useful software and does
something malicious once installed. It does not replicate; it relies on the
user choosing to install it. The free game that opens a back door.</li>
<li><strong>Logic bomb</strong> — code that lies dormant until a condition is
met, then acts. A date, a file being deleted, or a name disappearing from the
payroll — the classic case is a programmer who leaves one behind before
resigning.</li>
<li>Also: <strong>spyware</strong>, which records what you do;
<strong>ransomware</strong>, which encrypts your files and demands payment;
<strong>adware</strong>; and <strong>rootkits</strong>, which hide the presence
of everything else.</li>
</ul>

<h3>The distinction the exam wants</h3>
<table>
<tr><th></th><th>Needs a host file</th><th>Self-replicating</th><th>Needs user action</th></tr>
<tr><td>Virus</td><td>Yes</td><td>Yes</td><td>Yes</td></tr>
<tr><td>Worm</td><td>No</td><td>Yes</td><td>No</td></tr>
<tr><td>Trojan</td><td>No</td><td>No</td><td>Yes</td></tr>
<tr><td>Logic bomb</td><td>Usually embedded</td><td>No</td><td>No — waits for a trigger</td></tr>
</table>

<h3>Preventive measures</h3>
<ul>
<li>Antivirus software, kept updated. An out-of-date scanner does not know the
new signatures.</li>
<li>A firewall to block unwanted network traffic.</li>
<li>Patch the operating system and applications promptly — worms exploit known
holes that already have fixes.</li>
<li>Do not open unexpected attachments or links; scan every flash drive.</li>
<li>Install only from trusted sources, which also removes most trojans.</li>
<li>Least privilege, so malware that does run cannot reach the whole
system.</li>
<li>Regular tested backups, kept offline — the only reliable answer to
ransomware.</li>
<li>Train the users. Most infections begin with someone clicking something.</li>
</ul>

<h3>In the exam</h3>
<p>Virus against worm is asked constantly. The virus needs a host file and a
user to run it; the worm spreads itself across the network unaided. One
sentence each.</p>
""",

"Professional, ethical, and moral obligations of users and managers": """
<div class="def-box"><strong>Ethics:</strong> the moral principles that govern
a person's behaviour. <strong>Computer ethics:</strong> the moral principles
governing the use of computers and information technology.</div>
<p>The law says what you <em>must</em> do. Ethics says what you
<em>should</em> do. Something can be perfectly legal and still wrong, and that
gap is the whole subject.</p>

<h3>Obligations of users</h3>
<ul>
<li>Use systems only for authorised purposes, and only within the rights
granted to you.</li>
<li>Respect other people's privacy: do not read what is not yours, even if the
permissions were set carelessly.</li>
<li>Respect intellectual property: licensed software only, and cite the sources
you use.</li>
<li>Do not harm others through the computer — no harassment, no defamation, no
spreading of false information.</li>
<li>Keep your credentials to yourself and follow the security rules.</li>
<li>Be honest about what you have done and about mistakes you have made.</li>
</ul>

<h3>Obligations of managers of computerised information systems</h3>
<p>Managers hold power over other people's data and other people's jobs, so
their duties are heavier.</p>
<ul>
<li><strong>Protect the data they hold.</strong> Adequate security, backups,
and controlled access. The people whose data it is did not choose the
safeguards; the manager did.</li>
<li><strong>Collect only what is needed</strong>, use it only for the stated
purpose, and destroy it when it is no longer needed.</li>
<li><strong>Be accurate.</strong> A wrong record can cost someone a loan, a
job, or a place. Provide a way for people to see and correct their own
data.</li>
<li><strong>Be honest about system capabilities.</strong> Do not claim
accuracy, security or reliability the system does not have.</li>
<li><strong>Consider the effects on staff.</strong> Consult before automating,
retrain where possible, and be honest about job losses rather than presenting
them as efficiency.</li>
<li><strong>Monitor proportionately.</strong> Tell staff what is monitored and
why; do not monitor beyond what the work requires.</li>
<li><strong>Ensure a safe working environment</strong> — ergonomic equipment,
breaks, eye tests.</li>
<li><strong>Comply with the law</strong>, and keep the organisation's policies
current and known.</li>
<li><strong>Maintain professional competence</strong>, in themselves and in
their staff.</li>
</ul>

<h3>The recurring dilemmas</h3>
<ul>
<li>Employee monitoring against employee privacy.</li>
<li>Data useful to the business against data the person did not agree to
share.</li>
<li>Shipping a system on time against shipping it properly tested.</li>
<li>Loyalty to the employer against a duty to the public — which is where
whistleblowing sits.</li>
</ul>

<h3>In the exam</h3>
<p>Given a scenario, name the principle and say what should be done. "The
manager should not read the employee's private email, because the employee has
a reasonable expectation of privacy and the monitoring policy did not cover
personal correspondence." Principle plus action, every time.</p>
""",

"Need for privacy and integrity of personal or sensitive data": """
<div class="def-box"><strong>Privacy:</strong> the right of individuals to
control what information about them is collected, and who may see or use it.
<br><strong>Personal data:</strong> data relating to a living person who can be
identified from it.
<br><strong>Sensitive data:</strong> personal data whose misuse could cause
serious harm — health, religion, ethnicity, political opinion, criminal record,
biometrics.</div>

<h3>Why privacy matters</h3>
<ul>
<li>Misused data causes real harm: identity theft, fraud, blackmail, denial of
a loan or a job.</li>
<li>Sensitive data misused causes discrimination — a health record reaching an
employer, or an ethnicity record reaching the wrong hands.</li>
<li>People who fear being watched behave differently. Privacy protects freedom
of thought and expression, not just money.</li>
<li>Trust: people will not use a service, or will lie to it, if they do not
trust it with their information. That damages the data too.</li>
<li>Data on the internet is permanent, copied instantly, and impossible to
withdraw. A mistake at seventeen is still searchable at forty.</li>
</ul>

<h3>Measures to prevent sharing of personal data on the internet</h3>
<ul>
<li>Check and tighten privacy settings on every social network; the defaults
are set for the platform's benefit, not yours.</li>
<li>Post nothing you would not put on a noticeboard at school. Assume it is
permanent and public.</li>
<li>Never publish full date of birth, home address, ID number, bank details,
timetable or holiday plans.</li>
<li>Strong, different passwords on each account, with two-factor authentication
where offered.</li>
<li>Recognise phishing: no bank asks for your PIN by message, and the urgent
tone is the giveaway.</li>
<li>Look for HTTPS before entering anything; avoid entering credentials over
public Wi-Fi, or use a VPN.</li>
<li>Read what an app asks permission for. A torch app does not need your
contacts.</li>
<li>Turn off location tagging on photographs.</li>
<li>Log out on shared machines, and clear the browser afterwards.</li>
<li>Think about other people's privacy too: do not post photographs of others
without asking.</li>
</ul>

<h3>The need for a standard of conduct</h3>
<p>Why write the rules down at all?</p>
<ul>
<li>It makes the expected behaviour explicit, so nobody can claim they did not
know.</li>
<li>It gives a consistent standard, so decisions do not depend on who is
deciding.</li>
<li>It gives grounds for discipline when the standard is broken.</li>
<li>It protects the individual too: an employee under pressure to do something
improper can point at the code.</li>
<li>It builds trust with customers and with the public, who can see what the
organisation has committed to.</li>
<li>It supports the law rather than replacing it. Where the law is silent, the
standard still applies.</li>
</ul>

<h3>In the exam</h3>
<p>Distinguish personal data from sensitive personal data, and say why the
second category carries stronger protection: the harm from misuse is greater.
That distinction is often worth a mark by itself.</p>
""",

"Requirements of some professional codes of conduct: BCS, IEEE, ACM": """
<p>Three professional bodies, three codes. They overlap heavily, and that
overlap is the point: professional computing has an agreed idea of right
conduct.</p>

<h3>BCS — the British Computer Society</h3>
<p>The chartered institute for IT in the United Kingdom. Its code has four
sections:</p>
<ul>
<li><strong>Public interest</strong> — have due regard for public health,
privacy, security and wellbeing, and for the environment. Have due regard for
the legitimate rights of third parties. Conduct professional activities without
discrimination on grounds of sex, race, disability, age, religion or
nationality.</li>
<li><strong>Professional competence and integrity</strong> — only undertake
work you are competent to do. Keep your knowledge and skill up to date. Do not
claim competence you do not have. Respect and value alternative
viewpoints.</li>
<li><strong>Duty to relevant authority</strong> — act with care and diligence
for your employer or client. Avoid conflicts of interest and declare them when
they arise. Do not misrepresent or withhold information about the performance
of systems, and do not take advantage of a client's lack of knowledge.</li>
<li><strong>Duty to the profession</strong> — uphold the reputation of the
profession, act with integrity towards other members, and encourage the
professional development of others.</li>
</ul>

<h3>ACM — the Association for Computing Machinery</h3>
<p>American, and the most widely quoted code in computing education. It opens
with <strong>general moral imperatives</strong>:</p>
<ul>
<li>Contribute to society and human wellbeing.</li>
<li>Avoid harm to others.</li>
<li>Be honest and trustworthy.</li>
<li>Be fair, and take action not to discriminate.</li>
<li>Honour property rights, including copyrights and patents.</li>
<li>Give proper credit for intellectual property.</li>
<li>Respect the privacy of others.</li>
<li>Honour confidentiality.</li>
</ul>
<p>Then <strong>specific professional responsibilities</strong>: strive for
the highest quality in process and product; maintain professional competence;
know and respect the laws relating to professional work; accept and provide
appropriate professional review; give comprehensive and thorough evaluations of
computer systems and their impacts, including analysis of possible risks;
honour contracts, agreements and assigned responsibilities; improve public
understanding of computing; and access computing resources only when
authorised.</p>

<h3>IEEE — the Institute of Electrical and Electronics Engineers</h3>
<p>An engineering body, so its code has an engineer's emphasis on safety and
honesty about technical fact:</p>
<ul>
<li>Hold paramount the safety, health and welfare of the public, and disclose
promptly any factor that might endanger them.</li>
<li>Avoid real or perceived conflicts of interest, and disclose them when they
exist.</li>
<li>Be honest and realistic in stating claims or estimates based on available
data.</li>
<li>Reject bribery in all its forms.</li>
<li>Improve understanding of technology, its appropriate application, and its
potential consequences.</li>
<li>Maintain and improve technical competence, and undertake tasks only if
qualified by training or experience.</li>
<li>Seek, accept and offer honest criticism of technical work, and credit
properly the contributions of others.</li>
<li>Treat all persons fairly, without discrimination.</li>
<li>Avoid injuring others, their property, reputation or employment by false or
malicious action.</li>
<li>Assist colleagues and co-workers in their professional development.</li>
</ul>

<h3>What all three share</h3>
<p>Four themes, and if you can only remember four things, remember these:
<strong>public interest first; competence — only do what you can do;
integrity and honesty; and respect for others' rights, property and
privacy.</strong></p>

<h3>In the exam</h3>
<p>You will be given a scenario and asked which principle applies. "An engineer
is asked to certify a system he knows is untested." That is honesty in stating
claims, and public safety, and it comes before duty to the employer. Name the
body and the principle, and say what the person should do.</p>
""",

"Legislation and Effects of global communication": """
<p>Ethics is what you should do. Legislation is what you can be prosecuted for.
Four Acts are named on the syllabus; learn what each one prohibits.</p>

<h3>The Computer Misuse Act</h3>
<p>Written to prohibit hacking, because before it existed there was no offence
to charge a hacker with. Three offences, in rising seriousness:</p>
<ul>
<li><strong>Unauthorised access</strong> to computer material. Simply getting
in without permission. Looking is enough.</li>
<li><strong>Unauthorised access with intent</strong> to commit or facilitate a
further offence, such as fraud or blackmail.</li>
<li><strong>Unauthorised modification</strong> of computer material — changing
or deleting data, or introducing a virus.</li>
</ul>
<p>Note that "unauthorised" is the word doing the work. An employee who reads a
file they have no business reading has committed the first offence, even though
they were entitled to be on the system.</p>

<h3>The Copyright, Designs and Patents Act</h3>
<p>Protects the creator of an original work — software, music, film, writing,
images — giving them the exclusive right to copy, distribute and adapt it.</p>
<ul>
<li>Copying software without a licence is an offence, including installing one
licensed copy on several machines.</li>
<li>So is distributing copies, and downloading or streaming from an
unauthorised source.</li>
<li>Copyright is automatic on creation; it does not have to be registered.</li>
<li>A patent protects an invention; a trademark protects a name or logo;
copyright protects the expression of an idea, not the idea itself.</li>
</ul>

<h3>The Health and Safety Act</h3>
<p>Places duties on the employer for the safety of workers, which for computer
users means:</p>
<ul>
<li>Assess the risks of workstations and act on the assessment.</li>
<li>Provide adjustable chairs, suitable screens, adequate lighting and space,
and equipment that meets standards.</li>
<li>Plan work so there are breaks or changes of activity away from the
screen.</li>
<li>Provide eye tests and training on safe use.</li>
<li>The employee has duties too: use the equipment as trained and report
hazards.</li>
</ul>

<h3>Effects of global communication</h3>
<ul>
<li><strong>Positive</strong> — instant contact worldwide; access to
information, education and markets regardless of where you live; families kept
in touch across continents; cheaper and faster trade; faster response to
disasters.</li>
<li><strong>Negative</strong> — the digital divide; the spread of
misinformation as fast as information; loss of local languages and culture;
crime that crosses borders faster than the law can follow; and jurisdiction
problems, because an act legal where the server sits may be illegal where the
victim lives.</li>
</ul>

<h3>In the exam</h3>
<p>Name the correct Act for the offence. Hacking is the Computer Misuse Act.
Copying software is the Copyright, Designs and Patents Act. Misusing personal
data is the Data Protection Act. A poorly set-up workstation is the Health and
Safety Act. Choosing the wrong Act loses the mark however good the
explanation.</p>
""",

"Data protection Act and Global communication Effect": """
<h3>The Data Protection Act 1998, and the 2004 position</h3>
<p>The Act governs the processing of personal data — information about living,
identifiable people. It gives duties to those who hold data, and rights to
those the data is about.</p>

<h3>The principles</h3>
<p>Personal data must be:</p>
<ul>
<li><strong>Processed fairly and lawfully</strong> — the person must know who
holds the data and why.</li>
<li><strong>Obtained for specified, lawful purposes</strong> and not used for
anything incompatible with them. Data collected for a school register may not
be sold to a shop.</li>
<li><strong>Adequate, relevant and not excessive</strong> — collect what the
purpose needs and nothing more.</li>
<li><strong>Accurate and, where necessary, kept up to date</strong> — with
errors corrected promptly.</li>
<li><strong>Not kept for longer than necessary</strong>.</li>
<li><strong>Processed in accordance with the rights of the data
subject</strong>.</li>
<li><strong>Kept secure</strong> against unauthorised access, loss or damage —
technical and organisational measures both.</li>
<li><strong>Not transferred outside the country</strong> unless the
destination provides adequate protection. This is the principle global
communication puts under most strain.</li>
</ul>

<h3>The three roles</h3>
<ul>
<li><strong>Data subject</strong> — the living person the data is about.</li>
<li><strong>Data controller</strong> — the organisation that decides why and
how the data is processed. Legally responsible.</li>
<li><strong>Data processor</strong> — anyone processing it on the controller's
behalf, such as a cloud provider.</li>
</ul>

<h3>Rights of the data subject</h3>
<ul>
<li>To be told whether data about them is held, and to receive a copy — a
subject access request.</li>
<li>To have inaccurate data corrected or erased.</li>
<li>To prevent processing likely to cause damage or distress.</li>
<li>To prevent processing for direct marketing.</li>
<li>To compensation if they suffer damage from a breach.</li>
<li>Not to be subject to a decision made purely by automated processing.</li>
</ul>
<p>There are exemptions — national security, crime prevention and detection,
tax collection — where some of the duties do not apply.</p>

<h3>Distribution of anti-social material</h3>
<p>Material that is illegal or harmful: hate speech, incitement to violence,
terrorist content, images of child abuse, defamation, malicious falsehood.
Publishing it is an offence, and so, generally, is knowingly redistributing
it.</p>
<ul>
<li>Controls: laws against publication, platform moderation and reporting,
filtering, age verification, and prosecution.</li>
<li>Difficulties: the volume is enormous, servers are abroad, anonymity is
easy, and the line between offensive and illegal is not the same in every
country. Removing material also raises free-expression objections.</li>
</ul>

<h3>Effects of global communication</h3>
<ul>
<li><strong>Citizenship</strong> — people organise, campaign and hold
government to account online. Elections and public debate move onto platforms.
Against that: misinformation spreads faster than correction, and foreign actors
can influence a national debate.</li>
<li><strong>Cultural issues</strong> — exposure to other cultures, and the
survival of minority languages online. Against that: cultural homogenisation,
dominant languages and values crowding out local ones, and material that
offends local norms arriving without warning.</li>
<li><strong>The digital divide</strong> — the gap between those with reliable,
affordable access and skills, and those without. It runs between countries,
between town and village, between rich and poor, between old and young, and
between men and women.
<br>It matters because services move online: if government forms, job
applications, banking and schoolwork are online, being offline means being
excluded. The divide reinforces existing inequality rather than reducing
it.
<br>Reducing it needs infrastructure, affordable devices and data, electricity,
digital literacy training, and content in local languages.</li>
</ul>

<h3>In the exam</h3>
<p>You will be given a scenario and asked which data protection principle has
been broken. Practise the mapping: kept ten years after the student left —
"not kept longer than necessary". Sold to an advertiser — "obtained for a
specified purpose". Left on an unencrypted laptop on a bus — "kept secure".</p>
""",

"Architectural requirements of an IS": """
<div class="def-box"><strong>System:</strong> a set of interrelated components
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
add feedback if it asks for a diagram.</p>
""",

"Role of IS in an Organization": """
<h3>Components of an information system</h3>
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
follows.</p>
""",
}
