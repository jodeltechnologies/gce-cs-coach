# Information Systems

#### 6.0. Introduction

An information system is an integrated set of components for collecting, storing, processing data and for providing information and knowledge. Business firms and other organisations rely on information systems to carry out and manage their operations, interact with their customers and suppliers, and compete in the marketplace. An information system depends on people (end users and IS specialists), hardware (machines and media), software (programs and procedures), data (data and knowledge), and networks (communications media and network support) to perform input, processing, output, storage, feedback and control activities that convert data resources into information products. Data are raw facts and figures that have no purposeful meaning. Although raw and unorganized, data are potentially useful facts. When data are processed, interpreted, organized, structured, or presented so as to make them meaningful or useful, they are called information. Information therefore refers to data that has been processed so as to make it meaningful or useful. For example, each student's test mark is one piece of data. The student's average is information that can be derived from the given data.

#### 6.1. Data Capture

All information systems need data entered into them otherwise they have nothing to process. Data capture is the process of collecting or gathering data and putting into the system. Data capture can be manual or automated. Manual Data Capture: This is a data capture method in which data is entered into the computer by typing and clicking. Manual data capture uses forms, questionnaires, interviews and observation for collecting data that is then entered into the system using input devices like keyboard, mouse and touchscreens. Automatic Data Capture: This is a data capture method that uses specialized input devices (sensors) to collect data that is directly entered into the computer without the use of a keyboard or mouse. Automatic data capture methods are OMR, OCR, MICR, Barcode reading and voice recognition.

- Optical Mark Reading (Recognition): OMR is a technique that is used to reading marks made with prescribed pencils on specially designed forms called OMR forms, and converting them into information in the computer. A common application of this technique is marking of multiple choice examinations.

- Optical Character Recognition: OCR is a technique that is used for reading printed or handwritten text and transmitting them into the computer as if they were typed from the keyboard. This method is suitable for capturing data from airline tickets, reading postal codes, capturing data from telephone and electric bills.

- Magnetic Ink Character Recognition: MICR is a technique that is used for reading specially-formatted characters written in special ink called magnetic ink. A good example of the use of MICR is in banking where magnetic ink is used in the printing of certain characters on the bottom of checks and on the back of credit cards. When these documents are presented at the bank, MICR is used to verify their legitimacy or originality.

![](/notes/figures/part2-p007-0.png)

- Barcode Reading: This is a technique that is used for reading barcodes on products and translating them into digital data that is interpreted by the computer to identify the products. A barcode is a sequence of vertical bars/lines of varying widths that identify a product. The barcode gives information about:

- The country of manufacture

- The name of the manufacturer

- A product code

![](/notes/figures/part2-p007-1.png)

Barcode reading is used in libraries, supermarkets and retail shops.

- Voice Recognition: This is a technique that is used for converting speech into text or a sequence of commands that can be executed by a computer. It is most common for data entry and word processing environments, and fields where a user needs to interact with a computer without using their hands. Some common examples of the use of voice recognition are Google voice, and Cortana in Windows 10.

#### 6.2. Data Integrity

Data integrity refers to the accuracy and consistency of data. Accuracy refers to whether the data values stored are the correct values while consistency refers to the data's conformity to its expected value. Data integrity is ensured through data verification and validation. Data Verification: Data verification is a check on input data to make sure the data matches with the source. If the data matches the source, it is said to be correct. Two data verification methods are proofreading (visual checking) and double entry.

- Proofreading: Proofreading consists of reading the data entered either on screen or printout, to be sure that it matches the data source. For example, after typing a report, we print a copy which we read through to correct any errors.

- Double entry: Double entry consists of entering the data twice. The two entries are then compared against each other and a warning given if they do not match. For example, when creating a new password, it is always entered twice. Data Validation: Data validation is a check on input data to make sure it is sensible and reasonable. A validation check compares the input data with a set of rules that the system has been told the data must follow. If the data does not match up with the rules then there must be an error. Validation only checks that the data is valid but not its correctness. Methods for ensuring data validation are format check, length check, range check and presence check.

- Type check: A type check ensures that input data fits the required data type. For example, a person's name will consist of letters of the alphabet and sometimes hyphens and apostrophe. Any name that contains numbers will be rejected as invalid.

- Format check: A format check is used to ensure that input data is in a particular format. The format that data must be in is specified using an input mask. The input mask is made up of special characters which indicate what characters may be typed where. For example, the input mask for a car registration number is given as LL999LL, where L represents any letter and 9 represents any digit. SW499AO and CE021BA will be accepted as valid.

- Length check: A length check ensures that an entered value is not shorter or longer than a certain number of characters. For example, a phone number has 9 digits. Entering fewer or more digits makes a number invalid.

- Range check: A range check is used to ensure that the data entered falls between a specified minimum and maximum values. For example, a mark in an exam is between 0 and 20. Any mark entered that is below 0 or above 20 is rejected as invalid.

- Presence check: A presence check ensures that an entry has been made in a particular field. If it has not, the system will not allow the record to be saved or any entries to be made in later fields. Such fields called mandatory fields are indicated on some systems by the use of an asterisk. Exercise: Dates are read into a computer in the following format: DDMMMYY e.g. 15DEC92. The following dates were rejected by a validation program: 3MAR90, OCT2198, 31NOV02. State the validation check used to discover each error.

#### 6.3. Types of Information Systems

Within the organization there are three levels at

![strategic, tactical and operational.](/notes/figures/part2-p008-0.png)

*strategic, tactical and operational.*

which information can be used. These levels are strategic, tactical and operational. Level (Executives) Tactical Middle managers Level

![Operational](/notes/figures/part2-p008-1.png)

*Operational*

Level Workers

- Senior managers or executives need information to help with their business planning (long term plans)

- Middle managers need more detailed information to help them monitor and control business activities (short term plans)

- Workers with operational roles need information to help them carry out their duties Organizations employ several types of information systems to provide them with the information they need for planning, control and decision making. These include transaction processing systems, management information systems, decision support systems and executive information systems and expert systems. Transaction Processing System: A TPS captures and processes data generated during an organization's day-to-day transactions. TPS may work either in batch mode or on-line mode.

- Batch Processing: This is a processing method in which data is collected together (batched) and processed all at once with little or no human intervention. Batch processing is used in the following areas:

- Producing bills (billing systems e.g. electricity, water, gas etc.)

- Calculating employee monthly salaries (payroll systems)

- Processing student report cards

- Online Processing: This is a processing method in which data is processed immediately it is entered into the system. When a transaction is made, the system will automatically update and re-process. This ensures that the system always contains up- to-date information. Today, most TPS work in the on-line mode. Online processing is used in the following areas:

- Reservation (booking) systems (constantly recalculate how many seats/rooms are available as people do reservations)

- ATM systems (immediately update an account balance after a transaction) Management Information System: An MIS used the data collected by the TPS to generate reports that managers can use to make routine business decisions in response to problems. Some of the reports that this information system generates are summary and exception reports. All this is done to increase the efficiency of managerial activity. Decision Support System: A DSS helps managers in making decisions in situations where there is uncertainty about the outcomes of those decisions. A decision support system helps make decisions by working and analyzing data that can generate statistical projections and data models. DSS often involve the use of complex spreadsheets and databases to create "what-if" models. Expert Systems: An expert system, also called knowledge base system (KBS), is softwarethat attempts to act like a human expert on a particular subject area. It does this by combining the knowledge of human experts and then, following a set of rules, it draws inferences. An expert system is made up of three parts: a knowledge base, an inference engine and a user interface.

- Knowledge base: This is a database that contains the collection of facts and rules provided by human experts or specialists in a field.

- Inference engine: It is the processing part of an expert system. The inference engine acts rather like a search engine, examining the knowledge base for information that matches the user's query.

- User interface: This is the part of the system that allows a user to query (question) the expert system, and to receive advice. The user-interface is designed to be as simple to use as possible.

#### 6.4. System Development Life Cycle

System development or system analysis and design, is the process of creating and maintaining information systems. This is usually through a given number of steps called software development process or software development life cycle. SDLC consists of a number of stages that describe the activities involved in an information system development process. The classical SDLC involves the following stages: preliminary investigation, system analysis, system design, development and testing, implementation, and maintenance.

![System Development Life Cycle](/notes/figures/part2-p009-0.png)

*System Development Life Cycle*

Investigation: This is a brief study of the system under consideration that gives a clear picture of what actually the physical system is. Result: Feasibility report Activities:

- Gather information about the old or current system (through interviews, forms, questionnaires and observation)

- Identify problems with the current system

- Conduct a feasibility study to determine whether a new or improved information system is a feasible solution Analysis: This is an in-depth study of end user information needs which produces functional requirements that are used as the basis for the design of a new information system. System analysis describes what a system should do to meet the information needs of users. Result: Functional requirements document Activities:

- Collect data about the current system

- Identify how the current system uses resources

- Identify the requirements of the new or proposed system

- Identify the inputs, processing and outputs of the proposed system Design: This is the detailed description of how the system will accomplish the objectives of the analysis phase. In other words, it means describing how the new system will do what it has to do in order to solve the problems identified with the old system. Thus, the analysis phase specifies what needs to be done while the design phase specifies how to do the things that need to be done. Result: System specification document Activities:

- Design data entry forms (how will data be entered into the system)

- Design reports for printed output (what will printed outputs look like… e.g. pay slips, customer bills)

- Design screen-based outputs (what will data that are displayed on screen look like)

- Design structures to store data (e.g. databases, tables21

- Describe test data and test plans Development: This is the construction or creation of the new system from the design. It involves coding, testing and documentation. Result: Activities:

- Acquire hardware and software

- Write programs (coding)

- Test programs

- Produce documentation There are two types of documentation: user documentation (user manual) and technical documentation. User documentation contains the following:

- Instructions for installing and running the system

- Definition of hardware requirements

- Definition for operating system requirements

- Explanation of common errors and how to recover from them

- Description of how to make backups against accidental data loss

- The format of output data Technical documentation on the other hand contains the following:

- Description of data structures (data types, field names etc.)

- Listing of the code

- Diagrams like flowcharts and data flow diagrams showing how data flows through the system

- Testing information like test plans, test data, results and testing procedures.

- Details of validation rules used Implementation: Implementation is the conversion from the use of the old system to the operation of the new system. Product: Operational system Activities:

- Install the new system

- Load data into the new system

- Educate and train the users of the system Conversion from the old system to the new one can be done using different implementation methods.

- Direct changeover (plunge): plunge is an implementation method in which the old system is discarded completely the new system is used. All of the data that used to be input into the old system now goes into the new one. Its disadvantage is that, if the new system fails, there is no back-up system, so data can be lost.

- Pilot run: It is an implementation method in which the new system is first of all installed for trial in one part of the organization (e.g. in just one office, or in just one department). Once the pilot system is running successfully, the new system is introduced to other parts of the organization. Advantages: If something goes wrong with the new system, only a small part of the organization is affected. Also, staff that were part of the pilot scheme can help train other staff. Disadvantages: There is no back-up system for the part of the organisation doing the pilot, if things go wrong. Also, it takes longer to implement the system across the whole organization.

- Parallel run: This is an implementation method in which the old and the new system are kept running side-by-side until we are sure the new system performs correctly. All of the data that is input into the old system is also input into the new one. When staff are sure they can use the new system and that it is functioning properly, the old system is switched off. Advantages: If the new system fails, the old system will act as a back-up. Also, the outputs from the old and new systems can be compared to check that the new system is running correctly. Disadvantage: Entering data into two systems, and running two systems together, takes a lot of extra time and effort.

- Phased implementation (piecemeal): Piecemeal is an implementation method in which the new system is introduced one part at a time, gradually replacing parts of the old system until eventually the new system has taken over. Advantages: Staff can be trained gradually as they only need to train in the part of the system that is currently being phased in. Also, it is easier to find errors as you are dealing with only one part at a time. Disadvantages: If a part of the new system fails, there is no back-up system, so data can be lost. Also, it is only suitable for systems that can be split into separate parts (modules). Maintenance: Maintenance is monitoring and supporting the system after delivery to ensure that it continues to meet business goals. Maintenance is necessary to eliminate errors in the system during its working life and to tune the system to any variations in its working environment. During maintenance you may have to correct faults (corrective maintenance), improve performance (perfective maintenance) or to adapt the system to changing business requirements (adaptive maintenance). At the end of the maintenance phase, we obtain an improved system.

#### 6.5. Project Management

A project is a temporary endeavor to accomplish a specific objective through a unique set of interrelated tasks and the effective utilization of resources. A project is limited by its scope, time allocation and cost, called the triple constraint:

- Scope: what the project is intended to accomplish. In other words, the customer's requirements for the project.

- Time allocation: the time schedule for the project.

- Cost: the money, budget, and resources for a project. Project management is the application of knowledge, skills, tools and techniques to activities of a project for the achievement of the project's objectives. A successful project must Project management terms: Some common terns used in project management are:

- Task: A task or activity is anything that needs to be done that requires time and consumes resources.

- Dependent task: A dependent task is a task that can only begin after a previous one is finished. For example, roofing a house depends on the construction of the walls.

- Lag time: Lag time is the amount of time that passes between the end of one activity and the beginning of another if the two are dependent. For example, if task A is laying of cement blocks and dependent task B is building the walls of the house, there would be some lag time between the end of task A and the start of task B to let the blocks get dry.

- Slack time: Slack or float time is the amount of time a task can be delayed without causing a delay in the completion date of the entire project. If we have tasks A and B that start at the same time and task C that is dependent on both tasks A and B. If task A takes 3 days and task B takes 5 days, then task A has 2 days slack time. That is, it can run for 2 days before it affects the planned starting time for task C.

- Milestone: A milestone is an event that signifies the accomplishment or completion of a major deliverable during a project. A milestone could be the completion of the foundation or completion of building the walls.

- Critical task: A critical task is a task that cannot be delayed without delaying the entire project schedule. A critical task has zero slack time.

- Critical path: A critical path is a sequence of tasks that determines the earliest possible completion date of a project. Critical tasks fall on the critical path. Project Scheduling: Project scheduling is the process of converting the outline plan for a project into a time-based schedule based on the available resources and time constraints.Tools used for project scheduling are PERT chart and Gantt chart.

- PERT chart: PERT stands for Project Evaluation and Review Technique. A PERT chart is a graphic illustration of a project as a network diagram consisting of nodes representing activities in the project linked by directional lines representing durations. The direction of the arrows on the lines indicates the sequence of tasks. A PERT chart is used before the start of a project to calculate the maximum amount of time the project will need to be completed.

![](/notes/figures/part2-p011-0.png)

In the above PERT chart,

- Tasks are lettered A to G.

- Joining task A to task B shows that A must be completed before B can be started.

- Joining tasks B and C to task D means that both A and B must be completed before D can be started

- The number written on each line shows the duration of the task from which the line starts. Task A has a duration of 5, task B a duration of 8 and task C a duration of 7.

- Gantt chart: A Gantt chart is a graphic representation of project activities shown by a time-scaled bar chart. A Gantt chart is constructed with a horizontal axis representing the total time span of the project, broken down into increments (days, weeks, or months) and a vertical axis representing the tasks that make up the project. A Gantt chart is used during a project to plan out and tract specific tasks in the project.
