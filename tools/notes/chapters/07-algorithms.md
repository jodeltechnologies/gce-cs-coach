# Algorithms

#### 7.0. Introduction

A computer is a useful tool for solving a great variety of problems. To make a computer do anything (i.e. solve a problem), you have to write a computer program. In a computer program you tell a computer, step by step, exactly what you want it to do. The computer then executes the program, following each step mechanically, to accomplish the end goal. To write a program to solve a problem, the problem is analyzed and an algorithm is designed. An algorithm is a set of step-by-step instructions for solving a problem in a finite amount of time. Once the algorithm is designed, it is converted into a computer program by a programmer, who uses a specialized language called programming language. Designing algorithms is a problem-solving activity that can be useful regardless of whether a computer is involved. Computer programs would not exist without algorithms. Therefore, a study of algorithms is considered to be a cornerstone of computer science.

#### 7.1. Algorithm Design Process

To develop an algorithm to solve a problem the following steps are followed:

- Define/Understand the Problem: State the problem you are trying to solve in clear and concise terms. It involves answering the question, "What will the algorithm do?"

- Analyze the Problem: Identify the problem inputs (the data needed to solve the problem), outputs (what the algorithm will produce as result), and additional requirements or constraints on the solution.

- Write the Algorithm: Describe the steps needed to convert the inputs to produce the outputs. It involves writing the step-by-step procedure for solving the problem.

- Test the Algorithm: Verify that the algorithm solves the problem as intended. Choose data sets and verify that the algorithm works.

#### 7.2. Properties of a Good Algorithm

A good algorithm must have the following characteristics:

- Correct: It must always return the desired output for all legal instances of the problem.

- Finite: It must terminate after a finite number of steps.

- Unambiguous: Each instruction must be interpreted in one and only one way.

- Efficient: It must run as quickly as possible and use as little memory as possible.

- General: It must solve every instance of the problem.

#### 7.3. Expressing Algorithms

Algorithms can be expressed in many different notations including natural languages, pseudo code, flowcharts and programming languages. Natural language expressions of algorithms tend to be verbose and ambiguous, and are rarely used for complex or technical algorithms. Pseudo code and flowcharts are structured ways to express algorithms that avoid many ambiguities common in natural language statements, while remaining independent of a particular implementation language. Programming languages are primarily intended for expressing algorithms in a form that can be executed by a computer but are not often used to define or document algorithms. Pseudo code: A pseudo code is a description of an algorithm using a combination of English language with some rules of structure that make it appear like a program code. Writing pseudo code is one of the best ways to represent an algorithm as it allows the programmer to concentrate on how the algorithm works while ignoring the details of a programming language. Example 1: An algorithm that reads two numbers, computes and displays their sum. Inputs: 2 numbers, call them A and B Output: Sum of A and B, call it Sum.

![](/notes/figures/part2-p012-0.png)

Get a number, A Or, Get(A) Get another number, B Get(B) Set Sum to A plus B Sum ← A + B Display the sum Print(Sum) END END Example 2: An algorithm that reads two numbers and says which of the two numbers is greater. Inputs: 2 numbers, A and B Output: The message A/B is greater BEGIN Get a number, A Get another number, B IF A > B THEN Print "A is greater" ELSE Print "B is greater" ENDIF END Flowchart: A flowchart is a graphical or symbolic representation of an algorithm. In a flowchart, symbols represent operations and the arrows linking them represent the order of execution of instructions. The following are common symbols used in flowcharting and their meanings. Symbol Meaning Rectangle: Process: Any type of internal operation. E.g.

- Set Sum to A plus B // Sum ← A + B

- Add number to Total //Total ← Total + Number

- Increment Counter by 1 //Counter ← Counter + 1 Parallelogram: Input/Output: Input or output of data. E.g.

- Get a number, A

- Get another number, B

- Print Average Diamond: Decision/Branch: Evaluates a condition or statement and branches depending on whether the evaluation is true or false. E.g.

- If A is less than B then

- While Counter is less than or equal to N Do Elongated circle: Terminal: Indicates start or end of the algorithm. Arrow: Flow line: Indicates the direction of the progression of the program. Circle: Connector: Connects sections of the flowchart, so that the diagram can maintain a smooth, linear flow Example 1: An algorithm that gets the price (P)of an item and the number (N) of items, computes and displays the total price. If the number of items is less than 10, there is a reduction of 100. Otherwise, there is a reduction of 300. Start

![](/notes/figures/part2-p013-0.png)

Get price of item, P Get number of items, N

![](/notes/figures/part2-p013-1.png)

Yes No Is N < 10

![](/notes/figures/part2-p013-2.png)

Total ← P*N – 100 Total ← A*S – 300

![](/notes/figures/part2-p013-3.png)

Print Total Stop Example 2: A flowchart algorithm that gets two numbers from the user (dividend and divisor), tests to make sure that the divisor is not zero, and then computes and displays their quotient.

![Is Divisor = 0?](/notes/figures/part2-p013-4.png)

*Is Divisor = 0?*

#### 7.4. Identifiers, Variables and Constants

When writing an algorithm, we need to keep track of the data values the algorithm will manipulate. Each data value is given a name that will help us remember what it does. For example, Total, Counter, Number, Dividend, Divisor and Average. This name is called an identifier. Identifiers should be clear and indicate what they will be holding. Some data values may change during execution of the Identifier: A label or name algorithm while others remain fixed. Any data value that represents a variable or that can change during execution is called a variable constant. while any data value that cannot change during Variable: An identifier that execution is called a constant. Technically, variables and points to a value that can constants are storage locations that have been given change during execution. names. When a value is given to a variable or constant, Constant: An identifier that the value is kept in the memory location that points to a value that corresponds to that variable or constant. cannot change during In general, variables are written with no spaces and in execution. lowercase. They can be written with an underscore separating words, which is known as snake case or, words can be joined with each word starting with a capital letter, known as camel case. Constants are written in uppercase and mostly using snake case. Example snake case variable/constant Example camel case variable names names player_name PI playerName player_score VAT_RATE playerScore number_of_lives numberOfLives

#### 7.5. Basic Statements

Three basic statements used in an algorithm are input, output and assignment statements.

- Input: An input statement allows data to be typed from the keyboard. Keywords like GET, READ, and INPUT are used. Examples:

- Get a number, A

- Read(A)

- Input a number, call it A

- Input A

- Output: An output statement allows information to be displayed on the screen. Keywords like PRINT, WRITE, and DISPLAY are used. Examples:

- Print "Error!"

- Write("Error!")

- Print(Average)

- Display the average

- Assignment: Allows a value to be assigned to a variable. An assignment statement usually consists of three elements: a value to be assigned, an assignment operator (typically a symbol such as ← or =), and a destination variable. The general form of an assignment statement is given as follows: variableName← Value The value on the right is assigned to the variable on the left. The value can be a variable, a constant or involve variables and constants combined by arithmetic operators, called an expression. In this latter case, the expression is evaluated and the value obtained is assigned to the destination variable. Rounded brackets () may also be used in matched pairs in expressions to indicate the order of evaluation. When a value is assigned to a variable or constant when the variable/constant is first set up, it is called initialization. Examples:

- Total = 0 Total = Total + Number The first statement initializes the variable Total to 0. The second statement adds the value of Number to the value of Total and the result is assigned to Total, thereby, changing the initial value of Total.

- Counter = 1 Counter = Counter + 1 The first statement initializes Counter to 1. The second statement adds 1 to the initial value of Counter and the result is assigned to Counter, thereby, incrementing Counter variable by 1.

- Average ←(a + b)/2 Statement assigns half the sum of a and b to variable Average. Notice that rounded brackets are used to show the order of evaluation.

- PI← 3.14 Statement sets the value of PI to value 3.14. PI here is a constant, meaning that its value is not allowed to change during execution.

- VAT_RATE = 0.17 Constant VAT_RATE is set at 0.17. Exercise 1: Considering that the following statements are executed one after another, complete the table giving the values of x, y and z after each execution.

![←    +](/notes/figures/part2-p014-0.png)

*←    +*

← ← + ← ← + ← + Exercise 2: If x = 3 and y = 5, what will be the final values of x and y after the following statements have executed? A B t← x x ← x + y x← y y ← x – y x ← t x ← x – y

#### 7.6. Control Structures

The order of execution of steps in an algorithm is determined by input data and control structures. A control structure is a statement that determines the order of execution of other statements in an algorithm. There are three basic control structures: sequence, where one statement simply follows another; selection, where control flow depends on which criteria are met; and iteration, where an action is repeated until some condition occurs. Sequence: A sequence control structure is the construct where instructions are executed one after the other in the order they are given. The execution of instructions in an algorithm by default is sequential. Example: The following statements are executed in sequence. BEGIN Get A Get B Average ← (A+B)/2 Print Average END In a flowchart, sequence is expressed as: Statement 1 Statement 2

![](/notes/figures/part2-p015-0.png)

Statement n Selection: A selection control structure is the construct where one or more statements can be executed or skipped depending on whether a condition evaluates to TRUE or FALSE. There are three selection structures: IF...THEN, IF…THEN…ELSE and CASE

- IF...THEN IF condition is true THEN Statement(s) ENDIF Meaning: If condition is TRUE, do something (Statement(s)). If it is FALSE, do nothing. Example: An algorithm that gets two numbers (dividend and divisor), computes and displays the quotient if the divisor is different from zero. BEGIN Get Dividend Get Divisor IF Divisor ≠ 0 THEN

![Print Quotient](/notes/figures/part2-p015-1.png)

*Print Quotient*

ENDIF END In a flowchart, IF…THEN is expressed as:

![Is condition](/notes/figures/part2-p015-2.png)

*Is condition*

- IF…ELSE IF condition is true THEN Statement 1 ELSE Statement 2 ENDIF Meaning: If condition is TRUE, do something (Statement 1). If it is FALSE, do something else (Statement 2). Example: An algorithm that gets the price of an item and the number of items bought, then computes and displays the total price. If the number of items bought is 10 and

![is given.](/notes/figures/part2-p015-3.png)

*is given.*

above, a discount of 200 is given. BEGIN Get the price of item, P Get the number of items bought, N

![](/notes/figures/part2-p015-4.png)

IF N less than 10 THEN Total ← P * N ELSE Total ← P * N – 200 ENDIF Print Total END In a flowchart, IF…ELSE is expressed as: Yes No Is condition true? Statement 1 Statement 2

- CASE CASE is a multi-way selection structure. It allows for any number of choices or cases. The path taken is determined by the selection of the choice that is TRUE. In pseudo code, multi-way selection is expressed as: CASEWHERE expression evaluates to Choice 1 : Statement 1 Choice 2 : Statement 2 • • Choice n : Statement n Otherwise : default statement ENDCASE Example: An algorithm that gets two numbers and an operator, then computes and returns the result of the operation between the two numbers. BEGIN Get Number1 Get Number2 Get Operator CASEWHERE Operator is + : Result ← Number1 + Number2 – : Result ← Number1 – Number2 * : Result ← Number1 * Number2 / : IF Number2 ≠ 0 THEN Result ← Number1/Number2 OTHERWISE : Print "Error!" ENDCASE Print Result END In a flowchart, multi-way selection is expressed as: Condition

![](/notes/figures/part2-p016-0.png)

Choice 1 Choice 2 Otherwise Statement 1 Statement 2 Default statement Repetition: Repetition control structure is the construct where one or more instructions can be executed repeatedly depending on whether a condition evaluates to TRUE or FALSE. An occurrence of repetition is usually known as a loop. An essential feature of repetition is that each loop has a termination condition to stop the repetition, or the obvious outcome is that the loop never completes execution (an infinite loop). The termination condition can be checked or tested at the beginning or end of the loop. When the condition is tested at the beginning of the loop it is known as pre-test repetition. There are two examples of pre-test repetition: the WHILE loop and FOR loop. When the condition is tested at the end of the loop it is known as post-test repetition. An example of post-test repetition is the REPEAT loop.

- WHILE loop In pseudo code, the WHILE loop is expressed as: WHILE condition is true DO Statements here ENDWHILE Meaning: The body of the loop is executed repeatedly while the condition is TRUE. At the end of each execution of the body of the loop, the condition is evaluated to see whether it is TRUE or FALSE. If it is TRUE the body of the loop is executed again. If the condition is FALSE, the body of the loop is not executed and execution of the loop stops. The condition for the loop to stop must change during each execution of the loop, to ensure that the loop eventually stops. The WHILE loop is a condition-controlled loop. It is used when the number of executions of the loop is not known initially. Example; An algorithm that reads a number N entered by the user, and computes the sum of the first N integers. BEGIN Get number, N

![Sum + Counter](/notes/figures/part2-p016-1.png)

*Sum + Counter*

Sum ← 0 WHILE Counter <= N DO ENDWHILE Print Sum END In flowcharting, pre-test repetition is expressed as:

![Is condition](/notes/figures/part2-p017-0.png)

*Is condition*

- FOR Loop In pseudo code, the FOR loop is expressed as: FOR Counter ← Lower_bound TO Upper_bound DO Statements here ENDFOR Meaning: Counter variable is given an initial value called Lower_bound and the body of the loop is executed until the value of Counter is greater than Upper_bound. After each execution of the loop, the value of Counter is incremented automatically by 1 and checked. If the value is less than or equal to Lower_bound, the body of the loop is executed again. If it is greater than Upper_bound, the body of the loop is not executed and execution of the loop stops. Incrementing the value of Counter variable is done automatically after each execution of the loop unlike with the WHILE loop where it is done explicitly within the loop. The FOR loop is a count-controlled loop. It is used when the number of iterations of the loop is known initially. Example: An algorithm that reads an integer N entered by the user, and computes the sum of the first N integers using a FOR loop. BEGIN Get number, N

![Sum + Counter](/notes/figures/part2-p017-1.png)

*Sum + Counter*

FOR Counter ← 1 TO N DO ENDFOR Print Sum

![](/notes/figures/part2-p017-2.png)

- REPEAT Loop In pseudo code, the REPEAT loop is expressed as: REPEAT Statements here UNTIL condition is true Meaning: The body of the loop is executed before testing the termination condition. If the condition evaluates to FALSE, the body of the loop is executed again. If the condition evaluates to TRUE, the body of the loop is not executed and execution of the loop stops. The REPEAT loop is a condition-controlled loop. An important difference between a pre-test and post-test loop is that the statements of a post-test loop are executed at least once even if the condition is originally true, whereas the body of the pre-test loop may never be executed if the termination condition is originally false. Example: An algorithm that reads a positive integer N and prints the first N integers and their sum. BEGIN Get number, N Count ← 1 Sum ← 0 REPEAT Print Count

![Sum + Count](/notes/figures/part2-p017-3.png)

*Sum + Count*

Count ← Count + 1 UNTIL Count > N Print Sum END In a flowchart, post-test repetition is expressed as:

![](/notes/figures/part2-p017-4.png)

Statement

![](/notes/figures/part2-p017-5.png)

Is condition true? No Yes

#### 7.7. Dry Runs and Trace Tables

One of the steps in the algorithm design process is the testing of the final algorithm. To do this we perform a dry run of the algorithm. A dry run is the process of manually working through an algorithm to track the value of variables. Test data are selected and an execution of the algorithm is performed by hand using the test data until the algorithm terminates. When performing a dry run, the state of the variables used by the algorithm is updated after each instruction is carried out. When the algorithm terminates the variables used by the algorithm should contain correct final results if the algorithm is correct. Dry runs are performed using trace tables to keep track of the values of the variables used in an algorithm. A trace table is a table where the column headings record the names of all the variables used in the algorithm and the rows record the state of the variables after every instruction executes. Sometimes, important conditions are recorded too. Example: Use a trace table to test the accuracy of the logic of the algorithm given below. Use the following as test data: 12, 23, 34, 0.

![](/notes/figures/part2-p018-0.png)

### 0. BEGIN

### 1. Sum ← 0

### 2. Read Number

![Number ≠ 0 DO](/notes/figures/part2-p018-1.png)

*Number ≠ 0 DO*

### 3. WHILE Number ≠ 0 DO

### 4. Sum ← Sum + Number

### 5. Read Number

### 6. ENDWHILE

### 8. Print Sum

### 9. END

Trace table: Sum Number Number≠0? L1 0 L2 12 L3 Y L4 12 L5 23 L3 Y L4 35 L5 34 L3 Y L4 69 L5 0 L3 N L8 69 Exercise 1: Use a trace table to determine what is printed by the following algorithm. BEGIN X ← 5 Y ← 10 Z ← 45 WHILEZ< 75 DO Z ← Z + Y Print Y Y ← Y + X ENDWHILE Print Z END Exercise 2: Use a trace table to determine what is printed by the following algorithm. BEGIN Count ← 1 X ← 2 WHILE Count < 25 DO X ← X + 2 Print Count, X Count ← Count + 5 ENDWHILE END Exercise 3: Given the algorithm below, BEGIN Difference ← 0 Input A, B

![](/notes/figures/part2-p018-2.png)

IF A <= B THEN Difference ← B – A ELSE Difference ← A - B ENDIF Print Difference END What is printed by this algorithm if the input values are the following? (i) 20, 30 (ii) 100, 10 (iii) 50, 50 Exercise 4: Use a trace table to determine the output of the following algorithm. BEGIN Input N Sum ← 0 FOR Count ← 1 TO N DO

![](/notes/figures/part2-p019-0.png)

IF N modulo Count = 0 THEN Sum ← Sum + Count Print Count ENDIF ENDFOR Print Sum END Exercise 5: Use a trace table to determine the output of the algorithm below. Use the following data: (i) 6, 9 (ii) 15, 12 (iii) 8, 15 BEGIN Input A, B R ← 0 WHILE B > 0 DO R ← A modulo B A ← B B ← R ENDWHILE Print A END Exercise 6: Use a trace table to test the logic of the pseudo code below. Use the following as test data: 13, 15, 17, 10, and 11. BEGIN Get N Set Total to zero Set Counter to one WHILE Counter is less than or equal to N DO Get a number Add the number to Total Increase Counter by one ENDWHILE Set Average to Total/N Print Average END

![8.0.  Introduction](/notes/figures/part2-p019-1.png)

*8.0.  Introduction*

Computers can do such a wide variety of things because they can be programmed. This means that computers are not designed to do just one job, but to do any job that their programs tell them to do. A program is a set of instructions that a computer follows to perform a task. Microsoft Word is a word processing program that allows you to create, edit, and print documents with your computer. Adobe Photoshop is an image editing program that allows you to work with graphic images, such as photos taken with your digital camera. Computer programming is the act of writing computer programs. A person with the training and skills necessary to write computer programs is called a programmer. Programmers write computer programs by translating algorithms into a language that a computer can understand. A programming language is a formal language that is used for writing computer programs. There exist more than 2500 programming languages in the world. Some examples of the most widely used programming languages are FORTRAN, COBOL, Basic, C, SQL, C++, Perl, Java, Python, Ruby, PHP, JavaScript, Pascal, Logo and Prolog. Programming languages can be grouped into low-level languages and high-level languages.

#### 8.1. Low-Level Languages

A low level language is a computer language that reflects the processor architecture or that is closer to the CPU instruction set. Low-level languages are machine dependent. They consist of machine language and assembly language. Machine Language: Machine language is a low-level language that uses binary codes (or 0's and 1's) to represent the instructions that the computer will execute. Since machine language is made of 0's and 1's, programs written in machine language do not need to be translated for the computer to understand. However, programs written for one type of computer are tied to that particular computer and cannot be executed on another type of computer. This is because each brand of CPU has its own machine language instruction set. Machine language is the first generation of computer languages (1GL). Advantages

- Machine language programs run very fast

- Machine language does not require a translator Disadvantages:-

- Machine language is machine dependent/not portable

- Writing programs in machine language is tedious and error prone Assembly Language: Assembly language is a low-level language that uses abbreviations or mnemonics to represent the instructions that the computer will execute. Like with machine language, each brand of CPU has its own assembly language. As such, assembly language is tied to specific computer hardware and programs written for one type of computer cannot execute on another type of computer. Assembly language cannot be executed by the CPU directly. A special program called assembler is used to translate assembly language programs to a machine language. Each assembly language instruction translates to one and only one machine code instruction. Assembly language is the second generation of computer language (2GL). Advantages

- Assembly language programs run very fast

- They allow close control of the CPU Disadvantages

- Assembly language is machine dependent/not portable

- Writing programs in assembly language is time consuming and error prone

- Programmer needs to know a lot of detail about how the CPU works.

#### 8.2. High Level Languages

A high level language (HLL)is a computer language that uses English-like words to represent the instructions that the computer will execute. In other words, it is a computer language that is closer to human language, making high-level languages more user-friendly than low-level languages. In practice, every computer language above assembly language is a high-level language. Programs written in high-level language are translated to machine language by a compiler or an interpreter. Each high- level language instruction or statement translates to many machine language instructions. High-level language is the third generation of computer languages (3GL). Examples of high- level languages are Ada, BASIC, C, FORTRAN, Java, Pascal and Python. Advantages

- High-level languages are machine independent/portable

- Programs are shorter and faster to write

- Writing and correcting programs in high-level language is easy

- Programmers do not need to know how the CPU works Disadvantages

- High-level language programs are slower than low-level language programs

- High-level languages may not allow for low-level access to hardware

#### 8.3. Language Translators

A computer cannot execute a program written in any language other than its machine language. Programs written in assembly language or high-level language must be translated to the machine language of the computers on which they will run. A language translator is a computer program that translates program instructions from one computer language to another, without loss of original meaning. There are three types of language translators: assembler, compiler and interpreter. Assembler: An assembler is a program that translates an assembly language program into machine language. The process is called assembling. Compiler: It is a program that translates an entire program written in high-level language into an object program in machine language. The original version of the program in high- level language is called source code/program and the generated machine language program is called object code. This process is called compilation. Examples of compiled languages are Ada, C, Pascal, Java and Python. Advantages of a compiler

- It is fast since it translates the entire program before execution

- The object code produced can be used whenever required without need for recompilation Disadvantages of a compiler

- Object code is not produced if there are syntax errors

- If an error is corrected, the whole program needs to be recompiled

- It is a larger program than other translators so it occupies much space in memory Interpreter: It is a program that translates and then executes instructions from a high- level program line by line. An interpreter translates an instruction and allows it to be executed before translating the next instruction. Examples of interpreted languages are JavaScript, LISP, Perl and PHP, Some languages like BASIC are generally interpreted but can also be compiled. Advantages of an interpreter

- It is good at locating errors

- If an error is corrected, there is no need to retranslate the whole program

- It occupies little memory space so can be used in small systems with limited memory space Disadvantages of an interpreter

- It is slow as interpretation and execution are done line by line

- Translation is done every time the program executes since no object code is produced

- The program cannot run without an interpreter

![Each high-level language has its own set of words and rules](/notes/figures/part2-p020-0.png)

*Each high-level language has its own set of words and rules*

that the programmer must use to write a program. These words are known as keywords or reserved words while the rules to be used are called syntax. Each keyword has a specific meaning and cannot be used for any other purpose. Syntax: Syntax refers to the set of rules that define the structure of legal statements in a language. Syntax rules specify how the keywords and symbols of a programming language can be put together to form meaningful statements. Syntax error: a bug or When writing programs, non-respect of the syntax rules error in a program of the language used results in syntax errors. A syntax resulting from the non- error will stop the compiler or interpreter to stop trying respect of the grammatical to generate the machine code and will not create an rules of the language used. executable. However, a compiler will usually not stop at the first error it encounters but will continue checking the syntax of a program until the last line. Examples of syntax errors are: a misspelled keyword, a missing punctuation mark and the incorrect use of an operator. Semantics: Semantics refer to the meaning of a well-formed statement. Semantic rules specify the relationship between the words and symbols of a language and their intended meaning. Ultimately, without semantics a programming Semantic/logic error: a language is just a collection of meaningless phrases. A bug or error in a statement can be syntactically correct but semantically program that results in incorrect. That is, a statement can be written in an incorrect or unexpected acceptable form and still conveys the wrong meaning. output. Compilation and interpretation do not detect semantic errors; they are detected from wrong results.

#### 8.5. Programming Paradigms

High-level languages can be grouped into different paradigms. The word paradigm comes from the Greek word "paradigma" which means model or pattern. A programming paradigm can therefore be defined as a model for a class of programming languages that share common characteristics. In simple terms, it is a style or way of programming. Each paradigm describes the approach each language in that paradigm uses to solve a problem. The most common programming paradigms are imperative, procedural, declarative and object-oriented paradigms. Imperative Paradigm: This is a programming paradigm in which a program is expressed as a sequence of statements or commands that describe how to solve a particular class of problems. A program in imperative language describes in details, the steps that are necessary to find a solution to a problem. Examples of imperative languages are Ada, C, COBOL, FORTRAN, and Pascal. A subtype of imperative paradigm based upon the concept of subprogram calls is called procedural paradigm. A subprogram is a named sequence of statements for performing a specific task, which can be used whenever that task is needed. Subprograms are called by other names including procedures, functions, and subroutines. Today, all imperative languages are procedural making the term imperative programming synonymous to procedural programming. Features of imperative languages are: variable declaration, assignment, and control structures (sequence, selection and iteration) and recursion. Declarative Paradigm: This is a programming paradigm in which a program expresses what needs to be done to solve a problem without describing how. Programming in a declarative language, the programmer concentrates more on what is to be done to solve the problem while the how part is left in the hands of the language's implementation (compiler or interpreter). Some important features of declarative languages are recursion and backtracking. Examples of declarative languages are Haskell, LISP, Scheme, and Prolog. Object Oriented Paradigm: This is a programming paradigm in which a program is a collection of objects which interact with each other by sending messages. An object here is an entity containing both data and operations that manipulate the data. The data or attributes of the object represent the state of the object and the operations or methods represent the behavior of the object. For example, a Person object can have the attributes name, gender, DOB, height, and the methods walk, stop, sit, run, and jump. Some important features of OOP are class, object, abstraction, encapsulation, inheritance and polymorphism. Examples of object-oriented languages are C++, Objective C, Java, Python, Visual Basic and Smalltalk.

#### 8.6. C programming

C is a high-level programming language developed by Dennis Ritchie and Brian Kernighan at Bell Labs in the mid-1970s. Although originally designed as a systems programming language, C has proved to be a powerful and flexible language that can be used for a variety of applications, from business programs to engineering. The first major program written in C was the UNIX operating system, and for many years C was considered to be inextricably linked with UNIX. Now, however, C is an important language independent of UNIX. C is a particularly popular language for personal computer programmers because it is relatively small - it requires less memory than other languages. Basic Structure of C Program: A C program is made up of the following components:

- Processor directives

- Function prototypes

- Declaration of global variables

- Function main()

- Definition of functions Consider a simple C program which prints a line of text to the computer screen. This is traditionally the first C program you will see and is commonly called the "Hello World" program for obvious reasons. #include <stdio.h> void main() { printf("Hello World!\n"); } The line #include <stdio.h> is a preprocessor directive. It instructs the preprocessor to include the file stdio.h into the program before compilation so that the definitions for standard input/output functions including printf will be present for the compiler. All C compilers include a library of standard C functions such as printf which allow the programmer to carry out routine tasks such as I/O, maths operations, etc. but which are not part of the C language, the compiled C code merely being provided with the compiler in a standard form. These files are called header files, indicated by the extension .h. The line int main() { indicates the start of the mandatory main function. It is mandatory because every C program must have a main function. The parentheses, ( ), after the word main indicate a function while the curly braces, { }, are used to denote the beginning and end of a block of code – in this case the sequence of instructions that make up the function. The line printf("Hello World!\n"); is the only C statement in the program and must be terminated by a semicolon; omitting the semicolon results in a syntax error. The statement calls a function called printf which causes its argument, the string of text within the quotation marks, to be printed to the screen. The characters \n are not printed as these characters are interpreted as special characters by the printf function in this case printing out a newline on the screen. These characters are called escape sequences in C and cause special actions to occur and are preceded always

![for Backspace and](/notes/figures/part2-p022-0.png)

*for Backspace and*

by the backslash character, \ . Other escape sequences are \t for Tab space, \r for Return, \v for Backspace and \a for Bell. C is case sensitive. This means that printf and Printf would be interpreted as two different functions. So writing printf as Printf will result in a syntax error as keywords in C are written in lowercase. Consider another C program which reads the radius of a circle, computes and outputs the area. #include <stdio.h> #define PI 3.14 int main() { int radius; float area; printf("Enter radius of circle: "); scanf("%d", &radius); area = PI*radius*radius; printf("Area of circle = %f\n", area); return 0; } The line #define PI 3.14 is a pre-processor directive that defines PI as a constant. The value of PI is set as 3.14 and cannot be modified in the program. Trying to modify the value of PI in the program will result in a syntax area. A constant can also be declared in C using the keyword const. const float PI = 3.14; The line int radius; declares a variable named radius that will hold the radius of the circle. The word int indicates that the variable radius is of type integer. This means that radius will hold only integer values. The line float area; declares a variable named area that will hold the computed area of the circle. The word float indicates that the variable area is of type float (real). The general form for declaring a variable in C is: <data_type> name_of_variable; Variables that have the same type can be declared on the same line, but separated by commas and terminated by a semicolon. Example, int counter, number, sum; A variable can be assigned a value or initialised when the variable is declared. int count = 1, number, sum = 0; In C,

- A variable name can have letters (both uppercase and lowercase), digits and underscore only.

- The first character of a variable name should be either a letter or an underscore. However, it is discouraged to start variable names with an underscore as these variables can conflict with system names and may cause errors.

- If a variable name consists of two or more words joined together, they must not be spaces between the words. The line printf("Enter radius of circle: "); is an output statement. It displays the text within quotation marks on the screen, prompting the user to enter the radius of a circle. Text within double quotes is called string constant. Enter radius of circle: The line scanf("%d", &radius); is an input statement. It reads the radius entered by the user and stores it in the variable radius. The function scanf reads what is entered from the keyboard and stores it in the memory address of the variable radius. The characters %d, known as format specifier, specify that the value to be read should be formatted as integer. The format specifier %d is used because radius was declared as an integer. When a variable is declared as a float, the format specifier is %f. When declared as a character, the format specifier is %c and %s for string. The use of & in front of radius indicates the memory address of the variable radius. It tells the scanf function where in memory to go store the value read. The line area = PI*radius*radius; is an assignment statement. It computes the area of the circle using the expression PI*radius*radius, and assigns the result to the variable area. The assignment operator here is the equal sign. The line printf("Area of circle = %f\n", area); displays the string constant given within the quotation marks, followed by the computed area. The format specifier %f does not only specify the type of the output value, but also specifies where the output value will be displayed. In this case, the computed area will be displayed at the end of the string constant, after the equal sign. For example, if the radius entered by the user is 3, the computed area will be 28.26 and what will be displayed on the screen is:

![function, the memory address of the](/notes/figures/part2-p023-0.png)

*function, the memory address of the*

variable area will be printed instead of the value stored inside the variable area. printf("Area of circle = %f\n", &area); The line return 0;

![function. Notice that we used the keyword](/notes/figures/part2-p023-1.png)

*function. Notice that we used the keyword*

returns the value 0 at the end of the main() function. Notice that we used the keyword int at the beginning of the main() function. int main() The word int is used to indicate the type of the value that the main() function will return. When the main() function returns a value, it returns it to the operating system. Zero is commonly returned to indicate successful normal termination of a program to the operating system and other values could be used to indicate abnormal termination of the program. The keyword void can be used in place of int to indicate that the function will not return

![](/notes/figures/part2-p023-2.png)

any value. In this case, there is no need for the line return 0. Operators in C: An operator is something which takes one or more values and does something useful with those values to produce a result. C has different types of operators including the assignment operator, arithmetic operators, relational operators, logical operators and increment operators. Arithmetic Operators: Arithmetic operators are used to perform arithmetic operations. Operator Description + Addition – Subtraction * Multiplication / Division (integer division) % Modulo arithmetic Relational Operators: They are used for comparisons. Expressions that use these operators produce a true or false value when they are evaluated. Operator Description == Equal to != Not equal to < Less than > Greater than <= Less than or equal to >= Greater than or equal to Logical Operators: They are used to combine logical values. Operator Description && Logical AND || Logical OR ! Logical NOT Increment/Decrement Operators: They are used to increment or decrement by 1 the variable they act on. Operator Description ++ Increment – – Decrement Decision Statements: Decision statements are used for conditional execution in C. They are the IF statement, IF..ELSE statement and SWITCH statement.

- The IF Statement Syntax

![Do something here](/notes/figures/part2-p024-0.png)

*Do something here*

if(condition) { } Example 1: A program that reads two numbers and determines which is greater. #include <stdio.h> int main() { int number1, number2; printf("Enter first number: "); scanf("%d\n", &number1); printf("Enter second number: "); scanf("%d\n", &number2); if(number1 > number2) { printf("%d is greater than %d", number1, number2); } if(number1 < number2) { printf("%d is greater than %d", number2, number1); } if(number1 == number2) { printf("%d is equal to %d", number1, number2); } return 0; } Example 2: A program that reads a number and determines whether the number is positive or negative. #include <stdio.h> int main() { int number; printf("Enter number: "); scanf("%d\n", &number); if(number > 0) { printf("%d is Positive", number); } if(number < 0) { printf("%d is Negative"); } return 0; }

- The IF..ELSE Statement Syntax

![Do something here](/notes/figures/part2-p024-1.png)

*Do something here*

if(condition) { }

![Do something else here](/notes/figures/part2-p024-2.png)

*Do something else here*

} Example 1: Program to perform integer division avoiding division by 0. #include <stdio.h> int main() { int dividend, divisor, quotient; printf("Enter two numbers: "); scanf("%d %d", ÷nd, &divisor); if(divisor != 0){ quotient = dividend/divisor printf("%d/%d=%d",dividend, divisor, quotient); } else { printf("Invalid operation – cannot divide by 0!"); } return 0; } Example 2: A program that gets the price of an item and the number of items bought, then computes and displays the total price. If the number of items bought is 10 and above, the total price is calculated with a discount of 200. #include <stdio.h> int main() { int price, numberOfItems, totalPrice; printf("Enter number of items: "); scanf("%d", &numberOfItems); printf("Enter price of item: "); scanf("%d", &price); if(numberOfitems< 10){ totalPrice = price * numberOfItems; } else{ totalPrice = price * numberOfItems – 200; } printf("Total price = %dFrs", totalPrice); return 0; } Iteration Statements: Iteration statements are used for repetition. They include the

![statement and](/notes/figures/part2-p025-0.png)

*statement and*

- The WHILE Statement Syntax while(condition) {

![Statements here](/notes/figures/part2-p025-1.png)

*Statements here*

} Example 1: A program that reads a number N, computes and displays the sum of the first numbers. #include <stdio.h> int main() { int count=1, number, sum=0; printf("Enter a positive number: "); scanf("%d", &number); while(count <= number) { sum = sum + count; count = count + 1; } printf("Sum = %d", sum); return 0; } Example 2: A program that reads a number N, then gets N numbers entered by the user, computes and displays their sum. #include <stdio.h> int main() { int count=1, aNumber, number, sum=0; printf("Enter a positive number: "); scanf("%d", &aNumber); printf("Enter %d numbers: ", aNumber); while(count <= aNumber) { scanf("%d", &number); sum = sum + number; count = count + 1; } printf("Sum = %d\n", sum); return 0; }

- The FOR Statement Syntax

![(initilisation; condition; increment/decrement) {](/notes/figures/part2-p025-2.png)

*(initilisation; condition; increment/decrement) {*

for(initilisation; condition; increment/decrement) { } Example 1: A program to multiply two numbers by successive additions. #include <stdio.h> int main(){ intnumber1, number2, count, product=0; printf("Enter first number: "); scanf("%d", &number1); printf("Enter second number: "); scanf("%d", &number2); for(count=1; count<=number2; count++){ product =product + number1; } printf("%d",product); return 0; } Example 2: A program that reads a positive integer N and returns the factors of N. #include <stdio.h> int main() { int count, number; printf("Enter a positive number: "); scanf("%d", &number); for(count=1; counter<=number; counter++) { if(number % counter == 0) printf("%d\n", counter); } return 0; }

- The DO…WHILE Statement Syntax do{ Statements here! }while(condition); Example 1: A program to print the sum of the digits in a number. #include<stdio.h> int main() { int number, digit,sum=0; printf("Enter a number:"); scanf("%d", &number); do{ digit =number%10; sum=sum + digit; number =number/10; }while(number>0); printf("Sum of the digits = %d", sum); return 0; } Example 2: A program to display the multiplication table (up to 12) of any number entered by the user. If the user enters a number less than or equal to 0, the programs prompts them to enter a valid number until they do so. #include<stdio.h> int main() { int number, count=1; do{ printf("Enter any number: "); scanf("%d", number); if(number < 0){ printf("Number must be greater than 0!"); } }while(number<=0); while(count<=12){

![printf("%d * %d = %d\n", count, number, count*number);](/notes/figures/part2-p026-0.png)

*printf("%d * %d = %d\n", count, number, count*number);*

} return 0; } NOTES
