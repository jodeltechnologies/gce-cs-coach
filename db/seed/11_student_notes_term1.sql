-- Student lesson notes for the 2026/2027 progression sheets, First Term.
--
-- One note for each lesson that had none. Written to be read by the
-- learner rather than by the teacher, so there is nothing here about
-- examiners or marks. A note that spends its last paragraph coaching a
-- candidate teaches the reader that the topic is worth guessing at
-- rather than worth knowing.
--
-- Bodies are HTML. Figures are PNG files under public/notes/figures and
-- must be uploaded alongside this file, or the pictures will not load.
--
-- Ids are fixed, so running this a second time updates the same rows.

BEGIN;

ALTER TABLE note_sections
  ADD COLUMN IF NOT EXISTS body_format TEXT NOT NULL DEFAULT 'markdown';
ALTER TABLE note_sources
  ADD COLUMN IF NOT EXISTS sequence INTEGER NOT NULL DEFAULT 100,
  ADD COLUMN IF NOT EXISTS syllabus_id UUID REFERENCES syllabi(id);

-- Form 5 Computer Science, First Term 2026/2027
INSERT INTO note_sources (id, title, attribution, sequence) VALUES
  ('947e8ce4-cb63-5847-98b1-d4cc5cf2f67f', 'Form 5 Computer Science, First Term 2026/2027', 'One note per lesson, written for the 2026/2027 progression sheet', 1)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  attribution = EXCLUDED.attribution, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

UPDATE note_sources SET syllabus_id = (
  SELECT id FROM syllabi WHERE form_level = 'Form 5'
    AND deleted_at IS NULL ORDER BY created_at LIMIT 1)
WHERE id = '947e8ce4-cb63-5847-98b1-d4cc5cf2f67f';

-- Lower Sixth ICT, First Term 2026/2027
INSERT INTO note_sources (id, title, attribution, sequence) VALUES
  ('394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lower Sixth ICT, First Term 2026/2027', 'One note per lesson, written for the 2026/2027 progression sheet', 1)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  attribution = EXCLUDED.attribution, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

UPDATE note_sources SET syllabus_id = (
  SELECT id FROM syllabi WHERE form_level = 'Lower Sixth'
    AND deleted_at IS NULL ORDER BY created_at LIMIT 1)
WHERE id = '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec';

-- Form 5 lesson 4: Introduction to Artificial Intelligence
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('c79259fb-122b-56d2-97df-38ecca79a022', '947e8ce4-cb63-5847-98b1-d4cc5cf2f67f', 'Lesson 4',
   'Introduction to Artificial Intelligence',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>What AI is</li><li>How AI grew</li><li>The types of AI around us</li></ul></div>
<p>You have used artificial intelligence already today, probably more than
once. If your phone unlocked when it saw your face, that was AI. If the
keyboard guessed your next word, that was AI. If a message went to the spam
folder before you ever saw it, that was AI too. This lesson gives a name to
something you have been living with for years.</p>

<div class="def-box"><strong>Artificial intelligence.</strong> the branch of computer science that builds machines able to do things that would normally need human intelligence, such as seeing, understanding language, learning from experience and making decisions.</div>

<p>Notice what that sentence does not say. It does not say the machine thinks.
It does not say the machine is awake or aware. It says the machine does jobs
that would need intelligence if a person did them. That is a smaller claim, and
it is the true one.</p>

<h3>How the idea grew</h3>
<p>Artificial intelligence is older than the personal computer. It has had
periods of great excitement followed by long quiet years when the money ran out
and people said it would never work.</p>
<ul>
<li><strong>1950.</strong> Alan Turing asks whether a machine can think. Rather
than argue about the word, he suggests a test. If you hold a conversation by
text and cannot tell whether you are speaking to a person or a machine, then
call the machine intelligent.</li>
<li><strong>1956.</strong> A meeting at Dartmouth College gives the subject its
name. John McCarthy invents the term artificial intelligence.</li>
<li><strong>1997.</strong> A computer called Deep Blue beats Garry Kasparov,
the world chess champion. For the first time a machine has beaten the best
human alive at a game people were proud of.</li>
<li><strong>2011 onward.</strong> Siri arrives, then Alexa. AI leaves the
laboratory and moves into the pocket.</li>
<li><strong>2022 onward.</strong> Tools that write. AI becomes something
anybody with a phone can use.</li>
</ul>

<p>Three things caused the recent rush of progress. There is far more data to
learn from than there used to be. Processing has become cheap. And the methods
themselves have improved, particularly the ones based on neural networks.</p>

<h3>Sorting AI by what it can do</h3>
<ul>
<li><strong>Narrow AI.</strong> Good at one job and helpless at everything
else. A spam filter, a face unlock, a chess program. Every working AI system in
the world today is narrow AI.</li>
<li><strong>General AI.</strong> Could turn its hand to any task a person can,
and carry what it learns from one area into another. This does not exist.</li>
<li><strong>Super AI.</strong> Would be better than people at everything. This
does not exist either, and it may never.</li>
</ul>

<p>The chess program that beat a world champion cannot recognise your face. The
face unlock on your phone cannot play chess. Each one is brilliant inside a
narrow fence and lost outside it. That is what narrow means.</p>

<h3>Sorting AI by how it works</h3>
<ul>
<li><strong>Reactive machines.</strong> No memory at all. They look at the
situation in front of them and respond. Deep Blue worked this way.</li>
<li><strong>Limited memory.</strong> They use recent past data. A self driving
car watches the speed of the car ahead over the last few seconds before it
decides to brake. Almost every useful AI system today works this way.</li>
<li><strong>Theory of mind.</strong> Would understand that people have
feelings and beliefs that shape what they do. Still being researched.</li>
<li><strong>Self aware.</strong> Would know that it exists. Does not
exist.</li>
</ul>

<h3>Three words that are often confused</h3>
<figure class="fig"><img src="/notes/figures/ai_circles.png" alt="Artificial intelligence, machine learning and deep learning"><figcaption>Artificial intelligence, machine learning and deep learning</figcaption></figure>
<p>Artificial intelligence is the whole idea. Machine learning is one way of
doing it, where the system works out its own rules from examples. Deep learning
is one way of doing machine learning, using neural networks with many layers.
Each one sits inside the one before it. A traffic light controller that follows
fixed rules is artificial intelligence with no learning in it at all.</p>

<div class="in-short"><h3>In short</h3><ul><li>AI means machines doing jobs that would normally need human intelligence.</li><li>Every AI system that exists today is narrow. It does one job.</li><li>John McCarthy named the field in 1956.</li><li>All deep learning is machine learning, and all machine learning is AI. It does not work the other way round.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give the meaning of artificial intelligence in one sentence.</p><p class="a">It is the branch of computer science that builds machines able to do things that would normally need human intelligence, such as seeing, understanding language, learning and deciding.</p></li><li><p class="q">A hospital uses a system that reads chest X-rays and marks the ones that may show tuberculosis. What type of AI is it?</p><p class="a">Narrow AI, because it does only that one job. By the second grouping it is a limited memory system, because it learned from stored X-ray images.</p></li><li><p class="q">Why is it wrong to say a self driving car is general AI?</p><p class="a">Because it can only drive. General AI would be able to take on any task a person can, and no such system has been built.</p></li></ol></div>',
   'html', 1)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Form 5 lesson 5: Applications and Ethics of Artificial Intelligence
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('2ee75a6c-e91e-5582-a486-392ac0a2058e', '947e8ce4-cb63-5847-98b1-d4cc5cf2f67f', 'Lesson 5',
   'Applications and Ethics of Artificial Intelligence',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Where AI is used</li><li>AI in different fields</li><li>The problems AI brings</li></ul></div>
<p>The last lesson said what artificial intelligence is. This one asks two
harder questions. Where is it doing good work, and where is it doing harm? Both
halves matter, and an answer that gives only one of them is half an answer.</p>

<h3>Where you meet it</h3>
<ul>
<li><strong>Health.</strong> Reading X-rays and scans, and finding disease
earlier than a tired eye can. Helping to design new medicines.</li>
<li><strong>Farming.</strong> A phone camera that names the disease on a
cassava leaf. Predicting how much a field will yield from rainfall and soil
data.</li>
<li><strong>Banking and mobile money.</strong> Spotting fraud by comparing a
payment against your usual habits, in the time it takes to press send.</li>
<li><strong>Transport.</strong> Finding routes, predicting traffic, driving
vehicles.</li>
<li><strong>Education.</strong> Apps that give you harder questions once you
start getting things right.</li>
<li><strong>Language.</strong> Translation, turning speech into text, and the
keyboard that guesses your next word.</li>
</ul>

<h3>The problems</h3>
<ul>
<li><strong>Bias.</strong> An AI learns from data. If the data it was shown
held mostly light skinned faces, the system will be worse at recognising dark
ones. If a hiring system learned from twenty years of records in which most of
the people hired were men, it learns to prefer men. The machine has no opinion
about anybody. It is copying what it was shown.</li>
<li><strong>Privacy.</strong> These systems are hungry for personal data. Your
face, your voice, where you go, what you buy. Much of it is collected without
anyone really agreeing to it.</li>
<li><strong>Work.</strong> The jobs AI takes first are the repeated ones. Data
entry, simple customer service, basic translation.</li>
<li><strong>Blame.</strong> A self driving car kills someone. Who answers for
it? The owner, the maker, the programmer? The law has not settled this.</li>
<li><strong>Fake material.</strong> Video of a person saying something they
never said. Cheap to make and very hard to disprove once it has spread.</li>
<li><strong>Leaning on it too much.</strong> A skill you never build because
the tool always did it for you.</li>
</ul>

<h3>Using it honestly while you are still at school</h3>
<p>There is a clear line here and it is worth naming. Asking an AI tool to
explain a topic you did not follow in class is good use. It is a patient
teacher available at midnight. Asking it to write your assignment is cheating,
and it also works against you, because on the day of the examination the tool
will not be there and you will not have learned the material.</p>

<p>Use it to understand. Never use it to hand in. And check what it tells you,
because it is confidently wrong often enough to matter.</p>

<div class="in-short"><h3>In short</h3><ul><li>AI is at work in health, farming, banking, transport, education and language.</li><li>Bias comes from the data the system learned from, not from any opinion held by the machine.</li><li>Privacy, lost jobs, unclear blame and fake material are the other main worries.</li><li>Use AI to understand a topic. Do not use it to produce work you hand in.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Name two fields where AI is used and say what it does in each.</p><p class="a">For example, health, where it reads medical scans to find disease early. And banking, where it checks a payment against your usual habits to spot fraud.</p></li><li><p class="q">Explain how bias gets into an AI system.</p><p class="a">The system learns patterns from its training data. If that data leaves out or misrepresents a group of people, the system repeats that fault in every decision it makes.</p></li><li><p class="q">Give one reason a student should not hand in work written by an AI tool.</p><p class="a">It is dishonest, and it also stops the student learning material they will have to know without the tool in front of them.</p></li></ol></div>',
   'html', 2)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Form 5 lesson 6: The use of appropriate Prompts to generate AI responses
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('00890984-e46e-5bb7-947a-dd83eaa73ac8', '947e8ce4-cb63-5847-98b1-d4cc5cf2f67f', 'Lesson 6',
   'The use of appropriate Prompts to generate AI responses',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Looking at what a prompt returns</li><li>Judging the result</li><li>Writing prompts that solve a problem</li></ul></div>
<p>This lesson is done at the machine. A prompt is what you type to an AI tool.
The whole skill rests on one plain fact. A vague prompt gives a vague answer,
and a careful prompt gives a useful one. The tool is not reading your mind. It
reads your sentence, and it fills any gap you leave with a guess.</p>

<div class="def-box"><strong>Prompt.</strong> the instruction or question you give an AI tool, which decides the answer you get back.</div>

<h3>The four parts of a good prompt</h3>
<figure class="fig"><img src="/notes/figures/prompt_parts.png" alt="Role, task, context and format"><figcaption>Role, task, context and format</figcaption></figure>
<p>Leave any one of the four out and the tool has to guess that part for
itself. Most poor answers come from a missing context or a missing format.</p>

<h3>The same question asked badly and well</h3>
<p><strong>Weak.</strong> "Tell me about databases." What comes back is two
pages of general writing, half of it beyond your syllabus. You cannot revise
from it because you cannot tell which parts matter.</p>
<p><strong>Better.</strong> "You are a Form 5 Computer Science teacher. Explain
the difference between data verification and data validation to a student who
has just learned what a database is. Give two examples of each. Keep it under
150 words." What comes back is at your level and in a shape you can copy
straight into your notes.</p>

<h3>Things worth doing</h3>
<ul>
<li>Say how many. "Give three examples" beats "give some examples".</li>
<li>Ask it to show its reasoning. You can then check the working.</li>
<li>Set a limit. A word count, a reading level, or a rule such as do not use a
technical term without explaining it.</li>
<li>Keep going. The first answer is a draft. Reply with "that is too hard,
make it simpler" rather than starting again.</li>
</ul>

<h3>The part people skip</h3>
<p>AI tools produce confident wrong answers. The word for this is
<strong>hallucination</strong>. The tool invents a fact, a date or a formula
and states it in exactly the same tone as everything true it has said. It does
not know it is wrong and it will not warn you. It has no idea what is true. It
produces words that are likely to follow your words.</p>

<p>So everything you take from an AI tool has to be checked against your
textbook, your syllabus or your teacher. A prompt gives you a starting point.
It is never a source.</p>

<h3>Judging what came back</h3>
<p>Ask three questions of any answer. Is it correct, checked against something
you trust? Is it pitched at the right level? And did it answer the whole
question, or did it quietly drop part of it?</p>

<div class="in-short"><h3>In short</h3><ul><li>A prompt is the instruction you give an AI tool.</li><li>A good prompt has four parts. Role, task, context and format.</li><li>Hallucination means the tool states something false with complete confidence.</li><li>Check every answer against a source you trust before you use it.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Name the four parts of a well built prompt.</p><p class="a">Role, task, context and format.</p></li><li><p class="q">Improve this prompt. Write about networks.</p><p class="a">For example. You are a Computer Science teacher. Explain the difference between a LAN and a WAN to a Form 5 student, with two examples of each, in under 150 words. That adds a role, a context and a format.</p></li><li><p class="q">What is a hallucination?</p><p class="a">When an AI tool produces information that is false or invented but states it as confidently as it states anything true.</p></li></ol></div>',
   'html', 3)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 1: History and Evolution of Computing
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('a52dc80f-f196-5162-bae1-60ee052822d1', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 1',
   'History and Evolution of Computing',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>The generations of computers</li><li>How size, power and price changed</li><li>Von Neumann and Harvard architecture</li><li>The stored program idea</li></ul></div>
<p>Computers are usually divided into five generations, and each one is named
after the switch it was built from. Learn the switch and the rest follows,
because every generation is smaller, faster, cheaper, cooler and more reliable
than the one before it.</p>

<figure class="fig"><img src="/notes/figures/generations.png" alt="Five generations, and the direction of travel"><figcaption>Five generations, and the direction of travel</figcaption></figure>

<ul>
<li><strong>First, 1945 to 1955. Vacuum tubes.</strong> Machines that filled a
room, drank electricity and gave off heat that caused most of the faults.
Instructions in machine language only. Punched cards in, printouts out.</li>
<li><strong>Second, 1955 to 1965. Transistors.</strong> Smaller, faster,
cheaper and much cooler. Assembly language arrives, then COBOL and
FORTRAN.</li>
<li><strong>Third, 1965 to 1980. Integrated circuits.</strong> Many transistors
on one chip. The keyboard and the screen replace cards and printouts. An
operating system now runs several programs at once.</li>
<li><strong>Fourth, from 1980. The microprocessor.</strong> Thousands of
circuits on a single chip. What filled a room now fits in the hand. Personal
computers, networks and the mouse.</li>
<li><strong>Fifth, now. Artificial intelligence.</strong> Many processors
working side by side, and machines that learn. Speaking to a computer is
ordinary.</li>
</ul>

<h3>The stored program idea</h3>
<div class="def-box"><strong>Stored program concept.</strong> the idea that a computer keeps its instructions in the same memory as its data, so the machine can be given a new job by loading a new program instead of being rewired.</div>

<p>It is hard now to see how large a change this was. Before it, altering what
ENIAC did meant a team physically moving cables for days. After it, you load a
different program in seconds and the same machine does something completely
different. This one idea is the reason a computer can do any job, while a
calculator can only do sums.</p>

<h3>Two ways to arrange a computer</h3>
<figure class="fig"><img src="/notes/figures/vn_harvard.png" alt="One bus, or two"><figcaption>One bus, or two</figcaption></figure>
<p>In the <strong>Von Neumann</strong> arrangement there is one memory holding
both instructions and data, and one bus carrying both. It is simple and cheap
to build. Its weakness has a name. Instructions and data must take turns on the
same road, and that is called the Von Neumann bottleneck.</p>
<p>In the <strong>Harvard</strong> arrangement there are separate memories and
separate buses for instructions and for data. Both can move at the same moment,
so the machine runs faster. It costs more, so it is used where speed matters
most, in signal processors and in small control chips.</p>

<div class="in-short"><h3>In short</h3><ul><li>Five generations. Vacuum tube, transistor, integrated circuit, microprocessor, artificial intelligence.</li><li>Across the generations machines became smaller, faster, cheaper, cooler and more reliable.</li><li>The stored program idea lets one machine do any job by loading a new program.</li><li>Harvard uses separate buses for instructions and data, so both can move at once. Von Neumann shares one bus.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Name the switch used in each of the five generations.</p><p class="a">Vacuum tube, transistor, integrated circuit, microprocessor, and artificial intelligence with parallel processing.</p></li><li><p class="q">State the stored program idea.</p><p class="a">That instructions are held in the same memory as data, so a computer can be given a new task by loading a new program rather than being rewired.</p></li><li><p class="q">What is the Von Neumann bottleneck?</p><p class="a">The limit on speed caused by instructions and data having to share one bus between the processor and the memory.</p></li></ol></div>',
   'html', 1)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 3: AI Ethics and Responsible Use
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('00e5d24a-38cc-5d18-ae06-97275d3c7244', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 3',
   'AI Ethics and Responsible Use',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>The problems AI raises</li><li>Its risks and its benefits</li><li>Rules for using it responsibly</li></ul></div>
<p>Artificial intelligence is a tool, and the questions we ask of it are the
ones we ask of any powerful tool. Who does it help? Who does it harm? And who
answers when it goes wrong?</p>

<h3>The good, stated fairly</h3>
<ul>
<li><strong>Speed.</strong> A system reads ten thousand scans in the time a
doctor reads ten.</li>
<li><strong>Steadiness.</strong> It treats the first case and the ten
thousandth by the same standard. People get tired and their judgement
drifts.</li>
<li><strong>Reach.</strong> Expert help in places that have no expert. Crop
disease named in a village with no agronomist.</li>
<li><strong>Cost.</strong> Services that were once only for the rich become
affordable.</li>
<li><strong>Dull and dangerous work.</strong> Inspecting the inside of a pipe,
watching a machine all night.</li>
</ul>

<h3>The harm</h3>
<ul>
<li><strong>Bias.</strong> The system learns whatever the data taught it,
including our prejudices. This has been measured in real products, not
imagined.</li>
<li><strong>Privacy.</strong> The data these systems need is data about
people.</li>
<li><strong>The black box.</strong> Often nobody, including the people who
built it, can say why the system gave that answer. That is hard to accept when
the answer refuses somebody a loan.</li>
<li><strong>Lost work.</strong> Routine jobs go first, and the people who lose
them are rarely the people who get the new ones.</li>
<li><strong>False material.</strong> Fake video, invented quotations, made up
sources.</li>
<li><strong>Blame.</strong> When an automatic decision harms someone, the law
is still working out who is responsible.</li>
</ul>

<h3>Five rules for using it well</h3>
<ul>
<li><strong>Fairness.</strong> Test the system on every group it will be used
on, not only on the easy ones. An average accuracy of ninety five per cent can
hide sixty per cent for one group.</li>
<li><strong>Openness.</strong> People should be told when they are dealing with
a machine.</li>
<li><strong>Responsibility.</strong> A named person answers for what the system
does. Saying the computer decided is not an answer.</li>
<li><strong>Privacy.</strong> Collect the least data that does the job, ask
properly, and delete it when it is finished with.</li>
<li><strong>Human oversight.</strong> A person can look again at the decision
and overturn it. This matters most in health, law and hiring.</li>
</ul>

<div class="in-short"><h3>In short</h3><ul><li>AI brings speed, steadiness, reach and lower cost.</li><li>It also brings bias, loss of privacy, decisions nobody can explain, and lost work.</li><li>Bias comes from the training data.</li><li>Fairness, openness, responsibility, privacy and human oversight are the rules to hold it to.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Explain why an AI system may be biased.</p><p class="a">Because it learns its rules from training data. If that data leaves out or misrepresents a group, the rules it learns repeat that fault.</p></li><li><p class="q">What is meant by human oversight and why does it matter?</p><p class="a">That a person can review the system''s decision and overturn it. It matters because these systems make confident mistakes, and in health or law an unchallenged wrong decision does serious harm.</p></li><li><p class="q">Why is the black box problem serious when a bank refuses a loan?</p><p class="a">Because the applicant has a right to know why they were refused, and if nobody can explain the reasoning the decision cannot be challenged.</p></li></ol></div>',
   'html', 2)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 4: AI Techniques and Intelligent Systems
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('85b6fec0-9ded-5c25-b981-99faae3ed5c1', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 4',
   'AI Techniques and Intelligent Systems',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Common AI techniques</li><li>What makes a system intelligent</li><li>Choosing between the techniques</li></ul></div>
<p>Artificial intelligence is not one method. It is a shelf of them, and the
useful skill is knowing which one suits which job. Think of choosing a tool in
a workshop. You would not use a hammer on a screw.</p>

<h3>The main techniques</h3>
<ul>
<li><strong>Machine learning.</strong> The system learns rules from examples
instead of being given them. Used for spam filtering and credit scoring.</li>
<li><strong>Neural networks.</strong> Layers of simple units, loosely modelled
on brain cells. Used for recognising patterns.</li>
<li><strong>Deep learning.</strong> Neural networks with many layers. Used for
face and speech recognition and for translation.</li>
<li><strong>Natural language processing.</strong> Machines handling human
language. Chatbots, translation, turning speech into text.</li>
<li><strong>Computer vision.</strong> Machines reading images and video.
Number plate reading, medical images.</li>
<li><strong>Expert systems.</strong> A store of rules taken from human experts,
with an engine that applies them. Used to support medical diagnosis.</li>
<li><strong>Robotics.</strong> Artificial intelligence given a body, so it can
act on the world.</li>
<li><strong>Fuzzy logic.</strong> Reasoning in degrees instead of plain true
and false. Washing machines and air conditioners use it.</li>
</ul>

<h3>What makes a system intelligent</h3>
<ul>
<li><strong>Learning.</strong> It gets better with more data or more
experience.</li>
<li><strong>Reasoning.</strong> It draws a conclusion from what it holds.</li>
<li><strong>Perception.</strong> It takes in the world through sensors, images
or sound.</li>
<li><strong>Problem solving.</strong> It searches for a way to reach a
goal.</li>
<li><strong>Adapting.</strong> It copes with a situation nobody programmed it
for.</li>
<li><strong>Language.</strong> It understands or produces human speech and
writing.</li>
</ul>

<h3>Choosing one</h3>
<p>Read the situation for two clues. What kind of data is involved, and does
the decision have to be explained?</p>
<p>Pictures point to computer vision. Words point to language processing. A
field with clear written rules and a need to justify the answer points to an
expert system, because it can show which rules it used. A neural network cannot
do that. Many past examples but no known rules point to machine learning.
Control with vague edges, such as slightly too warm, points to fuzzy logic.</p>

<h3>Expert systems and machine learning side by side</h3>
<p>An expert system is given its rules by people, and it can explain its
answer. Machine learning finds its own rules from data, and usually cannot
explain anything. An expert system needs experts and their time. Machine
learning needs a great deal of data. When the world changes, somebody edits the
expert system by hand, while the machine learning model is trained again on
newer data.</p>

<div class="in-short"><h3>In short</h3><ul><li>Machine learning, neural networks, deep learning, language processing, computer vision, expert systems, robotics and fuzzy logic.</li><li>An intelligent system learns, reasons, perceives, solves problems, adapts and handles language.</li><li>Expert systems can explain their answers. Neural networks cannot.</li><li>Match the technique to the kind of data and to whether the answer must be explained.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">A hospital wants a system that suggests a diagnosis and can show the doctor how it reached it. Which technique suits this?</p><p class="a">An expert system, because it applies rules given by human experts and can show which rules it used.</p></li><li><p class="q">Give four things that make a system intelligent.</p><p class="a">Any four of learning, reasoning, perception, problem solving, adapting and handling language.</p></li><li><p class="q">Why can a neural network usually not explain its decision?</p><p class="a">Because the answer comes from the weights of many thousands of connections across several layers, and those do not match any rule a person can read.</p></li></ol></div>',
   'html', 3)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 5: Machine Learning
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('848d224a-c609-5125-83e1-e4120f150377', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 5',
   'Machine Learning',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>What machine learning is</li><li>How it works</li><li>Supervised, unsupervised and reinforcement learning</li></ul></div>
<p>In ordinary programming you write the rules and the computer applies them.
In machine learning you supply the examples and the computer works out the
rules for itself. That reversal is the whole idea.</p>

<div class="def-box"><strong>Machine learning.</strong> a branch of artificial intelligence in which a system learns patterns from data and gets better at a task with experience, without being given the rules by a programmer.</div>

<h3>Two ways to filter spam</h3>
<p>Suppose the job is to decide whether an email is spam.</p>
<p>Written as ordinary rules, you write them yourself. If the subject holds the
words free money, mark it as spam. If the sender is unknown and there are three
attachments, mark it as spam. Every new trick the senders invent means you must
write another rule, for ever.</p>
<p>Written as machine learning, you supply a hundred thousand emails already
marked spam or not spam. The system works out for itself which words, senders
and patterns go with spam, including combinations no person would have thought
of. When the senders change tactics you train it again instead of rewriting
it.</p>

<h3>How it is done</h3>
<ol>
<li><strong>Collect data.</strong> Many examples. Quality counts for more than
sheer quantity.</li>
<li><strong>Clean the data.</strong> Remove duplicates and errors, deal with
gaps, put everything in the same format, and label it if labels are needed.
This takes most of the time.</li>
<li><strong>Train.</strong> The system looks for patterns and builds a
<strong>model</strong>, which is the set of rules it has learned.</li>
<li><strong>Test.</strong> Try the model on data it has never seen. This is the
step that shows whether it learned anything real.</li>
<li><strong>Use it and keep watching.</strong> Put it to work, then retrain as
the world changes.</li>
</ol>

<p>The training data and the test data have to be different. Testing a model on
the same data it learned from proves nothing, in the same way that setting an
examination using the exact questions you gave out as homework proves
nothing.</p>

<h3>The three kinds</h3>
<figure class="fig"><img src="/notes/figures/ml_types.png" alt="Supervised, unsupervised and reinforcement learning"><figcaption>Supervised, unsupervised and reinforcement learning</figcaption></figure>

<p>The question that separates them is whether the training data carries
labels. If it does, the learning is supervised. If it does not, the learning is
unsupervised. If there is no data set at all and the system learns by being
rewarded or punished for what it tries, the learning is reinforcement.</p>

<h3>Two ways it fails</h3>
<p><strong>Overfitting</strong> means the model has memorised the training
data, including its accidents, and does badly on anything new. It is the
student who learned last year''s questions word for word without
understanding the topic, and who is then beaten by a question worded
differently.</p>
<p><strong>Underfitting</strong> means the model is too simple to catch the
pattern at all, and does badly even on the data it learned from.</p>
<p>You tell them apart by the gap. High accuracy on training data and poor
accuracy on test data means overfitting. Poor on both means underfitting.</p>

<div class="in-short"><h3>In short</h3><ul><li>Machine learning finds its own rules from data instead of being given them.</li><li>Collect, clean, train, test, then keep watching.</li><li>Supervised uses labelled data. Unsupervised uses unlabelled data. Reinforcement learns from rewards and penalties.</li><li>Overfitting means it memorised instead of learning.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">A shop has records of past customers with no labels and wants to find natural groups among them. Which kind of learning?</p><p class="a">Unsupervised learning, because the data has no labels and the task is to discover groupings.</p></li><li><p class="q">Why must test data be kept separate from training data?</p><p class="a">Because testing on data the model already learned from measures memory, not the ability to handle new cases.</p></li><li><p class="q">What is overfitting and how would you spot it?</p><p class="a">When a model memorises its training data, including the noise, and does badly on new data. You spot it by high accuracy on training data together with poor accuracy on test data.</p></li></ol></div>',
   'html', 4)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 6: Developing AI Systems
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('25e5f5a0-83d4-580e-9cd0-d9ea30bc5dfa', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 6',
   'Developing AI Systems',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>The stages of building an AI system</li><li>Languages and tools</li><li>Why Python is used so widely</li></ul></div>
<p>Building an artificial intelligence system is a project like any other, with
one stage that ordinary software does not have. The data has to be gathered and
cleaned before anything can be built at all, and that stage takes most of the
time.</p>

<h3>The stages</h3>
<ol>
<li><strong>Say what the problem is.</strong> What exactly should the system
predict or recognise, and how will you know whether it worked? Get this wrong
and everything after it is wasted.</li>
<li><strong>Collect the data.</strong> Enough relevant examples, from records,
sensors, surveys or public data sets. Check that you are allowed to use
them.</li>
<li><strong>Clean the data.</strong> Remove duplicates and obvious errors,
decide what to do about missing values, put everything in one format, and add
labels if the method needs them. This is usually the longest stage by a wide
margin.</li>
<li><strong>Choose a model.</strong> Pick the method that suits the problem,
the data, and whether the answer has to be explained.</li>
<li><strong>Train it.</strong> Run the data through and let the model adjust
itself.</li>
<li><strong>Measure it.</strong> Test on data held back for the purpose and
work out how accurate it is.</li>
<li><strong>Put it to work.</strong></li>
<li><strong>Watch it and train it again.</strong> The world changes, so the
model goes stale. Watch its accuracy and retrain on fresh data.</li>
</ol>

<h3>Languages and tools</h3>
<ul>
<li><strong>Python</strong> is used far more than anything else.</li>
<li><strong>R</strong> is strong for statistics and research work.</li>
<li><strong>Java and C++</strong> where speed matters or a large system already
exists in them.</li>
<li><strong>Libraries.</strong> TensorFlow and PyTorch for deep learning,
scikit-learn for general machine learning, Pandas and NumPy for handling the
data itself.</li>
<li><strong>Places to work.</strong> Jupyter Notebook, and Google Colab, which
runs on Google''s machines when your own is not strong enough.</li>
</ul>

<h3>Why Python</h3>
<ul>
<li>The way it is written is simple and readable, so your effort goes into the
problem rather than the language.</li>
<li>The libraries already exist and are free. Nobody starts from nothing.</li>
<li>A very large number of people use it, so an answer to your error has
usually been written down already.</li>
<li>It joins onto fast code underneath, so it is quick to write and still fast
where speed counts.</li>
<li>It runs on Windows, Linux and macOS alike, and it costs nothing.</li>
</ul>

<div class="in-short"><h3>In short</h3><ul><li>Say what the problem is, collect data, clean it, choose a model, train, measure, deploy, then watch and retrain.</li><li>Cleaning the data takes most of the time.</li><li>TensorFlow and PyTorch for deep learning. Pandas and NumPy for the data.</li><li>Python leads because it is simple to write, has free mature libraries, and has a very large community.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Which stage of building an AI system usually takes longest, and why?</p><p class="a">Cleaning the data, because real data arrives incomplete, inconsistent and full of errors, and all of that has to be put right before training.</p></li><li><p class="q">Why must a model be watched and retrained after it is put to work?</p><p class="a">Because the world changes, so the patterns the model learned stop holding and its accuracy falls.</p></li><li><p class="q">Give three reasons Python is used so widely for AI work.</p><p class="a">Any three of. It is simple and readable. Its libraries are mature and free. Its community is very large. It calls fast code underneath. It runs everywhere and costs nothing.</p></li></ol></div>',
   'html', 5)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 7: Types of Computers
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('5ec90a26-d22e-5c07-bd28-f5930c52fde3', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 7',
   'Types of Computers',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Supercomputer, mainframe, minicomputer, microcomputer</li><li>Size, power, cost and purpose</li><li>Choosing the right one</li></ul></div>
<p>Computers are grouped into four types, in order of size and power. The
useful thing is to learn them by what they are for, because that is what
decides which one suits a given job.</p>

<figure class="fig"><img src="/notes/figures/computer_types.png" alt="Four types, from the largest down"><figcaption>Four types, from the largest down</figcaption></figure>

<ul>
<li><strong>Supercomputer.</strong> The fastest machines that exist. They cost
millions, need a building of their own, and use enormous amounts of power and
cooling. They are used for one huge calculation at a time. Weather forecasting,
nuclear research, oil exploration, and training large AI models.</li>
<li><strong>Mainframe.</strong> Large, very reliable, built to serve thousands
of users at once and to run for years without stopping. Banks, airline booking,
tax and census systems. It is judged by how many transactions it handles, not
by raw speed.</li>
<li><strong>Minicomputer.</strong> Mid sized, serving a department or a medium
company. Between a mainframe and a personal computer in every respect.</li>
<li><strong>Microcomputer.</strong> One processor serving one user at a time.
Desktops, laptops, tablets and smartphones. The type you own.</li>
</ul>

<h3>Telling the top two apart</h3>
<p>This is the distinction people get wrong, and it is not about size or price.
A <strong>supercomputer</strong> is built for speed on one enormous problem. A
<strong>mainframe</strong> is built for volume and reliability across millions
of small transactions. A bank needs a mainframe, however rich the bank is. A
weather service needs a supercomputer, however many staff it has.</p>

<h3>Choosing for a situation</h3>
<ol>
<li>How many people use it at once? One points to a microcomputer. Thousands
point to a mainframe.</li>
<li>What is the work? One vast calculation, or millions of small ones?</li>
<li>What does an hour of downtime cost? If the answer is that the bank stops,
you need mainframe reliability.</li>
<li>What is the budget, and who will look after it?</li>
</ol>

<div class="in-short"><h3>In short</h3><ul><li>Supercomputer, mainframe, minicomputer, microcomputer, in order of falling power.</li><li>A supercomputer is for speed on one huge calculation.</li><li>A mainframe is for volume and reliability across millions of small transactions.</li><li>A smartphone is a microcomputer.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">State the main difference between a supercomputer and a mainframe.</p><p class="a">A supercomputer is built for the greatest possible speed on a single large calculation. A mainframe is built for high volume transaction processing and continuous reliability for many users at once.</p></li><li><p class="q">Which type would a weather service use, and why?</p><p class="a">A supercomputer, because forecasting is one enormous calculation that needs the greatest possible processing speed.</p></li><li><p class="q">Is a smartphone a computer, and if so which type?</p><p class="a">Yes. It is a microcomputer, because it has one processor serving a single user at a time.</p></li></ol></div>',
   'html', 6)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 8: Basic Components of a Computer
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('a3b11170-deae-50d5-824c-f4d91baa1dc8', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 8',
   'Basic Components of a Computer',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Hardware, input, output, storage and processing</li><li>What the common devices do</li><li>Choosing a device</li></ul></div>
<p>Every computer, from a smartwatch to a mainframe, is the same four things
arranged the same way. Something takes data in. Something works on it.
Something keeps it. Something gives the result out.</p>

<figure class="fig"><img src="/notes/figures/ipos.png" alt="Input, process, output and storage"><figcaption>Input, process, output and storage</figcaption></figure>

<div class="def-box"><strong>Hardware.</strong> the physical parts of a computer system, the parts you can touch, as opposed to the programs and data that tell them what to do.</div>

<h3>The four groups</h3>
<ul>
<li><strong>Input.</strong> Gets data and instructions into the machine.
Keyboard, mouse, scanner, microphone, camera, barcode reader, sensor, touch
screen, fingerprint reader.</li>
<li><strong>Processing.</strong> Works on the data. The CPU, made of a control
unit, an arithmetic and logic unit, and registers. A GPU where graphics or AI
work is involved.</li>
<li><strong>Storage.</strong> Keeps data and programs. Primary storage, which
is RAM, ROM and cache, is fast and close to the processor. Secondary storage,
which is hard disks, solid state drives, flash drives and memory cards, is
slower, larger, and keeps its contents when the power goes off.</li>
<li><strong>Output.</strong> Presents the result. Monitor, printer, speaker,
projector, plotter, actuator.</li>
</ul>

<h3>The awkward ones</h3>
<p>A few devices refuse to sit in one group, and those are the ones worth
knowing.</p>
<ul>
<li>A <strong>touch screen</strong> is both input and output. It shows and it
receives.</li>
<li>A <strong>modem</strong> or a network card is both, because data goes out
and comes in.</li>
<li>A <strong>printer that also scans</strong> is both.</li>
<li>A <strong>flash drive</strong> is storage, not input or output, even though
data moves both ways through it.</li>
<li>A <strong>sensor</strong> is input. An <strong>actuator</strong> is output.
Put together they make a control system.</li>
</ul>

<h3>Choosing a device</h3>
<p>Ask what the data is, where it is now, and who will use it. Hundreds of
identical printed forms point to a scanner with character recognition rather
than a keyboard and a typist. Goods passing a checkout point to a barcode
reader. A user who cannot see points to a screen reader and a Braille display.
A dusty workshop points to a sealed rugged device.</p>

<div class="in-short"><h3>In short</h3><ul><li>Input, process, output and storage. Every computer is these four.</li><li>Hardware means the parts you can touch.</li><li>Touch screens and modems are both input and output. A flash drive is storage.</li><li>Match the device to the volume of data, the surroundings, and who has to use it.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Put each of these in a group. Scanner, actuator, RAM, touch screen.</p><p class="a">Scanner is input. Actuator is output. RAM is primary storage. A touch screen is both input and output.</p></li><li><p class="q">Why is a flash drive counted as storage rather than input or output?</p><p class="a">Because its purpose is to hold data, not to bring data in for processing or to present results to a user.</p></li><li><p class="q">A clinic must record details from three hundred handwritten forms a day. Suggest an input device and say why.</p><p class="a">A scanner with character recognition software, because it captures the forms far faster than typing and avoids the errors a typist would make at that volume.</p></li></ol></div>',
   'html', 7)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 9: Input devices
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('7ef36eaf-35af-5940-9f1a-bd03e5c372fe', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 9',
   'Input devices',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Automatic data capture</li><li>MICR, OCR, OMR, barcode, QR, card and RFID</li><li>How AI reading extends data capture</li></ul></div>
<p>Typing is slow, and typing is where mistakes come from. Even a trained
typist makes an error every few hundred keystrokes, and at the volume a bank or
a supermarket handles that is not acceptable. Automatic data capture is the
answer. Let a machine read the data straight from the source.</p>

<div class="def-box"><strong>Automatic data capture.</strong> collecting data directly into a computer from its source, with nobody keying it in.</div>

<figure class="fig"><img src="/notes/figures/data_capture.png" alt="Ways of reading data without typing it"><figcaption>Ways of reading data without typing it</figcaption></figure>

<h3>The readers</h3>
<ul>
<li><strong>MICR.</strong> Magnetic ink character recognition. It reads the
oddly shaped numbers along the bottom of a cheque, printed in magnetic ink.
Very hard to forge, and it still reads if the cheque has been folded or written
over. Used in banking.</li>
<li><strong>OCR.</strong> Optical character recognition. It turns a picture of
printed or handwritten text into text you can edit. Used on passport pages,
scanned documents and number plates.</li>
<li><strong>OMR.</strong> Optical mark recognition. It finds a pencil mark in a
box. Used on multiple choice answer sheets and ballot papers. It sees where a
mark is, and takes no interest in what it says.</li>
<li><strong>Barcode reader.</strong> Reads a pattern of black and white bars.
Supermarkets, stock control, libraries.</li>
<li><strong>QR code reader.</strong> A square code holding far more data than a
barcode, and any phone camera reads it.</li>
<li><strong>Card readers.</strong> Magnetic stripe, chip, or contactless.</li>
<li><strong>RFID reader.</strong> Reads a tag by radio, with nothing in line of
sight and from a distance. Livestock tags, toll gates, warehouse pallets,
library books.</li>
<li><strong>Biometric readers.</strong> Fingerprint, iris, face. These identify
the person, not merely a card the person is carrying.</li>
</ul>

<h3>Why it is worth the money</h3>
<p>It is much faster than typing. It removes copying errors, because nobody is
copying. It costs less in staff time. It works where a keyboard could not, such
as a lorry passing a toll gate at speed. And the data is available at once, so
stock levels and accounts are current rather than a day behind.</p>
<p>Against that, the equipment costs money, the source has to be prepared with
barcodes printed or tags attached, and some methods still make mistakes.
Character recognition struggles with poor handwriting and a damaged barcode
will not scan at all.</p>

<h3>What AI adds</h3>
<p>Every reader above shares one limit. The world has to be labelled in
advance. A barcode reader can only read a barcode, so if nobody printed one it
sees nothing.</p>
<p>Reading by artificial intelligence removes that limit. It reads the thing
itself. It names a product on a shelf with no code attached, reads handwriting
that ordinary character recognition cannot manage, names a crop disease from a
photograph of the leaf, and works out which number on a receipt is the total
without being told where to look.</p>

<div class="in-short"><h3>In short</h3><ul><li>Automatic data capture reads data from its source with no typing.</li><li>OMR reads marks. OCR reads characters. That is the difference.</li><li>RFID needs no line of sight and works at a distance.</li><li>AI reading does not need the object labelled in advance.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give the difference between OMR and OCR.</p><p class="a">OMR finds the position of marks, such as a pencil mark in a box on an answer sheet. OCR recognises printed or handwritten characters and turns them into text.</p></li><li><p class="q">Why is RFID chosen instead of barcodes in a warehouse?</p><p class="a">Because RFID needs no line of sight and works at a distance, so a whole pallet can be read at once without unpacking it.</p></li><li><p class="q">A supermarket scans an item and the price appears. What actually happened?</p><p class="a">The reader captured the product code from the barcode. The system looked that code up in the stock database and returned the price stored there.</p></li></ol></div>',
   'html', 8)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 10: Output devices
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('1e6aec68-9081-551c-9aa1-7f5903081969', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 10',
   'Output devices',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Dot matrix, laser and inkjet printers</li><li>Projector, plotter, 3D printer, actuator</li><li>Choosing an output device</li></ul></div>
<p>Output is where the computer''s work becomes something a person, or another
machine, can act on. Learn these by their trade offs, because the useful
question is always which one suits the job in front of you.</p>

<h3>The three printers</h3>
<ul>
<li><strong>Dot matrix.</strong> Pins strike an inked ribbon against the paper.
It is noisy, slow and poor quality. But it is an <strong>impact</strong>
printer, so it prints carbon copies in one pass, and it survives dust and heat.
That is why it is still used for multi part invoices, payslips and delivery
notes.</li>
<li><strong>Inkjet.</strong> Sprays droplets of liquid ink. The machine is
cheap, the colour is good and photographs come out well. It is slow for long
jobs, and over time the cartridges cost more than the printer did.</li>
<li><strong>Laser.</strong> A laser draws the page in static electricity, toner
sticks to it, and heat fuses it on. Fast, sharp, quiet and cheap per page. The
machine itself is expensive. This is the office and school choice.</li>
</ul>

<h3>The others</h3>
<ul>
<li><strong>Projector.</strong> Throws the display onto a large surface for an
audience.</li>
<li><strong>Graph plotter.</strong> Draws with pens on very large paper, giving
continuous accurate lines. Used for architectural and engineering drawings and
for maps. A plotter draws lines. A printer builds a picture out of dots.</li>
<li><strong>3D printer.</strong> Builds a solid object layer by layer from
plastic, resin or metal powder. Used for prototypes, spare parts and medical
fittings.</li>
<li><strong>Actuator.</strong> Turns an electrical signal into movement. A
motor, a valve, a heater, a switch. This is the output device of a control
system. The sensor is the input and the actuator does something about it.</li>
</ul>

<h3>Matching the device to the job</h3>
<p>A transport company issuing three part delivery notes in a dusty depot needs
a dot matrix printer, because it is an impact printer and can produce the copies
in one pass. A school printing two thousand pages a week needs a laser, for
speed and cost per page. A photographer printing at home needs an inkjet, for
colour quality. An architect needing large accurate plans needs a plotter. A
greenhouse that must open a vent when it gets warm needs an actuator, because
the output required is movement.</p>

<div class="in-short"><h3>In short</h3><ul><li>Dot matrix is an impact printer, so it alone can print carbon copies in one pass.</li><li>Inkjet suits colour and photographs at low volume. Laser suits high volume text.</li><li>A plotter draws continuous lines. A printer builds a picture from dots.</li><li>An actuator turns a signal into movement, and is the output of a control system.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give one situation where a dot matrix printer is still the right choice, and say why.</p><p class="a">Printing multi part invoices or payslips, because it is an impact printer and can produce carbon copies in a single pass.</p></li><li><p class="q">What is the difference between a printer and a plotter?</p><p class="a">A printer builds an image out of dots and suits text and ordinary documents. A plotter draws continuous accurate lines with pens and suits large technical drawings.</p></li><li><p class="q">What is an actuator, and in what kind of system is it used?</p><p class="a">A device that turns an electrical signal into physical movement, used as the output device of a control system.</p></li></ol></div>',
   'html', 9)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 11: Secondary Storage media and devices
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('bf89c24c-0b82-5203-88f2-d4f4de7e0fdc', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 11',
   'Secondary Storage media and devices',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Secondary against primary storage</li><li>Magnetic, optical and solid state storage</li><li>Choosing storage</li></ul></div>
<p>Primary storage is the desk you work on. Secondary storage is the cupboard
you keep things in. The desk is fast and small and is cleared every night. The
cupboard is slower and much larger, and it keeps what you put in it.</p>

<h3>The difference</h3>
<p><strong>Primary storage</strong> is RAM, ROM and cache. The processor
reaches it directly. It is very fast, small and expensive for each gigabyte.
RAM is <strong>volatile</strong>, which means that when the power goes off the
contents are gone.</p>
<p><strong>Secondary storage</strong> is hard disks, solid state drives, flash
drives and discs. The processor cannot reach it directly, so data must be
loaded into RAM first. It is slower, much larger, cheap for each gigabyte, and
<strong>non volatile</strong>, so it keeps its contents.</p>

<h3>The three technologies</h3>
<ul>
<li><strong>Magnetic.</strong> A spinning platter with a moving head magnetises
tiny areas. Hard disk drives and magnetic tape work this way. Large capacity
and the cheapest for each gigabyte. Moving parts make it slower and easy to
damage. Tape is read from beginning to end, which is why it is used for backup
rather than for daily work.</li>
<li><strong>Optical.</strong> A laser burns pits into a reflective layer and
another laser reads them. A CD holds about 700 megabytes, a DVD 4.7 gigabytes
and a Blu-ray 25 gigabytes or more. Cheap and portable, but slow, easily
scratched, and small by modern standards.</li>
<li><strong>Solid state.</strong> Flash memory chips with no moving parts at
all. Solid state drives, flash drives and memory cards. Very fast, silent, low
power, and it survives being dropped. It costs more for each gigabyte, and each
cell can only be rewritten a limited number of times.</li>
</ul>

<h3>Two ways of reaching data</h3>
<p><strong>Serial access</strong> means you must pass everything before the
item you want. Magnetic tape works this way. <strong>Direct access</strong>
means you go straight to it. Disks, solid state drives and discs work this
way.</p>

<h3>Choosing</h3>
<p>A field officer walking rough ground needs solid state storage, because it
has no moving parts and survives knocks. A company keeping ten years of records
that are almost never read should use magnetic tape, because it is by far the
cheapest and reading from the beginning does not matter. A student carrying
assignments between home and school needs a flash drive.</p>

<div class="in-short"><h3>In short</h3><ul><li>Primary storage is fast, small and reached directly by the processor. RAM is volatile.</li><li>Secondary storage is slow, large and keeps its contents.</li><li>Magnetic is cheapest. Optical is portable. Solid state is fastest and toughest.</li><li>Tape is read from beginning to end, which is why it suits backup.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give three differences between primary and secondary storage.</p><p class="a">The processor reaches primary storage directly and secondary storage only through RAM. Primary is much faster but much smaller. RAM is volatile while secondary storage keeps its contents.</p></li><li><p class="q">Why is a solid state drive better than a hard disk in a laptop?</p><p class="a">It has no moving parts, so it is faster, silent, uses less power and survives being knocked or dropped while running.</p></li><li><p class="q">Why is magnetic tape still used for backup?</p><p class="a">Because it costs less for each gigabyte than anything else, and reading it from beginning to end is no disadvantage when the whole backup is read anyway.</p></li></ol></div>',
   'html', 10)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 12: Primary Storage devices
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('ede86a80-e0be-5e1b-9e9d-1cac1f7060b1', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 12',
   'Primary Storage devices',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>RAM, ROM, cache and registers</li><li>Comparing them</li><li>Why AI training needs so much storage</li></ul></div>
<p>There is an order inside the machine, and it holds all the way down. The
closer to the processor, the faster, the smaller and the more expensive for
each byte. If you understand that one sentence you can rebuild this whole topic
from memory.</p>

<figure class="fig"><img src="/notes/figures/memory_pyramid.png" alt="The order of memory, from the processor outward"><figcaption>The order of memory, from the processor outward</figcaption></figure>

<ul>
<li><strong>Registers.</strong> Inside the processor itself, and the fastest
storage there is. There are only a few dozen, and they hold the instruction
being carried out and the values being worked on right now.</li>
<li><strong>Cache.</strong> Very fast memory sitting between the processor and
RAM, holding data that has been used recently or is used often. It comes in
levels, L1, L2 and L3, where L1 is the smallest and fastest.</li>
<li><strong>RAM.</strong> Random access memory, the working memory of the
machine. It holds the operating system, your open programs and your open
documents. It can be read and written, and it is volatile.</li>
<li><strong>ROM.</strong> Read only memory. It holds the instructions that run
when the machine is switched on, before any operating system is loaded. It keeps
its contents when the power goes off, and it is not written to in normal
use.</li>
</ul>

<h3>RAM and ROM side by side</h3>
<p>RAM can be read and written, while ROM is read only in ordinary use. RAM
loses everything at power off and ROM does not. RAM is large, measured in
gigabytes, and ROM is small, measured in megabytes. RAM holds what you are
doing. ROM holds what the machine needs so that it can start.</p>

<h3>Why cache exists</h3>
<p>The processor is many times faster than RAM. Without help it would spend
most of its life waiting. Cache holds the data and instructions used most
recently, on the fair assumption that what was needed a moment ago will be
needed again shortly. When the processor finds what it wants there, that is a
cache hit. When it does not, it has to wait for RAM.</p>

<h3>Why AI training needs so much storage</h3>
<p>Training a machine learning model means passing millions of examples through
it, over and over. Those examples are pictures, recordings and text, and a
serious training set runs into hundreds of gigabytes. That is far too large to
sit in RAM, so it lives in secondary storage and is fed through in batches.</p>
<p>The secondary storage has to be large enough to hold the set and fast enough
to feed the processor without becoming the slow point, which is why training
machines use solid state drives rather than hard disks. Storage capacity, and
not only processor speed, limits how large a model you can train.</p>

<div class="in-short"><h3>In short</h3><ul><li>Registers, cache, RAM, then secondary storage. Speed falls and size rises as you move away from the processor.</li><li>RAM is read and write and volatile. ROM is read only and keeps its contents.</li><li>Cache exists to stop the processor waiting for RAM.</li><li>AI training sets are far larger than RAM, so they need large fast secondary storage.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Put these in order from fastest to slowest. RAM, registers, secondary storage, cache.</p><p class="a">Registers, cache, RAM, secondary storage.</p></li><li><p class="q">State three differences between RAM and ROM.</p><p class="a">RAM can be read and written while ROM is read only in ordinary use. RAM is volatile while ROM is not. RAM is much larger than ROM.</p></li><li><p class="q">What is the purpose of cache memory?</p><p class="a">It holds recently and frequently used data in very fast memory close to the processor, so that the processor spends less time waiting for the slower RAM.</p></li></ol></div>',
   'html', 11)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 13: Processing device and the machine instruction cycle
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('d0c08724-6802-56ec-afd4-5e46e191df52', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 13',
   'Processing device and the machine instruction cycle',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>CPU and GPU</li><li>The machine instruction cycle</li><li>Why AI work leans on the GPU</li></ul></div>
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
<figure class="fig"><img src="/notes/figures/cpu_cycle.png" alt="Fetch, decode, execute, store, and round again"><figcaption>Fetch, decode, execute, store, and round again</figcaption></figure>

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
once, and that is exactly what a GPU''s thousands of cores are for. A job that
would take a CPU several weeks can take a suitable GPU a few hours.</p>

<div class="in-short"><h3>In short</h3><ul><li>Fetch, decode, execute, and store where a result must be kept.</li><li>The program counter holds the address of the next instruction.</li><li>A CPU has few powerful cores for work done in turn. A GPU has thousands of simple cores for work done all at once.</li><li>AI training suits a GPU because the sums do not depend on each other.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Name the three main parts of the processor and say what each does.</p><p class="a">The control unit fetches, decodes and directs. The arithmetic and logic unit does calculations and comparisons. The registers are small fast stores holding the instruction and data in use.</p></li><li><p class="q">What does the program counter hold, and what happens to it during fetch?</p><p class="a">It holds the address of the next instruction. During fetch its contents are copied to the memory address register, and it then moves on by one.</p></li><li><p class="q">Why are GPUs used to train machine learning models?</p><p class="a">Because training is very large numbers of independent sums on grids of numbers, and a GPU''s many cores can carry them out at the same time instead of one after another.</p></li></ol></div>',
   'html', 12)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 14: Processor architectures, parallel and distributed computing
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('159b7963-b68f-5a9e-9b7d-09234cc6c6be', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 14',
   'Processor architectures, parallel and distributed computing',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>CISC and RISC</li><li>Flynn''s four categories</li><li>Parallel against distributed computing</li></ul></div>
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

<h3>Flynn''s four categories</h3>
<figure class="fig"><img src="/notes/figures/flynn.png" alt="Sorting machines by instruction and data streams"><figcaption>Sorting machines by instruction and data streams</figcaption></figure>
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

<div class="in-short"><h3>In short</h3><ul><li>CISC has many complex instructions. RISC has few simple ones and uses less power.</li><li>SISD, SIMD, MISD and MIMD sort machines by instruction and data streams.</li><li>A GPU is the example of SIMD.</li><li>Parallel means several processors in one machine. Distributed means separate machines on a network.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give two differences between CISC and RISC.</p><p class="a">CISC has many complex instructions, each often taking several clock cycles, while RISC has few simple ones each normally taking a single cycle. RISC chips are simpler and use less power, which is why phones use them.</p></li><li><p class="q">Expand SIMD and give an example.</p><p class="a">Single instruction, multiple data. A GPU applying the same operation to every pixel of an image at the same moment.</p></li><li><p class="q">What is the difference between parallel and distributed computing?</p><p class="a">Parallel computing uses several processors inside one machine, usually sharing memory and joined by fast buses. Distributed computing uses separate machines with their own memory, joined over a network.</p></li></ol></div>',
   'html', 13)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 15: Conversion between units of storage and units of processing
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('d531453e-c52a-595f-a015-cdd343124d4a', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 15',
   'Conversion between units of storage and units of processing',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Units of storage</li><li>Units of processing</li><li>Converting between them</li></ul></div>
<p>There are two separate ladders here and they are easy to confuse. Storage is
measured in bytes and says how much you can keep. Processing is measured in
hertz and says how fast things happen. They do not convert into one another,
and they do not even step by the same amount.</p>

<figure class="fig"><img src="/notes/figures/units_ladder.png" alt="The storage ladder, and the trap at the bottom"><figcaption>The storage ladder, and the trap at the bottom</figcaption></figure>

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

<div class="in-short"><h3>In short</h3><ul><li>Storage steps in 1024. Processing steps in 1000.</li><li>Eight bits make one byte.</li><li>Going down the ladder multiply, going up divide.</li><li>Small b is a bit and capital B is a byte.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Convert 4 gigabytes to megabytes.</p><p class="a">4 x 1024 = 4096 megabytes.</p></li><li><p class="q">Convert 3,145,728 bytes to megabytes.</p><p class="a">3,145,728 divided by 1024 = 3072 kilobytes. 3072 divided by 1024 = 3 megabytes.</p></li><li><p class="q">A file is 24 megabytes and the connection runs at 8 megabits each second. Roughly how long will it take?</p><p class="a">8 megabits each second is 1 megabyte each second, because eight bits make a byte. So about 24 seconds.</p></li></ol></div>',
   'html', 14)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 17: Application software
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('1289e1a7-10c8-55fd-8f1d-dbe568e91396', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 17',
   'Application software',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>General purpose, specific purpose and tailor made</li><li>Common types</li><li>Choosing software for a task</li></ul></div>
<p>Application software is what you open to get something done, as
opposed to the system software running underneath that keeps the machine
alive.</p>

<div class="def-box"><strong>Application software.</strong> programs written to help the user carry out a particular task, rather than to run the computer itself.</div>

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

<div class="in-short"><h3>In short</h3><ul><li>General purpose serves many tasks and is cheap. Specific purpose serves one kind of job. Tailor made serves one organisation.</li><li>Tailor made fits exactly, and costs the most in money and in time.</li><li>Choose by the shape of the data, not by habit.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give one advantage of general purpose software and one of tailor made software.</p><p class="a">General purpose software is cheap, because its cost is shared across millions of users. Tailor made software fits the organisation''s needs exactly.</p></li><li><p class="q">A hospital needs a system that matches its own unusual admission procedures, and has a large budget. Which kind should it choose?</p><p class="a">Tailor made software, because no ready made package supports procedures that are unique to that hospital, and the budget can carry the higher cost.</p></li><li><p class="q">Which type of software suits keeping and searching student records?</p><p class="a">Database software, because the data is structured records that have to be stored, searched, sorted and linked to one another.</p></li></ol></div>',
   'html', 15)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 18: System software and examples
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('1c3b758a-a058-584b-8f7f-30ccdee35ef2', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 18',
   'System software and examples',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Operating systems, drivers and utilities</li><li>Common utilities</li><li>Utilities that use AI</li></ul></div>
<p>System software works for the machine. Application software works for you.
You rarely open system software on purpose, and when it is doing its job
properly you never notice it. You notice it when it fails.</p>

<div class="def-box"><strong>System software.</strong> programs that manage and support the computer system itself, giving application software a platform to run on.</div>

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

<div class="in-short"><h3>In short</h3><ul><li>Operating systems, device drivers and utilities are all system software.</li><li>A driver translates between the operating system and one device.</li><li>Never defragment a solid state drive.</li><li>Behaviour based detection catches threats nobody has catalogued yet.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">What is a device driver and why is it needed?</p><p class="a">A small program that translates between the operating system and one particular piece of hardware, because the operating system cannot know the exact signals every different device needs.</p></li><li><p class="q">Why should a defragmenter not be run on a solid state drive?</p><p class="a">A solid state drive has no moving head, so there is no speed to be gained, and the extra writing shortens the life of the drive.</p></li><li><p class="q">What is the difference between a firewall and an antivirus?</p><p class="a">A firewall filters network traffic entering and leaving the machine. An antivirus finds and removes harmful software already on it.</p></li></ol></div>',
   'html', 16)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 19: Notions of the Operating System
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('0b165e2a-cbc7-5313-9102-6f2d95428f37', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 19',
   'Notions of the Operating System',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>How operating systems grew</li><li>Types of operating system</li><li>What an operating system does</li></ul></div>
<p>Without an operating system a computer is a heap of parts that cannot work
together. The operating system turns hardware into something a person and a
program can both use. It is the first thing to load and the last thing to
stop.</p>

<div class="def-box"><strong>Operating system.</strong> the system software that manages the computer''s hardware and software and provides an interface between the user and the machine.</div>

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
<li><strong>Network operating system.</strong> Manages a network''s shared
resources, users and security.</li>
<li><strong>Embedded.</strong> Built into a device to do one job with very
little memory. A washing machine, a router.</li>
</ul>

<p>Multi user and multitasking are not the same. Multi user means several
people. Multitasking means several programs. A laptop is single user and
multitasking.</p>

<h3>What it does</h3>
<figure class="fig"><img src="/notes/figures/os_functions.png" alt="The jobs an operating system carries out"><figcaption>The jobs an operating system carries out</figcaption></figure>
<p>It manages programs, deciding what runs and when. It manages memory, giving
each program space and stopping one from overwriting another. It manages files
and folders, and controls who may read them. It drives the hardware through
drivers. It handles security through accounts and passwords. It provides the
interface. And it detects and reports errors.</p>

<div class="in-short"><h3>In short</h3><ul><li>The operating system manages hardware and software and gives the user an interface.</li><li>Real time systems must answer inside a guaranteed time.</li><li>Multi user means several people. Multitasking means several programs.</li><li>Its jobs are processes, memory, files, devices, security, interface and errors.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">A ventilator must respond to a change in a patient''s breathing inside a fixed time. What type of operating system does it need?</p><p class="a">A real time operating system, because it must guarantee a response within a set deadline.</p></li><li><p class="q">What is the difference between multi user and multitasking?</p><p class="a">Multi user means several people use the system at the same time, each with their own session. Multitasking means several programs run at the same time.</p></li><li><p class="q">Name five things an operating system does.</p><p class="a">Any five of managing programs, managing memory, managing files, managing devices, security, providing the user interface, and handling errors.</p></li></ol></div>',
   'html', 17)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 20: Functions of an operating system 1
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('95d4da52-8268-575e-a6c2-533f73a839e4', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 20',
   'Functions of an operating system 1',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Pre-emptive and non pre-emptive scheduling</li><li>FCFS, SJF, SRT and round robin</li><li>AI in scheduling</li></ul></div>
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
<figure class="fig"><img src="/notes/figures/gantt.png" alt="First come first served, drawn as a Gantt chart"><figcaption>First come first served, drawn as a Gantt chart</figcaption></figure>
<p>Draw the chart first, then read the waiting times off it. Waiting time is
the start time minus the arrival time. In the chart above, P3 needed only one
unit of time and waited seven, because P1 sat in front of it with six units to
run. That is the convoy effect made visible.</p>

<h3>Where AI comes in</h3>
<p>Shortest job first has the best average waiting time, but it needs something
you cannot normally have, which is knowledge of how long a job will take before
it runs. A machine learning model can predict that from the behaviour of similar
jobs in the past. So a modern scheduler can come close to shortest job first
without being told anything. Some schedulers also learn a user''s habits and
give priority to the programs they are about to open.</p>

<div class="in-short"><h3>In short</h3><ul><li>Non pre-emptive means a program keeps the processor until it finishes. Pre-emptive means the system can take it away.</li><li>First come first served suffers the convoy effect.</li><li>Shortest job first gives the best average wait but can starve long jobs.</li><li>Waiting time is start time minus arrival time.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">What is the convoy effect and which method suffers from it?</p><p class="a">When a long job at the front of the queue forces all the shorter ones behind it to wait, raising the average waiting time. It affects first come first served.</p></li><li><p class="q">Explain the trade off in choosing a time quantum for round robin.</p><p class="a">Too small and the system wastes time switching between programs. Too large and it behaves like first come first served, losing the quickness that round robin exists to give.</p></li><li><p class="q">Two jobs arrive. P1 at time 0 needing 4 units, P2 at time 1 needing 2. Under first come first served, what is the average waiting time?</p><p class="a">P1 starts at 0 and waits 0. P2 starts at 4 and waits 4 minus 1, which is 3. The average is 1.5 units.</p></li></ol></div>',
   'html', 18)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 21: Functions of the operating system 2
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('b81b3136-538b-5037-af82-84b7c86d41ba', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 21',
   'Functions of the operating system 2',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Managing memory, files and devices</li><li>Deallocation, virtual memory, buffering, spooling, metadata</li></ul></div>
<p>Scheduling shares out the processor. This lesson is about sharing out
everything else, which means memory, storage and the devices.</p>

<h3>Managing memory</h3>
<p>The operating system gives each program the memory it needs when it starts,
and takes it back when the program ends. Taking it back is called
<strong>deallocation</strong>. A program that fails to release memory it no
longer needs causes a <strong>memory leak</strong>. Free memory shrinks
steadily, the machine slows, and in the end it has to be restarted.</p>
<p>The system also keeps programs apart, so that one cannot read or overwrite
another''s memory, whether by accident or on purpose.</p>

<h3>Virtual memory</h3>
<div class="def-box"><strong>Virtual memory.</strong> an area of secondary storage used as though it were RAM, so that programs larger than the physical memory can still run. Pages are swapped between disk and RAM as they are needed.</div>

<figure class="fig"><img src="/notes/figures/virtual_memory.png" alt="Pages moving between RAM and disk"><figcaption>Pages moving between RAM and disk</figcaption></figure>

<p>Virtual memory is why a machine with four gigabytes of RAM can have more
than four gigabytes of programs open. It is also why such a machine crawls when
memory runs short, because disk is thousands of times slower than RAM. When the
system spends more time swapping pages than doing useful work, that is called
<strong>thrashing</strong>. The cure is more RAM or fewer open programs.</p>

<h3>Managing files</h3>
<p>The operating system arranges storage into files and folders and keeps the
directory that records where everything actually sits. It controls who may
read, write or run each file. And it holds the <strong>metadata</strong>, which
means data about the data. A file''s name, size, type, owner, dates and
permissions are all metadata.</p>

<h3>Managing devices</h3>
<figure class="fig"><img src="/notes/figures/buffer_spool.png" alt="Buffering and spooling compared"><figcaption>Buffering and spooling compared</figcaption></figure>
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

<div class="in-short"><h3>In short</h3><ul><li>Deallocation means giving memory back. Failing to do it causes a memory leak.</li><li>Virtual memory borrows disk space and uses it as though it were RAM.</li><li>Metadata is data about data, such as a file''s size and date.</li><li>A buffer is in memory for one stream. A spool is on disk for a queue of jobs.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Define virtual memory and give one drawback.</p><p class="a">An area of secondary storage used as though it were RAM, so programs larger than physical memory can run. Its drawback is that disk is far slower than RAM, so heavy use of it slows the machine badly.</p></li><li><p class="q">What is a memory leak?</p><p class="a">When a program fails to give back memory it no longer needs, so free memory falls steadily until the machine slows or must be restarted.</p></li><li><p class="q">Give the difference between buffering and spooling.</p><p class="a">Buffering holds a flowing stream of data in memory while it passes between devices of different speeds. Spooling puts whole jobs in a queue on disk to be fed to a slow device as it becomes free.</p></li></ol></div>',
   'html', 19)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 22: Installing an operating system and user interfaces
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('5dc968a9-9b43-5ad2-93b5-26cc49c6dce4', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 22',
   'Installing an operating system and user interfaces',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Installing Windows or Linux</li><li>Graphical and command line interfaces</li><li>Choosing an interface</li></ul></div>
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

<div class="in-short"><h3>In short</h3><ul><li>Back up before you install. Installing normally wipes the disk.</li><li>A graphical interface is easy to learn and heavier on resources.</li><li>A command line is fast, light, and can be scripted.</li><li>Choose by who is using it, what the work is, and what connection is available.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Why must data be backed up before an operating system is installed?</p><p class="a">Because installing normally partitions and formats the disk, destroying everything already stored on it.</p></li><li><p class="q">Give two advantages of a command line interface.</p><p class="a">It can be written into a script so repeated jobs run exactly the same way every time, and it uses far fewer resources than a graphical interface.</p></li><li><p class="q">A company manages fifty servers with no monitors, over a slow connection. Which interface suits them?</p><p class="a">A command line, because the servers have no display hardware, text needs very little bandwidth, and work repeated across fifty machines can be scripted.</p></li></ol></div>',
   'html', 20)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 23: Using the GUI of an operating system
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('c18398d3-b3b5-5681-a7ee-4dac14757c7d', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 23',
   'Using the GUI of an operating system',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Files, folders and file formats</li><li>Working with files and folders</li><li>Keeping other people out</li></ul></div>
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

<div class="in-short"><h3>In short</h3><ul><li>A file holds data. A folder arranges files. The extension says which program opens it.</li><li>Copy duplicates. Cut moves.</li><li>Shift and Delete skips the Recycle Bin.</li><li>Separate accounts with passwords are the first defence.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">What is the purpose of a file extension?</p><p class="a">It shows the file''s format and tells the operating system which program should open it.</p></li><li><p class="q">What is the difference between Delete and Shift with Delete?</p><p class="a">Delete moves the file to the Recycle Bin where it can be restored. Shift with Delete removes it without putting it there.</p></li><li><p class="q">Why should daily work be done from a standard rather than an administrator account?</p><p class="a">Because harmful software runs with the rights of whoever is logged in, so an infection caught on a standard account can do far less damage.</p></li></ol></div>',
   'html', 21)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 24: Using the CLI of an operating system
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('75b90d72-30c7-5e83-aeea-36188aa97e59', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 24',
   'Using the CLI of an operating system',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Opening a command line</li><li>Working with files and folders</li><li>Writing a script</li></ul></div>
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
mkdir D:\Backup
copy C:\Users\Student\Documents\*.docx D:\Backup
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

<div class="in-short"><h3>In short</h3><ul><li>dir and ls list. copy and cp copy. del and rm delete.</li><li>A script is a text file of commands that runs them in order.</li><li>Scripting is the real advantage of the command line.</li><li>There is no Recycle Bin here. Deleting is final.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give the Windows and Linux commands to list the contents of a folder.</p><p class="a">dir in Windows and ls in Linux.</p></li><li><p class="q">What does a script let you do that clicking cannot?</p><p class="a">It records a sequence of commands so the whole job can be repeated exactly, automatically, without anybody present.</p></li><li><p class="q">Why is deleting from the command line more dangerous than deleting in the graphical interface?</p><p class="a">Because the file is removed at once and for good, with no Recycle Bin and no confirmation, so a mistyped command cannot be undone.</p></li></ol></div>',
   'html', 22)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 25: Hardware faults identification and correction
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('8c6b2cc7-752a-5ce8-9361-a3439c3c766c', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 25',
   'Hardware faults identification and correction',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Preventive and corrective maintenance</li><li>Common hardware faults</li><li>How to prevent them</li></ul></div>
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

<div class="in-short"><h3>In short</h3><ul><li>Preventive maintenance happens before the fault. Corrective happens after.</li><li>Dust and heat cause most hardware failures.</li><li>A clicking hard disk means back up now.</li><li>A surge protector is the most useful single precaution here.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give the difference between preventive and corrective maintenance.</p><p class="a">Preventive maintenance is carried out before a fault happens, to stop it happening. Corrective maintenance is carried out afterwards, to repair the fault.</p></li><li><p class="q">A computer shuts down by itself after twenty minutes. What is the likely cause and what should be done?</p><p class="a">Overheating, most likely from dust blocking the fans or vents. Clean out the dust, check the fans are turning, and make sure the vents are clear.</p></li><li><p class="q">A hard disk starts making a clicking noise. What should be done first?</p><p class="a">Back up the data at once, because a clicking disk is close to complete failure and may not last long.</p></li></ol></div>',
   'html', 23)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 26: Software faults identification and correction
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('1e7cc82b-bde3-59f8-9f31-6b13df48e069', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 26',
   'Software faults identification and correction',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Hardware against software maintenance</li><li>Common software faults</li><li>A method for finding the cause</li></ul></div>
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

<div class="in-short"><h3>In short</h3><ul><li>Hardware maintenance is physical. Software maintenance is not.</li><li>Ask what changed just before the fault appeared.</li><li>Change one thing at a time.</li><li>Backup is the remedy that covers every software fault.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">A document will not open on your machine. How would you find out whether the fault is in the file or in the program?</p><p class="a">Try the same file on another machine, and try a different file of the same type in the same program. If the file fails everywhere it is damaged. If only that program fails, the program is at fault.</p></li><li><p class="q">A device stops working straight after a system update. What is the likely cause and the remedy?</p><p class="a">A faulty or unsuitable driver installed by the update. Roll the driver back to the previous version.</p></li><li><p class="q">Why is regular backup called the remedy that always works?</p><p class="a">Because whatever goes wrong, whether damage, infection, a failed update or an accidental deletion, a recent backup lets the data be restored.</p></li></ol></div>',
   'html', 24)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 27: Assistive technology
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('680d3156-adf8-5077-84b9-b3357a1b67d4', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 27',
   'Assistive technology',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>What assistive technology is</li><li>Braille, audio and speech tools</li><li>How AI improved them</li></ul></div>
<p>A computer is only useful to somebody who can operate it. Assistive
technology is what makes the same machine usable by a person who cannot see the
screen, cannot hear the sound, or cannot work a standard keyboard. It is not a
kindness added on at the end. For a great many people it is the thing that makes
school and work possible at all.</p>

<div class="def-box"><strong>Assistive technology.</strong> any device, software or equipment that helps a person with a disability to carry out a task they would otherwise find difficult or impossible.</div>

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

<div class="in-short"><h3>In short</h3><ul><li>Assistive technology lets a person with a disability do what they otherwise could not.</li><li>Screen readers and Braille displays serve sight. Captions serve hearing. Speech and switches serve movement.</li><li>AI made speech recognition accurate enough to rely on.</li><li>Match the technology to the particular difficulty.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Describe how a Braille display works and who uses it.</p><p class="a">Small pins rise and fall to form Braille characters representing the text on screen, so a blind user can read by touch.</p></li><li><p class="q">A student cannot use a keyboard because of limited hand movement. Suggest two technologies.</p><p class="a">Speech recognition, so the student can dictate and control the machine by voice. And switch access with on screen scanning, so choices can be made with a single button.</p></li><li><p class="q">How has AI improved assistive technology?</p><p class="a">It has made speech recognition, predictive text and image description much more accurate, which turned unreliable aids into tools people can depend on.</p></li></ol></div>',
   'html', 25)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 28: Computer ergonomics
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('d1da1d67-f668-5001-8ad0-94d40681dadd', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 28',
   'Computer ergonomics',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>What ergonomics means</li><li>Health problems and their causes</li><li>Correct posture and equipment</li></ul></div>
<p>You will spend years of your life in front of a screen. The injuries that
come from doing it badly arrive slowly and quietly, and by the time they hurt
they are hard to undo. This lesson is cheap insurance.</p>

<div class="def-box"><strong>Computer ergonomics.</strong> the study of arranging the workplace, the equipment and the way of working so that they suit the human body and avoid injury.</div>

<figure class="fig"><img src="/notes/figures/workstation.png" alt="How to arrange a desk, a chair and a screen"><figcaption>How to arrange a desk, a chair and a screen</figcaption></figure>

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
about an arm''s length away, tilted slightly back. Place it so that no window or
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

<div class="in-short"><h3>In short</h3><ul><li>Ergonomics means fitting the equipment to the body.</li><li>Back pain, strain injury and eye strain are the main risks.</li><li>Screen at eye level, an arm''s length away. Elbows at a right angle, wrists straight.</li><li>Every twenty minutes, look twenty feet away for twenty seconds.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Name three health problems caused by computer use and give a cause of each.</p><p class="a">Back and neck pain from poor posture and a badly placed screen. Repetitive strain injury from long typing with bent wrists. Eye strain from staring at a bright screen with glare on it.</p></li><li><p class="q">State the twenty twenty twenty rule and say why it works.</p><p class="a">Every twenty minutes, look at something about twenty feet away for twenty seconds. It lets the focusing muscle of the eye relax after being held tense at one close distance.</p></li><li><p class="q">Describe the correct position of the screen and the keyboard.</p><p class="a">The top of the screen at or just below eye level, about an arm''s length away and free of reflections. The keyboard flat and directly in front, with elbows at about a right angle and wrists straight.</p></li></ol></div>',
   'html', 26)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 29: Editing and Formatting text
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('ce68821e-0eb1-5fe6-95cb-f629720027e1', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 29',
   'Editing and Formatting text',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Editing text</li><li>Formatting text</li><li>Styles</li><li>AI writing helpers</li></ul></div>
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

<div class="in-short"><h3>In short</h3><ul><li>Editing changes the words. Formatting changes how they look.</li><li>A style is a named set of formatting applied by name.</li><li>Change a style once and every paragraph using it changes.</li><li>Read every AI suggestion before you accept it.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give the difference between editing and formatting.</p><p class="a">Editing changes the content of the document, meaning the actual words. Formatting changes how that content looks without altering what it says.</p></li><li><p class="q">What is a style and give two reasons to use one.</p><p class="a">A named set of formatting applied to text. It keeps a long document consistent, and changing the style once updates every paragraph that uses it.</p></li><li><p class="q">Why is an automatic table of contents only possible when styles have been used?</p><p class="a">Because the software finds the headings by their heading style. Without styles it has no way of knowing which lines are headings.</p></li></ol></div>',
   'html', 27)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 30: Editing and formatting images and tables
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('8d3ad759-22bb-575e-8b45-12b8909bf8f5', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 30',
   'Editing and formatting images and tables',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Working with images</li><li>Text wrapping</li><li>Working with tables</li></ul></div>
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
<figure class="fig"><img src="/notes/figures/text_wrap.png" alt="Four ways text can flow around a picture"><figcaption>Four ways text can flow around a picture</figcaption></figure>
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

<div class="in-short"><h3>In short</h3><ul><li>Resize from a corner to keep the proportions. Crop removes area.</li><li>Text wrapping decides how the text flows around a picture.</li><li>Merging cells makes one heading span several columns.</li><li>Gridlines on screen are not borders and will not print.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Why should an image be resized using a corner handle?</p><p class="a">Because a corner keeps the proportions, so the image is not distorted. A side handle stretches it in one direction only.</p></li><li><p class="q">How would you make a single heading span three columns of a table?</p><p class="a">Select the three cells in that row and merge them into one.</p></li><li><p class="q">A table runs onto a second page but the headings do not appear there. What setting fixes it?</p><p class="a">Set the header row to repeat, so the heading row appears at the top of every page the table covers.</p></li></ol></div>',
   'html', 28)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 31: Using Text boxes and adjusting Page layout
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('422440b1-e8c3-5c9f-882a-558c6f0b2005', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 31',
   'Using Text boxes and adjusting Page layout',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Text boxes</li><li>Page layout</li><li>Comments</li></ul></div>
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

<div class="in-short"><h3>In short</h3><ul><li>A text box sits anywhere on the page, separate from the main text.</li><li>A page break starts a new page. A section break starts a new part with its own layout.</li><li>Section breaks are how one document mixes portrait and landscape.</li><li>Comments mark a document without changing it.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">What is the difference between a page break and a section break?</p><p class="a">A page break simply starts a new page with the same layout. A section break starts a new part of the document which can have different margins, orientation and page numbering.</p></li><li><p class="q">A report is mostly portrait but has one wide table that needs landscape. How is that done?</p><p class="a">Insert a section break before and after the table, then set the orientation of that section alone to landscape.</p></li><li><p class="q">What is a gutter margin and when is it used?</p><p class="a">Extra space added to the inside edge of the page, used when the document is to be bound so that text is not lost in the binding.</p></li></ol></div>',
   'html', 29)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 32: Introduction to spreadsheets
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('3cc17784-7175-5af6-81e2-1594b2a85875', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 32',
   'Introduction to spreadsheets',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>The parts of a worksheet</li><li>Selecting cells and ranges</li><li>Editing and formatting</li></ul></div>
<p>A spreadsheet is a grid that recalculates. Change one number and everything
depending on it updates by itself, at once and without being asked. That single
property is why the spreadsheet replaced the ledger book.</p>

<figure class="fig"><img src="/notes/figures/spreadsheet_grid.png" alt="The parts of a worksheet"><figcaption>The parts of a worksheet</figcaption></figure>

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

<div class="in-short"><h3>In short</h3><ul><li>A cell address is the column letter then the row number.</li><li>A range is written with a colon, as in A1:C10.</li><li>Every formula begins with an equals sign.</li><li>Hold Ctrl to select cells that are not next to each other.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Write the address of the cell in column D, row 12.</p><p class="a">D12. The column letter comes first, then the row number.</p></li><li><p class="q">What does the range B2:D10 refer to, and how many cells does it hold?</p><p class="a">The rectangle from B2 to D10, which is three columns by nine rows, so 27 cells.</p></li><li><p class="q">A cell shows a row of hash marks. What does that mean?</p><p class="a">The column is too narrow to display the number. Widening the column fixes it, and the data itself is unaffected.</p></li></ol></div>',
   'html', 30)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 33: Performing calculations using spreadsheets
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('649c95ca-ea97-558f-a7f4-c5ea1612eed9', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 33',
   'Performing calculations using spreadsheets',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Arithmetic in a spreadsheet</li><li>SUM, AVERAGE, COUNT, PRODUCT, IF, COUNTIF</li><li>AI features in spreadsheets</li></ul></div>
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

<div class="in-short"><h3>In short</h3><ul><li>Every formula begins with an equals sign.</li><li>Use cell references, never typed numbers.</li><li>IF takes a condition, then the answer if true, then the answer if false.</li><li>Nest IF from the highest boundary downwards.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Write a formula to find the average of the values in B2 to B25.</p><p class="a">=AVERAGE(B2:B25)</p></li><li><p class="q">Write a formula that shows Pass if cell D5 holds 50 or more, and Fail otherwise.</p><p class="a">=IF(D5>=50,"Pass","Fail")</p></li><li><p class="q">Why must a nested IF for grades start from the highest boundary?</p><p class="a">Because the first condition that is true is the one used. Testing the lowest boundary first would give the lowest grade to every mark above it.</p></li></ol></div>',
   'html', 31)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 34: Types of cells referencing and calculations
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('dcc6a25a-3283-5715-846c-fd43efd43007', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 34',
   'Types of cells referencing and calculations',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Relative, absolute and mixed references</li><li>Using RANK</li><li>Building a mark sheet</li></ul></div>
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
<figure class="fig"><img src="/notes/figures/cell_ref.png" alt="The same formula copied down, with and without the dollar signs"><figcaption>The same formula copied down, with and without the dollar signs</figcaption></figure>
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

<div class="in-short"><h3>In short</h3><ul><li>Relative references move when copied. Absolute references do not.</li><li>Write $E$1 to fix a reference that every row must use.</li><li>F4 moves a reference through the four states.</li><li>RANK needs an absolute range, or every row ranks against a different list.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give the difference between relative and absolute cell referencing.</p><p class="a">A relative reference such as A1 changes as the formula is copied to other cells. An absolute reference such as $A$1 stays on the same cell however the formula is copied.</p></li><li><p class="q">A formula multiplying prices by a rate in E1 works in the first row and gives zeros below. Explain and correct it.</p><p class="a">The reference to E1 is relative, so it moved down as the formula was copied and now points at empty cells. Change it to $E$1.</p></li><li><p class="q">Two students score 78 and are ranked second. What rank does the next student get?</p><p class="a">Fourth. RANK gives tied values the same rank and then skips the position in between.</p></li></ol></div>',
   'html', 32)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 35: Positive and Negative Uses of Computer Systems
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('42bd2533-721e-57de-9bff-0123772b9621', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 35',
   'Positive and Negative Uses of Computer Systems',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>The good uses</li><li>The harmful uses</li><li>Social and economic effects</li><li>Using ICT responsibly</li></ul></div>
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
consume other people''s. Guard your own and other people''s personal data. Keep
screen time in proportion to the rest of life. And help somebody who has less
access than you, which is the practical answer to the digital divide.</p>

<div class="in-short"><h3>In short</h3><ul><li>Computers help communication, education, health, trade, work, government and farming.</li><li>They also bring lost work, crime, lost privacy, false information and cultural loss.</li><li>The gains and the harms are both real and both should be stated.</li><li>Check before sharing, and guard personal data.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give three good and three harmful uses of computer systems.</p><p class="a">Good. Instant low cost communication, education through online resources, and mobile money giving people financial access. Harmful. Fraud and identity theft, loss of routine jobs to automation, and the spread of false information.</p></li><li><p class="q">How has mobile money affected Cameroon?</p><p class="a">It has given financial services to large numbers of people who never held a bank account, letting them send, receive and store money and trade beyond their own area.</p></li><li><p class="q">What is meant by cultural erosion here?</p><p class="a">The weakening of local languages, customs and traditions as dominant online cultures and languages take their place.</p></li></ol></div>',
   'html', 33)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 36: Computer Ethics, Legislation and Cameroon Law
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('50ea657b-7078-5897-81a4-b843240fd55e', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 36',
   'Computer Ethics, Legislation and Cameroon Law',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>A code of ethics for computer users</li><li>Cameroon law</li><li>New problems from AI</li></ul></div>
<p>Ethics is what you should do. Law is what you must do. They overlap and they
are not the same, and the difference is worth stating clearly.</p>

<div class="def-box"><strong>Computer ethics.</strong> the moral principles that guide how people use computers and information, concerned with what is right and not only with what is legal.</div>

<h3>What is asked of a computer user</h3>
<ul>
<li>Do not use a computer to harm other people.</li>
<li>Do not interfere with other people''s computer work.</li>
<li>Do not look through other people''s files.</li>
<li>Do not use a computer to steal, or to lie.</li>
<li>Do not copy or use software you have not paid for.</li>
<li>Do not use other people''s resources without permission.</li>
<li>Do not claim other people''s work as your own.</li>
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
<p>Some things are wrong without being crimes. Reading a friend''s messages over
their shoulder, or using the office printer for personal work, are unkind or
dishonest rather than illegal.</p>
<p>Some things are both. Breaking into a company''s server, installing pirated
software, or pretending to be somebody else to get money.</p>
<p>And some things are legal yet hard to defend, such as a company collecting
far more personal data than it needs, buried in terms nobody reads. That third
group is the interesting one.</p>

<h3>The newer problems</h3>
<ul>
<li><strong>Material written by AI.</strong> Who owns it, and must its use be
declared? Handing it in as your own work is dishonest whatever the tool''s terms
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

<div class="in-short"><h3>In short</h3><ul><li>Ethics is what you should do. Law is what you must do.</li><li>Law No. 2010/012 of 2010 covers cybersecurity and cybercrime in Cameroon.</li><li>Hacking, electronic fraud, identity theft and piracy are all punished under it.</li><li>Deepfakes are dangerous because they are cheap, convincing and hard to disprove.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give the difference between an unethical act and an illegal act, with an example of each.</p><p class="a">An unethical act breaks a moral principle but may not break the law, such as reading a colleague''s messages without permission. An illegal act breaks the law and is punished, such as gaining access to a computer system without permission.</p></li><li><p class="q">Name the main Cameroonian law on cybercrime.</p><p class="a">Law No. 2010/012 of 21 December 2010, relating to cybersecurity and cybercriminality in Cameroon.</p></li><li><p class="q">Why are deepfakes considered dangerous?</p><p class="a">Because they are cheap to produce, convincing enough to be believed, and very hard to disprove once they have spread, so the harm is done before any correction reaches the same audience.</p></li></ol></div>',
   'html', 34)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 37: Data Protection, Copyright and the Digital Divide
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('be410b50-ef49-5292-b7de-fddba72cf113', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 37',
   'Data Protection, Copyright and the Digital Divide',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Data protection</li><li>Copyright</li><li>The digital divide</li></ul></div>
<p>Three connected ideas. Who controls information about you, who owns what
people create, and who is left behind when everything moves online.</p>

<h3>Data protection</h3>
<div class="def-box"><strong>Data protection.</strong> the law and practice governing how personal data about identifiable people is collected, stored, used and shared.</div>
<p>The principles are much the same wherever they are written down. Collect
data lawfully and fairly, with the person''s knowledge. Use it only for the
purpose you stated. Collect no more than you need. Keep it accurate. Do not keep
it longer than necessary. Keep it secure. And let people see what you hold about
them and have mistakes corrected.</p>
<p>In Cameroon, data security sits inside Law No. 2010/012. The framework most
often quoted internationally is the European GDPR, which is worth knowing
because it applies to any organisation handling European citizens'' data wherever
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
<li><strong>Plagiarism</strong> means presenting somebody else''s work as your
own. It is not always illegal and it is always dishonest.</li>
<li><strong>Fair dealing</strong> allows limited use for education, criticism,
news and research, with credit given.</li>
<li><strong>Open source and Creative Commons</strong> licences grant rights in
advance. Read the licence, because some require credit and some forbid
commercial use.</li>
</ul>

<h3>The digital divide</h3>
<div class="def-box"><strong>Digital divide.</strong> the gap between those who have access to information and communication technology, and the skills to use it, and those who do not.</div>
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

<div class="in-short"><h3>In short</h3><ul><li>Data protection governs how personal information is collected and used.</li><li>Copyright begins automatically when a work is created. No registration is needed.</li><li>Piracy is unlawful copying. Plagiarism is claiming somebody''s work as your own.</li><li>The digital divide is closed by access, affordability, skills and local language content.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">When does copyright begin, and must it be registered?</p><p class="a">It begins automatically at the moment the original work is created, and no registration is required.</p></li><li><p class="q">Give the difference between software piracy and plagiarism.</p><p class="a">Piracy is unlawfully copying, installing or distributing software against its licence. Plagiarism is presenting somebody else''s work as your own without credit.</p></li><li><p class="q">Suggest three practical ways to narrow the digital divide in your community.</p><p class="a">Open the school computer room outside teaching hours. Run digital skills classes for adults and for young people out of school. Provide services in local languages and make them work on a basic phone.</p></li></ol></div>',
   'html', 35)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 38: Protecting Computer Systems from Illegal Access
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('baecd70c-5997-5e0c-a8b7-d26be1770e0b', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 38',
   'Protecting Computer Systems from Illegal Access',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Security, reliability and resilience</li><li>Ways to keep people out</li><li>Backup</li></ul></div>
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
<figure class="fig"><img src="/notes/figures/backup_types.png" alt="Full, incremental and differential backup"><figcaption>Full, incremental and differential backup</figcaption></figure>
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

<div class="in-short"><h3>In short</h3><ul><li>Security keeps people out. Reliability works correctly. Resilience recovers afterwards.</li><li>Encryption makes data unreadable to anybody without the key.</li><li>Biometric data cannot be changed once it is stolen.</li><li>Three copies, two kinds of media, one kept elsewhere.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Define encryption.</p><p class="a">Scrambling data so that it can only be read by somebody holding the correct key, which makes intercepted data useless.</p></li><li><p class="q">Give one advantage and one disadvantage of biometric authentication.</p><p class="a">It cannot be forgotten or easily shared, and it identifies the person rather than a card they carry. Its disadvantage is that biometric data cannot be changed if it is ever stolen.</p></li><li><p class="q">Why should one backup copy be kept disconnected from the network?</p><p class="a">Because ransomware encrypts every file it can reach, so a copy that is offline can still be used to recover.</p></li></ol></div>',
   'html', 36)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 39: System Recovery and Safe Working Practices
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('6b781fa4-db14-5994-959b-17bf92e052a9', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 39',
   'System Recovery and Safe Working Practices',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Why recovery matters</li><li>Recovery measures</li><li>Safe working</li></ul></div>
<p>The last lesson was about stopping bad things happening. This one accepts
that some of them will happen anyway, and asks how quickly you get back on your
feet.</p>

<h3>Why recovery matters</h3>
<p>Data is usually worth far more than the hardware holding it. A stolen laptop
costs the price of a laptop. The only copy of a term''s records costs the term.
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
unapproved software on an organisation''s machine. And report anything suspicious
rather than investigating it yourself.</p>

<div class="in-short"><h3>In short</h3><ul><li>Data is usually worth more than the hardware holding it.</li><li>A disaster recovery plan is written before it is needed.</li><li>Deleting a file does not remove the data from the disk.</li><li>Lock your screen, and use a standard account for daily work.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">What is a disaster recovery plan and what should it contain?</p><p class="a">A written document prepared in advance saying what happens after a serious failure. Who is responsible, in what order systems are restored, where the backups are kept, and who to contact.</p></li><li><p class="q">Why does deleting a file not make the data safe from recovery?</p><p class="a">Deleting removes the directory entry pointing to the file, but the data stays on the disk until something overwrites it, and it can be recovered with ordinary software.</p></li><li><p class="q">Give two safe working practices and say what each prevents.</p><p class="a">Locking the screen when you leave the desk prevents somebody else using your session and your access rights. Using a standard account prevents harmful software gaining full control of the system.</p></li></ol></div>',
   'html', 37)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 40: Computer Crimes and Combat Measures
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('d5e5b616-6963-526f-aa28-97a48f89aab1', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 40',
   'Computer Crimes and Combat Measures',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Computer as target or as tool</li><li>The crimes</li><li>Matching crimes to defences</li></ul></div>
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
<li><strong>Identity theft.</strong> Using somebody''s personal details to
pretend to be them.</li>
<li><strong>Copyright infringement.</strong> Unlawful copying and
distribution.</li>
<li><strong>Plagiarism.</strong> Passing off another''s work as your own.</li>
<li><strong>Fraud.</strong> Getting money or goods by deception, including
mobile money scams.</li>
<li><strong>Bullying and stalking online.</strong></li>
<li><strong>Denial of service.</strong> Flooding a system with traffic so that
real users cannot get through.</li>
<li><strong>Ransomware.</strong> Encrypting somebody''s files and demanding
payment.</li>
</ul>

<h3>Matching the defence to the crime</h3>
<ul>
<li><strong>Hacking.</strong> Strong passwords, two factor authentication,
firewalls, prompt patching, access levels.</li>
<li><strong>Phishing.</strong> Training people, because the attack aims at the
person and not the machine. Also spam filters, and checking the sender''s real
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

<div class="in-short"><h3>In short</h3><ul><li>Computer related crime targets the computer. Computer assisted crime uses the computer as a tool.</li><li>Hacking is computer related. Fraud by email is computer assisted.</li><li>Phishing aims at the person, so training is the main defence.</li><li>A disconnected backup is the answer to ransomware.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Put these in a group. Hacking, online fraud, spreading a virus, bullying online.</p><p class="a">Hacking is computer related. Online fraud is computer assisted. Spreading a virus is computer related. Bullying online is computer assisted.</p></li><li><p class="q">What is phishing, and why is training the main defence against it?</p><p class="a">A fake message or website designed to trick a person into giving up their password. Training is the main defence because the attack targets the person rather than the system.</p></li><li><p class="q">Give one defence against ransomware and say why it works.</p><p class="a">Keep a backup copy disconnected from the network, because ransomware can only encrypt what it can reach, so an offline copy allows recovery without paying.</p></li></ol></div>',
   'html', 38)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 41: Malware, Types and Characteristics
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('77b40a2c-02e1-57eb-bc83-7d5ca4c909e6', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 41',
   'Malware, Types and Characteristics',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Virus, worm, Trojan, rootkit, backdoor, spyware</li><li>How they spread and what they do</li><li>AI on both sides</li></ul></div>
<p>Malware is harmful software. The types are told apart by two questions. How
does it get in, and how does it spread once it is there?</p>

<div class="def-box"><strong>Malware.</strong> any software written to damage, disrupt or gain unauthorised access to a computer system.</div>

<h3>Virus and worm, the pair that matters most</h3>
<figure class="fig"><img src="/notes/figures/virus_worm.png" alt="How each one spreads"><figcaption>How each one spreads</figcaption></figure>
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
mistakes, in the target''s own language, matching the style of a colleague. That
removes the very clues people were taught to look for. It also produces harmful
software that rewrites its own code each time it spreads, so that no fixed
signature ever matches it.</p>

<div class="in-short"><h3>In short</h3><ul><li>A virus attaches to a host file and needs a person to run it.</li><li>A worm stands alone and copies itself across a network by itself.</li><li>A Trojan is disguised as something useful and does not copy itself.</li><li>Behaviour based detection catches threats nobody has catalogued.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Give two differences between a virus and a worm.</p><p class="a">A virus attaches itself to a host file while a worm stands alone. A virus needs a person to run something before it acts, while a worm copies itself across a network with no human action.</p></li><li><p class="q">Why is a rootkit so hard to remove?</p><p class="a">Because it buries itself deep in the operating system and actively hides itself and other harmful software from the antivirus, so often the only reliable cure is reinstalling the system.</p></li><li><p class="q">What is a keylogger and what kind of malware is it?</p><p class="a">A program that records every key pressed, capturing passwords and other private input. It is a form of spyware.</p></li></ol></div>',
   'html', 39)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Lower Sixth lesson 42: Protecting a Computer System from Malware
INSERT INTO note_sections (id, note_source_id, chapter_number, title,
                           body, body_format, sequence) VALUES
  ('93ca2523-4130-5160-85c3-e91576142375', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec', 'Lesson 42',
   'Protecting a Computer System from Malware',
   '<div class="objectives"><h3>This lesson covers</h3><ul><li>Good habits</li><li>Scanning with an antivirus</li><li>Setting up a firewall</li></ul></div>
<p>This is the last topic of the term, and it is done at the machine. Most
infections arrive because somebody clicked something, so habits matter as much
as software does.</p>

<h3>Good habits</h3>
<ul>
<li>Do not open attachments from senders you do not know, and be careful of
unexpected attachments even from senders you do, because their account may have
been taken over.</li>
<li>Scan attachments and flash drives before opening them.</li>
<li>Download software only from the maker''s own site or an official store.
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

<div class="in-short"><h3>In short</h3><ul><li>Most infections start with somebody clicking something.</li><li>Update the definitions before you scan.</li><li>Quarantine isolates a file without destroying it.</li><li>A firewall handles traffic. An antivirus handles files. You need both.</li></ul></div>

<div class="quiz"><h3>Test yourself</h3><ol><li><p class="q">Why must antivirus definitions be updated before a scan?</p><p class="a">Because the scanner recognises threats by comparing files against its definition file, so an out of date file will not recognise anything found since it was issued.</p></li><li><p class="q">What does quarantining a file mean, and why is it better than deleting it at once?</p><p class="a">It isolates the file so it cannot run, without destroying it. That allows the file to be recovered if the detection turns out to be a false alarm.</p></li><li><p class="q">Give the difference between a firewall and an antivirus.</p><p class="a">A firewall filters network traffic coming in and going out. An antivirus finds and removes harmful software already on the machine.</p></li></ol></div>',
   'html', 40)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  chapter_number = EXCLUDED.chapter_number, body = EXCLUDED.body,
  body_format = EXCLUDED.body_format, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- Attach each note to the lesson of the same name, so it appears on the
-- progression sheet and in the reader. Rebuilt from the sheet each time
-- rather than stored by hand.
INSERT INTO lesson_note_sections (lesson_id, note_section_id, coverage)
SELECT l.id, s.id, 'full'
  FROM note_sections s
  JOIN note_sources src ON src.id = s.note_source_id
  JOIN lessons l
    ON l.syllabus_id = src.syllabus_id
   AND lower(regexp_replace(l.title, '[^a-zA-Z0-9]', '', 'g'))
     = lower(regexp_replace(s.title, '[^a-zA-Z0-9]', '', 'g'))
 WHERE src.id IN ('947e8ce4-cb63-5847-98b1-d4cc5cf2f67f', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec')
   AND s.deleted_at IS NULL AND l.deleted_at IS NULL
ON CONFLICT (lesson_id, note_section_id) DO NOTHING;

COMMIT;

-- What happened. Read every row.
SELECT 'notes loaded' AS item, count(*)::text AS value
  FROM note_sections s JOIN note_sources src ON src.id = s.note_source_id
 WHERE src.id IN ('947e8ce4-cb63-5847-98b1-d4cc5cf2f67f', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec')
   AND s.deleted_at IS NULL
UNION ALL SELECT 'attached to a lesson', count(*)::text
  FROM lesson_note_sections lns
  JOIN note_sections s ON s.id = lns.note_section_id
  JOIN note_sources src ON src.id = s.note_source_id
 WHERE src.id IN ('947e8ce4-cb63-5847-98b1-d4cc5cf2f67f', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec')
UNION ALL SELECT 'not matched to any lesson', count(*)::text
  FROM note_sections s JOIN note_sources src ON src.id = s.note_source_id
 WHERE src.id IN ('947e8ce4-cb63-5847-98b1-d4cc5cf2f67f', '394dbea1-e9d4-5da2-b9db-e2fe1953c8ec')
   AND s.deleted_at IS NULL
   AND NOT EXISTS (SELECT 1 FROM lesson_note_sections x
                    WHERE x.note_section_id = s.id);
