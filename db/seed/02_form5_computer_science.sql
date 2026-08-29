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
  'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b',
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

INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('6c675ff1-318c-4e12-8ca5-283568805483', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Describing data structure', NULL, 1);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e13fac20-8dcb-4f3b-890f-9ceb24193307', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Describing programming paradigms', NULL, 2);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('c1ba3abd-b1f8-4ce9-a113-25ce9c054f1f', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Writing algorithms', NULL, 3);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('bffc774a-f659-4a78-9112-5bc86ba5eb4d', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Converting an algorithm into a program', NULL, 4);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('1e4c002c-f1a9-4daa-959e-bcc646a6fd84', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Describing peripheral devices', NULL, 5);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('3bcffad0-e58a-4361-b711-1db5e2d7f226', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Describing internal components of the computer', NULL, 6);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('97f983f2-0f39-413e-b91b-025680f3f68d', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Getting application software', NULL, 7);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('45aa0b56-61f6-4df3-8e7f-1c55c447a685', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Describing ways of acquiring and distributing software', NULL, 8);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('69b76dff-d550-4cc9-b513-3d870e1ddfe5', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Creating digital content using software', NULL, 9);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('6f017d4c-6002-4ded-809b-af0039ea5c73', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Proposing assistive technology for social inclusion', NULL, 10);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('663c420b-fe30-4f6c-ba30-9d2386211a15', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Setting up LANS and classifying hardware for networks', NULL, 11);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('5703a304-13f4-4cf5-a60c-2414e21920d8', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Exploring concepts related to data communication', NULL, 12);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e135769e-b2da-4c56-b368-f1db2c45f981', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Working on the internet', NULL, 13);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('1ad12e87-9d9d-411e-b932-b66d016ffe72', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Social networks', NULL, 14);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('934967e6-814a-48aa-af78-74b3c716ec3f', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Securing data, computers, and networks', NULL, 15);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('7f0274a6-6ff5-4455-910d-ef5c26faf700', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Evaluating the impacts of digital identities and digital footprints', NULL, 16);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('96344811-dc82-4152-b7e0-684011f96f0a', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Examine licenses and copyright practices', NULL, 17);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('6016a5c4-576b-4861-a56b-38d5ac412b56', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Representing data in the computer', NULL, 18);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('3adb6e35-ec23-434c-bb46-9d11c0f035c4', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Analyzing simple logic circuits and expressions', NULL, 19);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('51f3b1c3-d64e-4206-8f46-7cf19c11bded', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Evaluating an information system', NULL, 20);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('cee3d54a-9bd0-4b77-bbb8-9cad954804d5', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Designing and implementing simple databases', NULL, 21);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('773a8f7c-6722-4f73-86aa-1c2b965fc8b4', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Developing a system', NULL, 22);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('4460b1f2-e24d-444a-9a87-67f85282cf45', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'Managing projects', NULL, 23);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dee7a833-9e41-4152-913b-b91c5121b0e5', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, 0,
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
  'e89bd5a0-5eab-4537-bbd0-0c25ee992ad9', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6c675ff1-318c-4e12-8ca5-283568805483', 1,
  1, 'Simple data types', 1,
  1, 1,
  true, false, false,
  'content', 2
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e89bd5a0-5eab-4537-bbd0-0c25ee992ad9', 'objective', 'Explain the concept of data type', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e89bd5a0-5eab-4537-bbd0-0c25ee992ad9', 'objective', 'Describe simple data types', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e89bd5a0-5eab-4537-bbd0-0c25ee992ad9', 'objective', 'Choose appropriate simple data type for a given situation', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0edf1f76-7b51-4134-a797-52f5d7969dad', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6c675ff1-318c-4e12-8ca5-283568805483', 2,
  2, 'Data structures', 1,
  1, 1,
  true, false, false,
  'content', 3
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0edf1f76-7b51-4134-a797-52f5d7969dad', 'objective', 'Differentiate between data type and data structure', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0edf1f76-7b51-4134-a797-52f5d7969dad', 'objective', 'Describe the different data structures', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0edf1f76-7b51-4134-a797-52f5d7969dad', 'objective', 'Select appropriate data structure for a given situation', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '772ef42b-8af4-401e-a787-eb364faa6fc7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6c675ff1-318c-4e12-8ca5-283568805483', 3,
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
  '2dd1661d-defc-4798-9e0b-da59764f9c74', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'e13fac20-8dcb-4f3b-890f-9ceb24193307', 4,
  4, 'Notions on programming paradigms', 1,
  2, 2,
  true, false, false,
  'content', 5
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2dd1661d-defc-4798-9e0b-da59764f9c74', 'objective', 'Explain the concept of programming paradigms', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2dd1661d-defc-4798-9e0b-da59764f9c74', 'objective', 'Describe different types of programming paradigms', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2dd1661d-defc-4798-9e0b-da59764f9c74', 'objective', 'Give examples of languages that make use of a given programming paradigm', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f8b42c7c-f62c-4698-ae12-0ebe8f2ba27e', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'e13fac20-8dcb-4f3b-890f-9ceb24193307', 5,
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
  '6624662c-3b13-471f-906e-e8c5173058a1', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'c1ba3abd-b1f8-4ce9-a113-25ce9c054f1f', 6,
  6, 'Algorithms to solve common problems 1', 1,
  3, 3,
  true, false, false,
  'content', 7
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6624662c-3b13-471f-906e-e8c5173058a1', 'objective', 'Differentiate between pseudocode and flowchart', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6624662c-3b13-471f-906e-e8c5173058a1', 'objective', 'Produce pseudocode and flowchart to solve common problems such as swapping, identification of maximum or minimum', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3960caca-58c4-439f-b86b-7db40b0f0a26', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'c1ba3abd-b1f8-4ce9-a113-25ce9c054f1f', 7,
  7, 'Algorithms to solve common problems 2', 1,
  3, 3,
  true, false, false,
  'content', 8
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3960caca-58c4-439f-b86b-7db40b0f0a26', 'objective', 'Differentiate between searching and sorting problems', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3960caca-58c4-439f-b86b-7db40b0f0a26', 'objective', 'Explain the principles of linear search and bubble sort', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3960caca-58c4-439f-b86b-7db40b0f0a26', 'objective', 'Produce pseudocode and flowchart to solve common problems such as totaling, counting', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '394a4949-f23e-4546-9db9-874973199f5b', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'c1ba3abd-b1f8-4ce9-a113-25ce9c054f1f', 8,
  8, 'Notions on subroutines', 1,
  3, 3,
  true, false, false,
  'content', 9
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('394a4949-f23e-4546-9db9-874973199f5b', 'objective', 'Explain the concepts of subroutines, local variables, global variables, formal parameters, actual parameters', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('394a4949-f23e-4546-9db9-874973199f5b', 'objective', 'Identify common parts of a subroutine', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('394a4949-f23e-4546-9db9-874973199f5b', 'objective', 'Differentiate between procedures and functions', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'be80359e-2843-48e6-8df0-c54370f9561e', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'c1ba3abd-b1f8-4ce9-a113-25ce9c054f1f', 9,
  9, 'Algorithms as subroutines', 1,
  4, 4,
  true, false, false,
  'content', 10
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be80359e-2843-48e6-8df0-c54370f9561e', 'objective', 'Produce procedures or functions to solve problems such as totaling, counting, max, min, swap, search, and sort', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b57d3a26-740e-4c76-adbb-55ac63e1af92', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'c1ba3abd-b1f8-4ce9-a113-25ce9c054f1f', 10,
  10, 'Algorithm correctness and efficiency', 1,
  4, 4,
  true, false, false,
  'content', 11
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b57d3a26-740e-4c76-adbb-55ac63e1af92', 'objective', 'Explain how dry running can be used to test the correctness of an algorithm', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b57d3a26-740e-4c76-adbb-55ac63e1af92', 'objective', 'Describe simple ways of measuring the efficiency of an algorithm', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b57d3a26-740e-4c76-adbb-55ac63e1af92', 'objective', 'Establish the correctness and efficiency of a given set of algorithms', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '86df17ec-2589-4112-920d-70d47d671855', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'c1ba3abd-b1f8-4ce9-a113-25ce9c054f1f', 11,
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
  'a0b340f9-e0a8-4915-b973-108abec6f1b7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  'c49e1cff-7f2e-4419-a64b-261f601db8a7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'bffc774a-f659-4a78-9112-5bc86ba5eb4d', 12,
  12, 'Coding 1', 1,
  5, 5,
  true, false, false,
  'content', 14
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c49e1cff-7f2e-4419-a64b-261f601db8a7', 'objective', 'State best practices when writing code', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c49e1cff-7f2e-4419-a64b-261f601db8a7', 'objective', 'Produce source code for the totaling, counting algorithms', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6976eca5-c52a-4cdb-8698-dd65ee5c331a', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'bffc774a-f659-4a78-9112-5bc86ba5eb4d', 13,
  13, 'Coding 2', 1,
  5, 5,
  true, false, false,
  'content', 15
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6976eca5-c52a-4cdb-8698-dd65ee5c331a', 'objective', 'Produce source code for maximum, minimum and swapping algorithms using subroutines', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '91539315-0dd9-4a11-903d-75901fec2890', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'bffc774a-f659-4a78-9112-5bc86ba5eb4d', 14,
  14, 'Coding 3', 1,
  6, 6,
  true, false, false,
  'content', 16
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('91539315-0dd9-4a11-903d-75901fec2890', 'objective', 'Produce source code for linear search algorithm and bubble sort algorithms using subroutines', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '070db9e7-bbf3-48dc-82f9-69b9fde19413', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  '9c01446a-6b95-47e9-b963-25dca17b0b88', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  '2c1f83f4-16ba-4c36-9daf-9295b162bab7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'bffc774a-f659-4a78-9112-5bc86ba5eb4d', 15,
  15, 'Coding 4', 1,
  6, 6,
  true, false, false,
  'content', 19
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2c1f83f4-16ba-4c36-9daf-9295b162bab7', 'objective', 'Make use of some built-in routines in a programming language to solve problems', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9ebf3f04-cbbf-43de-9bae-12461546b2ad', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'bffc774a-f659-4a78-9112-5bc86ba5eb4d', 16,
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
  'bea77ec0-8cae-446f-8f5f-0a0632d85ee7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '1e4c002c-f1a9-4daa-959e-bcc646a6fd84', 17,
  17, 'Input and output peripherals', 1,
  7, 7,
  true, false, false,
  'content', 21
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bea77ec0-8cae-446f-8f5f-0a0632d85ee7', 'objective', 'Describe RFID readers, QR code readers, OMR readers, OCR readers, and contactless card readers', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bea77ec0-8cae-446f-8f5f-0a0632d85ee7', 'objective', 'Describe plotters, 3D printer, and actuators', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bea77ec0-8cae-446f-8f5f-0a0632d85ee7', 'objective', 'Choose appropriate input, and output peripheral in a given context', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5b24d8c2-b6b1-4f97-9e2b-a76d437c4ac2', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '1e4c002c-f1a9-4daa-959e-bcc646a6fd84', 18,
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
  '6509db82-7853-428a-982f-f69976fdf8d7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '3bcffad0-e58a-4361-b711-1db5e2d7f226', 19,
  19, 'Storage and processing devices', 1,
  7, 7,
  true, false, false,
  'content', 23
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6509db82-7853-428a-982f-f69976fdf8d7', 'objective', 'Describe processing and storage devices', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6509db82-7853-428a-982f-f69976fdf8d7', 'objective', 'Describe the machine instruction cycle', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd5e4ffac-0e78-40b4-b387-3ddf1d0326f9', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '3bcffad0-e58a-4361-b711-1db5e2d7f226', 20,
  20, 'Other internal components', 1,
  8, 8,
  true, false, false,
  'content', 24
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d5e4ffac-0e78-40b4-b387-3ddf1d0326f9', 'objective', 'State the main ports on the motherboard', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d5e4ffac-0e78-40b4-b387-3ddf1d0326f9', 'objective', 'Describe the different types of bus', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d5e4ffac-0e78-40b4-b387-3ddf1d0326f9', 'objective', 'State the role of the CMOS and battery', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4c4a2d8c-da9e-4249-9db2-540f9629c2a5', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '3bcffad0-e58a-4361-b711-1db5e2d7f226', 21,
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
  '04b1be8b-d6a7-44d6-9980-6a18b244a258', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '97f983f2-0f39-413e-b91b-025680f3f68d', 22,
  22, 'Types of application software', 1,
  9, 9,
  true, false, false,
  'content', 26
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('04b1be8b-d6a7-44d6-9980-6a18b244a258', 'objective', 'Describe common application software for productivity, personal interest, graphics and media, and communication and collaboration', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('04b1be8b-d6a7-44d6-9980-6a18b244a258', 'objective', 'Choose application software for a given situation', 'evaluate', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '238d5863-a31a-4f92-8c90-7f4e65cd04e9', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '97f983f2-0f39-413e-b91b-025680f3f68d', 23,
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
  '22a5ebc9-8b2c-404a-b270-ea45d46a90f7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '45aa0b56-61f6-4df3-8e7f-1c55c447a685', 24,
  24, 'Methods to obtain software', 1,
  10, 10,
  true, false, false,
  'content', 28
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('22a5ebc9-8b2c-404a-b270-ea45d46a90f7', 'objective', 'Describe the different methods of obtaining software', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('22a5ebc9-8b2c-404a-b270-ea45d46a90f7', 'objective', 'Choose appropriate method to obtain software', 'evaluate', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fa67bdd8-d112-4987-9f6b-a97aaa0a99de', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '45aa0b56-61f6-4df3-8e7f-1c55c447a685', 25,
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
  '2434a372-cc51-4922-8b53-5579ce67a73e', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  '64418e57-6805-489d-bd67-826cf0c6cc8f', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '69b76dff-d550-4cc9-b513-3d870e1ddfe5', 26,
  26, 'Using a word processor 1', 1,
  11, 11,
  true, true, true,
  'content', 31
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('64418e57-6805-489d-bd67-826cf0c6cc8f', 'objective', 'Produce a formatted word processed document that makes use of text, tables, graphics, and text boxes', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ae77a3d8-3967-4385-a948-2f4e8a6625c8', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '69b76dff-d550-4cc9-b513-3d870e1ddfe5', 27,
  27, 'Using a word processor 2', 1,
  11, 11,
  true, true, true,
  'content', 32
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae77a3d8-3967-4385-a948-2f4e8a6625c8', 'objective', 'Reproduce a document of at most two pages with the help of a word processor', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd4b5d5bb-a46f-4add-86e4-abe2a2f99438', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '69b76dff-d550-4cc9-b513-3d870e1ddfe5', 28,
  28, 'Solve problems with spreadsheets 1', 1,
  12, 12,
  true, true, true,
  'content', 33
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d4b5d5bb-a46f-4add-86e4-abe2a2f99438', 'objective', 'Reproduce the data and formatting applied to a spreadsheet', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d4b5d5bb-a46f-4add-86e4-abe2a2f99438', 'objective', 'Determine appropriate formulas to meet the different goals in a problem', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dc7d8a38-bd84-4507-975b-6466d4d994f2', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  'e3605bc7-d2bc-4524-a0dc-771aea8a2cd3', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  '9f64cbc4-127f-44a5-ba85-9886b631452e', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '69b76dff-d550-4cc9-b513-3d870e1ddfe5', 29,
  29, 'Solve problems with spreadsheets 2', 2,
  13, 13,
  true, true, true,
  'content', 36
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9f64cbc4-127f-44a5-ba85-9886b631452e', 'objective', 'Determine appropriate formulas to meet the different goals in a problem', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9f64cbc4-127f-44a5-ba85-9886b631452e', 'objective', 'Represent specific spreadsheet data as a given chart', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9f64cbc4-127f-44a5-ba85-9886b631452e', 'objective', 'Make use of features of spreadsheets such as sort, and filter', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e5627f59-c7db-4afe-8661-667e3792367c', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '69b76dff-d550-4cc9-b513-3d870e1ddfe5', 30,
  30, 'Create presentations 1', 2,
  13, 13,
  true, true, true,
  'content', 37
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e5627f59-c7db-4afe-8661-667e3792367c', 'objective', 'Create simple presentations of at most 5 slides when given a model of the presentation', 'create', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e5627f59-c7db-4afe-8661-667e3792367c', 'objective', 'Modify a presentation by adding and formatting objects such as images, sound, and videos', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '70119ec6-10a2-41c0-a631-1e4673609b53', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '69b76dff-d550-4cc9-b513-3d870e1ddfe5', 31,
  31, 'Create presentations 2', 2,
  13, 13,
  true, true, true,
  'content', 38
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70119ec6-10a2-41c0-a631-1e4673609b53', 'objective', 'Create animations using a presentation software that meet a given situation', 'create', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5c260d3c-eb15-4239-9061-3562baab104d', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '69b76dff-d550-4cc9-b513-3d870e1ddfe5', 32,
  32, 'Create publications', 2,
  14, 14,
  true, true, true,
  'content', 39
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5c260d3c-eb15-4239-9061-3562baab104d', 'objective', 'Produce a given publication when given the model of the publication', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f940211b-e6e9-407d-a858-0ed7fc10dcaa', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '69b76dff-d550-4cc9-b513-3d870e1ddfe5', 33,
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
  '4ae8ff4c-26be-4f9c-b300-a2a3f3df7bf6', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6f017d4c-6002-4ded-809b-af0039ea5c73', 34,
  34, 'Assistive technology and disabilities', 2,
  14, 14,
  true, false, false,
  'content', 41
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4ae8ff4c-26be-4f9c-b300-a2a3f3df7bf6', 'objective', 'Explain the concepts of disability, and assistive technology', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4ae8ff4c-26be-4f9c-b300-a2a3f3df7bf6', 'objective', 'Describe common assistive technologies for a given disability', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4ae8ff4c-26be-4f9c-b300-a2a3f3df7bf6', 'objective', 'Outline features common to operating systems aimed at helping the disabled', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6f946ff9-274b-4963-8e45-b6c3c0b75bfb', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6f017d4c-6002-4ded-809b-af0039ea5c73', 35,
  35, 'Assistive technologies for the elderly', 2,
  15, 15,
  true, false, false,
  'content', 42
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6f946ff9-274b-4963-8e45-b6c3c0b75bfb', 'objective', 'Explain the importance of assistive technologies for the elderly', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6f946ff9-274b-4963-8e45-b6c3c0b75bfb', 'objective', 'Describe technologies that can be used to assist the elderly', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e0576e2f-65d5-4a6f-b2c6-2d1f6847c089', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6f017d4c-6002-4ded-809b-af0039ea5c73', 36,
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
  '39bcdfcd-e778-425e-8ce6-ae411d679452', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '663c420b-fe30-4f6c-ba30-9d2386211a15', 37,
  37, 'Network hardware', 2,
  15, 15,
  true, false, false,
  'content', 44
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('39bcdfcd-e778-425e-8ce6-ae411d679452', 'objective', 'Explain the role of NIC, modem, router, multiplexer, bridge, repeater in a network', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('39bcdfcd-e778-425e-8ce6-ae411d679452', 'objective', 'Identify hardware needed for internet connectivity in a house, school or organizational network', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bae7b30e-70ec-43fb-94ee-3915aedd1be7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '663c420b-fe30-4f6c-ba30-9d2386211a15', 38,
  38, 'Network IP configuration', 2,
  16, 16,
  true, false, false,
  'content', 45
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bae7b30e-70ec-43fb-94ee-3915aedd1be7', 'objective', 'State the purpose of MAC address and IP address', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bae7b30e-70ec-43fb-94ee-3915aedd1be7', 'objective', 'Differentiate between IPv4 and IPv6 addresses', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bae7b30e-70ec-43fb-94ee-3915aedd1be7', 'objective', 'Compare static ip addresses to dynamic ip addresses', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bae7b30e-70ec-43fb-94ee-3915aedd1be7', 'objective', 'Explain the purpose of configuring ip addresses on a LAN', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7e03fb18-6a39-4ee3-978f-3f782c73164a', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '663c420b-fe30-4f6c-ba30-9d2386211a15', 39,
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
  'abf3fa9f-b0a9-4f7f-ab6a-8b43a61153fc', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '5703a304-13f4-4cf5-a60c-2414e21920d8', 40,
  40, 'Notions on packets', 2,
  16, 16,
  true, false, false,
  'content', 47
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('abf3fa9f-b0a9-4f7f-ab6a-8b43a61153fc', 'objective', 'Explain the concepts packet header, payload, trailer, packet switching', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('abf3fa9f-b0a9-4f7f-ab6a-8b43a61153fc', 'objective', 'Describe the structure of a packet', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('abf3fa9f-b0a9-4f7f-ab6a-8b43a61153fc', 'objective', 'Describe the USB interface and explain mechanisms it uses to transmit data', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5905e350-6917-4454-9622-2c419930e1e7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  'd66ccee9-dc53-44d6-b9ef-e25aeee4314b', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '5703a304-13f4-4cf5-a60c-2414e21920d8', 41,
  41, 'Error detection and packet security', 2,
  17, 17,
  true, false, false,
  'content', 49
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d66ccee9-dc53-44d6-b9ef-e25aeee4314b', 'objective', 'Explain the need to check for errors after data transmission and how these errors occur', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d66ccee9-dc53-44d6-b9ef-e25aeee4314b', 'objective', 'Explain the need for and purpose of encryption when transmitting data', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d66ccee9-dc53-44d6-b9ef-e25aeee4314b', 'objective', 'Describe error detection methods and how data is encrypted', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4bae07bd-7ef0-4fdc-852d-e55821aa7496', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '5703a304-13f4-4cf5-a60c-2414e21920d8', 42,
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
  '38f7c25b-3191-4d60-9bee-a2d6de5ca8f1', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  '6f9aae00-db24-4ddf-9f72-14e76593951e', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  'deb24ecc-91ab-4ff3-8be4-239900cc0af6', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'e135769e-b2da-4c56-b368-f1db2c45f981', 43,
  43, 'Notions on the internet', 2,
  18, 18,
  true, false, false,
  'content', 53
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('deb24ecc-91ab-4ff3-8be4-239900cc0af6', 'objective', 'Explain the concepts of internet, intranet, extranet, protocol', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('deb24ecc-91ab-4ff3-8be4-239900cc0af6', 'objective', 'Outline advantages and disadvantages of the internet', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('deb24ecc-91ab-4ff3-8be4-239900cc0af6', 'objective', 'Explain the role of ISP and browsers in accessing the internet', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('deb24ecc-91ab-4ff3-8be4-239900cc0af6', 'objective', 'Describe the importance of URL and its nomenclature', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8897e019-9c90-4dd8-b06f-eb96da0149a1', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'e135769e-b2da-4c56-b368-f1db2c45f981', 44,
  44, 'Notions on digital currency', 2,
  19, 19,
  true, false, false,
  'content', 54
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8897e019-9c90-4dd8-b06f-eb96da0149a1', 'objective', 'Outline common internet services', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8897e019-9c90-4dd8-b06f-eb96da0149a1', 'objective', 'Explain the concept of digital currencies and how they are used', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8897e019-9c90-4dd8-b06f-eb96da0149a1', 'objective', 'State examples of digital currencies', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8897e019-9c90-4dd8-b06f-eb96da0149a1', 'objective', 'Explain the process of block chain and how it is used to track digital currency transactions', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3e85db03-4bf4-4284-a694-3486e5f79358', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'e135769e-b2da-4c56-b368-f1db2c45f981', 45,
  45, 'Web authoring services', 2,
  19, 19,
  true, true, true,
  'content', 55
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3e85db03-4bf4-4284-a694-3486e5f79358', 'objective', 'Outline examples of web authoring tools', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3e85db03-4bf4-4284-a694-3486e5f79358', 'objective', 'State the role of HTML', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3e85db03-4bf4-4284-a694-3486e5f79358', 'objective', 'Build a simple web page using HTML and CSS', 'create', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '610aceb5-467b-4e48-b351-f5a779b6be71', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'e135769e-b2da-4c56-b368-f1db2c45f981', 46,
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
  '8bc20247-2f73-4388-8145-3c6528c8ec2b', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '1ad12e87-9d9d-411e-b932-b66d016ffe72', 47,
  47, 'Notions on social networks', 2,
  20, 20,
  true, false, false,
  'content', 57
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8bc20247-2f73-4388-8145-3c6528c8ec2b', 'objective', 'State the reasons for social networks', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8bc20247-2f73-4388-8145-3c6528c8ec2b', 'objective', 'State the characteristics of social networks', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8bc20247-2f73-4388-8145-3c6528c8ec2b', 'objective', 'State advantages and disadvantages of online social networks', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8bc20247-2f73-4388-8145-3c6528c8ec2b', 'objective', 'Explain the impacts of online social networks', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '461f4a51-6b54-45e5-a31a-7e000104b8d1', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '1ad12e87-9d9d-411e-b932-b66d016ffe72', 48,
  48, 'Using online social networks', 2,
  20, 20,
  true, false, false,
  'content', 58
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('461f4a51-6b54-45e5-a31a-7e000104b8d1', 'objective', 'Differentiate between social network and social media', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('461f4a51-6b54-45e5-a31a-7e000104b8d1', 'objective', 'Differentiate between different online social networks', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('461f4a51-6b54-45e5-a31a-7e000104b8d1', 'objective', 'Make use of an online social network to share resources and communicate', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '62ce1e58-a225-4a95-b1b9-bf5605313fd9', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '1ad12e87-9d9d-411e-b932-b66d016ffe72', 49,
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
  '9ccc1cf6-f495-42c7-b6ab-492d5254d078', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '934967e6-814a-48aa-af78-74b3c716ec3f', 50,
  50, 'Notions on security', 2,
  21, 21,
  true, false, false,
  'content', 60
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9ccc1cf6-f495-42c7-b6ab-492d5254d078', 'objective', 'Differentiate between computer security, data security, and network security', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9ccc1cf6-f495-42c7-b6ab-492d5254d078', 'objective', 'Differentiate between vulnerability, threat, and attack. Identify three security objectives', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9ccc1cf6-f495-42c7-b6ab-492d5254d078', 'objective', 'Identify common vulnerabilities linked to data, computers, or networks in a given context', 'analyse', 3);
INSERT INTO curriculum_load_log (syllabus_id, severity, message, source_ref) VALUES ('d280ec19-0e1f-436e-806e-f8c5fcdf9c6b', 'correction', 'Sheet prints this row as "501"; loaded as lesson 50', 'Notions on security');

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e9a5e553-bf60-4e88-8aac-647ee8725b26', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '934967e6-814a-48aa-af78-74b3c716ec3f', 51,
  51, 'Threats and attacks on computer systems', 2,
  21, 21,
  true, false, false,
  'content', 61
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e9a5e553-bf60-4e88-8aac-647ee8725b26', 'objective', 'Identify common threats on data, computers, and networks', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e9a5e553-bf60-4e88-8aac-647ee8725b26', 'objective', 'Describe common attacks on data, computers, and networks', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e9a5e553-bf60-4e88-8aac-647ee8725b26', 'objective', 'Describe the different types of malware', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1aa18307-e6c4-421e-b99a-9090b1d6cf45', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '934967e6-814a-48aa-af78-74b3c716ec3f', 52,
  52, 'Data, computer, and network security measures', 2,
  21, 21,
  true, false, false,
  'content', 62
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1aa18307-e6c4-421e-b99a-9090b1d6cf45', 'objective', 'Explain measures to secure data', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1aa18307-e6c4-421e-b99a-9090b1d6cf45', 'objective', 'Explain measures to secure a computer', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1aa18307-e6c4-421e-b99a-9090b1d6cf45', 'objective', 'Explain measures to secure a network', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1aa18307-e6c4-421e-b99a-9090b1d6cf45', 'objective', 'Outline common data recovery strategies', 'remember', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6735b8d8-966b-400a-bc38-4bd5dcc32c75', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '934967e6-814a-48aa-af78-74b3c716ec3f', 53,
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
  '0f0381ea-3a65-402f-b24c-6bbcf2be5285', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '7f0274a6-6ff5-4455-910d-ef5c26faf700', 54,
  54, 'Notions on digital identities and digital footprints', 2,
  22, 22,
  true, false, false,
  'content', 64
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0f0381ea-3a65-402f-b24c-6bbcf2be5285', 'objective', 'Explain the following concepts: digital identity, password, username, identity theft, digital footprint, passive and active digital footprint', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0f0381ea-3a65-402f-b24c-6bbcf2be5285', 'objective', 'Explain characteristics of a good password', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0f0381ea-3a65-402f-b24c-6bbcf2be5285', 'objective', 'Explain ways that a user creates passive and active digital footprints', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e6faeb1f-2111-4101-b549-2a930c917a0a', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '7f0274a6-6ff5-4455-910d-ef5c26faf700', 55,
  55, 'Digital identities and footprints management', 2,
  22, 22,
  true, false, false,
  'content', 65
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e6faeb1f-2111-4101-b549-2a930c917a0a', 'objective', 'Outline best practices to manage multiple digital identities', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e6faeb1f-2111-4101-b549-2a930c917a0a', 'objective', 'State positive and negative effects of digital footprints', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e6faeb1f-2111-4101-b549-2a930c917a0a', 'objective', 'Explain ways of protecting digital footprints', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3d6d08b1-1715-4f07-bcd9-9d15ed8cba93', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '7f0274a6-6ff5-4455-910d-ef5c26faf700', 56,
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
  '8360933b-512b-48a7-9da4-dfbb83cc7fdc', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  'b01d2454-43a2-44e7-beea-c8511491d29a', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '96344811-dc82-4152-b7e0-684011f96f0a', 57,
  57, 'Protecting Intellectual property', 2,
  23, 23,
  true, false, false,
  'content', 68
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b01d2454-43a2-44e7-beea-c8511491d29a', 'objective', 'Explain the concepts of intellectual property, trademark, patent, copyright, license', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b01d2454-43a2-44e7-beea-c8511491d29a', 'objective', 'Identify the freedoms provided by a given type of license', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b01d2454-43a2-44e7-beea-c8511491d29a', 'objective', 'State possible national and international consequences of non-respect of intellectual property', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b01d2454-43a2-44e7-beea-c8511491d29a', 'objective', 'Identify exceptions and legal limitations of using and sharing copyrighted content', 'analyse', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ace828e3-8d0f-4bf5-9b38-34b79eb02c50', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '96344811-dc82-4152-b7e0-684011f96f0a', 58,
  58, 'Assigning and respecting digital licenses', 2,
  23, 23,
  true, false, false,
  'content', 69
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ace828e3-8d0f-4bf5-9b38-34b79eb02c50', 'objective', 'Match each type of creative common license to a given permission', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ace828e3-8d0f-4bf5-9b38-34b79eb02c50', 'objective', 'Explain ways of identifying free and copyrighted digital content', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ace828e3-8d0f-4bf5-9b38-34b79eb02c50', 'objective', 'State platforms where free digital content can be found', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ace828e3-8d0f-4bf5-9b38-34b79eb02c50', 'objective', 'State ways of sharing and using digital content legally', 'remember', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd611235a-fefe-48fb-965f-6dc6cd1dd90a', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '96344811-dc82-4152-b7e0-684011f96f0a', 59,
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
  'e78ebb12-0fb3-48e6-965d-2db5972b53ec', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  'fbf69190-b2da-4efa-b535-c2b863e61dad', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  'aa0b1dcc-cba8-4826-81af-6a6524620872', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6016a5c4-576b-4861-a56b-38d5ac412b56', 60,
  60, 'Notions on data encoding', 3,
  25, 25,
  true, false, false,
  'content', 73
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('aa0b1dcc-cba8-4826-81af-6a6524620872', 'objective', 'Explain how data is represented in the computer', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('aa0b1dcc-cba8-4826-81af-6a6524620872', 'objective', 'Distinguish between data numbers, characters, images and sound', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('aa0b1dcc-cba8-4826-81af-6a6524620872', 'objective', 'Outline techniques used to encode numbers, characters, images, and sound', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f861b992-f60b-47d4-b395-224aa303ddf8', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6016a5c4-576b-4861-a56b-38d5ac412b56', 61,
  61, 'Character and positive integers encoding', 3,
  25, 25,
  true, false, false,
  'content', 74
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f861b992-f60b-47d4-b395-224aa303ddf8', 'objective', 'Apply a given character encoding scheme to represent a set of characters', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f861b992-f60b-47d4-b395-224aa303ddf8', 'objective', 'Determine the base 2 representation of a positive integer', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '20469aa5-7fc2-4e3c-8d58-4f29dbef46bc', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6016a5c4-576b-4861-a56b-38d5ac412b56', 62,
  62, 'Addition and subtraction in base 2, 8 and 16', 3,
  26, 26,
  true, false, false,
  'content', 75
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20469aa5-7fc2-4e3c-8d58-4f29dbef46bc', 'objective', 'Identify symbols of base 2, 8 and 16', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20469aa5-7fc2-4e3c-8d58-4f29dbef46bc', 'objective', 'Perform addition in any number system', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20469aa5-7fc2-4e3c-8d58-4f29dbef46bc', 'objective', 'Perform subtraction in any number system', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7a89fd0a-fa87-4dcf-936c-cda93e3a0798', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '6016a5c4-576b-4861-a56b-38d5ac412b56', 63,
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
  '432a4296-e8cc-4dd4-a5aa-6ab2e7653d54', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '3adb6e35-ec23-434c-bb46-9d11c0f035c4', 64,
  64, 'Logic gates', 3,
  26, 26,
  true, false, false,
  'content', 77
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('432a4296-e8cc-4dd4-a5aa-6ab2e7653d54', 'objective', 'Identify various logic gates', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('432a4296-e8cc-4dd4-a5aa-6ab2e7653d54', 'objective', 'Describe the different types of logic gates', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('432a4296-e8cc-4dd4-a5aa-6ab2e7653d54', 'objective', 'Draw the truth table for a logic gate', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '828e85b3-d9fb-45ed-9f3c-06af67a0b6d1', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '3adb6e35-ec23-434c-bb46-9d11c0f035c4', 65,
  65, 'Logic circuits and expressions', 3,
  27, 27,
  true, false, false,
  'content', 78
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('828e85b3-d9fb-45ed-9f3c-06af67a0b6d1', 'objective', 'Identify logic gates in a circuit or an expression', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('828e85b3-d9fb-45ed-9f3c-06af67a0b6d1', 'objective', 'Produce the truth table or a logic circuit or expression', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('828e85b3-d9fb-45ed-9f3c-06af67a0b6d1', 'objective', 'Produce a logic circuit when given a logic expression', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '77e303f0-3766-428c-948a-1c1783ebca48', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '3adb6e35-ec23-434c-bb46-9d11c0f035c4', 66,
  66, 'De Morgan''s law and Boolean simplification', 3,
  27, 27,
  true, false, false,
  'content', 79
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('77e303f0-3766-428c-948a-1c1783ebca48', 'objective', 'State the De Morgan''s laws', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('77e303f0-3766-428c-948a-1c1783ebca48', 'objective', 'Identify situations where De Morgan''s law can be used', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('77e303f0-3766-428c-948a-1c1783ebca48', 'objective', 'State common laws of Boolean simplification', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1f9796d5-982d-4493-99dd-923a8e538569', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '3adb6e35-ec23-434c-bb46-9d11c0f035c4', 67,
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
  'b78637cf-a92f-4c7e-99fe-de15860b432b', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '51f3b1c3-d64e-4206-8f46-7cf19c11bded', 68,
  68, 'Notions on organizations and information', 3,
  28, 28,
  true, false, false,
  'content', 81
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b78637cf-a92f-4c7e-99fe-de15860b432b', 'objective', 'Explain the concepts of information and organization', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b78637cf-a92f-4c7e-99fe-de15860b432b', 'objective', 'Explain the characteristics of good information', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b78637cf-a92f-4c7e-99fe-de15860b432b', 'objective', 'Explain the flow of information within an organization', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '409eed2d-675b-4f36-8135-167c7b317380', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '51f3b1c3-d64e-4206-8f46-7cf19c11bded', 69,
  69, 'Information systems', 3,
  29, 29,
  true, false, false,
  'content', 82
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('409eed2d-675b-4f36-8135-167c7b317380', 'objective', 'Define an information system', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('409eed2d-675b-4f36-8135-167c7b317380', 'objective', 'Differentiate manual and automated information systems', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('409eed2d-675b-4f36-8135-167c7b317380', 'objective', 'Describe the elements of an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fb051647-cd4a-4575-9a86-e199a07ded3f', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '51f3b1c3-d64e-4206-8f46-7cf19c11bded', 70,
  70, 'Types of information system', 3,
  29, 29,
  true, false, false,
  'content', 83
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fb051647-cd4a-4575-9a86-e199a07ded3f', 'objective', 'Describe common types of information system', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fb051647-cd4a-4575-9a86-e199a07ded3f', 'objective', 'Differentiate between batch processing and real-time processing', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fb051647-cd4a-4575-9a86-e199a07ded3f', 'objective', 'Explain how choosing an appropriate process can help ensure the efficiency of an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0179e45d-8267-4a4d-a8cf-2b7021209ef7', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  '5b223543-ddf9-41ed-b0a6-4e9857984c5b', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '51f3b1c3-d64e-4206-8f46-7cf19c11bded', 71,
  71, 'Data capture methods', 3,
  30, 30,
  true, false, false,
  'content', 85
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5b223543-ddf9-41ed-b0a6-4e9857984c5b', 'objective', 'Explain the concept of data capture', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5b223543-ddf9-41ed-b0a6-4e9857984c5b', 'objective', 'Describe common manual and automated data capture methods', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5b223543-ddf9-41ed-b0a6-4e9857984c5b', 'objective', 'Explain how automated data capture helps improve effectiveness, and reliability of an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '118e3055-36a7-4bf8-a2a4-4210742b9a19', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  '704d7e06-9dde-41d5-98b5-35d93c78d3c8', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  'bde25e1a-458a-4449-91ad-d23d8ba50682', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '51f3b1c3-d64e-4206-8f46-7cf19c11bded', 72,
  72, 'Data verification and validation', 3,
  31, 31,
  true, false, false,
  'content', 88
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bde25e1a-458a-4449-91ad-d23d8ba50682', 'objective', 'Differentiate between data verification and data validation', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bde25e1a-458a-4449-91ad-d23d8ba50682', 'objective', 'Describe data verification and data validation methods', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bde25e1a-458a-4449-91ad-d23d8ba50682', 'objective', 'Explain how data validation and data verification ensure the effectiveness, and reliability of an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cdf6c225-3f5f-41ad-b718-dbca08a78551', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '51f3b1c3-d64e-4206-8f46-7cf19c11bded', 73,
  73, 'Data integrity', 3,
  31, 31,
  true, false, false,
  'content', 89
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cdf6c225-3f5f-41ad-b718-dbca08a78551', 'objective', 'Explain the concept of data integrity', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cdf6c225-3f5f-41ad-b718-dbca08a78551', 'objective', 'Explain why ensuring data integrity is important in an information system', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cdf6c225-3f5f-41ad-b718-dbca08a78551', 'objective', 'Explain ways of ensuring data integrity in an information system', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '83bb3e86-e856-40dd-ac26-587d0667579a', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '51f3b1c3-d64e-4206-8f46-7cf19c11bded', 74,
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
  '47067dd3-33f9-4515-aac7-c22cea718b06', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'cee3d54a-9bd0-4b77-bbb8-9cad954804d5', 75,
  75, 'Introduction to databases', 3,
  32, 32,
  true, false, false,
  'content', 91
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('47067dd3-33f9-4515-aac7-c22cea718b06', 'objective', 'Describe common types of database', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('47067dd3-33f9-4515-aac7-c22cea718b06', 'objective', 'Outline advantages and disadvantages of flat file systems', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('47067dd3-33f9-4515-aac7-c22cea718b06', 'objective', 'State common features of a DBMS', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fa70448e-7163-428d-bb74-961ed457996e', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'cee3d54a-9bd0-4b77-bbb8-9cad954804d5', 76,
  76, 'Relational database design', 3,
  32, 32,
  true, false, false,
  'content', 92
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fa70448e-7163-428d-bb74-961ed457996e', 'objective', 'Explain the concepts of attribute, record, table, primary key, foreign key, relationship', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fa70448e-7163-428d-bb74-961ed457996e', 'objective', 'Identify attributes, tables, primary key, and relationships in a given situation', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '90b8dc73-11e2-447f-a016-cf4139d0ac13', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'cee3d54a-9bd0-4b77-bbb8-9cad954804d5', 77,
  77, 'Normalization and Relational models', 3,
  32, 32,
  true, false, false,
  'content', 93
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90b8dc73-11e2-447f-a016-cf4139d0ac13', 'objective', 'Explain the purpose of normalization', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90b8dc73-11e2-447f-a016-cf4139d0ac13', 'objective', 'State the properties of a database in 1NF, 2NF, and 3NF', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90b8dc73-11e2-447f-a016-cf4139d0ac13', 'objective', 'Identify attributes, tables, primary key, foreign key, and relationships in a given situation', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '69b79f78-a0aa-4ea9-89ab-f05fa61bc01c', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'cee3d54a-9bd0-4b77-bbb8-9cad954804d5', 78,
  78, 'Use an RDBMS to create tables', 3,
  33, 33,
  true, true, true,
  'content', 94
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('69b79f78-a0aa-4ea9-89ab-f05fa61bc01c', 'objective', 'Outline examples of an RDBMS', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('69b79f78-a0aa-4ea9-89ab-f05fa61bc01c', 'objective', 'Identify common features of a given GUI RDBMS', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('69b79f78-a0aa-4ea9-89ab-f05fa61bc01c', 'objective', 'Make use of a GUI RDBMS to create tables', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7bd8d4b9-7fae-432a-834e-0de5bb6da26c', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'cee3d54a-9bd0-4b77-bbb8-9cad954804d5', 79,
  79, 'Use an RDBMS to create relationships', 3,
  33, 33,
  true, true, true,
  'content', 95
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7bd8d4b9-7fae-432a-834e-0de5bb6da26c', 'objective', 'Make use of a GUI RDBMS to create relationships', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7bd8d4b9-7fae-432a-834e-0de5bb6da26c', 'objective', 'Enter data in a table found in a GUI RDBMS', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7bd8d4b9-7fae-432a-834e-0de5bb6da26c', 'objective', 'Perform simple operations such as sorting and filtering data with the aid of a GUI RDBMS', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a29aed42-f8e5-48a7-8705-8b2235f6c05e', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'cee3d54a-9bd0-4b77-bbb8-9cad954804d5', 80,
  80, 'Use an RDBMS to create queries and reports', 3,
  33, 33,
  true, true, true,
  'content', 96
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a29aed42-f8e5-48a7-8705-8b2235f6c05e', 'objective', 'Explain the concepts of database queries and reports', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a29aed42-f8e5-48a7-8705-8b2235f6c05e', 'objective', 'Make use of a GUI RDBMS to create queries that is coherent to a situation', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a29aed42-f8e5-48a7-8705-8b2235f6c05e', 'objective', 'Make use of a GUI RDBMS to create reports', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a210cb60-421f-4b02-a663-d0f98a546a99', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, 'cee3d54a-9bd0-4b77-bbb8-9cad954804d5', 81,
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
  '61d793f7-593b-49e7-b1c0-06867aaf5336', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '773a8f7c-6722-4f73-86aa-1c2b965fc8b4', 82,
  82, 'Stages of SDLC: investigation, analysis, design', 3,
  34, 34,
  true, false, false,
  'content', 98
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61d793f7-593b-49e7-b1c0-06867aaf5336', 'objective', 'Describe the investigation, analysis and design stages of the SDLC', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61d793f7-593b-49e7-b1c0-06867aaf5336', 'objective', 'Outline the functions of a system to be developed', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61d793f7-593b-49e7-b1c0-06867aaf5336', 'objective', 'Explain the concept of prototyping', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61d793f7-593b-49e7-b1c0-06867aaf5336', 'objective', 'Explain the need for appropriate choice of hardware and software for a system', 'understand', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'afa70655-0d34-4695-8243-4875746db233', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '773a8f7c-6722-4f73-86aa-1c2b965fc8b4', 83,
  83, 'Stages of SDLC: development, testing, implementation, maintenance', 3,
  34, 34,
  true, false, false,
  'content', 99
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('afa70655-0d34-4695-8243-4875746db233', 'objective', 'Describe the development, testing, implementation, and maintenance stages of the SDLC', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('afa70655-0d34-4695-8243-4875746db233', 'objective', 'Explain the need for documentation in system development', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ad27fe83-10b7-4986-a8e4-228cdb14e207', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '773a8f7c-6722-4f73-86aa-1c2b965fc8b4', 84,
  84, 'Implementation strategies', 3,
  34, 34,
  true, false, false,
  'content', 100
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ad27fe83-10b7-4986-a8e4-228cdb14e207', 'objective', 'Describe the different implementation strategies', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ad27fe83-10b7-4986-a8e4-228cdb14e207', 'objective', 'Outline the advantages and disadvantages of a given implementation strategy', 'remember', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '31571273-30e0-4406-a4c5-f2a7a09b8934', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '773a8f7c-6722-4f73-86aa-1c2b965fc8b4', 85,
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
  'b7bc39fc-e692-41ac-b809-15532e0ded7c', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '4460b1f2-e24d-444a-9a87-67f85282cf45', 86,
  86, 'Introduction to project management', 3,
  35, 35,
  true, false, false,
  'content', 102
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b7bc39fc-e692-41ac-b809-15532e0ded7c', 'objective', 'Explain the concept of project', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b7bc39fc-e692-41ac-b809-15532e0ded7c', 'objective', 'Explain the need for project management', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b7bc39fc-e692-41ac-b809-15532e0ded7c', 'objective', 'Describe the phases of the project life cycle', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'aba500fc-e358-4903-9e96-eba36f6a8db3', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '4460b1f2-e24d-444a-9a87-67f85282cf45', 87,
  87, 'Project management tools', 3,
  35, 35,
  true, false, false,
  'content', 103
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('aba500fc-e358-4903-9e96-eba36f6a8db3', 'objective', 'Describe tools used to plan, monitor and control a project', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('aba500fc-e358-4903-9e96-eba36f6a8db3', 'objective', 'Produce the Gantt chart for a project', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '778d3b00-c6f5-460b-a99f-b3b27c23c3c6', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '4460b1f2-e24d-444a-9a87-67f85282cf45', 88,
  88, 'Project management concepts and metrics 1', 3,
  35, 35,
  true, false, false,
  'content', 104
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('778d3b00-c6f5-460b-a99f-b3b27c23c3c6', 'objective', 'Explain the concept of task, milestone, critical path, slack time, duration of project, critical tasks', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('778d3b00-c6f5-460b-a99f-b3b27c23c3c6', 'objective', 'Determine the critical path, slack time, and duration of a project from a Gantt chart', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cfb660c7-75e4-438c-8fa7-cea10181781b', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '4460b1f2-e24d-444a-9a87-67f85282cf45', 89,
  89, 'Project management concepts and metrics 2', 3,
  36, 36,
  true, false, false,
  'content', 105
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cfb660c7-75e4-438c-8fa7-cea10181781b', 'objective', 'Explain the concepts of early start, early finish, late start, and late finish', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cfb660c7-75e4-438c-8fa7-cea10181781b', 'objective', 'Determine the early start, early finish, late start, and late finish in a given situation', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd425425d-4e11-4f41-b9a2-601c2ad57250', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, '4460b1f2-e24d-444a-9a87-67f85282cf45', 90,
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
  'd89d107f-7398-41c4-8827-983577181fd0', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
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
  'eb39d5e5-27ff-4e75-8d03-1cf7c180fe73', 'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b', NULL, NULL, NULL,
  NULL, 'Remediation', 3,
  36, 36,
  true, false, false,
  'remediation', 108
);

-- Proposed continuity with the previous year (unconfirmed).
UPDATE competencies SET
  continues_from_id = (
    SELECT c.id FROM competencies c
    JOIN syllabi s ON s.id = c.syllabus_id
    WHERE c.category_of_action = 'Using control structures'
      AND s.form_level = 'Form 4'
    LIMIT 1
  ),
  link_confirmed = false
WHERE id = 'c1ba3abd-b1f8-4ce9-a113-25ce9c054f1f';
UPDATE competencies SET
  continues_from_id = (
    SELECT c.id FROM competencies c
    JOIN syllabi s ON s.id = c.syllabus_id
    WHERE c.category_of_action = 'Writing of source code'
      AND s.form_level = 'Form 4'
    LIMIT 1
  ),
  link_confirmed = false
WHERE id = 'bffc774a-f659-4a78-9112-5bc86ba5eb4d';
UPDATE competencies SET
  continues_from_id = (
    SELECT c.id FROM competencies c
    JOIN syllabi s ON s.id = c.syllabus_id
    WHERE c.category_of_action = 'Choosing appropriate peripheral devices'
      AND s.form_level = 'Form 4'
    LIMIT 1
  ),
  link_confirmed = false
WHERE id = '1e4c002c-f1a9-4daa-959e-bcc646a6fd84';
UPDATE competencies SET
  continues_from_id = (
    SELECT c.id FROM competencies c
    JOIN syllabi s ON s.id = c.syllabus_id
    WHERE c.category_of_action = 'Operations on number systems'
      AND s.form_level = 'Form 4'
    LIMIT 1
  ),
  link_confirmed = false
WHERE id = '6016a5c4-576b-4861-a56b-38d5ac412b56';
UPDATE competencies SET
  continues_from_id = (
    SELECT c.id FROM competencies c
    JOIN syllabi s ON s.id = c.syllabus_id
    WHERE c.category_of_action = 'Analysing simple logic circuits'
      AND s.form_level = 'Form 4'
    LIMIT 1
  ),
  link_confirmed = false
WHERE id = '3adb6e35-ec23-434c-bb46-9d11c0f035c4';
UPDATE competencies SET
  continues_from_id = (
    SELECT c.id FROM competencies c
    JOIN syllabi s ON s.id = c.syllabus_id
    WHERE c.category_of_action = 'Creating digital content'
      AND s.form_level = 'Form 4'
    LIMIT 1
  ),
  link_confirmed = false
WHERE id = '69b76dff-d550-4cc9-b513-3d870e1ddfe5';

COMMIT;
