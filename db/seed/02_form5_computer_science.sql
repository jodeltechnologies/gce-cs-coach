BEGIN;
-- Annual Harmonised Progression Sheet for Form 5

INSERT INTO subjects (name) VALUES ('Computer Science') ON CONFLICT (name) DO NOTHING;
INSERT INTO levels (name, short_name) VALUES ('GCE Ordinary Level', 'O/L') ON CONFLICT (name) DO NOTHING;

INSERT INTO syllabi (
  id, subject_id, level_id, title, form_level, issuing_authority, scope, region,
  version_label, effective_from, total_weeks, weekly_periods_theory,
  weekly_periods_practical, coefficient, module_label, has_modules,
  uses_competencies, has_competency_statements, has_practical_stream
) VALUES (
  '0a48b345-b974-4dd4-940b-fb547d9a63dc',
  (SELECT id FROM subjects WHERE name = 'Computer Science'),
  (SELECT id FROM levels   WHERE name = 'GCE Ordinary Level'),
  'Annual Harmonised Progression Sheet for Form 5', 'Form 5', 'Inspectorate General of Education, Inspectorate of Pedagogy in charge of the Teaching of Computer Science',
  'national', NULL, 'Harmonised Progression (current)',
  2025, 36,
  NULL, NULL,
  NULL, 'Module',
  false, true,
  false,
  false
);

INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('69e98690-60cd-470b-9f9c-47ffe14c0d24', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Describing data structure', NULL, 1);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('1a18cd5d-4b6a-4936-8593-4d45cfb03c59', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Describing programming paradigms', NULL, 2);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('3c6f2ba3-a2b6-44b8-84c7-ae2bf31cd78b', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Writing algorithms', NULL, 3);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('f9f3dc3e-369f-4a8a-ae8c-261ed46eb77b', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Converting an algorithm into a program', NULL, 4);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('eb4bacfa-742e-4d25-9d5d-dc321eab6c2b', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Describing peripheral devices', NULL, 5);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('dd3f934d-4c11-4662-9119-f45c018b5ff5', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Describing internal components of the computer', NULL, 6);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('b9c54e29-d747-44e0-90a6-7ab6e8a26da9', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Getting application software', NULL, 7);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e588f2ae-e85b-480e-a251-48bd8683e05a', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Describing ways of acquiring and distributing software', NULL, 8);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('5af4df75-ed61-4fe1-b104-6c0bb411f4ff', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Creating digital content using software', NULL, 9);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('97ea7831-f07a-4ebf-9e16-c185257b78ec', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Proposing assistive technology for social inclusion', NULL, 10);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('1aa47daf-a2a9-43e3-9268-07fa141e8c15', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Setting up LANS and classifying hardware for networks', NULL, 11);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('d13d4470-c7aa-46ef-a0d0-ebdb6250cf6d', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Exploring concepts related to data communication', NULL, 12);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('b3e5a87f-98d0-43ab-a4f8-c69e43546fc4', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Working on the internet', NULL, 13);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('b142cead-0774-4443-a2e1-a2751e3a9c88', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Social networks', NULL, 14);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('0847312e-e473-406d-b806-321ccf039b81', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Securing data, computers, and networks', NULL, 15);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('d88e9c24-0e19-491a-99a9-e7b488173993', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Evaluating the impacts of digital identities and digital footprints', NULL, 16);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e2807d84-afc8-46d8-9c14-848b59206fcf', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Examine licenses and copyright practices', NULL, 17);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('ee21728f-1433-494c-9237-b0a9cf939cd4', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Representing data in the computer', NULL, 18);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('a177800a-28e2-473a-a085-0efd8dbf8096', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Analyzing simple logic circuits and expressions', NULL, 19);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('1be43d53-925a-4322-ab51-a1c82ba64cbc', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Evaluating an information system', NULL, 20);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('b72a0c1a-be68-4784-a743-d850f127d47e', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Designing and implementing simple databases', NULL, 21);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('cdceb923-8ea0-4981-a6ab-1e177e4330f3', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Developing a system', NULL, 22);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('8cb52cb7-92d5-4cf6-b1a2-11d445582b62', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'Managing projects', NULL, 23);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '711e680e-a937-467c-9da3-480afc5118a5', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, 0,
  0, 'Diagnostic evaluation', 1,
  1, 1,
  true, false, false,
  'diagnostic_evaluation', 1
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '949bf0d6-bd49-48ef-9fba-076112109bc2', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '69e98690-60cd-470b-9f9c-47ffe14c0d24', 1,
  1, 'Simple data types', 1,
  1, 1,
  true, false, false,
  'content', 2
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('949bf0d6-bd49-48ef-9fba-076112109bc2', 'objective', 'Explain the concept of data type', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('949bf0d6-bd49-48ef-9fba-076112109bc2', 'objective', 'Describe simple data types', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('949bf0d6-bd49-48ef-9fba-076112109bc2', 'objective', 'Choose appropriate simple data type for a given situation', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3a5c510c-7d60-498b-80dd-8c9948033c5f', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '69e98690-60cd-470b-9f9c-47ffe14c0d24', 2,
  2, 'Data structures', 1,
  1, 1,
  true, false, false,
  'content', 3
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3a5c510c-7d60-498b-80dd-8c9948033c5f', 'objective', 'Differentiate between data type and data structure', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3a5c510c-7d60-498b-80dd-8c9948033c5f', 'objective', 'Describe the different data structures', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3a5c510c-7d60-498b-80dd-8c9948033c5f', 'objective', 'Select appropriate data structure for a given situation', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '306c1c22-ad63-4340-a074-316f0344f19c', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '69e98690-60cd-470b-9f9c-47ffe14c0d24', 3,
  3, 'Integration activities', 1,
  1, 1,
  true, false, false,
  'integration_activity', 4
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4a08436f-9eaf-4f09-a1f7-08f13af445a2', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1a18cd5d-4b6a-4936-8593-4d45cfb03c59', 4,
  4, 'Notions on programming paradigms', 1,
  2, 2,
  true, false, false,
  'content', 5
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4a08436f-9eaf-4f09-a1f7-08f13af445a2', 'objective', 'Explain the concept of programming paradigms', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4a08436f-9eaf-4f09-a1f7-08f13af445a2', 'objective', 'Describe different types of programming paradigms', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4a08436f-9eaf-4f09-a1f7-08f13af445a2', 'objective', 'Give examples of languages that make use of a given programming paradigm', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'df8d94bf-f234-4829-89df-fb440d1f55dc', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1a18cd5d-4b6a-4936-8593-4d45cfb03c59', 5,
  5, 'Integration activities', 1,
  2, 2,
  true, false, false,
  'integration_activity', 6
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5092c66d-4550-42e8-8db2-7afffe962f45', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '3c6f2ba3-a2b6-44b8-84c7-ae2bf31cd78b', 6,
  6, 'Algorithms to solve common problems 1', 1,
  3, 3,
  true, false, false,
  'content', 7
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5092c66d-4550-42e8-8db2-7afffe962f45', 'objective', 'Differentiate between pseudocode and flowchart', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5092c66d-4550-42e8-8db2-7afffe962f45', 'objective', 'Produce pseudocode and flowchart to solve common problems such as swapping, identification of maximum or minimum', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '53dde42e-1def-4ba3-aa0c-cef20d255a04', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '3c6f2ba3-a2b6-44b8-84c7-ae2bf31cd78b', 7,
  7, 'Algorithms to solve common problems 2', 1,
  3, 3,
  true, false, false,
  'content', 8
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53dde42e-1def-4ba3-aa0c-cef20d255a04', 'objective', 'Differentiate between searching and sorting problems', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53dde42e-1def-4ba3-aa0c-cef20d255a04', 'objective', 'Explain the principles of linear search and bubble sort', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53dde42e-1def-4ba3-aa0c-cef20d255a04', 'objective', 'Produce pseudocode and flowchart to solve common problems such as totaling, counting', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8742a02f-775f-4f3b-9cf1-7ebebf025f58', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '3c6f2ba3-a2b6-44b8-84c7-ae2bf31cd78b', 8,
  8, 'Notions on subroutines', 1,
  3, 3,
  true, false, false,
  'content', 9
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8742a02f-775f-4f3b-9cf1-7ebebf025f58', 'objective', 'Explain the concepts of subroutines, local variables, global variables, formal parameters, actual parameters', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8742a02f-775f-4f3b-9cf1-7ebebf025f58', 'objective', 'Identify common parts of a subroutine', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8742a02f-775f-4f3b-9cf1-7ebebf025f58', 'objective', 'Differentiate between procedures and functions', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ac17788b-aaaf-48be-a5e3-0b2780bee7e8', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '3c6f2ba3-a2b6-44b8-84c7-ae2bf31cd78b', 9,
  9, 'Algorithms as subroutines', 1,
  4, 4,
  true, false, false,
  'content', 10
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ac17788b-aaaf-48be-a5e3-0b2780bee7e8', 'objective', 'Produce procedures or functions to solve problems such as totaling, counting, max, min, swap, search, and sort', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '92de7c34-8ec0-48e7-9bde-311738b207d8', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '3c6f2ba3-a2b6-44b8-84c7-ae2bf31cd78b', 10,
  10, 'Algorithm correctness and efficiency', 1,
  4, 4,
  true, false, false,
  'content', 11
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('92de7c34-8ec0-48e7-9bde-311738b207d8', 'objective', 'Explain how dry running can be used to test the correctness of an algorithm', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('92de7c34-8ec0-48e7-9bde-311738b207d8', 'objective', 'Describe simple ways of measuring the efficiency of an algorithm', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('92de7c34-8ec0-48e7-9bde-311738b207d8', 'objective', 'Establish the correctness and efficiency of a given set of algorithms', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c9d70e93-d40a-4a2b-bee2-0c96fbb1033f', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '3c6f2ba3-a2b6-44b8-84c7-ae2bf31cd78b', 11,
  11, 'Integration activities', 1,
  4, 4,
  true, false, false,
  'integration_activity', 12
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0a061114-2150-4a77-8211-80cb3ce5a4af', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Evaluation', 1,
  5, 5,
  true, false, false,
  'evaluation', 13
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '46f9bb0b-cf2c-4f35-8b7a-7252cd166e6a', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'f9f3dc3e-369f-4a8a-ae8c-261ed46eb77b', 12,
  12, 'Coding 1', 1,
  5, 5,
  true, false, false,
  'content', 14
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('46f9bb0b-cf2c-4f35-8b7a-7252cd166e6a', 'objective', 'State best practices when writing code', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('46f9bb0b-cf2c-4f35-8b7a-7252cd166e6a', 'objective', 'Produce source code for the totaling, counting algorithms', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '35de136e-471f-4af2-8145-da0c28784ad7', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'f9f3dc3e-369f-4a8a-ae8c-261ed46eb77b', 13,
  13, 'Coding 2', 1,
  5, 5,
  true, false, false,
  'content', 15
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('35de136e-471f-4af2-8145-da0c28784ad7', 'objective', 'Produce source code for maximum, minimum and swapping algorithms using subroutines', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '656d4ef7-238a-4bad-9ded-9b1e781857d5', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'f9f3dc3e-369f-4a8a-ae8c-261ed46eb77b', 14,
  14, 'Coding 3', 1,
  6, 6,
  true, false, false,
  'content', 16
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('656d4ef7-238a-4bad-9ded-9b1e781857d5', 'objective', 'Produce source code for linear search algorithm and bubble sort algorithms using subroutines', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5701d8f8-3810-4466-a0d2-fbef741037eb', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
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
  '382424c7-f23e-4dba-809f-8c220588356e', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
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
  'd1384d44-e594-4272-a394-74b6022d6b6d', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'f9f3dc3e-369f-4a8a-ae8c-261ed46eb77b', 15,
  15, 'Coding 4', 1,
  6, 6,
  true, false, false,
  'content', 19
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d1384d44-e594-4272-a394-74b6022d6b6d', 'objective', 'Make use of some built-in routines in a programming language to solve problems', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3ce51af7-fa7e-41c8-9e14-a570abcf0cbf', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'f9f3dc3e-369f-4a8a-ae8c-261ed46eb77b', 16,
  16, 'Integration activities', 1,
  6, 6,
  true, false, false,
  'integration_activity', 20
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '410f7612-501e-429d-afc0-3adf78d460fd', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'eb4bacfa-742e-4d25-9d5d-dc321eab6c2b', 17,
  17, 'Input and output peripherals', 1,
  7, 7,
  true, false, false,
  'content', 21
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('410f7612-501e-429d-afc0-3adf78d460fd', 'objective', 'Describe RFID readers, QR code readers, OMR readers, OCR readers, and contactless card readers', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('410f7612-501e-429d-afc0-3adf78d460fd', 'objective', 'Describe plotters, 3D printer, and actuators', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('410f7612-501e-429d-afc0-3adf78d460fd', 'objective', 'Choose appropriate input, and output peripheral in a given context', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd170572e-4449-4786-b64d-3e64786807e8', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'eb4bacfa-742e-4d25-9d5d-dc321eab6c2b', 18,
  18, 'Integration activities', 1,
  7, 7,
  true, false, false,
  'integration_activity', 22
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd07253b1-6d2f-4eaf-b9f6-7fdd196bbd06', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'dd3f934d-4c11-4662-9119-f45c018b5ff5', 19,
  19, 'Storage and processing devices', 1,
  7, 7,
  true, false, false,
  'content', 23
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d07253b1-6d2f-4eaf-b9f6-7fdd196bbd06', 'objective', 'Describe processing and storage devices', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d07253b1-6d2f-4eaf-b9f6-7fdd196bbd06', 'objective', 'Describe the machine instruction cycle', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'caf46309-0a85-423d-89cd-0de99db8a8dd', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'dd3f934d-4c11-4662-9119-f45c018b5ff5', 20,
  20, 'Other internal components', 1,
  8, 8,
  true, false, false,
  'content', 24
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caf46309-0a85-423d-89cd-0de99db8a8dd', 'objective', 'State the main ports on the motherboard', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caf46309-0a85-423d-89cd-0de99db8a8dd', 'objective', 'Describe the different types of bus', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caf46309-0a85-423d-89cd-0de99db8a8dd', 'objective', 'State the role of the CMOS and battery', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '480952ca-112d-4587-9841-8e9547492b16', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'dd3f934d-4c11-4662-9119-f45c018b5ff5', 21,
  21, 'Integration activities', 1,
  8, 8,
  true, false, false,
  'integration_activity', 25
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f15a6bf9-0076-4060-b3cd-790900fc2728', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b9c54e29-d747-44e0-90a6-7ab6e8a26da9', 22,
  22, 'Types of application software', 1,
  9, 9,
  true, false, false,
  'content', 26
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f15a6bf9-0076-4060-b3cd-790900fc2728', 'objective', 'Describe common application software for productivity, personal interest, graphics and media, and communication and collaboration', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f15a6bf9-0076-4060-b3cd-790900fc2728', 'objective', 'Choose application software for a given situation', 'evaluate', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd8208b84-278e-4f29-a1a8-1118f4ad46dc', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b9c54e29-d747-44e0-90a6-7ab6e8a26da9', 23,
  23, 'Integration activities', 1,
  9, 9,
  true, false, false,
  'integration_activity', 27
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9c8e932a-0205-4678-8bf2-9f43324b9c92', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'e588f2ae-e85b-480e-a251-48bd8683e05a', 24,
  24, 'Methods to obtain software', 1,
  10, 10,
  true, false, false,
  'content', 28
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9c8e932a-0205-4678-8bf2-9f43324b9c92', 'objective', 'Describe the different methods of obtaining software', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9c8e932a-0205-4678-8bf2-9f43324b9c92', 'objective', 'Choose appropriate method to obtain software', 'evaluate', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6a3c7212-25f8-46e1-83a4-772ba9bb3f44', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'e588f2ae-e85b-480e-a251-48bd8683e05a', 25,
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
  'f05e3267-eef7-4410-a741-bca8ec9302e8', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Evaluation', 1,
  11, 11,
  true, false, false,
  'evaluation', 30
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd2346919-2bf0-4b52-8c75-ad4e870fd6bf', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '5af4df75-ed61-4fe1-b104-6c0bb411f4ff', 26,
  26, 'Using a word processor 1', 1,
  11, 11,
  true, true, true,
  'content', 31
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d2346919-2bf0-4b52-8c75-ad4e870fd6bf', 'objective', 'Produce a formatted word processed document that makes use of text, tables, graphics, and text boxes', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f6c4a064-fb5e-47a1-9648-900140501130', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '5af4df75-ed61-4fe1-b104-6c0bb411f4ff', 27,
  27, 'Using a word processor 2', 1,
  11, 11,
  true, true, true,
  'content', 32
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f6c4a064-fb5e-47a1-9648-900140501130', 'objective', 'Reproduce a document of at most two pages with the help of a word processor', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '62e18ac6-064f-4cab-9c6f-64701be9b548', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '5af4df75-ed61-4fe1-b104-6c0bb411f4ff', 28,
  28, 'Solve problems with spreadsheets 1', 1,
  12, 12,
  true, true, true,
  'content', 33
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62e18ac6-064f-4cab-9c6f-64701be9b548', 'objective', 'Reproduce the data and formatting applied to a spreadsheet', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62e18ac6-064f-4cab-9c6f-64701be9b548', 'objective', 'Determine appropriate formulas to meet the different goals in a problem', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9bb69347-972e-496b-8429-b05016a3b0df', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Remediation', 1,
  12, 12,
  true, false, false,
  'remediation', 34
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9bab13af-ce97-419f-9449-fdcf6cda494c', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
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
  '9d8aa383-5601-4716-a5c0-087b1520e989', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '5af4df75-ed61-4fe1-b104-6c0bb411f4ff', 29,
  29, 'Solve problems with spreadsheets 2', 2,
  13, 13,
  true, true, true,
  'content', 36
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d8aa383-5601-4716-a5c0-087b1520e989', 'objective', 'Determine appropriate formulas to meet the different goals in a problem', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d8aa383-5601-4716-a5c0-087b1520e989', 'objective', 'Represent specific spreadsheet data as a given chart', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d8aa383-5601-4716-a5c0-087b1520e989', 'objective', 'Make use of features of spreadsheets such as sort, and filter', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '07f15000-de72-415f-9fff-cb251332bbe0', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '5af4df75-ed61-4fe1-b104-6c0bb411f4ff', 30,
  30, 'Create presentations 1', 2,
  13, 13,
  true, true, true,
  'content', 37
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07f15000-de72-415f-9fff-cb251332bbe0', 'objective', 'Create simple presentations of at most 5 slides when given a model of the presentation', 'create', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07f15000-de72-415f-9fff-cb251332bbe0', 'objective', 'Modify a presentation by adding and formatting objects such as images, sound, and videos', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cbaeae0c-a164-4e26-bfa8-78ad122c4f04', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '5af4df75-ed61-4fe1-b104-6c0bb411f4ff', 31,
  31, 'Create presentations 2', 2,
  13, 13,
  true, true, true,
  'content', 38
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cbaeae0c-a164-4e26-bfa8-78ad122c4f04', 'objective', 'Create animations using a presentation software that meet a given situation', 'create', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b5435fd7-cbfb-4d7c-a94e-962c1a506e93', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '5af4df75-ed61-4fe1-b104-6c0bb411f4ff', 32,
  32, 'Create publications', 2,
  14, 14,
  true, true, true,
  'content', 39
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b5435fd7-cbfb-4d7c-a94e-962c1a506e93', 'objective', 'Produce a given publication when given the model of the publication', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2cb45141-0944-4f92-a2a2-423832f9b47a', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '5af4df75-ed61-4fe1-b104-6c0bb411f4ff', 33,
  33, 'Integration activities', 2,
  14, 14,
  true, false, false,
  'integration_activity', 40
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '11e3a820-5f53-4c76-907f-f4ecb72ed40f', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '97ea7831-f07a-4ebf-9e16-c185257b78ec', 34,
  34, 'Assistive technology and disabilities', 2,
  14, 14,
  true, false, false,
  'content', 41
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('11e3a820-5f53-4c76-907f-f4ecb72ed40f', 'objective', 'Explain the concepts of disability, and assistive technology', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('11e3a820-5f53-4c76-907f-f4ecb72ed40f', 'objective', 'Describe common assistive technologies for a given disability', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('11e3a820-5f53-4c76-907f-f4ecb72ed40f', 'objective', 'Outline features common to operating systems aimed at helping the disabled', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '36e3d813-2a01-48a4-b39b-291c109cbe2d', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '97ea7831-f07a-4ebf-9e16-c185257b78ec', 35,
  35, 'Assistive technologies for the elderly', 2,
  15, 15,
  true, false, false,
  'content', 42
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('36e3d813-2a01-48a4-b39b-291c109cbe2d', 'objective', 'Explain the importance of assistive technologies for the elderly', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('36e3d813-2a01-48a4-b39b-291c109cbe2d', 'objective', 'Describe technologies that can be used to assist the elderly', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '982ebc4e-9b9a-4c76-82d0-dc2d82e566c7', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '97ea7831-f07a-4ebf-9e16-c185257b78ec', 36,
  36, 'Integration activities', 2,
  15, 15,
  true, false, false,
  'integration_activity', 43
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '36dedc3b-afce-45c7-9620-c5bcf723541a', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1aa47daf-a2a9-43e3-9268-07fa141e8c15', 37,
  37, 'Network hardware', 2,
  15, 15,
  true, false, false,
  'content', 44
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('36dedc3b-afce-45c7-9620-c5bcf723541a', 'objective', 'Explain the role of NIC, modem, router, multiplexer, bridge, repeater in a network', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('36dedc3b-afce-45c7-9620-c5bcf723541a', 'objective', 'Identify hardware needed for internet connectivity in a house, school or organizational network', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '70849546-b1b9-497e-9b5a-7ce8a46a6f44', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1aa47daf-a2a9-43e3-9268-07fa141e8c15', 38,
  38, 'Network IP configuration', 2,
  16, 16,
  true, false, false,
  'content', 45
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70849546-b1b9-497e-9b5a-7ce8a46a6f44', 'objective', 'State the purpose of MAC address and IP address', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70849546-b1b9-497e-9b5a-7ce8a46a6f44', 'objective', 'Differentiate between IPv4 and IPv6 addresses', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70849546-b1b9-497e-9b5a-7ce8a46a6f44', 'objective', 'Compare static ip addresses to dynamic ip addresses', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70849546-b1b9-497e-9b5a-7ce8a46a6f44', 'objective', 'Explain the purpose of configuring ip addresses on a LAN', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '584581a8-fa93-43f6-8ec2-56645a1f8a44', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1aa47daf-a2a9-43e3-9268-07fa141e8c15', 39,
  39, 'Integration activities', 2,
  16, 16,
  true, false, false,
  'integration_activity', 46
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'be1e3ad3-6a5e-402d-b16b-e261ac0fec37', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'd13d4470-c7aa-46ef-a0d0-ebdb6250cf6d', 40,
  40, 'Notions on packets', 2,
  16, 16,
  true, false, false,
  'content', 47
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be1e3ad3-6a5e-402d-b16b-e261ac0fec37', 'objective', 'Explain the concepts packet header, payload, trailer, packet switching', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be1e3ad3-6a5e-402d-b16b-e261ac0fec37', 'objective', 'Describe the structure of a packet', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be1e3ad3-6a5e-402d-b16b-e261ac0fec37', 'objective', 'Describe the USB interface and explain mechanisms it uses to transmit data', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd9aa474f-4cfc-41da-af84-5afc1b26700b', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Evaluation', 2,
  17, 17,
  true, false, false,
  'evaluation', 48
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '537b48f7-d781-4403-96ce-136dece5e747', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'd13d4470-c7aa-46ef-a0d0-ebdb6250cf6d', 41,
  41, 'Error detection and packet security', 2,
  17, 17,
  true, false, false,
  'content', 49
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('537b48f7-d781-4403-96ce-136dece5e747', 'objective', 'Explain the need to check for errors after data transmission and how these errors occur', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('537b48f7-d781-4403-96ce-136dece5e747', 'objective', 'Explain the need for and purpose of encryption when transmitting data', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('537b48f7-d781-4403-96ce-136dece5e747', 'objective', 'Describe error detection methods and how data is encrypted', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'be2409fb-8c01-4486-a707-888326252a29', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'd13d4470-c7aa-46ef-a0d0-ebdb6250cf6d', 42,
  42, 'Integration activities', 2,
  17, 17,
  true, false, false,
  'integration_activity', 50
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a6d528ce-bb7a-464e-bde4-733fbfd42690', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Remediation', 2,
  18, 18,
  true, false, false,
  'remediation', 51
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '97c1005c-250f-4d37-affb-647c5b3ed03f', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Remediation', 2,
  18, 18,
  true, false, false,
  'remediation', 52
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6ca21a77-8ea9-4fd9-af2a-697fa10301f4', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b3e5a87f-98d0-43ab-a4f8-c69e43546fc4', 43,
  43, 'Notions on the internet', 2,
  18, 18,
  true, false, false,
  'content', 53
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ca21a77-8ea9-4fd9-af2a-697fa10301f4', 'objective', 'Explain the concepts of internet, intranet, extranet, protocol', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ca21a77-8ea9-4fd9-af2a-697fa10301f4', 'objective', 'Outline advantages and disadvantages of the internet', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ca21a77-8ea9-4fd9-af2a-697fa10301f4', 'objective', 'Explain the role of ISP and browsers in accessing the internet', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ca21a77-8ea9-4fd9-af2a-697fa10301f4', 'objective', 'Describe the importance of URL and its nomenclature', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '67bec858-a369-4403-bf1b-4f87c32b4b3c', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b3e5a87f-98d0-43ab-a4f8-c69e43546fc4', 44,
  44, 'Notions on digital currency', 2,
  19, 19,
  true, false, false,
  'content', 54
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67bec858-a369-4403-bf1b-4f87c32b4b3c', 'objective', 'Outline common internet services', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67bec858-a369-4403-bf1b-4f87c32b4b3c', 'objective', 'Explain the concept of digital currencies and how they are used', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67bec858-a369-4403-bf1b-4f87c32b4b3c', 'objective', 'State examples of digital currencies', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67bec858-a369-4403-bf1b-4f87c32b4b3c', 'objective', 'Explain the process of block chain and how it is used to track digital currency transactions', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4f255d92-0864-45a4-abbc-c45340884ce6', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b3e5a87f-98d0-43ab-a4f8-c69e43546fc4', 45,
  45, 'Web authoring services', 2,
  19, 19,
  true, true, true,
  'content', 55
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4f255d92-0864-45a4-abbc-c45340884ce6', 'objective', 'Outline examples of web authoring tools', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4f255d92-0864-45a4-abbc-c45340884ce6', 'objective', 'State the role of HTML', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4f255d92-0864-45a4-abbc-c45340884ce6', 'objective', 'Build a simple web page using HTML and CSS', 'create', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1e568a05-167e-4703-bc53-be52a75e654e', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b3e5a87f-98d0-43ab-a4f8-c69e43546fc4', 46,
  46, 'Integration activities', 2,
  19, 19,
  true, false, false,
  'integration_activity', 56
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd16d9c69-ab04-4f64-9c85-c91edc54e5ee', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b142cead-0774-4443-a2e1-a2751e3a9c88', 47,
  47, 'Notions on social networks', 2,
  20, 20,
  true, false, false,
  'content', 57
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d16d9c69-ab04-4f64-9c85-c91edc54e5ee', 'objective', 'State the reasons for social networks', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d16d9c69-ab04-4f64-9c85-c91edc54e5ee', 'objective', 'State the characteristics of social networks', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d16d9c69-ab04-4f64-9c85-c91edc54e5ee', 'objective', 'State advantages and disadvantages of online social networks', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d16d9c69-ab04-4f64-9c85-c91edc54e5ee', 'objective', 'Explain the impacts of online social networks', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '33d84738-2310-4a9f-bab7-de3f8924bf4e', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b142cead-0774-4443-a2e1-a2751e3a9c88', 48,
  48, 'Using online social networks', 2,
  20, 20,
  true, false, false,
  'content', 58
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('33d84738-2310-4a9f-bab7-de3f8924bf4e', 'objective', 'Differentiate between social network and social media', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('33d84738-2310-4a9f-bab7-de3f8924bf4e', 'objective', 'Differentiate between different online social networks', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('33d84738-2310-4a9f-bab7-de3f8924bf4e', 'objective', 'Make use of an online social network to share resources and communicate', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4ee315b7-7bdd-4009-a499-5949c9508c01', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b142cead-0774-4443-a2e1-a2751e3a9c88', 49,
  49, 'Integration activities', 2,
  20, 20,
  true, false, false,
  'integration_activity', 59
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dedd3ef2-f3a3-499e-b0f5-34197c6b308c', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '0847312e-e473-406d-b806-321ccf039b81', 50,
  50, 'Notions on security', 2,
  21, 21,
  true, false, false,
  'content', 60
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dedd3ef2-f3a3-499e-b0f5-34197c6b308c', 'objective', 'Differentiate between computer security, data security, and network security', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dedd3ef2-f3a3-499e-b0f5-34197c6b308c', 'objective', 'Differentiate between vulnerability, threat, and attack. Identify three security objectives', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dedd3ef2-f3a3-499e-b0f5-34197c6b308c', 'objective', 'Identify common vulnerabilities linked to data, computers, or networks in a given context', 'analyse', 3);
INSERT INTO curriculum_load_log (syllabus_id, severity, message, source_ref) VALUES ('0a48b345-b974-4dd4-940b-fb547d9a63dc', 'correction', 'Sheet prints this row as "501"; loaded as lesson 50', 'Notions on security');

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '421d8bae-422a-4102-b660-44f959a92a8e', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '0847312e-e473-406d-b806-321ccf039b81', 51,
  51, 'Threats and attacks on computer systems', 2,
  21, 21,
  true, false, false,
  'content', 61
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('421d8bae-422a-4102-b660-44f959a92a8e', 'objective', 'Identify common threats on data, computers, and networks', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('421d8bae-422a-4102-b660-44f959a92a8e', 'objective', 'Describe common attacks on data, computers, and networks', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('421d8bae-422a-4102-b660-44f959a92a8e', 'objective', 'Describe the different types of malware', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9744107a-71ba-45da-bb07-65d8b4abd608', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '0847312e-e473-406d-b806-321ccf039b81', 52,
  52, 'Data, computer, and network security measures', 2,
  21, 21,
  true, false, false,
  'content', 62
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9744107a-71ba-45da-bb07-65d8b4abd608', 'objective', 'Explain measures to secure data', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9744107a-71ba-45da-bb07-65d8b4abd608', 'objective', 'Explain measures to secure a computer', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9744107a-71ba-45da-bb07-65d8b4abd608', 'objective', 'Explain measures to secure a network', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9744107a-71ba-45da-bb07-65d8b4abd608', 'objective', 'Outline common data recovery strategies', 'remember', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '60c64913-88a4-4d71-886f-adee08140f1e', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '0847312e-e473-406d-b806-321ccf039b81', 53,
  53, 'Integration activities', 2,
  22, 22,
  true, false, false,
  'integration_activity', 63
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5616a9f7-865c-43f6-b35d-e2cec6f62ca9', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'd88e9c24-0e19-491a-99a9-e7b488173993', 54,
  54, 'Notions on digital identities and digital footprints', 2,
  22, 22,
  true, false, false,
  'content', 64
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5616a9f7-865c-43f6-b35d-e2cec6f62ca9', 'objective', 'Explain the following concepts: digital identity, password, username, identity theft, digital footprint, passive and active digital footprint', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5616a9f7-865c-43f6-b35d-e2cec6f62ca9', 'objective', 'Explain characteristics of a good password', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5616a9f7-865c-43f6-b35d-e2cec6f62ca9', 'objective', 'Explain ways that a user creates passive and active digital footprints', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2532a882-f639-4ec4-ae39-ea1503d6b12f', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'd88e9c24-0e19-491a-99a9-e7b488173993', 55,
  55, 'Digital identities and footprints management', 2,
  22, 22,
  true, false, false,
  'content', 65
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2532a882-f639-4ec4-ae39-ea1503d6b12f', 'objective', 'Outline best practices to manage multiple digital identities', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2532a882-f639-4ec4-ae39-ea1503d6b12f', 'objective', 'State positive and negative effects of digital footprints', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2532a882-f639-4ec4-ae39-ea1503d6b12f', 'objective', 'Explain ways of protecting digital footprints', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '771d5807-4571-41b5-a53b-65098dd993f8', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'd88e9c24-0e19-491a-99a9-e7b488173993', 56,
  56, 'Integration activities', 2,
  22, 22,
  true, false, false,
  'integration_activity', 66
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '862f2977-774d-4b65-bdfd-79cfb355e5c1', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Evaluation', 2,
  23, 23,
  true, false, false,
  'evaluation', 67
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '62d60637-78ea-4bb4-b482-cd9b09a4fbea', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'e2807d84-afc8-46d8-9c14-848b59206fcf', 57,
  57, 'Protecting Intellectual property', 2,
  23, 23,
  true, false, false,
  'content', 68
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62d60637-78ea-4bb4-b482-cd9b09a4fbea', 'objective', 'Explain the concepts of intellectual property, trademark, patent, copyright, license', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62d60637-78ea-4bb4-b482-cd9b09a4fbea', 'objective', 'Identify the freedoms provided by a given type of license', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62d60637-78ea-4bb4-b482-cd9b09a4fbea', 'objective', 'State possible national and international consequences of non-respect of intellectual property', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62d60637-78ea-4bb4-b482-cd9b09a4fbea', 'objective', 'Identify exceptions and legal limitations of using and sharing copyrighted content', 'analyse', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c1f4b725-7b9a-4792-bd1d-b61e6a841d60', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'e2807d84-afc8-46d8-9c14-848b59206fcf', 58,
  58, 'Assigning and respecting digital licenses', 2,
  23, 23,
  true, false, false,
  'content', 69
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c1f4b725-7b9a-4792-bd1d-b61e6a841d60', 'objective', 'Match each type of creative common license to a given permission', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c1f4b725-7b9a-4792-bd1d-b61e6a841d60', 'objective', 'Explain ways of identifying free and copyrighted digital content', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c1f4b725-7b9a-4792-bd1d-b61e6a841d60', 'objective', 'State platforms where free digital content can be found', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c1f4b725-7b9a-4792-bd1d-b61e6a841d60', 'objective', 'State ways of sharing and using digital content legally', 'remember', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9fdf6955-ba36-4952-910e-eafc73f9a369', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'e2807d84-afc8-46d8-9c14-848b59206fcf', 59,
  59, 'Integration activities', 2,
  24, 24,
  true, false, false,
  'integration_activity', 70
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '31bd810f-1a89-4891-8493-76c11a1802d2', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
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
  '4bb7d2c7-9e6c-4167-83c7-1f0fc7d931eb', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
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
  'be595517-150b-4598-a548-b4ccc8956967', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'ee21728f-1433-494c-9237-b0a9cf939cd4', 60,
  60, 'Notions on data encoding', 3,
  25, 25,
  true, false, false,
  'content', 73
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be595517-150b-4598-a548-b4ccc8956967', 'objective', 'Explain how data is represented in the computer', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be595517-150b-4598-a548-b4ccc8956967', 'objective', 'Distinguish between data numbers, characters, images and sound', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be595517-150b-4598-a548-b4ccc8956967', 'objective', 'Outline techniques used to encode numbers, characters, images, and sound', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7740233b-d20e-4bab-b5cc-a73dd3e69d9b', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'ee21728f-1433-494c-9237-b0a9cf939cd4', 61,
  61, 'Character and positive integers encoding', 3,
  25, 25,
  true, false, false,
  'content', 74
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7740233b-d20e-4bab-b5cc-a73dd3e69d9b', 'objective', 'Apply a given character encoding scheme to represent a set of characters', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7740233b-d20e-4bab-b5cc-a73dd3e69d9b', 'objective', 'Determine the base 2 representation of a positive integer', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '99a15ea5-0f34-4e3d-b302-5962ac3b1cd0', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'ee21728f-1433-494c-9237-b0a9cf939cd4', 62,
  62, 'Addition and subtraction in base 2, 8 and 16', 3,
  26, 26,
  true, false, false,
  'content', 75
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('99a15ea5-0f34-4e3d-b302-5962ac3b1cd0', 'objective', 'Identify symbols of base 2, 8 and 16', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('99a15ea5-0f34-4e3d-b302-5962ac3b1cd0', 'objective', 'Perform addition in any number system', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('99a15ea5-0f34-4e3d-b302-5962ac3b1cd0', 'objective', 'Perform subtraction in any number system', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '574f9340-0529-45d4-a7ef-317c7d1afea0', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'ee21728f-1433-494c-9237-b0a9cf939cd4', 63,
  63, 'Integration activities', 3,
  26, 26,
  true, false, false,
  'integration_activity', 76
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '70d8d5d6-35dc-4192-9a41-5b0128b6d658', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'a177800a-28e2-473a-a085-0efd8dbf8096', 64,
  64, 'Logic gates', 3,
  26, 26,
  true, false, false,
  'content', 77
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70d8d5d6-35dc-4192-9a41-5b0128b6d658', 'objective', 'Identify various logic gates', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70d8d5d6-35dc-4192-9a41-5b0128b6d658', 'objective', 'Describe the different types of logic gates', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70d8d5d6-35dc-4192-9a41-5b0128b6d658', 'objective', 'Draw the truth table for a logic gate', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '66fc8cf7-22d5-4f98-9306-b7e6394f5fb1', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'a177800a-28e2-473a-a085-0efd8dbf8096', 65,
  65, 'Logic circuits and expressions', 3,
  27, 27,
  true, false, false,
  'content', 78
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('66fc8cf7-22d5-4f98-9306-b7e6394f5fb1', 'objective', 'Identify logic gates in a circuit or an expression', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('66fc8cf7-22d5-4f98-9306-b7e6394f5fb1', 'objective', 'Produce the truth table or a logic circuit or expression', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('66fc8cf7-22d5-4f98-9306-b7e6394f5fb1', 'objective', 'Produce a logic circuit when given a logic expression', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7acfa48f-e962-426f-bb8d-f7fe90e1ed34', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'a177800a-28e2-473a-a085-0efd8dbf8096', 66,
  66, 'De Morgan''s law and Boolean simplification', 3,
  27, 27,
  true, false, false,
  'content', 79
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7acfa48f-e962-426f-bb8d-f7fe90e1ed34', 'objective', 'State the De Morgan''s laws', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7acfa48f-e962-426f-bb8d-f7fe90e1ed34', 'objective', 'Identify situations where De Morgan''s law can be used', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7acfa48f-e962-426f-bb8d-f7fe90e1ed34', 'objective', 'State common laws of Boolean simplification', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cd504c00-f2b2-4dfc-b159-57cd21081424', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'a177800a-28e2-473a-a085-0efd8dbf8096', 67,
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
  '1a5b3fa4-2de7-476c-aed3-05d28962a525', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1be43d53-925a-4322-ab51-a1c82ba64cbc', 68,
  68, 'Notions on organizations and information', 3,
  28, 28,
  true, false, false,
  'content', 81
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1a5b3fa4-2de7-476c-aed3-05d28962a525', 'objective', 'Explain the concepts of information and organization', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1a5b3fa4-2de7-476c-aed3-05d28962a525', 'objective', 'Explain the characteristics of good information', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1a5b3fa4-2de7-476c-aed3-05d28962a525', 'objective', 'Explain the flow of information within an organization', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fa9bbe52-cc38-40df-a77d-25c4c711c148', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1be43d53-925a-4322-ab51-a1c82ba64cbc', 69,
  69, 'Information systems', 3,
  29, 29,
  true, false, false,
  'content', 82
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fa9bbe52-cc38-40df-a77d-25c4c711c148', 'objective', 'Define an information system', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fa9bbe52-cc38-40df-a77d-25c4c711c148', 'objective', 'Differentiate manual and automated information systems', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fa9bbe52-cc38-40df-a77d-25c4c711c148', 'objective', 'Describe the elements of an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a80eb3b2-665f-4d9a-a24b-7650fba4e0d5', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1be43d53-925a-4322-ab51-a1c82ba64cbc', 70,
  70, 'Types of information system', 3,
  29, 29,
  true, false, false,
  'content', 83
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a80eb3b2-665f-4d9a-a24b-7650fba4e0d5', 'objective', 'Describe common types of information system', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a80eb3b2-665f-4d9a-a24b-7650fba4e0d5', 'objective', 'Differentiate between batch processing and real-time processing', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a80eb3b2-665f-4d9a-a24b-7650fba4e0d5', 'objective', 'Explain how choosing an appropriate process can help ensure the efficiency of an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '98daf811-7beb-4637-8179-4ba47348bcbc', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Evaluation', 3,
  29, 29,
  true, false, false,
  'evaluation', 84
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0ca46e9c-8091-4fad-9c26-bc7261b4dfeb', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1be43d53-925a-4322-ab51-a1c82ba64cbc', 71,
  71, 'Data capture methods', 3,
  30, 30,
  true, false, false,
  'content', 85
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0ca46e9c-8091-4fad-9c26-bc7261b4dfeb', 'objective', 'Explain the concept of data capture', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0ca46e9c-8091-4fad-9c26-bc7261b4dfeb', 'objective', 'Describe common manual and automated data capture methods', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0ca46e9c-8091-4fad-9c26-bc7261b4dfeb', 'objective', 'Explain how automated data capture helps improve effectiveness, and reliability of an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f4ce15ca-7fc1-43ab-8b41-698d765adb02', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Remediation', 3,
  30, 30,
  true, false, false,
  'remediation', 86
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '87481f21-3510-40fc-8662-2b0ae11dda39', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Remediation', 3,
  30, 30,
  true, false, false,
  'remediation', 87
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '086df641-deff-40cf-94f1-fa15c880e784', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1be43d53-925a-4322-ab51-a1c82ba64cbc', 72,
  72, 'Data verification and validation', 3,
  31, 31,
  true, false, false,
  'content', 88
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('086df641-deff-40cf-94f1-fa15c880e784', 'objective', 'Differentiate between data verification and data validation', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('086df641-deff-40cf-94f1-fa15c880e784', 'objective', 'Describe data verification and data validation methods', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('086df641-deff-40cf-94f1-fa15c880e784', 'objective', 'Explain how data validation and data verification ensure the effectiveness, and reliability of an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2a393532-b651-45e4-a212-871bffa57162', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1be43d53-925a-4322-ab51-a1c82ba64cbc', 73,
  73, 'Data integrity', 3,
  31, 31,
  true, false, false,
  'content', 89
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2a393532-b651-45e4-a212-871bffa57162', 'objective', 'Explain the concept of data integrity', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2a393532-b651-45e4-a212-871bffa57162', 'objective', 'Explain why ensuring data integrity is important in an information system', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2a393532-b651-45e4-a212-871bffa57162', 'objective', 'Explain ways of ensuring data integrity in an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c0870797-7568-4d36-960d-cfa004e2b1e3', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '1be43d53-925a-4322-ab51-a1c82ba64cbc', 74,
  74, 'Integration activities', 3,
  31, 31,
  true, false, false,
  'integration_activity', 90
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f8ee57fd-a306-40ba-bb4b-ce42fe63fbf8', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b72a0c1a-be68-4784-a743-d850f127d47e', 75,
  75, 'Introduction to databases', 3,
  32, 32,
  true, false, false,
  'content', 91
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f8ee57fd-a306-40ba-bb4b-ce42fe63fbf8', 'objective', 'Describe common types of database', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f8ee57fd-a306-40ba-bb4b-ce42fe63fbf8', 'objective', 'Outline advantages and disadvantages of flat file systems', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f8ee57fd-a306-40ba-bb4b-ce42fe63fbf8', 'objective', 'State common features of a DBMS', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1e57116d-6f3a-4b12-810d-16a7640861c2', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b72a0c1a-be68-4784-a743-d850f127d47e', 76,
  76, 'Relational database design', 3,
  32, 32,
  true, false, false,
  'content', 92
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e57116d-6f3a-4b12-810d-16a7640861c2', 'objective', 'Explain the concepts of attribute, record, table, primary key, foreign key, relationship', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e57116d-6f3a-4b12-810d-16a7640861c2', 'objective', 'Identify attributes, tables, primary key, and relationships in a given situation', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6e4a92bf-eb5f-4689-ae5d-ea68f7350905', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b72a0c1a-be68-4784-a743-d850f127d47e', 77,
  77, 'Normalization and Relational models', 3,
  32, 32,
  true, false, false,
  'content', 93
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6e4a92bf-eb5f-4689-ae5d-ea68f7350905', 'objective', 'Explain the purpose of normalization', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6e4a92bf-eb5f-4689-ae5d-ea68f7350905', 'objective', 'State the properties of a database in 1NF, 2NF, and 3NF', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6e4a92bf-eb5f-4689-ae5d-ea68f7350905', 'objective', 'Identify attributes, tables, primary key, foreign key, and relationships in a given situation', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fce8a640-bbf6-4fd7-9e7b-e702a779a8ff', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b72a0c1a-be68-4784-a743-d850f127d47e', 78,
  78, 'Use an RDBMS to create tables', 3,
  33, 33,
  true, true, true,
  'content', 94
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fce8a640-bbf6-4fd7-9e7b-e702a779a8ff', 'objective', 'Outline examples of an RDBMS', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fce8a640-bbf6-4fd7-9e7b-e702a779a8ff', 'objective', 'Identify common features of a given GUI RDBMS', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fce8a640-bbf6-4fd7-9e7b-e702a779a8ff', 'objective', 'Make use of a GUI RDBMS to create tables', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0155ea99-7a58-4f14-9ed6-ffe04e87655e', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b72a0c1a-be68-4784-a743-d850f127d47e', 79,
  79, 'Use an RDBMS to create relationships', 3,
  33, 33,
  true, true, true,
  'content', 95
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0155ea99-7a58-4f14-9ed6-ffe04e87655e', 'objective', 'Make use of a GUI RDBMS to create relationships', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0155ea99-7a58-4f14-9ed6-ffe04e87655e', 'objective', 'Enter data in a table found in a GUI RDBMS', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0155ea99-7a58-4f14-9ed6-ffe04e87655e', 'objective', 'Perform simple operations such as sorting and filtering data with the aid of a GUI RDBMS', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8492d2fb-813c-46e2-884a-f22cdae0406e', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b72a0c1a-be68-4784-a743-d850f127d47e', 80,
  80, 'Use an RDBMS to create queries and reports', 3,
  33, 33,
  true, true, true,
  'content', 96
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8492d2fb-813c-46e2-884a-f22cdae0406e', 'objective', 'Explain the concepts of database queries and reports', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8492d2fb-813c-46e2-884a-f22cdae0406e', 'objective', 'Make use of a GUI RDBMS to create queries that is coherent to a situation', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8492d2fb-813c-46e2-884a-f22cdae0406e', 'objective', 'Make use of a GUI RDBMS to create reports', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0d3d0267-4ff0-4f85-b8cc-ebf543f1ffa3', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'b72a0c1a-be68-4784-a743-d850f127d47e', 81,
  81, 'Integration activities', 3,
  33, 33,
  true, false, false,
  'integration_activity', 97
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c638b153-604b-4244-b553-6373eb913783', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'cdceb923-8ea0-4981-a6ab-1e177e4330f3', 82,
  82, 'Stages of SDLC: investigation, analysis, design', 3,
  34, 34,
  true, false, false,
  'content', 98
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c638b153-604b-4244-b553-6373eb913783', 'objective', 'Describe the investigation, analysis and design stages of the SDLC', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c638b153-604b-4244-b553-6373eb913783', 'objective', 'Outline the functions of a system to be developed', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c638b153-604b-4244-b553-6373eb913783', 'objective', 'Explain the concept of prototyping', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c638b153-604b-4244-b553-6373eb913783', 'objective', 'Explain the need for appropriate choice of hardware and software for a system', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9deb10fb-f4f8-4f6c-ab2c-223ef499724e', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'cdceb923-8ea0-4981-a6ab-1e177e4330f3', 83,
  83, 'Stages of SDLC: development, testing, implementation, maintenance', 3,
  34, 34,
  true, false, false,
  'content', 99
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9deb10fb-f4f8-4f6c-ab2c-223ef499724e', 'objective', 'Describe the development, testing, implementation, and maintenance stages of the SDLC', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9deb10fb-f4f8-4f6c-ab2c-223ef499724e', 'objective', 'Explain the need for documentation in system development', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1b919030-96d8-4df0-a0e0-074e854dd2e8', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'cdceb923-8ea0-4981-a6ab-1e177e4330f3', 84,
  84, 'Implementation strategies', 3,
  34, 34,
  true, false, false,
  'content', 100
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1b919030-96d8-4df0-a0e0-074e854dd2e8', 'objective', 'Describe the different implementation strategies', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1b919030-96d8-4df0-a0e0-074e854dd2e8', 'objective', 'Outline the advantages and disadvantages of a given implementation strategy', 'remember', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '75678edb-3d01-40bf-a472-a6d6baec37bc', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, 'cdceb923-8ea0-4981-a6ab-1e177e4330f3', 85,
  85, 'Integration activities', 3,
  34, 34,
  true, false, false,
  'integration_activity', 101
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6b91d802-cb4f-4a62-9fe5-f40562e4d3b7', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '8cb52cb7-92d5-4cf6-b1a2-11d445582b62', 86,
  86, 'Introduction to project management', 3,
  35, 35,
  true, false, false,
  'content', 102
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6b91d802-cb4f-4a62-9fe5-f40562e4d3b7', 'objective', 'Explain the concept of project', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6b91d802-cb4f-4a62-9fe5-f40562e4d3b7', 'objective', 'Explain the need for project management', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6b91d802-cb4f-4a62-9fe5-f40562e4d3b7', 'objective', 'Describe the phases of the project life cycle', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8f531bb3-2f9e-4ea4-a99d-be456113d8eb', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '8cb52cb7-92d5-4cf6-b1a2-11d445582b62', 87,
  87, 'Project management tools', 3,
  35, 35,
  true, false, false,
  'content', 103
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8f531bb3-2f9e-4ea4-a99d-be456113d8eb', 'objective', 'Describe tools used to plan, monitor and control a project', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8f531bb3-2f9e-4ea4-a99d-be456113d8eb', 'objective', 'Produce the Gantt chart for a project', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2367a4a9-03ec-4fdb-8b1a-dcc4c1ad3a4a', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '8cb52cb7-92d5-4cf6-b1a2-11d445582b62', 88,
  88, 'Project management concepts and metrics 1', 3,
  35, 35,
  true, false, false,
  'content', 104
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2367a4a9-03ec-4fdb-8b1a-dcc4c1ad3a4a', 'objective', 'Explain the concept of task, milestone, critical path, slack time, duration of project, critical tasks', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2367a4a9-03ec-4fdb-8b1a-dcc4c1ad3a4a', 'objective', 'Determine the critical path, slack time, and duration of a project from a Gantt chart', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7e5cc12e-5d94-4a0c-b522-d02d66efd234', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '8cb52cb7-92d5-4cf6-b1a2-11d445582b62', 89,
  89, 'Project management concepts and metrics 2', 3,
  36, 36,
  true, false, false,
  'content', 105
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7e5cc12e-5d94-4a0c-b522-d02d66efd234', 'objective', 'Explain the concepts of early start, early finish, late start, and late finish', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7e5cc12e-5d94-4a0c-b522-d02d66efd234', 'objective', 'Determine the early start, early finish, late start, and late finish in a given situation', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b6c943c6-8f86-4f96-aeed-8855016c4167', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, '8cb52cb7-92d5-4cf6-b1a2-11d445582b62', 90,
  90, 'Integration activities', 3,
  36, 36,
  true, false, false,
  'integration_activity', 106
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ce3bf95d-966a-40e4-8ca8-c7fc3a1e3ca2', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Evaluation', 3,
  36, 36,
  true, false, false,
  'evaluation', 107
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '427d1e12-9e57-450a-8f29-39e5311bce46', '0a48b345-b974-4dd4-940b-fb547d9a63dc', NULL, NULL, NULL,
  NULL, 'Remediation', 3,
  36, 36,
  true, false, false,
  'remediation', 108
);

COMMIT;
