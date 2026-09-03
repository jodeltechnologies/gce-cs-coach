# -*- coding: utf-8 -*-
"""Student notes for the app. Part A.

Written to be read by the learner, on a phone, during or after the lesson.
Plain words. Short paragraphs. No talk of examiners or marks.
"""

NOTES = []


def note(form, no, week, title, covers, html):
    NOTES.append(dict(form=form, no=no, week=week, term=1, title=title,
                      covers=covers, html=html.strip()))


def fig(name, caption):
    return (f'<figure class="fig">'
            f'<img src="/notes/figures/{name}.png" alt="{caption}">'
            f'<figcaption>{caption}</figcaption></figure>')


def box(term, meaning):
    return f'<div class="def-box"><strong>{term}.</strong> {meaning}</div>'


def short(*points):
    items = "".join(f"<li>{p}</li>" for p in points)
    return f'<div class="in-short"><h3>In short</h3><ul>{items}</ul></div>'


def quiz(*pairs):
    rows = "".join(
        f'<li><p class="q">{q}</p><p class="a">{a}</p></li>' for q, a in pairs)
    return f'<div class="quiz"><h3>Test yourself</h3><ol>{rows}</ol></div>'


# =====================================================================
# FORM 5
# =====================================================================

note("Form 5", 4, 2, "Introduction to Artificial Intelligence",
     ["What AI is", "How AI grew", "The types of AI around us"], f"""
<p>You have used artificial intelligence already today, probably more than
once. If your phone unlocked when it saw your face, that was AI. If the
keyboard guessed your next word, that was AI. If a message went to the spam
folder before you ever saw it, that was AI too. This lesson gives a name to
something you have been living with for years.</p>

{box("Artificial intelligence",
     "the branch of computer science that builds machines able to do things "
     "that would normally need human intelligence, such as seeing, "
     "understanding language, learning from experience and making decisions.")}

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
{fig("ai_circles", "Artificial intelligence, machine learning and deep learning")}
<p>Artificial intelligence is the whole idea. Machine learning is one way of
doing it, where the system works out its own rules from examples. Deep learning
is one way of doing machine learning, using neural networks with many layers.
Each one sits inside the one before it. A traffic light controller that follows
fixed rules is artificial intelligence with no learning in it at all.</p>

{short(
 "AI means machines doing jobs that would normally need human intelligence.",
 "Every AI system that exists today is narrow. It does one job.",
 "John McCarthy named the field in 1956.",
 "All deep learning is machine learning, and all machine learning is AI. It "
 "does not work the other way round.")}

{quiz(
 ("Give the meaning of artificial intelligence in one sentence.",
  "It is the branch of computer science that builds machines able to do things "
  "that would normally need human intelligence, such as seeing, understanding "
  "language, learning and deciding."),
 ("A hospital uses a system that reads chest X-rays and marks the ones that "
  "may show tuberculosis. What type of AI is it?",
  "Narrow AI, because it does only that one job. By the second grouping it is "
  "a limited memory system, because it learned from stored X-ray images."),
 ("Why is it wrong to say a self driving car is general AI?",
  "Because it can only drive. General AI would be able to take on any task a "
  "person can, and no such system has been built."))}
""")


note("Form 5", 5, 2, "Applications and Ethics of Artificial Intelligence",
     ["Where AI is used", "AI in different fields", "The problems AI brings"],
     f"""
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

{short(
 "AI is at work in health, farming, banking, transport, education and "
 "language.",
 "Bias comes from the data the system learned from, not from any opinion held "
 "by the machine.",
 "Privacy, lost jobs, unclear blame and fake material are the other main "
 "worries.",
 "Use AI to understand a topic. Do not use it to produce work you hand in.")}

{quiz(
 ("Name two fields where AI is used and say what it does in each.",
  "For example, health, where it reads medical scans to find disease early. "
  "And banking, where it checks a payment against your usual habits to spot "
  "fraud."),
 ("Explain how bias gets into an AI system.",
  "The system learns patterns from its training data. If that data leaves out "
  "or misrepresents a group of people, the system repeats that fault in every "
  "decision it makes."),
 ("Give one reason a student should not hand in work written by an AI tool.",
  "It is dishonest, and it also stops the student learning material they will "
  "have to know without the tool in front of them."))}
""")


note("Form 5", 6, 2, "The use of appropriate Prompts to generate AI responses",
     ["Looking at what a prompt returns", "Judging the result",
      "Writing prompts that solve a problem"], f"""
<p>This lesson is done at the machine. A prompt is what you type to an AI tool.
The whole skill rests on one plain fact. A vague prompt gives a vague answer,
and a careful prompt gives a useful one. The tool is not reading your mind. It
reads your sentence, and it fills any gap you leave with a guess.</p>

{box("Prompt", "the instruction or question you give an AI tool, which decides "
     "the answer you get back.")}

<h3>The four parts of a good prompt</h3>
{fig("prompt_parts", "Role, task, context and format")}
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

{short(
 "A prompt is the instruction you give an AI tool.",
 "A good prompt has four parts. Role, task, context and format.",
 "Hallucination means the tool states something false with complete "
 "confidence.",
 "Check every answer against a source you trust before you use it.")}

{quiz(
 ("Name the four parts of a well built prompt.",
  "Role, task, context and format."),
 ("Improve this prompt. Write about networks.",
  "For example. You are a Computer Science teacher. Explain the difference "
  "between a LAN and a WAN to a Form 5 student, with two examples of each, in "
  "under 150 words. That adds a role, a context and a format."),
 ("What is a hallucination?",
  "When an AI tool produces information that is false or invented but states "
  "it as confidently as it states anything true."))}
""")


# =====================================================================
# LOWER SIXTH
# =====================================================================

note("Lower Sixth", 1, 1, "History and Evolution of Computing",
     ["The generations of computers", "How size, power and price changed",
      "Von Neumann and Harvard architecture", "The stored program idea"], f"""
<p>Computers are usually divided into five generations, and each one is named
after the switch it was built from. Learn the switch and the rest follows,
because every generation is smaller, faster, cheaper, cooler and more reliable
than the one before it.</p>

{fig("generations", "Five generations, and the direction of travel")}

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
{box("Stored program concept",
     "the idea that a computer keeps its instructions in the same memory as its "
     "data, so the machine can be given a new job by loading a new program "
     "instead of being rewired.")}

<p>It is hard now to see how large a change this was. Before it, altering what
ENIAC did meant a team physically moving cables for days. After it, you load a
different program in seconds and the same machine does something completely
different. This one idea is the reason a computer can do any job, while a
calculator can only do sums.</p>

<h3>Two ways to arrange a computer</h3>
{fig("vn_harvard", "One bus, or two")}
<p>In the <strong>Von Neumann</strong> arrangement there is one memory holding
both instructions and data, and one bus carrying both. It is simple and cheap
to build. Its weakness has a name. Instructions and data must take turns on the
same road, and that is called the Von Neumann bottleneck.</p>
<p>In the <strong>Harvard</strong> arrangement there are separate memories and
separate buses for instructions and for data. Both can move at the same moment,
so the machine runs faster. It costs more, so it is used where speed matters
most, in signal processors and in small control chips.</p>

{short(
 "Five generations. Vacuum tube, transistor, integrated circuit, "
 "microprocessor, artificial intelligence.",
 "Across the generations machines became smaller, faster, cheaper, cooler and "
 "more reliable.",
 "The stored program idea lets one machine do any job by loading a new "
 "program.",
 "Harvard uses separate buses for instructions and data, so both can move at "
 "once. Von Neumann shares one bus.")}

{quiz(
 ("Name the switch used in each of the five generations.",
  "Vacuum tube, transistor, integrated circuit, microprocessor, and artificial "
  "intelligence with parallel processing."),
 ("State the stored program idea.",
  "That instructions are held in the same memory as data, so a computer can be "
  "given a new task by loading a new program rather than being rewired."),
 ("What is the Von Neumann bottleneck?",
  "The limit on speed caused by instructions and data having to share one bus "
  "between the processor and the memory."))}
""")


note("Lower Sixth", 3, 1, "AI Ethics and Responsible Use",
     ["The problems AI raises", "Its risks and its benefits",
      "Rules for using it responsibly"], f"""
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

{short(
 "AI brings speed, steadiness, reach and lower cost.",
 "It also brings bias, loss of privacy, decisions nobody can explain, and "
 "lost work.",
 "Bias comes from the training data.",
 "Fairness, openness, responsibility, privacy and human oversight are the "
 "rules to hold it to.")}

{quiz(
 ("Explain why an AI system may be biased.",
  "Because it learns its rules from training data. If that data leaves out or "
  "misrepresents a group, the rules it learns repeat that fault."),
 ("What is meant by human oversight and why does it matter?",
  "That a person can review the system's decision and overturn it. It matters "
  "because these systems make confident mistakes, and in health or law an "
  "unchallenged wrong decision does serious harm."),
 ("Why is the black box problem serious when a bank refuses a loan?",
  "Because the applicant has a right to know why they were refused, and if "
  "nobody can explain the reasoning the decision cannot be challenged."))}
""")


note("Lower Sixth", 4, 1, "AI Techniques and Intelligent Systems",
     ["Common AI techniques", "What makes a system intelligent",
      "Choosing between the techniques"], f"""
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

{short(
 "Machine learning, neural networks, deep learning, language processing, "
 "computer vision, expert systems, robotics and fuzzy logic.",
 "An intelligent system learns, reasons, perceives, solves problems, adapts "
 "and handles language.",
 "Expert systems can explain their answers. Neural networks cannot.",
 "Match the technique to the kind of data and to whether the answer must be "
 "explained.")}

{quiz(
 ("A hospital wants a system that suggests a diagnosis and can show the doctor "
  "how it reached it. Which technique suits this?",
  "An expert system, because it applies rules given by human experts and can "
  "show which rules it used."),
 ("Give four things that make a system intelligent.",
  "Any four of learning, reasoning, perception, problem solving, adapting and "
  "handling language."),
 ("Why can a neural network usually not explain its decision?",
  "Because the answer comes from the weights of many thousands of connections "
  "across several layers, and those do not match any rule a person can "
  "read."))}
""")


note("Lower Sixth", 5, 2, "Machine Learning",
     ["What machine learning is", "How it works",
      "Supervised, unsupervised and reinforcement learning"], f"""
<p>In ordinary programming you write the rules and the computer applies them.
In machine learning you supply the examples and the computer works out the
rules for itself. That reversal is the whole idea.</p>

{box("Machine learning",
     "a branch of artificial intelligence in which a system learns patterns "
     "from data and gets better at a task with experience, without being given "
     "the rules by a programmer.")}

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
{fig("ml_types", "Supervised, unsupervised and reinforcement learning")}

<p>The question that separates them is whether the training data carries
labels. If it does, the learning is supervised. If it does not, the learning is
unsupervised. If there is no data set at all and the system learns by being
rewarded or punished for what it tries, the learning is reinforcement.</p>

<h3>Two ways it fails</h3>
<p><strong>Overfitting</strong> means the model has memorised the training
data, including its accidents, and does badly on anything new. It is the
student who learned last year's questions word for word without
understanding the topic, and who is then beaten by a question worded
differently.</p>
<p><strong>Underfitting</strong> means the model is too simple to catch the
pattern at all, and does badly even on the data it learned from.</p>
<p>You tell them apart by the gap. High accuracy on training data and poor
accuracy on test data means overfitting. Poor on both means underfitting.</p>

{short(
 "Machine learning finds its own rules from data instead of being given "
 "them.",
 "Collect, clean, train, test, then keep watching.",
 "Supervised uses labelled data. Unsupervised uses unlabelled data. "
 "Reinforcement learns from rewards and penalties.",
 "Overfitting means it memorised instead of learning.")}

{quiz(
 ("A shop has records of past customers with no labels and wants to find "
  "natural groups among them. Which kind of learning?",
  "Unsupervised learning, because the data has no labels and the task is to "
  "discover groupings."),
 ("Why must test data be kept separate from training data?",
  "Because testing on data the model already learned from measures memory, not "
  "the ability to handle new cases."),
 ("What is overfitting and how would you spot it?",
  "When a model memorises its training data, including the noise, and does "
  "badly on new data. You spot it by high accuracy on training data together "
  "with poor accuracy on test data."))}
""")


note("Lower Sixth", 6, 2, "Developing AI Systems",
     ["The stages of building an AI system", "Languages and tools",
      "Why Python is used so widely"], f"""
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
runs on Google's machines when your own is not strong enough.</li>
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

{short(
 "Say what the problem is, collect data, clean it, choose a model, train, "
 "measure, deploy, then watch and retrain.",
 "Cleaning the data takes most of the time.",
 "TensorFlow and PyTorch for deep learning. Pandas and NumPy for the data.",
 "Python leads because it is simple to write, has free mature libraries, and "
 "has a very large community.")}

{quiz(
 ("Which stage of building an AI system usually takes longest, and why?",
  "Cleaning the data, because real data arrives incomplete, inconsistent and "
  "full of errors, and all of that has to be put right before training."),
 ("Why must a model be watched and retrained after it is put to work?",
  "Because the world changes, so the patterns the model learned stop holding "
  "and its accuracy falls."),
 ("Give three reasons Python is used so widely for AI work.",
  "Any three of. It is simple and readable. Its libraries are mature and free. "
  "Its community is very large. It calls fast code underneath. It runs "
  "everywhere and costs nothing."))}
""")


note("Lower Sixth", 7, 2, "Types of Computers",
     ["Supercomputer, mainframe, minicomputer, microcomputer",
      "Size, power, cost and purpose", "Choosing the right one"], f"""
<p>Computers are grouped into four types, in order of size and power. The
useful thing is to learn them by what they are for, because that is what
decides which one suits a given job.</p>

{fig("computer_types", "Four types, from the largest down")}

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

{short(
 "Supercomputer, mainframe, minicomputer, microcomputer, in order of falling "
 "power.",
 "A supercomputer is for speed on one huge calculation.",
 "A mainframe is for volume and reliability across millions of small "
 "transactions.",
 "A smartphone is a microcomputer.")}

{quiz(
 ("State the main difference between a supercomputer and a mainframe.",
  "A supercomputer is built for the greatest possible speed on a single large "
  "calculation. A mainframe is built for high volume transaction processing "
  "and continuous reliability for many users at once."),
 ("Which type would a weather service use, and why?",
  "A supercomputer, because forecasting is one enormous calculation that needs "
  "the greatest possible processing speed."),
 ("Is a smartphone a computer, and if so which type?",
  "Yes. It is a microcomputer, because it has one processor serving a single "
  "user at a time."))}
""")


note("Lower Sixth", 8, 2, "Basic Components of a Computer",
     ["Hardware, input, output, storage and processing",
      "What the common devices do", "Choosing a device"], f"""
<p>Every computer, from a smartwatch to a mainframe, is the same four things
arranged the same way. Something takes data in. Something works on it.
Something keeps it. Something gives the result out.</p>

{fig("ipos", "Input, process, output and storage")}

{box("Hardware", "the physical parts of a computer system, the parts you can "
     "touch, as opposed to the programs and data that tell them what to do.")}

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

{short(
 "Input, process, output and storage. Every computer is these four.",
 "Hardware means the parts you can touch.",
 "Touch screens and modems are both input and output. A flash drive is "
 "storage.",
 "Match the device to the volume of data, the surroundings, and who has to use "
 "it.")}

{quiz(
 ("Put each of these in a group. Scanner, actuator, RAM, touch screen.",
  "Scanner is input. Actuator is output. RAM is primary storage. A touch "
  "screen is both input and output."),
 ("Why is a flash drive counted as storage rather than input or output?",
  "Because its purpose is to hold data, not to bring data in for processing or "
  "to present results to a user."),
 ("A clinic must record details from three hundred handwritten forms a day. "
  "Suggest an input device and say why.",
  "A scanner with character recognition software, because it captures the "
  "forms far faster than typing and avoids the errors a typist would make at "
  "that volume."))}
""")


note("Lower Sixth", 9, 3, "Input devices",
     ["Automatic data capture", "MICR, OCR, OMR, barcode, QR, card and RFID",
      "How AI reading extends data capture"], f"""
<p>Typing is slow, and typing is where mistakes come from. Even a trained
typist makes an error every few hundred keystrokes, and at the volume a bank or
a supermarket handles that is not acceptable. Automatic data capture is the
answer. Let a machine read the data straight from the source.</p>

{box("Automatic data capture", "collecting data directly into a computer from "
     "its source, with nobody keying it in.")}

{fig("data_capture", "Ways of reading data without typing it")}

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

{short(
 "Automatic data capture reads data from its source with no typing.",
 "OMR reads marks. OCR reads characters. That is the difference.",
 "RFID needs no line of sight and works at a distance.",
 "AI reading does not need the object labelled in advance.")}

{quiz(
 ("Give the difference between OMR and OCR.",
  "OMR finds the position of marks, such as a pencil mark in a box on an "
  "answer sheet. OCR recognises printed or handwritten characters and turns "
  "them into text."),
 ("Why is RFID chosen instead of barcodes in a warehouse?",
  "Because RFID needs no line of sight and works at a distance, so a whole "
  "pallet can be read at once without unpacking it."),
 ("A supermarket scans an item and the price appears. What actually happened?",
  "The reader captured the product code from the barcode. The system looked "
  "that code up in the stock database and returned the price stored there."))}
""")


note("Lower Sixth", 10, 3, "Output devices",
     ["Dot matrix, laser and inkjet printers",
      "Projector, plotter, 3D printer, actuator",
      "Choosing an output device"], f"""
<p>Output is where the computer's work becomes something a person, or another
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

{short(
 "Dot matrix is an impact printer, so it alone can print carbon copies in one "
 "pass.",
 "Inkjet suits colour and photographs at low volume. Laser suits high volume "
 "text.",
 "A plotter draws continuous lines. A printer builds a picture from dots.",
 "An actuator turns a signal into movement, and is the output of a control "
 "system.")}

{quiz(
 ("Give one situation where a dot matrix printer is still the right choice, "
  "and say why.",
  "Printing multi part invoices or payslips, because it is an impact printer "
  "and can produce carbon copies in a single pass."),
 ("What is the difference between a printer and a plotter?",
  "A printer builds an image out of dots and suits text and ordinary "
  "documents. A plotter draws continuous accurate lines with pens and suits "
  "large technical drawings."),
 ("What is an actuator, and in what kind of system is it used?",
  "A device that turns an electrical signal into physical movement, used as "
  "the output device of a control system."))}
""")


note("Lower Sixth", 11, 3, "Secondary Storage media and devices",
     ["Secondary against primary storage",
      "Magnetic, optical and solid state storage",
      "Choosing storage"], f"""
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

{short(
 "Primary storage is fast, small and reached directly by the processor. RAM is "
 "volatile.",
 "Secondary storage is slow, large and keeps its contents.",
 "Magnetic is cheapest. Optical is portable. Solid state is fastest and "
 "toughest.",
 "Tape is read from beginning to end, which is why it suits backup.")}

{quiz(
 ("Give three differences between primary and secondary storage.",
  "The processor reaches primary storage directly and secondary storage only "
  "through RAM. Primary is much faster but much smaller. RAM is volatile while "
  "secondary storage keeps its contents."),
 ("Why is a solid state drive better than a hard disk in a laptop?",
  "It has no moving parts, so it is faster, silent, uses less power and "
  "survives being knocked or dropped while running."),
 ("Why is magnetic tape still used for backup?",
  "Because it costs less for each gigabyte than anything else, and reading it "
  "from beginning to end is no disadvantage when the whole backup is read "
  "anyway."))}
""")


note("Lower Sixth", 12, 3, "Primary Storage devices",
     ["RAM, ROM, cache and registers", "Comparing them",
      "Why AI training needs so much storage"], f"""
<p>There is an order inside the machine, and it holds all the way down. The
closer to the processor, the faster, the smaller and the more expensive for
each byte. If you understand that one sentence you can rebuild this whole topic
from memory.</p>

{fig("memory_pyramid", "The order of memory, from the processor outward")}

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

{short(
 "Registers, cache, RAM, then secondary storage. Speed falls and size rises as "
 "you move away from the processor.",
 "RAM is read and write and volatile. ROM is read only and keeps its "
 "contents.",
 "Cache exists to stop the processor waiting for RAM.",
 "AI training sets are far larger than RAM, so they need large fast secondary "
 "storage.")}

{quiz(
 ("Put these in order from fastest to slowest. RAM, registers, secondary "
  "storage, cache.",
  "Registers, cache, RAM, secondary storage."),
 ("State three differences between RAM and ROM.",
  "RAM can be read and written while ROM is read only in ordinary use. RAM is "
  "volatile while ROM is not. RAM is much larger than ROM."),
 ("What is the purpose of cache memory?",
  "It holds recently and frequently used data in very fast memory close to the "
  "processor, so that the processor spends less time waiting for the slower "
  "RAM."))}
""")
