# Digital Electronics

#### 3.0. Introduction

Computers are digital systems. Digital systems manipulate information that is represented by binary digits. The circuits in the computer manipulate signals that must have one of two discrete levels high or low, where high is interpreted as 1 and low is interpreted as 0. Digital circuits use transistors (on/off switches) to create logic gates in order to perform Boolean logic which provides a convenient mathematical framework that serves as the foundation of digital electronics and computer processing.

#### 3.1. Boolean Algebra

Boolean algebra also known as the algebra of logic was developed by an English mathematician called George Boole. It is a mathematical system for the manipulation of variables that can have one of two values. In formal logic, these values are "true" and "false". In digital systems, these values are "on" and "off", I and 0, or "high" and "low". Just like with ordinary algebra, the variables in Boolean algebra can be represented using symbols like A, B, C, X, Y and Z, which must have one of only two values 1 or 0. The relationships between these variables are expressed with the logical operators AND, OR, and NOT. The symbols representing these operators, their usage and how they are used verbally are shown in the table below. Operator Symbol Usage Spoken as AND • or ˄ A and B OR + or ˅ A or B NOT ¯, ' or ¬ ̅ not A; or A bar

##### 3.1.1. Truth Tables

A Boolean operator can be completely described using a table that lists the inputs, all possible values for these inputs, and the resulting values of the operation for all possible combinations of these inputs. This table is called a truth table. We define a truth table as a table that shows the relationship between the input values and the results of a specific Boolean operator on the input variables. ̅ 0 1 1 0

![Truth table for](/notes/figures/part1-p014-0.png)

*Truth table for*

0 0 0 0 0 0 0 1 0 0 1 1 1 0 0 1 0 1 1 1 1 1 1 1 Truth table for AND Truth table for OR

##### 3.1.2. Boolean Expressions

When Boolean variables and operators are combined, this results to a Boolean expression. A Boolean expression is an expression that will evaluate to true (1) or false (0). Symbols can be used to represent Boolean variables just like with ordinary algebra, typically a single upper case letter. For example: A, B, C, X, Y, Z etc. Examples of Boolean expressions are: 1) ̅ 2) 3) ̅ ̅ A Boolean expression can also be represented using a truth table. To construct a truth table for a given expression, we evaluate the expression for all possible combinations of values for the input variables. The number of possible combinations is always equal to , where is the number of input variables. Example 1: Construct a truth table for the expression ̅ We have 2 input variables and we will have different combinations. ̅ ̅ ̅ 0 0 1 0 0 0 1 1 1 1 1 0 0 0 1 1 1 0 0 1 Example 2: Construct a truth table for the expression 3 input variables different combinations 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 1 1 0 1 1 0 0 0 0 1 0 1 1 1 1 1 0 0 1 1 1 1 1 1

#### 3.2. Logic Gates

A logic gate is an electronic switch that implements a simple Boolean function. Most logic gates take an input of two binary values and produce a single value of 0 or 1 as output. There are seven different types of logic gates namely AND, OR, NOT, NAND, NOR, XOR and XNOR. Each of these gates has a symbol that represents it.

##### 3.3.1. AND Gate

An AND gate is a logic gate with two inputs and one output that performs logical conjunction. The output of an AND gate is 1 only when all of the inputs are 1. If one or all inputs are 0, then the output of the AND gate is 0.

![](/notes/figures/part1-p015-0.png)

Logic symbol for AND gate

![](/notes/figures/part1-p015-1.png)

0 0 0 0 1 0 1 0 0 1 1 1

##### 3.3.2. OR Gate

An OR gate is a logic gate with two inputs and one output that performs logical disjunction. The output of an OR gate is 1 when one or all of its inputs are 1. If all of an OR gate's inputs are 0, then the output of the OR gate is 0.

![](/notes/figures/part1-p015-2.png)

Logic symbol for OR gate 0 0 0 0 1 1 1 0 1 1 1 1

##### 3.3.3. NOT Gate

The NOT gate is a logic gate that takes a single input and produces an output that is the inverse of the input. This means that when the input is 1, the output is 0 and when the input is 0, the output is 1. The NOT gate is also called an inverter because it produces the inverted version of the input at its output. Logic symbol for NOT ̅

![](/notes/figures/part1-p015-3.png)

##### 3.3.4. NAND Gate

A Negated-AND (NAND) gate is a logic gate with two inputs and one output with behavior that is the opposite of an AND gate. The output of a NAND gate is 1 when one or both of its inputs are 0. If all of a NAND gate's inputs are 1, then the output of the NAND gate is 0. Simply stated, the NAND gate operates like an AND gate followed by a NOT gate.

![](/notes/figures/part1-p015-4.png)

Logic symbol for NAND gate ̅̅̅̅̅̅ 0 0 1 0 1 1 1 0 1 1 1 0

##### 3.3.5. NOR Gate

A Negated-OR (NOR) gate is a logic gate with two inputs and one output with behavior that is the opposite of an OR gate. The output of a NOR gate is 1 if all of its inputs are 0. If one or both of a NOR gate's inputs are 1, then the output of the NOR gate is 0. The NOR gate operates as an OR gate followed by a NOT gate. Logic symbol for NOR gate ̅̅̅̅̅̅̅̅ 0 0 1 0 1 0 1 0 0 1 1 0

##### 3.3.6. XOR Gate

An Exclusive-OR (XOR or EX-OR) gate is a logic gate with two inputs and one output that performs exclusive disjunction. The output of an XOR gate is 1 only when exactly one of its inputs is 1. If all of an XOR gate's inputs are 0, or if all of its inputs are 1, then the output of the XOR gate is 0. Another way of looking at this gate is to observe that the output is 1 if the inputs are different, but 0 if the inputs are different.

![](/notes/figures/part1-p016-0.png)

Logic symbol for XOR gate

![](/notes/figures/part1-p016-1.png)

0 0 0 0 1 1 1 0 1 1 1 0

##### 3.3.7. XNOR Gate

An Exclusive NOR (XNOR or EX-NOR) gate is a logic gate with two inputs and one output that performs logical equality. It operates like an XOR gate followed by a NOT gate. The output of an XNOR gate is 1 when all of its inputs are 1 or when all of its inputs are 0. If one of its inputs is 1 and the other is 0, then the output of the XNOR gate is 0. Another way of looking at this gate is to observe that the output is 1 if the inputs are the same, but 0 if the inputs are different.

![](/notes/figures/part1-p016-2.png)

Logic symbol for XNOR gate ̅̅̅̅̅̅̅̅̅ 0 0 1 0 1 0 1 0 0

![](/notes/figures/part1-p016-3.png)

#### 3.3. Logic Circuits

A simple Boolean operation such as AND or OR, can be represented by a simple logic gate. A more complex Boolean expression can be represented as a combination of gates, resulting in a logic diagram that describes the entire expression. This logic diagram represents the physical implementation of the given expression, or the actual logic circuit. A logic circuit is a combination of logic gates. It produces output based on the rules of logic it is designed to follow for the electrical signals it receives as input. Example 1: What is the output of the following logic circuit?

![](/notes/figures/part1-p016-4.png)

Example 2: The figure below shows a logic circuit with inputs A, B and C, and output Q.

![](/notes/figures/part1-p016-5.png)

- Give a logic expression for the above circuit in terms of A, B, C and Q.

- Construct a truth table for the above circuit.

- Two of the gates in the above circuit could be replaced by a single gate. Identify them and draw the new circuit diagram with the new gate. Example 3: Given the Boolean expression ̅ ̅

- Draw a logic circuit for the Boolean expression Z.

- Complete the corresponding truth table below.
