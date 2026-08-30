# Database Organisation

#### 5.0. Introduction

A database is a collection of information stored in an organized form. Databases of all kinds pervade almost every business. A telephone directory, a library catalogue and a class register are examples of paper-based database systems. However, when we talk of databases, we are referring to computerized databases – a collection of information stored in an organized form in a computer. Today, much of the world's computing power is dedicated to maintaining and using databases because of the ability for computers to store large amounts of data and to quickly and efficiently process the data. Computerized databases are created and managed using database software called database management systems (DBMS).A DBMS creates, processes and administers the database it controls, and serves as an intermediary between database applications and the database. Database applications provide the users of the database with different interface forms they can use to enter, read, delete and query data in the database. These activities are managed and controlled by the DBMS in order to ensure security and integrity of the database. Examples of DBMS are Microsoft Access, MySQL, Oracle, SQL Server and DB2.

#### 5.1. Database Structure

Databases are very useful because they store data in a structured (organized) way. When data is structured it can be manipulated easily and then outputted in different ways. A database keeps data in one or more tables. A table is made up of records (rows) and fields (columns). Each field has a field name (column heading) and a data type. Tables: A table is a collection of records. Database tables are stored as files. Below is an example of a database table that holds medical patients data.

![Doctor](/notes/figures/part2-p001-0.png)

*Doctor*

Patient Doctor Name D.O.B Gender Phone Doctor Room Id Id 134 Lisa 04/07/1993 Male 678764530 01 Dr. Ako 03 178 David 08/02/1987 Male 698635467 01 Dr. Ako 03 198 Jeff 18/12/1979 Female 674987351 02 Dr. Oben 06 258 Rachel 08/02/1987 Female 698367242 02 Dr. Oben 06 Records: A record is all of the data or information about one person or single object in a database. A single row in a database table is a record. In the Patient database table above, we have four records. The records contain the following information: Record1 Record2 Record3 Patient Id: 134 Patient Id: 178 Patient Id: 198 Name: Lisa Name: David Name: Jeff D.O.B: 04/07/1993 D.O.B: 08/02/1987 D.O.B: 18/12/1979 Gender: Female Gender: Male Gender: Male Phone: 678764530 Phone: 698635467 Phone: 674987351 Doctor Id: 01 Doctor Id: 01 Doctor Id: 02 Doctor: Dr. Ako Doctor: Dr. Ako Doctor: Dr. Oben Room: 03 Room: 03 Room: 06 Record4 Patient Id: 258 Name: Rachel Each record has the same data structure (Id, D.O.B: 08/02/1987 Name, Gender etc). The only things that change Gender: Female are the individual pieces of information (Actual Phone: 698367242 Names, Actual Genders etc). Doctor Id: 02 Doctor: Dr. Oben Room: 06 Fields: A field is the basic unit of data entry in a record. In other words, fields store the single items of data that make up a record. So, a record is a group of related fields. Fields are given field names so we know what kind of data they hold. Field names are found at the top of each column. This means that each column in a table refers to a different field. For example, D.O.B is the field name used to describe the Date of Birth field. Doctor is the field name used to describe the name of doctor field. Each of our records consists of 8 fields: Patient Id, Name, D.O.B, Gender, Phone, Doctor Id, Doctor and Room. Data: Data are the individual pieces of information that get stored in a field. The table below lists all the fields in our Patient database and the data stored for record 2. Patient Id 178 Name David D.O.B 08/02/1987

![stored](/notes/figures/part2-p001-1.png)

*stored*

Field Gender Male names Phone 698635467 stored DoctorId 01 Doctor Dr. Ako Room 03 Notice that each data value is a group of characters that conveys some meaning like178, David, 08/02/1987, and Male. Since each data item is stored in a single field, a field can also be defined as a group of characters that conveys some meaning. Hence, a group of characters is a field, a group of related fields is a record, a group of related records is a table (or file), and a collection of related tables is a database. This arrangement of data elements from smallest to largest is known as the data hierarchy. bit  byte (character)  field  record  file (table)  database Key fields: Key fields are individual pieces of data that are unique (only appear once) for each record. Because key fields are unique, they can be used to differentiate one record from another. For example, in our Patients database the key field is the Patient Id. Every patient has a different Id Number. This is vital so we can identify each patient uniquely and correctly. Imagine if the doctor mixed two patients up and gave them the wrong medicine!!

![Doctor](/notes/figures/part2-p002-0.png)

*Doctor*

Patient Doctor Name D.O.B Gender Phone Doctor Room Id Id 134 Lisa 04/07/1993 Female 678764530 01 Dr.Ako 03 178 David 08/02/1987 Male 698635467 01 Dr.Ako 03 198 Jeff 18/12/1979 Male 674987351 02 Dr.Oben 06 258 Rachel 08/02/1987 Female 698367242 02 Dr.Oben 06 Why is Patient Id suitable for the key field? The key field must contain data that must never repeat. Patient Id is therefore used as the key field because it is not possible for two or more patients to have the same Id number.

- Name: Two patients can have the same name.

- Gender: Two patients can be of the same gender.

- D.O.B: Two patients can have the same date of birth (like David and Rachel in our database)

- Phone: Although the phone numbers are all unique, phone numbers can be changed or even swapped. This makes them unsuitable for key fields.

- Doctor Id: The doctor Id cannot be used to uniquely identify a patient..... just each doctor.

- Doctor: Doctor's name cannot be used to identify each patient as two or more patients can be assigned the same doctor (like in our table).

- Room: Multiple patients are sent to the same room. This is not a good key field.

#### 5.2. Types of Databases

There are two main types of databases: flat-file database and relational database. Flat-File Database: A flat-file database holds all its data in a single table. In other words, a flat-file database is a single table database. Flat-file databases are suitable only for simple databases. The Patient database above is an example of a flat-file database as all the information is stored in one table.

- Limitations of a Flat-File Database: The problems with using a flat-file database are:

- Data is duplicated and hence stored many times. This wastes disk space and slows down query time.

- Maintenance is difficult as every occurrence of a piece of data needs to be updated if its value changes

- More manual data entry is required and therefore a greater likelihood of errors when data is being entered.

- Data Redundancy: Data redundancy is the unnecessary duplication of data. It occurs when you store the same data many times (duplicate data) in your table. This repeated data needs to be typed in over and over again which takes a long time. Data that is duplicated unnecessarily within a database is bad practice. If we had 100 patients who were all assigned to Dr. Ako, his Doctor Id, Name and Room number would have to be entered 100 separate times. This could lead to data inconsistency. Data inconsistency exists when different versions of the same data appear in different places. For example, data inconsistency exists if for some patient doctor name is stored as Dr. Oben and for another patient, the same doctor's name is stored as Dr. Obenson. Also, if Dr. Ako leaves the doctors surgery, we would have to update the new doctor's details for every patient in the database. The way to avoid the data redundancy problems that come with flat-file databases is to create a relational database. Relational Database: A relational database does not store all its data in the same table. It uses two or more tables linked together to form a relationship. Repeated data is moved into its own table as shown below. Patients Table Patient Name D.o.B Gender Phone Doctor Id Id 134 Lisa 04/07/1993 Female 678764530 01 178 David 08/02/1987 Male 698635467 01 198 Jeff 18/12/1979 Male 674987351 02

![](/notes/figures/part2-p002-1.png)

258 Rachel 08/02/1987 Female 698367242 02 Doctors Table Doctor Id Doctor Room 01 Dr. Ako 03 02 Dr. Oben 06 All the repeating data has been moved into a table of its own. Now we have a Patients table (for patient details) and a Doctors table (for doctor details). A relationship is formed when our two tables are joined together. Relationships make use of key fields (primary keys and foreign keys) to allow two tables to communicate with each other and share their data. A primary key is a field that uniquely identifies each record in a table. For the Patients table, the primary key is Patient Id and for the Doctors table, the primary key is Doctor Id. Primary keys are usually indicated by underlining and/or an asterisk. In order to link the tables, we need to use a common field. A common field is data that appears in both tables. Looking at the tables we see that the common field is Doctor Id. Patients Table

![Doctor](/notes/figures/part2-p003-0.png)

*Doctor*

Patient Doctor Name D.O.B Gender Phone Id Id 134 Lisa 04/07/1993 Female 678764530 01 178 David 08/02/1987 Male 698635467 01 198 Jeff 18/12/1979 Male 674987351 02 258 Rachel 08/02/1987 Female 698367242 02

![Doctors Table](/notes/figures/part2-p003-1.png)

*Doctors Table*

At this stage you may have noticed the following:

- Doctor Id (the common field) is set as primary key in the Doctors table.

- Doctor Id is not set as primary key in the Patients table. A common field that is a primary key field in one table but is an ordinary field in another table in order to link the two tables is called a foreign key. Simply put, a foreign key is a field that creates a join between two tables. So Doctor Id has been used as a foreign key in the Patient table. This means that to relate two tables, the common field must be a primary key in one of the tables.

- Benefits of Relational Databases: The advantages of using a relational database instead of a flat-file database are as follows:

- Duplicated data is reduced.

- Data inconsistency is reduced

- Database space is not wasted (due to unnecessary duplicated data).

- Quicker to enter data as there are less duplicates.

- Quicker to update data

#### 5.3. Data Types

Data items stored in a database are of different types. The type of each data specifies the possible range of values for that data item, the operations that can be performed on those values, and the way in which the values will be stored in memory. A data type is a set of values and a collection of operations defined on them. The main types of data found in a computer system are Boolean, text/alphanumeric, numeric, and date/time. Boolean: Data of type Boolean can only have one of two values – true or false. Booleans are used when there are only two possible responses to a question. Examples of responses that can be stored as Boolean are:  True / False  On / Off  Yes / No  1 / 0 Text/Alphanumeric: Text or alphanumeric data type is used for data that is made up of letters and/or digits, and sometimes including control characters, space character and symbols (special characters) such as @, #, $, /, –, and _. Examples of text data are:  Peter  madeup@gmail.com  Peter has a dog  5 Nambeke Str. Limbe  ABBY237  Numeric: Numeric data type is used to store numbers. Numeric data can be in two forms: integers and real numbers.

- Integers: Integers are made of whole numbers (numbers without decimals) and can be both positive and negative values. Examples of integers are:  0  123  5  –123

- Real: Real numbers are numbers that include decimals. Real numbers can also be positive and negative. Examples of real numbers are:  0.5  25.5  1.25  –25.5 Currency: Currency data type is used for monetary values. Currency numbers are real numbers (decimals) that have been formatted to include money symbols ($, £, €, CFA etc). Examples of currency data:  £1  2,000CFAF  $10  XAF 500 Date/Time: Date and time data types are used for date and time respectively. Date and Time data can be shown in many different formats. The most common formats are shown in the table below: Examples of Date Examples of Time  dd/mm/yy (01/04/92) Long time (17:24:33)  dd/mm/yyyy (01/04/1992) Medium time (05:24:PM)  dd/mmm/yyyy (01/Apr/1992) Short time (17:24) Take care to match the date/time data you are inputting to the style of date/time that your computer is set up to expect. For example, American style dates follow the mm/dd/yy format and will cause problems if you try to insert data in the International style of dd/mm/yy.

#### 5.4. File Formats

Data in a file must be stored in a way that a program that uses the file will be able to recognize and possibly access it. The way data are arranged logically within a file is called file format. A particular file format is often indicated as part of a file's name by a file extension. The file extension is a set of characters added to the file name to help identify the type of data the file contains. Conventionally, the extension is separated from the file name by a dot and contains three or four letters that indicate the format. For example, notes.docx, MyAccounts.xls, victory.mp3 and flag.jpg. Different file formats exist for different file types including text documents, graphics, audio, video, and hypermedia. Document File Formats: A document is a file that contains information. Text material typed using text editing programs like Microsoft Word, WordPad, and Notepad belong to the group of documents. They may contain diagrams or images. Some document extensions are given in the table below. Format Extension Description Microsoft Word .docx / Identifies Microsoft Word document files. Document .doc Identifies ASCII text files. In most cases, a document with a .txt extension does not Plain Text Document .txt include any formatting commands, so it is readable in any text editor (Notepad, WordPad) or word processing program. Identifies documents encoded in the Portable Document Format developed by Adobe Portable Document .pdf Systems. To display or print a .pdf file, the Format (PDF) user should obtain the freeware Adobe Acrobat Reader or Foxit Reader. Microsoft Excel

![.xlsx / .xls](/notes/figures/part2-p004-0.png)

*.xlsx / .xls*

.xlsx / .xls Identifies spreadsheet file in Microsoft Excel. Document Microsoft .pptx / Identifies presentation file in Microsoft PowerPoint ppt PowerPoint. Document Graphics File Formats: Graphics files contain data that can be represented as images such as pictures. Computers store graphics as either bitmap images or vector images.

- Bitmap Graphics: A bitmap (or raster)image is a computer graphic stored as a collection of dots (pixels) of individual colors that make up the image. Each pixel is stored in memory as a collection of bits that represent the attributes of the individual pixels in an image (one bit per pixel in a black-and-white display, multiple bits per pixel in a color or gray-scale display). Since a data file for a bitmap image contains information about every single pixel in the image, the file size of a bitmap graphic is often quite large. Bitmapped graphics are typical of paint programs, which treat images as collections of dots rather than as shapes.

![](/notes/figures/part2-p004-1.png)

Bitmap image Bitmap images require higher resolutions to appear smooth. Bitmap file formats include GIF, JPG, PNG, TIFF and BMP. Format Extension Characteristics

- It is an 8-bit format limiting the number of colors in an image to 256. It has low Graphics resolution. Interchange .gif

- It is a lossless compression format Format (GIF)

- It supports animation

- Used for on-screen viewing only

- It is a 24 bits format allowing more than 16 million colors in an image. It is high Joint resolution format. Photographic .jpeg / .jpg - It is a lossy compression format. Can be Experts Group created at a variety of compression levels. (JPEG) More compression means less quality.

- Handles only still images

- Used for storage and interchange of gray- Tagged Image scale graphic images.

![.tiff / .tif](/notes/figures/part2-p005-0.png)

*.tiff / .tif*

File Format .tiff / .tif - Improved lossless compression (TIFF) - No support for animation

- Used for print production

- Limited color format (has more color Portable options than GIF) Network .png

- Used for on-screen viewing Graphics (PNG)

- Designed to replace the GIF file format

- Vector graphics: Vector images consist of points, lines and curves based on mathematical definitions.

![](/notes/figures/part2-p005-1.png)

Vector image The edges of vector graphics remain smooth at any size or resolution. Fonts, line art (charts and graphs) and illustrations are typically vector-based. Vector file formats include DXF, EPS, PDF, PS. Vector file formats are created using mathematical definitions to produce smooth paths. They can be scaled in size without any loss of quality. They are typically used for type, illustrations and line art.  DXF: Drawing Interchange Format  PIC: Macintosh Picture  PS: PostScript  EPS: Encapsulated PostScript Audio File Formats: An audio file is a record of captured sound that can be played back. Some common audio file formats are: Format Extension Description Identifies audio files compressed and encoded MPEG Audio according to the MPEG Audio Layer-3 standard.

![Layer-3](/notes/figures/part2-p005-2.png)

*Layer-3*

Layer-3 Although MP3 is part of the MPEG family, it is audio-only. Identifies sound files stored in waveform audio Waveform Audio format. One minute of sound in WAV format .wav File can occupy as little as 644 kilobytes or as much as 27 megabytes of storage. Identifies audio files stored using an audio coding Windows Media scheme developed by Microsoft that is used in .wma Audio distributing recorded music, usually over the Internet. Musical Instrument

![Musical Instrument](/notes/figures/part2-p005-3.png)

*Musical Instrument*

Digital Interface .mid Identifies audio files in MIDI format. (MIDI) Video File Formats: A video file is a recording of visual moving objects. Some common video file formats are: Format Extension Description Identifies video and sound files compressed in the MPEG format specified by the Moving

![MPEG (Moving](/notes/figures/part2-p005-4.png)

*MPEG (Moving*

.mpeg / Picture Experts Group. The MPEG standard has Picture Experts .mpg different types that have been designed to work Group) in different situations (MPEG-1, MPEG-2, and MPEG-4) A Windows multimedia file format for sound

![Audio Video](/notes/figures/part2-p005-5.png)

*Audio Video*

.avi and moving pictures that uses the Microsoft RIFF Interleave (Resource Interchange File Format) specification. Hypermedia File Formats: Hypermedia is the combination of text, video, graphic images, sound, hyperlinks, and other elements in the form typical of Web documents. Essentially, hypermedia is the modern extension of hypertext, the hyperlinked, text-based documents of the original Internet. Examples of hypermedia file formats are:

![Hypertext Markup](/notes/figures/part2-p005-6.png)

*Hypertext Markup*

Format Extension Description Hypertext Markup .html / Identifies Hypertext Markup Language (HTML) Language File .htm files, most commonly used as Web pages. Identifies eXtensible Markup Language (XML) Extensible Markup files. XML offers greater flexibility in organizing

![Language File](/notes/figures/part2-p005-7.png)

*Language File*

Language File and presenting information in web pages than is possible with HTML.

#### 5.5. Data Security

There is always a chance that data can be compromised though it may appear secure when confined in a computer. One could suddenly be hit with a malware infection where a virus destroys the files or hackers may gain access into the computer system and steal, delete or destroy files. Data security is the practice of keeping data protected from unauthorized access and unauthorized use. Threats to Data Security: Data stored in a computer is exposed to different threats. The following are some examples of threats to the security of our data. Threats to computer data include hacking, malware attacks, theft, natural disaster, hardware failure and software failure. Threat Description This is the illegal or unauthorized access to another person's computer system to steal, delete, corrupt or illegitimately view Hacking files. A person who accesses someone's computer without their permission is called hacker. Malware are software created and distributed for malicious Malware attack purposes, such as invading computer systems in the form of viruses, worms, or Trojan horse. Theft Theft of computer data. Accidental deletion by yourself or an incompetent colleague or Deletion friend. Deliberate deletion by a disgruntled colleague or friend. Natural disaster Natural disasters like fire and flood can be the cause of data loss. Hardware Hardware failure like disc scratch, disk crash and file server failure failure. Software failure Operating system failure that requires formatting Data Security Measures: Different measures than can be used to ensure the security of our data include authentication, encryption, backup, the use of antivirus software and firewalls.

- Authentication: The process of determining if someone is who they say they are. In other words, it is proving someone's identity. Authentication protects data from unauthorized access. This can be done by the use of usernames and passwords, biometrics, and smart cards.  A password is a secret sequence of characters known to an individual which when provided, proves that they are authentic. When a system is password protected, a user must provide their username and password which the system compares with a list of authorized users stored in the system. If the system detects a match, the user is granted access to the system. Passwords are not reliable as they can be guessed or cracked. So, if anyone is using a password to protect their system, the following guidelines will help make it more secure:

- It should be at least 8 characters long

- Use a mixture of lowercase and uppercase letters and numbers

- Do not use proper words like your name and names of your love ones

- Do not use any information about you like your date of birth

- Change your password regularly but not too often

- Do not tell your password to anyone else  Biometrics refers to the use of measurable biological features to identify a person. Such biological features include fingerprints, eye patterns, facial patterns, voice patterns, and DNA.  A smart card is a small plastic card that holds user authentication information on a chip. To access a system the user inserts the card into a card reader and types a PIN (Personal Identification Number). If the PIN is correct, the user is granted access to the system.

- Encryption: The transformation of data from one form to another to prevent an unauthorized user from being able to understand it. The original data or message is known as plaintext. The encrypted data is known as cipher text. The encryption method or algorithm is known as the cipher, and the secret information to encrypt or decrypt the data is known as a key. Encryption protects data from unauthorized use.

- Backup: To make duplicate copies of data that will be used to replace the original copies in case they are damaged or lost. The duplicate copy or backup is stored in an external hard drive, a DVD, or CD which is kept in a safe place. This will ensure that if the original data is deleted or damaged, the backup copy is used to replace it.

- Antivirus: An antivirus is software that detects and removes viruses from a system. A virus is a type of malicious program that can infect a computer and delete or damage files or cause the computer to behave in an unexpected and undesirable way. To protect your computer from viruses, you need to install an antivirus and update it regularly. Scanning your computer with an updated antivirus will help detect viruses if the computer is infected.

- Firewall: A firewall is a hardware and/or software system that protects a computer or private network against threats coming from another network such as the Internet. All messages entering or leaving a computer or network protected by a firewall must pass through the firewall which examines each message and blocks those that do not meet the specified the security criteria. NOTES
