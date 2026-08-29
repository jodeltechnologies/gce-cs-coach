BEGIN;
-- Annual Harmonised Progression Sheet for Computer Science Form 4

INSERT INTO subjects (name) VALUES ('Computer Science') ON CONFLICT (name) DO NOTHING;
INSERT INTO levels (name, short_name) VALUES ('GCE Ordinary Level', 'O/L') ON CONFLICT (name) DO NOTHING;

INSERT INTO syllabi (
  id, subject_id, level_id, title, form_level, issuing_authority, scope, region,
  version_label, effective_from, total_weeks, weekly_periods_theory,
  weekly_periods_practical, coefficient, module_label, has_modules,
  uses_competencies, has_competency_statements, has_practical_stream
) VALUES (
  'f6da639c-8448-4c72-b3b3-9527ca764ac1',
  (SELECT id FROM subjects WHERE name = 'Computer Science'),
  (SELECT id FROM levels   WHERE name = 'GCE Ordinary Level'),
  'Annual Harmonised Progression Sheet for Computer Science Form 4', 'Form 4', 'Inspectorate General of Education, Inspectorate of Pedagogy in charge of the Teaching of Computer Science',
  'national', NULL, 'Harmonised Progression (current)',
  2025, 36,
  3, NULL,
  3, 'Module',
  true, true,
  true,
  false
);

INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('1fe1e5fa-f630-4b8e-b6c0-ad7698be1323', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', 'Problem solving and coding 2', 1);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('63d69c0c-e4a9-4126-ab58-690c8588d7b4', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', 'Data manipulation 1', 2);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('2ba43ff9-af2b-4b6e-9961-508cf803036e', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', 'Hardware and software systems 2', 3);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('5bfe6c3b-bbf9-4df3-a7c1-83185a35ed92', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', 'Ethics, society and legal issues 2', 4);

INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('53e4a124-3bfc-4889-b9d4-ecce03adceea', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '1fe1e5fa-f630-4b8e-b6c0-ad7698be1323', 'Using control structures', 'Given an algorithmic problem that requires the use of control structures, learners produce algorithms that use the appropriate control structure to solve the problem.', 1);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('5419b2d4-ba98-46a6-8c42-f9153887a81b', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '1fe1e5fa-f630-4b8e-b6c0-ad7698be1323', 'Testing and debugging', 'Given an algorithm, learners evaluate its semantic correctness using the dry-run technique and propose a way of fixing errors if any.', 2);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('3597f421-dd2e-46cc-9c7c-10228177db10', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '1fe1e5fa-f630-4b8e-b6c0-ad7698be1323', 'Setting up a programming environment', 'Given a problem, learners select the appropriate tools for programming and install them.', 3);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('74f926cb-86c4-45c4-9a32-f431c3fdd999', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '1fe1e5fa-f630-4b8e-b6c0-ad7698be1323', 'Writing of source code', 'Given an algorithm, learners transform it into a syntactically and semantically correct program.', 4);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e37a5511-5ab7-436b-89e9-ebcb89f48045', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '63d69c0c-e4a9-4126-ab58-690c8588d7b4', 'Operations on number systems', 'Presented with a situation that involves number systems, learners apply appropriate operations on number systems to solve the problem.', 5);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('6d824ed5-049b-4577-a957-1376c48ad902', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '63d69c0c-e4a9-4126-ab58-690c8588d7b4', 'Analysing simple logic circuits', 'Learners analyse a situation concerning logic circuits and determine the correct outputs and truth tables of the different elements used in the circuit.', 6);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('8df0af98-5334-4fef-9ba3-0d71e3cc09e7', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '2ba43ff9-af2b-4b6e-9961-508cf803036e', 'Optimising computer performance', 'Provided with a situation with issues related to optimising a computer, learners propose methods of optimising the computer which are coherent with the situation.', 7);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('778c8257-f3f7-4423-8a71-d3d52063db51', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '2ba43ff9-af2b-4b6e-9961-508cf803036e', 'Choosing appropriate peripheral devices', 'Learners select appropriate peripheral devices based on a situation or context. Clear justification of the choice should be made.', 8);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('f6f4ded4-deff-4bba-afb2-fa5c3354aaed', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '2ba43ff9-af2b-4b6e-9961-508cf803036e', 'Calculating storage space', 'Given a problem with factors related to storage space and units, learners determine the cause and solution to the problem showing clearly how they achieved the proposed conclusions.', 9);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('c5b2d4dd-bc9d-483e-90b2-319081018474', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '2ba43ff9-af2b-4b6e-9961-508cf803036e', 'Carrying out basic computer maintenance', 'When presented with a situation involving issues with a computer, learners propose possible causes and possible methods to fix such issues.', 10);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('a463dc7c-813a-4834-a49b-aa258bf00faf', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '2ba43ff9-af2b-4b6e-9961-508cf803036e', 'Creating digital content', 'Faced with a situation related to the creation and editing of digital content, learners propose a variety of tools that can be used to solve the problem and produce digital content using an appropriate tool.', 11);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('095a9900-70d7-4872-9475-ffcd66ea46a0', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '2ba43ff9-af2b-4b6e-9961-508cf803036e', 'Producing word processed documents', 'Given a task that is related to using a word processor to produce or reproduce content, learners use appropriate features of a word processor to achieve the task.', 12);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('6b88d553-1d9c-4382-95fb-f90f0c3f4391', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '2ba43ff9-af2b-4b6e-9961-508cf803036e', 'Manipulating spreadsheets', 'Given tasks that is related to spreadsheets and with appropriate guidance, learners choose functions or spreadsheet features that are coherent with the tasks and apply them correctly on spreadsheet software.', 13);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('ecb02d6d-3372-471f-a8ef-3d6af15c1787', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '2ba43ff9-af2b-4b6e-9961-508cf803036e', 'Understanding embedded system IoT and Cloud Computing', 'Given a situation with factors related to IoT and embedded systems, learners identify the correct type of sensors used in the situation and their role.', 14);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('2bd7f6d0-fac1-49a6-a61e-01d91c612b90', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '5bfe6c3b-bbf9-4df3-a7c1-83185a35ed92', 'Practising netiquette rules', 'Placed in a context that requires communicating with others, learners determine and apply appropriate behavioural norms that respect others and their cultural and generational diversities.', 15);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('506d5163-4bc3-4d68-9a1b-04fed74f6736', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '5bfe6c3b-bbf9-4df3-a7c1-83185a35ed92', 'Appraising National and International Laws on Cybersecurity', 'Learners state national and international laws or acts that are related to protecting and regulating activities in the cyberspace.', 16);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('132b36c1-1d3a-4462-910a-eea070333808', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '5bfe6c3b-bbf9-4df3-a7c1-83185a35ed92', 'Evaluating the credibility and reliability of information', 'Given a problem with factors related to the reliability and credibility of information, learners propose strategies of verifying the information. The strategies proposed should be pertinent, coherent, and logical.', 17);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('badb16e4-394a-4bdf-9b27-a371cf8e3c86', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', '5bfe6c3b-bbf9-4df3-a7c1-83185a35ed92', 'Avoiding computer related health issues', 'Given a problem or a situation related to avoiding computer related issues, learners evaluate the workplace, practices and habits of users based on standards and report on elements to reinforce and elements to adjust. The recommendations should express appropriate practices and health issues that can arise for not respecting these practices.', 18);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '36a82755-5cc6-4dc8-bbe0-77b05e1e9c32', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Diagnostic evaluation', 1,
  1, 1,
  true, false, false,
  'diagnostic_evaluation', 1
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7e5ccf5f-6f03-4ea5-a7e8-2cc7b831a449', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '53e4a124-3bfc-4889-b9d4-ecce03adceea', 1,
  1, 'Sequence and selection control structure', 1,
  1, 1,
  true, false, false,
  'content', 2
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7e5ccf5f-6f03-4ea5-a7e8-2cc7b831a449', 'objective', 'Explain how sequence and selection control structures work', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7e5ccf5f-6f03-4ea5-a7e8-2cc7b831a449', 'objective', 'Illustrate the functioning of sequence and selection control structures with a flowchart', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7e5ccf5f-6f03-4ea5-a7e8-2cc7b831a449', 'objective', 'Write simple algorithms that make use of a selection control structure', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c447c02e-97b8-4930-a670-66708a552c2d', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '53e4a124-3bfc-4889-b9d4-ecce03adceea', 2,
  2, 'Multiple selection constructs', 1,
  1, 1,
  true, false, false,
  'content', 3
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c447c02e-97b8-4930-a670-66708a552c2d', 'objective', 'Explain how the different types of multiple selection constructs work', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c447c02e-97b8-4930-a670-66708a552c2d', 'objective', 'Illustrate the functioning of the different multiple selection constructs', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c447c02e-97b8-4930-a670-66708a552c2d', 'objective', 'Write algorithms that make use of multiple selection control structures', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '806ff1b2-ff63-4a46-8909-7c39b853ddd9', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '53e4a124-3bfc-4889-b9d4-ecce03adceea', 3,
  3, 'Iterative constructs', 1,
  2, 2,
  true, false, false,
  'content', 4
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('806ff1b2-ff63-4a46-8909-7c39b853ddd9', 'objective', 'Identify situations where an iterative or loop control structure is needed', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('806ff1b2-ff63-4a46-8909-7c39b853ddd9', 'objective', 'Describe the 4 main parts of a loop', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('806ff1b2-ff63-4a46-8909-7c39b853ddd9', 'objective', 'Explain advantages and disadvantages of iterative control structures', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8a726dd9-a984-44f8-a367-2515a76a4f93', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '53e4a124-3bfc-4889-b9d4-ecce03adceea', 4,
  4, 'Definite iterative constructs', 1,
  2, 2,
  true, false, false,
  'content', 5
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a726dd9-a984-44f8-a367-2515a76a4f93', 'objective', 'Choose correctly when to use a definite iteration', 'evaluate', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a726dd9-a984-44f8-a367-2515a76a4f93', 'objective', 'Build definite iterations that are coherent with a given context', 'create', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a726dd9-a984-44f8-a367-2515a76a4f93', 'objective', 'Write simple algorithms that make use of definite iteration', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a2e983ae-9c0a-47ba-9d50-fa958bd26779', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '53e4a124-3bfc-4889-b9d4-ecce03adceea', 5,
  5, 'Indefinite iterative constructs', 1,
  2, 2,
  true, false, false,
  'content', 6
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a2e983ae-9c0a-47ba-9d50-fa958bd26779', 'objective', 'Differentiate between pretest and posttest indefinite iterations', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a2e983ae-9c0a-47ba-9d50-fa958bd26779', 'objective', 'Illustrate the functioning of indefinite iterations using a flowchart', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a2e983ae-9c0a-47ba-9d50-fa958bd26779', 'objective', 'Write simple algorithms that make use of indefinite iteration', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c83d92f0-4e2a-4a5f-8d08-051afbf7a540', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '53e4a124-3bfc-4889-b9d4-ecce03adceea', 6,
  6, 'Integration activities', 1,
  3, 3,
  true, false, false,
  'integration_activity', 7
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e338d3c9-06f0-434b-81d3-88db8fb39217', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '5419b2d4-ba98-46a6-8c42-f9153887a81b', 7,
  7, 'Notions on testing and debugging', 1,
  3, 3,
  true, false, false,
  'content', 8
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e338d3c9-06f0-434b-81d3-88db8fb39217', 'objective', 'Explain the concepts of testing, test case, test data and bug', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e338d3c9-06f0-434b-81d3-88db8fb39217', 'objective', 'Differentiate between testing and debugging', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e338d3c9-06f0-434b-81d3-88db8fb39217', 'objective', 'Differentiate between black box test and white box test', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3f8c652c-a9be-44aa-838b-d978ecce4be2', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '5419b2d4-ba98-46a6-8c42-f9153887a81b', 8,
  8, 'Dry running', 1,
  3, 3,
  true, false, false,
  'content', 9
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3f8c652c-a9be-44aa-838b-d978ecce4be2', 'objective', 'Explain the concepts of dry running and trace tables', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3f8c652c-a9be-44aa-838b-d978ecce4be2', 'objective', 'Perform a dry run test on an algorithm', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0d1085f6-d658-4fa2-b0f4-52a882bb95a6', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '5419b2d4-ba98-46a6-8c42-f9153887a81b', 9,
  9, 'Integration activities', 1,
  4, 4,
  true, false, false,
  'integration_activity', 10
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4d7abf6b-e969-402b-809a-911a0d107d15', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '3597f421-dd2e-46cc-9c7c-10228177db10', 10,
  10, 'Programming tools', 1,
  4, 4,
  true, false, false,
  'content', 11
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4d7abf6b-e969-402b-809a-911a0d107d15', 'objective', 'State the role of the following programming tools: text editor, translator, and IDE', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4d7abf6b-e969-402b-809a-911a0d107d15', 'objective', 'Differentiate between a compiler and an interpreter', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4d7abf6b-e969-402b-809a-911a0d107d15', 'objective', 'Explain the advantages and disadvantages of installing an IDE over separate programming tools and vice-versa', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '66d66c75-1f5d-4ffb-a8e9-ca1d4d22e5c2', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '3597f421-dd2e-46cc-9c7c-10228177db10', 11,
  11, 'Installation of programming tools', 1,
  4, 4,
  true, true, true,
  'content', 12
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('66d66c75-1f5d-4ffb-a8e9-ca1d4d22e5c2', 'objective', 'Install an IDE and use it to run a program', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('66d66c75-1f5d-4ffb-a8e9-ca1d4d22e5c2', 'objective', 'Test the functionalities of an installed programming tool', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e9378f89-c70f-4df1-b848-ba2795ab000b', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '3597f421-dd2e-46cc-9c7c-10228177db10', 12,
  12, 'Integration activities', 1,
  5, 5,
  true, false, false,
  'integration_activity', 13
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c99a6b0d-2ae5-4622-a351-164ae18b5921', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Evaluation', 1,
  5, 5,
  true, false, false,
  'evaluation', 14
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '29b134ab-e811-465f-989a-8ebb9480a8f0', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '74f926cb-86c4-45c4-9a32-f431c3fdd999', 13,
  13, 'Introduction to coding', 1,
  5, 5,
  true, false, false,
  'content', 15
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('29b134ab-e811-465f-989a-8ebb9480a8f0', 'objective', 'Explain the concept of coding', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('29b134ab-e811-465f-989a-8ebb9480a8f0', 'objective', 'Explain strategies that can be used to ease coding', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('29b134ab-e811-465f-989a-8ebb9480a8f0', 'objective', 'Identify the structure of a program in a given programming language', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd6357ba6-f169-4e09-bd22-e2e72a6ead51', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '74f926cb-86c4-45c4-9a32-f431c3fdd999', 14,
  14, 'Coding 1', 1,
  6, 6,
  true, true, true,
  'content', 16
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6357ba6-f169-4e09-bd22-e2e72a6ead51', 'objective', 'Write source code that makes use of input, output, mathematical and assignment operators', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e5fea5e3-d093-432f-875c-913f7a6f9ecd', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 1,
  6, 6,
  true, false, false,
  'remediation', 17
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bb1083e3-1c6c-4077-a97c-6c55c76fc1fe', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 1,
  6, 6,
  true, false, false,
  'remediation', 18
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '96504bdb-ac75-4a0d-ba91-a84e902db2f8', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '74f926cb-86c4-45c4-9a32-f431c3fdd999', 15,
  15, 'Coding 2', 1,
  7, 7,
  true, true, true,
  'content', 19
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('96504bdb-ac75-4a0d-ba91-a84e902db2f8', 'objective', 'Write source code that makes use of selection control structures', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ce92f361-745f-4f86-bfd9-43518d5c771f', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '74f926cb-86c4-45c4-9a32-f431c3fdd999', 16,
  16, 'Coding 3', 1,
  7, 7,
  true, true, true,
  'content', 20
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ce92f361-745f-4f86-bfd9-43518d5c771f', 'objective', 'Write source code that make use of multiple selection control structures', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '13ec20f0-2c87-4886-a1aa-cbb465898dc2', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '74f926cb-86c4-45c4-9a32-f431c3fdd999', 17,
  17, 'Coding 4', 1,
  7, 7,
  true, true, true,
  'content', 21
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('13ec20f0-2c87-4886-a1aa-cbb465898dc2', 'objective', 'Write source code that make use of definite iterative control structures', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '58c64e74-9483-4783-88b0-b6049622c8fd', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '74f926cb-86c4-45c4-9a32-f431c3fdd999', 18,
  18, 'Coding 5', 1,
  8, 8,
  true, true, true,
  'content', 22
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('58c64e74-9483-4783-88b0-b6049622c8fd', 'objective', 'Write source code that make use of indefinite iterative control structures', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '89def384-badf-42ad-b584-e0035b3348db', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '74f926cb-86c4-45c4-9a32-f431c3fdd999', 19,
  19, 'Integration activities', 1,
  8, 8,
  true, false, false,
  'integration_activity', 23
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8d65a0c9-8f5a-4472-ac3f-65378a7b36e1', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'e37a5511-5ab7-436b-89e9-ebcb89f48045', 20,
  20, 'Notions on number systems', 1,
  8, 8,
  true, false, false,
  'content', 24
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8d65a0c9-8f5a-4472-ac3f-65378a7b36e1', 'objective', 'Outline symbols of base 2, 8, 10, and 16', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8d65a0c9-8f5a-4472-ac3f-65378a7b36e1', 'objective', 'Identify symbols in a given base', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8d65a0c9-8f5a-4472-ac3f-65378a7b36e1', 'objective', 'Recognise a number in a given number system', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '52822719-36f4-4a7a-a6ee-ffec54fd2986', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'e37a5511-5ab7-436b-89e9-ebcb89f48045', 21,
  21, 'Conversion from any base to base 10', 1,
  9, 9,
  true, false, false,
  'content', 25
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('52822719-36f4-4a7a-a6ee-ffec54fd2986', 'objective', 'Explain the principle of conversion from any base to base 10', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('52822719-36f4-4a7a-a6ee-ffec54fd2986', 'objective', 'Convert from base 2, 8, and 16 to base 10', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9563246d-640c-4ba3-9573-162e4d95060b', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'e37a5511-5ab7-436b-89e9-ebcb89f48045', 22,
  22, 'Conversion from base 10 to any base', 1,
  9, 9,
  true, false, false,
  'content', 26
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9563246d-640c-4ba3-9573-162e4d95060b', 'objective', 'Explain the principle of conversion from base 10 to any base', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9563246d-640c-4ba3-9573-162e4d95060b', 'objective', 'Convert from base 10 to base 2, 8, and 16', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '600741fb-8755-4e7b-9737-f7c673cc830a', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'e37a5511-5ab7-436b-89e9-ebcb89f48045', 23,
  23, 'Conversion from base 2 to 8 and 16 and vice versa', 1,
  9, 9,
  true, false, false,
  'content', 27
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('600741fb-8755-4e7b-9737-f7c673cc830a', 'objective', 'Explain the principle of conversion from base 2 directly to base 8, and 16', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('600741fb-8755-4e7b-9737-f7c673cc830a', 'objective', 'Explain the principle of conversion from base 8 or 16 directly to base 2', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('600741fb-8755-4e7b-9737-f7c673cc830a', 'objective', 'Convert from base 2 to 8, and 16 and from base 8, and 16 to base 2', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8c346431-0eb0-422e-afd8-b233aea4747b', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'e37a5511-5ab7-436b-89e9-ebcb89f48045', 24,
  24, 'Addition and subtraction in a number system', 1,
  10, 10,
  true, false, false,
  'content', 28
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8c346431-0eb0-422e-afd8-b233aea4747b', 'objective', 'Explain the principle of addition in any number system', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8c346431-0eb0-422e-afd8-b233aea4747b', 'objective', 'Explain the principle of subtraction in any number system', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8c346431-0eb0-422e-afd8-b233aea4747b', 'objective', 'Apply the principle of addition and subtraction to add and subtract in a base 2, 8, and 16', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '52bc62f7-6718-42c0-9d0a-d88b6a9e916a', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'e37a5511-5ab7-436b-89e9-ebcb89f48045', 25,
  25, 'Integration activities', 1,
  10, 10,
  true, false, false,
  'integration_activity', 29
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '20d492cc-4d72-4ff4-b6a0-d6fe139f5f48', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6d824ed5-049b-4577-a957-1376c48ad902', 26,
  26, 'Basic logic gates', 1,
  10, 10,
  true, false, false,
  'content', 30
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20d492cc-4d72-4ff4-b6a0-d6fe139f5f48', 'objective', 'Explain the concept of logic gates and truth tables', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20d492cc-4d72-4ff4-b6a0-d6fe139f5f48', 'objective', 'Identify a given basic logic gate', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20d492cc-4d72-4ff4-b6a0-d6fe139f5f48', 'objective', 'Explain the functioning of a given basic logic gate', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20d492cc-4d72-4ff4-b6a0-d6fe139f5f48', 'objective', 'Produce the truth table of a given basic logic gate', 'apply', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b696d3d6-99b1-4132-8221-01fe6f532db5', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Evaluation', 1,
  11, 11,
  true, false, false,
  'evaluation', 31
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '90800538-8287-4715-b59e-e00624f62c59', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6d824ed5-049b-4577-a957-1376c48ad902', 27,
  27, 'Derived gates', 1,
  11, 11,
  true, false, false,
  'content', 32
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90800538-8287-4715-b59e-e00624f62c59', 'objective', 'Identify a given logic gate', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90800538-8287-4715-b59e-e00624f62c59', 'objective', 'Explain the functioning of a given logic gate', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90800538-8287-4715-b59e-e00624f62c59', 'objective', 'Produce the truth table of a given logic gate', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a357ce47-95ba-47f9-ad95-b51c9f108a74', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6d824ed5-049b-4577-a957-1376c48ad902', 28,
  28, 'Logic circuits', 1,
  11, 11,
  true, false, false,
  'content', 33
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a357ce47-95ba-47f9-ad95-b51c9f108a74', 'objective', 'Explain the concept of logic circuit', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a357ce47-95ba-47f9-ad95-b51c9f108a74', 'objective', 'Deduce the expression and truth table of a logic circuit of 2 variables', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a357ce47-95ba-47f9-ad95-b51c9f108a74', 'objective', 'Draw the logic circuit of a logic expression of 2 variables', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4e2ad01d-0ac6-40f5-b9de-3762922bda3d', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6d824ed5-049b-4577-a957-1376c48ad902', 29,
  29, 'Integration activities', 1,
  12, 12,
  true, false, false,
  'integration_activity', 34
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6d55c5d0-d95d-48bc-9f65-09eb52a2bc5a', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 1,
  12, 12,
  true, false, false,
  'remediation', 35
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c7ad35ec-2d52-4be1-a02e-d9b9036026ad', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 1,
  12, 12,
  true, false, false,
  'remediation', 36
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '882f3770-9914-4954-8fbc-2dda9949906f', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '8df0af98-5334-4fef-9ba3-0d71e3cc09e7', 30,
  30, 'Software methods for optimising the computer', 2,
  13, 13,
  true, false, false,
  'content', 37
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('882f3770-9914-4954-8fbc-2dda9949906f', 'objective', 'Outline common software for optimising the performance of a computer', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('882f3770-9914-4954-8fbc-2dda9949906f', 'objective', 'Explain the following concepts and how they affect the performance of a computer: malware, fragmentation, defragmentation', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('882f3770-9914-4954-8fbc-2dda9949906f', 'objective', 'Explain how antivirus, disk defragmenter, disk cleaner, and operating system configurations can improve the performance of a computer', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '62ff049a-1753-41d7-977d-cb1f21ab2a78', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '8df0af98-5334-4fef-9ba3-0d71e3cc09e7', 31,
  31, 'Hardware methods for optimising the computer', 2,
  13, 13,
  true, false, false,
  'content', 38
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62ff049a-1753-41d7-977d-cb1f21ab2a78', 'objective', 'Explain how size of RAM and disk can improve computer performance', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62ff049a-1753-41d7-977d-cb1f21ab2a78', 'objective', 'Explain how SSDs improve computer performance compared to HDDs', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62ff049a-1753-41d7-977d-cb1f21ab2a78', 'objective', 'Explain hardware related methods for improving computer performance', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '13208375-3ab1-455b-a0f3-32bd6237d9e5', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '8df0af98-5334-4fef-9ba3-0d71e3cc09e7', 32,
  32, 'Integration activities', 2,
  13, 13,
  true, false, false,
  'integration_activity', 39
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9cf3c41d-5ec0-48ee-9d45-1ce1aed6fc3a', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '778c8257-f3f7-4423-8a71-d3d52063db51', 33,
  33, 'Input peripherals', 2,
  14, 14,
  true, false, false,
  'content', 40
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9cf3c41d-5ec0-48ee-9d45-1ce1aed6fc3a', 'objective', 'State the purpose of a given input peripheral device', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9cf3c41d-5ec0-48ee-9d45-1ce1aed6fc3a', 'objective', 'Describe the characteristics of a given input peripheral device', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9cf3c41d-5ec0-48ee-9d45-1ce1aed6fc3a', 'objective', 'Choose appropriate input peripheral in a given context', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6ec3b238-2a7d-45da-9e20-30ae4b18b934', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '778c8257-f3f7-4423-8a71-d3d52063db51', 34,
  34, 'Output peripherals', 2,
  14, 14,
  true, false, false,
  'content', 41
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ec3b238-2a7d-45da-9e20-30ae4b18b934', 'objective', 'State the purpose of a given output peripheral device', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ec3b238-2a7d-45da-9e20-30ae4b18b934', 'objective', 'Describe the characteristics of a given output peripheral device', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ec3b238-2a7d-45da-9e20-30ae4b18b934', 'objective', 'Choose appropriate output peripheral in a given context', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dc562ffa-429f-4325-9967-d511d2ae6f08', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '778c8257-f3f7-4423-8a71-d3d52063db51', 35,
  35, 'Integration activities', 2,
  14, 14,
  true, false, false,
  'integration_activity', 42
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3bddb2d6-41ed-44a9-b37a-c85584ad09d2', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'f6f4ded4-deff-4bba-afb2-fa5c3354aaed', 36,
  36, 'Units of storage', 2,
  15, 15,
  true, false, false,
  'content', 43
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3bddb2d6-41ed-44a9-b37a-c85584ad09d2', 'objective', 'Explain the concepts of storage, and storage units', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3bddb2d6-41ed-44a9-b37a-c85584ad09d2', 'objective', 'State units of storage and the relationship between these units', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3bddb2d6-41ed-44a9-b37a-c85584ad09d2', 'objective', 'Explain the read and write operations on storage', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8d96afae-7be4-4d70-bcc3-3bd1d470b1fa', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'f6f4ded4-deff-4bba-afb2-fa5c3354aaed', 37,
  37, 'Conversion between units of storage', 2,
  15, 15,
  true, false, false,
  'content', 44
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8d96afae-7be4-4d70-bcc3-3bd1d470b1fa', 'objective', 'Explain how to convert from a given unit to another', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8d96afae-7be4-4d70-bcc3-3bd1d470b1fa', 'objective', 'Convert between units of storage', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '346638d2-4f79-4c4a-a913-47dfdf4588a9', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'f6f4ded4-deff-4bba-afb2-fa5c3354aaed', 38,
  38, 'Integration activities', 2,
  15, 15,
  true, false, false,
  'integration_activity', 45
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7e455652-b4e2-445c-909a-ee7b6272b5a8', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'c5b2d4dd-bc9d-483e-90b2-319081018474', 39,
  39, 'Notions on computer maintenance', 2,
  16, 16,
  true, false, false,
  'content', 46
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7e455652-b4e2-445c-909a-ee7b6272b5a8', 'objective', 'Explain the concepts of maintenance, hardware maintenance, software maintenance, preventive maintenance, and corrective maintenance', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7e455652-b4e2-445c-909a-ee7b6272b5a8', 'objective', 'Classify maintenance problems into hardware and software', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7e455652-b4e2-445c-909a-ee7b6272b5a8', 'objective', 'Classify solutions into preventive and corrective maintenance', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3923f5e5-aec9-45a8-8ba1-f69c9c81f297', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'c5b2d4dd-bc9d-483e-90b2-319081018474', 40,
  40, 'Hardware maintenance', 2,
  16, 16,
  true, false, false,
  'content', 47
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3923f5e5-aec9-45a8-8ba1-f69c9c81f297', 'objective', 'Match symptoms to a given hardware problem', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3923f5e5-aec9-45a8-8ba1-f69c9c81f297', 'objective', 'Determine appropriate and logical means of solving a given hardware problem', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3923f5e5-aec9-45a8-8ba1-f69c9c81f297', 'objective', 'Explain common preventive maintenance tips', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7235ff85-85f8-4a41-8cc3-aeaaf8dd1330', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'c5b2d4dd-bc9d-483e-90b2-319081018474', 41,
  41, 'Software maintenance', 2,
  16, 16,
  true, false, false,
  'content', 48
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7235ff85-85f8-4a41-8cc3-aeaaf8dd1330', 'objective', 'Match symptoms to a given software problem', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7235ff85-85f8-4a41-8cc3-aeaaf8dd1330', 'objective', 'Determine appropriate and logical means of solving a given software problem', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7235ff85-85f8-4a41-8cc3-aeaaf8dd1330', 'objective', 'Explain common preventive maintenance tips', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '96eefed9-dd78-4127-b0d9-6a33ea014c53', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'c5b2d4dd-bc9d-483e-90b2-319081018474', 42,
  42, 'Integration activities', 2,
  17, 17,
  true, false, false,
  'integration_activity', 49
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'da7cab62-4946-436b-a67a-7990ecdc755a', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Evaluation', 2,
  17, 17,
  true, false, false,
  'evaluation', 50
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6bf78a3a-8bce-4b81-99a6-e3c94e0a88a0', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 43,
  43, 'Types of Digital content and File formats', 2,
  17, 17,
  true, false, false,
  'content', 51
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6bf78a3a-8bce-4b81-99a6-e3c94e0a88a0', 'objective', 'Describe the different types of digital content', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6bf78a3a-8bce-4b81-99a6-e3c94e0a88a0', 'objective', 'Identify common types of digital content and their file formats', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6bf78a3a-8bce-4b81-99a6-e3c94e0a88a0', 'objective', 'Differentiate between multimedia and hypermedia', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '481a10c9-f703-4483-8042-472f44d5ec4c', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 44,
  44, 'Tools for creating digital content', 2,
  18, 18,
  true, false, false,
  'content', 52
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('481a10c9-f703-4483-8042-472f44d5ec4c', 'objective', 'Identify appropriate tools for producing digital content of a given type', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('481a10c9-f703-4483-8042-472f44d5ec4c', 'objective', 'State AI tools for producing digital content', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('481a10c9-f703-4483-8042-472f44d5ec4c', 'objective', 'Outline methods for creating digital content', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dd42b3fa-1b33-4e76-98c6-0bbcf35ed491', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 2,
  18, 18,
  true, false, false,
  'remediation', 53
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '42dcb5a4-decf-4783-ae42-6707a0d5d339', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 2,
  18, 18,
  true, false, false,
  'remediation', 54
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'df256845-4642-4cd8-bde5-844df26e52de', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 45,
  45, 'Creation of audio content', 2,
  19, 19,
  true, true, true,
  'content', 55
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('df256845-4642-4cd8-bde5-844df26e52de', 'objective', 'Produce audio content using hardware tools', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('df256845-4642-4cd8-bde5-844df26e52de', 'objective', 'Produce audio content using software tools', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '38cdf986-1126-4083-8097-217c86beb28e', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 46,
  46, 'Creation of image content', 2,
  19, 19,
  true, true, true,
  'content', 56
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('38cdf986-1126-4083-8097-217c86beb28e', 'objective', 'Produce image content using hardware tools', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('38cdf986-1126-4083-8097-217c86beb28e', 'objective', 'Produce image content using software tools', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7d92e370-5a09-437f-9058-b8c316c5a496', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 47,
  47, 'Creation of multimedia content 1', 2,
  19, 19,
  true, true, true,
  'content', 57
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7d92e370-5a09-437f-9058-b8c316c5a496', 'objective', 'Produce multimedia content using hardware tools', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7d92e370-5a09-437f-9058-b8c316c5a496', 'objective', 'Produce multimedia content using software tools', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c09eb7f8-6298-4cd9-916f-1f016f929f87', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 48,
  48, 'Creation of multimedia content 2', 2,
  20, 20,
  true, true, true,
  'content', 58
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c09eb7f8-6298-4cd9-916f-1f016f929f87', 'objective', 'Combine text, audio, image using an appropriate tool to produce a video', 'create', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '15fb751e-9926-4fc0-9d03-34a08af7b8dc', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 49,
  49, 'Creation of hypermedia content 1', 2,
  20, 20,
  true, true, true,
  'content', 59
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('15fb751e-9926-4fc0-9d03-34a08af7b8dc', 'objective', 'Identify the necessary technologies to create hypermedia content', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('15fb751e-9926-4fc0-9d03-34a08af7b8dc', 'objective', 'Create hypermedia content with the help of html, CSS, JavaScript, etc', 'create', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a458e461-12a4-4ac5-bb80-ba2b76552852', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 50,
  50, 'Creation of hypermedia content 2', 2,
  20, 20,
  true, true, true,
  'content', 60
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a458e461-12a4-4ac5-bb80-ba2b76552852', 'objective', 'Create hypermedia content with the help of html, CSS, JavaScript, etc', 'create', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'aea89e84-16c9-4aff-8f5e-cf588152b05c', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 51,
  51, 'Creation of hypermedia content 3', 2,
  21, 21,
  true, true, true,
  'content', 61
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('aea89e84-16c9-4aff-8f5e-cf588152b05c', 'objective', 'Create hypermedia content with the help of html, CSS, JavaScript, etc', 'create', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6e03a379-1041-4700-9b76-197759958c56', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 52,
  52, 'Integration activities', 2,
  21, 21,
  true, false, false,
  'integration_activity', 62
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '552a4424-66bd-4dae-b20b-9ebbcf5f3ac6', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'a463dc7c-813a-4834-a49b-aa258bf00faf', 53,
  53, 'Integration activities', 2,
  21, 21,
  true, false, false,
  'integration_activity', 63
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a1efed65-cdba-4c99-8711-bb427231e09d', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '095a9900-70d7-4872-9475-ffcd66ea46a0', 54,
  54, 'Features of a word processor', 2,
  22, 22,
  true, true, true,
  'content', 64
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a1efed65-cdba-4c99-8711-bb427231e09d', 'objective', 'Choose appropriate word processor features for a given task', 'evaluate', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a1efed65-cdba-4c99-8711-bb427231e09d', 'objective', 'Perform basic formatting', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8131857c-26e7-48e1-a124-7329321b4226', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '095a9900-70d7-4872-9475-ffcd66ea46a0', 55,
  55, 'Common operations on a page', 2,
  22, 22,
  true, true, true,
  'content', 65
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8131857c-26e7-48e1-a124-7329321b4226', 'objective', 'Explain what is meant by page layout', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8131857c-26e7-48e1-a124-7329321b4226', 'objective', 'Perform basic operations on a page', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd2cfd703-0dc7-43c8-a50e-b1afc67712ba', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '095a9900-70d7-4872-9475-ffcd66ea46a0', 56,
  56, 'Operations on tables', 2,
  22, 22,
  true, true, true,
  'content', 66
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d2cfd703-0dc7-43c8-a50e-b1afc67712ba', 'objective', 'Create tables of different rows and columns using a word processor', 'create', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d2cfd703-0dc7-43c8-a50e-b1afc67712ba', 'objective', 'Perform operations on tables (add, delete, resize)', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fc5423ac-0536-409b-811a-79c94a29894f', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '095a9900-70d7-4872-9475-ffcd66ea46a0', 57,
  57, 'Integration activities', 2,
  23, 23,
  true, false, false,
  'integration_activity', 67
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cb1fce4a-ec76-416a-8277-a7e81a46967e', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '095a9900-70d7-4872-9475-ffcd66ea46a0', 58,
  58, 'Integration activities', 2,
  23, 23,
  true, false, false,
  'integration_activity', 68
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ffb55712-d623-4368-ae28-d32cf9916e59', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Evaluation', 2,
  23, 23,
  true, false, false,
  'evaluation', 69
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '64c7a7ea-cc66-4020-b661-1cbaa14027b6', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6b88d553-1d9c-4382-95fb-f90f0c3f4391', 59,
  59, 'Notions on cell referencing', 2,
  24, 24,
  true, false, false,
  'content', 70
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('64c7a7ea-cc66-4020-b661-1cbaa14027b6', 'objective', 'Explain the concepts of cells, formula, ranges, and cell reference', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('64c7a7ea-cc66-4020-b661-1cbaa14027b6', 'objective', 'Differentiate between the different types of cell referencing', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('64c7a7ea-cc66-4020-b661-1cbaa14027b6', 'objective', 'Identify when to use a given type of cell referencing', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd0922015-5222-47b5-a128-ecfd6fa3d340', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 2,
  24, 24,
  true, false, false,
  'remediation', 71
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9afc5d38-bd95-4680-a55d-345267771720', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 2,
  24, 24,
  true, false, false,
  'remediation', 72
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '914b3367-3871-42d3-bd62-4e964676757f', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6b88d553-1d9c-4382-95fb-f90f0c3f4391', 60,
  60, 'Operations using different types of cell referencing', 3,
  25, 25,
  true, true, true,
  'content', 73
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('914b3367-3871-42d3-bd62-4e964676757f', 'objective', 'Perform operations (sum, average, product, count) using different types of cell referencing', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ba91adc4-0915-4bf6-a42a-24c4a23bdac5', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6b88d553-1d9c-4382-95fb-f90f0c3f4391', 61,
  61, 'Conditional functions: IF function 1', 3,
  25, 25,
  true, true, true,
  'content', 74
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ba91adc4-0915-4bf6-a42a-24c4a23bdac5', 'objective', 'Describe the IF function', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ba91adc4-0915-4bf6-a42a-24c4a23bdac5', 'objective', 'Identify when to use the IF function', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ba91adc4-0915-4bf6-a42a-24c4a23bdac5', 'objective', 'Solve variety of problems using the IF function', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a9e4e58e-02bb-4606-9509-e68954a929a8', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6b88d553-1d9c-4382-95fb-f90f0c3f4391', 62,
  62, 'Conditional functions: IF function 2', 3,
  25, 25,
  true, true, true,
  'content', 75
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a9e4e58e-02bb-4606-9509-e68954a929a8', 'objective', 'Solve variety of problems using the IF function', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '34d7212b-f541-4ac3-b30f-bfd4d02ebe3d', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6b88d553-1d9c-4382-95fb-f90f0c3f4391', 63,
  63, 'Conditional functions: SUMIF, PRODUCTIF', 3,
  26, 26,
  true, true, true,
  'content', 76
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34d7212b-f541-4ac3-b30f-bfd4d02ebe3d', 'objective', 'Describe the SUMIF, and PRODUCTIF functions', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34d7212b-f541-4ac3-b30f-bfd4d02ebe3d', 'objective', 'Identify when to use the SUMIF, and PRODUCTIF function', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34d7212b-f541-4ac3-b30f-bfd4d02ebe3d', 'objective', 'Solve a problem that uses the SUMIF, and PRODUCTIF', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3500f60a-6169-4588-a699-c570250b5dae', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6b88d553-1d9c-4382-95fb-f90f0c3f4391', 64,
  64, 'Conditional functions: COUNTIF, AVERAGEIF', 3,
  26, 26,
  true, true, true,
  'content', 77
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3500f60a-6169-4588-a699-c570250b5dae', 'objective', 'Describe the COUNTIF, AVERAGEIF functions', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3500f60a-6169-4588-a699-c570250b5dae', 'objective', 'Identify when to use the COUNTIF, AVERAGEIF function', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3500f60a-6169-4588-a699-c570250b5dae', 'objective', 'Solve a problem that uses the COUNTIF, AVERAGEIF', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dedb124b-8e62-4acc-b09f-f0c5c370661d', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6b88d553-1d9c-4382-95fb-f90f0c3f4391', 65,
  65, 'Represent data using charts', 3,
  26, 26,
  true, true, true,
  'content', 78
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dedb124b-8e62-4acc-b09f-f0c5c370661d', 'objective', 'Identify the different types of charts', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dedb124b-8e62-4acc-b09f-f0c5c370661d', 'objective', 'Represent data using charts', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dedb124b-8e62-4acc-b09f-f0c5c370661d', 'objective', 'Perform simple formatting on charts', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e5e413fb-56d8-4b2b-a733-37731e3c91ae', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6b88d553-1d9c-4382-95fb-f90f0c3f4391', 66,
  66, 'Integration activities', 3,
  27, 27,
  true, false, false,
  'integration_activity', 79
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'de9885ff-24f5-407f-a869-5bda43e904fd', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '6b88d553-1d9c-4382-95fb-f90f0c3f4391', 67,
  67, 'Integration activities', 3,
  27, 27,
  true, false, false,
  'integration_activity', 80
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dd03f920-2320-425c-8673-e5561853c17c', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'ecb02d6d-3372-471f-a8ef-3d6af15c1787', 68,
  68, 'Types of sensors', 3,
  27, 27,
  true, false, false,
  'content', 81
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dd03f920-2320-425c-8673-e5561853c17c', 'objective', 'Explain the concept of sensors, and actuators', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dd03f920-2320-425c-8673-e5561853c17c', 'objective', 'State the different types of sensor and their roles', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dd03f920-2320-425c-8673-e5561853c17c', 'objective', 'Outline situations in life where a given type of sensor can be used', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '60107990-8a37-47fe-97cf-808751ef99be', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'ecb02d6d-3372-471f-a8ef-3d6af15c1787', 69,
  69, 'Embedded systems and IoT', 3,
  28, 28,
  true, false, false,
  'content', 82
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('60107990-8a37-47fe-97cf-808751ef99be', 'objective', 'Differentiate between embedded systems, IoT, and cloud computing', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('60107990-8a37-47fe-97cf-808751ef99be', 'objective', 'Describe scenarios where IoT and embedded systems are used in life', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9f13271a-5cef-4433-865e-cf4392043682', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'ecb02d6d-3372-471f-a8ef-3d6af15c1787', 70,
  70, 'Cloud computing', 3,
  28, 28,
  true, false, false,
  'content', 83
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9f13271a-5cef-4433-865e-cf4392043682', 'objective', 'Explain the concept of cloud computing', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9f13271a-5cef-4433-865e-cf4392043682', 'objective', 'Outline the 3 main types of cloud services with examples', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9f13271a-5cef-4433-865e-cf4392043682', 'objective', 'Describe how embedded systems and IoT relate to cloud computing', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ed9c8f08-ac8d-4860-97be-cfc706f7ebfb', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'ecb02d6d-3372-471f-a8ef-3d6af15c1787', 71,
  71, 'Integration activities', 3,
  28, 28,
  true, false, false,
  'integration_activity', 84
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd7cc75fd-e2aa-4f7a-a3d7-db4b76645733', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Evaluation', 3,
  29, 29,
  true, false, false,
  'evaluation', 85
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd6739bf1-289c-4cce-b844-5e80e68265f9', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '2bd7f6d0-fac1-49a6-a61e-01d91c612b90', 72,
  72, 'Notions on netiquette', 3,
  29, 29,
  true, false, false,
  'content', 86
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6739bf1-289c-4cce-b844-5e80e68265f9', 'objective', 'Explain the concepts of netiquette, and empathy', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6739bf1-289c-4cce-b844-5e80e68265f9', 'objective', 'State codes of conduct for posting and sharing content online', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6739bf1-289c-4cce-b844-5e80e68265f9', 'objective', 'Explain the importance of empathy, awareness in cultural and generational diversities when communicating online', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '222dbde4-42d7-4d7e-a7f6-9dd3555d3098', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '2bd7f6d0-fac1-49a6-a61e-01d91c612b90', 73,
  73, 'Emojis', 3,
  29, 29,
  true, false, false,
  'content', 87
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('222dbde4-42d7-4d7e-a7f6-9dd3555d3098', 'objective', 'Differentiate emojis from emoticon', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('222dbde4-42d7-4d7e-a7f6-9dd3555d3098', 'objective', 'Give the meaning of common emojis', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('222dbde4-42d7-4d7e-a7f6-9dd3555d3098', 'objective', 'Explain why it is important to know the meaning of an emoji before using it', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '003072f9-a8f0-44ca-bba9-a16e23d1e753', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 3,
  30, 30,
  true, false, false,
  'remediation', 88
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cc0a0195-4884-40f0-bce3-40127aae21c2', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 3,
  30, 30,
  true, false, false,
  'remediation', 89
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f793e713-b9c9-4fb4-b8fc-89389094e1c7', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '2bd7f6d0-fac1-49a6-a61e-01d91c612b90', 74,
  74, 'Communicating responsibly online', 3,
  30, 30,
  true, false, false,
  'content', 90
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f793e713-b9c9-4fb4-b8fc-89389094e1c7', 'objective', 'Choose communication modes and strategies adapted to an audience', 'evaluate', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f793e713-b9c9-4fb4-b8fc-89389094e1c7', 'objective', 'Identify hostile or derogatory messages or activities online that attack an individual or groups of individuals', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f793e713-b9c9-4fb4-b8fc-89389094e1c7', 'objective', 'Propose behavioural rules when using digital technologies in a context', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c8820e77-9f87-4509-8e25-c4708d7fba57', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '2bd7f6d0-fac1-49a6-a61e-01d91c612b90', 75,
  75, 'Integration activities', 3,
  31, 31,
  true, false, false,
  'integration_activity', 91
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '45395d95-9491-4852-b878-8ce4578ea834', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '506d5163-4bc3-4d68-9a1b-04fed74f6736', 76,
  76, 'International laws or acts on digital technology', 3,
  31, 31,
  true, false, false,
  'content', 92
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('45395d95-9491-4852-b878-8ce4578ea834', 'objective', 'Explain the importance of laws and acts to regulate activities related to the creation and use of data and digital technologies', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('45395d95-9491-4852-b878-8ce4578ea834', 'objective', 'Outline international laws and acts related to the use of digital technology', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('45395d95-9491-4852-b878-8ce4578ea834', 'objective', 'State the purpose of a given international law or act', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '70201fe9-8744-4a42-8aeb-29ccfad18205', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '506d5163-4bc3-4d68-9a1b-04fed74f6736', 77,
  77, 'National laws or policies on digital technology', 3,
  31, 31,
  true, false, false,
  'content', 93
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70201fe9-8744-4a42-8aeb-29ccfad18205', 'objective', 'State national laws or policies aimed at regulating the use of digital technology in Cameroon and their respective goals', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70201fe9-8744-4a42-8aeb-29ccfad18205', 'objective', 'Discuss some elements of law No 2010-12 of 21st December', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70201fe9-8744-4a42-8aeb-29ccfad18205', 'objective', 'State penalties of some information and communication technology malpractice in Cameroon', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '34e3b352-69c5-499c-8ef9-5b8769bc3131', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '506d5163-4bc3-4d68-9a1b-04fed74f6736', 78,
  78, 'National and international bodies regulating the use of ICT', 3,
  32, 32,
  true, false, false,
  'content', 94
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34e3b352-69c5-499c-8ef9-5b8769bc3131', 'objective', 'Outline international bodies that regulate the use of ICT and their respective goals', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34e3b352-69c5-499c-8ef9-5b8769bc3131', 'objective', 'Outline national bodies in Cameroon that regulate the use of ICT and their respective goals', 'remember', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '581906b6-8e96-46b0-a775-e6cfff2264ca', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '506d5163-4bc3-4d68-9a1b-04fed74f6736', 79,
  79, 'Integration activities', 3,
  32, 32,
  true, false, false,
  'integration_activity', 95
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '306605a4-5a74-432f-9691-2d64e8fc07fa', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '132b36c1-1d3a-4462-910a-eea070333808', 80,
  80, 'Notions on misinformation and disinformation', 3,
  32, 32,
  true, false, false,
  'content', 96
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('306605a4-5a74-432f-9691-2d64e8fc07fa', 'objective', 'Differentiate between misinformation and disinformation', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('306605a4-5a74-432f-9691-2d64e8fc07fa', 'objective', 'State factors of information biases (data algorithms, censorship, editorial choices, personal limitations)', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('306605a4-5a74-432f-9691-2d64e8fc07fa', 'objective', 'Explain the concepts of misinformation, disinformation, deepfake, infodemic, clickbait', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '51c1ffbe-edf4-43e5-b324-ef936088c2e2', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '132b36c1-1d3a-4462-910a-eea070333808', 81,
  81, 'Analysis of online information', 3,
  33, 33,
  true, false, false,
  'content', 97
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('51c1ffbe-edf4-43e5-b324-ef936088c2e2', 'objective', 'Identify the author and source of a given information found online', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('51c1ffbe-edf4-43e5-b324-ef936088c2e2', 'objective', 'Identify sponsored content online', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('51c1ffbe-edf4-43e5-b324-ef936088c2e2', 'objective', 'Analyse information in order to detect its purpose or interest', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '738cc764-d802-4ff5-b354-7ff9aaba3fec', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '132b36c1-1d3a-4462-910a-eea070333808', 82,
  82, 'Identifying the credibility of information', 3,
  33, 33,
  true, false, false,
  'content', 98
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('738cc764-d802-4ff5-b354-7ff9aaba3fec', 'objective', 'Explain strategies for verifying the credibility and reliability of information', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('738cc764-d802-4ff5-b354-7ff9aaba3fec', 'objective', 'Propose national and international sources of getting credible information', 'evaluate', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '11c04bf8-6035-479e-9d86-de71abb5adf3', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, '132b36c1-1d3a-4462-910a-eea070333808', 83,
  83, 'Integration activities', 3,
  33, 33,
  true, false, false,
  'integration_activity', 99
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '525d9a76-791c-40a9-a156-48e759bfe920', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'badb16e4-394a-4bdf-9b27-a371cf8e3c86', 84,
  84, 'Computer related health hazards', 3,
  34, 34,
  true, false, false,
  'content', 100
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('525d9a76-791c-40a9-a156-48e759bfe920', 'objective', 'Describe different types of computer related health hazards', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('525d9a76-791c-40a9-a156-48e759bfe920', 'objective', 'Outline major causes of computer related health hazards', 'remember', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c189aa92-ed19-4d85-a0f1-30db15f474ff', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'badb16e4-394a-4bdf-9b27-a371cf8e3c86', 85,
  85, 'Computer ergonomics: best practices in the design of items and workplace setup', 3,
  34, 34,
  true, false, false,
  'content', 101
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c189aa92-ed19-4d85-a0f1-30db15f474ff', 'objective', 'Identify wrong equipment placement and design in a computing environment', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c189aa92-ed19-4d85-a0f1-30db15f474ff', 'objective', 'Explain how the design of equipment and workplace setup can help prevent computer related health injuries', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7fe08cb0-abd5-475d-ad6d-038b4fc25db5', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'badb16e4-394a-4bdf-9b27-a371cf8e3c86', 86,
  86, 'Computer ergonomics: workplace habits and exercises', 3,
  34, 34,
  true, false, false,
  'content', 102
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7fe08cb0-abd5-475d-ad6d-038b4fc25db5', 'objective', 'Identify wrong user posture and habits in a computing environment', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7fe08cb0-abd5-475d-ad6d-038b4fc25db5', 'objective', 'Explain how the workplace habits and exercises can help prevent computer related health injuries', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a018e421-f05e-4d21-bb3f-178033340c4f', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'badb16e4-394a-4bdf-9b27-a371cf8e3c86', 87,
  87, 'Integration activities', 3,
  35, 35,
  true, false, false,
  'integration_activity', 103
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e19cab83-385b-4a5e-88ed-a07803c2c05f', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, 'badb16e4-394a-4bdf-9b27-a371cf8e3c86', 88,
  88, 'Integration activities', 3,
  35, 35,
  true, false, false,
  'integration_activity', 104
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bf5c3a2e-bb53-427e-ae0c-b1380eecec4c', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Evaluation', 3,
  35, 35,
  true, false, false,
  'evaluation', 105
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'db838ae4-974f-452c-a2cb-c89150389efd', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 3,
  36, 36,
  true, false, false,
  'remediation', 106
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd14fd752-b856-48ec-9c6b-3c0ba4a63312', 'f6da639c-8448-4c72-b3b3-9527ca764ac1', NULL, NULL, NULL,
  NULL, 'Remediation', 3,
  36, 36,
  true, false, false,
  'remediation', 107
);

COMMIT;
