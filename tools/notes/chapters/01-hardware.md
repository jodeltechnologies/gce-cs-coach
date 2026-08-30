# Hardware

#### 1.0. Introduction

A modern computer can be defined as a machine that can accept instructions and perform computations based on the instructions. A computer takes data as input from the user and processes this data under the control of a set of instructions called program, and gives the result as output and can save the data for future use. A computer system is basically a combination of hardware and software. Hardware refers to the physical parts of a computer while software refers to the collection of programs that make use of the hardware for performing various functions. Computer hardware devices, which make up the machine part of the computer, can be divided into internal and external devices. Internal hardware devices often referred to as components include motherboards, hard drives, and RAM. External hardware devices usually called peripherals include monitors, keyboards, mice, printers, and scanners.

#### 1.1. Functional Units of a Computer

A computer performs five major operations or functions irrespective of its size and make. These are

- it accepts data or instructions as input,

- it stores data and instructions

- it processes data as per the instructions,

- it controls all operations inside a computer, and

- it gives results in the form of output. In order to carry out these five operations, the computer allocates the tasks between its various functional units which are the input unit, storage unit, processing unit and output unit.

![Functional Diagram of a Computer](/notes/figures/part1-p001-0.png)

*Functional Diagram of a Computer*

##### 1.1.1. The Processing Unit

The processing unit, also called central processing unit (CPU), is the part of the computer that performs calculations that are required to convert data into information. It is also responsible for controlling all the activities of the computer system. The CPU is made up of two main components: the arithmetic and logic unit, and the control unit. Other CPU components are registers, cache memory and buses.

- Arithmetic and Logic Unit: The ALU is responsible for performing arithmetic operations and logic operations. Arithmetic operations include addition, subtraction, multiplication and division while logic operations include comparisons like equal to, less than, greater than and less than or equal to. These are essential operations that need to be done on almost any data that is being processed by the CPU.

- Control Unit: The Control Unit is responsible for controlling the operations of the computer. It locates and retrieves program instructions from memory, interprets them and ensures that they are carried out in proper sequence. The activities of the other components of the computer are coordinated by the Control Unit.

- Registers: Registers are storage locations within the CPU that hold instructions and data that the processor is working on. Registers are grouped into two: general purpose registers and special purpose registers. General purpose registers have no specific function - they are used according to the needs of the program being executed by the computer. Special purpose registers on the other hand are dedicated to specific functions and have special names. Examples of special purpose registers are program counter, instruction register, accumulator, status register, memory data register, and memory address register.

- Processor Speed: Processor speed refers to the number of clock cycles per second that the processor runs at. It is measured in hertz – cycles per second. Generally, processor speeds are expressed in gigahertz (GHz), where giga stands for one billion or 230. Thus, a CPU with a clock speed of 2.3GHz can perform 2,300,000,000 (i.e. 2.3 x 230) clock cycles in one second. The faster the clock speed, the more the instructions the processor can execute per second.

- Instruction Cycle: A program consists of a number of instructions that are executed by the processor when the program is running. For these instructions to be executed, the program must first be loaded into the computer's main memory as well as the data on which the instructions will act – the stored program concept. Once the program and necessary data are in main memory, the CPU executes the instructions one after the other in the order specified by the program. To execute each instruction, the CPU fetches it from memory, decodes it, and executes it. This process of fetching, decoding and executing an instruction is called the instruction cycle or fetch-execute cycle.

- Fetch: The control unit copies the instruction from the memory into the CPU.

- Decode: The Control unit works out what the instruction means.

- Execute: The ALU performs the instruction

![The Instruction Cycle](/notes/figures/part1-p002-0.png)

*The Instruction Cycle*

##### 1.1.2. The Storage Unit

The storage unit consists of computer components that can hold programs and data for use in the computer. Storage devices are used for holding data and programs before and after processing. Computer storage can be classified into two types: primary storage and secondary storage.

- Primary Storage: Primary Storage is computer storage that holds programs and data that are currently being used by the computer. It is also called immediate access storage as the data it holds can be directly accessed by the CPU. Primary memory can be further divided into Random Access Memory (RAM) and cache memory.

- Random Access Memory: RAM is the computer's main memory. It is the temporary space into which user programs and data are loaded prior to execution. The operating system, application programs and the data in current use are kept temporarily in RAM so that they can be accessed by the computer's processor. The purpose of RAM in a computer is to hold data that is in current use by the CPU. The content of RAM can be rewritten or modified. Also, RAM is volatile – its content is lost when the computer is turned off.

![RAM contents only last a while](/notes/figures/part1-p002-1.png)

*RAM contents only last a while*

Poem: RAM contents only last a while

- Read Only Memory: ROM is a kind of computer memory whose contents can only be read but not modified. Data stored in ROM is written once and cannot be modified by the user. The purpose of ROM in a computer is to hold never changing data for later use. For example, in a computer, ROM is used to hold the instructions of a program called BIOS (Basic Input and Output System) that are required to startup (boot-up) the computer. In some computer systems, like your washing machines and microwave ovens, ROM is used to store the programs that control the hardware, as well as data such as washing and cooking times etc. ROM is non-volatile. This means that the content of ROM is not lost when power is switched off (computer is turned off). Question: State two differences between RAM and ROM.

- Cache Memory: Cache memory is a small amount of fast memory that acts as buffer between the CPU and main memory. It holds frequently requested data and instructions so that they are immediately available to the CPU when needed. Cache memory is faster than main memory (RAM). This means that the CPU can access cache memory more quickly than it can access RAM. Therefore, retrieving frequently requested data and instructions from RAM and storing them into cache memory, speeds up memory accesses thereby increasing the performance of the computer.

- Virtual Memory: Virtual memory is part of the hard drive (secondary storage) that is used as an extension of main memory. When a computer is running many programs at once and RAM is running low, the operating system sets up a file on the hard drive (secondary storage) to be used as part of RAM called virtual memory. Data that are not immediately needed by the CPU are moved out of RAM to virtual memory in order to free up RAM. When the CPU needs the data, it pulls it back from the hard drive into RAM. For example when a program has been minimized for a long time it may be transferred to virtual memory so as not to fill up the main memory. Swapping is the process the Operating System uses to move data between RAM and virtual memory. Using virtual memory slows the computer down because accessing the hard disk takes much longer than accessing RAM.

- Secondary Storage: Secondary storage is computer storage that holds programs and data for backup purposes or future use. Secondary storage is not directly accessible to the CPU as programs and data from secondary storage must be transferred to main memory (RAM) for processing. It is also called mass storage, backup storage or external storage. Secondary storage devices are of three types; magnetic, optical and solid state. Magnetic devices include hard disks, floppy disks and tapes. Optical devices include compact discs (CDs), digital versatile discs (DVDs) and Blu-ray discs. Solid state devices include flash drives, memory cards and secure digital cards.

- Magnetic Storage: Magnetic storage devices store data as electromagnetic charges on the magnetic surfaces of their storage media. Examples are floppy disks, hard disks and magnetic tape. Floppy Disk: A floppy disk consists of a round flexible plastic disk coated with a magnetic substance and protected by a plastic cover lined with a soft material that wipes the disk clean as it spins. The disk is made of two recordable surfaces which are divided into a number of concentric circles called tracks. Each track is in turn divided into a number of smaller units called sectors. A sector is the basic unit of storage on the disk and has a capacity of 512 bytes.

![](/notes/figures/part1-p003-0.png)

Hard Drive: A hard disk drive (HDD) consists of several metallic platters (disks) which store data. Each platter has two recordable sides, each divided into a number of tracks. Tracks on a platter are numbered 0 from the outside and usually go up to 1,023. Each track is divided into sectors. Sectors are grouped together to form clusters. A cluster is the smallest logical amount of disk space that can be allocated to hold a file. A cylinder is a sum set of all the tracks on all the platters that have the same track value.

- Optical Storage: Optical storage devices store data as microscopic light and dark spots on the disc surface. Data is stored in the form of indentations and bumps on the reflective surface of an optical disc. The indentations are called pits, and the bumps are called lands. A laser is used to burn pits in certain places of the continuous spiral track of the disc and where a pit is formed is read as a 1 and a land is read as a 0. Examples of optical storage devices are compact discs, digital versatile discs and Blu-ray discs. Compact disc: A compact disc (CD) is a round disc coated with a metallic surface on which data can be stored and accessed via laser technology. Different variations of CD exist: CD-ROM, CD-R and CD-RW. A CD can store 650MB to 700MB of data. CD-ROM stands for compact disc read only memory. CD-ROMs can only be read but not recorded on by the user's computer. Their content is set during manufacture. CD-R stands for compact disc recordable. It is a type of CD that can be recorded by the user. Once the user records on the CD, the content is set and cannot be changed. CD-R can be read by CD-ROM drives but to write on them, you need a CD-R drive. CD-RW stands for compact disc rewritable. It is a type of CD that can be recorded, erased and reused by the user. CD-RW cannot be read by CD- ROM and CD-R drives. CD-RW drives are required to read and write on them. Digital Video Disc: A digital video disc (DVD) is similar to a CD in size and thickness but has a higher storage capacity than the CD. DVDs use a laser beam of wavelength shorter than used by CDs. This allows for smaller indentations and increased storage capacity. Just like the CD, different variations of the DVD exist: DVD-ROM, DVD-R and DVD-RW. A DVD can store up to 17GB of data. Common DVD storage capacities are: DVD-5: Single-sided, single-layer, Storage capacity: 4.7GB. DVD-9: Single-sided, double-layer, Storage capacity: 8.5GB. DVD-10: Double-sided, single-layer, Storage capacity: 9.4GB. DVD-18: Double-sided, double layer, Storage capacity: 17.1GB.

![:  The term solid-state essentially means no moving](/notes/figures/part1-p003-1.png)

*:  The term solid-state essentially means no moving*

- Solid State Storage: The term solid-state essentially means no moving parts. Solid-state drives (SSDs) have no moving parts (no reels, no spinning disks). They store data using a type of memory called flash memory. Examples of solid state devices are USB flash drives, memory cards, secure digital cards and external hard drives.

- Characteristics of Storage Devices: Three important characteristics of storage devices are storage capacity, access time and access method.

- Storage capacity: Data is stored in the computer as a sequence of bits. A bit is a binary digit which could be 0 or 1. In itself a bit is of little use, so bits are used in groups to make them more useful. A group of 8 bits makes a byte which is used to represent a single character in the computer. The capacity of a storage device is the maximum number of bytes of data the device can hold. Units of storage are summarized as follows: Byte Kilobyte Megabyte Terabyte Gigabyte (GB) (B) (KB) (MB) (TB) 1B = 8 1KB = 1,024 1MB = 1,024 1GB = 1,024 1TB = 1,024 bits bytes kilobytes megabytes gigabytes 1KB = 210 1MB = 220 1GB = 230 1TB = 240 bytes bytes bytes bytes Example 1: A floppy disk has two recordable sides, 18 tracks and 80 sectors per track. If each sector stores 512 bytes of data, what is the capacity of the disk in kilobytes and megabytes? Number of sides = 2 Number of tracks = 18 Number of sectors per track = 80 Total number of sectors = 2 x 18 x 80 = 2880 Size of sector = 512 bytes Size of disk = 2880 x 512 = 1,474,560 bytes Size of disk in KB = 1,474,560/210 = 1440KB Size of disk in MB = 1,474,560/220 = 1.41MB Example 2: A flash disk of size 128MB is used to save two documents of sizes 108MB and 2048KB. How much space is left in the disk? Give your answer in megabytes and kilobytes. Size of disk = 128MB Size of document 1 = 108MB Size of document 2 = 2,048KB = 2,048/210 = 2MB Space left on disk in MB = 128 – (108 + 2) = 18MB Space left on disk in KB = 18 x 210 = 18,432KB Example 3: A double layer DVD can store 8.5GB of data. How many CDs of storage capacity 700MB are required to store information in a full DVD? Size of DVD = 8.5GB = 8.5 x 210 = 8704MB Size of CD = 700MB CDs needed = 8704/700 =12.4 Answer: 13 CDs needed (12 filled CDs and 1 partially-filled CD)

- Access time: Access time or access speed is the time needed to read or write data to a storage device's medium. Access time is usually measured in milliseconds and is used as a performance measure for hard disks and CD drives. Units of time are summarized as follows: Millisecond Microsecond Nanosecond Picosecond Femtosecond (ms) (µs) (ns) (ps) (fs) 1s = 1,000 ms 1ms = 1,000 µs 1 µs =1,000 ns 1ns = 1,000 ps 1ps = 1,000 fs 1s = 103 ms 1s = 106 µs 1s = 109 ns 1s = 1012 ps 1s =1015 fs Example 1: Convert 2.5 seconds to milliseconds 1s = 1000 ms 2.5s = X X = 2.5 x 1000 = 2500 2.5s = 2500ms Example 2: Convert 0.00004 seconds into milliseconds 1s = 103 ms 0.00004s = Y Y = 0.00004 x 103 = 0.04 0.00004s = 0.04ms Example 3: Convert 5 microseconds into seconds 106 µs = 1s 5 µs = X X = 5/106 = 0.000005 5µs =0.000005s Example 4: Convert 0.04 millisecond to nanoseconds 1 ms = 106 ns 0.04ms = Yns Y = 0.04 x 106 = 40,000 0.04ms = 40,000ns

- Access Method: An access method is the technique used to store and read information from a storage device's medium. Storage media can be accessed in two ways: sequentially or randomly. Sequential access: An access method in which data is read in serial order, one after the other in the order it was stored. To read any data stored on the medium, the device has to start from the beginning going through each data until the required data is found. As such, the time to access a particular piece of data depends on the data's location on the medium. An example of a sequential access medium is the magnetic tape.

![](/notes/figures/part1-p005-0.png)

Random access: An access method in which data is read in any order, regardless of its location on the device's medium. To read any data stored on the medium, the device does not need to go through all preceding data. Any particular piece of data can be accessed at any moment in approximately the same amount of time. It is also called direct access. Examples of random access media are RAM, ROM, magnetic disks, CDs, DVDs, and flash memory.

![](/notes/figures/part1-p005-1.png)

- Memory Hierarchy: Modern computers manage memory by organizing it into a hierarchy in which large and slow memories feed data into smaller but faster memories for faster processing of data. This organization of computer memory is known as memory hierarchy. Registers Storage capacity decreases, access speed Cache memory increases, and cost per Main memory byte increases, as we move from bottom to Secondary storage top.

![Memory hierarchy](/notes/figures/part1-p005-2.png)

*Memory hierarchy*

##### 1.1.3. Input Unit

The input unit consists of input devices. An input device is a piece of hardware that is used to enter data and instructions into the computer. Examples of input devices are keyboards, mice, scanners, microphones, digital cameras, and webcams.

- Keyboard: A keyboard is a device that is used for entering text based data into the computer. A keyboard typically contains buttons or keys for individual letters, numbers, symbols (special characters), as well as keys for specific functions. When a key is pressed, a code representing each character is sent to the computer to tell it which character to display. The way keys are arranged on the keyboard is known as the layout of the keyboard. There are different keyboard layouts but the best known are QWERTY mainly used by English speakers, and AZERTY used by French speakers. The name QWERTY or AZERTY comes from the first six lettered keys on the top row of the letter keys – Q-W-E-R-T-Y. A standard keyboard has a total of 101-104 keys grouped as follows:

- Letter (alphabetical) keys are in the center of the keyboard.

- Number keys run across the top of the keyboard and are also on the right of the keyboard.

- Symbol keys to the right of the letter keys include symbols such as the comma, full stop, question mark, colon and quotation marks.

- The keys that surround the letter, number and symbol keys on the left, right and bottom of the keyboard, help you to choose where and how you type. These keys called Action keys include TAB, CAPS LOCK, SHIFT, CTRL, SPACE bar, ENTER and BACKSPACE.

- Function keys labeled F1 to F2 are found across the top of the keyboard. They are used for special tasks by different programs. For example, F1 is used in most programs to display help. Win key + F1 opens the Microsoft Windows Help and Support Center F2 is used to rename any selected icon, file or folder Use Shift + F3 to change text in Microsoft Word from upper to lower case Alt + F4 is used to close the currently open program F5 is often used to refresh a webpage Click F5 to open Find & Replace window in Microsoft Word

- Arrow keys also called cursor keys are four keys (Up, Down, Left and Right) that allow the user to navigate through documents and websites.

- Mouse: A mouse is a handheld device used to manipulate objects on a computer screen. When moved across a flat surface, the mouse controls the movement of a cursor or pointer on the computer screen. Most mouse designs have two buttons – a left button and a right button. [Diagram] A mouse can be used to do a variety of tasks like select things, open things and move things.

- To select things, move your cursor over the item, click once with the left button and let go. This known as a click.

- To open things click twice on the left button in quick succession – think 'knock, knock' on a door. This is known as a double-click. A double click can be used to open a folder, a file or a program.

- To move things, you need to 'drag and drop'. First select the item with the left mouse button and keep the button pressed down. Then move the mouse and the item on screen will move with the cursor. This is a drag. When you have the cursor and item in the position you want, release the left mouse button. The item will now be dropped where the cursor is positioned on the screen.

- Pressing the right mouse button displays a list of computer commands to choose from. This is known as a right-click.

- Scanner: A scanner is a device that is used to convert physical documents like text documents and photographs into digital data that can be stored and manipulated on a computer. These physical documents are said to be in hardcopy format. When converted into digital data, they are said to be in softcopy format. A scanner therefore converts hardcopy information into softcopy. Common scanner devices are the flatbed scanner, optical mark reader, optical character reader and barcode reader.

##### 1.1.4. Output Unit

Output devices are used to communicate the results of computations to the user in a form they can understand. Input devices take data into the computer for processing while output devices bring information out of the computer. Examples of output devices are monitors, printers, speakers, plotters and projectors.

- Monitor: A monitor is a device that displays computer output on a screen. This type of output is known as softcopy output. The monitor is the most common output device. Another name for monitor is visual display unit (VDU). Monitors are characterized by their type, their resolution, their refresh rate and their size. Monitor Types: Monitors can be classified into two main types based on the technology they use namely cathode ray tube (CRT) monitors and liquid crystal display (LCD) monitors. Assignment: State four advantages of LCD monitors over CRT.

- LCD monitors are lighter and occupy less space

- LCD monitors consume less electricity

- LCD monitors generate less heat

- LCD monitors produce brighter images Monitor resolution: The screen of a monitor is made of tiny dots that are individually painted to form an image on the screen. Each of these dots is called a pixel – short for picture element. Screen resolution refers to the number of pixels on a display screen. It is expressed in terms of the number of pixels on the horizontal axis and the number of pixels in the vertical axis. A resolution of 1360 x 768 means that there are 1360 horizontal pixels (columns) and 768 vertical pixels (rows). Displays with lots of pixels are called high resolution while those with fewer pixels are called low resolution. The higher the resolution, the clearer and sharper the image will be. Refresh rate: The refresh rate of a monitor refers to the number of times an image is redrawn on the screen per second. This number is measured in hertz (Hz). A typical rate for a CRT monitor is 60, 75 or 80 Hz, but some monitors support a much higher rate. A higher refresh rate reduces screen flicker and eyestrain. You can alter the refresh rate for CRT by changing the settings in the monitor's control panel. This should be set to the maximum refresh rate possible. Monitor size: The size of a monitor refers to how big the monitor is. It is measured in inches along the diagonal of the screen. Typical sizes are 10" or 12" for LCDs and 14", 15" or 21" for desktop monitors.

- Printer: A printer is a device that is used to produce computer output (text and images) on paper. This kind of output is called hardcopy output. Printer Types: Based on the technology used, printers can be classified into impact and non-impact printers. Impact printers have mechanical contact between the printing head and the paper while non-impact printers have no mechanical contact between the printing head and the paper. Daisy wheel, dot matrix and line printers are examples of impact printers while laser printers, ink jet printers and thermal printers are examples of non-impact printers. Printer resolution: Printed images are made up of tiny dots of color (pixels), and the more dots that can be squeezed into a square inch, the sharper the resulting image will be. Printer resolution is measured in dots per inch, or dpi, and ranges from about 125 dpi for low-quality dot-matrix printers to about 600 dpi for some laser and ink-jet printers. Question: What is an input/output device? Give two examples. An input/output device is a device that can be used to enter data into the computer and also used to send out information from the computer. Examples are touchscreen and electronic whiteboard

#### 1.2. The Motherboard

The motherboard is the main printed circuit board in the computer. It holds the CPU and other electronic components that give functionality to the computer. The motherboard is essential as a means of connecting all of the computer's parts together, and provides the main computing capability. Some motherboard components include the CPU socket, memory slots, chipset, BIOS chip, CMOS chip, Northbridge, Southbridge, buses and expansion slots.

##### 1.2.1. Buses

The term bus refers to a set of hardware lines (wires, conductors) used for data transfer among the components of a computer system. A bus interconnects computer components together, allowing the exchange of data between them. There are many buses on the motherboard and each bus is limited by its width (or size) and speed. Bus width refers to the number of wires (or lines) that the bus has. They are usually 8, 16, 32 or 64-bits wide. This tells how many bits the bus can transmit at any one time. The speed of a bus is measured in megahertz (MHz) and the faster the bus, the faster data is communicated. The bus that connects the CPU to main memory is called the system bus. The system bus combines the functions of three types of buses namely the data bus, address bus and control bus.

- Address bus: It is a unidirectional bus that carries address information from the CPU to the other components of the computer. The CPU uses the address bus to send the address of where data needs to go or where data needs to be gotten from. The address bus only sends data in one direction – from the CPU to RAM.

- Data bus: It is a bidirectional bus that carries data between the CPU and main memory. The CPU uses the data bus to send data to memory or receive data from memory. The data bus is bidirectional as such data can flow in both ways along the bus.

- Control bus: It is a bidirectional bus that carries signals to coordinate the activities of the components of the computer. The CPU uses the control bus to send out control signals to all of the devices to check their status and give them instructions. Some typical control bus signals are: memory read, memory write, I/O read, I/O write, transfer ACK, clock, bus request and bus grant. When the CPU wants to read data from a memory location, it sends out the memory address of the desired data on the address bus and then sends out a Memory Read signal on the control bus. The memory read signal instructs the addressed memory device to output the data onto the data bus. The data from the memory travels along the data bus to the CPU.

##### 1.2.2. Expansion Slots and Cards

An expansion slot is a socket on the motherboard which is used to insert an expansion card, which provides additional features to a computer. Different types of expansion slots that can be found in modern computers are AGP, PCI, PCIe and ISA. They differ primarily in how fast they transfer information between the microprocessor and the expansion card. An expansion card, also called expansion board, is a circuit board that is plugged into an expansion slot to add extra functionality to the computer. Typical expansion cards add memory, video support, internal modems, etc.

- Graphics card: A graphics card, also called video card or graphics adapter, is an expansion card that controls the output to a display screen (monitor). The graphics card in your PC converts video data into electronic signals and sends them to your monitor. The monitor accepts the signals and turns them into colorful images. Graphics cards connect to an AGP slot or PCIe slot.

- Sound card: A sound card, also known as audio card or audio adapter, is an expansion card that enables a computer to manipulate and output sound. Sound cards enable the computer to output sound through speakers or headphones connected to the board, to record sound input from a microphone connected to the computer, and to manipulate sound stored on a disk.

- Network adapter: A network adapter, also called network interface card (NIC), is an expansion card that is used to control the exchange of data between the computer and a network. Most modern network adapters are produced for the PCI slot.

- TV tuner card: A TV tuner card is an expansion card that allows television signals to be received and processed by a computer. It provides a port for connecting coaxial cable to the computer, allowing TV channels to be displayed on a computer screen. Most TV tuners also function as video capture cards, allowing them to record television programs onto the hard disk

##### 1.2.3. I/O Ports

The I/O ports on the back panel of the system are the pathway through which the computer system communicates with peripheral devices such as a keyboard, mouse, printer, and monitor. Several ports can be found on a computer including PS/2 ports, VGA port, Ethernet port, modem port, USB port and FireWire port.

- PS/2 port – PS/2 stands for Personal System 2. There are two PS/2 ports on the computer, one for connecting the mouse and the other for the keyboard.

- VGA port: VGA stands for Video Graphics Array. The VGA port is used for connecting the monitor to a computer's video card.

- Ethernet port: The Ethernet port is used for connecting the computer to an Ethernet network through cable. It is also called RJ-45 port, where RJ stands for Registered Jack.

- Modem port: The modem port is used for connecting a computer to a telephone network. It is also called RJ-11 port. This port looks like the RJ-45 port but is smaller.

- USB port: USB stands for Universal Serial Bus. The USB port is used for connecting USB compliant devices like flash drives, printers, mice, Keyboards and speakers. USB ports are of different versions and types. Different USB versions are USB 1.1, USB 2.0 and USB 3.0 while different types are USB type A, USB type B, USB mini B, micro USB A and micro USB B.

- HDMI port: HDMI stands for High Definition Multimedia Interface. The HDMI port is used for connecting digital audio/video devices such as HD DVD players, Blu-ray Disc players, personal computers (PCs), video game consoles such as the PlayStation 3 and Xbox 360.
