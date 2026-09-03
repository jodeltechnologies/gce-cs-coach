# -*- coding: utf-8 -*-
"""Student notes for the app. Part C, Lower Sixth lessons 27 to 42."""

from student_a import note, fig, box, short, quiz


note("Lower Sixth", 27, 8, "Assistive technology",
     ["What assistive technology is", "Braille, audio and speech tools",
      "How AI improved them"], f"""
<p>A computer is only useful to somebody who can operate it. Assistive
technology is what makes the same machine usable by a person who cannot see the
screen, cannot hear the sound, or cannot work a standard keyboard. It is not a
kindness added on at the end. For a great many people it is the thing that makes
school and work possible at all.</p>

{box("Assistive technology", "any device, software or equipment that helps a "
     "person with a disability to carry out a task they would otherwise find "
     "difficult or impossible.")}

<h3>For sight</h3>
<ul>
<li>A <strong>screen reader</strong> reads aloud what is on the screen,
including menus and links.</li>
<li>A <strong>Braille keyboard</strong> takes input in Braille, and a
<strong>Braille display</strong> raises small pins to form Braille characters so
the screen can be read by touch.</li>
<li>A <strong>screen magnifier</strong> and high contrast colours help partial
sight.</li>
<li><strong>Text to speech</strong> reads documents and books aloud.</li>
</ul>

<h3>For hearing</h3>
<p>Captions and subtitles put speech on the screen as text. Speech to text
turns a spoken lesson into writing as it happens. Visual alerts flash the screen
instead of sounding a beep.</p>

<h3>For movement</h3>
<ul>
<li><strong>Speech recognition</strong> lets a person dictate instead of typing
and control the machine by voice.</li>
<li><strong>Adapted keyboards</strong> have oversized keys, one handed layouts,
or guards that stop the finger slipping.</li>
<li><strong>Switch access</strong> uses a single large button, worked by hand,
head or foot, together with on screen scanning that highlights the choices in
turn.</li>
<li><strong>Eye tracking</strong> moves the pointer wherever the user looks.</li>
<li><strong>Sticky keys</strong> allow shortcuts to be pressed one key at a
time.</li>
</ul>

<h3>What AI changed</h3>
<p>Most of these existed twenty years ago and were frustrating to use. Artificial
intelligence did not invent them. It made them accurate enough to be worth
using, which is a different and larger contribution.</p>
<p>Speech recognition once needed long training on your own voice, a silent
room, and careful unnatural speech, and it still made constant mistakes. Modern
systems handle accents, background noise and ordinary conversation. That turned
dictation from a test of patience into a way of working.</p>
<p>Predictive text matters enormously to somebody typing with one switch.
Guessing the whole word after two letters is the difference between a sentence a
minute and a sentence in ten. AI also writes descriptions of photographs so a
screen reader has something to read, and produces live captions free and
instantly where a human writer was once needed.</p>

{short(
 "Assistive technology lets a person with a disability do what they otherwise "
 "could not.",
 "Screen readers and Braille displays serve sight. Captions serve hearing. "
 "Speech and switches serve movement.",
 "AI made speech recognition accurate enough to rely on.",
 "Match the technology to the particular difficulty.")}

{quiz(
 ("Describe how a Braille display works and who uses it.",
  "Small pins rise and fall to form Braille characters representing the text "
  "on screen, so a blind user can read by touch."),
 ("A student cannot use a keyboard because of limited hand movement. Suggest "
  "two technologies.",
  "Speech recognition, so the student can dictate and control the machine by "
  "voice. And switch access with on screen scanning, so choices can be made "
  "with a single button."),
 ("How has AI improved assistive technology?",
  "It has made speech recognition, predictive text and image description much "
  "more accurate, which turned unreliable aids into tools people can depend "
  "on."))}
""")


note("Lower Sixth", 28, 8, "Computer ergonomics",
     ["What ergonomics means", "Health problems and their causes",
      "Correct posture and equipment"], f"""
<p>You will spend years of your life in front of a screen. The injuries that
come from doing it badly arrive slowly and quietly, and by the time they hurt
they are hard to undo. This lesson is cheap insurance.</p>

{box("Computer ergonomics", "the study of arranging the workplace, the "
     "equipment and the way of working so that they suit the human body and "
     "avoid injury.")}

{fig("workstation", "How to arrange a desk, a chair and a screen")}

<h3>The problems and where they come from</h3>
<ul>
<li><strong>Back, neck and shoulder pain.</strong> Caused by poor posture, a
badly placed screen, an unsupportive chair, and long periods without
movement.</li>
<li><strong>Repetitive strain injury and carpal tunnel syndrome.</strong>
Caused by long spells of typing and mousing with the wrists bent or resting on
a hard edge.</li>
<li><strong>Eye strain.</strong> Sore, dry and tired eyes, caused by staring at
a bright screen at one fixed distance, made worse by glare and poor
lighting.</li>
<li><strong>Headaches.</strong> From eye strain, from glare, or from tension in
the neck and shoulders.</li>
<li><strong>Tiredness.</strong> From long unbroken sessions.</li>
<li><strong>Trips and shocks.</strong> From trailing cables and overloaded
sockets.</li>
</ul>

<h3>Setting up properly</h3>
<ul>
<li><strong>Screen.</strong> The top of the screen at or just below eye level,
about an arm's length away, tilted slightly back. Place it so that no window or
lamp reflects in it.</li>
<li><strong>Chair.</strong> Adjustable, with support for the lower back. Feet
flat on the floor or on a footrest, thighs roughly level.</li>
<li><strong>Keyboard.</strong> Flat and directly in front of you, elbows at
about a right angle, wrists straight and not resting on a hard edge while you
type.</li>
<li><strong>Mouse.</strong> Beside the keyboard at the same height, close
enough that you do not stretch for it.</li>
<li><strong>Lighting.</strong> Even, with no glare on the screen and no bright
window directly behind it or in front of it.</li>
</ul>

<h3>Habits worth building</h3>
<p>Take a short break every hour and stand up. Follow the twenty twenty twenty
rule, which means every twenty minutes look at something about twenty feet away
for twenty seconds. That lets the focusing muscle of the eye relax, and it is
the muscle that gets tired. Blink on purpose, because people blink about a third
as often at a screen and that is exactly why the eyes dry. Stretch the wrists
and roll the shoulders. And do not hold a phone between your ear and your
shoulder while typing.</p>

{short(
 "Ergonomics means fitting the equipment to the body.",
 "Back pain, strain injury and eye strain are the main risks.",
 "Screen at eye level, an arm's length away. Elbows at a right angle, wrists "
 "straight.",
 "Every twenty minutes, look twenty feet away for twenty seconds.")}

{quiz(
 ("Name three health problems caused by computer use and give a cause of "
  "each.",
  "Back and neck pain from poor posture and a badly placed screen. Repetitive "
  "strain injury from long typing with bent wrists. Eye strain from staring at "
  "a bright screen with glare on it."),
 ("State the twenty twenty twenty rule and say why it works.",
  "Every twenty minutes, look at something about twenty feet away for twenty "
  "seconds. It lets the focusing muscle of the eye relax after being held tense "
  "at one close distance."),
 ("Describe the correct position of the screen and the keyboard.",
  "The top of the screen at or just below eye level, about an arm's length "
  "away and free of reflections. The keyboard flat and directly in front, with "
  "elbows at about a right angle and wrists straight."))}
""")


note("Lower Sixth", 29, 8, "Editing and Formatting text",
     ["Editing text", "Formatting text", "Styles", "AI writing helpers"], f"""
<p>This lesson is done at the machine. <strong>Editing</strong> means changing
what the words are. <strong>Formatting</strong> means changing how they look.
Keep the two apart in your mind, because they are different jobs.</p>

<h3>Editing</h3>
<p>Insert, delete and overtype. Select by clicking and dragging, or double click
a word, or triple click a paragraph, or press Ctrl and A for everything. Cut,
copy and paste with Ctrl and X, C and V. Undo and redo with Ctrl and Z and
Ctrl and Y, and use them freely, because they are what make experimenting safe.
Find and replace with Ctrl and H, remembering that Replace All changes every
occurrence at once, which is powerful and occasionally a disaster.</p>

<h3>Formatting</h3>
<p>At the level of <strong>characters</strong> you can change the font, the
size, bold, italic, underline, colour, highlight, superscript and subscript, and
case.</p>
<p>At the level of <strong>paragraphs</strong> you can change alignment, which
is left, centre, right or justified, and line spacing, space before and after,
indents, bullets and numbering, and borders and shading.</p>

<h3>Styles, which matter more than the rest</h3>
<p>A <strong>style</strong> is a named set of formatting, such as Heading 1,
Heading 2 or Normal. Instead of formatting each heading by hand, you apply the
style. Change the style once and every paragraph using it changes at the same
moment.</p>
<p>Styles keep a long document consistent. They make a global change simple,
one edit instead of forty. They are what allows an automatic table of contents,
because the software finds the headings by their style. And screen readers use
the heading structure to move around the document, so styles also make a
document usable by somebody who cannot see it.</p>

<h3>AI writing helpers</h3>
<p>These can suggest grammar and spelling corrections that understand the
sentence rather than only checking a dictionary. They suggest shorter sentences
and plainer words. They rewrite a passage in a different tone, summarise a long
document, or expand an outline.</p>
<p>The caution is the familiar one. The helper does not know your subject. It
will confidently replace a technical term with a wrong word that reads more
smoothly, and it will correct a place name it has never seen. Read every
suggestion before accepting it, and never use Accept All on work that
matters.</p>

<h3>Try this</h3>
<p>Take a plain page of text. Apply Heading 1 and Heading 2 styles to its
sections, justify the body, set line spacing to 1.5, and insert an automatic
table of contents. Then change the Heading 1 style once and watch every heading
follow.</p>

{short(
 "Editing changes the words. Formatting changes how they look.",
 "A style is a named set of formatting applied by name.",
 "Change a style once and every paragraph using it changes.",
 "Read every AI suggestion before you accept it.")}

{quiz(
 ("Give the difference between editing and formatting.",
  "Editing changes the content of the document, meaning the actual words. "
  "Formatting changes how that content looks without altering what it says."),
 ("What is a style and give two reasons to use one.",
  "A named set of formatting applied to text. It keeps a long document "
  "consistent, and changing the style once updates every paragraph that uses "
  "it."),
 ("Why is an automatic table of contents only possible when styles have been "
  "used?",
  "Because the software finds the headings by their heading style. Without "
  "styles it has no way of knowing which lines are headings."))}
""")


note("Lower Sixth", 30, 8, "Editing and formatting images and tables",
     ["Working with images", "Text wrapping", "Working with tables"], f"""
<p>This lesson carries on from the last. A document that mixes text, pictures
and tables is what you will actually be asked to produce, at school and
afterwards.</p>

<h3>Images</h3>
<ul>
<li><strong>Insert</strong> from a file, from the camera, or as a shape drawn
in the program.</li>
<li><strong>Resize</strong> by dragging a <strong>corner</strong> handle, which
keeps the proportions. Dragging a side handle stretches the picture, and a
stretched picture always looks wrong even to somebody who cannot say why.</li>
<li><strong>Crop</strong> to cut away the part you do not want. Cropping removes
area. Resizing changes scale. They are different jobs.</li>
<li><strong>Adjust</strong> brightness, contrast and colour, or remove the
background.</li>
<li><strong>Compress</strong> to reduce the file size, which matters a great
deal when sending a document by email.</li>
</ul>

<h3>Text wrapping</h3>
{fig("text_wrap", "Four ways text can flow around a picture")}
<p>Almost every complaint that a picture keeps jumping around is really a text
wrapping problem. <strong>In line with text</strong> treats the picture as one
very large letter in the line. <strong>Square</strong> flows the text around a
rectangle, and it is the usual choice beside a paragraph. <strong>Tight</strong>
follows the actual outline of the image. <strong>Behind text</strong> puts the
picture underneath, which is how watermarks are made.</p>

<h3>Tables</h3>
<ul>
<li><strong>Insert</strong> by choosing rows and columns, by drawing, or by
converting existing text.</li>
<li><strong>Merge and split cells.</strong> Merging joins several cells into
one, and that is how a heading is made to span the whole table.</li>
<li><strong>Column width and row height.</strong> Drag the borders, or use
AutoFit.</li>
<li><strong>Borders and shading.</strong> Note that the faint gridlines on
screen are not borders and will not print. If lines must appear on paper, apply
borders.</li>
<li><strong>Repeat header row</strong> so that a table crossing a page break
carries its headings onto the next page.</li>
<li><strong>Sort</strong> by any column, upward or downward.</li>
</ul>

<h3>Try this</h3>
<p>Build a table of your subjects, teachers and coefficients. Merge the top row
into one cell and put a title in it. Shade the header row and make it bold. Set
the header to repeat. Then insert a picture beside a paragraph and set its
wrapping to Square, so the text flows around it.</p>

{short(
 "Resize from a corner to keep the proportions. Crop removes area.",
 "Text wrapping decides how the text flows around a picture.",
 "Merging cells makes one heading span several columns.",
 "Gridlines on screen are not borders and will not print.")}

{quiz(
 ("Why should an image be resized using a corner handle?",
  "Because a corner keeps the proportions, so the image is not distorted. A "
  "side handle stretches it in one direction only."),
 ("How would you make a single heading span three columns of a table?",
  "Select the three cells in that row and merge them into one."),
 ("A table runs onto a second page but the headings do not appear there. What "
  "setting fixes it?",
  "Set the header row to repeat, so the heading row appears at the top of "
  "every page the table covers."))}
""")


note("Lower Sixth", 31, 9, "Using Text boxes and adjusting Page layout",
     ["Text boxes", "Page layout", "Comments"], f"""
<p>This is the last of the word processing lessons. Text boxes and page setup
are what turn a document from something typed into something arranged.</p>

<h3>Text boxes</h3>
<p>A text box is a container you can place anywhere on the page, separate from
the main flow of text. Insert it, then type into it. Resize with the handles and
drag to move.</p>
<p>You can format the box itself, giving it a fill colour, a border, a shadow,
or a margin between its edge and its text. You set its text wrapping so the body
text behaves around it. And you can link two boxes so that text overflowing the
first carries on in the second, which is how a newsletter runs a story across
columns.</p>
<p>Text boxes suit pull quotes, side notes, captions, and labels on
diagrams.</p>

<h3>Page layout</h3>
<ul>
<li><strong>Margins.</strong> The white space around the edge. Add a
<strong>gutter</strong>, which is extra space on the inside edge, when the
document will be bound.</li>
<li><strong>Orientation.</strong> Portrait is taller than wide. Landscape is
wider than tall, and suits wide tables and charts.</li>
<li><strong>Size.</strong> A4 is standard here. Letter is American and will
print with the wrong margins.</li>
<li><strong>Columns.</strong> Two or three for a newsletter.</li>
<li><strong>Page break.</strong> Ctrl and Enter starts a new page. Use this
rather than pressing Enter many times, because that falls apart as soon as
anything above it changes.</li>
<li><strong>Section break.</strong> Starts a new part of the document that can
have its own margins, orientation and numbering. This is how one document holds
both portrait and landscape pages.</li>
<li><strong>Headers and footers.</strong> Repeated at the top and bottom of
every page, and where page numbers belong.</li>
</ul>

<h3>Comments</h3>
<p>Select the text, then insert a comment and type. It appears in the margin
with your name and the date. Comments are for feedback and questions. They mark
the document without changing it, and they do not print unless you ask for
them.</p>
<p>Others can reply to a comment, and a comment can be marked as resolved once
it has been dealt with. This is how a teacher marks work on screen, and how
several people review one document without all of them editing at once.</p>
<p>Track changes is related but different. Comments say something about the
text. Track changes records actual edits so that they can be accepted or
rejected later.</p>

{short(
 "A text box sits anywhere on the page, separate from the main text.",
 "A page break starts a new page. A section break starts a new part with its "
 "own layout.",
 "Section breaks are how one document mixes portrait and landscape.",
 "Comments mark a document without changing it.")}

{quiz(
 ("What is the difference between a page break and a section break?",
  "A page break simply starts a new page with the same layout. A section break "
  "starts a new part of the document which can have different margins, "
  "orientation and page numbering."),
 ("A report is mostly portrait but has one wide table that needs landscape. "
  "How is that done?",
  "Insert a section break before and after the table, then set the orientation "
  "of that section alone to landscape."),
 ("What is a gutter margin and when is it used?",
  "Extra space added to the inside edge of the page, used when the document is "
  "to be bound so that text is not lost in the binding."))}
""")


note("Lower Sixth", 32, 9, "Introduction to spreadsheets",
     ["The parts of a worksheet", "Selecting cells and ranges",
      "Editing and formatting"], f"""
<p>A spreadsheet is a grid that recalculates. Change one number and everything
depending on it updates by itself, at once and without being asked. That single
property is why the spreadsheet replaced the ledger book.</p>

{fig("spreadsheet_grid", "The parts of a worksheet")}

<h3>The words you need</h3>
<ul>
<li>A <strong>column</strong> runs down the sheet and is labelled with letters.
A <strong>row</strong> runs across and is numbered.</li>
<li>A <strong>cell</strong> is where a column and a row meet, and it is the
basic unit.</li>
<li>A <strong>cell address</strong> is the column letter followed by the row
number. C5 means column C, row 5, and it is always written in that order.</li>
<li>A <strong>range</strong> is a block of cells, written first to last with a
colon between. A1:A10 is a column of ten. A1:C10 is a rectangle of thirty.</li>
<li>A <strong>formula</strong> calculates something, and it always begins with
an equals sign.</li>
<li>A <strong>function</strong> is a ready made formula with a name, such as
SUM.</li>
<li>A <strong>worksheet</strong> is one grid. A <strong>workbook</strong> is
the file, and it can hold many worksheets.</li>
<li>The <strong>active cell</strong> is the one selected, shown by a heavy
border, with its address in the name box.</li>
</ul>

<h3>Selecting</h3>
<p>Click a cell to select it. Click and drag for a range, or click the first
cell and hold Shift while clicking the last. Click a letter for a whole column,
or a number for a whole row. Press Ctrl and A for the whole sheet.</p>
<p>For cells that are <strong>not next to each other</strong>, select the
first, then hold <strong>Ctrl</strong> while clicking the others. That is how
you total January, April and July without the months in between.</p>

<h3>Editing and formatting</h3>
<p>Type to enter a value. Press F2 or use the formula bar to change one. Press
Delete to clear it.</p>
<p>The <strong>fill handle</strong> is the small square at the bottom right of
the selection. Drag it to copy a formula down a column, or to continue a series
such as Jan, Feb, Mar.</p>
<p><strong>Number formats</strong> change how a value is shown, not the value
stored, which is why a cell showing 3 may really hold 3.4999. <strong>Freeze
panes</strong> keeps the heading row visible while you scroll, and it is
essential on any sheet longer than a screen. If a cell shows a row of hash
marks, the column is simply too narrow. Widen it, because nothing is wrong with
the data.</p>

{short(
 "A cell address is the column letter then the row number.",
 "A range is written with a colon, as in A1:C10.",
 "Every formula begins with an equals sign.",
 "Hold Ctrl to select cells that are not next to each other.")}

{quiz(
 ("Write the address of the cell in column D, row 12.",
  "D12. The column letter comes first, then the row number."),
 ("What does the range B2:D10 refer to, and how many cells does it hold?",
  "The rectangle from B2 to D10, which is three columns by nine rows, so 27 "
  "cells."),
 ("A cell shows a row of hash marks. What does that mean?",
  "The column is too narrow to display the number. Widening the column fixes "
  "it, and the data itself is unaffected."))}
""")


note("Lower Sixth", 33, 9, "Performing calculations using spreadsheets",
     ["Arithmetic in a spreadsheet", "SUM, AVERAGE, COUNT, PRODUCT, IF, COUNTIF",
      "AI features in spreadsheets"], f"""
<p>Now the grid earns its keep. Every formula begins with an equals sign.
Without it the spreadsheet stores exactly what you typed as text and calculates
nothing at all.</p>

<h3>Plain arithmetic</h3>
<p>Use <code>+</code> to add, <code>-</code> to subtract, <code>*</code> to
multiply, <code>/</code> to divide and <code>^</code> to raise to a power. So
<code>=A1+B1</code> adds two cells and <code>=A1^2</code> squares one.</p>
<p>Always use <strong>cell references</strong> rather than typed numbers.
<code>=A1*B1</code> updates when the data changes. <code>=25*4</code> does not,
and that is the most damaging habit in spreadsheet work.</p>
<p>The order of operations follows BODMAS, so use brackets freely.
<code>=(A1+B1)/2</code> is the average of two numbers, while
<code>=A1+B1/2</code> is something quite different.</p>

<h3>The six functions</h3>
<ul>
<li><code>=SUM(A1:A10)</code> adds every number in the range.</li>
<li><code>=AVERAGE(B2:B40)</code> gives the mean. Empty cells are ignored,
which is not the same as counting them as zero.</li>
<li><code>=COUNT(A1:A10)</code> counts the cells holding numbers. Use COUNTA to
count non empty cells of any kind.</li>
<li><code>=PRODUCT(A1:A3)</code> multiplies the range together.</li>
<li><code>=IF(condition, value if true, value if false)</code> tests something
and returns one of two answers. Text inside a formula goes in quotation
marks.</li>
<li><code>=COUNTIF(range, condition)</code> counts only the cells that meet the
condition.</li>
</ul>

<h3>A class mark sheet</h3>
<p>Suppose marks sit in C2 to C40.</p>
<ul>
<li>Total of all marks. <code>=SUM(C2:C40)</code></li>
<li>Class average. <code>=AVERAGE(C2:C40)</code></li>
<li>Pass or fail for the first student.
<code>=IF(C2&gt;=50,"Pass","Fail")</code></li>
<li>How many passed. <code>=COUNTIF(C2:C40,"&gt;=50")</code></li>
<li>How many were graded A. <code>=COUNTIF(D2:D40,"A")</code></li>
</ul>

<h3>Nesting IF for grades</h3>
<p>A grade needs more than two outcomes, so put one IF inside another. Work from
the <strong>highest boundary downwards</strong>, because the first condition
that is true wins and everything after it is ignored.</p>
<pre><code>=IF(C2&gt;=70,"A",IF(C2&gt;=60,"B",IF(C2&gt;=50,"C","F")))</code></pre>
<p>Read it aloud. If the mark is 70 or more, A. Otherwise if it is 60 or more,
B. Otherwise if it is 50 or more, C. Otherwise F. Written the other way round,
from the lowest upwards, every mark above 50 would be given a C and stop
there.</p>

<h3>What AI has added</h3>
<p>Some spreadsheets now notice a pattern in a column and offer to continue it,
forecast a series forward from its history, answer a plain English question such
as which month had the highest sales, suggest the formula they think you meant,
and highlight values that do not fit the pattern, which often reveals a typing
mistake.</p>

{short(
 "Every formula begins with an equals sign.",
 "Use cell references, never typed numbers.",
 "IF takes a condition, then the answer if true, then the answer if false.",
 "Nest IF from the highest boundary downwards.")}

{quiz(
 ("Write a formula to find the average of the values in B2 to B25.",
  "=AVERAGE(B2:B25)"),
 ("Write a formula that shows Pass if cell D5 holds 50 or more, and Fail "
  "otherwise.",
  '=IF(D5>=50,"Pass","Fail")'),
 ("Why must a nested IF for grades start from the highest boundary?",
  "Because the first condition that is true is the one used. Testing the "
  "lowest boundary first would give the lowest grade to every mark above "
  "it."))}
""")


note("Lower Sixth", 34, 10, "Types of cells referencing and calculations",
     ["Relative, absolute and mixed references", "Using RANK",
      "Building a mark sheet"], f"""
<p>This is the lesson that separates people who use a spreadsheet from people
who fight one. When you copy a formula, some of its references should move with
it and some should stay exactly where they are. The dollar sign is how you say
which.</p>

<h3>The three types</h3>
<ul>
<li><strong>Relative</strong>, written <code>A1</code>. Both the column and the
row move with the formula. Copy <code>=A1*2</code> from B1 down to B2 and it
becomes <code>=A2*2</code>. This is the default and it is what you want most of
the time.</li>
<li><strong>Absolute</strong>, written <code>$A$1</code>. Nothing changes,
however far you copy it. Use it for a fixed value that every row needs, such as
a tax rate sitting in one cell.</li>
<li><strong>Mixed</strong>, written <code>$A1</code> or <code>A$1</code>. The
first locks the column and lets the row move. The second locks the row and lets
the column move. Useful for grids such as multiplication tables.</li>
</ul>
<p>The <strong>F4</strong> key moves a reference through all four states as you
type it.</p>

<h3>Why it matters</h3>
{fig("cell_ref", "The same formula copied down, with and without the dollar signs")}
<p>Suppose the tax rate sits in cell E1 and prices run down column B. If you
write <code>=B2*E1</code> in C2 and copy it down, C3 becomes
<code>=B3*E2</code> and C4 becomes <code>=B4*E3</code>, pointing at empty cells
below the rate. Every answer after the first is zero, and nothing on the screen
tells you why.</p>
<p>Write <code>=B2*$E$1</code> instead and copy it down. The price reference
moves and the rate reference stays. Every row is right.</p>
<p>That is the whole lesson. Ask of every reference in a formula you are about
to copy, should this one move?</p>

<h3>RANK</h3>
<p>The form is <code>=RANK(number, range, order)</code>. Order 0, or leaving it
out, ranks the highest first. Order 1 ranks the lowest first.</p>
<p>For class position from marks in C2 to C40, put this in D2 and copy it
down.</p>
<pre><code>=RANK(C2,$C$2:$C$40,0)</code></pre>
<p>The range must be absolute. With a relative range each row would be ranked
against a different and shrinking list, and the positions would be nonsense.
Equal marks are given the same rank and the next rank is skipped, so two
students tied at second means the next is fourth.</p>

<h3>Try this</h3>
<p>Build a mark sheet with names, marks in four subjects, a total, an average, a
grade by nested IF, a position by RANK, and a count of passes by COUNTIF. Every
formula must be written once and copied. If one breaks when copied, you have
found a reference that needed locking.</p>

{short(
 "Relative references move when copied. Absolute references do not.",
 "Write $E$1 to fix a reference that every row must use.",
 "F4 moves a reference through the four states.",
 "RANK needs an absolute range, or every row ranks against a different "
 "list.")}

{quiz(
 ("Give the difference between relative and absolute cell referencing.",
  "A relative reference such as A1 changes as the formula is copied to other "
  "cells. An absolute reference such as $A$1 stays on the same cell however "
  "the formula is copied."),
 ("A formula multiplying prices by a rate in E1 works in the first row and "
  "gives zeros below. Explain and correct it.",
  "The reference to E1 is relative, so it moved down as the formula was copied "
  "and now points at empty cells. Change it to $E$1."),
 ("Two students score 78 and are ranked second. What rank does the next "
  "student get?",
  "Fourth. RANK gives tied values the same rank and then skips the position in "
  "between."))}
""")


note("Lower Sixth", 35, 10, "Positive and Negative Uses of Computer Systems",
     ["The good uses", "The harmful uses", "Social and economic effects",
      "Using ICT responsibly"], f"""
<p>Every technology cuts both ways. This topic asks you to weigh both sides
rather than argue for one, and an answer that gives only the good or only the
harm has told half the story.</p>

<h3>The good</h3>
<ul>
<li><strong>Communication.</strong> A message to a relative abroad costs
nothing and arrives at once, where a letter once took weeks.</li>
<li><strong>Education.</strong> Online courses, digital libraries and recorded
lessons reaching schools that have no specialist teacher in a subject.</li>
<li><strong>Health.</strong> Patient records, consultation at a distance,
faster and more accurate diagnosis.</li>
<li><strong>Money and trade.</strong> Mobile money has given accounts to people
who never had a bank. Small traders reach customers they could not travel
to.</li>
<li><strong>Work.</strong> Whole kinds of job exist that did not before, and
people here can work remotely for employers in other countries.</li>
<li><strong>Government.</strong> Applications online, digital identity,
published records.</li>
<li><strong>Farming.</strong> Weather forecasts, market prices and disease
identification delivered to a phone.</li>
<li><strong>Culture.</strong> Recording languages, music and oral history that
would otherwise be lost.</li>
</ul>

<h3>The harm</h3>
<ul>
<li><strong>Lost work.</strong> Automation removes routine jobs faster than it
creates replacements suited to the same people.</li>
<li><strong>Crime.</strong> Fraud, hacking, identity theft and online scams, at
a scale and distance that were impossible before.</li>
<li><strong>Privacy.</strong> Watching and data gathering on a scale nobody
really agreed to.</li>
<li><strong>False information.</strong> Untrue news travels further and faster
than any correction.</li>
<li><strong>Health.</strong> Sitting still for hours, eye strain, poor sleep
and real dependence on devices.</li>
<li><strong>Society.</strong> Bullying online, isolation, families in one room
on four screens.</li>
<li><strong>Culture.</strong> Local languages and customs squeezed out by the
dominant cultures of the internet.</li>
<li><strong>The digital divide.</strong> Those without access fall further
behind every year.</li>
</ul>

<h3>Effects on money and on society</h3>
<p>On money, computers raise output, create new industries and lower the cost
of doing business, while displacing workers and gathering wealth in the hands of
those who own the technology rather than those who use it.</p>
<p>On society, people connect across distance more easily than at any time in
history and often less well with those in the same room. Information is
everywhere available and so is falsehood. Both halves of each of those sentences
are true at once, and saying so plainly is the honest answer.</p>

<h3>Using it responsibly</h3>
<p>Check before you share, because forwarding a false message makes you part of
the problem whatever you intended. Treat people online as you would face to
face. Use ICT to record and spread your own language and culture, not only to
consume other people's. Guard your own and other people's personal data. Keep
screen time in proportion to the rest of life. And help somebody who has less
access than you, which is the practical answer to the digital divide.</p>

{short(
 "Computers help communication, education, health, trade, work, government and "
 "farming.",
 "They also bring lost work, crime, lost privacy, false information and "
 "cultural loss.",
 "The gains and the harms are both real and both should be stated.",
 "Check before sharing, and guard personal data.")}

{quiz(
 ("Give three good and three harmful uses of computer systems.",
  "Good. Instant low cost communication, education through online resources, "
  "and mobile money giving people financial access. Harmful. Fraud and "
  "identity theft, loss of routine jobs to automation, and the spread of false "
  "information."),
 ("How has mobile money affected Cameroon?",
  "It has given financial services to large numbers of people who never held a "
  "bank account, letting them send, receive and store money and trade beyond "
  "their own area."),
 ("What is meant by cultural erosion here?",
  "The weakening of local languages, customs and traditions as dominant online "
  "cultures and languages take their place."))}
""")


note("Lower Sixth", 36, 11, "Computer Ethics, Legislation and Cameroon Law",
     ["A code of ethics for computer users", "Cameroon law",
      "New problems from AI"], f"""
<p>Ethics is what you should do. Law is what you must do. They overlap and they
are not the same, and the difference is worth stating clearly.</p>

{box("Computer ethics", "the moral principles that guide how people use "
     "computers and information, concerned with what is right and not only "
     "with what is legal.")}

<h3>What is asked of a computer user</h3>
<ul>
<li>Do not use a computer to harm other people.</li>
<li>Do not interfere with other people's computer work.</li>
<li>Do not look through other people's files.</li>
<li>Do not use a computer to steal, or to lie.</li>
<li>Do not copy or use software you have not paid for.</li>
<li>Do not use other people's resources without permission.</li>
<li>Do not claim other people's work as your own.</li>
<li>Think about the effect on society of the program you write.</li>
<li>Use computers with consideration and respect for other people.</li>
</ul>

<h3>Cameroon law</h3>
<p>The main text is Law No. 2010/012 of 21 December 2010, on cybersecurity and
cybercrime in Cameroon. Alongside it sits Law No. 2010/013 on electronic
communications, and the OAPI framework covering intellectual property. Confirm
these references with your teacher before quoting them in written work.</p>
<p>Acts punished under the cybersecurity law include gaining access to a
computer system without permission, altering or destroying data belonging to
another person, spreading a virus, electronic fraud, identity theft, producing
or distributing child pornography, stalking and harassment online, intercepting
communications without authority, and software piracy.</p>
<p>The penalties run to heavy fines and to imprisonment, and the law covers acts
committed from Cameroon or affecting people in it.</p>

<h3>Where the line falls</h3>
<p>Some things are wrong without being crimes. Reading a friend's messages over
their shoulder, or using the office printer for personal work, are unkind or
dishonest rather than illegal.</p>
<p>Some things are both. Breaking into a company's server, installing pirated
software, or pretending to be somebody else to get money.</p>
<p>And some things are legal yet hard to defend, such as a company collecting
far more personal data than it needs, buried in terms nobody reads. That third
group is the interesting one.</p>

<h3>The newer problems</h3>
<ul>
<li><strong>Material written by AI.</strong> Who owns it, and must its use be
declared? Handing it in as your own work is dishonest whatever the tool's terms
say.</li>
<li><strong>Deepfakes.</strong> Convincing fake video or audio of a real
person, used for fraud, for revenge and for political mischief. What makes them
dangerous is that they are cheap to make, convincing, and very hard to disprove
once they have spread.</li>
<li><strong>Unfair automatic decisions.</strong> A system that disadvantages a
group because the data it learned from did. This matters most where it decides
loans, jobs or bail.</li>
<li><strong>Who answers.</strong> When an automatic system harms somebody, the
law often cannot yet say clearly who is responsible.</li>
</ul>

{short(
 "Ethics is what you should do. Law is what you must do.",
 "Law No. 2010/012 of 2010 covers cybersecurity and cybercrime in Cameroon.",
 "Hacking, electronic fraud, identity theft and piracy are all punished under "
 "it.",
 "Deepfakes are dangerous because they are cheap, convincing and hard to "
 "disprove.")}

{quiz(
 ("Give the difference between an unethical act and an illegal act, with an "
  "example of each.",
  "An unethical act breaks a moral principle but may not break the law, such "
  "as reading a colleague's messages without permission. An illegal act breaks "
  "the law and is punished, such as gaining access to a computer system without "
  "permission."),
 ("Name the main Cameroonian law on cybercrime.",
  "Law No. 2010/012 of 21 December 2010, relating to cybersecurity and "
  "cybercriminality in Cameroon."),
 ("Why are deepfakes considered dangerous?",
  "Because they are cheap to produce, convincing enough to be believed, and "
  "very hard to disprove once they have spread, so the harm is done before any "
  "correction reaches the same audience."))}
""")


note("Lower Sixth", 37, 11,
     "Data Protection, Copyright and the Digital Divide",
     ["Data protection", "Copyright", "The digital divide"], f"""
<p>Three connected ideas. Who controls information about you, who owns what
people create, and who is left behind when everything moves online.</p>

<h3>Data protection</h3>
{box("Data protection", "the law and practice governing how personal data "
     "about identifiable people is collected, stored, used and shared.")}
<p>The principles are much the same wherever they are written down. Collect
data lawfully and fairly, with the person's knowledge. Use it only for the
purpose you stated. Collect no more than you need. Keep it accurate. Do not keep
it longer than necessary. Keep it secure. And let people see what you hold about
them and have mistakes corrected.</p>
<p>In Cameroon, data security sits inside Law No. 2010/012. The framework most
often quoted internationally is the European GDPR, which is worth knowing
because it applies to any organisation handling European citizens' data wherever
that organisation happens to be.</p>

<h3>Copyright</h3>
<ul>
<li>Copyright protects original creative work, whether writing, music, images,
film or software, and it begins <strong>automatically at the moment of
creation</strong>. There is no need to register it.</li>
<li>It gives the creator control over copying, distribution, adaptation and
public performance.</li>
<li>In Cameroon, copyright operates under national law within the OAPI regional
framework.</li>
<li><strong>Software piracy</strong> means installing one licence on many
machines, downloading cracked programs, or sharing licence keys.</li>
<li><strong>Plagiarism</strong> means presenting somebody else's work as your
own. It is not always illegal and it is always dishonest.</li>
<li><strong>Fair dealing</strong> allows limited use for education, criticism,
news and research, with credit given.</li>
<li><strong>Open source and Creative Commons</strong> licences grant rights in
advance. Read the licence, because some require credit and some forbid
commercial use.</li>
</ul>

<h3>The digital divide</h3>
{box("Digital divide", "the gap between those who have access to information "
     "and communication technology, and the skills to use it, and those who do "
     "not.")}
<p>It is caused by the cost of devices and data, by no electricity or an
unreliable supply, by no network coverage in rural areas, by not being able to
read or having no digital skills, by content existing only in foreign languages,
and by differences between town and countryside.</p>
<p>Its effect is that those without access lose out on education, work,
government services and information, and the gap grows wider with every passing
year.</p>
<p>It can be narrowed by community ICT centres and school computer rooms opened
outside teaching hours, cheaper devices and data, extending electricity and
network coverage, digital skills training for adults as well as children,
content in local languages, public wireless access, and designing government
services so they work on a basic phone.</p>

{short(
 "Data protection governs how personal information is collected and used.",
 "Copyright begins automatically when a work is created. No registration is "
 "needed.",
 "Piracy is unlawful copying. Plagiarism is claiming somebody's work as your "
 "own.",
 "The digital divide is closed by access, affordability, skills and local "
 "language content.")}

{quiz(
 ("When does copyright begin, and must it be registered?",
  "It begins automatically at the moment the original work is created, and no "
  "registration is required."),
 ("Give the difference between software piracy and plagiarism.",
  "Piracy is unlawfully copying, installing or distributing software against "
  "its licence. Plagiarism is presenting somebody else's work as your own "
  "without credit."),
 ("Suggest three practical ways to narrow the digital divide in your "
  "community.",
  "Open the school computer room outside teaching hours. Run digital skills "
  "classes for adults and for young people out of school. Provide services in "
  "local languages and make them work on a basic phone."))}
""")


note("Lower Sixth", 38, 11,
     "Protecting Computer Systems from Illegal Access",
     ["Security, reliability and resilience", "Ways to keep people out",
      "Backup"], f"""
<p>Security means keeping people out. Reliability means working correctly.
Resilience means carrying on when something has already gone wrong. They are
three different qualities and a serious system needs all three.</p>

<h3>Keeping people out</h3>
<ul>
<li><strong>Passwords.</strong> Something you know. A strong one is long, mixes
capitals, small letters, digits and symbols, avoids dictionary words and names,
and differs on every account. Length matters more than symbols. Passwords can
be guessed, stolen, or written on a note under the keyboard.</li>
<li><strong>Two factor authentication.</strong> Something you know together
with something you have, such as a code from an app. Even a stolen password is
then not enough by itself.</li>
<li><strong>Encryption.</strong> Scrambling data so that only somebody holding
the key can read it. Data caught in transit is then useless to whoever caught
it. This is what the padlock in a browser stands for.</li>
<li><strong>Biometrics.</strong> Fingerprint, face, iris or voice. These cannot
be forgotten or easily shared. They also cannot be changed once stolen, which is
a real weakness. You can issue a new password. You cannot issue new
fingerprints.</li>
<li><strong>Access levels.</strong> Give each user the least access that lets
them do their job.</li>
<li><strong>Firewall.</strong> Filters traffic coming in and going out.</li>
<li><strong>Physical security.</strong> Locked rooms, cable locks, guards,
cameras, sign in books. A machine anybody can carry out of the building is not
secure however good its password is.</li>
</ul>

<h3>Backup</h3>
{fig("backup_types", "Full, incremental and differential backup")}
<p>Backup is the measure that survives every other measure failing. Whatever
gets past the firewall, the antivirus and the passwords, a recent backup means
you lose time instead of losing data.</p>
<p>A <strong>full</strong> backup copies everything every time. It is the
slowest to make and the simplest to restore.</p>
<p>An <strong>incremental</strong> backup copies only what has changed since
the last backup of any kind. It is the fastest to make and the slowest to
restore, because you need the full backup and every increment since.</p>
<p>A <strong>differential</strong> backup copies everything changed since the
last full backup. It sits between the two. Restoring needs only the full backup
and the latest differential.</p>
<p>The rule to remember is three copies, on two kinds of media, with one of them
kept somewhere else. Keep one copy disconnected, because ransomware encrypts
everything it can reach. And test a restore, because a backup you have never
restored from is only a hope.</p>

{short(
 "Security keeps people out. Reliability works correctly. Resilience recovers "
 "afterwards.",
 "Encryption makes data unreadable to anybody without the key.",
 "Biometric data cannot be changed once it is stolen.",
 "Three copies, two kinds of media, one kept elsewhere.")}

{quiz(
 ("Define encryption.",
  "Scrambling data so that it can only be read by somebody holding the correct "
  "key, which makes intercepted data useless."),
 ("Give one advantage and one disadvantage of biometric authentication.",
  "It cannot be forgotten or easily shared, and it identifies the person "
  "rather than a card they carry. Its disadvantage is that biometric data "
  "cannot be changed if it is ever stolen."),
 ("Why should one backup copy be kept disconnected from the network?",
  "Because ransomware encrypts every file it can reach, so a copy that is "
  "offline can still be used to recover."))}
""")


note("Lower Sixth", 39, 11,
     "System Recovery and Safe Working Practices",
     ["Why recovery matters", "Recovery measures", "Safe working"], f"""
<p>The last lesson was about stopping bad things happening. This one accepts
that some of them will happen anyway, and asks how quickly you get back on your
feet.</p>

<h3>Why recovery matters</h3>
<p>Data is usually worth far more than the hardware holding it. A stolen laptop
costs the price of a laptop. The only copy of a term's records costs the term.
Downtime costs money and trust, and trust is slower to rebuild. Some records
must be kept by law, and saying the disk failed is not a defence. And work
already done is lost twice, once in the data and again in the time spent doing
it over.</p>

<h3>Recovery measures</h3>
<ul>
<li><strong>Regular backups that have been tested</strong>, with at least one
copy kept somewhere else.</li>
<li><strong>A disaster recovery plan.</strong> A written document saying what
happens, in what order, and who does it. It should name the person responsible,
list what gets restored first, and say where the backup media are. It is written
before it is needed, not during.</li>
<li><strong>Restore points and system images</strong>, so a machine can be
rolled back to a known good state.</li>
<li><strong>Duplication.</strong> Disk arrays so one failed disk loses nothing,
a second server, a second internet line.</li>
<li><strong>An uninterruptible power supply</strong>, which keeps machines
alive long enough to shut down cleanly. Given our power supply this is not
optional.</li>
<li><strong>Practice.</strong> Try the restore before the day you need it, and
time how long it takes.</li>
</ul>

<h3>Privacy at work</h3>
<p>Lock the screen whenever you leave the desk. Do not leave sensitive documents
on the printer. Watch for people reading over your shoulder in a shared room,
especially while you type a password. Do not discuss confidential matters where
you can be overheard. Shred paper holding personal data, and wipe drives before
throwing them out, because deleting a file removes the entry in the directory
and not the data itself.</p>

<h3>Safe working</h3>
<p>Log out rather than closing the lid, so nobody else uses your session. Do not
open attachments from senders you do not know, because that is how most harmful
software arrives. Do not plug in a flash drive you found, because that is a
known and effective attack. Keep software and antivirus updated. Use a standard
account rather than an administrator account for daily work. Do not install
unapproved software on an organisation's machine. And report anything suspicious
rather than investigating it yourself.</p>

{short(
 "Data is usually worth more than the hardware holding it.",
 "A disaster recovery plan is written before it is needed.",
 "Deleting a file does not remove the data from the disk.",
 "Lock your screen, and use a standard account for daily work.")}

{quiz(
 ("What is a disaster recovery plan and what should it contain?",
  "A written document prepared in advance saying what happens after a serious "
  "failure. Who is responsible, in what order systems are restored, where the "
  "backups are kept, and who to contact."),
 ("Why does deleting a file not make the data safe from recovery?",
  "Deleting removes the directory entry pointing to the file, but the data "
  "stays on the disk until something overwrites it, and it can be recovered "
  "with ordinary software."),
 ("Give two safe working practices and say what each prevents.",
  "Locking the screen when you leave the desk prevents somebody else using "
  "your session and your access rights. Using a standard account prevents "
  "harmful software gaining full control of the system."))}
""")


note("Lower Sixth", 40, 12, "Computer Crimes and Combat Measures",
     ["Computer as target or as tool", "The crimes",
      "Matching crimes to defences"], f"""
<p>One idea runs through this whole topic, and it turns on a single question.
Was the computer the <strong>target</strong>, or was it the
<strong>tool</strong>?</p>

<h3>The two groups</h3>
<p>In a <strong>computer related</strong> crime the computer system is the
target. The crime could not exist without computers at all. Hacking, spreading
harmful software, flooding a system so nobody else can use it, defacing a
website, stealing data.</p>
<p>In a <strong>computer assisted</strong> crime the computer is only the tool.
The crime existed long before computers and the computer made it easier. Fraud,
forgery, theft, harassment, distributing illegal material.</p>

<h3>The crimes</h3>
<ul>
<li><strong>Hacking.</strong> Getting into a computer system without
permission.</li>
<li><strong>Phishing.</strong> A fake message or website that tricks somebody
into giving up their password. This is how most large break-ins begin.</li>
<li><strong>Identity theft.</strong> Using somebody's personal details to
pretend to be them.</li>
<li><strong>Copyright infringement.</strong> Unlawful copying and
distribution.</li>
<li><strong>Plagiarism.</strong> Passing off another's work as your own.</li>
<li><strong>Fraud.</strong> Getting money or goods by deception, including
mobile money scams.</li>
<li><strong>Bullying and stalking online.</strong></li>
<li><strong>Denial of service.</strong> Flooding a system with traffic so that
real users cannot get through.</li>
<li><strong>Ransomware.</strong> Encrypting somebody's files and demanding
payment.</li>
</ul>

<h3>Matching the defence to the crime</h3>
<ul>
<li><strong>Hacking.</strong> Strong passwords, two factor authentication,
firewalls, prompt patching, access levels.</li>
<li><strong>Phishing.</strong> Training people, because the attack aims at the
person and not the machine. Also spam filters, and checking the sender's real
address.</li>
<li><strong>Identity theft.</strong> Guard personal data, shred documents,
watch your accounts.</li>
<li><strong>Copyright infringement.</strong> Licensing, watermarking,
prosecution.</li>
<li><strong>Plagiarism.</strong> Proper citation, detection software, school
policy.</li>
<li><strong>Fraud.</strong> Verifying transactions, spending limits, automatic
fraud detection, public awareness.</li>
<li><strong>Bullying.</strong> Reporting and blocking tools, school policy,
involving parents, and the law.</li>
<li><strong>Denial of service.</strong> Filtering traffic, limiting rates,
extra capacity.</li>
<li><strong>Ransomware.</strong> Disconnected backups, training, and restricting
administrator rights.</li>
</ul>
<p>Notice that several of these defences are not technical at all. Training,
policy and awareness stop more attacks than software does.</p>

{short(
 "Computer related crime targets the computer. Computer assisted crime uses "
 "the computer as a tool.",
 "Hacking is computer related. Fraud by email is computer assisted.",
 "Phishing aims at the person, so training is the main defence.",
 "A disconnected backup is the answer to ransomware.")}

{quiz(
 ("Put these in a group. Hacking, online fraud, spreading a virus, bullying "
  "online.",
  "Hacking is computer related. Online fraud is computer assisted. Spreading a "
  "virus is computer related. Bullying online is computer assisted."),
 ("What is phishing, and why is training the main defence against it?",
  "A fake message or website designed to trick a person into giving up their "
  "password. Training is the main defence because the attack targets the "
  "person rather than the system."),
 ("Give one defence against ransomware and say why it works.",
  "Keep a backup copy disconnected from the network, because ransomware can "
  "only encrypt what it can reach, so an offline copy allows recovery without "
  "paying."))}
""")


note("Lower Sixth", 41, 12, "Malware, Types and Characteristics",
     ["Virus, worm, Trojan, rootkit, backdoor, spyware",
      "How they spread and what they do", "AI on both sides"], f"""
<p>Malware is harmful software. The types are told apart by two questions. How
does it get in, and how does it spread once it is there?</p>

{box("Malware", "any software written to damage, disrupt or gain unauthorised "
     "access to a computer system.")}

<h3>Virus and worm, the pair that matters most</h3>
{fig("virus_worm", "How each one spreads")}
<p>A <strong>virus</strong> attaches itself to a host file or program and
spreads when that file is run, copied or shared. It needs a person to do
something before it does anything at all.</p>
<p>A <strong>worm</strong> stands alone and needs no host file. It copies itself
across a network with no human action whatever. That is why worms spread so
fast, and it is the single difference worth memorising.</p>

<h3>The others</h3>
<ul>
<li><strong>Trojan horse.</strong> Disguises itself as something useful so that
you install it yourself. It does not copy itself. It opens the door for other
things.</li>
<li><strong>Rootkit.</strong> Buries itself deep in the operating system and
hides both itself and other harmful software from the antivirus. Very hard to
find, and often the only cure is to reinstall the system.</li>
<li><strong>Backdoor.</strong> A hidden way into a system that gets round the
normal checks, left behind for later use.</li>
<li><strong>Spyware.</strong> Quietly gathers information and sends it away. A
<strong>keylogger</strong> records every key you press, passwords
included.</li>
<li><strong>Ransomware.</strong> Encrypts your files and demands payment for
the key.</li>
<li><strong>Adware.</strong> Floods the machine with advertisements.</li>
</ul>

<h3>Sorting them out</h3>
<p>Does it need a host file? A virus does and a worm does not. Does it spread by
itself? A worm does, a virus needs you to run something, and a Trojan does not
spread at all. Is it disguised as something useful? That is a Trojan. Does it
hide other harmful software? That is a rootkit. Does it steal information
quietly? That is spyware.</p>

<h3>AI on both sides</h3>
<p>On the defending side, older antivirus matched files against a list of known
threats, which cannot catch anything new. Systems using artificial intelligence
watch <strong>behaviour</strong> instead. A program that starts rapidly
encrypting your documents is stopped even though nobody has seen that particular
threat before.</p>
<p>On the attacking side, AI writes convincing messages with no spelling
mistakes, in the target's own language, matching the style of a colleague. That
removes the very clues people were taught to look for. It also produces harmful
software that rewrites its own code each time it spreads, so that no fixed
signature ever matches it.</p>

{short(
 "A virus attaches to a host file and needs a person to run it.",
 "A worm stands alone and copies itself across a network by itself.",
 "A Trojan is disguised as something useful and does not copy itself.",
 "Behaviour based detection catches threats nobody has catalogued.")}

{quiz(
 ("Give two differences between a virus and a worm.",
  "A virus attaches itself to a host file while a worm stands alone. A virus "
  "needs a person to run something before it acts, while a worm copies itself "
  "across a network with no human action."),
 ("Why is a rootkit so hard to remove?",
  "Because it buries itself deep in the operating system and actively hides "
  "itself and other harmful software from the antivirus, so often the only "
  "reliable cure is reinstalling the system."),
 ("What is a keylogger and what kind of malware is it?",
  "A program that records every key pressed, capturing passwords and other "
  "private input. It is a form of spyware."))}
""")


note("Lower Sixth", 42, 12,
     "Protecting a Computer System from Malware",
     ["Good habits", "Scanning with an antivirus", "Setting up a firewall"],
     f"""
<p>This is the last topic of the term, and it is done at the machine. Most
infections arrive because somebody clicked something, so habits matter as much
as software does.</p>

<h3>Good habits</h3>
<ul>
<li>Do not open attachments from senders you do not know, and be careful of
unexpected attachments even from senders you do, because their account may have
been taken over.</li>
<li>Scan attachments and flash drives before opening them.</li>
<li>Download software only from the maker's own site or an official store.
Cracked software is the commonest way people infect themselves, because
whoever installs it has already agreed to ignore every warning.</li>
<li>Hover over a link and read the real address before clicking it.</li>
<li>Keep the system and every application updated, because most successful
attacks use holes that were closed months earlier.</li>
<li>Run an antivirus and keep it current.</li>
<li>Turn the firewall on and leave it on.</li>
<li>Use a standard account for daily work.</li>
<li>Back up regularly and keep one copy disconnected.</li>
<li>Turn off autorun for removable media.</li>
</ul>

<h3>Scanning with an antivirus</h3>
<ol>
<li><strong>Update the definitions first.</strong> A scan with an old
definition file misses everything recent, and this is the step people skip.</li>
<li><strong>Choose the type of scan.</strong> A quick scan checks the usual
hiding places in a few minutes. A full scan checks every file and may take
hours. A custom scan checks one drive or folder, which is what you want for a
flash drive.</li>
<li><strong>Run it</strong> and wait.</li>
<li><strong>Read the report.</strong> What was found, where, and what the
software proposes to do about it.</li>
<li><strong>Act.</strong> Clean, quarantine or delete.
<strong>Quarantine</strong> isolates the file so it cannot run without
destroying it, which matters when the detection turns out to be a false
alarm.</li>
<li><strong>Restart and scan again</strong> to check the machine is clean.</li>
<li>For something stubborn, <strong>scan in safe mode</strong>, where most
harmful software has not loaded and can therefore be removed.</li>
</ol>

<h3>Setting up a firewall</h3>
<p>A firewall filters traffic entering and leaving according to rules. In
Windows, open Control Panel and then Windows Defender Firewall, and check that
it is on for both private and public networks. Set incoming connections to be
blocked unless a rule allows them. Add a rule only for a program that genuinely
needs to accept connections, and remove rules for software you no longer use. On
a public network set the profile to Public, which turns off file and printer
sharing.</p>
<p>A firewall controls network traffic. An antivirus finds and removes harmful
software. They do different jobs and you need both.</p>

<h3>Try this</h3>
<p>Update the antivirus definitions and note the date before and after. Run a
quick scan and write down what it reports. Then open the firewall settings and
record whether it is on, what happens to incoming connections by default, and
how many programs have been allowed through.</p>

{short(
 "Most infections start with somebody clicking something.",
 "Update the definitions before you scan.",
 "Quarantine isolates a file without destroying it.",
 "A firewall handles traffic. An antivirus handles files. You need both.")}

{quiz(
 ("Why must antivirus definitions be updated before a scan?",
  "Because the scanner recognises threats by comparing files against its "
  "definition file, so an out of date file will not recognise anything found "
  "since it was issued."),
 ("What does quarantining a file mean, and why is it better than deleting it "
  "at once?",
  "It isolates the file so it cannot run, without destroying it. That allows "
  "the file to be recovered if the detection turns out to be a false alarm."),
 ("Give the difference between a firewall and an antivirus.",
  "A firewall filters network traffic coming in and going out. An antivirus "
  "finds and removes harmful software already on the machine."))}
""")
