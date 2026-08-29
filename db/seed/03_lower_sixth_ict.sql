BEGIN;
-- Progression Sheet for Information and Communication Technologies for Lower Sixth

INSERT INTO subjects (name) VALUES ('ICT') ON CONFLICT (name) DO NOTHING;
INSERT INTO levels (name, short_name) VALUES ('GCE Advanced Level', 'A/L') ON CONFLICT (name) DO NOTHING;

INSERT INTO syllabi (
  id, subject_id, level_id, title, form_level, issuing_authority, scope, region,
  version_label, effective_from, total_weeks, weekly_periods_theory,
  weekly_periods_practical, coefficient, module_label, has_modules,
  uses_competencies, has_competency_statements, has_practical_stream
) VALUES (
  'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c',
  (SELECT id FROM subjects WHERE name = 'ICT'),
  (SELECT id FROM levels   WHERE name = 'GCE Advanced Level'),
  'Progression Sheet for Information and Communication Technologies for Lower Sixth', 'Lower Sixth', 'Regional Delegation for the South West, Inspectorate of Pedagogy in charge of the Teaching of Computer Science',
  'regional', 'South West', 'South West Progression (current)',
  2025, 36,
  6, 2,
  5, 'Teaching Unit',
  true, false,
  false,
  true
);

INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('889e258f-d985-49f2-a3ac-ca6ad3cd726d', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 1: Exploring Computer systems', 1);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('3ce8985a-7e6d-4521-90c3-5c7d3059a589', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 2: Computer Architecture (Hardware)', 2);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('0688ee18-2b88-4231-bd3b-6a8d2555f108', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 3: Digital Arithmetic', 3);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('13ae1fb0-9daf-4497-aec0-a623a7ed08e0', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 4: Boolean Logic and Digital Electronics', 4);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 5: Computer Software', 5);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('45210bab-087d-4aa1-8af2-fa9d8193e5c2', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 6: File Formats and file security', 6);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('2211284f-3af7-4c88-8647-81a35ef96d78', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 7: The Social, Legal, ethical, and Economic Implication of the use of Computers', 7);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('068c80d0-d0c2-49ba-a828-409749f2f3ac', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 8: Information Systems (IS)', 8);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('096db83c-8937-4c99-9c0b-dea1de6a012a', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 9: System Development Life Cycle (SDLC)', 9);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('ec516eca-f500-4b45-a926-d65d728e787f', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 10: Project Management', 10);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Unit 11: Electronic Services', 11);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b804472e-96f0-48aa-aa71-25950d8f68ee', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '889e258f-d985-49f2-a3ac-ca6ad3cd726d', NULL, 1,
  1, 'Diagnostic Evaluations, Remediation and Presentation of annual program', 1,
  1, 1,
  true, false, false,
  'diagnostic_evaluation', 1
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5b085d32-cc3c-402c-9726-0ac2c31b20e6', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '889e258f-d985-49f2-a3ac-ca6ad3cd726d', NULL, 2,
  3, 'History and Evolution of computers', 1,
  1, 1,
  true, false, false,
  'content', 2
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5b085d32-cc3c-402c-9726-0ac2c31b20e6', 'content_point', 'Generations of Computers', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '63f91113-f8e3-405d-8c14-cc0d262c9096', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '889e258f-d985-49f2-a3ac-ca6ad3cd726d', NULL, 4,
  4, 'Practical: Identify software and Hardware', 1,
  1, 1,
  true, false, false,
  'practical', 3
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6507b6bb-48a5-4552-aa3a-d9bf24cf7619', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '889e258f-d985-49f2-a3ac-ca6ad3cd726d', NULL, 5,
  6, 'Definition, types and uses of computing systems', 1,
  2, 2,
  true, false, false,
  'content', 4
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6507b6bb-48a5-4552-aa3a-d9bf24cf7619', 'content_point', 'Commercial and general data processing systems, e.g. banking systems, hospital administration, personnel records systems, stock control systems, order processing systems', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b23b627f-e501-49c3-8c15-f2bc7eff8f06', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '889e258f-d985-49f2-a3ac-ca6ad3cd726d', NULL, 7,
  7, 'Communication and Information Systems', 1,
  2, 2,
  true, false, false,
  'content', 5
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b23b627f-e501-49c3-8c15-f2bc7eff8f06', 'content_point', 'Internet, video conferencing, electronic mail, information retrieval systems, home based communication systems, office automation and library systems', NULL, 1);
INSERT INTO curriculum_load_log (syllabus_id, severity, message, source_ref) VALUES ('b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'correction', 'Sheet prints this row as "5 & 7"; loaded as lesson 7', 'Communication and Information Systems');

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd25180a2-1d6c-422b-a5df-beec0b44bc43', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '889e258f-d985-49f2-a3ac-ca6ad3cd726d', NULL, 8,
  8, 'Practical: computer system', 1,
  2, 2,
  true, false, false,
  'practical', 6
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b6c747d0-878a-4d6f-89f8-3054f9385d02', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '889e258f-d985-49f2-a3ac-ca6ad3cd726d', NULL, 9,
  10, 'Application and examples of some computer systems', 1,
  3, 3,
  true, false, false,
  'content', 7
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b6c747d0-878a-4d6f-89f8-3054f9385d02', 'content_point', 'Automation, control systems, embedded systems, and robotics', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b6c747d0-878a-4d6f-89f8-3054f9385d02', 'content_point', 'Monitoring patients in hospitals, chemical process control, traffic control, domestic equipment, automatic navigation systems and industrial robots', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bb511f35-4564-4f93-ac39-11f6c00a9431', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '889e258f-d985-49f2-a3ac-ca6ad3cd726d', NULL, 11,
  11, 'Industrial, Technical and scientific application of Computing systems', 1,
  3, 3,
  true, false, false,
  'content', 8
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bb511f35-4564-4f93-ac39-11f6c00a9431', 'content_point', 'Weather forecasting, computer aided design and manufacture, image processing and industrial inspection systems, simulation and modelling', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '61387dba-0064-47f3-9132-c5b30958f4ac', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '889e258f-d985-49f2-a3ac-ca6ad3cd726d', NULL, 12,
  12, 'Practical: Word processing', 1,
  3, 3,
  true, false, false,
  'practical', 9
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '39c55156-9f1a-4a7f-9a72-7ae9761b3c2b', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 13,
  13, 'Computing applications in the arts and the media', 1,
  4, 4,
  true, false, false,
  'content', 10
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('39c55156-9f1a-4a7f-9a72-7ae9761b3c2b', 'content_point', 'Applications in music, computer graphics and animation for television and film, production of newspapers', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd316962c-183c-49cb-9d59-4565967384f2', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 14,
  15, 'Computer organization (Basic Components of a Computer)', 1,
  4, 4,
  true, false, false,
  'content', 11
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d316962c-183c-49cb-9d59-4565967384f2', 'content_point', 'Classification and description of hardware components (input, processing, output, and storage components)', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '005214dc-812b-4b58-b253-e851a674d1b8', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 16,
  16, 'Practical: Presentation', 1,
  4, 4,
  true, false, false,
  'practical', 12
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '03180181-dfbe-4799-8d96-f87f0d5256ff', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 17,
  17, 'Description of peripheral devices and data handling media device', 1,
  4, 4,
  true, false, false,
  'content', 13
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8f25a015-56ad-458f-96dc-6777244bf166', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 18,
  18, 'Processor architecture', 1,
  4, 4,
  true, false, false,
  'content', 14
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8f25a015-56ad-458f-96dc-6777244bf166', 'content_point', 'Description of processor configuration; control unit; ALU; registers; bus type, role and size', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cfba3402-e270-49a6-bbc7-4a31f41d2fc4', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 19,
  19, 'Classification of computers based on processor architecture', 1,
  4, 4,
  true, false, false,
  'content', 15
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cfba3402-e270-49a6-bbc7-4a31f41d2fc4', 'content_point', 'RISC and CISC machines; SISD, SIMD, MIMD', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9c3c3e37-9a46-413b-ae7a-9da6e9805ed2', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 20,
  20, 'Practical: Presentation', 1,
  4, 4,
  true, false, false,
  'practical', 16
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '662a1974-49bb-4ccc-a268-89f22057876c', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 21,
  21, 'Identify assorted computer types', 1,
  5, 5,
  true, false, false,
  'content', 17
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('662a1974-49bb-4ccc-a268-89f22057876c', 'content_point', 'Mainframe, mini and microcomputers, and parallel and distributed computing', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4cd7ac10-8a54-480e-aec8-7114b07f9e41', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 22,
  23, 'Primary and Secondary storage', 1,
  5, 5,
  true, false, false,
  'content', 18
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4cd7ac10-8a54-480e-aec8-7114b07f9e41', 'content_point', 'Differentiate between storage devices and storage media', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4cd7ac10-8a54-480e-aec8-7114b07f9e41', 'content_point', 'Functions and characteristics of storage devices and media: RAM, ROM, CD ROM, disks and tapes, memory card readers, USB ports', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4cd7ac10-8a54-480e-aec8-7114b07f9e41', 'content_point', 'The role of memory systems: RAM, DRAM, SRAM, ROM, PROM, EPROM, EEPROM, cache, virtual memory', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4cd7ac10-8a54-480e-aec8-7114b07f9e41', 'content_point', 'Performance and characteristics of storage devices (storage hierarchy based on speed and size)', NULL, 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4cd7ac10-8a54-480e-aec8-7114b07f9e41', 'content_point', 'Units of storage: bits, bytes, kilobytes, MB, GB, terabytes, and conversion between them', NULL, 5);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ff9743d7-6523-468f-97ab-07f543bd2a2b', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 24,
  24, 'Practical: Presentation', 1,
  5, 5,
  true, false, false,
  'practical', 19
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cffb09dc-ff68-432a-864f-59400c121f3b', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, NULL,
  NULL, 'Integration activities and Evaluation 1', 1,
  6, 6,
  true, false, false,
  'evaluation', 20
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cc58a10a-ae3c-4504-8e37-4d9dc59db39c', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 25,
  25, 'Machine Cycle', 1,
  7, 7,
  true, false, false,
  'content', 21
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cc58a10a-ae3c-4504-8e37-4d9dc59db39c', 'content_point', 'Description of fetch, decode, execute and store stages', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '160eb4e1-0148-4105-b905-61eaada484f1', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 26,
  27, 'Data capture', 1,
  7, 7,
  true, false, false,
  'content', 22
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('160eb4e1-0148-4105-b905-61eaada484f1', 'content_point', 'Classifying data capture devices: manual and automatic (MICR, OMR, OCR, barcode reader)', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '11c588e0-b9f7-49fe-af81-379b1aad451e', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '3ce8985a-7e6d-4521-90c3-5c7d3059a589', NULL, 28,
  28, 'Practical: Presentation', 1,
  7, 7,
  true, false, false,
  'practical', 23
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8ddd5d73-9b50-4ba3-83b5-3447df401be3', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '0688ee18-2b88-4231-bd3b-6a8d2555f108', NULL, 29,
  29, 'Data Representation', 1,
  8, 8,
  true, false, false,
  'content', 24
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8ddd5d73-9b50-4ba3-83b5-3447df401be3', 'content_point', 'Coding schemes (ASCII, EBCDIC, BCD, Unicode)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8ddd5d73-9b50-4ba3-83b5-3447df401be3', 'content_point', 'Measuring units: bit, nibble, byte, word, word size', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'da1714bf-80b2-4bd8-9c57-58508d0e93a9', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '0688ee18-2b88-4231-bd3b-6a8d2555f108', NULL, 30,
  31, 'Number systems', 1,
  8, 8,
  true, false, false,
  'content', 25
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('da1714bf-80b2-4bd8-9c57-58508d0e93a9', 'content_point', 'Positional number system', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('da1714bf-80b2-4bd8-9c57-58508d0e93a9', 'content_point', 'Base conversion, e.g. base 2 to 8, 10, 16 and vice versa', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4d3013f7-fe1b-41f9-a8bd-1ddf8b2f3715', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '0688ee18-2b88-4231-bd3b-6a8d2555f108', NULL, 32,
  32, 'Practical: Presentation', 1,
  8, 8,
  true, false, false,
  'practical', 26
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0df15f1c-99c6-447f-9423-56207a8d49ba', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '0688ee18-2b88-4231-bd3b-6a8d2555f108', NULL, 33,
  34, 'Binary arithmetic and Complement Representation', 1,
  9, 9,
  true, false, false,
  'content', 27
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0df15f1c-99c6-447f-9423-56207a8d49ba', 'content_point', 'Addition, subtraction, multiplication, and division', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0df15f1c-99c6-447f-9423-56207a8d49ba', 'content_point', 'Unsigned and signed numbers (one''s complement, two''s complement)', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '03d5570d-f985-4378-a59c-6d2175dcd611', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '13ae1fb0-9daf-4497-aec0-a623a7ed08e0', NULL, 35,
  35, 'Boolean Logic and Logic Gates', 1,
  9, 9,
  true, false, false,
  'content', 28
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('03d5570d-f985-4378-a59c-6d2175dcd611', 'content_point', 'Identify and sketch logic gate symbols: OR, AND, NOT, NAND, NOR, XOR', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('03d5570d-f985-4378-a59c-6d2175dcd611', 'content_point', 'Derive the truth table for each logic gate', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e0a04213-4bcd-4e50-825b-a8e301256387', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '13ae1fb0-9daf-4497-aec0-a623a7ed08e0', NULL, 36,
  36, 'Practical: Presentation', 1,
  9, 9,
  true, false, false,
  'practical', 29
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd4ee940a-8fed-42c0-bb7c-2522dafd25ee', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '13ae1fb0-9daf-4497-aec0-a623a7ed08e0', NULL, 37,
  37, 'Combining logic gates', 1,
  10, 10,
  true, false, false,
  'content', 30
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d4ee940a-8fed-42c0-bb7c-2522dafd25ee', 'content_point', 'Combine logic gates to form a logic circuit', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d4ee940a-8fed-42c0-bb7c-2522dafd25ee', 'content_point', 'Understanding Boolean algebra and Boolean expression', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b84f9997-7b02-4e2a-97a0-9107a2b2e7ae', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '13ae1fb0-9daf-4497-aec0-a623a7ed08e0', NULL, 38,
  39, 'Truth table and De Morgan theorem', 1,
  10, 10,
  true, false, false,
  'content', 31
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b84f9997-7b02-4e2a-97a0-9107a2b2e7ae', 'content_point', 'Derive truth tables from Boolean expressions (maximum of 3 inputs)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b84f9997-7b02-4e2a-97a0-9107a2b2e7ae', 'content_point', 'State and explain De Morgan''s theorem', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b84f9997-7b02-4e2a-97a0-9107a2b2e7ae', 'content_point', 'Simplify Boolean expressions using De Morgan theorem', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '42bba657-12c3-4886-90df-4f25287da768', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '13ae1fb0-9daf-4497-aec0-a623a7ed08e0', NULL, 40,
  40, 'Practical: Presentation', 1,
  10, 10,
  true, false, false,
  'practical', 32
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f2533043-5da9-46d3-9ee7-015996729607', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 41,
  41, 'Definitions and Classification of software', 1,
  11, 11,
  true, false, false,
  'content', 33
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f2533043-5da9-46d3-9ee7-015996729607', 'content_point', 'Based on source (open versus proprietary)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f2533043-5da9-46d3-9ee7-015996729607', 'content_point', 'Based on licence (shareware versus freeware)', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c8118185-09b5-4c03-a881-bcc3da59c3ec', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 42,
  43, 'Categorization of software: application software and examples', 1,
  11, 11,
  true, false, false,
  'content', 34
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c8118185-09b5-4c03-a881-bcc3da59c3ec', 'content_point', 'Identify application packages and classify into custom made (bespoke), specialist software, general purpose or generic packages e.g. spreadsheet, database, information retrieval packages', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c0dcce3d-dbde-4c10-b161-4aa0f76146af', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 44,
  44, 'Practical: Presentation', 1,
  11, 11,
  true, false, false,
  'practical', 35
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3f691393-e48a-47cf-8113-246c0e8fa455', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, NULL,
  NULL, 'Integration activities and Evaluation 2', 1,
  12, 12,
  true, false, false,
  'evaluation', 36
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '62026d51-a432-4817-a45c-5c707fc2831c', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 45,
  45, 'System software', 2,
  13, 13,
  true, false, false,
  'content', 37
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62026d51-a432-4817-a45c-5c707fc2831c', 'content_point', 'The need for system software and examples (operating system, utility, device drivers, language translators: compiler, interpreter, assembler)', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1da1b876-4d83-4d58-88cf-b779b2334cd0', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 46,
  46, 'Operating systems (OS)', 2,
  13, 13,
  true, false, false,
  'content', 38
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1da1b876-4d83-4d58-88cf-b779b2334cd0', 'content_point', 'History and evolution of operating systems', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '765404ec-1a40-4636-b42d-f73f52c1069e', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 47,
  47, 'Types of OS', 2,
  13, 13,
  true, false, false,
  'content', 39
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('765404ec-1a40-4636-b42d-f73f52c1069e', 'content_point', 'Describe types of OS: batch, online, multi-access, real time transaction processing, network OS, process control', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('765404ec-1a40-4636-b42d-f73f52c1069e', 'content_point', 'Distinguish between multitasking, multiprogramming and multiprocessing operating systems', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '986c6d4b-d27a-4d3e-a42e-c978526ec7ab', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 48,
  48, 'Practical: Presentation', 2,
  13, 13,
  true, false, false,
  'practical', 40
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '91cd7957-233c-4367-81dd-0f790f011d33', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 49,
  50, 'Functions of the operating system', 2,
  14, 14,
  true, false, false,
  'content', 41
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('91cd7957-233c-4367-81dd-0f790f011d33', 'content_point', 'Device management (interrupt, polling, buffering, spooling, handshaking)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('91cd7957-233c-4367-81dd-0f790f011d33', 'content_point', 'Memory management and file management', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('91cd7957-233c-4367-81dd-0f790f011d33', 'content_point', 'Process management', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('91cd7957-233c-4367-81dd-0f790f011d33', 'content_point', 'Process scheduling strategies: pre-emptive and non-pre-emptive', NULL, 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('91cd7957-233c-4367-81dd-0f790f011d33', 'content_point', 'Scheduling algorithms: First Come First Served, Shortest Job First, Shortest Remaining Time, Round Robin', NULL, 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('91cd7957-233c-4367-81dd-0f790f011d33', 'content_point', 'Processor sharing concepts (multitasking and multiprogramming)', NULL, 6);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7359913f-b190-4ea9-97d3-9a2a88b44234', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 51,
  51, 'Operating system user interfaces', 2,
  14, 14,
  true, false, false,
  'content', 42
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7359913f-b190-4ea9-97d3-9a2a88b44234', 'content_point', 'Describe the features: GUI, command driven interface, menu driven, natural language or voice recognition', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7359913f-b190-4ea9-97d3-9a2a88b44234', 'content_point', 'Identify the strengths and weaknesses of each', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7359913f-b190-4ea9-97d3-9a2a88b44234', 'content_point', 'Choosing the best interface for a user', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'add10d6a-c964-46f5-a143-6e418f67875f', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 52,
  52, 'Practical: Presentation', 2,
  14, 14,
  true, false, false,
  'practical', 43
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a9b5a82a-0997-4c83-b055-27ba2c0153e2', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 53,
  53, 'Server Concepts', 2,
  15, 15,
  true, false, false,
  'content', 44
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a9b5a82a-0997-4c83-b055-27ba2c0153e2', 'content_point', 'Properties of stand-alone and server OS', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a9b5a82a-0997-4c83-b055-27ba2c0153e2', 'content_point', 'Setting up OS to connect to wired and wireless network', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a9b5a82a-0997-4c83-b055-27ba2c0153e2', 'content_point', 'Setting up OS to avoid unauthorized access into the system', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2326604f-a36c-4213-91ae-7a9f2cc538f2', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 54,
  54, 'Utility Software', 2,
  15, 15,
  true, false, false,
  'content', 45
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2326604f-a36c-4213-91ae-7a9f2cc538f2', 'content_point', 'Types and role of utility software in system performance', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2326604f-a36c-4213-91ae-7a9f2cc538f2', 'content_point', 'e.g. disk defragmenter, virus checker, file compression, disk cleaner', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '48443ac9-21a5-42cf-9cb9-8a446e010027', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 55,
  55, 'Graphic software', 2,
  15, 15,
  true, false, false,
  'content', 46
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('48443ac9-21a5-42cf-9cb9-8a446e010027', 'content_point', 'Uses of bitmap and vector graphics', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('48443ac9-21a5-42cf-9cb9-8a446e010027', 'content_point', 'Identify the advantages and disadvantages of each type', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e54cf80d-309d-4631-afee-52d6af882cce', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'c65e8bfa-7ed6-4069-95d5-a3bbe7abdca2', NULL, 56,
  56, 'Practical: Presentation', 2,
  15, 15,
  true, false, false,
  'practical', 47
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9cf24559-efb5-4033-80fc-92820a5ecbd3', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '45210bab-087d-4aa1-8af2-fa9d8193e5c2', NULL, 57,
  57, 'File and Data Security', 2,
  16, 16,
  true, false, false,
  'content', 48
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9cf24559-efb5-4033-80fc-92820a5ecbd3', 'content_point', 'Backup, transaction logs, archive files, data integrity, access right management, physical protection, disaster planning, user id, passwords, encryption', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '95966aa1-bee7-4649-a987-735d74564c21', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '45210bab-087d-4aa1-8af2-fa9d8193e5c2', NULL, 58,
  58, 'File compression', 2,
  16, 16,
  true, false, false,
  'content', 49
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('95966aa1-bee7-4649-a987-735d74564c21', 'content_point', 'Compression methods and file systems', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('95966aa1-bee7-4649-a987-735d74564c21', 'content_point', 'Advantages of compressing a file', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '07188a58-36cd-4447-b019-7cc03cd3291f', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '45210bab-087d-4aa1-8af2-fa9d8193e5c2', NULL, 59,
  59, 'File Format', 2,
  16, 16,
  true, false, false,
  'content', 50
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07188a58-36cd-4447-b019-7cc03cd3291f', 'content_point', 'Importance of file formats and popular file formats', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07188a58-36cd-4447-b019-7cc03cd3291f', 'content_point', 'Bitmap e.g. JPEG, TIFF, GIF', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07188a58-36cd-4447-b019-7cc03cd3291f', 'content_point', 'Vector e.g. PNG, CGM, EPS, SVG', NULL, 3);
INSERT INTO curriculum_load_log (syllabus_id, severity, message, source_ref) VALUES ('b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'correction', 'Sheet prints this row as "99"; loaded as lesson 59', 'File Format');

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1bb1c955-2b1e-4d29-88f1-cde3120591e3', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '45210bab-087d-4aa1-8af2-fa9d8193e5c2', NULL, 60,
  60, 'Practical: Presentation', 2,
  16, 16,
  true, false, false,
  'practical', 51
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8244fd4b-d779-45e8-8161-1c6acbabe9e1', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '45210bab-087d-4aa1-8af2-fa9d8193e5c2', NULL, 61,
  61, 'File Format (continued)', 2,
  17, 17,
  true, false, false,
  'content', 52
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8244fd4b-d779-45e8-8161-1c6acbabe9e1', 'content_point', 'Sound e.g. WAV, MP3, MP4', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8244fd4b-d779-45e8-8161-1c6acbabe9e1', 'content_point', 'Video e.g. AVI, MPEG; text e.g. PDF, DOC', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8244fd4b-d779-45e8-8161-1c6acbabe9e1', 'content_point', 'Common application file formats e.g. database (DBF, MDB), spreadsheet (XLS)', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8244fd4b-d779-45e8-8161-1c6acbabe9e1', 'content_point', 'Hypermedia e.g. HTML, SGML, XML', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '77b092d2-8853-4ba0-9779-11b737e371bc', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '45210bab-087d-4aa1-8af2-fa9d8193e5c2', NULL, 62,
  63, 'Ergonomics', 2,
  17, 17,
  true, false, false,
  'content', 53
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('77b092d2-8853-4ba0-9779-11b737e371bc', 'content_point', 'Explain ergonomics', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('77b092d2-8853-4ba0-9779-11b737e371bc', 'content_point', 'Notion of good and comfortable working environment for computer users', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('77b092d2-8853-4ba0-9779-11b737e371bc', 'content_point', 'Computer related health hazards (RSI, CTS, eye strain) and preventive measures', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c9e19713-2859-4bcb-9e15-af1901000571', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '45210bab-087d-4aa1-8af2-fa9d8193e5c2', NULL, 64,
  64, 'Practical: Presentation', 2,
  17, 17,
  true, false, false,
  'practical', 54
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0a5f6a87-2dd8-47c4-84aa-cd5fa11e282a', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '45210bab-087d-4aa1-8af2-fa9d8193e5c2', NULL, NULL,
  NULL, 'Integration activities and Evaluation 3', 2,
  18, 18,
  true, false, false,
  'evaluation', 55
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0a1a1748-1152-4d2e-acd7-dbbc7c6c3842', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 65,
  65, 'Social and economic effects on people and organization', 2,
  19, 19,
  true, false, false,
  'content', 56
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0a1a1748-1152-4d2e-acd7-dbbc7c6c3842', 'content_point', 'Changes to existing methods, products, services, working environment, employment', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c07a2ee1-9445-428f-b1fb-b99927f3dcba', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 66,
  67, 'System security, reliability and resilience', 2,
  19, 19,
  true, false, false,
  'content', 57
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c07a2ee1-9445-428f-b1fb-b99927f3dcba', 'content_point', 'Explain system security, reliability, and resilience', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c07a2ee1-9445-428f-b1fb-b99927f3dcba', 'content_point', 'The importance of safe working practices, privacy and data integrity', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c07a2ee1-9445-428f-b1fb-b99927f3dcba', 'content_point', 'Identify the consequence of system failure', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7d944136-c8d4-4569-a4a3-64c56a8ad1c5', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 68,
  68, 'Practical: Presentation', 2,
  19, 19,
  true, false, false,
  'practical', 58
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e5fde6ce-76ec-48c8-914b-9faa91f5b202', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 69,
  69, 'Computer crime and Protection', 2,
  20, 20,
  true, false, false,
  'content', 59
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e5fde6ce-76ec-48c8-914b-9faa91f5b202', 'content_point', 'Unauthorized access to confidential data, frauds, unauthorized copying of copyrighted materials, plagiarism, illegal storage and use of personal data', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e5fde6ce-76ec-48c8-914b-9faa91f5b202', 'content_point', 'Preventive measures: physical security, security codes, password, encryption, biometrics, monitoring access attempts', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2bc77ad3-6f3f-47db-bd10-e33af2da9695', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 70,
  70, 'Natural and software threats to computer systems', 2,
  20, 20,
  true, false, false,
  'content', 60
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2bc77ad3-6f3f-47db-bd10-e33af2da9695', 'content_point', 'Natural threats (fire, flood)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2bc77ad3-6f3f-47db-bd10-e33af2da9695', 'content_point', 'Software threats: malware, virus, worm, trojan horse, logic bomb', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2bc77ad3-6f3f-47db-bd10-e33af2da9695', 'content_point', 'Preventive measures', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c67f1860-3dfd-408e-81aa-e8d2e49f00fd', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 71,
  71, 'Professional, ethical, and moral obligations of users and managers', 2,
  20, 20,
  true, false, false,
  'content', 61
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c67f1860-3dfd-408e-81aa-e8d2e49f00fd', 'content_point', 'Describe the ethical and moral obligations of users and managers of computerized information systems', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '31d4e3cd-f240-4b29-b04d-6197c7ea6f5a', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 72,
  72, 'Practical: Spreadsheet', 2,
  20, 20,
  true, false, false,
  'practical', 62
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f56bc4fb-2908-4073-8a51-1ce283d98ae8', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 73,
  73, 'Need for privacy and integrity of personal or sensitive data', 2,
  21, 21,
  true, false, false,
  'content', 63
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f56bc4fb-2908-4073-8a51-1ce283d98ae8', 'content_point', 'Measures to prevent sharing of personal data on the internet', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f56bc4fb-2908-4073-8a51-1ce283d98ae8', 'content_point', 'Explain the need for standard of conduct', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8a6e1331-3cbe-439d-a2e9-89623bd694a1', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 74,
  74, 'Requirements of some professional codes of conduct: BCS, IEEE, ACM', 2,
  21, 21,
  true, false, false,
  'content', 64
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a7abf821-c91e-443c-a8a0-6b9347406b6e', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 75,
  75, 'Legislation and Effects of global communication', 2,
  21, 21,
  true, false, false,
  'content', 65
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a7abf821-c91e-443c-a8a0-6b9347406b6e', 'content_point', 'Explain laws to prohibit hacking, copying of copyrighted material and storage of personal data', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dc2ce27d-b699-4b28-ab00-6169ecc762b5', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '2211284f-3af7-4c88-8647-81a35ef96d78', NULL, 76,
  76, 'Practical: Spreadsheet', 2,
  21, 21,
  true, false, false,
  'practical', 66
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '61bf523d-07f4-47da-902d-a072f4975006', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 77,
  78, 'Data protection Act and Global communication Effect', 2,
  22, 22,
  true, false, false,
  'content', 67
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61bf523d-07f4-47da-902d-a072f4975006', 'content_point', 'Data protection act of 2004 (UK) and distribution of anti-social materials', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61bf523d-07f4-47da-902d-a072f4975006', 'content_point', 'Effects of global communication on citizenship, cultural issues, and digital divide', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c2e23ae8-f9f3-4d7d-a748-21168e4d95c9', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 79,
  79, 'Architectural requirements of an IS', 2,
  22, 22,
  true, false, false,
  'content', 68
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c2e23ae8-f9f3-4d7d-a748-21168e4d95c9', 'content_point', 'Describe a system and an information system', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c2e23ae8-f9f3-4d7d-a748-21168e4d95c9', 'content_point', 'Distinguish between natural and artificial systems, data and information, manual and computer-based information systems', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c2e23ae8-f9f3-4d7d-a748-21168e4d95c9', 'content_point', 'Outline the activities of an IS: input, processing, output, storage, and distribution', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '282e4d9e-e41d-4cf2-b4fa-6f565f025808', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 80,
  80, 'Practical: Spreadsheet', 2,
  22, 22,
  true, false, false,
  'practical', 69
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '809b6ffc-a72e-4d9a-a493-b43db586a7f4', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 81,
  83, 'Role of IS in an Organization', 2,
  23, 23,
  true, false, false,
  'content', 70
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('809b6ffc-a72e-4d9a-a493-b43db586a7f4', 'content_point', 'Components of an IS', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('809b6ffc-a72e-4d9a-a493-b43db586a7f4', 'content_point', 'Illustrate the hierarchical structure of an organisation and describe the IS used at each level', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('809b6ffc-a72e-4d9a-a493-b43db586a7f4', 'content_point', 'The need of an IS at operational, tactical, and strategic levels', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('809b6ffc-a72e-4d9a-a493-b43db586a7f4', 'content_point', 'Key features of GIS, HIS, LIS, TPS, MIS, DSS, EIS and area of application of each', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f46b6968-9cb3-4ca8-a7c7-c2031b7cf506', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 84,
  84, 'Practical: Spreadsheet', 2,
  23, 23,
  true, false, false,
  'practical', 71
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8e21c32b-d0cb-4075-8e9e-a6c5a407fb8c', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, NULL,
  NULL, 'Integration activities and Evaluation 4', 2,
  24, 24,
  true, false, false,
  'evaluation', 72
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2ce51814-917c-468f-b9b8-37cc8b9d38ef', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 85,
  85, 'The role of MIS in planning', 3,
  25, 25,
  true, false, false,
  'content', 73
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ce51814-917c-468f-b9b8-37cc8b9d38ef', 'content_point', 'Decision making and organization of a company', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ce51814-917c-468f-b9b8-37cc8b9d38ef', 'content_point', 'Factors affecting the success or failure of MIS', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4c8d8dfa-da3b-4ab4-ae6e-648b2af01416', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 86,
  87, 'Introduction to Artificial Intelligence (AI)', 3,
  25, 25,
  true, false, false,
  'content', 74
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4c8d8dfa-da3b-4ab4-ae6e-648b2af01416', 'content_point', 'Cognitive science application (expert systems, learning systems)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4c8d8dfa-da3b-4ab4-ae6e-648b2af01416', 'content_point', 'Robotics application (visual perception, tactility)', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4c8d8dfa-da3b-4ab4-ae6e-648b2af01416', 'content_point', 'Natural interface application (natural languages, speech recognition)', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bdbe4de0-8b31-4478-bf65-ac7a9718e6ef', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 87,
  87, 'Real life application of Artificial Intelligence', 3,
  25, 25,
  true, false, false,
  'content', 75
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bdbe4de0-8b31-4478-bf65-ac7a9718e6ef', 'content_point', 'In education, health, banking, company, home', NULL, 1);
INSERT INTO curriculum_load_log (syllabus_id, severity, message, source_ref) VALUES ('b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'correction', 'Sheet prints this row as "87 (duplicate)"; loaded as lesson 87b', 'Real life application of Artificial Intelligence');

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'aabda3be-931f-4930-a2fd-4a4da15e1a6e', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 88,
  88, 'Practical: Spreadsheet', 3,
  25, 25,
  true, false, false,
  'practical', 76
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8797ad05-de60-4730-a74e-3984db6a2040', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 89,
  89, 'Robotics Application', 3,
  26, 26,
  true, false, false,
  'content', 77
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8797ad05-de60-4730-a74e-3984db6a2040', 'content_point', 'Uses in manufacturing, health, home', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8797ad05-de60-4730-a74e-3984db6a2040', 'content_point', 'Advantages and limitations of robots', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd93248d9-215d-49d6-825b-106b61534aa2', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 90,
  90, 'Knowledge-based system (Expert system)', 3,
  26, 26,
  true, false, false,
  'content', 78
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d93248d9-215d-49d6-825b-106b61534aa2', 'content_point', 'Components, application, and examples', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d93248d9-215d-49d6-825b-106b61534aa2', 'content_point', 'Advantages and disadvantages', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd9a7c8d1-abe7-4356-891d-bc3244975579', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 91,
  91, 'Introduction to Simulation', 3,
  26, 26,
  true, false, false,
  'content', 79
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d9a7c8d1-abe7-4356-891d-bc3244975579', 'content_point', 'Definition, application in real life systems or situations', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d9a7c8d1-abe7-4356-891d-bc3244975579', 'content_point', 'Advantages and limitations', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '358972a6-65fe-458e-9a33-a9fa63b5a911', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '068c80d0-d0c2-49ba-a828-409749f2f3ac', NULL, 92,
  92, 'Practical: Spreadsheet', 3,
  26, 26,
  true, false, false,
  'practical', 80
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '490161ef-c4b9-40bb-b5f6-59ba11d00186', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '096db83c-8937-4c99-9c0b-dea1de6a012a', NULL, 93,
  93, 'Virtual reality (VR) and Augmented Reality (AR)', 3,
  27, 27,
  true, false, false,
  'content', 81
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('490161ef-c4b9-40bb-b5f6-59ba11d00186', 'content_point', 'Description and role of VR and AR', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('490161ef-c4b9-40bb-b5f6-59ba11d00186', 'content_point', 'Compare AR and VR with examples of each', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3616939c-ee69-43fb-9ded-2268edb51bb3', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '096db83c-8937-4c99-9c0b-dea1de6a012a', NULL, 94,
  95, 'Phases of SDLC', 3,
  27, 27,
  true, false, false,
  'content', 82
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3616939c-ee69-43fb-9ded-2268edb51bb3', 'content_point', 'Investigation: problem identification, data collection, feasibility study (economic, technical, operational, organisational, schedule)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3616939c-ee69-43fb-9ded-2268edb51bb3', 'content_point', 'Analysis: detailed study of old system, functional requirement analysis, user and technical documentation', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3616939c-ee69-43fb-9ded-2268edb51bb3', 'content_point', 'Design: user interface design, data design, process design', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3616939c-ee69-43fb-9ded-2268edb51bb3', 'content_point', 'Development: developing software, integration of modules, unit, system and integration testing', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '677b7fbf-707a-491d-8530-58a58597dde4', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '096db83c-8937-4c99-9c0b-dea1de6a012a', NULL, 96,
  96, 'Practical: Spreadsheet', 3,
  27, 27,
  true, false, false,
  'practical', 83
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e02eb044-8db0-4f3a-a4c4-623e1e2b9bfc', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '096db83c-8937-4c99-9c0b-dea1de6a012a', NULL, 97,
  97, 'System Implementation and Maintenance', 3,
  28, 28,
  true, false, false,
  'content', 84
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e02eb044-8db0-4f3a-a4c4-623e1e2b9bfc', 'content_point', 'Implementation strategies: direct (plunge), parallel, phased (piecemeal), and pilot', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e02eb044-8db0-4f3a-a4c4-623e1e2b9bfc', 'content_point', 'Advantages and disadvantages of each type', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e02eb044-8db0-4f3a-a4c4-623e1e2b9bfc', 'content_point', 'Maintenance: debugging, corrective, adaptive maintenance', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd6db7c32-65a0-42c2-ace1-facac7f5a931', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '096db83c-8937-4c99-9c0b-dea1de6a012a', NULL, 98,
  99, 'SDLC Models', 3,
  28, 28,
  true, false, false,
  'content', 85
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6db7c32-65a0-42c2-ace1-facac7f5a931', 'content_point', 'Describe waterfall, V-shape, prototyping, spiral models', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6db7c32-65a0-42c2-ace1-facac7f5a931', 'content_point', 'Waterfall versus V-shape model', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2fcc2d77-db70-4ad4-9ef0-e3bbf1bd9765', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '096db83c-8937-4c99-9c0b-dea1de6a012a', NULL, 100,
  100, 'Practical: Spreadsheet', 3,
  28, 28,
  true, false, false,
  'practical', 86
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'eeb10d18-e1f3-4b5f-b23b-1e6c30e96783', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '096db83c-8937-4c99-9c0b-dea1de6a012a', NULL, NULL,
  NULL, 'Integration activities', 3,
  29, 29,
  true, false, false,
  'integration_activity', 87
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '25d4ec59-cb18-4752-8c28-502f320e191f', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', '096db83c-8937-4c99-9c0b-dea1de6a012a', NULL, NULL,
  NULL, 'Integration activities and Evaluation 5', 3,
  30, 30,
  true, false, false,
  'evaluation', 88
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '07f8458f-ff9d-44fb-80a7-c9c901fc36ad', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'ec516eca-f500-4b45-a926-d65d728e787f', NULL, 101,
  101, 'Project Management', 3,
  31, 31,
  true, false, false,
  'content', 89
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07f8458f-ff9d-44fb-80a7-c9c901fc36ad', 'content_point', 'Define a project and project management', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07f8458f-ff9d-44fb-80a7-c9c901fc36ad', 'content_point', 'Explain project management concepts: task, predecessor, successor, slack task/time, lag, lead, milestone, critical path/task, early finish, late finish, early start, late start', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f1b4d541-b2c5-4b03-a0de-af182f962adf', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'ec516eca-f500-4b45-a926-d65d728e787f', NULL, 102,
  102, 'Project constraints and Role of project management team', 3,
  31, 31,
  true, false, false,
  'content', 90
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f1b4d541-b2c5-4b03-a0de-af182f962adf', 'content_point', 'Scope, time, and cost', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f1b4d541-b2c5-4b03-a0de-af182f962adf', 'content_point', 'Identify the roles and responsibilities of project management team members', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3ae48231-e50f-4800-8753-dfc9f9585901', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'ec516eca-f500-4b45-a926-d65d728e787f', NULL, 103,
  103, 'Project management phases', 3,
  31, 31,
  true, false, false,
  'content', 91
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3ae48231-e50f-4800-8753-dfc9f9585901', 'content_point', 'Describe the activities of project initiation, planning, execution, control and monitoring, reporting stages', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2f450be6-dd98-4494-bfe8-2c26da797591', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'ec516eca-f500-4b45-a926-d65d728e787f', NULL, 104,
  104, 'Practical: Web Authoring', 3,
  31, 31,
  true, false, false,
  'practical', 92
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '03cd6a05-a791-4296-9da3-4e6fdd6cd2eb', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'ec516eca-f500-4b45-a926-d65d728e787f', NULL, 105,
  107, 'Project control and scheduling methods', 3,
  32, 32,
  true, false, false,
  'content', 93
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('03cd6a05-a791-4296-9da3-4e6fdd6cd2eb', 'content_point', 'PERT chart, critical path analysis; use the network diagram to determine project deadline, slack or float (free and total), critical path and tasks', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('03cd6a05-a791-4296-9da3-4e6fdd6cd2eb', 'content_point', 'Gantt chart', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('03cd6a05-a791-4296-9da3-4e6fdd6cd2eb', 'content_point', 'Critical Path Method (CPM)', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('03cd6a05-a791-4296-9da3-4e6fdd6cd2eb', 'content_point', 'Differences between PERT and Gantt; advantages and disadvantages of PERT and CPM', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ebe0d168-9710-468e-87be-7df2201332c6', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'ec516eca-f500-4b45-a926-d65d728e787f', NULL, 108,
  108, 'Practical: Web Authoring', 3,
  32, 32,
  true, false, false,
  'practical', 94
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6ed45b49-4353-485a-a0db-71300f1468c0', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', NULL, 109,
  109, 'E-commerce', 3,
  33, 33,
  true, false, false,
  'content', 95
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ed45b49-4353-485a-a0db-71300f1468c0', 'content_point', 'Definition and types', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ed45b49-4353-485a-a0db-71300f1468c0', 'content_point', 'E-commerce forms (B2C, B2B)', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ed45b49-4353-485a-a0db-71300f1468c0', 'content_point', 'Medium of purchase, fund transfer', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ed45b49-4353-485a-a0db-71300f1468c0', 'content_point', 'Advantages and disadvantages', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '47de75b2-3f5a-45a7-b942-630a9ad0ff05', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', NULL, 110,
  110, 'E-banking', 3,
  33, 33,
  true, false, false,
  'content', 96
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('47de75b2-3f5a-45a7-b942-630a9ad0ff05', 'content_point', 'Describe e-banking activities', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('47de75b2-3f5a-45a7-b942-630a9ad0ff05', 'content_point', 'Types: usefulness of ATM, POS, and Internet banking transactions', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('47de75b2-3f5a-45a7-b942-630a9ad0ff05', 'content_point', 'Advantages and disadvantages of e-banking to banks and customers', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '31df6895-980d-42f3-8269-ba71d4bac878', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', NULL, 111,
  111, 'E-Health', 3,
  33, 33,
  true, false, false,
  'content', 97
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('31df6895-980d-42f3-8269-ba71d4bac878', 'content_point', 'Define e-health and its applications', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('31df6895-980d-42f3-8269-ba71d4bac878', 'content_point', 'Role, advantages and disadvantages of e-health technologies e.g. medical information system, telemedicine, electronic medical records system', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '41816026-fb5d-4c24-96e8-941139546cbd', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', NULL, 112,
  112, 'Practical: Web Authoring', 3,
  33, 33,
  true, false, false,
  'practical', 98
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '61efc2cc-469b-4a00-9b88-4ce7c7c0dbaf', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', NULL, 113,
  113, 'Computer Assisted Learning (CAL)', 3,
  34, 34,
  true, false, false,
  'content', 99
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61efc2cc-469b-4a00-9b88-4ce7c7c0dbaf', 'content_point', 'Define CAL', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61efc2cc-469b-4a00-9b88-4ce7c7c0dbaf', 'content_point', 'Methods of course delivery e.g. servers, CD-ROM, didactic resources (e-books)', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61efc2cc-469b-4a00-9b88-4ce7c7c0dbaf', 'content_point', 'Advantages and limitations', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '30e4b114-9b7a-496a-b4d6-ec927a26c5b9', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', NULL, 114,
  115, 'E-government', 3,
  34, 34,
  true, false, false,
  'content', 100
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('30e4b114-9b7a-496a-b4d6-ec927a26c5b9', 'content_point', 'Define e-government', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('30e4b114-9b7a-496a-b4d6-ec927a26c5b9', 'content_point', 'Describe forms: e-governance, e-taxation, e-vote', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('30e4b114-9b7a-496a-b4d6-ec927a26c5b9', 'content_point', 'Implication of e-government to the government and citizens', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2fa23219-f44c-4170-9014-8f979b1b134e', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', NULL, 116,
  116, 'Practical: Web Authoring', 3,
  34, 34,
  true, false, false,
  'practical', 101
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '59763ba8-c4f2-4283-8ff6-17378acbe3d7', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', NULL, NULL,
  NULL, 'Integration activities', 3,
  35, 35,
  true, false, false,
  'integration_activity', 102
);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '26645211-41f2-4597-a3fd-d4b091863e77', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'cf231aa2-4fa0-4a4d-a8a3-274e93ca2ab5', NULL, NULL,
  NULL, 'Integration activities and Evaluation 6', 3,
  36, 36,
  true, false, false,
  'evaluation', 103
);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('3111dd48-dac8-48da-ace2-77742e9f2ea9', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Section 1: Computer system', 1, 'See PRACTICAL WORKBOOK');
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('3111dd48-dac8-48da-ace2-77742e9f2ea9', 'Identify and describe hardware installed and their role', 1, 1, 1, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('3111dd48-dac8-48da-ace2-77742e9f2ea9', 'Differentiating between the system and application software installed', 1, 1, 1, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('3111dd48-dac8-48da-ace2-77742e9f2ea9', 'Managing files using input devices (mouse, keyboard); creating, naming and renaming folders', 1, 2, 2, 3);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('a23511d1-0164-42af-9550-08a13ee81534', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Working with Application software: Microsoft Word', 2, NULL);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('a23511d1-0164-42af-9550-08a13ee81534', 'Open MS Word and save the file in a specified location', 1, 3, 3, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('a23511d1-0164-42af-9550-08a13ee81534', 'Inputting text, pictures, shapes; format and edit text; find and replace text', 1, 3, 3, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('a23511d1-0164-42af-9550-08a13ee81534', 'Working with page layout; add headers and footers; inserting and formatting tables and shapes; printing', 1, 3, 3, 3);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Section 2: Presentation Software', 3, 'See practical workbook');
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Describe main features of presentation software; select a suitable template, scheme and layout; create and save a new presentation', 1, 4, 4, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Opening an existing presentation; explain the features of tab commands (home, insert, design, transitions)', 1, 4, 4, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Add and format text; create a new slide; change font format; apply bulleted or numbered lists; add images and shapes; use Format Painter', 1, 5, 5, 3);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Insert charts; format chart elements (series, axes, titles, data labels, legend, plot area)', 1, 7, 7, 4);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Apply text outline or text effect; change chart elements and layout; edit data series', 1, 9, 9, 5);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Use chart button to label data; improve appearance; hide and show series and categories', 1, 10, 10, 6);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Change layout of chart elements (add, remove, position labels, axis titles, legends, trend lines); apply chart styles', 1, 11, 11, 7);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Working with SmartArt: insert, add text, add shapes, change position, flip, format', 2, 14, 14, 8);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Working with tables: insert, add rows and columns, apply styles, merge and split cells, adjust size, format data', 2, 15, 15, 9);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Importing into PowerPoint: object linking and embedding (OLE); embed Word tables and Excel tables and charts; link Excel charts', 2, 16, 16, 10);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Delivering your presentation: create a custom show; apply animation to text and graphics; timing; running a slide show', 2, 17, 17, 11);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d9e68149-2b24-434e-a3dc-5fa2401d6a91', 'Shapes and picture enhancements: draw, resize, edit, reposition, merge, align, connect shapes; adjust picture appearance, border, style, cropping', 2, 19, 19, 12);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('5e3186f3-2f1d-44c4-81c9-7d84c42439a4', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Section 3: Spreadsheet', 4, 'Practical manual');
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('5e3186f3-2f1d-44c4-81c9-7d84c42439a4', 'Explain basic spreadsheet concepts (workbook, worksheet, sheet tabs, active sheet); introduction to MS Excel; features of the displayed screen; switching between worksheets', 2, 20, 20, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('5e3186f3-2f1d-44c4-81c9-7d84c42439a4', 'Cell references: distinguish relative and absolute; add or remove rows and columns; format cell entries and cells including conditional formatting', 2, 21, 21, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('5e3186f3-2f1d-44c4-81c9-7d84c42439a4', 'Data entry and editing: autofill, copy and paste, drag and drop, saving a workbook, editing and clearing cell contents, undo; modifying columns and rows', 2, 22, 22, 3);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('5e3186f3-2f1d-44c4-81c9-7d84c42439a4', 'Formatting text: alignment, merging cells, underline, bold, italic, font type, size and colour; number formatting including accounting, percentage and decimal places', 2, 23, 23, 4);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('5e3186f3-2f1d-44c4-81c9-7d84c42439a4', 'Spreadsheet functions for financial and statistical analysis: MAX, MIN, SUM, AVERAGE, COUNT, PRODUCT', 3, 25, 25, 5);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('5e3186f3-2f1d-44c4-81c9-7d84c42439a4', 'IF function, SUMIF, COUNTIF, SUMPRODUCT, nested IF', 3, 26, 26, 6);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('5e3186f3-2f1d-44c4-81c9-7d84c42439a4', 'RANK, ROUND, CONCATENATE, VLOOKUP and HLOOKUP', 3, 27, 27, 7);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('5e3186f3-2f1d-44c4-81c9-7d84c42439a4', 'Represent data on a chart; format the chart; adjust labels, legend, titles; change chart type; swap rows and columns; link Excel formulae between worksheets; add Excel charts to Word or PowerPoint', 3, 28, 28, 8);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('d94048cc-41d1-4ae9-8df6-a08b6fed1085', 'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c', 'Web Authoring', 5, NULL);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d94048cc-41d1-4ae9-8df6-a08b6fed1085', 'Web authoring', 3, 29, 29, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d94048cc-41d1-4ae9-8df6-a08b6fed1085', 'Web authoring', 3, 31, 31, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d94048cc-41d1-4ae9-8df6-a08b6fed1085', 'Web authoring', 3, 32, 32, 3);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d94048cc-41d1-4ae9-8df6-a08b6fed1085', 'Web authoring', 3, 33, 33, 4);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('d94048cc-41d1-4ae9-8df6-a08b6fed1085', 'Web authoring', 3, 34, 34, 5);

COMMIT;
