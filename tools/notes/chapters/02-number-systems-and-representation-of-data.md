# Number Systems And Representation Of Data

#### 2.0. Introduction

On hearing the word "number", we immediately think of the familiar decimal number system with 10 digits, 0 to 9, which we use for counting. But modern computers communicate and operate with binary numbers which use only 2 digits 0 and 1. This is because the circuits used in these computers use two-state devices that have to exist in one of two possible states ON or OFF, which are represented as 1 for ON and 0 for OFF. For computers to manipulate real-world data, we need a way to represent the data in binary. All types of data be it numeric, alphabetic, graphic, audio and video, are represented in the computer in binary form, with 0s and 1s. The process of representing human understandable data in binary- coded form is known as encoding. Other number systems like octal and hexadecimal are used in computer science and there are specific areas where a certain number system is easier to use and offers advantages over another. Thus, the study of number systemsis important from the viewpoint of understanding how data are represented before they can be processed by any digital system including a digital computer.

#### 2.1. Number Systems

A number system is the basis for counting various items; it is a set of digits and rules used to represent various numbers. The number of different digits used in a given number system is known as the base or radix of the system. The digits always begin with 0 and continue through one less than the base of that system. This means that for a number system with base b, the digits used will be 0 to b-1.

##### 2.1.1. Decimal System

The decimal system consists of 10 digits 0, 1, 2, 3, 4, 5, 6, 7, 8, and 9. Hence, the base or radix of this system is 10. It is the most familiar number system used in day-to-day life. In this system, any number (integer or fraction) of any magnitude can be represented by the use of these 10 digits only. Every digit in a number has a place value that determines the weight of the digit in the number. Place value is the value of the location or position of a digit in a number. Place values in base 10 are powers of ten; 100, 101, 102, 103, and so on. The weight of any digit in a decimal number is obtained by multiplying the digit with its place value. In the number 29810, o the digit 8 has a place value of 100, thus having a weight of 8 or 8 ones (8 x 100) o the digit 9 has a place value of 101, and a weight of 90 or 9 tens (9 x 101) o the digit 2 has a place value of 102 and a weight of 200 or 2 hundreds (2 x 100).

![Digit‟s weight](/notes/figures/part1-p009-0.png)

*Digit‟s weight*

Notice that place values here are powers of 10 (the base) starting from 0 and attributed from left to right. Each decimal place value is 10 times greater than the one to its immediate right. That is, 102 is 10 times greater than 101 which is 10 times greater than 100.

##### 2.1.2. Binary system

The base of this number system is 2. Hence, it has 2 digits 0 and 1 called binary digits (bits), which are used to represent any quantity. A binary number is a sequence of bits, each of which can be 0 or 1. Place values in binary are powers of 2: 1, 2, 4, 8, … with each place value being 2 times greater than the one to its immediate right. For the 4 bit number 11012, the place value and weight of each digit are:

![Digit‟s weight](/notes/figures/part1-p009-1.png)

*Digit‟s weight*

##### 2.1.3. OctalSystem

The octal number system is a base 8 system. It uses the digits 0 to 7 to represent any quantity. Place values in octal are powers of 8: 1, 8, 64, 512, and so on. Since it is base 8 and 8 = 23, every 3-bit group of binary can be represented by one octal number. This means an octal number is 1/3 the length of the corresponding binary number.

![Digit‟s weight](/notes/figures/part1-p009-2.png)

*Digit‟s weight*

##### 2.1.4. Hexadecimal System

The hexadecimal system has a base of 16. It uses the digits 0 to 9 and the letters A to F. Since it is base 16 and 16 = 24, every group of four bits can be represented by one hexadecimal digit. This means that a hexadecimal number is 1/4 the length of the corresponding binary number, making the hexadecimal system particularly useful for representing large numbers as fewer digits are required. For the hexadecimal number 23D16,the place value and weight of each digit are shown below. Digit Place value (256) (16) (1)

![fifty-sixes](/notes/figures/part1-p010-0.png)

*fifty-sixes*

Two hundred and Digit's weight 512 48 D (13) Summary table: Number system Base Digits Binary 2 0, 1 Octal 8 0, 1, 2, 3, 4, 5, 6, 7 Decimal 10 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, Hexadecimal 16 A, B, C, D, E, F

#### 2.2. Conversion between Bases

##### 2.2.1. Decimalto Binary

To convert from base-10 to base-2,

- Divide the decimal number by two repeatedly, writing down the remainder at each division, until the quotient is less than 2.

- Obtain the answer by writing up the remainders of the division in reverse order. Example 1: Convert 2510 to base 2 2 25 Rem. 2 12 R 1 2 6 R 0 2 3 R 0 2 1 R 1 0 R 1 Answer: 2510 = 110012 Example 2: Convert 12410 to base 2. 2 124 Rem. 2 62 0 2 31 0 2 16 1 2 8 0 2 4 0 2 2 0 2 1 0 0 1 Answer: 12410 = 100001002

##### 2.2.2. Binary to Decimal

To convert from binary to decimal, proceed as follows:

- Multiply each binary digit by its place value

- Add all the weights obtained. The value obtained is the base 10 equivalent of the binary number Example 1: Convert 1110 to base 10. 10110 = (1 x 23) + (1 x 22) + (1 x 21) + (0 x 20) = (1 x 8) + (1 x 4) + (1 x 2) + (0 x 1) = 8 + 4 + 2 + 0 = 14 Answer: 11102 = 1410 Example 2: Convert 110012 to base 10. 11001 = (1 x 24) + (1 x 23) + (0 x 22) + (0 x 21) + (1 x 20) = (1 x 16) + (1 x 8) + (0 x 4) + (0 x 2) + (1 x 1) = 16 + 8 + 0 + 0 + 1 = 25 Answer: 11001 = 25 2 10

##### 2.2.3. Binary to Octal

If base R1 is the integer power of another base, R2 (i.e. R1 = R d), then every group of d digits in R is equivalent to 1 digit in base R. 2 2 1 Since 8 = 23, 3 binary digits are equivalent to 1 digit in base 8. To convert from binary to octal, proceed as follows

- Make groups of 3 bits starting from the least significant bit and move towards the most significant bit.

- Replace each group of bits by its octal representation. Use the table below. Binary Octal Binary Octal 000 0 100 4 001 1 101 5 010 2 110 6 011 3 111 7 Example 1: Convert to base 8

![](/notes/figures/part1-p011-0.png)

Answer: Example 2: Convert to base 8

![](/notes/figures/part1-p011-1.png)

Answer:

##### 2.2.4. Octal to Binary

To convert from octal to binary, we replace every octal digit by its 3-bits binary equivalent. Example 1: Convert to binary

![](/notes/figures/part1-p011-2.png)

Answer: Example 2: Convert to binary

![](/notes/figures/part1-p011-3.png)

Answer:

##### 2.2.5. Binary to Hexadecimal

Since 16 = 24, 4 binary digits are equivalent to 1 digit in base 16. To convert from binary to hexadecimal

- Make groups of 4 bits starting from the least significant bit and move towards the most significant bit.

- Replace each group of bits by its hexadecimal value representation. Use the table below Hex Binary Hex Binary 0 0000 8 1001 1 0001 9 1001 2 0010 A 1010 3 0011 B 1011 4 0100 C 1100 5 0101 D 1101 6 0110 E 1110 7 0111 F 1111 Example 1: Convert to base 16

![](/notes/figures/part1-p011-4.png)

Answer: Example 2: Convert to base 16

![](/notes/figures/part1-p011-5.png)

Answer:

##### 2.2.6. Hexadecimal to Binary

To convert from hexadecimal to binary, we carry out the inverse operation. That is, we replace every hexadecimal digit by its 4-bits binary equivalent. Example 1: Convert to binary

![](/notes/figures/part1-p011-6.png)

Answer: Example 2: Convert to base 2

![](/notes/figures/part1-p012-0.png)

Answer: Assignment: i) Convert to hexadecimal: 7658 and 5438 ii) Convert to octal: 12B16 and F2E16

![Binary Arithmetic](/notes/figures/part1-p012-1.png)

*Binary Arithmetic*

##### 2.3.1. Addition

Rules for addition are: 0+0=0; 0+1=1; 1+0=1; 1+1=10 (write 0 and carry 1); 1+1+1 = 10+1 = 11 (write 1 and carry 1) Example 1: Add 1001 and 110 . 2 2 1 0 0 1 + 1 1 0 1 1 1 1 Answer: 10012 + 1102 = 11112 Example 2: Add 11012 and 1012 (1) (1) 1 1 0 1 + 1 0 1 1 0 0 1 0 Answer: 1101 + 101 = 10010 2 2 2 Example 3: Add 11112 and 10102 (1) (1) (1) 1 1 1 1 + 1 0 1 0 1 1 0 0 1 Answer: 11112 + 10102 = 110012

##### 2.3.2. Subtraction

Rules for subtraction are: 0-0 = 0; 1-0 = 1; 0-1 = requires a borrow; 1-1 = 0 Example 1: Subtract 1002 from 11012. 1 1 0 1

- 1 0 0 1 0 0 1 Answer: 11012 - 1002 = 10012 Example 2: Subtract 1012 from 10102 (2) 1 0 1 1

- 1 0 1 0 1 1 0 Answer: 10102 - 1012 = 1102 Example 3: Subtract 1101 from 10010 2 2 (1) (2)

![](/notes/figures/part1-p012-2.png)

1 0 0 1 0

- 1 1 0 1 0 0 1 0 1 Answer: 10011 - 1101 = 101 2 2 2

#### 2.4. Character Sets

Character encoding is the process of representing individual characters in the computer using a corresponding character set or charset. A character set is a defined list of characters recognized by computer hardware and software. Different charsets exist and each charset maps (pairs) each character in the set to a unique binary number. This means that each character in a charset has a unique number that is assigned to it and which is used to represent the character in the computer. The characters within a charset can be letters, digits or even symbols. The most commonly used character sets are BCD, ASCII, EBCDIC and Unicode.

##### 2.4.1. BCD

BCD stands for Binary Coded Decimal. As the name implies, BCD is a binary representation of decimal numbers where each decimal digit is represented by 4 bits (a nibble). In BCD, only the digits 0 through 9 are valid. When we exceed the value of 9 each digit in the decimal number is now represented by its 4 bit BCD value. Number BCD Code Number BCD Code Number BCD Code 0 0000 5 0101 10 0001 0000 1 0001 6 0110 11 0001 0001 2 0010 7 0111 12 0001 0010 3 0011 8 1000 13 0001 0011 4 0100 9 1001 14 0001 0100

##### 2.4.2. ASCII

ASCII stands for American Standard Code for Information Interchange. It is a standard 7-bit code for representing characters including letters, numbers, punctuation marks, control characters and other symbols, in the computer. Using 7 bits means that each character in the set is coded on 7 bits. It also means that the character set has 128 (27) different characters. Every character in the set is assigned a unique code between 0 and 127 inclusive. Every single letter, number or symbol on a computer keyboard has a unique and distinct ASCII code assigned to it. Examples: 0 = 48, 1 = 49, 2 =50, A = 65, B = 66, C = 67, a = 97, b = 98, c = 99, , = 44, - = 45, . = 46

![](/notes/figures/part1-p013-0.png)

##### 2.4.3. EBCDIC

EBCDIC stands for Extended Binary Coded Decimal Interchange Code. It is an 8 bit character scheme used by mainframe computers. Using 8 bits implies that 28 = 256 different characters can be represented. Just like the ASCII charset, the EBCDIC charset contains both printable and non-printable characters. EBCDIC differs in that some numbers have not been assigned any character.

##### 2.4.4. Unicode

Unicode is a 16-bit universal international coding standard for representing text-based data in any ancient or modern language, including those with different alphabets such as Chinese, Greek, Hebrew and Russian. By using 2 bytes to represent each character, Unicode can represent up to 65,536 characters which enables almost all the written languages of the world to be represented using a single character set. Unicode is backward compatible with the 7-bit ASCII, meaning that the first 128 characters of Unicode are the same as ASCII.

#### 2.5. Seven-Segment Display

Seven-segment displays are very common and are found almost everywhere, from pocket calculators, digital clocks and electronic test equipment to petrol pumps. Each seven segment display uses seven LEDs (light emitting diodes) arranged in a special pattern that makes it possible to show any number from 0 to 9. They are arranged and labeled as shown in the diagram below, in the form of an '8' in hexadecimal form.

![](/notes/figures/part1-p013-1.png)

7-Segment display When all the segments are powered on, the display shows the number 8. Powering up segments a, b, c, d, and g will display the number 3. The numeric 7-segment display can also show a limited number of other characters, limited only by your own fantasy, but usually 'A to F'. But 'H', 'L', 'I', 'O', and a couple others are also possible. The table below gives the binary code for displaying different numeric and alphabetic characters. 1 means ON and 0 means OFF. a b c d e f g 0 1 1 1 1 1 1 0 1 0 1 1 0 0 0 0 2 1 1 0 1 1 0 1 3 1 1 1 1 0 0 1 4 0 1 1 0 0 0 1 5 1 0 1 1 0 1 1 6 1 0 1 1 1 1 1 7 1 1 1 0 0 0 0 8 1 1 1 1 1 1 1 9 1 1 1 1 0 1 1 A 1 1 1 0 1 1 1 B 0 0 1 1 1 1 1 C 1 0 0 1 1 1 0 D 0 1 1 1 1 0 1 E 1 0 0 1 1 1 1 F 1 0 0 0 1 1 1
