-- Part D of 7 — notes 3 of 5: File and Data Security → Data protection Act and Global communication Effect.
-- Run the parts in alphabetical order, one at a time.
-- Safe to run again if you lose your place.

BEGIN;

-- 15 notes
INSERT INTO note_sections
  (id, note_source_id, chapter_number, title, body, body_format, sequence)
VALUES
  ('c60d757d-24e8-5da2-be0e-51e3f4d7e6f8', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'File and Data Security', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Backup, transaction logs, archive files, data integrity, access right management, physical protection, disaster planning, user id, passwords, encryption</li></ul></div><p>Data is usually worth more than the machine it sits on. A stolen laptop
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
structure alone reads as a stronger answer.</p>', 'html', 35),
  ('1414d3b8-ee86-5ec2-9fe8-a5fbcf9cebba', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'File compression', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Compression methods and file systems</li><li>Advantages of compressing a file</li></ul></div><div class="def-box"><strong>File compression:</strong> encoding data so that
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
discarded sound cannot be recovered.</p>', 'html', 36),
  ('268feeb2-8a38-5bb9-9bab-958abd5bacc9', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'File Format', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Importance of file formats and popular file formats</li><li>Bitmap e.g. JPEG, TIFF, GIF</li><li>Vector e.g. PNG, CGM, EPS, SVG</li></ul></div><div class="def-box"><strong>File format:</strong> the particular way in which
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
<li><strong>EPS</strong> — Encapsulated PostScript. The printing industry''s
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
quality is not noticeable on screen" is the full answer.</p>', 'html', 37),
  ('a56c03df-3eff-59a1-a98f-ff910f2c7e55', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'File Format (continued)', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Sound e.g. WAV, MP3, MP4</li><li>Video e.g. AVI, MPEG; text e.g. PDF, DOC</li><li>Common application file formats e.g. database (DBF, MDB), spreadsheet (XLS)</li><li>Hypermedia e.g. HTML, SGML, XML</li></ul></div><h3>Sound formats</h3>
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
against user-defined tags for data. Say both halves.</p>', 'html', 38),
  ('98256703-ddd4-57bf-9a3d-aa6bc5c60ab9', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Ergonomics', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Explain ergonomics</li><li>Notion of good and comfortable working environment for computer users</li><li>Computer related health hazards (RSI, CTS, eye strain) and preventive measures</li></ul></div><div class="def-box"><strong>Ergonomics:</strong> the study of designing
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
    <text x="440" y="150">arm''s length away</text>
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
<li><strong>Desk</strong> — enough depth for the screen at arm''s length, and
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
prevention earns the other two. Never answer "sit properly" on its own.</p>', 'html', 39),
  ('6028e7ba-5851-559c-ac76-33a9abc9ebf6', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Practical: Spreadsheet', '<p>The spreadsheet practicals run for most of Terms 2 and 3, so treat this as
the list to work through rather than one hour''s worth.</p>

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
say why absolute referencing was needed there.</p>', 'html', 40),
  ('b167d6e7-8c18-5136-9b8b-63ffcf491410', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Social and economic effects on people and organization', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Changes to existing methods, products, services, working environment, employment</li></ul></div><p>Answer these questions in balance. Every change listed here has helped
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
points it contains.</p>', 'html', 41),
  ('6260551b-34b7-581d-92a7-2e7256bc9af1', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'System security, reliability and resilience', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Explain system security, reliability, and resilience</li><li>The importance of safe working practices, privacy and data integrity</li><li>Identify the consequence of system failure</li></ul></div><p>Three words that sound alike and mean different things. Define them apart
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
system is fatal. Saying that explicitly is what separates a top answer.</p>', 'html', 42),
  ('69583735-2a8c-5617-a44b-601068798c69', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Computer crime and Protection', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Unauthorized access to confidential data, frauds, unauthorized copying of copyrighted materials, plagiarism, illegal storage and use of personal data</li><li>Preventive measures: physical security, security codes, password, encryption, biometrics, monitoring access attempts</li></ul></div><div class="def-box"><strong>Computer crime:</strong> any illegal act in which
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
<li><strong>Plagiarism</strong> — presenting another person''s work as your own.
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
eventually and encryption is what protects the data when it is.</p>', 'html', 43),
  ('801c60cf-7b85-58ed-b97d-57b54f0cec88', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Natural and software threats to computer systems', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Natural threats (fire, flood)</li><li>Software threats: malware, virus, worm, trojan horse, logic bomb</li><li>Preventive measures</li></ul></div><p>Threats divide into those that come from nature, those that come from
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
sentence each.</p>', 'html', 44),
  ('a9372d74-f23f-5e90-8f99-1b522c5107f1', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Professional, ethical, and moral obligations of users and managers', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Describe the ethical and moral obligations of users and managers of computerized information systems</li></ul></div><div class="def-box"><strong>Ethics:</strong> the moral principles that govern
a person''s behaviour. <strong>Computer ethics:</strong> the moral principles
governing the use of computers and information technology.</div>
<p>The law says what you <em>must</em> do. Ethics says what you
<em>should</em> do. Something can be perfectly legal and still wrong, and that
gap is the whole subject.</p>

<h3>Obligations of users</h3>
<ul>
<li>Use systems only for authorised purposes, and only within the rights
granted to you.</li>
<li>Respect other people''s privacy: do not read what is not yours, even if the
permissions were set carelessly.</li>
<li>Respect intellectual property: licensed software only, and cite the sources
you use.</li>
<li>Do not harm others through the computer — no harassment, no defamation, no
spreading of false information.</li>
<li>Keep your credentials to yourself and follow the security rules.</li>
<li>Be honest about what you have done and about mistakes you have made.</li>
</ul>

<h3>Obligations of managers of computerised information systems</h3>
<p>Managers hold power over other people''s data and other people''s jobs, so
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
<li><strong>Comply with the law</strong>, and keep the organisation''s policies
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
manager should not read the employee''s private email, because the employee has
a reasonable expectation of privacy and the monitoring policy did not cover
personal correspondence." Principle plus action, every time.</p>', 'html', 45),
  ('3e47042a-7da4-5dd3-861f-a3a217433993', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Need for privacy and integrity of personal or sensitive data', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Measures to prevent sharing of personal data on the internet</li><li>Explain the need for standard of conduct</li></ul></div><div class="def-box"><strong>Privacy:</strong> the right of individuals to
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
are set for the platform''s benefit, not yours.</li>
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
<li>Think about other people''s privacy too: do not post photographs of others
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
That distinction is often worth a mark by itself.</p>', 'html', 46),
  ('38a81452-f821-5707-ac21-adb3987bd8ff', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Requirements of some professional codes of conduct: BCS, IEEE, ACM', '<p>Three professional bodies, three codes. They overlap heavily, and that
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
of systems, and do not take advantage of a client''s lack of knowledge.</li>
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
<p>An engineering body, so its code has an engineer''s emphasis on safety and
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
integrity and honesty; and respect for others'' rights, property and
privacy.</strong></p>

<h3>In the exam</h3>
<p>You will be given a scenario and asked which principle applies. "An engineer
is asked to certify a system he knows is untested." That is honesty in stating
claims, and public safety, and it comes before duty to the employer. Name the
body and the principle, and say what the person should do.</p>', 'html', 47),
  ('0a87a2a3-71f7-50a8-8f9a-da518d329aee', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Legislation and Effects of global communication', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Explain laws to prohibit hacking, copying of copyrighted material and storage of personal data</li></ul></div><p>Ethics is what you should do. Legislation is what you can be prosecuted for.
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
explanation.</p>', 'html', 48),
  ('c44cf5a0-5777-5e52-a812-039111d1b584', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Data protection Act and Global communication Effect', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Data protection act of 2004 (UK) and distribution of anti-social materials</li><li>Effects of global communication on citizenship, cultural issues, and digital divide</li></ul></div><h3>The Data Protection Act 1998, and the 2004 position</h3>
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
<li><strong>Data processor</strong> — anyone processing it on the controller''s
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
specified purpose". Left on an unencrypted laptop on a bus — "kept secure".</p>', 'html', 49)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  body = EXCLUDED.body, body_format = EXCLUDED.body_format,
  chapter_number = EXCLUDED.chapter_number,
  sequence = EXCLUDED.sequence, updated_at = now();

COMMIT;
