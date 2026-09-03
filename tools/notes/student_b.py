# -*- coding: utf-8 -*-
"""Student notes for the app. Part B, Lower Sixth lessons 13 to 26."""

from student_a import note, fig, box, short, quiz


note("Lower Sixth", 13, 4,
     "Processing device and the machine instruction cycle",
     ["CPU and GPU", "The machine instruction cycle",
      "Why AI work leans on the GPU"], f"""
<p>The processor does one thing over and over, billions of times a second. It
fetches an instruction, works out what it means, and carries it out. Everything
a computer has ever done is that loop repeated.</p>

<h3>Inside the processor</h3>
<ul>
<li><strong>Control unit.</strong> Fetches instructions, decodes them, and
tells the other parts what to do. It does no arithmetic itself. It
conducts.</li>
<li><strong>Arithmetic and logic unit.</strong> Does the sums and the
comparisons.</li>
<li><strong>Registers.</strong> Very small, very fast stores inside the
processor, each with a defined job.</li>
</ul>

<p>The registers worth knowing are these. The <strong>program counter</strong>
holds the address of the next instruction. The <strong>memory address
register</strong> holds the address being used at this moment. The
<strong>memory data register</strong> holds whatever is travelling to or from
memory. The <strong>current instruction register</strong> holds the instruction
being carried out. The <strong>accumulator</strong> holds the result the
arithmetic unit has just produced.</p>

<h3>The cycle</h3>
{fig("cpu_cycle", "Fetch, decode, execute, store, and round again")}

<p>In <strong>fetch</strong>, the address in the program counter is copied to
the memory address register. The instruction at that address travels back into
the memory data register and then into the current instruction register. The
program counter moves on by one, so it now points at the following
instruction.</p>
<p>In <strong>decode</strong>, the control unit works out what the instruction
means and what data it needs.</p>
<p>In <strong>execute</strong>, the instruction is carried out. The arithmetic
unit does the sum or the comparison, and the result usually lands in the
accumulator.</p>
<p>Where a result has to be kept, it is <strong>stored</strong> back to memory.
Then the cycle begins again.</p>

<h3>Two kinds of processor</h3>
<p>A <strong>CPU</strong> has a few cores, typically four to sixteen, but each
one is powerful. It is built for complicated instructions carried out one after
another. It runs the operating system and the general work of the machine.</p>
<p>A <strong>GPU</strong> has thousands of cores, each simple. It is built to
do the same simple operation on a great many pieces of data at the same moment.
It was designed for graphics, where every pixel on the screen needs the same
treatment.</p>

<h3>Why AI uses the GPU</h3>
<p>Training a neural network is millions of multiplications and additions on
grids of numbers. The important point is that these sums do not depend on one
another, so there is no reason to do them in turn. They can all be done at
once, and that is exactly what a GPU's thousands of cores are for. A job that
would take a CPU several weeks can take a suitable GPU a few hours.</p>

{short(
 "Fetch, decode, execute, and store where a result must be kept.",
 "The program counter holds the address of the next instruction.",
 "A CPU has few powerful cores for work done in turn. A GPU has thousands of "
 "simple cores for work done all at once.",
 "AI training suits a GPU because the sums do not depend on each other.")}

{quiz(
 ("Name the three main parts of the processor and say what each does.",
  "The control unit fetches, decodes and directs. The arithmetic and logic "
  "unit does calculations and comparisons. The registers are small fast stores "
  "holding the instruction and data in use."),
 ("What does the program counter hold, and what happens to it during fetch?",
  "It holds the address of the next instruction. During fetch its contents are "
  "copied to the memory address register, and it then moves on by one."),
 ("Why are GPUs used to train machine learning models?",
  "Because training is very large numbers of independent sums on grids of "
  "numbers, and a GPU's many cores can carry them out at the same time instead "
  "of one after another."))}
""")


note("Lower Sixth", 14, 4,
     "Processor architectures, parallel and distributed computing",
     ["CISC and RISC", "Flynn's four categories",
      "Parallel against distributed computing"], f"""
<p>Three separate ideas sit in this lesson. An argument about how to design an
instruction set, a way of sorting every computer ever built, and the difference
between many processors in one box and many boxes working together. Keep them
apart in your mind.</p>

<h3>CISC and RISC</h3>
<p><strong>CISC</strong> stands for complex instruction set computer. It has
many instructions, some of them elaborate, and each may take several clock
cycles. Programs come out shorter because fewer instructions are needed. Intel
and AMD processors in desktops and laptops work this way.</p>
<p><strong>RISC</strong> stands for reduced instruction set computer. It has
few, simple instructions, each normally taking one cycle. Programs come out
longer, but every step is fast and predictable, and the chip is simpler and uses
less power. ARM processors work this way, which means very nearly every phone
in the world.</p>
<p>The power difference explains why RISC took the mobile world completely. A
phone runs on a battery, and a simpler chip doing predictable single cycle work
uses far less energy.</p>

<h3>Flynn's four categories</h3>
{fig("flynn", "Sorting machines by instruction and data streams")}
<p>Michael Flynn sorted machines by two questions. How many instruction streams
does it handle at once, and how many data streams?</p>
<ul>
<li><strong>SISD.</strong> Single instruction, single data. One instruction
acting on one piece of data. The traditional single core computer.</li>
<li><strong>SIMD.</strong> Single instruction, multiple data. The same
instruction applied to many pieces of data at once. A GPU works this way.</li>
<li><strong>MISD.</strong> Multiple instruction, single data. Several
instructions on the same data. Rare, and used where safety demands that the
same input be checked several ways, as in flight control.</li>
<li><strong>MIMD.</strong> Multiple instruction, multiple data. Independent
processors on independent data. Multi core machines and clusters.</li>
</ul>

<h3>Parallel and distributed computing</h3>
<p><strong>Parallel computing</strong> puts several processors inside one
machine, usually sharing memory and joined by fast internal buses. They work on
parts of one problem and can talk to one another very quickly.</p>
<p><strong>Distributed computing</strong> uses separate computers in different
places, each with its own memory, joined by a network. It is cheaper to build
and easy to grow by adding more machines. The network is slow compared with a
bus, though, and any one machine may drop out in the middle of a job.</p>

{short(
 "CISC has many complex instructions. RISC has few simple ones and uses less "
 "power.",
 "SISD, SIMD, MISD and MIMD sort machines by instruction and data streams.",
 "A GPU is the example of SIMD.",
 "Parallel means several processors in one machine. Distributed means separate "
 "machines on a network.")}

{quiz(
 ("Give two differences between CISC and RISC.",
  "CISC has many complex instructions, each often taking several clock cycles, "
  "while RISC has few simple ones each normally taking a single cycle. RISC "
  "chips are simpler and use less power, which is why phones use them."),
 ("Expand SIMD and give an example.",
  "Single instruction, multiple data. A GPU applying the same operation to "
  "every pixel of an image at the same moment."),
 ("What is the difference between parallel and distributed computing?",
  "Parallel computing uses several processors inside one machine, usually "
  "sharing memory and joined by fast buses. Distributed computing uses "
  "separate machines with their own memory, joined over a network."))}
""")


note("Lower Sixth", 15, 4,
     "Conversion between units of storage and units of processing",
     ["Units of storage", "Units of processing", "Converting between them"],
     f"""
<p>There are two separate ladders here and they are easy to confuse. Storage is
measured in bytes and says how much you can keep. Processing is measured in
hertz and says how fast things happen. They do not convert into one another,
and they do not even step by the same amount.</p>

{fig("units_ladder", "The storage ladder, and the trap at the bottom")}

<h3>Storage</h3>
<p>A <strong>bit</strong> is one binary digit, a nought or a one, and it is the
smallest unit there is. Four bits make a <strong>nibble</strong>. Eight bits
make a <strong>byte</strong>, which holds one character.</p>
<p>After that each step is a multiplication by <strong>1024</strong>. A
kilobyte is 1024 bytes. A megabyte is 1024 kilobytes. A gigabyte is 1024
megabytes. A terabyte is 1024 gigabytes. A petabyte is 1024 terabytes.</p>
<p>The number 1024 appears because the machine counts in twos, and 1024 is two
raised to the power ten. Manufacturers sometimes use 1000 instead, which makes
a disk sound larger. That is why a disk sold as 500 gigabytes shows as about
465 gigabytes when you plug it in. Nothing has been taken from you. Two
different definitions have been used.</p>

<h3>Processing</h3>
<p>One <strong>hertz</strong> is one cycle each second. A kilohertz is 1000
hertz, a megahertz is 1000 kilohertz, and a gigahertz is 1000 megahertz.</p>
<p>Notice that this ladder steps in <strong>1000</strong>, not 1024. A
processor running at 2.4 gigahertz completes 2,400,000,000 cycles every
second.</p>

<h3>How to convert</h3>
<p>Going down the ladder to smaller units, multiply. Going up to larger units,
divide. Two steps means doing it twice. To move between bits and bytes, divide
by eight going up and multiply by eight going down.</p>
<ul>
<li>3 gigabytes to megabytes. Down one step, so multiply. 3 x 1024 = 3072
megabytes.</li>
<li>8192 kilobytes to megabytes. Up one step, so divide. 8192 divided by 1024 =
8 megabytes.</li>
<li>2 gigabytes to kilobytes. Down two steps. 2 x 1024 x 1024 = 2,097,152
kilobytes.</li>
</ul>

<h3>The trap</h3>
<p>Watch the capital letter. A small <strong>b</strong> means a bit. A capital
<strong>B</strong> means a byte. Internet speeds are quoted in megabits each
second while file sizes are in megabytes, and there are eight bits in a byte.
So a connection sold as 16 megabits each second downloads at about 2 megabytes
each second. That is why a 100 megabyte file takes about fifty seconds on
it.</p>

{short(
 "Storage steps in 1024. Processing steps in 1000.",
 "Eight bits make one byte.",
 "Going down the ladder multiply, going up divide.",
 "Small b is a bit and capital B is a byte.")}

{quiz(
 ("Convert 4 gigabytes to megabytes.",
  "4 x 1024 = 4096 megabytes."),
 ("Convert 3,145,728 bytes to megabytes.",
  "3,145,728 divided by 1024 = 3072 kilobytes. 3072 divided by 1024 = 3 "
  "megabytes."),
 ("A file is 24 megabytes and the connection runs at 8 megabits each second. "
  "Roughly how long will it take?",
  "8 megabits each second is 1 megabyte each second, because eight bits make a "
  "byte. So about 24 seconds."))}
""")


note("Lower Sixth", 17, 5, "Application software",
     ["General purpose, specific purpose and tailor made",
      "Common types", "Choosing software for a task"], f"""
<p>Application software is what you open to get something done, as
opposed to the system software running underneath that keeps the machine
alive.</p>

{box("Application software", "programs written to help the user carry out a "
     "particular task, rather than to run the computer itself.")}

<h3>The three kinds</h3>
<ul>
<li><strong>General purpose.</strong> One program, many unrelated uses. A word
processor writes a letter, a report, a story or a shopping list. It is cheap
because the cost is shared across millions of buyers. Word processors,
spreadsheets and browsers are all general purpose.</li>
<li><strong>Specific purpose.</strong> Built for one kind of job, but sold to
many organisations doing that job. Accounting packages, payroll systems, school
management systems, hospital records. It fits better than general purpose
software and costs more.</li>
<li><strong>Tailor made.</strong> Written for one organisation and nobody else.
It fits exactly and the organisation owns it. It is very expensive, it takes a
long time to build, and if the developer disappears there is a problem.</li>
</ul>

<h3>Common types</h3>
<p>A <strong>word processor</strong> handles text documents. A
<strong>spreadsheet</strong> calculates on tables of data. <strong>Presentation
software</strong> makes slides. <strong>Desktop publishing</strong> lays out
pages for print. <strong>Database software</strong> stores and searches
structured records. <strong>Graphics software</strong> handles images and
drawings. A <strong>browser</strong> reaches the web. There are also
communication tools for email and messaging, and now artificial intelligence
assistants.</p>

<h3>Choosing</h3>
<p>Match the software to the shape of the data rather than to whatever you
happen to know already. Numbers that need calculating point to a spreadsheet
rather than a table typed into a word processor. Records that must be searched,
sorted and linked point to a database. Careful control of a printed page points
to desktop publishing. Continuous prose points to a word processor.</p>

{short(
 "General purpose serves many tasks and is cheap. Specific purpose serves one "
 "kind of job. Tailor made serves one organisation.",
 "Tailor made fits exactly, and costs the most in money and in time.",
 "Choose by the shape of the data, not by habit.")}

{quiz(
 ("Give one advantage of general purpose software and one of tailor made "
  "software.",
  "General purpose software is cheap, because its cost is shared across "
  "millions of users. Tailor made software fits the organisation's needs "
  "exactly."),
 ("A hospital needs a system that matches its own unusual admission "
  "procedures, and has a large budget. Which kind should it choose?",
  "Tailor made software, because no ready made package supports procedures "
  "that are unique to that hospital, and the budget can carry the higher "
  "cost."),
 ("Which type of software suits keeping and searching student records?",
  "Database software, because the data is structured records that have to be "
  "stored, searched, sorted and linked to one another."))}
""")


note("Lower Sixth", 18, 5, "System software and examples",
     ["Operating systems, drivers and utilities", "Common utilities",
      "Utilities that use AI"], f"""
<p>System software works for the machine. Application software works for you.
You rarely open system software on purpose, and when it is doing its job
properly you never notice it. You notice it when it fails.</p>

{box("System software", "programs that manage and support the computer system "
     "itself, giving application software a platform to run on.")}

<h3>The three kinds</h3>
<ul>
<li><strong>Operating system.</strong> The master program. It manages memory,
programs, files, devices and users, and it gives you an interface. Windows,
Linux, macOS, Android and iOS.</li>
<li><strong>Device drivers.</strong> Small programs that translate between the
operating system and one particular piece of hardware. The operating system says
print this in general terms, and the driver turns that into the exact signals
that printer understands. Without the right driver a device will not work,
however well it is plugged in.</li>
<li><strong>Utility software.</strong> Small tools that maintain, tidy or
protect the system.</li>
</ul>

<h3>The utilities</h3>
<ul>
<li><strong>Antivirus</strong> finds and removes harmful software.</li>
<li><strong>Disk cleaner</strong> deletes temporary files to recover
space.</li>
<li><strong>Defragmenter</strong> gathers the scattered pieces of files on a
magnetic hard disk so they can be read in fewer movements of the head. It
should never be run on a solid state drive. There is no head to move, so
nothing is gained, and the extra writing shortens the life of the drive.</li>
<li><strong>File management</strong> covers copying, moving, renaming and
searching.</li>
<li><strong>File compression</strong> shrinks files to save space or to send
them faster.</li>
<li><strong>Backup</strong> copies data so it can be recovered.</li>
<li><strong>Firewall</strong> filters traffic coming in and going out.</li>
</ul>

<h3>Where AI has changed the utilities</h3>
<p>Traditional antivirus works by matching files against a list of known
threats, which cannot catch anything new. Antivirus that uses artificial
intelligence watches <strong>behaviour</strong> instead. A program that suddenly
starts encrypting your documents at speed is stopped, even though nobody has
ever seen that particular threat before.</p>
<p>The same idea appears elsewhere. Some systems learn which files you open and
when, and arrange storage so that what you are about to need is already
loaded.</p>

{short(
 "Operating systems, device drivers and utilities are all system software.",
 "A driver translates between the operating system and one device.",
 "Never defragment a solid state drive.",
 "Behaviour based detection catches threats nobody has catalogued yet.")}

{quiz(
 ("What is a device driver and why is it needed?",
  "A small program that translates between the operating system and one "
  "particular piece of hardware, because the operating system cannot know the "
  "exact signals every different device needs."),
 ("Why should a defragmenter not be run on a solid state drive?",
  "A solid state drive has no moving head, so there is no speed to be gained, "
  "and the extra writing shortens the life of the drive."),
 ("What is the difference between a firewall and an antivirus?",
  "A firewall filters network traffic entering and leaving the machine. An "
  "antivirus finds and removes harmful software already on it."))}
""")


note("Lower Sixth", 19, 6, "Notions of the Operating System",
     ["How operating systems grew", "Types of operating system",
      "What an operating system does"], f"""
<p>Without an operating system a computer is a heap of parts that cannot work
together. The operating system turns hardware into something a person and a
program can both use. It is the first thing to load and the last thing to
stop.</p>

{box("Operating system", "the system software that manages the computer's "
     "hardware and software and provides an interface between the user and the "
     "machine.")}

<h3>How it grew</h3>
<p>In the 1950s there was no operating system at all. One job ran at a time,
loaded by hand, and the machine sat idle in between. Batch systems came next,
collecting jobs and running them one after another. Then came time sharing,
switching the processor quickly between users so that each believed they had
the machine to themselves.</p>
<p>UNIX arrived in 1969 and became the ancestor of Linux, macOS, Android and
iOS. MS-DOS arrived in 1981, with a command line, one user and one task at a
time. The graphical interface reached ordinary buyers with the Apple Macintosh
and then Windows. Linux appeared in 1991, free and open. From 2007 iOS and
Android put a full operating system in every pocket.</p>

<h3>Types</h3>
<ul>
<li><strong>Single user, single tasking.</strong> One person, one program.
MS-DOS.</li>
<li><strong>Single user, multitasking.</strong> One person, several programs at
once. Windows on a laptop.</li>
<li><strong>Multi user.</strong> Many people on one machine at the same time,
each with their own session. A server or a mainframe.</li>
<li><strong>Batch.</strong> Jobs are collected and run together with nobody
watching. Payroll overnight.</li>
<li><strong>Online.</strong> The user asks and gets an answer at once. A cash
machine.</li>
<li><strong>Real time.</strong> A guaranteed answer inside a fixed time.
Braking systems, patient monitors, air traffic control. Late is as bad as
wrong.</li>
<li><strong>Network operating system.</strong> Manages a network's shared
resources, users and security.</li>
<li><strong>Embedded.</strong> Built into a device to do one job with very
little memory. A washing machine, a router.</li>
</ul>

<p>Multi user and multitasking are not the same. Multi user means several
people. Multitasking means several programs. A laptop is single user and
multitasking.</p>

<h3>What it does</h3>
{fig("os_functions", "The jobs an operating system carries out")}
<p>It manages programs, deciding what runs and when. It manages memory, giving
each program space and stopping one from overwriting another. It manages files
and folders, and controls who may read them. It drives the hardware through
drivers. It handles security through accounts and passwords. It provides the
interface. And it detects and reports errors.</p>

{short(
 "The operating system manages hardware and software and gives the user an "
 "interface.",
 "Real time systems must answer inside a guaranteed time.",
 "Multi user means several people. Multitasking means several programs.",
 "Its jobs are processes, memory, files, devices, security, interface and "
 "errors.")}

{quiz(
 ("A ventilator must respond to a change in a patient's breathing inside a "
  "fixed time. What type of operating system does it need?",
  "A real time operating system, because it must guarantee a response within a "
  "set deadline."),
 ("What is the difference between multi user and multitasking?",
  "Multi user means several people use the system at the same time, each with "
  "their own session. Multitasking means several programs run at the same "
  "time."),
 ("Name five things an operating system does.",
  "Any five of managing programs, managing memory, managing files, managing "
  "devices, security, providing the user interface, and handling errors."))}
""")


note("Lower Sixth", 20, 6, "Functions of an operating system 1",
     ["Pre-emptive and non pre-emptive scheduling",
      "FCFS, SJF, SRT and round robin", "AI in scheduling"], f"""
<p>One processor, and many programs all wanting it. Scheduling is how the
operating system decides who gets it and for how long. It is the reason a
machine feels quick or feels as though it has stopped listening to you.</p>

<h3>Two approaches</h3>
<p>Under <strong>non pre-emptive</strong> scheduling, once a program has the
processor it keeps it until it finishes or stops to wait for something. This is
simple to build, but one long job holds everybody up.</p>
<p>Under <strong>pre-emptive</strong> scheduling, the operating system can take
the processor away and give it to another program. This is harder to build,
because the state of the interrupted program has to be saved and restored, but
it is fair. It is what lets you move the mouse while a large file is
copying.</p>

<h3>The four methods</h3>
<ul>
<li><strong>First come first served.</strong> Non pre-emptive. Whoever arrived
first runs first, to the end. It is completely fair in order of arrival, but a
long job at the front makes everybody behind it wait. That effect has a name.
It is the <strong>convoy effect</strong>.</li>
<li><strong>Shortest job first.</strong> Non pre-emptive. Run the shortest job
next. This gives the best average waiting time of any method. Its faults are
that long jobs may never run at all, which is called
<strong>starvation</strong>, and that it needs to know how long each job will
take before running it, which you usually cannot.</li>
<li><strong>Shortest remaining time.</strong> The pre-emptive version of
shortest job first. If a new job arrives needing less time than is left of the
running one, it takes over.</li>
<li><strong>Round robin.</strong> Pre-emptive. Each program gets a fixed slice
of time, called the <strong>time quantum</strong>, then goes to the back of the
queue. It is fair, nothing starves, and it suits interactive work. If the
quantum is too small the machine wastes time switching. If it is too large the
method behaves like first come first served.</li>
</ul>

<h3>Working out waiting time</h3>
{fig("gantt", "First come first served, drawn as a Gantt chart")}
<p>Draw the chart first, then read the waiting times off it. Waiting time is
the start time minus the arrival time. In the chart above, P3 needed only one
unit of time and waited seven, because P1 sat in front of it with six units to
run. That is the convoy effect made visible.</p>

<h3>Where AI comes in</h3>
<p>Shortest job first has the best average waiting time, but it needs something
you cannot normally have, which is knowledge of how long a job will take before
it runs. A machine learning model can predict that from the behaviour of similar
jobs in the past. So a modern scheduler can come close to shortest job first
without being told anything. Some schedulers also learn a user's habits and
give priority to the programs they are about to open.</p>

{short(
 "Non pre-emptive means a program keeps the processor until it finishes. "
 "Pre-emptive means the system can take it away.",
 "First come first served suffers the convoy effect.",
 "Shortest job first gives the best average wait but can starve long jobs.",
 "Waiting time is start time minus arrival time.")}

{quiz(
 ("What is the convoy effect and which method suffers from it?",
  "When a long job at the front of the queue forces all the shorter ones "
  "behind it to wait, raising the average waiting time. It affects first come "
  "first served."),
 ("Explain the trade off in choosing a time quantum for round robin.",
  "Too small and the system wastes time switching between programs. Too large "
  "and it behaves like first come first served, losing the quickness that "
  "round robin exists to give."),
 ("Two jobs arrive. P1 at time 0 needing 4 units, P2 at time 1 needing 2. "
  "Under first come first served, what is the average waiting time?",
  "P1 starts at 0 and waits 0. P2 starts at 4 and waits 4 minus 1, which is 3. "
  "The average is 1.5 units."))}
""")


note("Lower Sixth", 21, 6, "Functions of the operating system 2",
     ["Managing memory, files and devices",
      "Deallocation, virtual memory, buffering, spooling, metadata"], f"""
<p>Scheduling shares out the processor. This lesson is about sharing out
everything else, which means memory, storage and the devices.</p>

<h3>Managing memory</h3>
<p>The operating system gives each program the memory it needs when it starts,
and takes it back when the program ends. Taking it back is called
<strong>deallocation</strong>. A program that fails to release memory it no
longer needs causes a <strong>memory leak</strong>. Free memory shrinks
steadily, the machine slows, and in the end it has to be restarted.</p>
<p>The system also keeps programs apart, so that one cannot read or overwrite
another's memory, whether by accident or on purpose.</p>

<h3>Virtual memory</h3>
{box("Virtual memory", "an area of secondary storage used as though it were "
     "RAM, so that programs larger than the physical memory can still run. "
     "Pages are swapped between disk and RAM as they are needed.")}

{fig("virtual_memory", "Pages moving between RAM and disk")}

<p>Virtual memory is why a machine with four gigabytes of RAM can have more
than four gigabytes of programs open. It is also why such a machine crawls when
memory runs short, because disk is thousands of times slower than RAM. When the
system spends more time swapping pages than doing useful work, that is called
<strong>thrashing</strong>. The cure is more RAM or fewer open programs.</p>

<h3>Managing files</h3>
<p>The operating system arranges storage into files and folders and keeps the
directory that records where everything actually sits. It controls who may
read, write or run each file. And it holds the <strong>metadata</strong>, which
means data about the data. A file's name, size, type, owner, dates and
permissions are all metadata.</p>

<h3>Managing devices</h3>
{fig("buffer_spool", "Buffering and spooling compared")}
<p><strong>Buffering</strong> uses a small area of memory to hold data
temporarily while it moves between two things running at different speeds. A
video buffers because the network delivers unevenly while the screen needs a
steady stream.</p>
<p><strong>Spooling</strong> puts whole jobs in a queue on disk and feeds them
to a slow device as it becomes free. This is why you can send five documents to
one printer and go straight back to work.</p>
<p>Both stop a slow device holding up a fast processor. A buffer sits in memory
and handles one flowing stream. A spool sits on disk and handles a queue of
whole jobs.</p>

{short(
 "Deallocation means giving memory back. Failing to do it causes a memory "
 "leak.",
 "Virtual memory borrows disk space and uses it as though it were RAM.",
 "Metadata is data about data, such as a file's size and date.",
 "A buffer is in memory for one stream. A spool is on disk for a queue of "
 "jobs.")}

{quiz(
 ("Define virtual memory and give one drawback.",
  "An area of secondary storage used as though it were RAM, so programs larger "
  "than physical memory can run. Its drawback is that disk is far slower than "
  "RAM, so heavy use of it slows the machine badly."),
 ("What is a memory leak?",
  "When a program fails to give back memory it no longer needs, so free memory "
  "falls steadily until the machine slows or must be restarted."),
 ("Give the difference between buffering and spooling.",
  "Buffering holds a flowing stream of data in memory while it passes between "
  "devices of different speeds. Spooling puts whole jobs in a queue on disk to "
  "be fed to a slow device as it becomes free."))}
""")


note("Lower Sixth", 22, 6,
     "Installing an operating system and user interfaces",
     ["Installing Windows or Linux", "Graphical and command line interfaces",
      "Choosing an interface"], f"""
<p>This lesson is done at the machine. By the end of it you should have
installed an operating system, or watched it done step by step, and be able to
say why a server administrator prefers a command line while a beginner needs a
graphical one.</p>

<h3>Installing, in order</h3>
<ol>
<li><strong>Check the requirements.</strong> Processor, memory, free disk
space, and whether the machine is 32 bit or 64 bit.</li>
<li><strong>Back up everything already on the machine.</strong> Installing
usually destroys what is there.</li>
<li><strong>Make bootable media.</strong> A USB drive written with the
installation image.</li>
<li><strong>Set the boot order</strong> in the BIOS or UEFI, so the machine
starts from the USB and not from the hard disk.</li>
<li><strong>Partition and format the disk.</strong></li>
<li><strong>Copy the system files</strong> and let the installer work. The
machine restarts, usually more than once.</li>
<li><strong>Set it up.</strong> Language, keyboard, time zone, computer name,
user account and password.</li>
<li><strong>Install drivers</strong>, then run the updates.</li>
<li><strong>Install your applications</strong> and restore the data you backed
up at step two.</li>
</ol>

<h3>The two interfaces</h3>
<p>A <strong>graphical user interface</strong> uses windows, icons, menus and a
pointer. You choose from what is shown. It is easy to learn because the options
are visible, and there is nothing to memorise. It uses more memory and
processing to draw the display, it is slower for repeated work, and it can only
do what somebody put a button on.</p>
<p>A <strong>command line interface</strong> takes typed commands. It is very
fast in trained hands, uses almost no resources, and can be written into a
script so that a job repeats exactly. Against that, you have to know the
commands, a typing mistake can destroy something immediately, and it is
unfriendly to a beginner.</p>

<h3>Choosing</h3>
<p>A school computer room, or any beginner, needs a graphical interface. A
server administrator looking after forty machines needs a command line, because
the work is repetitive and can be scripted. A server in a data centre often has
no screen at all, so a command line is the only option. And working over a slow
connection strongly favours the command line, because text needs a tiny
fraction of the bandwidth a screen image needs.</p>

{short(
 "Back up before you install. Installing normally wipes the disk.",
 "A graphical interface is easy to learn and heavier on resources.",
 "A command line is fast, light, and can be scripted.",
 "Choose by who is using it, what the work is, and what connection is "
 "available.")}

{quiz(
 ("Why must data be backed up before an operating system is installed?",
  "Because installing normally partitions and formats the disk, destroying "
  "everything already stored on it."),
 ("Give two advantages of a command line interface.",
  "It can be written into a script so repeated jobs run exactly the same way "
  "every time, and it uses far fewer resources than a graphical interface."),
 ("A company manages fifty servers with no monitors, over a slow connection. "
  "Which interface suits them?",
  "A command line, because the servers have no display hardware, text needs "
  "very little bandwidth, and work repeated across fifty machines can be "
  "scripted."))}
""")


note("Lower Sixth", 23, 7, "Using the GUI of an operating system",
     ["Files, folders and file formats", "Working with files and folders",
      "Keeping other people out"], f"""
<p>This lesson is done at the machine. Most of what follows you have probably
done out of habit. The point today is to be able to name it, say why it works
that way, and set a machine up so that other people cannot read your work.</p>

<h3>Three words</h3>
<p>A <strong>file</strong> is a named collection of related data held in
storage. A <strong>folder</strong> is a container that arranges files and other
folders into a tree. A <strong>file format</strong> is the way the data inside
is arranged, shown by the <strong>extension</strong> at the end of the name.
The extension tells the operating system which program should open the
file.</p>
<p>Common ones are .docx for a Word document, .xlsx for a spreadsheet, .pptx
for a presentation, .pdf for a fixed layout document, .txt for plain text, .jpg
and .png for pictures, .mp3 for audio, .mp4 for video, and .zip for a
compressed archive.</p>

<h3>What you can do</h3>
<ul>
<li><strong>Create.</strong> Right click, New, then choose the type.</li>
<li><strong>Rename.</strong> Select and press F2. Keep the extension unless you
mean to change the format.</li>
<li><strong>Copy and paste.</strong> Ctrl+C then Ctrl+V. The original
stays.</li>
<li><strong>Cut and paste.</strong> Ctrl+X then Ctrl+V. The original
moves.</li>
<li><strong>Delete.</strong> The Delete key sends it to the Recycle Bin, which
can be undone. Shift and Delete together remove it with no safety net.</li>
<li><strong>Search</strong> by name, type, size or date.</li>
<li><strong>Compress.</strong> Right click, Send to, Compressed folder. The
result is smaller and travels as one item.</li>
<li><strong>Properties</strong> shows the metadata. Size, dates, permissions,
and which program opens it.</li>
</ul>

<h3>Keeping other people out</h3>
<ol>
<li>Give every user their own account. A shared account means shared files and
nobody accountable.</li>
<li>Put a strong password on each one, and require it at startup.</li>
<li>Turn on the screen lock after a few minutes idle. Windows and L together
locks it at once.</li>
<li>Use a standard account for daily work and an administrator account only
when installing software. Harmful software gets the rights of whoever is logged
in.</li>
<li>Set folder permissions so each user reaches only their own work.</li>
<li>Turn on the firewall and leave updates running.</li>
</ol>

<h3>Try this</h3>
<p>Build a folder tree for your own subjects, three levels deep, and put a file
in each. Compress the whole tree and note the size before and after. Then create
a second user account, log into it, and check that it cannot open your files.
That last step is the one that proves you understood the lesson.</p>

{short(
 "A file holds data. A folder arranges files. The extension says which program "
 "opens it.",
 "Copy duplicates. Cut moves.",
 "Shift and Delete skips the Recycle Bin.",
 "Separate accounts with passwords are the first defence.")}

{quiz(
 ("What is the purpose of a file extension?",
  "It shows the file's format and tells the operating system which program "
  "should open it."),
 ("What is the difference between Delete and Shift with Delete?",
  "Delete moves the file to the Recycle Bin where it can be restored. Shift "
  "with Delete removes it without putting it there."),
 ("Why should daily work be done from a standard rather than an administrator "
  "account?",
  "Because harmful software runs with the rights of whoever is logged in, so "
  "an infection caught on a standard account can do far less damage."))}
""")


note("Lower Sixth", 24, 7, "Using the CLI of an operating system",
     ["Opening a command line", "Working with files and folders",
      "Writing a script"], f"""
<p>The command line looks unfriendly and is far more powerful than the windows
you are used to. The reason is simple. Anything you can type, you can put in a
file and have repeated exactly, a thousand times, while you are not even
there.</p>

<h3>Getting there</h3>
<p>In Windows, press the Windows key and R together, type cmd and press Enter.
In Linux, press Ctrl, Alt and T together, or find Terminal in the menu.</p>

<h3>The commands</h3>
<ul>
<li><strong>List what is here.</strong> <code>dir</code> in Windows,
<code>ls</code> in Linux.</li>
<li><strong>Change folder.</strong> <code>cd name</code> in both.
<code>cd ..</code> goes up one level.</li>
<li><strong>Where am I.</strong> <code>cd</code> alone in Windows,
<code>pwd</code> in Linux.</li>
<li><strong>Make a folder.</strong> <code>mkdir name</code> in both.</li>
<li><strong>Remove a folder.</strong> <code>rmdir name</code>.</li>
<li><strong>Copy a file.</strong> <code>copy a b</code> in Windows,
<code>cp a b</code> in Linux.</li>
<li><strong>Move or rename.</strong> <code>move</code> or <code>ren</code> in
Windows, <code>mv</code> in Linux.</li>
<li><strong>Delete a file.</strong> <code>del name</code> in Windows,
<code>rm name</code> in Linux.</li>
<li><strong>Show a file.</strong> <code>type name</code> in Windows,
<code>cat name</code> in Linux.</li>
<li><strong>Clear the screen.</strong> <code>cls</code> or
<code>clear</code>.</li>
</ul>

<h3>Writing a script</h3>
<p>A script is a text file holding commands, run in order. In Windows save it
with a .bat ending. In Linux save it with .sh, put <code>#!/bin/bash</code> on
the first line, and make it runnable with <code>chmod +x</code>.</p>
<p>Here is a Windows script that makes a folder and copies your documents into
it.</p>
<pre><code>@echo off
rem Back up documents to the D drive
mkdir D:\\Backup
copy C:\\Users\\Student\\Documents\\*.docx D:\\Backup
echo Backup completed
pause</code></pre>
<p>Taking it line by line. <code>@echo off</code> stops each command being
printed as it runs. <code>rem</code> marks a comment for a human reader.
<code>mkdir</code> creates the destination. <code>copy</code> with the wildcard
<code>*.docx</code> copies every Word document. <code>echo</code> reports
success, and <code>pause</code> holds the window open so you can read it.</p>

<h3>The danger</h3>
<p>There is no Recycle Bin on the command line. <code>del</code> and
<code>rm</code> remove the file at once and for good. Read the line before you
press Enter, and read it twice when it holds a wildcard, because the star means
everything that matches and it will not ask you again.</p>

{short(
 "dir and ls list. copy and cp copy. del and rm delete.",
 "A script is a text file of commands that runs them in order.",
 "Scripting is the real advantage of the command line.",
 "There is no Recycle Bin here. Deleting is final.")}

{quiz(
 ("Give the Windows and Linux commands to list the contents of a folder.",
  "dir in Windows and ls in Linux."),
 ("What does a script let you do that clicking cannot?",
  "It records a sequence of commands so the whole job can be repeated exactly, "
  "automatically, without anybody present."),
 ("Why is deleting from the command line more dangerous than deleting in the "
  "graphical interface?",
  "Because the file is removed at once and for good, with no Recycle Bin and "
  "no confirmation, so a mistyped command cannot be undone."))}
""")


note("Lower Sixth", 25, 7, "Hardware faults identification and correction",
     ["Preventive and corrective maintenance", "Common hardware faults",
      "How to prevent them"], f"""
<p>Machines fail. The only question is whether they fail on a day you chose or
on a day that destroys the work of a term. Maintenance is how you choose.</p>

<h3>Three terms</h3>
<p><strong>Computer maintenance</strong> is the work of keeping a system
running properly. <strong>Preventive maintenance</strong> is done before
anything breaks, to stop it breaking. Cleaning, checking, tightening, updating.
<strong>Corrective maintenance</strong> is done after a fault, to put it right.
Diagnosing, repairing or replacing.</p>

<h3>Common faults</h3>
<ul>
<li><strong>The machine will not switch on.</strong> A faulty power supply, a
loose cable, or a dead socket. Check the simple things first. Is it plugged in,
is the switch on, does another device work in that socket?</li>
<li><strong>It overheats and shuts down.</strong> Fans blocked with dust, a fan
that has stopped, or dried thermal paste. Blow out the dust, check every fan
turns, keep the vents clear, and never stand a laptop on a bed.</li>
<li><strong>Blue screens and random restarts.</strong> Usually faulty memory.
Reseat the modules and test them one at a time.</li>
<li><strong>A clicking noise from the disk and files going missing.</strong>
The disk is failing. Back up at once, then replace it. A clicking disk gives you
one warning.</li>
<li><strong>No display.</strong> A loose or wrong cable, a dead monitor, or a
failed graphics card. Try another monitor before condemning the machine.</li>
<li><strong>The clock resets every time.</strong> The small battery on the
motherboard is flat. It is a coin cell and costs very little.</li>
</ul>

<h3>Preventing them</h3>
<p>Clean dust from fans and vents on a schedule, because dust is the commonest
cause of hardware failure. Use an uninterruptible power supply, or at the very
least a surge protector, because our mains supply is not gentle and a surge
kills power supplies and motherboards. Keep machines off the floor and out of
direct sun. Shut down properly rather than pulling the plug. Hold components by
their edges, because static electricity destroys chips silently. Keep drinks
away from keyboards.</p>

{short(
 "Preventive maintenance happens before the fault. Corrective happens after.",
 "Dust and heat cause most hardware failures.",
 "A clicking hard disk means back up now.",
 "A surge protector is the most useful single precaution here.")}

{quiz(
 ("Give the difference between preventive and corrective maintenance.",
  "Preventive maintenance is carried out before a fault happens, to stop it "
  "happening. Corrective maintenance is carried out afterwards, to repair the "
  "fault."),
 ("A computer shuts down by itself after twenty minutes. What is the likely "
  "cause and what should be done?",
  "Overheating, most likely from dust blocking the fans or vents. Clean out "
  "the dust, check the fans are turning, and make sure the vents are clear."),
 ("A hard disk starts making a clicking noise. What should be done first?",
  "Back up the data at once, because a clicking disk is close to complete "
  "failure and may not last long."))}
""")


note("Lower Sixth", 26, 7, "Software faults identification and correction",
     ["Hardware against software maintenance", "Common software faults",
      "A method for finding the cause"], f"""
<p>If the fault follows the machine, suspect hardware. If it follows the
program or the file, suspect software. That single test saves hours, and it is
the first thing a technician does.</p>

<h3>The difference</h3>
<p><strong>Hardware maintenance</strong> deals with physical parts. Cleaning,
replacing, checking connections. It needs tools and often a spare part.
<strong>Software maintenance</strong> deals with programs and settings.
Updating, patching, reinstalling, reconfiguring, removing harmful software. It
needs no screwdriver and can often be done from somewhere else entirely.</p>

<h3>Common faults</h3>
<ul>
<li><strong>The machine is very slow.</strong> Too many programs starting with
Windows, a full disk, harmful software, or too little memory for what is open.
Open the task manager first and see what is actually using the machine.</li>
<li><strong>A program freezes or closes itself.</strong> A bug, a damaged
installation, or a clash with another program. Update it, then repair or
reinstall it.</li>
<li><strong>The system will not start.</strong> Damaged system files, a failed
update, or an infection. Use safe mode, or a recovery disc.</li>
<li><strong>A file will not open.</strong> The file is damaged, the right
program is missing, or the extension is wrong.</li>
<li><strong>A device stops working after an update.</strong> A driver clash.
Roll the driver back to the earlier version.</li>
<li><strong>Pop-ups and a changed home page.</strong> Harmful software. Scan
with an up to date antivirus, in safe mode if you need to.</li>
</ul>

<h3>A method</h3>
<ol>
<li>Ask what changed just before the fault appeared. New software, an update, a
new device? That is usually the cause.</li>
<li>Change one thing at a time and watch. Changing three at once tells you
nothing about which one mattered.</li>
<li>Separate the two possibilities. Try the same file on another machine, and
another file on the same machine. One of those tells you whether the fault is
in the data or in the system.</li>
<li>Check the simplest explanation first. Is it plugged in, is it logged in, is
the disk full?</li>
<li>Write down what you did, so that if it happens again you are not starting
from nothing.</li>
</ol>

<h3>Preventing them</h3>
<p>Install only from trusted sources. Keep the system and the applications
updated, because most patches close holes that are already being used against
people. Run an antivirus and keep it current. Back up regularly, which is the
one remedy that works for every software fault there is. Create a restore point
before installing anything large. And do not install five programs that do the
same job, because they will fight.</p>

{short(
 "Hardware maintenance is physical. Software maintenance is not.",
 "Ask what changed just before the fault appeared.",
 "Change one thing at a time.",
 "Backup is the remedy that covers every software fault.")}

{quiz(
 ("A document will not open on your machine. How would you find out whether "
  "the fault is in the file or in the program?",
  "Try the same file on another machine, and try a different file of the same "
  "type in the same program. If the file fails everywhere it is damaged. If "
  "only that program fails, the program is at fault."),
 ("A device stops working straight after a system update. What is the likely "
  "cause and the remedy?",
  "A faulty or unsuitable driver installed by the update. Roll the driver back "
  "to the previous version."),
 ("Why is regular backup called the remedy that always works?",
  "Because whatever goes wrong, whether damage, infection, a failed update or "
  "an accidental deletion, a recent backup lets the data be restored."))}
""")
