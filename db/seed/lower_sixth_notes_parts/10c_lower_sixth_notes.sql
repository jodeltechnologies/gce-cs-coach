-- Part C of 7 — notes 2 of 5: Number systems → Graphic software.
-- Run the parts in alphabetical order, one at a time.
-- Safe to run again if you lose your place.

BEGIN;

-- 15 notes
INSERT INTO note_sections
  (id, note_source_id, chapter_number, title, body, body_format, sequence)
VALUES
  ('4b521078-c512-5b54-9253-b8ded692712f', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Number systems', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Positional number system</li><li>Base conversion, e.g. base 2 to 8, 10, 16 and vice versa</li></ul></div><p>A number system has a <strong>base</strong>: how many different digits it
uses. Decimal uses ten, binary two, octal eight, hexadecimal sixteen.</p>

<div class="def-box"><strong>Positional number system:</strong> a system in
which the value of a digit depends on its position, each position being worth
the base raised to a power.</div>

<figure class="fig">
<svg viewBox="0 0 620 160" role="img" aria-label="Place values of the binary number 1011 shown as powers of two">
  <g stroke="var(--cyan)" fill="var(--cyan-soft)" stroke-width="1.5">
    <rect x="150" y="56" width="70" height="44" rx="5"/><rect x="228" y="56" width="70" height="44" rx="5"/>
    <rect x="306" y="56" width="70" height="44" rx="5"/><rect x="384" y="56" width="70" height="44" rx="5"/>
  </g>
  <g fill="currentColor" font-size="20" text-anchor="middle" font-weight="600">
    <text x="185" y="86">1</text><text x="263" y="86">0</text>
    <text x="341" y="86">1</text><text x="419" y="86">1</text>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="185" y="46">2³</text><text x="263" y="46">2²</text>
    <text x="341" y="46">2¹</text><text x="419" y="46">2⁰</text>
    <text x="185" y="120">8</text><text x="263" y="120">4</text>
    <text x="341" y="120">2</text><text x="419" y="120">1</text>
  </g>
  <text x="302" y="148" font-size="13" fill="currentColor" text-anchor="middle">8 + 0 + 2 + 1 = 11 in decimal</text>
  <text x="120" y="86" font-size="12" fill="currentColor" text-anchor="end">1011₂</text>
</svg>
<figcaption>Every position is worth the base to a power. Write the powers above the digits and the conversion does itself.</figcaption>
</figure>

<h3>The four bases</h3>
<ul>
<li><strong>Decimal, base 10</strong> — digits 0 to 9. What people use.</li>
<li><strong>Binary, base 2</strong> — digits 0 and 1. What the machine uses,
because a circuit is on or off.</li>
<li><strong>Octal, base 8</strong> — digits 0 to 7. One octal digit is exactly
three bits.</li>
<li><strong>Hexadecimal, base 16</strong> — digits 0 to 9 then A to F, where A
is 10 and F is 15. One hex digit is exactly four bits. Used because it writes
a byte in two characters instead of eight.</li>
</ul>

<h3>Any base to decimal</h3>
<p>Multiply each digit by its place value and add. 2AF₁₆ = 2×256 + 10×16 +
15×1 = 512 + 160 + 15 = 687.</p>

<h3>Decimal to any base</h3>
<p>Divide repeatedly by the base, keep the remainders, read them
<em>upwards</em>. 45 to binary: 45÷2 = 22 r 1, 22÷2 = 11 r 0, 11÷2 = 5 r 1,
5÷2 = 2 r 1, 2÷2 = 1 r 0, 1÷2 = 0 r 1. Reading up: 101101₂.</p>
<p>Check it: 32 + 8 + 4 + 1 = 45. Always check. It costs ten seconds.</p>

<h3>Binary to octal and hexadecimal, without going through decimal</h3>
<ul>
<li>To octal: group the bits in <strong>threes</strong> from the right,
padding the left with zeros. 101101 → 101 101 → 5 5 → 55₈.</li>
<li>To hexadecimal: group in <strong>fours</strong> from the right. 101101 →
0010 1101 → 2 D → 2D₁₆.</li>
<li>Backwards, expand each digit into three or four bits. C7₁₆ → 1100 0111.</li>
</ul>
<p>Octal to hexadecimal has no shortcut of its own. Go through binary.</p>

<h3>Fractions</h3>
<p>To the right of the point the powers go negative: 0.101₂ = ½ + 0 + ⅛ =
0.625. Decimal fraction to binary: multiply by 2 repeatedly and read the whole
parts <em>downwards</em>. 0.625 × 2 = 1.25 → 1; 0.25 × 2 = 0.5 → 0; 0.5 × 2 =
1.0 → 1. So 0.101₂.</p>

<h3>In the exam</h3>
<p>Show the working. A correct answer with no division column can be marked
down; a wrong answer with correct working still collects method marks. And
always write the base as a subscript.</p>', 'html', 20),
  ('0ed00e70-b7d0-52d2-b5ac-ac65c899aa7c', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Binary arithmetic and Complement Representation', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Addition, subtraction, multiplication, and division</li><li>Unsigned and signed numbers (one''s complement, two''s complement)</li></ul></div><h3>The four operations</h3>
<p>Binary addition has four rules: 0+0=0, 0+1=1, 1+0=1, and 1+1=10, which is 0
carry 1. Only the last one is new.</p>
<pre>  1 0 1 1   (11)
+ 0 1 1 0   (6)
---------
1 0 0 0 1   (17)</pre>
<p>Subtraction: 0−0=0, 1−0=1, 1−1=0, and 0−1 = 1 with a borrow from the next
column. Multiplication is easier than in decimal, because you only ever
multiply by 0 or 1 — shift and add. Division is repeated subtraction and shift,
exactly the long division you already do.</p>

<h3>Unsigned and signed</h3>
<ul>
<li><strong>Unsigned</strong> — every bit is part of the value. In 8 bits the
range is 0 to 255. No negatives at all.</li>
<li><strong>Signed</strong> — the leftmost bit is the <strong>sign bit</strong>:
0 for positive, 1 for negative.</li>
</ul>

<h3>Sign and magnitude</h3>
<p>Sign bit, then the size. +5 = 0000 0101, −5 = 1000 0101. Simple to read, but
there are two zeros — 0000 0000 and 1000 0000 — and arithmetic needs extra
circuitry. Not used in practice.</p>

<h3>One''s complement</h3>
<p>Negate by flipping every bit. +5 = 0000 0101, so −5 = 1111 1010. Still two
zeros, and adding needs an "end-around carry": if a carry comes out of the top,
add it back at the bottom.</p>

<h3>Two''s complement</h3>
<p>Flip every bit, then add one. This is the one every real computer uses.</p>
<figure class="fig">
<svg viewBox="0 0 620 150" role="img" aria-label="Finding two''s complement of five in eight bits">
  <g font-size="14" fill="currentColor" font-family="ui-monospace, monospace">
    <text x="200" y="34">0 0 0 0 0 1 0 1</text>
    <text x="200" y="74">1 1 1 1 1 0 1 0</text>
    <text x="200" y="114">1 1 1 1 1 0 1 1</text>
  </g>
  <g font-size="12" fill="currentColor" text-anchor="end">
    <text x="185" y="34">+5 =</text><text x="185" y="74">flip every bit</text>
    <text x="185" y="114">add 1  →  −5 =</text>
  </g>
  <line x1="196" y1="88" x2="410" y2="88" stroke="currentColor" stroke-width="1.2"/>
  <text x="440" y="34" font-size="11" fill="currentColor">the sign bit is the leftmost</text>
  <text x="440" y="114" font-size="11" fill="currentColor">1 means negative</text>
</svg>
<figcaption>Two''s complement of 5 in eight bits. Flip, then add one.</figcaption>
</figure>

<p>Why it is used:</p>
<ul>
<li>Only one zero.</li>
<li>Subtraction becomes addition: A − B is A + (two''s complement of B), so one
adder circuit does both operations.</li>
<li>Any carry out of the leftmost column is simply discarded.</li>
</ul>
<p>Worked: 9 − 5 in 8 bits. 9 = 0000 1001. −5 = 1111 1011. Add: 1 0000 0100.
Discard the ninth bit: 0000 0100 = 4. Correct.</p>
<p>Range in 8 bits: −128 to +127. Note it is not symmetrical, because the one
spare pattern goes to the negative side.</p>

<h3>Overflow</h3>
<p>Overflow is when the true answer will not fit in the bits available. In
two''s complement the sign of the answer is then wrong: add two positives and
get a negative, and you have overflowed.</p>

<h3>In the exam</h3>
<p>State the number of bits before you start and keep every number that width.
Half the lost marks on this topic are answers of the wrong length.</p>', 'html', 21),
  ('951946ad-3627-5911-a0d7-724c530f7922', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Boolean Logic and Logic Gates', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Identify and sketch logic gate symbols: OR, AND, NOT, NAND, NOR, XOR</li><li>Derive the truth table for each logic gate</li></ul></div><p>Boolean logic has two values, true and false, written 1 and 0. A logic gate
is the circuit that carries out one Boolean operation.</p>

<div class="def-box"><strong>Logic gate:</strong> an electronic circuit with
one or more inputs and one output, whose output is decided by the values of
the inputs.</div>

<figure class="fig">
<svg viewBox="0 0 660 320" role="img" aria-label="Symbols for the AND, OR, NOT, NAND, NOR and XOR gates">
  <g stroke="currentColor" stroke-width="1.6" fill="none">
    <!-- AND -->
    <path d="M60 30 H100 A25 25 0 0 1 100 80 H60 Z"/>
    <path d="M30 42 H60 M30 68 H60 M125 55 H155"/>
    <!-- OR -->
    <path d="M260 30 Q288 55 260 80 Q305 80 330 55 Q305 30 260 30 Z"/>
    <path d="M232 42 H266 M232 68 H266 M330 55 H360"/>
    <!-- NOT -->
    <path d="M470 28 L515 55 L470 82 Z"/>
    <circle cx="521" cy="55" r="6"/>
    <path d="M440 55 H470 M527 55 H560"/>
    <!-- NAND -->
    <path d="M60 190 H100 A25 25 0 0 1 100 240 H60 Z"/>
    <circle cx="131" cy="215" r="6"/>
    <path d="M30 202 H60 M30 228 H60 M137 215 H160"/>
    <!-- NOR -->
    <path d="M260 190 Q288 215 260 240 Q305 240 330 215 Q305 190 260 190 Z"/>
    <circle cx="336" cy="215" r="6"/>
    <path d="M232 202 H266 M232 228 H266 M342 215 H365"/>
    <!-- XOR -->
    <path d="M478 190 Q506 215 478 240 Q523 240 548 215 Q523 190 478 190 Z"/>
    <path d="M466 190 Q494 215 466 240"/>
    <path d="M440 202 H478 M440 228 H478 M548 215 H578"/>
  </g>
  <g fill="currentColor" font-size="13" text-anchor="middle" font-weight="600">
    <text x="92" y="105">AND</text><text x="295" y="105">OR</text><text x="500" y="105">NOT</text>
    <text x="92" y="265">NAND</text><text x="295" y="265">NOR</text><text x="510" y="265">XOR</text>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="92" y="122">Q = A·B</text><text x="295" y="122">Q = A+B</text><text x="500" y="122">Q = Ā</text>
    <text x="92" y="282">Q = A·B</text><text x="295" y="282">Q = A+B</text><text x="510" y="282">Q = A⊕B</text>
    <text x="92" y="296">(inverted)</text><text x="295" y="296">(inverted)</text><text x="510" y="296">different → 1</text>
  </g>
</svg>
<figcaption>The six gate symbols. The small circle on the output is the inversion — that is the only difference between AND and NAND, or OR and NOR.</figcaption>
</figure>

<h3>Truth tables</h3>
<table>
<tr><th>A</th><th>B</th><th>AND</th><th>OR</th><th>NAND</th><th>NOR</th><th>XOR</th></tr>
<tr><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td></tr>
<tr><td>0</td><td>1</td><td>0</td><td>1</td><td>1</td><td>0</td><td>1</td></tr>
<tr><td>1</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>1</td></tr>
<tr><td>1</td><td>1</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>
</table>
<p>NOT has one input: 0 gives 1, 1 gives 0.</p>

<h3>How to remember them</h3>
<ul>
<li><strong>AND</strong> — output 1 only when <em>all</em> inputs are 1.</li>
<li><strong>OR</strong> — output 1 when <em>at least one</em> input is 1.</li>
<li><strong>NOT</strong> — the opposite.</li>
<li><strong>NAND</strong> — AND then invert. Output 0 only when all inputs
are 1.</li>
<li><strong>NOR</strong> — OR then invert. Output 1 only when all inputs
are 0.</li>
<li><strong>XOR</strong> — output 1 when the inputs are <em>different</em>.
That one sentence is the whole gate.</li>
</ul>

<h3>In the exam</h3>
<p>Sketch the symbols with a ruler, in the standard shapes, and never leave off
the inversion circle. Fill truth tables in the standard order 00, 01, 10, 11 —
it is easy to mark and easy to check.</p>
<p>NAND and NOR are called the universal gates: any circuit can be built from
NAND alone, or from NOR alone. That fact is worth a mark on its own.</p>', 'html', 22),
  ('a2016684-3e25-5ff8-ac78-7a5dd5b54f6a', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Combining logic gates', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Combine logic gates to form a logic circuit</li><li>Understanding Boolean algebra and Boolean expression</li></ul></div><p>One gate is not a circuit. Gates are joined so the output of one becomes the
input of the next, and the whole thing carries out a Boolean expression.</p>

<figure class="fig">
<svg viewBox="0 0 660 220" role="img" aria-label="Logic circuit computing Q equals A AND B, OR NOT C">
  <g stroke="currentColor" stroke-width="1.6" fill="none">
    <path d="M170 40 H210 A25 25 0 0 1 210 90 H170 Z"/>
    <path d="M80 52 H170 M80 78 H170"/>
    <path d="M170 140 L212 165 L170 190 Z"/><circle cx="218" cy="165" r="6"/>
    <path d="M80 165 H170"/>
    <path d="M380 78 Q408 108 380 138 Q425 138 450 108 Q425 78 380 78 Z"/>
    <path d="M235 65 H380 M224 165 H380"/>
    <path d="M450 108 H545"/>
  </g>
  <g fill="currentColor" font-size="13">
    <text x="62" y="57">A</text><text x="62" y="83">B</text><text x="62" y="170">C</text>
    <text x="556" y="113">Q</text>
  </g>
  <g fill="currentColor" font-size="11" text-anchor="middle">
    <text x="200" y="110">AND</text><text x="196" y="208">NOT</text><text x="412" y="158">OR</text>
    <text x="300" y="58">A·B</text><text x="300" y="158">C̄</text>
  </g>
  <text x="330" y="18" font-size="13" fill="currentColor" text-anchor="middle" font-weight="600">Q = (A · B) + C̄</text>
</svg>
<figcaption>Read a circuit left to right, labelling each intermediate wire with its expression as you go.</figcaption>
</figure>

<h3>From circuit to expression</h3>
<ol>
<li>Label the inputs.</li>
<li>Work left to right. Write the output expression on every wire as you reach
it.</li>
<li>The label on the last wire is the answer.</li>
</ol>
<p>In the drawing: the AND gate gives A·B, the NOT gate gives C̄, and the OR
gate combines them into Q = A·B + C̄.</p>

<h3>From expression to circuit</h3>
<p>Work from the inside out, exactly as in algebra. For Q = (A + B)·C̄: draw the
OR of A and B, draw the NOT of C, then AND the two results together.</p>

<h3>Boolean algebra: the notation</h3>
<ul>
<li>AND is a dot, or nothing at all: A·B, or AB. It behaves like
multiplication.</li>
<li>OR is a plus: A + B. It behaves like addition.</li>
<li>NOT is a bar over the top, or a prime: Ā, or A''.</li>
<li>Precedence: NOT first, then AND, then OR. So A + B·C means A + (B·C).</li>
</ul>

<h3>The laws you will use</h3>
<table>
<tr><th>Law</th><th>AND form</th><th>OR form</th></tr>
<tr><td>Identity</td><td>A·1 = A</td><td>A + 0 = A</td></tr>
<tr><td>Null</td><td>A·0 = 0</td><td>A + 1 = 1</td></tr>
<tr><td>Idempotent</td><td>A·A = A</td><td>A + A = A</td></tr>
<tr><td>Complement</td><td>A·Ā = 0</td><td>A + Ā = 1</td></tr>
<tr><td>Absorption</td><td>A·(A + B) = A</td><td>A + A·B = A</td></tr>
<tr><td>Distributive</td><td>A·(B + C) = AB + AC</td><td>A + BC = (A+B)(A+C)</td></tr>
</table>
<p>Double negation: the bar over a bar cancels. A with two bars is A.</p>

<h3>In the exam</h3>
<p>Label every intermediate wire on the diagram. It shows the method, and if
you slip at the last gate you still keep the earlier marks.</p>', 'html', 23),
  ('eac8be07-282d-577d-b2f2-abc4e84c4d9d', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Truth table and De Morgan theorem', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Derive truth tables from Boolean expressions (maximum of 3 inputs)</li><li>State and explain De Morgan''s theorem</li><li>Simplify Boolean expressions using De Morgan theorem</li></ul></div><h3>Building a truth table from an expression</h3>
<p>With <em>n</em> inputs there are 2<sup>n</sup> rows. Two inputs, four rows.
Three inputs, eight rows. The syllabus stops at three.</p>
<ol>
<li>Write the input columns in the standard counting order: 000, 001, 010, 011,
100, 101, 110, 111.</li>
<li>Add one column for each intermediate term in the expression.</li>
<li>Fill the intermediate columns first, then combine them for the final
output.</li>
</ol>
<p>Worked, for Q = A·B + C̄:</p>
<table>
<tr><th>A</th><th>B</th><th>C</th><th>A·B</th><th>C̄</th><th>Q</th></tr>
<tr><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td></tr>
<tr><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>
<tr><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>1</td></tr>
<tr><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>
<tr><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td></tr>
<tr><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr>
<tr><td>1</td><td>1</td><td>0</td><td>1</td><td>1</td><td>1</td></tr>
<tr><td>1</td><td>1</td><td>1</td><td>1</td><td>0</td><td>1</td></tr>
</table>

<h3>De Morgan''s theorem</h3>
<div class="def-box">The complement of a product is the sum of the
complements, and the complement of a sum is the product of the complements.
In symbols: <strong>(A·B)‾ = Ā + B̄</strong> and <strong>(A + B)‾ = Ā · B̄</strong>.</div>

<figure class="fig">
<svg viewBox="0 0 660 200" role="img" aria-label="De Morgan equivalence: a NAND gate equals an OR gate with inverted inputs">
  <g stroke="currentColor" stroke-width="1.6" fill="none">
    <path d="M90 40 H130 A25 25 0 0 1 130 90 H90 Z"/><circle cx="161" cy="65" r="6"/>
    <path d="M50 52 H90 M50 78 H90 M167 65 H205"/>
    <path d="M430 40 Q458 65 430 90 Q475 90 500 65 Q475 40 430 40 Z"/>
    <path d="M500 65 H545"/>
    <circle cx="412" cy="52" r="6"/><circle cx="412" cy="78" r="6"/>
    <path d="M360 52 H406 M360 78 H406 M418 52 H436 M418 78 H436"/>
  </g>
  <g fill="currentColor" font-size="13">
    <text x="34" y="57">A</text><text x="34" y="83">B</text>
    <text x="344" y="57">A</text><text x="344" y="83">B</text>
    <text x="214" y="70">Q</text><text x="556" y="70">Q</text>
  </g>
  <text x="290" y="70" font-size="22" fill="currentColor" text-anchor="middle">=</text>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="128" y="126">NAND: (A·B)‾</text>
    <text x="450" y="126">OR with inverted inputs: Ā + B̄</text>
    <text x="330" y="168">Break the bar, change the sign. Same truth table, different drawing.</text>
  </g>
</svg>
<figcaption>The same function, two circuits. This equivalence is why NAND alone can build anything.</figcaption>
</figure>

<h3>How to apply it</h3>
<p>Say it as a rule: <strong>break the bar and change the sign</strong>. Break
the long bar, and swap the dot for a plus or the plus for a dot.</p>
<p>Worked: simplify (A + B̄)‾ · B.</p>
<ul>
<li>Break the bar over (A + B̄): it becomes Ā · B, since the bar over B̄
cancels.</li>
<li>Now the expression is Ā · B · B.</li>
<li>B·B = B by the idempotent law.</li>
<li>Answer: Ā · B. Three gates become two.</li>
</ul>

<h3>Why simplify at all</h3>
<p>Fewer gates means a cheaper circuit, less power, less heat and less delay.
Say that if asked to justify simplification — it is a mark, and most candidates
only write "it is shorter".</p>

<h3>In the exam</h3>
<p>Show every step with the law named beside it. And prove an equivalence by
building both truth tables and showing the output columns are identical; that
is a complete proof and is often what "verify" means.</p>', 'html', 24),
  ('ee3b02eb-8688-53f2-989f-84d8f17ff660', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Definitions and Classification of software', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Based on source (open versus proprietary)</li><li>Based on licence (shareware versus freeware)</li></ul></div><div class="def-box"><strong>Software:</strong> the set of programs,
procedures and associated data that tell the hardware what to do.</div>

<figure class="fig">
<svg viewBox="0 0 660 230" role="img" aria-label="Classification of software by function, source and licence">
  <g stroke="var(--cyan)" fill="var(--cyan-soft)" stroke-width="1.5">
    <rect x="270" y="12" width="120" height="34" rx="6"/>
    <rect x="60" y="80" width="150" height="34" rx="6"/>
    <rect x="450" y="80" width="150" height="34" rx="6"/>
    <rect x="20" y="150" width="110" height="34" rx="6"/>
    <rect x="140" y="150" width="110" height="34" rx="6"/>
    <rect x="410" y="150" width="110" height="34" rx="6"/>
    <rect x="530" y="150" width="110" height="34" rx="6"/>
  </g>
  <g fill="currentColor" font-size="12" text-anchor="middle">
    <text x="330" y="34">Software</text>
    <text x="135" y="102">by source</text><text x="525" y="102">by licence</text>
    <text x="75" y="171">open source</text><text x="195" y="171">proprietary</text>
    <text x="465" y="171">freeware</text><text x="585" y="171">shareware</text>
  </g>
  <g stroke="currentColor" stroke-width="1.4" fill="none">
    <path d="M300 46 V64 H135 V80"/><path d="M360 46 V64 H525 V80"/>
    <path d="M100 114 V132 H75 V150"/><path d="M170 114 V132 H195 V150"/>
    <path d="M490 114 V132 H465 V150"/><path d="M560 114 V132 H585 V150"/>
  </g>
</svg>
<figcaption>Two independent classifications. A program has a source category and a licence category at the same time.</figcaption>
</figure>

<h3>Classification by source</h3>
<ul>
<li><strong>Open source</strong> — the source code is published. Anyone may
read it, change it and redistribute it, under a licence such as the GPL. Linux,
LibreOffice, Firefox, GIMP.
<br>Advantages: free or cheap, can be adapted to your own needs, many eyes find
bugs, no lock-in to one supplier.
<br>Disadvantages: no company obliged to support you, quality varies, and it
may need more skill to install and maintain.</li>
<li><strong>Proprietary (closed source)</strong> — the source code is kept by
the owner. You buy the right to use a compiled copy, not the code. Windows,
Microsoft Office, Adobe Photoshop.
<br>Advantages: supported, tested, documented, usually easier to install.
<br>Disadvantages: costs money, cannot be modified, and you depend on the
vendor to fix faults and to keep selling it.</li>
</ul>

<h3>Classification by licence</h3>
<ul>
<li><strong>Freeware</strong> — free to use for as long as you like, but the
source code is not given and you may not sell or modify it. Adobe Reader, many
mobile apps.</li>
<li><strong>Shareware</strong> — try before you buy. Free for a trial period,
or with features locked, after which you are expected to pay. WinRAR is the
example everyone has met.</li>
</ul>
<p>Also worth knowing: <strong>public domain</strong> software has no copyright
at all, and <strong>commercial</strong> software must be paid for before
use.</p>

<h3>The confusion to avoid</h3>
<p>Free-of-charge is not the same as open source. Freeware costs nothing but
hides its code. Open-source software shows its code and may still be sold.
"Free" in "free software" means freedom, not price.</p>

<h3>In the exam</h3>
<p>"Give one advantage and one disadvantage of open-source software for a
school." Advantage: no licence fees, so more machines can be equipped for the
same budget. Disadvantage: no supplier is obliged to help when it breaks. Tie
the answer to the organisation in the question — a general answer scores
less.</p>', 'html', 25),
  ('b65275fa-5cee-58d4-a9ba-88c4287bab56', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 1', 'Categorization of software: application software and examples', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Identify application packages and classify into custom made (bespoke), specialist software, general purpose or generic packages e.g. spreadsheet, database, information retrieval packages</li></ul></div><div class="def-box"><strong>Application software:</strong> programs written
to do a job for the user, as opposed to system software, which runs the
machine.</div>

<h3>The three categories</h3>
<ul>
<li><strong>General purpose, or generic</strong> — one package used for many
different jobs by many different people. Word processor, spreadsheet, database,
presentation package, web browser, graphics editor. Nobody wrote Excel for your
school in particular; it is shaped to fit by the person using it.</li>
<li><strong>Specialist</strong> — written for one kind of work, sold to
everyone doing that work. Accounting packages, payroll, CAD, hospital
management, school management systems, statistical packages. Bought
off-the-shelf, but for a narrow purpose.</li>
<li><strong>Custom made, or bespoke</strong> — written for one organisation, to
its own requirements. The system a specific bank uses for its own products; a
system written for the Cameroon GCE Board.</li>
</ul>

<h3>Bespoke against off-the-shelf</h3>
<table>
<tr><th></th><th>Off-the-shelf</th><th>Bespoke</th></tr>
<tr><td>Cost</td><td>Low, shared among many buyers</td><td>High, one buyer pays for all of it</td></tr>
<tr><td>Availability</td><td>Immediate</td><td>Months or years to develop</td></tr>
<tr><td>Fit to the job</td><td>Approximate; you adapt to it</td><td>Exact; it is built to your requirements</td></tr>
<tr><td>Reliability</td><td>Well tested by thousands of users</td><td>Only your own testing</td></tr>
<tr><td>Support and training</td><td>Books, courses, other users</td><td>Only from the developer</td></tr>
<tr><td>Upgrades</td><td>Regular, from the vendor</td><td>Must be commissioned and paid for</td></tr>
</table>

<h3>Generic packages and what each is for</h3>
<ul>
<li><strong>Word processor</strong> — documents: letters, reports,
mail-merged notices.</li>
<li><strong>Spreadsheet</strong> — calculation on tabular data, "what if"
modelling, charts. A school fees analysis.</li>
<li><strong>Database</strong> — storing, querying and reporting on structured
records. A student register.</li>
<li><strong>Information retrieval package</strong> — searching a large body of
documents and returning matches. A library catalogue, a legal database.</li>
<li><strong>Presentation package</strong> — slides for an audience.</li>
<li><strong>Desktop publishing</strong> — page layout for printing.</li>
</ul>

<h3>In the exam</h3>
<p>When asked to choose, justify with fit against cost. A small school buys
off-the-shelf because bespoke cannot be afforded. A national examinations board
commissions bespoke because no package on the market handles its rules. Say the
reason, not just the choice.</p>', 'html', 26),
  ('904459ab-2035-503b-8753-321d7901486a', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'System software', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>The need for system software and examples (operating system, utility, device drivers, language translators: compiler, interpreter, assembler)</li></ul></div><p>Software divides in two. Application software does a job for you. System
software runs the machine so that application software can.</p>

<div class="def-box"><strong>System software:</strong> programs that manage and
control the computer''s hardware and provide a platform on which application
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
through device drivers. Named functions score.</p>', 'html', 27),
  ('9e4f23f4-54bd-5d8c-9fbc-ba3a0fe50b33', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Operating systems (OS)', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>History and evolution of operating systems</li></ul></div><div class="def-box"><strong>Operating system:</strong> the set of programs
that manage the computer''s resources, control the running of other programs,
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
became the user''s time, and the interface became the thing worth improving.
That sentence answers a lot of "why" questions.</p>

<h3>In the exam</h3>
<p>The OS is the interface between user and hardware, and it manages resources.
Both halves of that definition are needed for full marks. And when asked why
batch processing was introduced, the answer is to remove idle setup time
between jobs — not "to make it faster", which is too vague to mark.</p>', 'html', 28),
  ('b80146db-34be-5c5a-a6a4-a429e41ec736', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Types of OS', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Describe types of OS: batch, online, multi-access, real time transaction processing, network OS, process control</li><li>Distinguish between multitasking, multiprogramming and multiprocessing operating systems</li></ul></div><p>Operating systems are grouped by how they take work in and how many things
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
consequences of delay are different.</p>', 'html', 29),
  ('ecc022f9-82db-5c66-8087-8861aee23124', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Functions of the operating system', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Device management (interrupt, polling, buffering, spooling, handshaking)</li><li>Memory management and file management</li><li>Process management</li><li>Process scheduling strategies: pre-emptive and non-pre-emptive</li><li>Scheduling algorithms: First Come First Served, Shortest Job First, Shortest Remaining Time, Round Robin</li><li>Processor sharing concepts (multitasking and multiprogramming)</li></ul></div><p>Five jobs. Learn them as five headings and the detail hangs off them.</p>

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
teacher''s folder. Allocates disk space and tracks free space.</p>

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
travels and you have the mark.</p>', 'html', 30),
  ('ac683c0a-7349-5160-9626-eb11d4df4bd0', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Operating system user interfaces', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Describe the features: GUI, command driven interface, menu driven, natural language or voice recognition</li><li>Identify the strengths and weaknesses of each</li><li>Choosing the best interface for a user</li></ul></div><div class="def-box"><strong>User interface:</strong> the part of the system
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
it". The justification must mention the <em>user''s</em> circumstances, not the
interface''s general qualities. "GUI because it is easy" scores less than "GUI
because the staff are not trained in computing and will use it occasionally".</p>', 'html', 31),
  ('9135c9c2-5cf9-52c0-a830-1b392613e165', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Server Concepts', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Properties of stand-alone and server OS</li><li>Setting up OS to connect to wired and wireless network</li><li>Setting up OS to avoid unauthorized access into the system</li></ul></div><div class="def-box"><strong>Server:</strong> a computer, or a program, that
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
and monitored.</p>', 'html', 32),
  ('cf71afc2-27bf-5bde-878c-068ecf1031a5', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Utility Software', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Types and role of utility software in system performance</li><li>e.g. disk defragmenter, virus checker, file compression, disk cleaner</li></ul></div><div class="def-box"><strong>Utility software:</strong> system software that
performs a specific maintenance or housekeeping task to keep the computer
running well.</div>
<p>A utility does not do the user''s work and does not run the machine. It looks
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
the computer; a spreadsheet does the user''s work. If a question asks for
"two utility programs and their purpose", name and purpose both, one line
each.</p>', 'html', 33),
  ('c969484b-3662-588a-a20f-186dad3d0d7c', '7df11f03-a526-56c6-abb9-562db2871de7', 'Term 2', 'Graphic software', '<div class="objectives"><p><strong>This lesson covers:</strong></p><ul><li>Uses of bitmap and vector graphics</li><li>Identify the advantages and disadvantages of each type</li></ul></div><p>There are two ways to store a picture, and every graphics question comes
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
about PNG is that it is a lossless format supporting transparency.</p>', 'html', 34)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  body = EXCLUDED.body, body_format = EXCLUDED.body_format,
  chapter_number = EXCLUDED.chapter_number,
  sequence = EXCLUDED.sequence, updated_at = now();

COMMIT;
