"""
Form 5 lesson notes — Term 2.

Same house rules as term1.py: one note per lesson, short sentences, the thing
then the example, exam wording flagged where the mark scheme is fussy about it.
"""

TERM2 = {

"Solve problems with spreadsheets 2": """
<p>Term 1 covered formulas. This lesson is about making a spreadsheet answer a
question — sorting, filtering, and drawing the result.</p>

<h3>Sorting</h3>
<p>Select the whole table, including the headings, then sort. Select only one
column and you scramble the rows: the marks move but the names stay, and every
student gets somebody else's result. This is the classic spreadsheet
disaster.</p>

<h3>Filtering</h3>
<p>A filter hides rows that do not match a condition. Show only students who
scored below 10. The rows are hidden, not deleted — clear the filter and they
come back.</p>

<h3>Charts</h3>
<ul>
<li><strong>Bar or column</strong> — comparing separate things. Marks by
subject.</li>
<li><strong>Line</strong> — change over time. Enrolment each year.</li>
<li><strong>Pie</strong> — parts of one whole. Percentage of boys and girls.
Only use it when the slices add to 100%.</li>
</ul>
<p>Every chart needs a title and labelled axes. Marks are given for those
specifically.</p>

<h3>Conditional formatting</h3>
<p>Colour a cell based on its value — red where the mark is below 10. The
spreadsheet applies the rule; you do not colour cells by hand.</p>

<h3>Useful functions</h3>
<pre>=COUNTIF(B2:B41, "&gt;=10")     how many passed
=SUMIF(C2:C41, "Form 5", D2:D41)
=ROUND(B2, 2)                two decimal places
=CONCATENATE(A2, " ", B2)    join first and last name</pre>

<h3>When something breaks</h3>
<ul>
<li><code>#####</code> — the column is too narrow. Widen it.</li>
<li><code>#DIV/0!</code> — dividing by zero or by an empty cell.</li>
<li><code>#NAME?</code> — a function name is misspelled.</li>
<li><code>#REF!</code> — the formula points at a cell you deleted.</li>
</ul>
""",

"Create presentations 1": """
<p>Presentation software makes slides. PowerPoint, LibreOffice Impress, Google
Slides.</p>

<h3>The parts</h3>
<ul>
<li><strong>Slide</strong> — one screen.</li>
<li><strong>Layout</strong> — the arrangement of boxes on a slide: title only,
title and content, two columns.</li>
<li><strong>Slide master</strong> — the template behind every slide. Change the
font on the master and every slide changes. This is the fast way, and the exam
likes it.</li>
<li><strong>Placeholder</strong> — a box waiting for text or a picture.</li>
</ul>

<h3>The views</h3>
<ul>
<li><strong>Normal</strong> — where you edit one slide.</li>
<li><strong>Slide sorter</strong> — all slides as thumbnails, for reordering.</li>
<li><strong>Notes page</strong> — your speaking notes, which the audience never
sees.</li>
<li><strong>Slide show</strong> — full screen, what the audience sees.</li>
</ul>

<h3>Making slides that work</h3>
<ul>
<li>A few words per line, a few lines per slide. The slide is a prompt, not the
speech.</li>
<li>Large text. If it is hard to read on your screen it is impossible from the
back of a classroom.</li>
<li>Strong contrast — dark text on light, or light on dark.</li>
<li>One idea per slide.</li>
</ul>

<h3>Animation and transition</h3>
<p>A <strong>transition</strong> is how one slide replaces the next. An
<strong>animation</strong> is how something moves on a single slide. Know which
word is which; the exam asks.</p>
<p>Use both sparingly. They are the easiest way to make a good presentation
annoying.</p>
""",

"Create presentations 2": """
<p>A practical lesson: build a complete presentation from a brief.</p>

<h3>The order to work in</h3>
<ul>
<li>Plan on paper first. How many slides, and what goes on each.</li>
<li>Choose a design or set the slide master.</li>
<li>Type all the text.</li>
<li>Add pictures, tables and charts.</li>
<li>Add transitions and animations last, if at all.</li>
<li>Run the slide show from the start and watch it as the audience would.</li>
</ul>

<h3>A workable structure</h3>
<ul>
<li>Title slide — the topic, your name, the date.</li>
<li>Introduction — what this is about, in one slide.</li>
<li>Three to five content slides.</li>
<li>Conclusion — what you want them to remember.</li>
</ul>

<h3>Things worth knowing how to do</h3>
<ul>
<li><strong>Insert a chart</strong>, or paste one from a spreadsheet.</li>
<li><strong>Hyperlink</strong> to another slide or a website.</li>
<li><strong>Action button</strong> — a clickable shape that jumps somewhere.</li>
<li><strong>Header and footer</strong> — slide numbers, the date, the school
name.</li>
<li><strong>Rehearse timings</strong> — records how long you spend on each
slide.</li>
<li><strong>Print as handouts</strong> — several slides per page.</li>
</ul>

<h3>Saving</h3>
<p><code>.pptx</code> is the editable file. <code>.pdf</code> is for sending to
someone who only needs to read it. A slide show file opens straight into
presentation mode.</p>
""",

"Create publications": """
<p>Desktop publishing software arranges text and pictures on a page: posters,
newsletters, invitation cards, brochures. Microsoft Publisher, Adobe InDesign,
Scribus.</p>

<h3>How it differs from a word processor</h3>
<p>A word processor is built around a flow of text down a page. DTP is built
around <strong>frames</strong> you place anywhere and fill with text or a
picture. If the job is a letter, use a word processor. If the job is a poster,
use DTP.</p>

<h3>The vocabulary</h3>
<ul>
<li><strong>Text frame</strong> — a box holding text. Frames can be linked, so
text overflowing one continues in the next.</li>
<li><strong>Margin and gutter</strong> — the space at the edge of the page, and
the space between columns.</li>
<li><strong>Orientation</strong> — portrait (tall) or landscape (wide).</li>
<li><strong>Template</strong> — a ready-made layout you fill in.</li>
</ul>

<h3>Design that works</h3>
<ul>
<li>Two fonts at most. One for headings, one for body text.</li>
<li>Line things up. A ruler or guide beats judging by eye.</li>
<li>Leave white space. A crowded page does not get read.</li>
<li>Keep the most important thing biggest.</li>
</ul>

<h3>Pictures</h3>
<p>Use a high enough resolution for print. An image that looks fine on screen
can print blurred, because a screen needs far fewer dots per inch than paper
does.</p>
""",

"Assistive technology and disabilities": """
<p>Assistive technology is hardware or software that lets a person with a
disability use a computer.</p>

<h3>For sight</h3>
<ul>
<li><strong>Screen reader</strong> — reads what is on screen aloud.</li>
<li><strong>Screen magnifier</strong> — enlarges part of the display.</li>
<li><strong>Braille display</strong> — raises pins to form Braille characters.</li>
<li><strong>High contrast mode</strong> and larger fonts, built into the OS.</li>
</ul>

<h3>For hearing</h3>
<ul>
<li><strong>Captions and subtitles</strong> on video.</li>
<li><strong>Visual alerts</strong> — the screen flashes instead of a beep.</li>
</ul>

<h3>For movement</h3>
<ul>
<li><strong>Speech recognition</strong> — control the computer by voice.</li>
<li><strong>On-screen keyboard</strong>, operated by a mouse or a single
switch.</li>
<li><strong>Trackball, head pointer, eye tracker</strong>.</li>
<li><strong>Sticky keys</strong> — press Ctrl and C one after another rather
than together.</li>
</ul>

<h3>Ergonomics</h3>
<div class="def-box"><strong>Ergonomics:</strong> the science of designing a safe
and comfortable working environment for people.</div>
<p>Long hours at a computer cause real injuries:</p>
<ul>
<li><strong>RSI</strong> — Repetitive Strain Injury. Pain in fingers, wrists and
arms from the same movement repeated for hours. Carpal tunnel syndrome is one
kind.</li>
<li><strong>CVS</strong> — Computer Vision Syndrome. Sore, dry eyes and blurred
vision from staring at a screen.</li>
<li><strong>Back and neck pain</strong> from a bad chair or a badly placed
screen.</li>
</ul>
<p>Prevention: screen at eye level and an arm's length away, wrists straight,
feet flat, back supported, and a break every hour.</p>
""",

"Assistive technologies for the elderly": """
<p>Older people often face several small difficulties at once — weaker sight,
less steady hands, slower reflexes, sometimes memory problems. Technology helps
where it removes an obstacle without adding a new one.</p>

<h3>Making an ordinary device usable</h3>
<ul>
<li>Larger text and higher contrast in the settings.</li>
<li>A phone with big buttons and a loud, simple ringer.</li>
<li>Voice control, so nothing has to be typed.</li>
<li>Fewer icons on the home screen; only what is actually used.</li>
</ul>

<h3>Health and safety at home</h3>
<ul>
<li><strong>Medication reminder</strong> — an alarm, or a box that beeps and
opens the right compartment.</li>
<li><strong>Personal alarm</strong> — a pendant with a button that calls for
help after a fall.</li>
<li><strong>Fall detector</strong> — a sensor that raises the alarm without the
person pressing anything.</li>
<li><strong>Telemedicine</strong> — a nurse consulted by video instead of a
journey to the hospital.</li>
<li><strong>GPS tracker</strong> — for someone who may become lost.</li>
</ul>

<h3>Staying connected</h3>
<p>Video calls to family, and a simplified messaging app. Isolation is a real
health problem, and this is the part of the technology that addresses it.</p>

<h3>Designing for older users</h3>
<ul>
<li>Big targets. A small button is hard to hit with an unsteady hand.</li>
<li>Clear feedback — the device should visibly confirm what it did.</li>
<li>Forgiving of mistakes, with an obvious way back.</li>
<li>No jargon.</li>
</ul>
""",

"Network hardware": """
<div class="def-box"><strong>Network:</strong> two or more computers connected
so they can share data and resources.</div>

<h3>By size</h3>
<ul>
<li><strong>PAN</strong> — Personal Area Network. A few metres. Your phone and
your earphones over Bluetooth.</li>
<li><strong>LAN</strong> — Local Area Network. One building. A school computer
lab.</li>
<li><strong>MAN</strong> — Metropolitan Area Network. One city.</li>
<li><strong>WAN</strong> — Wide Area Network. Across cities or countries. The
Internet is the largest WAN.</li>
</ul>

<h3>The devices</h3>
<ul>
<li><strong>NIC</strong> — Network Interface Card. Connects one computer to the
network.</li>
<li><strong>Hub</strong> — sends what it receives to <em>every</em> port.
Wasteful; obsolete.</li>
<li><strong>Switch</strong> — sends data only to the machine it is addressed to.
This is the difference the exam asks about.</li>
<li><strong>Router</strong> — joins two different networks, and finds the path
between them. Your home box is a router.</li>
<li><strong>Repeater</strong> — amplifies a weakening signal so it can travel
further. Fixes <strong>attenuation</strong>.</li>
<li><strong>Bridge</strong> — joins two segments of the same network.</li>
<li><strong>Modem</strong> — modulates and demodulates between digital and
analogue.</li>
<li><strong>Server</strong> — provides a service; <strong>client</strong>
requests it.</li>
</ul>

<h3>Topologies</h3>
<ul>
<li><strong>Star</strong> — every machine to a central hub or switch. Most
common. One cable failing affects one machine; the central device failing takes
everything down.</li>
<li><strong>Bus</strong> — all machines on one cable. Cheap. The cable fails and
the network fails.</li>
<li><strong>Ring</strong> — each machine to the next, in a circle.</li>
<li><strong>Mesh</strong> — many machines connected to many others. Expensive,
and the best <strong>fault tolerance</strong>, because there is more than one
path.</li>
</ul>

<h3>Cables</h3>
<p>Twisted pair (cheap, common), coaxial, and <strong>fibre optic</strong> —
fastest, longest range, immune to electrical interference, and the most
expensive.</p>
""",

"Network IP configuration": """
<p>Every device on a network needs an address, so data knows where to go.</p>

<div class="def-box"><strong>IP address:</strong> a number that uniquely
identifies a device on a network.</div>

<h3>The shape of it</h3>
<p><strong>IPv4</strong> is four numbers, 0 to 255, separated by dots:
<code>192.168.1.10</code>. That gives about 4 billion addresses, which sounded
like plenty in 1980 and ran out.</p>
<p><strong>IPv6</strong> is much longer and solves that.</p>

<h3>The other settings</h3>
<ul>
<li><strong>Subnet mask</strong> — <code>255.255.255.0</code>. Says which part
of the address is the network and which part is the machine.</li>
<li><strong>Default gateway</strong> — the router's address. Anything not on
this network is sent there.</li>
<li><strong>DNS server</strong> — turns a name like
<code>www.mtn.cm</code> into an IP address. Without it you would type numbers.</li>
</ul>

<h3>Static or dynamic</h3>
<ul>
<li><strong>Static</strong> — you type the address in, and it never changes.
Used for servers and printers, which must be findable at the same address.</li>
<li><strong>Dynamic (DHCP)</strong> — the router hands out an address when a
device joins. Used for everything else, because nobody wants to configure forty
laptops by hand.</li>
</ul>

<h3>Checking it works</h3>
<ul>
<li><code>ipconfig</code> (Windows) or <code>ifconfig</code> — shows your
address.</li>
<li><code>ping 8.8.8.8</code> — is anything reachable?</li>
<li><code>ping google.com</code> — if the number works and the name does not,
your DNS is the problem.</li>
</ul>
""",

"Notions on packets": """
<p>Data does not travel across a network in one piece. It is cut into
<strong>packets</strong>, sent separately, and reassembled at the other end.</p>

<h3>Why</h3>
<ul>
<li>A large file would block the line for everyone else.</li>
<li>Packets can take different routes and go round a broken link.</li>
<li>If one packet is lost, only that one is resent.</li>
</ul>

<h3>What a packet carries</h3>
<ul>
<li><strong>Header</strong> — sender's address, receiver's address, packet
number.</li>
<li><strong>Payload</strong> — the actual data.</li>
<li><strong>Trailer</strong> — the error check.</li>
</ul>
<p>The packet number matters: packets can arrive out of order, and the number is
how they are put back in sequence.</p>

<h3>Protocols</h3>
<div class="def-box"><strong>Protocol:</strong> a set of rules governing how
data is transmitted between devices.</div>
<p>Both ends must follow the same rules, or neither understands the other.</p>

<h3>Transmission modes</h3>
<ul>
<li><strong>Simplex</strong> — one direction only. A keyboard to the computer;
radio broadcasting.</li>
<li><strong>Half duplex</strong> — both directions, one at a time. A walkie
talkie: you speak, then you listen.</li>
<li><strong>Full duplex</strong> — both directions at once. A phone call.</li>
</ul>

<h3>Modulation</h3>
<p><strong>Modulation</strong> turns a digital signal into analogue so it can
travel on a telephone line. <strong>Demodulation</strong> turns it back. A
modem does both, which is where the name comes from.</p>

<h3>Multiplexing</h3>
<p>Sending several signals along one line at the same time, so the cable is not
wasted carrying one conversation.</p>
""",

"Error detection and packet security": """
<p>Signals get corrupted in transit. A 1 arrives as a 0. Error detection is how
the receiver notices.</p>

<h3>Parity check</h3>
<p>Add one extra bit to every byte so the number of 1s is always even (even
parity) or always odd (odd parity).</p>
<p><code>1010110</code> has four 1s. For even parity the parity bit is
<strong>0</strong>. For odd parity it is <strong>1</strong>.</p>
<p>The receiver counts. Wrong count, error. Its weakness: if <em>two</em> bits
flip, the count comes out right again and the error passes unnoticed.</p>

<h3>Checksum</h3>
<p>Add up all the bytes and send the total. The receiver adds them again and
compares. Different total, error.</p>

<h3>Check digit</h3>
<p>An extra digit calculated from the others and added to the end. Used on
barcodes, ISBNs and account numbers, to catch a number typed in wrongly.</p>

<h3>Echo check</h3>
<p>The receiver sends the whole message back and the sender compares. Reliable,
and doubles the traffic.</p>

<h3>Automatic Repeat Request</h3>
<p>The receiver acknowledges each packet. No acknowledgement within a set time,
the sender sends it again.</p>

<h3>Keeping packets private</h3>
<p>Detection catches accidents, not attackers. For that you need
<strong>encryption</strong>: the packet is scrambled with a key, so anyone
intercepting it sees nothing usable. HTTPS is HTTP with encryption, which is
what the padlock in the address bar means.</p>
""",

"Notions on the internet": """
<div class="def-box"><strong>Internet:</strong> a worldwide network of
interconnected computer networks that communicate using TCP/IP.</div>

<h3>The Internet is not the Web</h3>
<p>The Internet is the network. The <strong>World Wide Web</strong> is one
service running on it — the pages you browse. Email, file transfer and video
calls are other services on the same network. The exam asks this often enough to
be worth remembering.</p>

<h3>Protocols by name</h3>
<ul>
<li><strong>HTTP / HTTPS</strong> — web pages. The S is encryption.</li>
<li><strong>FTP</strong> — File Transfer Protocol, for moving files.</li>
<li><strong>SMTP</strong> — sending email.</li>
<li><strong>POP3 / IMAP</strong> — receiving email.</li>
<li><strong>TCP/IP</strong> — the pair the whole Internet runs on.</li>
</ul>

<h3>Addresses</h3>
<p>A <strong>URL</strong> is a Uniform Resource Locator — the address of a page.
<code>https://www.gcerevision.com/notes.html</code>: the protocol, the domain
name, the path to the file.</p>
<p>Uploading is sending a file <em>to</em> a server. Downloading is bringing one
<em>from</em> a server. Students reverse these under pressure.</p>

<h3>Getting connected</h3>
<p>An <strong>ISP</strong> (Internet Service Provider) sells you access — MTN,
Orange, Camtel. <strong>Bandwidth</strong> is how much data the connection can
carry per second.</p>

<h3>E-commerce</h3>
<p>Buying and selling online. Open all hours, reaches customers anywhere, no
shop to rent. Against that: no physical contact with the goods before buying,
delivery must be arranged, and payment details can be stolen.</p>
""",

"Notions on digital currency": """
<div class="def-box"><strong>Digital currency:</strong> money that exists only in
electronic form, with no notes or coins.</div>

<h3>The kinds</h3>
<ul>
<li><strong>Mobile money</strong> — MTN MoMo, Orange Money. Money held in an
account tied to your phone number. Backed by real francs held by the
operator.</li>
<li><strong>Cryptocurrency</strong> — Bitcoin and others. No bank and no
government behind it. Runs on a <strong>blockchain</strong>: a shared record
kept on thousands of computers at once, so no single person can rewrite it.</li>
<li><strong>Central bank digital currency</strong> — a national currency issued
electronically by the country's own central bank.</li>
</ul>

<h3>Why people use it</h3>
<ul>
<li>Transfers in seconds, over any distance.</li>
<li>No bank account needed for mobile money — only a phone.</li>
<li>Cheaper than international bank transfers.</li>
<li>Every transaction is recorded.</li>
</ul>

<h3>The risks</h3>
<ul>
<li>Cryptocurrency values swing violently. Money you had yesterday may be half
as much today.</li>
<li>Send to the wrong address and there is nobody to reverse it.</li>
<li>Lose the key to a crypto wallet and the money is gone permanently.</li>
<li>The anonymity attracts fraud and money laundering.</li>
<li>It needs network coverage and a charged phone.</li>
</ul>

<h3>Staying safe</h3>
<p>Never share your PIN. Check the number before confirming. Keep the
confirmation message. Treat any unexpected "you have received money, please send
it back" message as a scam, because it is one.</p>
""",

"Web authoring services": """
<p>Web pages are written in <strong>HTML</strong> — HyperText Markup Language.
It is not a programming language. It marks up text to say what each part
<em>is</em>.</p>

<h3>The skeleton</h3>
<pre>&lt;html&gt;
&lt;head&gt;
   &lt;title&gt;My School&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
   &lt;h1&gt;GHS Mbonjo&lt;/h1&gt;
   &lt;p&gt;Welcome to our website.&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;</pre>
<p>What is in the <code>head</code> is not shown on the page. What is in the
<code>body</code> is.</p>

<h3>Tags worth knowing</h3>
<ul>
<li><code>&lt;h1&gt;</code> to <code>&lt;h6&gt;</code> — headings, largest to
smallest.</li>
<li><code>&lt;p&gt;</code> — paragraph.</li>
<li><code>&lt;b&gt;</code> bold, <code>&lt;i&gt;</code> italic,
<code>&lt;u&gt;</code> underline.</li>
<li><code>&lt;br&gt;</code> line break, <code>&lt;hr&gt;</code> horizontal
rule.</li>
<li><code>&lt;ul&gt;</code> bulleted list, <code>&lt;ol&gt;</code> numbered
list, <code>&lt;li&gt;</code> an item in either.</li>
<li><code>&lt;img src="photo.jpg"&gt;</code> — an image.</li>
<li><code>&lt;a href="page2.html"&gt;Next&lt;/a&gt;</code> — a link.</li>
<li><code>&lt;table&gt;</code>, <code>&lt;tr&gt;</code> row,
<code>&lt;td&gt;</code> cell.</li>
</ul>

<h3>Opening and closing</h3>
<p>Most tags come in pairs: <code>&lt;p&gt;</code> and <code>&lt;/p&gt;</code>.
A few stand alone — <code>&lt;br&gt;</code>, <code>&lt;hr&gt;</code>,
<code>&lt;img&gt;</code> — because there is nothing to wrap.</p>

<h3>What reads it</h3>
<p>A <strong>browser</strong>. Nothing is compiled: the browser interprets the
tags and draws the page. That is why an HTML mistake gives you an ugly page
rather than an error message.</p>
""",

"Notions on social networks": """
<div class="def-box"><strong>Social network:</strong> an online service where
people create a profile and share content with others.</div>
<p>Facebook, WhatsApp, Instagram, X, TikTok, LinkedIn.</p>

<h3>What they are good for</h3>
<ul>
<li>Keeping in touch across distance, cheaply.</li>
<li>Finding information and news quickly.</li>
<li>Study groups and sharing notes.</li>
<li>Small businesses reaching customers with no shop and no advertising
budget.</li>
<li>Jobs and professional contacts.</li>
</ul>

<h3>What they cost</h3>
<ul>
<li><strong>False information</strong> spreads faster than the correction.</li>
<li><strong>Cyberbullying</strong> follows a student home; there is no escaping
it at the school gate.</li>
<li><strong>Addiction</strong> — hours lost, and schoolwork with them.</li>
<li><strong>Privacy</strong> — what you post can be copied and kept forever, by
anyone.</li>
<li><strong>Scams</strong> — fake accounts, fake offers.</li>
</ul>

<h3>Netiquette</h3>
<p>Network etiquette. The rules of behaving decently online:</p>
<ul>
<li>Do not type in capitals. It reads as SHOUTING.</li>
<li>Check spelling before posting.</li>
<li>Do not flame — no abuse, no insults.</li>
<li>Do not forward huge attachments unasked.</li>
<li>Fill in the subject line of an email.</li>
<li>Say nothing online you would not say to the person's face.</li>
</ul>
""",

"Using online social networks": """
<p>A practical lesson: use these services deliberately rather than by habit.</p>

<h3>Setting a profile up properly</h3>
<ul>
<li>A strong password, different from every other account.</li>
<li>Two-factor authentication where it is offered.</li>
<li>Only the personal details that are actually required. Your birthday and your
school are two of the answers to a security question.</li>
<li>Privacy settings checked, not left at the default. The default is usually
the most open.</li>
</ul>

<h3>Before you post</h3>
<p>Three questions. Would I be happy for my parents to see this? Would I be
happy for an employer to see it in ten years? Am I sure it is true?</p>
<p>Anything failing one of those should not be posted. Deleting later does not
help — anyone may already have screenshotted it.</p>

<h3>Spotting false information</h3>
<ul>
<li>Who published it? Is there a name and a real organisation?</li>
<li>Does any other source say the same?</li>
<li>What is the date? Old news gets recirculated as new.</li>
<li>Is it designed to make you angry? That is how it gets shared.</li>
</ul>
<p>If you are not sure, do not forward it. Forwarding is publishing.</p>

<h3>When something goes wrong</h3>
<ul>
<li>Block and report. Do not reply.</li>
<li>Keep screenshots as evidence.</li>
<li>Tell an adult. Bullying that is ignored gets worse.</li>
<li>Never send money to an account you have not verified by phone.</li>
</ul>
""",

"Notions on security": """
<div class="def-box"><strong>Data security:</strong> keeping data safe from
unauthorised access and unauthorised use.</div>

<h3>Authentication</h3>
<p>Proving you are who you say you are. Three ways:</p>
<ul>
<li><strong>Something you know</strong> — password, PIN.</li>
<li><strong>Something you have</strong> — smart card, phone.</li>
<li><strong>Something you are</strong> — biometrics: fingerprint, face, iris,
voice.</li>
</ul>
<p>Using two of the three together is <strong>two-factor
authentication</strong>, and it is far stronger than any one alone.</p>

<h3>A password worth having</h3>
<ul>
<li>At least eight characters.</li>
<li>Upper case, lower case and digits mixed.</li>
<li>No real words, no names, no birthdays.</li>
<li>Different for every account.</li>
<li>Changed occasionally, and never shared.</li>
</ul>
<p>Given four options in an exam, the strongest is the one mixing cases, digits
and length. A name with a year after it is the weakest, however long.</p>

<h3>Encryption</h3>
<p>Scrambling data with an algorithm so only the holder of the key can read it.
The original is <strong>plaintext</strong>, the scrambled version is
<strong>ciphertext</strong>, the method is the <strong>cipher</strong>, and the
secret is the <strong>key</strong>.</p>
<p>Encryption does not stop data being stolen. It stops the thief being able to
use it. That distinction is worth a mark.</p>

<h3>Backup</h3>
<p>A second copy, kept somewhere else. Somewhere else matters: a backup on the
same disk dies with the disk, and a backup in the same room dies in the same
fire.</p>
""",

"Threats and attacks on computer systems": """
<h3>Malware</h3>
<div class="def-box"><strong>Malware:</strong> software written to damage or
gain unauthorised access to a computer system.</div>
<ul>
<li><strong>Virus</strong> — attaches itself to a file and spreads when that
file is run.</li>
<li><strong>Worm</strong> — copies itself across a network on its own. Needs no
host file, and fills memory and bandwidth.</li>
<li><strong>Trojan horse</strong> — pretends to be something useful. You install
it yourself.</li>
<li><strong>Spyware</strong> — watches quietly and reports back.</li>
<li><strong>Ransomware</strong> — encrypts your files and demands payment.</li>
<li><strong>Logic bomb</strong> — sits dormant until a condition is met.</li>
</ul>
<p>Virus needs a host and human action. Worm spreads itself. That is the
distinction exams test.</p>

<h3>Attacks on people rather than machines</h3>
<ul>
<li><strong>Phishing</strong> — an email pretending to be from your bank, asking
you to click a link and confirm your details. The link goes to a copy of the
real site.</li>
<li><strong>Pharming</strong> — you type the correct address and are redirected
to a fake site.</li>
<li><strong>Social engineering</strong> — someone phones claiming to be from IT
and asks for your password.</li>
</ul>

<h3>Other threats</h3>
<ul>
<li><strong>Hacking</strong> — unauthorised access to a system.</li>
<li><strong>Denial of service</strong> — flooding a server until it stops
responding.</li>
<li><strong>Theft</strong> of the equipment itself.</li>
<li><strong>Accidental deletion</strong>, hardware failure, fire, flood. Not
attacks, and they lose just as much data.</li>
</ul>
""",

"Data, computer, and network security measures": """
<p>Knowing the threats is half of it. This lesson is the defences.</p>

<h3>Antivirus</h3>
<p>Detects and removes malware. It must be <strong>updated regularly</strong> —
new malware appears daily and yesterday's antivirus does not recognise it. Scan
every flash drive before opening it.</p>

<h3>Firewall</h3>
<div class="def-box"><strong>Firewall:</strong> hardware or software that
examines traffic entering or leaving a network and blocks anything that fails
the security rules.</div>
<p>It sits between your network and the outside, and it is the answer to "what
protects a private network from the Internet".</p>

<h3>Access control</h3>
<ul>
<li>Usernames and passwords.</li>
<li><strong>File permissions</strong> — read only, read and write, no access.
Not everyone needs to edit everything.</li>
<li><strong>User levels</strong> — a student, a teacher and an administrator see
different things.</li>
<li>Automatic logout after a period of inactivity.</li>
</ul>

<h3>Backups done properly</h3>
<ul>
<li>Regularly, on a schedule, not when someone remembers.</li>
<li>Stored in a different building, or in the cloud.</li>
<li><strong>Tested.</strong> A backup nobody has ever restored is a guess.</li>
</ul>

<h3>Physical security</h3>
<p>Locked server room, cables secured, machines bolted down, a UPS so a power
cut does not corrupt what was open.</p>

<h3>The part that is not technical</h3>
<p>Train the users. The strongest firewall in the world does not help when
somebody gives their password to a caller who sounded official.</p>
""",

"Notions on digital identities and digital footprints": """
<div class="def-box"><strong>Digital identity:</strong> the information that
represents a person online — accounts, profiles, usernames, email
addresses.</div>
<div class="def-box"><strong>Digital footprint:</strong> the trail of data a
person leaves behind through their online activity.</div>

<h3>Two kinds of footprint</h3>
<ul>
<li><strong>Active</strong> — what you deliberately put online. Posts,
comments, photos, forms you fill in.</li>
<li><strong>Passive</strong> — what is collected without you doing anything.
Sites you visited, your IP address, your location, what you searched for.</li>
</ul>
<p>The passive one is larger, and most people never think about it.</p>

<h3>Why it matters</h3>
<ul>
<li>Employers search for candidates before interviewing them.</li>
<li>Universities do the same.</li>
<li>Advertisers build a profile of you from it.</li>
<li>It is very hard to remove. Copies, screenshots, archives.</li>
</ul>

<h3>The rule worth remembering</h3>
<p>The Internet does not forget. A post deleted after an hour may already exist
in five other places.</p>

<h3>Identity theft</h3>
<p>Someone collects enough of your details to pretend to be you — open an
account, take a loan, commit a crime in your name. They get those details from
phishing, from a data breach, or from what you posted yourself.</p>
<p>Which is why your date of birth, your mother's name and your school are not
harmless things to publish. They are the answers to security questions.</p>
""",

"Digital identities and footprints management": """
<p>A practical lesson: find out what is already out there, then reduce it.</p>

<h3>Audit yourself</h3>
<ul>
<li>Search your own name and see what comes back.</li>
<li>List every account you have ever opened. Most people are surprised by the
number.</li>
<li>Close the ones you no longer use. A dormant account is a way in.</li>
</ul>

<h3>Tighten what remains</h3>
<ul>
<li>Go through privacy settings on each account. Who can see your posts? Your
friend list? Your photos?</li>
<li>Turn off location tagging on photos.</li>
<li>Review which apps you have granted access to your accounts, and revoke the
ones you do not recognise.</li>
<li>Use a different password everywhere, with a password manager if you can.</li>
</ul>

<h3>Reduce the passive trail</h3>
<ul>
<li>Clear cookies periodically.</li>
<li>Use private browsing on a shared or school computer — and understand what
it does not do. It hides history from the next person at that machine. It does
not hide you from the website or the network.</li>
<li>Decline cookie banners you do not need to accept.</li>
</ul>

<h3>Build the identity you want found</h3>
<p>A footprint is not only a risk. A student with a decent LinkedIn profile, or
public work they are proud of, has a footprint that helps them. The goal is to
control it, not to disappear.</p>

<h3>If something is out there you want removed</h3>
<p>Ask the site to take it down. Report it to the platform if it breaks their
rules. Where the law provides for it, request erasure. None of these is
guaranteed to work, which is the reason for thinking before posting.</p>
""",

"Protecting Intellectual property": """
<div class="def-box"><strong>Intellectual property:</strong> creations of the
mind — writing, music, software, inventions, designs — which belong to whoever
made them.</div>

<h3>The protections</h3>
<ul>
<li><strong>Copyright</strong> — protects the expression of an idea: a book, a
song, a film, a program. Automatic on creation; you do not apply for it.</li>
<li><strong>Patent</strong> — protects an invention. You must apply, and it is
granted for a limited period.</li>
<li><strong>Trademark</strong> — protects a name or logo that identifies a
business.</li>
</ul>
<p>Copyright protects the <em>expression</em>, not the idea. Anyone may write a
program that sorts a list; nobody may copy your code for doing it.</p>

<h3>What breaks copyright</h3>
<ul>
<li><strong>Software piracy</strong> — copying, selling or distributing software
without permission. The most widely practised computer crime.</li>
<li><strong>Plagiarism</strong> — presenting someone else's work as your own.
Copying from a website into your assignment is plagiarism even when you change a
few words.</li>
<li>Downloading music or films from sites without a licence.</li>
</ul>

<h3>The laws</h3>
<ul>
<li><strong>Copyright, Designs and Patents Act</strong> — protects creators and
ensures they are credited and paid.</li>
<li><strong>Computer Misuse Act</strong> — makes three things offences:
unauthorised access; unauthorised access intending further crime; and
unauthorised modification of data.</li>
<li><strong>Data Protection Act</strong> — governs personal data: collect only
what is needed, keep it accurate, keep it secure, do not keep it longer than
necessary.</li>
</ul>

<h3>Doing it properly</h3>
<p>Cite your sources. Use material licensed for reuse. Buy the software, or use
open source. Ask permission.</p>
""",

"Assigning and respecting digital licenses": """
<p>A licence says what you may do with something. Reading it is the difference
between using a work and stealing it.</p>

<h3>Software licences</h3>
<ul>
<li><strong>Single user</strong> — one machine.</li>
<li><strong>Multi user</strong> — a stated number of machines.</li>
<li><strong>Site licence</strong> — everything at one location. What a school
buys.</li>
<li><strong>Subscription</strong> — you pay monthly or yearly and stop when you
stop paying.</li>
<li><strong>EULA</strong> — End User Licence Agreement. The one everybody
accepts without reading.</li>
</ul>

<h3>Creative Commons</h3>
<p>A standard set of licences for anything creative, so a creator can permit
reuse without giving up all rights:</p>
<ul>
<li><strong>BY</strong> — use it, but credit me.</li>
<li><strong>SA</strong> — ShareAlike. Anything you build from it carries the
same licence.</li>
<li><strong>NC</strong> — NonCommercial. Not for making money.</li>
<li><strong>ND</strong> — NoDerivatives. Use it as it is; do not change it.</li>
</ul>
<p>They combine: CC BY-NC means credit me and do not sell it.</p>

<h3>Licensing your own work</h3>
<p>You already hold copyright in whatever you make. A licence is you telling
others what they may do with it. Choose it deliberately: a project you want
others to build on should say so, or nobody will risk touching it.</p>

<h3>Respecting other people's</h3>
<ul>
<li>Check the licence before using an image, a font or a piece of code.</li>
<li>Give credit in the form the licence asks for.</li>
<li>"I found it on Google" is not a licence. Google is a search engine, not the
owner.</li>
<li>When there is no licence, assume all rights reserved and ask.</li>
</ul>
""",

}
