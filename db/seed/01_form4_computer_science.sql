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
  '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b',
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

INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('3d583d84-774f-44c5-9e68-a44e014130a1', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'Problem solving and coding 2', 1);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('e33e043e-26b5-45c9-b675-c925141bd2c3', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'Data manipulation 1', 2);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('ff3d1642-d81b-4965-b8b3-3c9ceb353b9c', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'Hardware and software systems 2', 3);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('2e459dab-52dc-47c6-a142-a561d7a93ae8', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'Ethics, society and legal issues 2', 4);

INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('46449853-38cc-4062-a5fa-f1690a310f51', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', '3d583d84-774f-44c5-9e68-a44e014130a1', 'Using control structures', 'Given an algorithmic problem that requires the use of control structures, learners produce algorithms that use the appropriate control structure to solve the problem.', 1);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('b2f6adca-0438-4471-b52e-3a988c967e1e', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', '3d583d84-774f-44c5-9e68-a44e014130a1', 'Testing and debugging', 'Given an algorithm, learners evaluate its semantic correctness using the dry-run technique and propose a way of fixing errors if any.', 2);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e9c882d0-b3ca-41d1-b03b-f0b4ab973759', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', '3d583d84-774f-44c5-9e68-a44e014130a1', 'Setting up a programming environment', 'Given a problem, learners select the appropriate tools for programming and install them.', 3);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('2631b9d4-ef58-4fc9-899c-0277f5dc985a', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', '3d583d84-774f-44c5-9e68-a44e014130a1', 'Writing of source code', 'Given an algorithm, learners transform it into a syntactically and semantically correct program.', 4);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('3d1f87f5-18b6-42c4-831e-5dce22ebae98', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'e33e043e-26b5-45c9-b675-c925141bd2c3', 'Operations on number systems', 'Presented with a situation that involves number systems, learners apply appropriate operations on number systems to solve the problem.', 5);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('6904c52e-06b8-4a91-8133-a0e68194388d', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'e33e043e-26b5-45c9-b675-c925141bd2c3', 'Analysing simple logic circuits', 'Learners analyse a situation concerning logic circuits and determine the correct outputs and truth tables of the different elements used in the circuit.', 6);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('4eb38ed9-35a9-411c-ad05-77a2f86c0996', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'ff3d1642-d81b-4965-b8b3-3c9ceb353b9c', 'Optimising computer performance', 'Provided with a situation with issues related to optimising a computer, learners propose methods of optimising the computer which are coherent with the situation.', 7);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('51515b55-d986-4f55-aa10-c6add2645c22', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'ff3d1642-d81b-4965-b8b3-3c9ceb353b9c', 'Choosing appropriate peripheral devices', 'Learners select appropriate peripheral devices based on a situation or context. Clear justification of the choice should be made.', 8);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('58208d09-0ca6-416b-b659-f3156144d653', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'ff3d1642-d81b-4965-b8b3-3c9ceb353b9c', 'Calculating storage space', 'Given a problem with factors related to storage space and units, learners determine the cause and solution to the problem showing clearly how they achieved the proposed conclusions.', 9);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('32e005ff-bf41-42f1-ae08-337ab0255fc5', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'ff3d1642-d81b-4965-b8b3-3c9ceb353b9c', 'Carrying out basic computer maintenance', 'When presented with a situation involving issues with a computer, learners propose possible causes and possible methods to fix such issues.', 10);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('a2b4de13-67e4-40e7-883a-604976f6b8d9', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'ff3d1642-d81b-4965-b8b3-3c9ceb353b9c', 'Creating digital content', 'Faced with a situation related to the creation and editing of digital content, learners propose a variety of tools that can be used to solve the problem and produce digital content using an appropriate tool.', 11);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('974b5650-e69f-4649-9619-de6b5261f7e9', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'ff3d1642-d81b-4965-b8b3-3c9ceb353b9c', 'Producing word processed documents', 'Given a task that is related to using a word processor to produce or reproduce content, learners use appropriate features of a word processor to achieve the task.', 12);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e35edbfe-ee43-45a5-8e67-d9850c83bb8e', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'ff3d1642-d81b-4965-b8b3-3c9ceb353b9c', 'Manipulating spreadsheets', 'Given tasks that is related to spreadsheets and with appropriate guidance, learners choose functions or spreadsheet features that are coherent with the tasks and apply them correctly on spreadsheet software.', 13);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('a7ea2051-7452-4f34-9f5b-bf4e92f71d1b', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', 'ff3d1642-d81b-4965-b8b3-3c9ceb353b9c', 'Understanding embedded system IoT and Cloud Computing', 'Given a situation with factors related to IoT and embedded systems, learners identify the correct type of sensors used in the situation and their role.', 14);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('5995b54d-76e9-49f8-a7b7-73aec68b0c86', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', '2e459dab-52dc-47c6-a142-a561d7a93ae8', 'Practising netiquette rules', 'Placed in a context that requires communicating with others, learners determine and apply appropriate behavioural norms that respect others and their cultural and generational diversities.', 15);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('7eb55e9b-3a2e-4f55-80e0-df3f12190394', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', '2e459dab-52dc-47c6-a142-a561d7a93ae8', 'Appraising National and International Laws on Cybersecurity', 'Learners state national and international laws or acts that are related to protecting and regulating activities in the cyberspace.', 16);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e24d5627-634c-4dc7-bec9-b343d8ec9039', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', '2e459dab-52dc-47c6-a142-a561d7a93ae8', 'Evaluating the credibility and reliability of information', 'Given a problem with factors related to the reliability and credibility of information, learners propose strategies of verifying the information. The strategies proposed should be pertinent, coherent, and logical.', 17);
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('56619e3c-031e-498b-b143-f7ffbff0ecd8', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', '2e459dab-52dc-47c6-a142-a561d7a93ae8', 'Avoiding computer related health issues', 'Given a problem or a situation related to avoiding computer related issues, learners evaluate the workplace, practices and habits of users based on standards and report on elements to reinforce and elements to adjust. The recommendations should express appropriate practices and health issues that can arise for not respecting these practices.', 18);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5ebf42ba-949c-46a0-9b7a-11c7414ed831', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '78ef2f54-a02f-45b4-87f9-5cc7b282f0e3', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '46449853-38cc-4062-a5fa-f1690a310f51', 1,
  1, 'Sequence and selection control structure', 1,
  1, 1,
  true, false, false,
  'content', 2
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78ef2f54-a02f-45b4-87f9-5cc7b282f0e3', 'objective', 'Explain how sequence and selection control structures work', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78ef2f54-a02f-45b4-87f9-5cc7b282f0e3', 'objective', 'Illustrate the functioning of sequence and selection control structures with a flowchart', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78ef2f54-a02f-45b4-87f9-5cc7b282f0e3', 'objective', 'Write simple algorithms that make use of a selection control structure', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '81feeed9-da34-42e6-a22a-d4ec15a95332', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '46449853-38cc-4062-a5fa-f1690a310f51', 2,
  2, 'Multiple selection constructs', 1,
  1, 1,
  true, false, false,
  'content', 3
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('81feeed9-da34-42e6-a22a-d4ec15a95332', 'objective', 'Explain how the different types of multiple selection constructs work', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('81feeed9-da34-42e6-a22a-d4ec15a95332', 'objective', 'Illustrate the functioning of the different multiple selection constructs', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('81feeed9-da34-42e6-a22a-d4ec15a95332', 'objective', 'Write algorithms that make use of multiple selection control structures', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6dc2a931-5616-487e-ae6c-91c5677eef40', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '46449853-38cc-4062-a5fa-f1690a310f51', 3,
  3, 'Iterative constructs', 1,
  2, 2,
  true, false, false,
  'content', 4
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6dc2a931-5616-487e-ae6c-91c5677eef40', 'objective', 'Identify situations where an iterative or loop control structure is needed', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6dc2a931-5616-487e-ae6c-91c5677eef40', 'objective', 'Describe the 4 main parts of a loop', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6dc2a931-5616-487e-ae6c-91c5677eef40', 'objective', 'Explain advantages and disadvantages of iterative control structures', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '83fa428e-05bd-475d-96e9-357934c16ce6', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '46449853-38cc-4062-a5fa-f1690a310f51', 4,
  4, 'Definite iterative constructs', 1,
  2, 2,
  true, false, false,
  'content', 5
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('83fa428e-05bd-475d-96e9-357934c16ce6', 'objective', 'Choose correctly when to use a definite iteration', 'evaluate', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('83fa428e-05bd-475d-96e9-357934c16ce6', 'objective', 'Build definite iterations that are coherent with a given context', 'create', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('83fa428e-05bd-475d-96e9-357934c16ce6', 'objective', 'Write simple algorithms that make use of definite iteration', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e570f0f5-2d8e-426a-ba95-11a117defe8a', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '46449853-38cc-4062-a5fa-f1690a310f51', 5,
  5, 'Indefinite iterative constructs', 1,
  2, 2,
  true, false, false,
  'content', 6
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e570f0f5-2d8e-426a-ba95-11a117defe8a', 'objective', 'Differentiate between pretest and posttest indefinite iterations', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e570f0f5-2d8e-426a-ba95-11a117defe8a', 'objective', 'Illustrate the functioning of indefinite iterations using a flowchart', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e570f0f5-2d8e-426a-ba95-11a117defe8a', 'objective', 'Write simple algorithms that make use of indefinite iteration', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd2e0275c-967f-4996-8028-23332e3b3e74', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '46449853-38cc-4062-a5fa-f1690a310f51', 6,
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
  '72abe4a6-562e-4d59-82b9-e2e604cac01c', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'b2f6adca-0438-4471-b52e-3a988c967e1e', 7,
  7, 'Notions on testing and debugging', 1,
  3, 3,
  true, false, false,
  'content', 8
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('72abe4a6-562e-4d59-82b9-e2e604cac01c', 'objective', 'Explain the concepts of testing, test case, test data and bug', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('72abe4a6-562e-4d59-82b9-e2e604cac01c', 'objective', 'Differentiate between testing and debugging', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('72abe4a6-562e-4d59-82b9-e2e604cac01c', 'objective', 'Differentiate between black box test and white box test', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '485fc8c5-6b76-40ab-9c4d-fa3dc840f2e4', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'b2f6adca-0438-4471-b52e-3a988c967e1e', 8,
  8, 'Dry running', 1,
  3, 3,
  true, false, false,
  'content', 9
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('485fc8c5-6b76-40ab-9c4d-fa3dc840f2e4', 'objective', 'Explain the concepts of dry running and trace tables', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('485fc8c5-6b76-40ab-9c4d-fa3dc840f2e4', 'objective', 'Perform a dry run test on an algorithm', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '85a58fcf-49bc-402b-b335-34c05cc0a3d2', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'b2f6adca-0438-4471-b52e-3a988c967e1e', 9,
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
  'd59a7827-ff00-473a-84bd-2a5e4862f9d0', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e9c882d0-b3ca-41d1-b03b-f0b4ab973759', 10,
  10, 'Programming tools', 1,
  4, 4,
  true, false, false,
  'content', 11
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d59a7827-ff00-473a-84bd-2a5e4862f9d0', 'objective', 'State the role of the following programming tools: text editor, translator, and IDE', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d59a7827-ff00-473a-84bd-2a5e4862f9d0', 'objective', 'Differentiate between a compiler and an interpreter', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d59a7827-ff00-473a-84bd-2a5e4862f9d0', 'objective', 'Explain the advantages and disadvantages of installing an IDE over separate programming tools and vice-versa', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '05f6db92-91d5-4e75-ba82-6ac6eb89bcb6', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e9c882d0-b3ca-41d1-b03b-f0b4ab973759', 11,
  11, 'Installation of programming tools', 1,
  4, 4,
  true, true, true,
  'content', 12
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('05f6db92-91d5-4e75-ba82-6ac6eb89bcb6', 'objective', 'Install an IDE and use it to run a program', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('05f6db92-91d5-4e75-ba82-6ac6eb89bcb6', 'objective', 'Test the functionalities of an installed programming tool', 'analyse', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '75b77e3a-9222-427f-b651-3005990b582e', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e9c882d0-b3ca-41d1-b03b-f0b4ab973759', 12,
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
  '1acec26c-c811-43e8-b36b-bd9502c89444', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  'b4c1946d-c724-4e65-a864-35cd3ad9c100', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '2631b9d4-ef58-4fc9-899c-0277f5dc985a', 13,
  13, 'Introduction to coding', 1,
  5, 5,
  true, false, false,
  'content', 15
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4c1946d-c724-4e65-a864-35cd3ad9c100', 'objective', 'Explain the concept of coding', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4c1946d-c724-4e65-a864-35cd3ad9c100', 'objective', 'Explain strategies that can be used to ease coding', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4c1946d-c724-4e65-a864-35cd3ad9c100', 'objective', 'Identify the structure of a program in a given programming language', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2f14827e-36b3-455d-9cf3-5ae58acc00aa', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '2631b9d4-ef58-4fc9-899c-0277f5dc985a', 14,
  14, 'Coding 1', 1,
  6, 6,
  true, true, true,
  'content', 16
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2f14827e-36b3-455d-9cf3-5ae58acc00aa', 'objective', 'Write source code that makes use of input, output, mathematical and assignment operators', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'df409644-928e-4499-a1ec-2f3f95bfcd3f', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  'ec555874-d4a7-4b42-bcd0-ed017e3850d4', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '4f92715f-5547-4ece-9fba-42c4f2bdceb1', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '2631b9d4-ef58-4fc9-899c-0277f5dc985a', 15,
  15, 'Coding 2', 1,
  7, 7,
  true, true, true,
  'content', 19
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4f92715f-5547-4ece-9fba-42c4f2bdceb1', 'objective', 'Write source code that makes use of selection control structures', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b3e61e8e-ae2e-426f-8716-f12704e85014', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '2631b9d4-ef58-4fc9-899c-0277f5dc985a', 16,
  16, 'Coding 3', 1,
  7, 7,
  true, true, true,
  'content', 20
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b3e61e8e-ae2e-426f-8716-f12704e85014', 'objective', 'Write source code that make use of multiple selection control structures', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd1cf1483-eb6f-4ddd-b31d-f4f9d9a66c69', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '2631b9d4-ef58-4fc9-899c-0277f5dc985a', 17,
  17, 'Coding 4', 1,
  7, 7,
  true, true, true,
  'content', 21
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d1cf1483-eb6f-4ddd-b31d-f4f9d9a66c69', 'objective', 'Write source code that make use of definite iterative control structures', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9b39ae0c-b755-4a86-9c55-7756bf23e90c', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '2631b9d4-ef58-4fc9-899c-0277f5dc985a', 18,
  18, 'Coding 5', 1,
  8, 8,
  true, true, true,
  'content', 22
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9b39ae0c-b755-4a86-9c55-7756bf23e90c', 'objective', 'Write source code that make use of indefinite iterative control structures', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ea540a88-d6dd-4d39-abce-eb7f762fd924', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '2631b9d4-ef58-4fc9-899c-0277f5dc985a', 19,
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
  '7a11dd0e-3a28-4501-b0a8-6b58cc1485e8', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '3d1f87f5-18b6-42c4-831e-5dce22ebae98', 20,
  20, 'Notions on number systems', 1,
  8, 8,
  true, false, false,
  'content', 24
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7a11dd0e-3a28-4501-b0a8-6b58cc1485e8', 'objective', 'Outline symbols of base 2, 8, 10, and 16', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7a11dd0e-3a28-4501-b0a8-6b58cc1485e8', 'objective', 'Identify symbols in a given base', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7a11dd0e-3a28-4501-b0a8-6b58cc1485e8', 'objective', 'Recognise a number in a given number system', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4d38ae40-9598-489e-90fa-2a818f332d00', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '3d1f87f5-18b6-42c4-831e-5dce22ebae98', 21,
  21, 'Conversion from any base to base 10', 1,
  9, 9,
  true, false, false,
  'content', 25
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4d38ae40-9598-489e-90fa-2a818f332d00', 'objective', 'Explain the principle of conversion from any base to base 10', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4d38ae40-9598-489e-90fa-2a818f332d00', 'objective', 'Convert from base 2, 8, and 16 to base 10', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '184f6b30-92c5-4cf1-8a9c-5a57cec57819', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '3d1f87f5-18b6-42c4-831e-5dce22ebae98', 22,
  22, 'Conversion from base 10 to any base', 1,
  9, 9,
  true, false, false,
  'content', 26
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('184f6b30-92c5-4cf1-8a9c-5a57cec57819', 'objective', 'Explain the principle of conversion from base 10 to any base', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('184f6b30-92c5-4cf1-8a9c-5a57cec57819', 'objective', 'Convert from base 10 to base 2, 8, and 16', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9437c180-89bb-4aa5-91da-3dc4c9af078b', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '3d1f87f5-18b6-42c4-831e-5dce22ebae98', 23,
  23, 'Conversion from base 2 to 8 and 16 and vice versa', 1,
  9, 9,
  true, false, false,
  'content', 27
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9437c180-89bb-4aa5-91da-3dc4c9af078b', 'objective', 'Explain the principle of conversion from base 2 directly to base 8, and 16', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9437c180-89bb-4aa5-91da-3dc4c9af078b', 'objective', 'Explain the principle of conversion from base 8 or 16 directly to base 2', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9437c180-89bb-4aa5-91da-3dc4c9af078b', 'objective', 'Convert from base 2 to 8, and 16 and from base 8, and 16 to base 2', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0f2e0c60-150d-479a-8065-1c726fbae9d4', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '3d1f87f5-18b6-42c4-831e-5dce22ebae98', 24,
  24, 'Addition and subtraction in a number system', 1,
  10, 10,
  true, false, false,
  'content', 28
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0f2e0c60-150d-479a-8065-1c726fbae9d4', 'objective', 'Explain the principle of addition in any number system', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0f2e0c60-150d-479a-8065-1c726fbae9d4', 'objective', 'Explain the principle of subtraction in any number system', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0f2e0c60-150d-479a-8065-1c726fbae9d4', 'objective', 'Apply the principle of addition and subtraction to add and subtract in a base 2, 8, and 16', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a2901665-c738-4d0c-82ed-90eae43eccda', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '3d1f87f5-18b6-42c4-831e-5dce22ebae98', 25,
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
  'bed8b08d-d3a2-4612-bff6-300622adecc6', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '6904c52e-06b8-4a91-8133-a0e68194388d', 26,
  26, 'Basic logic gates', 1,
  10, 10,
  true, false, false,
  'content', 30
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bed8b08d-d3a2-4612-bff6-300622adecc6', 'objective', 'Explain the concept of logic gates and truth tables', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bed8b08d-d3a2-4612-bff6-300622adecc6', 'objective', 'Identify a given basic logic gate', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bed8b08d-d3a2-4612-bff6-300622adecc6', 'objective', 'Explain the functioning of a given basic logic gate', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bed8b08d-d3a2-4612-bff6-300622adecc6', 'objective', 'Produce the truth table of a given basic logic gate', 'apply', 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b45b9a11-9ec6-479d-a6ac-e572e86c7ca6', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '8f0cffe5-0c92-4a6e-8dee-a0f494ec0144', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '6904c52e-06b8-4a91-8133-a0e68194388d', 27,
  27, 'Derived gates', 1,
  11, 11,
  true, false, false,
  'content', 32
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8f0cffe5-0c92-4a6e-8dee-a0f494ec0144', 'objective', 'Identify a given logic gate', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8f0cffe5-0c92-4a6e-8dee-a0f494ec0144', 'objective', 'Explain the functioning of a given logic gate', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8f0cffe5-0c92-4a6e-8dee-a0f494ec0144', 'objective', 'Produce the truth table of a given logic gate', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ae535998-057a-4194-8e03-98bf908c7279', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '6904c52e-06b8-4a91-8133-a0e68194388d', 28,
  28, 'Logic circuits', 1,
  11, 11,
  true, false, false,
  'content', 33
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae535998-057a-4194-8e03-98bf908c7279', 'objective', 'Explain the concept of logic circuit', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae535998-057a-4194-8e03-98bf908c7279', 'objective', 'Deduce the expression and truth table of a logic circuit of 2 variables', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae535998-057a-4194-8e03-98bf908c7279', 'objective', 'Draw the logic circuit of a logic expression of 2 variables', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1ae92fd5-332b-4b5c-8499-9e6f8965b10a', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '6904c52e-06b8-4a91-8133-a0e68194388d', 29,
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
  '21aee1f6-a35a-4938-8f5c-470b7533bcba', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  'aabe1e5e-862a-43bf-a72a-2a80f77822f7', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '5e22970f-df60-42a4-816f-40d18922b3ae', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '4eb38ed9-35a9-411c-ad05-77a2f86c0996', 30,
  30, 'Software methods for optimising the computer', 2,
  13, 13,
  true, false, false,
  'content', 37
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5e22970f-df60-42a4-816f-40d18922b3ae', 'objective', 'Outline common software for optimising the performance of a computer', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5e22970f-df60-42a4-816f-40d18922b3ae', 'objective', 'Explain the following concepts and how they affect the performance of a computer: malware, fragmentation, defragmentation', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5e22970f-df60-42a4-816f-40d18922b3ae', 'objective', 'Explain how antivirus, disk defragmenter, disk cleaner, and operating system configurations can improve the performance of a computer', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '097ddaba-2b26-47ba-807d-446f826e91c1', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '4eb38ed9-35a9-411c-ad05-77a2f86c0996', 31,
  31, 'Hardware methods for optimising the computer', 2,
  13, 13,
  true, false, false,
  'content', 38
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('097ddaba-2b26-47ba-807d-446f826e91c1', 'objective', 'Explain how size of RAM and disk can improve computer performance', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('097ddaba-2b26-47ba-807d-446f826e91c1', 'objective', 'Explain how SSDs improve computer performance compared to HDDs', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('097ddaba-2b26-47ba-807d-446f826e91c1', 'objective', 'Explain hardware related methods for improving computer performance', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '39389ce1-8a18-4b60-b387-8022ba1d07b8', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '4eb38ed9-35a9-411c-ad05-77a2f86c0996', 32,
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
  '55729010-7c82-41e3-b74f-27036ba58540', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '51515b55-d986-4f55-aa10-c6add2645c22', 33,
  33, 'Input peripherals', 2,
  14, 14,
  true, false, false,
  'content', 40
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('55729010-7c82-41e3-b74f-27036ba58540', 'objective', 'State the purpose of a given input peripheral device', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('55729010-7c82-41e3-b74f-27036ba58540', 'objective', 'Describe the characteristics of a given input peripheral device', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('55729010-7c82-41e3-b74f-27036ba58540', 'objective', 'Choose appropriate input peripheral in a given context', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a876f2cf-e72e-48d5-ae2c-52476cbcda15', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '51515b55-d986-4f55-aa10-c6add2645c22', 34,
  34, 'Output peripherals', 2,
  14, 14,
  true, false, false,
  'content', 41
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a876f2cf-e72e-48d5-ae2c-52476cbcda15', 'objective', 'State the purpose of a given output peripheral device', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a876f2cf-e72e-48d5-ae2c-52476cbcda15', 'objective', 'Describe the characteristics of a given output peripheral device', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a876f2cf-e72e-48d5-ae2c-52476cbcda15', 'objective', 'Choose appropriate output peripheral in a given context', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '798bf7c9-ed0d-4f45-8984-3135713a46ed', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '51515b55-d986-4f55-aa10-c6add2645c22', 35,
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
  '47a58f70-61c1-4d78-89dc-99c29ff96ff7', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '58208d09-0ca6-416b-b659-f3156144d653', 36,
  36, 'Units of storage', 2,
  15, 15,
  true, false, false,
  'content', 43
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('47a58f70-61c1-4d78-89dc-99c29ff96ff7', 'objective', 'Explain the concepts of storage, and storage units', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('47a58f70-61c1-4d78-89dc-99c29ff96ff7', 'objective', 'State units of storage and the relationship between these units', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('47a58f70-61c1-4d78-89dc-99c29ff96ff7', 'objective', 'Explain the read and write operations on storage', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9b78a781-e82c-4ab7-a4d6-f410e0a11464', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '58208d09-0ca6-416b-b659-f3156144d653', 37,
  37, 'Conversion between units of storage', 2,
  15, 15,
  true, false, false,
  'content', 44
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9b78a781-e82c-4ab7-a4d6-f410e0a11464', 'objective', 'Explain how to convert from a given unit to another', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9b78a781-e82c-4ab7-a4d6-f410e0a11464', 'objective', 'Convert between units of storage', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0afeb4ed-1e56-4957-b6d2-4318e42d22e3', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '58208d09-0ca6-416b-b659-f3156144d653', 38,
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
  '95f74317-a1e9-415d-916b-0ccaaafb0d0d', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '32e005ff-bf41-42f1-ae08-337ab0255fc5', 39,
  39, 'Notions on computer maintenance', 2,
  16, 16,
  true, false, false,
  'content', 46
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('95f74317-a1e9-415d-916b-0ccaaafb0d0d', 'objective', 'Explain the concepts of maintenance, hardware maintenance, software maintenance, preventive maintenance, and corrective maintenance', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('95f74317-a1e9-415d-916b-0ccaaafb0d0d', 'objective', 'Classify maintenance problems into hardware and software', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('95f74317-a1e9-415d-916b-0ccaaafb0d0d', 'objective', 'Classify solutions into preventive and corrective maintenance', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '60bd1d83-5e16-4bf9-be9a-26b55873246d', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '32e005ff-bf41-42f1-ae08-337ab0255fc5', 40,
  40, 'Hardware maintenance', 2,
  16, 16,
  true, false, false,
  'content', 47
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('60bd1d83-5e16-4bf9-be9a-26b55873246d', 'objective', 'Match symptoms to a given hardware problem', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('60bd1d83-5e16-4bf9-be9a-26b55873246d', 'objective', 'Determine appropriate and logical means of solving a given hardware problem', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('60bd1d83-5e16-4bf9-be9a-26b55873246d', 'objective', 'Explain common preventive maintenance tips', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1e9eb8b0-9ca2-4121-bf76-397fc43fb5b7', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '32e005ff-bf41-42f1-ae08-337ab0255fc5', 41,
  41, 'Software maintenance', 2,
  16, 16,
  true, false, false,
  'content', 48
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e9eb8b0-9ca2-4121-bf76-397fc43fb5b7', 'objective', 'Match symptoms to a given software problem', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e9eb8b0-9ca2-4121-bf76-397fc43fb5b7', 'objective', 'Determine appropriate and logical means of solving a given software problem', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e9eb8b0-9ca2-4121-bf76-397fc43fb5b7', 'objective', 'Explain common preventive maintenance tips', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5f129efc-aa0e-4007-aeb4-20323e99a77a', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '32e005ff-bf41-42f1-ae08-337ab0255fc5', 42,
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
  '5f4a6c60-b35b-4555-bd73-e1ea19cf9802', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '5cc4bbbc-10f1-41bf-b39b-74dc5b7d6e6e', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 43,
  43, 'Types of Digital content and File formats', 2,
  17, 17,
  true, false, false,
  'content', 51
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5cc4bbbc-10f1-41bf-b39b-74dc5b7d6e6e', 'objective', 'Describe the different types of digital content', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5cc4bbbc-10f1-41bf-b39b-74dc5b7d6e6e', 'objective', 'Identify common types of digital content and their file formats', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5cc4bbbc-10f1-41bf-b39b-74dc5b7d6e6e', 'objective', 'Differentiate between multimedia and hypermedia', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2de0365e-3382-46d5-abe5-85ad81d84cb0', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 44,
  44, 'Tools for creating digital content', 2,
  18, 18,
  true, false, false,
  'content', 52
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2de0365e-3382-46d5-abe5-85ad81d84cb0', 'objective', 'Identify appropriate tools for producing digital content of a given type', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2de0365e-3382-46d5-abe5-85ad81d84cb0', 'objective', 'State AI tools for producing digital content', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2de0365e-3382-46d5-abe5-85ad81d84cb0', 'objective', 'Outline methods for creating digital content', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'abec0435-39e9-4017-a5c5-eaecd1be6e4b', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '6dc48320-010a-42df-822a-4487deffb620', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '23f296ae-744c-445b-89d4-f281c76e41aa', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 45,
  45, 'Creation of audio content', 2,
  19, 19,
  true, true, true,
  'content', 55
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('23f296ae-744c-445b-89d4-f281c76e41aa', 'objective', 'Produce audio content using hardware tools', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('23f296ae-744c-445b-89d4-f281c76e41aa', 'objective', 'Produce audio content using software tools', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a01fcaea-b910-4540-bb90-3338e466d1aa', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 46,
  46, 'Creation of image content', 2,
  19, 19,
  true, true, true,
  'content', 56
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a01fcaea-b910-4540-bb90-3338e466d1aa', 'objective', 'Produce image content using hardware tools', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a01fcaea-b910-4540-bb90-3338e466d1aa', 'objective', 'Produce image content using software tools', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1d0dd5a6-a507-4c5c-abff-04262b7b3dba', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 47,
  47, 'Creation of multimedia content 1', 2,
  19, 19,
  true, true, true,
  'content', 57
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1d0dd5a6-a507-4c5c-abff-04262b7b3dba', 'objective', 'Produce multimedia content using hardware tools', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1d0dd5a6-a507-4c5c-abff-04262b7b3dba', 'objective', 'Produce multimedia content using software tools', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bdff49d6-7baf-46ec-b3f9-651b49ed8dba', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 48,
  48, 'Creation of multimedia content 2', 2,
  20, 20,
  true, true, true,
  'content', 58
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bdff49d6-7baf-46ec-b3f9-651b49ed8dba', 'objective', 'Combine text, audio, image using an appropriate tool to produce a video', 'create', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4af06ca2-ed79-49ca-9481-6a339b2a44cb', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 49,
  49, 'Creation of hypermedia content 1', 2,
  20, 20,
  true, true, true,
  'content', 59
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4af06ca2-ed79-49ca-9481-6a339b2a44cb', 'objective', 'Identify the necessary technologies to create hypermedia content', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4af06ca2-ed79-49ca-9481-6a339b2a44cb', 'objective', 'Create hypermedia content with the help of html, CSS, JavaScript, etc', 'create', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '673cd189-c304-45b8-9841-cea2e7c82998', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 50,
  50, 'Creation of hypermedia content 2', 2,
  20, 20,
  true, true, true,
  'content', 60
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('673cd189-c304-45b8-9841-cea2e7c82998', 'objective', 'Create hypermedia content with the help of html, CSS, JavaScript, etc', 'create', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '054a9315-d242-495d-80fd-c6c4481a736c', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 51,
  51, 'Creation of hypermedia content 3', 2,
  21, 21,
  true, true, true,
  'content', 61
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('054a9315-d242-495d-80fd-c6c4481a736c', 'objective', 'Create hypermedia content with the help of html, CSS, JavaScript, etc', 'create', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6bbd1523-435b-405f-9af5-4606ba8260ce', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 52,
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
  'a07b2676-07d2-4174-aa32-cdc68a97307d', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a2b4de13-67e4-40e7-883a-604976f6b8d9', 53,
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
  'f7b51b52-3476-4f1c-9c01-8ac57d7a22f0', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '974b5650-e69f-4649-9619-de6b5261f7e9', 54,
  54, 'Features of a word processor', 2,
  22, 22,
  true, true, true,
  'content', 64
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f7b51b52-3476-4f1c-9c01-8ac57d7a22f0', 'objective', 'Choose appropriate word processor features for a given task', 'evaluate', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f7b51b52-3476-4f1c-9c01-8ac57d7a22f0', 'objective', 'Perform basic formatting', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd728aa58-f3db-41ee-888c-aa9f09b48b83', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '974b5650-e69f-4649-9619-de6b5261f7e9', 55,
  55, 'Common operations on a page', 2,
  22, 22,
  true, true, true,
  'content', 65
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d728aa58-f3db-41ee-888c-aa9f09b48b83', 'objective', 'Explain what is meant by page layout', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d728aa58-f3db-41ee-888c-aa9f09b48b83', 'objective', 'Perform basic operations on a page', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c534cc76-45cd-4d3d-9156-f070bd2aa22d', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '974b5650-e69f-4649-9619-de6b5261f7e9', 56,
  56, 'Operations on tables', 2,
  22, 22,
  true, true, true,
  'content', 66
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c534cc76-45cd-4d3d-9156-f070bd2aa22d', 'objective', 'Create tables of different rows and columns using a word processor', 'create', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c534cc76-45cd-4d3d-9156-f070bd2aa22d', 'objective', 'Perform operations on tables (add, delete, resize)', 'apply', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b221a6fe-0d53-47c4-8ab9-4320e0ecb533', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '974b5650-e69f-4649-9619-de6b5261f7e9', 57,
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
  '3867cd9a-981b-460f-98fe-5a4b5cae9300', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '974b5650-e69f-4649-9619-de6b5261f7e9', 58,
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
  '4e213ee8-0e3e-4714-85e6-20d70612f103', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '9a866866-27ba-4ed0-8ae6-c83fb8ec5824', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e35edbfe-ee43-45a5-8e67-d9850c83bb8e', 59,
  59, 'Notions on cell referencing', 2,
  24, 24,
  true, false, false,
  'content', 70
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9a866866-27ba-4ed0-8ae6-c83fb8ec5824', 'objective', 'Explain the concepts of cells, formula, ranges, and cell reference', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9a866866-27ba-4ed0-8ae6-c83fb8ec5824', 'objective', 'Differentiate between the different types of cell referencing', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9a866866-27ba-4ed0-8ae6-c83fb8ec5824', 'objective', 'Identify when to use a given type of cell referencing', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4ca62b1d-e459-4581-97ef-caf510a57ed3', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '780e2182-2b4b-4a38-ad7d-d4c650fb3341', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '59c09010-6353-4161-9105-552360dc522f', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e35edbfe-ee43-45a5-8e67-d9850c83bb8e', 60,
  60, 'Operations using different types of cell referencing', 3,
  25, 25,
  true, true, true,
  'content', 73
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('59c09010-6353-4161-9105-552360dc522f', 'objective', 'Perform operations (sum, average, product, count) using different types of cell referencing', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '09e9f857-b173-4e27-8064-8828af12412b', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e35edbfe-ee43-45a5-8e67-d9850c83bb8e', 61,
  61, 'Conditional functions: IF function 1', 3,
  25, 25,
  true, true, true,
  'content', 74
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('09e9f857-b173-4e27-8064-8828af12412b', 'objective', 'Describe the IF function', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('09e9f857-b173-4e27-8064-8828af12412b', 'objective', 'Identify when to use the IF function', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('09e9f857-b173-4e27-8064-8828af12412b', 'objective', 'Solve variety of problems using the IF function', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8c85998e-43ef-44a0-b4a4-eb0876eed28d', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e35edbfe-ee43-45a5-8e67-d9850c83bb8e', 62,
  62, 'Conditional functions: IF function 2', 3,
  25, 25,
  true, true, true,
  'content', 75
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8c85998e-43ef-44a0-b4a4-eb0876eed28d', 'objective', 'Solve variety of problems using the IF function', 'apply', 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '95171062-0ad9-413c-a3e1-3047ea2f137a', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e35edbfe-ee43-45a5-8e67-d9850c83bb8e', 63,
  63, 'Conditional functions: SUMIF, PRODUCTIF', 3,
  26, 26,
  true, true, true,
  'content', 76
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('95171062-0ad9-413c-a3e1-3047ea2f137a', 'objective', 'Describe the SUMIF, and PRODUCTIF functions', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('95171062-0ad9-413c-a3e1-3047ea2f137a', 'objective', 'Identify when to use the SUMIF, and PRODUCTIF function', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('95171062-0ad9-413c-a3e1-3047ea2f137a', 'objective', 'Solve a problem that uses the SUMIF, and PRODUCTIF', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f5889032-7a59-48b0-b43c-7013cda65324', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e35edbfe-ee43-45a5-8e67-d9850c83bb8e', 64,
  64, 'Conditional functions: COUNTIF, AVERAGEIF', 3,
  26, 26,
  true, true, true,
  'content', 77
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f5889032-7a59-48b0-b43c-7013cda65324', 'objective', 'Describe the COUNTIF, AVERAGEIF functions', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f5889032-7a59-48b0-b43c-7013cda65324', 'objective', 'Identify when to use the COUNTIF, AVERAGEIF function', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f5889032-7a59-48b0-b43c-7013cda65324', 'objective', 'Solve a problem that uses the COUNTIF, AVERAGEIF', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8a00a1a3-0638-4eaa-8ffb-abfcacb5b3ed', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e35edbfe-ee43-45a5-8e67-d9850c83bb8e', 65,
  65, 'Represent data using charts', 3,
  26, 26,
  true, true, true,
  'content', 78
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a00a1a3-0638-4eaa-8ffb-abfcacb5b3ed', 'objective', 'Identify the different types of charts', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a00a1a3-0638-4eaa-8ffb-abfcacb5b3ed', 'objective', 'Represent data using charts', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a00a1a3-0638-4eaa-8ffb-abfcacb5b3ed', 'objective', 'Perform simple formatting on charts', 'apply', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7251a513-cb1a-4d99-b4c5-df1a696f161b', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e35edbfe-ee43-45a5-8e67-d9850c83bb8e', 66,
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
  'bc27f9b7-8cce-4660-a7e5-3ed335362a2b', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e35edbfe-ee43-45a5-8e67-d9850c83bb8e', 67,
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
  '378d6f6e-63e8-47b1-9ec9-1cec17db2536', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a7ea2051-7452-4f34-9f5b-bf4e92f71d1b', 68,
  68, 'Types of sensors', 3,
  27, 27,
  true, false, false,
  'content', 81
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('378d6f6e-63e8-47b1-9ec9-1cec17db2536', 'objective', 'Explain the concept of sensors, and actuators', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('378d6f6e-63e8-47b1-9ec9-1cec17db2536', 'objective', 'State the different types of sensor and their roles', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('378d6f6e-63e8-47b1-9ec9-1cec17db2536', 'objective', 'Outline situations in life where a given type of sensor can be used', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9e1abd84-8481-42b7-8348-44812299dc94', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a7ea2051-7452-4f34-9f5b-bf4e92f71d1b', 69,
  69, 'Embedded systems and IoT', 3,
  28, 28,
  true, false, false,
  'content', 82
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9e1abd84-8481-42b7-8348-44812299dc94', 'objective', 'Differentiate between embedded systems, IoT, and cloud computing', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9e1abd84-8481-42b7-8348-44812299dc94', 'objective', 'Describe scenarios where IoT and embedded systems are used in life', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7dc14ff1-968a-4c84-9887-5418508efb75', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a7ea2051-7452-4f34-9f5b-bf4e92f71d1b', 70,
  70, 'Cloud computing', 3,
  28, 28,
  true, false, false,
  'content', 83
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7dc14ff1-968a-4c84-9887-5418508efb75', 'objective', 'Explain the concept of cloud computing', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7dc14ff1-968a-4c84-9887-5418508efb75', 'objective', 'Outline the 3 main types of cloud services with examples', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7dc14ff1-968a-4c84-9887-5418508efb75', 'objective', 'Describe how embedded systems and IoT relate to cloud computing', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '28f2256e-351d-4e17-a99c-21c19a7f1b70', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'a7ea2051-7452-4f34-9f5b-bf4e92f71d1b', 71,
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
  '94905515-44e4-4287-850c-2d99dc7d7c70', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  'a243a112-5f8e-4b6d-a4c6-a3737dc4b981', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '5995b54d-76e9-49f8-a7b7-73aec68b0c86', 72,
  72, 'Notions on netiquette', 3,
  29, 29,
  true, false, false,
  'content', 86
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a243a112-5f8e-4b6d-a4c6-a3737dc4b981', 'objective', 'Explain the concepts of netiquette, and empathy', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a243a112-5f8e-4b6d-a4c6-a3737dc4b981', 'objective', 'State codes of conduct for posting and sharing content online', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a243a112-5f8e-4b6d-a4c6-a3737dc4b981', 'objective', 'Explain the importance of empathy, awareness in cultural and generational diversities when communicating online', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '82800c72-b304-4c69-b874-0becdf5018f9', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '5995b54d-76e9-49f8-a7b7-73aec68b0c86', 73,
  73, 'Emojis', 3,
  29, 29,
  true, false, false,
  'content', 87
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('82800c72-b304-4c69-b874-0becdf5018f9', 'objective', 'Differentiate emojis from emoticon', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('82800c72-b304-4c69-b874-0becdf5018f9', 'objective', 'Give the meaning of common emojis', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('82800c72-b304-4c69-b874-0becdf5018f9', 'objective', 'Explain why it is important to know the meaning of an emoji before using it', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a938dbee-e386-4713-9376-48fd5b60fc5e', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '5f44f14b-714a-4079-8ac5-ca19ccd6bdb3', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '114d081f-3150-4126-9715-def952a4c532', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '5995b54d-76e9-49f8-a7b7-73aec68b0c86', 74,
  74, 'Communicating responsibly online', 3,
  30, 30,
  true, false, false,
  'content', 90
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('114d081f-3150-4126-9715-def952a4c532', 'objective', 'Choose communication modes and strategies adapted to an audience', 'evaluate', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('114d081f-3150-4126-9715-def952a4c532', 'objective', 'Identify hostile or derogatory messages or activities online that attack an individual or groups of individuals', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('114d081f-3150-4126-9715-def952a4c532', 'objective', 'Propose behavioural rules when using digital technologies in a context', 'evaluate', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b6b02f5a-520f-4602-905a-a2785c04beea', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '5995b54d-76e9-49f8-a7b7-73aec68b0c86', 75,
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
  'c01685ab-fb87-443e-b06c-a5c0e8bf9683', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '7eb55e9b-3a2e-4f55-80e0-df3f12190394', 76,
  76, 'International laws or acts on digital technology', 3,
  31, 31,
  true, false, false,
  'content', 92
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c01685ab-fb87-443e-b06c-a5c0e8bf9683', 'objective', 'Explain the importance of laws and acts to regulate activities related to the creation and use of data and digital technologies', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c01685ab-fb87-443e-b06c-a5c0e8bf9683', 'objective', 'Outline international laws and acts related to the use of digital technology', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c01685ab-fb87-443e-b06c-a5c0e8bf9683', 'objective', 'State the purpose of a given international law or act', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4d7007d2-14ff-45b4-bc25-06fec912de7c', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '7eb55e9b-3a2e-4f55-80e0-df3f12190394', 77,
  77, 'National laws or policies on digital technology', 3,
  31, 31,
  true, false, false,
  'content', 93
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4d7007d2-14ff-45b4-bc25-06fec912de7c', 'objective', 'State national laws or policies aimed at regulating the use of digital technology in Cameroon and their respective goals', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4d7007d2-14ff-45b4-bc25-06fec912de7c', 'objective', 'Discuss some elements of law No 2010-12 of 21st December', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4d7007d2-14ff-45b4-bc25-06fec912de7c', 'objective', 'State penalties of some information and communication technology malpractice in Cameroon', 'remember', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c39c6aa7-94f8-4028-a2dd-339ec156d1e0', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '7eb55e9b-3a2e-4f55-80e0-df3f12190394', 78,
  78, 'National and international bodies regulating the use of ICT', 3,
  32, 32,
  true, false, false,
  'content', 94
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c39c6aa7-94f8-4028-a2dd-339ec156d1e0', 'objective', 'Outline international bodies that regulate the use of ICT and their respective goals', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c39c6aa7-94f8-4028-a2dd-339ec156d1e0', 'objective', 'Outline national bodies in Cameroon that regulate the use of ICT and their respective goals', 'remember', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b7f203a3-fb79-458a-a40c-8d9a466492e1', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '7eb55e9b-3a2e-4f55-80e0-df3f12190394', 79,
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
  '36664450-2e70-4a1b-87f3-90c74da076c1', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e24d5627-634c-4dc7-bec9-b343d8ec9039', 80,
  80, 'Notions on misinformation and disinformation', 3,
  32, 32,
  true, false, false,
  'content', 96
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('36664450-2e70-4a1b-87f3-90c74da076c1', 'objective', 'Differentiate between misinformation and disinformation', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('36664450-2e70-4a1b-87f3-90c74da076c1', 'objective', 'State factors of information biases (data algorithms, censorship, editorial choices, personal limitations)', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('36664450-2e70-4a1b-87f3-90c74da076c1', 'objective', 'Explain the concepts of misinformation, disinformation, deepfake, infodemic, clickbait', 'understand', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a450a042-4ba6-4b0c-a57b-5267ded337d8', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e24d5627-634c-4dc7-bec9-b343d8ec9039', 81,
  81, 'Analysis of online information', 3,
  33, 33,
  true, false, false,
  'content', 97
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a450a042-4ba6-4b0c-a57b-5267ded337d8', 'objective', 'Identify the author and source of a given information found online', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a450a042-4ba6-4b0c-a57b-5267ded337d8', 'objective', 'Identify sponsored content online', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a450a042-4ba6-4b0c-a57b-5267ded337d8', 'objective', 'Analyse information in order to detect its purpose or interest', 'analyse', 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '596c00db-ebcd-4eca-a438-c61f4fb7b178', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e24d5627-634c-4dc7-bec9-b343d8ec9039', 82,
  82, 'Identifying the credibility of information', 3,
  33, 33,
  true, false, false,
  'content', 98
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('596c00db-ebcd-4eca-a438-c61f4fb7b178', 'objective', 'Explain strategies for verifying the credibility and reliability of information', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('596c00db-ebcd-4eca-a438-c61f4fb7b178', 'objective', 'Propose national and international sources of getting credible information', 'evaluate', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'aaca232a-4845-4a31-b8aa-9ca6973e8a30', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, 'e24d5627-634c-4dc7-bec9-b343d8ec9039', 83,
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
  '0df0d5de-cd27-42be-885b-4aba590d9cd7', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '56619e3c-031e-498b-b143-f7ffbff0ecd8', 84,
  84, 'Computer related health hazards', 3,
  34, 34,
  true, false, false,
  'content', 100
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0df0d5de-cd27-42be-885b-4aba590d9cd7', 'objective', 'Describe different types of computer related health hazards', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0df0d5de-cd27-42be-885b-4aba590d9cd7', 'objective', 'Outline major causes of computer related health hazards', 'remember', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5e057bd3-bd9c-4270-a4da-71c915b390a1', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '56619e3c-031e-498b-b143-f7ffbff0ecd8', 85,
  85, 'Computer ergonomics: best practices in the design of items and workplace setup', 3,
  34, 34,
  true, false, false,
  'content', 101
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5e057bd3-bd9c-4270-a4da-71c915b390a1', 'objective', 'Identify wrong equipment placement and design in a computing environment', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5e057bd3-bd9c-4270-a4da-71c915b390a1', 'objective', 'Explain how the design of equipment and workplace setup can help prevent computer related health injuries', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '69ea6375-64a9-4042-a60e-a8a09bd3c5bd', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '56619e3c-031e-498b-b143-f7ffbff0ecd8', 86,
  86, 'Computer ergonomics: workplace habits and exercises', 3,
  34, 34,
  true, false, false,
  'content', 102
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('69ea6375-64a9-4042-a60e-a8a09bd3c5bd', 'objective', 'Identify wrong user posture and habits in a computing environment', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('69ea6375-64a9-4042-a60e-a8a09bd3c5bd', 'objective', 'Explain how the workplace habits and exercises can help prevent computer related health injuries', 'understand', 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1e652406-2cf2-4166-8c17-7cdc95e00d05', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '56619e3c-031e-498b-b143-f7ffbff0ecd8', 87,
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
  'a65cc24e-d43a-4a7a-bc6d-1a7e61be0583', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, '56619e3c-031e-498b-b143-f7ffbff0ecd8', 88,
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
  '95f84b42-5b1f-45e4-b1ae-cb72461666ee', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  'cb5480fc-1b8f-4635-9de1-a07e72607837', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
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
  '6815c01f-761e-4540-a099-ac6a83446331', '3a9d99c9-dd9d-4755-afc0-8b2ead62e14b', NULL, NULL, NULL,
  NULL, 'Remediation', 3,
  36, 36,
  true, false, false,
  'remediation', 107
);

COMMIT;
