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
  'd2f5920a-95b3-4663-b14b-280cac4da1e3',
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

INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('43591237-1354-43e9-98e6-c30d905d0063', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 1: Exploring Computer systems', 1);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('2c6a0636-23b9-49c6-ae91-43e01dca3245', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 2: Computer Architecture (Hardware)', 2);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('a740f79d-0e9b-4b7c-97ae-4906c5b8a27c', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 3: Digital Arithmetic', 3);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('b021b6b5-4149-48d5-bdfe-6d08499b1538', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 4: Boolean Logic and Digital Electronics', 4);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('c8154e50-e815-47b7-8729-2b4614739808', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 5: Computer Software', 5);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('cd3dea26-b2af-4022-a6ab-587321f7c85b', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 6: File Formats and file security', 6);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('61635f37-d483-418c-bc72-ac4b2e14624e', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 7: The Social, Legal, ethical, and Economic Implication of the use of Computers', 7);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('4421d677-4d06-4433-8cf5-f5656192f016', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 8: Information Systems (IS)', 8);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('b5f7d53f-9a00-4ced-b5e4-eb3204b56ee2', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 9: System Development Life Cycle (SDLC)', 9);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('0b5d2573-8444-4a7b-9971-aba72a9248c8', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 10: Project Management', 10);
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Unit 11: Electronic Services', 11);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0fc80da8-35ae-45f0-899f-9daac1862a90', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '43591237-1354-43e9-98e6-c30d905d0063', NULL, 1,
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
  'b4b6030d-54ef-4aac-896f-45ca14fbdddc', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '43591237-1354-43e9-98e6-c30d905d0063', NULL, 2,
  3, 'History and Evolution of computers', 1,
  1, 1,
  true, false, false,
  'content', 2
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4b6030d-54ef-4aac-896f-45ca14fbdddc', 'content_point', 'Generations of Computers', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6dec8724-06ae-4441-afc2-b6034afd402e', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '43591237-1354-43e9-98e6-c30d905d0063', NULL, 4,
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
  '57e166fc-29f2-4410-aa9f-796082fb7eaf', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '43591237-1354-43e9-98e6-c30d905d0063', NULL, 5,
  6, 'Definition, types and uses of computing systems', 1,
  2, 2,
  true, false, false,
  'content', 4
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('57e166fc-29f2-4410-aa9f-796082fb7eaf', 'content_point', 'Commercial and general data processing systems, e.g. banking systems, hospital administration, personnel records systems, stock control systems, order processing systems', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6cb957b1-756d-4f82-aa58-a143fb95d9b1', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '43591237-1354-43e9-98e6-c30d905d0063', NULL, 7,
  7, 'Communication and Information Systems', 1,
  2, 2,
  true, false, false,
  'content', 5
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6cb957b1-756d-4f82-aa58-a143fb95d9b1', 'content_point', 'Internet, video conferencing, electronic mail, information retrieval systems, home based communication systems, office automation and library systems', NULL, 1);
INSERT INTO curriculum_load_log (syllabus_id, severity, message, source_ref) VALUES ('d2f5920a-95b3-4663-b14b-280cac4da1e3', 'correction', 'Sheet prints this row as "5 & 7"; loaded as lesson 7', 'Communication and Information Systems');

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b9e4d0ed-5489-4b32-a1c1-2fb554419357', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '43591237-1354-43e9-98e6-c30d905d0063', NULL, 8,
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
  '43e9e2b3-b706-4544-af28-123fcde9fe9e', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '43591237-1354-43e9-98e6-c30d905d0063', NULL, 9,
  10, 'Application and examples of some computer systems', 1,
  3, 3,
  true, false, false,
  'content', 7
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('43e9e2b3-b706-4544-af28-123fcde9fe9e', 'content_point', 'Automation, control systems, embedded systems, and robotics', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('43e9e2b3-b706-4544-af28-123fcde9fe9e', 'content_point', 'Monitoring patients in hospitals, chemical process control, traffic control, domestic equipment, automatic navigation systems and industrial robots', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f5d08387-8f36-48c5-abf9-55dd9995810e', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '43591237-1354-43e9-98e6-c30d905d0063', NULL, 11,
  11, 'Industrial, Technical and scientific application of Computing systems', 1,
  3, 3,
  true, false, false,
  'content', 8
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f5d08387-8f36-48c5-abf9-55dd9995810e', 'content_point', 'Weather forecasting, computer aided design and manufacture, image processing and industrial inspection systems, simulation and modelling', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a9caefc1-f055-4ba9-b903-2cf4ffdd9286', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '43591237-1354-43e9-98e6-c30d905d0063', NULL, 12,
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
  '8d1d77db-e53a-4689-9249-6e53af47a5e8', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 13,
  13, 'Computing applications in the arts and the media', 1,
  4, 4,
  true, false, false,
  'content', 10
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8d1d77db-e53a-4689-9249-6e53af47a5e8', 'content_point', 'Applications in music, computer graphics and animation for television and film, production of newspapers', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8c86d77d-671a-4835-ad06-94f850f5867e', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 14,
  15, 'Computer organization (Basic Components of a Computer)', 1,
  4, 4,
  true, false, false,
  'content', 11
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8c86d77d-671a-4835-ad06-94f850f5867e', 'content_point', 'Classification and description of hardware components (input, processing, output, and storage components)', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '31ea496a-4273-47f7-b414-6c8000c1fb93', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 16,
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
  '4347b1d1-2471-44fd-8427-7419f1b6ac79', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 17,
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
  'e9bfcfc1-7d2b-4400-a87d-6af8ea9ed8f4', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 18,
  18, 'Processor architecture', 1,
  4, 4,
  true, false, false,
  'content', 14
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e9bfcfc1-7d2b-4400-a87d-6af8ea9ed8f4', 'content_point', 'Description of processor configuration; control unit; ALU; registers; bus type, role and size', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c4c8d25f-83d3-4607-b713-cff9f5f599df', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 19,
  19, 'Classification of computers based on processor architecture', 1,
  4, 4,
  true, false, false,
  'content', 15
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c4c8d25f-83d3-4607-b713-cff9f5f599df', 'content_point', 'RISC and CISC machines; SISD, SIMD, MIMD', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b4f9db43-7f90-4136-bb9b-ac7405d042e2', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 20,
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
  '05f5e914-628d-4ca0-9f67-c18101c78b32', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 21,
  21, 'Identify assorted computer types', 1,
  5, 5,
  true, false, false,
  'content', 17
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('05f5e914-628d-4ca0-9f67-c18101c78b32', 'content_point', 'Mainframe, mini and microcomputers, and parallel and distributed computing', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '009b122d-a46a-4f6a-94bc-c1699a45e073', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 22,
  23, 'Primary and Secondary storage', 1,
  5, 5,
  true, false, false,
  'content', 18
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('009b122d-a46a-4f6a-94bc-c1699a45e073', 'content_point', 'Differentiate between storage devices and storage media', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('009b122d-a46a-4f6a-94bc-c1699a45e073', 'content_point', 'Functions and characteristics of storage devices and media: RAM, ROM, CD ROM, disks and tapes, memory card readers, USB ports', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('009b122d-a46a-4f6a-94bc-c1699a45e073', 'content_point', 'The role of memory systems: RAM, DRAM, SRAM, ROM, PROM, EPROM, EEPROM, cache, virtual memory', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('009b122d-a46a-4f6a-94bc-c1699a45e073', 'content_point', 'Performance and characteristics of storage devices (storage hierarchy based on speed and size)', NULL, 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('009b122d-a46a-4f6a-94bc-c1699a45e073', 'content_point', 'Units of storage: bits, bytes, kilobytes, MB, GB, terabytes, and conversion between them', NULL, 5);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '84b190ef-5342-4161-a35e-4fe3bda1c900', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 24,
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
  '942497ca-45f6-42c3-aa64-9746f561e0ad', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, NULL,
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
  'f3e596e4-7b06-4f17-b593-a335dc3e9613', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 25,
  25, 'Machine Cycle', 1,
  7, 7,
  true, false, false,
  'content', 21
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f3e596e4-7b06-4f17-b593-a335dc3e9613', 'content_point', 'Description of fetch, decode, execute and store stages', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0599c93f-9573-4bf1-8b1b-c5d76dbc1ef0', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 26,
  27, 'Data capture', 1,
  7, 7,
  true, false, false,
  'content', 22
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0599c93f-9573-4bf1-8b1b-c5d76dbc1ef0', 'content_point', 'Classifying data capture devices: manual and automatic (MICR, OMR, OCR, barcode reader)', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'aad11449-79d5-4c34-8450-f336cb75c1c0', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '2c6a0636-23b9-49c6-ae91-43e01dca3245', NULL, 28,
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
  'd6df68ed-a933-45ae-bef6-daa049a681ca', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'a740f79d-0e9b-4b7c-97ae-4906c5b8a27c', NULL, 29,
  29, 'Data Representation', 1,
  8, 8,
  true, false, false,
  'content', 24
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6df68ed-a933-45ae-bef6-daa049a681ca', 'content_point', 'Coding schemes (ASCII, EBCDIC, BCD, Unicode)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6df68ed-a933-45ae-bef6-daa049a681ca', 'content_point', 'Measuring units: bit, nibble, byte, word, word size', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6dd3c9a6-8886-4741-a167-e0a99b9c6933', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'a740f79d-0e9b-4b7c-97ae-4906c5b8a27c', NULL, 30,
  31, 'Number systems', 1,
  8, 8,
  true, false, false,
  'content', 25
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6dd3c9a6-8886-4741-a167-e0a99b9c6933', 'content_point', 'Positional number system', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6dd3c9a6-8886-4741-a167-e0a99b9c6933', 'content_point', 'Base conversion, e.g. base 2 to 8, 10, 16 and vice versa', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '238bd949-7b40-4166-957e-784e4a120b48', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'a740f79d-0e9b-4b7c-97ae-4906c5b8a27c', NULL, 32,
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
  '857dafc0-cbe4-4465-84ea-f01b30e7b458', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'a740f79d-0e9b-4b7c-97ae-4906c5b8a27c', NULL, 33,
  34, 'Binary arithmetic and Complement Representation', 1,
  9, 9,
  true, false, false,
  'content', 27
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('857dafc0-cbe4-4465-84ea-f01b30e7b458', 'content_point', 'Addition, subtraction, multiplication, and division', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('857dafc0-cbe4-4465-84ea-f01b30e7b458', 'content_point', 'Unsigned and signed numbers (one''s complement, two''s complement)', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fc9a56fc-e2f3-4c14-880e-54e3900023a5', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b021b6b5-4149-48d5-bdfe-6d08499b1538', NULL, 35,
  35, 'Boolean Logic and Logic Gates', 1,
  9, 9,
  true, false, false,
  'content', 28
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fc9a56fc-e2f3-4c14-880e-54e3900023a5', 'content_point', 'Identify and sketch logic gate symbols: OR, AND, NOT, NAND, NOR, XOR', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fc9a56fc-e2f3-4c14-880e-54e3900023a5', 'content_point', 'Derive the truth table for each logic gate', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2aedc93b-84d3-4c9c-b244-b9bdced10952', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b021b6b5-4149-48d5-bdfe-6d08499b1538', NULL, 36,
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
  '3bd06aa6-4be3-495d-b724-128fa33fa1d0', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b021b6b5-4149-48d5-bdfe-6d08499b1538', NULL, 37,
  37, 'Combining logic gates', 1,
  10, 10,
  true, false, false,
  'content', 30
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3bd06aa6-4be3-495d-b724-128fa33fa1d0', 'content_point', 'Combine logic gates to form a logic circuit', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3bd06aa6-4be3-495d-b724-128fa33fa1d0', 'content_point', 'Understanding Boolean algebra and Boolean expression', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '740ca3f3-5e41-447b-855e-22132e96710c', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b021b6b5-4149-48d5-bdfe-6d08499b1538', NULL, 38,
  39, 'Truth table and De Morgan theorem', 1,
  10, 10,
  true, false, false,
  'content', 31
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('740ca3f3-5e41-447b-855e-22132e96710c', 'content_point', 'Derive truth tables from Boolean expressions (maximum of 3 inputs)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('740ca3f3-5e41-447b-855e-22132e96710c', 'content_point', 'State and explain De Morgan''s theorem', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('740ca3f3-5e41-447b-855e-22132e96710c', 'content_point', 'Simplify Boolean expressions using De Morgan theorem', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1c8963a6-e4cd-4a51-9c9e-98ef7f53f493', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b021b6b5-4149-48d5-bdfe-6d08499b1538', NULL, 40,
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
  '45239a65-04e6-4a5c-9e12-24dd286e9a98', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 41,
  41, 'Definitions and Classification of software', 1,
  11, 11,
  true, false, false,
  'content', 33
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('45239a65-04e6-4a5c-9e12-24dd286e9a98', 'content_point', 'Based on source (open versus proprietary)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('45239a65-04e6-4a5c-9e12-24dd286e9a98', 'content_point', 'Based on licence (shareware versus freeware)', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ad92477e-6417-4c99-9045-45139470acdc', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 42,
  43, 'Categorization of software: application software and examples', 1,
  11, 11,
  true, false, false,
  'content', 34
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ad92477e-6417-4c99-9045-45139470acdc', 'content_point', 'Identify application packages and classify into custom made (bespoke), specialist software, general purpose or generic packages e.g. spreadsheet, database, information retrieval packages', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b711df07-be2d-4da5-89fd-07e187e49e2b', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 44,
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
  '173b7f4e-a9b0-4eb4-bf3c-e5c58eb33bbb', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, NULL,
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
  'e2f45392-07bb-4fb5-bb71-b136dd512dd5', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 45,
  45, 'System software', 2,
  13, 13,
  true, false, false,
  'content', 37
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e2f45392-07bb-4fb5-bb71-b136dd512dd5', 'content_point', 'The need for system software and examples (operating system, utility, device drivers, language translators: compiler, interpreter, assembler)', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'feb378ce-3b1e-403b-a490-81d970b85972', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 46,
  46, 'Operating systems (OS)', 2,
  13, 13,
  true, false, false,
  'content', 38
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('feb378ce-3b1e-403b-a490-81d970b85972', 'content_point', 'History and evolution of operating systems', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c7f0a50f-5583-4a07-8753-29d746274916', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 47,
  47, 'Types of OS', 2,
  13, 13,
  true, false, false,
  'content', 39
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c7f0a50f-5583-4a07-8753-29d746274916', 'content_point', 'Describe types of OS: batch, online, multi-access, real time transaction processing, network OS, process control', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c7f0a50f-5583-4a07-8753-29d746274916', 'content_point', 'Distinguish between multitasking, multiprogramming and multiprocessing operating systems', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '33332e82-8c9f-41c5-acb4-f680fe1ff7b6', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 48,
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
  '6a47a519-411f-422a-9310-eafdfac262a0', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 49,
  50, 'Functions of the operating system', 2,
  14, 14,
  true, false, false,
  'content', 41
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6a47a519-411f-422a-9310-eafdfac262a0', 'content_point', 'Device management (interrupt, polling, buffering, spooling, handshaking)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6a47a519-411f-422a-9310-eafdfac262a0', 'content_point', 'Memory management and file management', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6a47a519-411f-422a-9310-eafdfac262a0', 'content_point', 'Process management', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6a47a519-411f-422a-9310-eafdfac262a0', 'content_point', 'Process scheduling strategies: pre-emptive and non-pre-emptive', NULL, 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6a47a519-411f-422a-9310-eafdfac262a0', 'content_point', 'Scheduling algorithms: First Come First Served, Shortest Job First, Shortest Remaining Time, Round Robin', NULL, 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6a47a519-411f-422a-9310-eafdfac262a0', 'content_point', 'Processor sharing concepts (multitasking and multiprogramming)', NULL, 6);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '02bfd3c2-df28-418b-9521-6420cd198129', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 51,
  51, 'Operating system user interfaces', 2,
  14, 14,
  true, false, false,
  'content', 42
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('02bfd3c2-df28-418b-9521-6420cd198129', 'content_point', 'Describe the features: GUI, command driven interface, menu driven, natural language or voice recognition', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('02bfd3c2-df28-418b-9521-6420cd198129', 'content_point', 'Identify the strengths and weaknesses of each', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('02bfd3c2-df28-418b-9521-6420cd198129', 'content_point', 'Choosing the best interface for a user', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b7a444bd-8504-4782-b85f-3aa794504d2c', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 52,
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
  '6dd5d4f7-c7ea-406e-adad-2c05cd9f24f9', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 53,
  53, 'Server Concepts', 2,
  15, 15,
  true, false, false,
  'content', 44
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6dd5d4f7-c7ea-406e-adad-2c05cd9f24f9', 'content_point', 'Properties of stand-alone and server OS', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6dd5d4f7-c7ea-406e-adad-2c05cd9f24f9', 'content_point', 'Setting up OS to connect to wired and wireless network', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6dd5d4f7-c7ea-406e-adad-2c05cd9f24f9', 'content_point', 'Setting up OS to avoid unauthorized access into the system', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2ffb4c1b-6e8a-4b7e-a72d-54fb98ef228c', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 54,
  54, 'Utility Software', 2,
  15, 15,
  true, false, false,
  'content', 45
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ffb4c1b-6e8a-4b7e-a72d-54fb98ef228c', 'content_point', 'Types and role of utility software in system performance', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ffb4c1b-6e8a-4b7e-a72d-54fb98ef228c', 'content_point', 'e.g. disk defragmenter, virus checker, file compression, disk cleaner', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '153f5c33-b4b8-4c20-9a14-2429317a7822', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 55,
  55, 'Graphic software', 2,
  15, 15,
  true, false, false,
  'content', 46
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('153f5c33-b4b8-4c20-9a14-2429317a7822', 'content_point', 'Uses of bitmap and vector graphics', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('153f5c33-b4b8-4c20-9a14-2429317a7822', 'content_point', 'Identify the advantages and disadvantages of each type', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd2429d00-28ac-4c45-bf03-577d22c7eca9', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'c8154e50-e815-47b7-8729-2b4614739808', NULL, 56,
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
  '8461a706-35e1-4c15-b21d-c7ef5685fe92', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'cd3dea26-b2af-4022-a6ab-587321f7c85b', NULL, 57,
  57, 'File and Data Security', 2,
  16, 16,
  true, false, false,
  'content', 48
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8461a706-35e1-4c15-b21d-c7ef5685fe92', 'content_point', 'Backup, transaction logs, archive files, data integrity, access right management, physical protection, disaster planning, user id, passwords, encryption', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '13b831f8-8def-4f0a-a400-76c7bbfb227e', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'cd3dea26-b2af-4022-a6ab-587321f7c85b', NULL, 58,
  58, 'File compression', 2,
  16, 16,
  true, false, false,
  'content', 49
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('13b831f8-8def-4f0a-a400-76c7bbfb227e', 'content_point', 'Compression methods and file systems', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('13b831f8-8def-4f0a-a400-76c7bbfb227e', 'content_point', 'Advantages of compressing a file', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '87c66029-b833-407c-85a5-e080ce8702e6', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'cd3dea26-b2af-4022-a6ab-587321f7c85b', NULL, 59,
  59, 'File Format', 2,
  16, 16,
  true, false, false,
  'content', 50
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('87c66029-b833-407c-85a5-e080ce8702e6', 'content_point', 'Importance of file formats and popular file formats', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('87c66029-b833-407c-85a5-e080ce8702e6', 'content_point', 'Bitmap e.g. JPEG, TIFF, GIF', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('87c66029-b833-407c-85a5-e080ce8702e6', 'content_point', 'Vector e.g. PNG, CGM, EPS, SVG', NULL, 3);
INSERT INTO curriculum_load_log (syllabus_id, severity, message, source_ref) VALUES ('d2f5920a-95b3-4663-b14b-280cac4da1e3', 'correction', 'Sheet prints this row as "99"; loaded as lesson 59', 'File Format');

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '37a848d3-96ab-434f-9fcb-b5671b115d97', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'cd3dea26-b2af-4022-a6ab-587321f7c85b', NULL, 60,
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
  'f40cc034-07c8-4ada-922d-b8a257f456ba', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'cd3dea26-b2af-4022-a6ab-587321f7c85b', NULL, 61,
  61, 'File Format (continued)', 2,
  17, 17,
  true, false, false,
  'content', 52
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f40cc034-07c8-4ada-922d-b8a257f456ba', 'content_point', 'Sound e.g. WAV, MP3, MP4', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f40cc034-07c8-4ada-922d-b8a257f456ba', 'content_point', 'Video e.g. AVI, MPEG; text e.g. PDF, DOC', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f40cc034-07c8-4ada-922d-b8a257f456ba', 'content_point', 'Common application file formats e.g. database (DBF, MDB), spreadsheet (XLS)', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f40cc034-07c8-4ada-922d-b8a257f456ba', 'content_point', 'Hypermedia e.g. HTML, SGML, XML', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b39cab12-46ba-4c1c-89b2-f2da390909b5', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'cd3dea26-b2af-4022-a6ab-587321f7c85b', NULL, 62,
  63, 'Ergonomics', 2,
  17, 17,
  true, false, false,
  'content', 53
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b39cab12-46ba-4c1c-89b2-f2da390909b5', 'content_point', 'Explain ergonomics', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b39cab12-46ba-4c1c-89b2-f2da390909b5', 'content_point', 'Notion of good and comfortable working environment for computer users', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b39cab12-46ba-4c1c-89b2-f2da390909b5', 'content_point', 'Computer related health hazards (RSI, CTS, eye strain) and preventive measures', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f3630947-d20f-4c82-812d-1e4bc7657451', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'cd3dea26-b2af-4022-a6ab-587321f7c85b', NULL, 64,
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
  'adfc5853-f6d3-4ede-99a9-99f446c9c32f', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'cd3dea26-b2af-4022-a6ab-587321f7c85b', NULL, NULL,
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
  '705be64a-fa4c-4721-ac0f-ba5bad2de30a', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 65,
  65, 'Social and economic effects on people and organization', 2,
  19, 19,
  true, false, false,
  'content', 56
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('705be64a-fa4c-4721-ac0f-ba5bad2de30a', 'content_point', 'Changes to existing methods, products, services, working environment, employment', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6801b312-6d24-4119-8d81-0378b4f8edcc', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 66,
  67, 'System security, reliability and resilience', 2,
  19, 19,
  true, false, false,
  'content', 57
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6801b312-6d24-4119-8d81-0378b4f8edcc', 'content_point', 'Explain system security, reliability, and resilience', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6801b312-6d24-4119-8d81-0378b4f8edcc', 'content_point', 'The importance of safe working practices, privacy and data integrity', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6801b312-6d24-4119-8d81-0378b4f8edcc', 'content_point', 'Identify the consequence of system failure', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4bf5d028-a07f-4d61-bf9e-aa190199fe97', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 68,
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
  'c7019a30-e8bc-45ca-909e-2b45efc9e33d', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 69,
  69, 'Computer crime and Protection', 2,
  20, 20,
  true, false, false,
  'content', 59
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c7019a30-e8bc-45ca-909e-2b45efc9e33d', 'content_point', 'Unauthorized access to confidential data, frauds, unauthorized copying of copyrighted materials, plagiarism, illegal storage and use of personal data', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c7019a30-e8bc-45ca-909e-2b45efc9e33d', 'content_point', 'Preventive measures: physical security, security codes, password, encryption, biometrics, monitoring access attempts', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e3ced3b5-ace1-4944-96ed-1da4431a2999', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 70,
  70, 'Natural and software threats to computer systems', 2,
  20, 20,
  true, false, false,
  'content', 60
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e3ced3b5-ace1-4944-96ed-1da4431a2999', 'content_point', 'Natural threats (fire, flood)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e3ced3b5-ace1-4944-96ed-1da4431a2999', 'content_point', 'Software threats: malware, virus, worm, trojan horse, logic bomb', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e3ced3b5-ace1-4944-96ed-1da4431a2999', 'content_point', 'Preventive measures', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3aba4311-4c37-49f5-a73a-40526255afc5', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 71,
  71, 'Professional, ethical, and moral obligations of users and managers', 2,
  20, 20,
  true, false, false,
  'content', 61
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3aba4311-4c37-49f5-a73a-40526255afc5', 'content_point', 'Describe the ethical and moral obligations of users and managers of computerized information systems', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ee2412af-5dec-4fd4-9cc9-1afa2f909361', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 72,
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
  'b30a3e37-14f9-4329-9200-207139f5c447', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 73,
  73, 'Need for privacy and integrity of personal or sensitive data', 2,
  21, 21,
  true, false, false,
  'content', 63
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b30a3e37-14f9-4329-9200-207139f5c447', 'content_point', 'Measures to prevent sharing of personal data on the internet', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b30a3e37-14f9-4329-9200-207139f5c447', 'content_point', 'Explain the need for standard of conduct', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9bdfd1f0-daaa-4f02-a2d6-463c1bfdd46b', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 74,
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
  '877554b8-37b5-4c25-9d27-493e469ff508', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 75,
  75, 'Legislation and Effects of global communication', 2,
  21, 21,
  true, false, false,
  'content', 65
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('877554b8-37b5-4c25-9d27-493e469ff508', 'content_point', 'Explain laws to prohibit hacking, copying of copyrighted material and storage of personal data', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '76617081-5c78-47ef-9e26-11e4d25e0ccb', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '61635f37-d483-418c-bc72-ac4b2e14624e', NULL, 76,
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
  '67bf2c6d-d4be-4027-8213-a691e1d66bbf', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 77,
  78, 'Data protection Act and Global communication Effect', 2,
  22, 22,
  true, false, false,
  'content', 67
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67bf2c6d-d4be-4027-8213-a691e1d66bbf', 'content_point', 'Data protection act of 2004 (UK) and distribution of anti-social materials', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67bf2c6d-d4be-4027-8213-a691e1d66bbf', 'content_point', 'Effects of global communication on citizenship, cultural issues, and digital divide', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3c83f1f4-63c5-4518-8550-5e1a46ab9c37', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 79,
  79, 'Architectural requirements of an IS', 2,
  22, 22,
  true, false, false,
  'content', 68
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3c83f1f4-63c5-4518-8550-5e1a46ab9c37', 'content_point', 'Describe a system and an information system', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3c83f1f4-63c5-4518-8550-5e1a46ab9c37', 'content_point', 'Distinguish between natural and artificial systems, data and information, manual and computer-based information systems', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3c83f1f4-63c5-4518-8550-5e1a46ab9c37', 'content_point', 'Outline the activities of an IS: input, processing, output, storage, and distribution', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9920adde-f6f2-41a7-b74a-d9f63a46a4f5', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 80,
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
  'bd105655-6401-4903-8d21-d4740c9906ee', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 81,
  83, 'Role of IS in an Organization', 2,
  23, 23,
  true, false, false,
  'content', 70
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bd105655-6401-4903-8d21-d4740c9906ee', 'content_point', 'Components of an IS', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bd105655-6401-4903-8d21-d4740c9906ee', 'content_point', 'Illustrate the hierarchical structure of an organisation and describe the IS used at each level', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bd105655-6401-4903-8d21-d4740c9906ee', 'content_point', 'The need of an IS at operational, tactical, and strategic levels', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bd105655-6401-4903-8d21-d4740c9906ee', 'content_point', 'Key features of GIS, HIS, LIS, TPS, MIS, DSS, EIS and area of application of each', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '87dc9d0f-e20b-4350-818c-c3ee1fa4e06e', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 84,
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
  'c82789da-10c1-43e6-a636-387d9f776f2a', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, NULL,
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
  '625b25c4-e71b-430c-9892-7a08f091c8d0', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 85,
  85, 'The role of MIS in planning', 3,
  25, 25,
  true, false, false,
  'content', 73
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('625b25c4-e71b-430c-9892-7a08f091c8d0', 'content_point', 'Decision making and organization of a company', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('625b25c4-e71b-430c-9892-7a08f091c8d0', 'content_point', 'Factors affecting the success or failure of MIS', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a6fd9e74-eb93-4395-ac8d-0363ed5d99f1', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 86,
  87, 'Introduction to Artificial Intelligence (AI)', 3,
  25, 25,
  true, false, false,
  'content', 74
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a6fd9e74-eb93-4395-ac8d-0363ed5d99f1', 'content_point', 'Cognitive science application (expert systems, learning systems)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a6fd9e74-eb93-4395-ac8d-0363ed5d99f1', 'content_point', 'Robotics application (visual perception, tactility)', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a6fd9e74-eb93-4395-ac8d-0363ed5d99f1', 'content_point', 'Natural interface application (natural languages, speech recognition)', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2d5dddeb-429e-44df-b082-558d428eafc0', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 87,
  87, 'Real life application of Artificial Intelligence', 3,
  25, 25,
  true, false, false,
  'content', 75
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2d5dddeb-429e-44df-b082-558d428eafc0', 'content_point', 'In education, health, banking, company, home', NULL, 1);
INSERT INTO curriculum_load_log (syllabus_id, severity, message, source_ref) VALUES ('d2f5920a-95b3-4663-b14b-280cac4da1e3', 'correction', 'Sheet prints this row as "87 (duplicate)"; loaded as lesson 87b', 'Real life application of Artificial Intelligence');

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c79ad3fe-c8bf-4eec-bd0b-72e9b20d0d10', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 88,
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
  'd31394e5-6682-486f-8acd-82187e5ede94', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 89,
  89, 'Robotics Application', 3,
  26, 26,
  true, false, false,
  'content', 77
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d31394e5-6682-486f-8acd-82187e5ede94', 'content_point', 'Uses in manufacturing, health, home', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d31394e5-6682-486f-8acd-82187e5ede94', 'content_point', 'Advantages and limitations of robots', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6ad08b50-fbc3-46ee-86a8-b0f0deef5ed3', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 90,
  90, 'Knowledge-based system (Expert system)', 3,
  26, 26,
  true, false, false,
  'content', 78
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ad08b50-fbc3-46ee-86a8-b0f0deef5ed3', 'content_point', 'Components, application, and examples', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6ad08b50-fbc3-46ee-86a8-b0f0deef5ed3', 'content_point', 'Advantages and disadvantages', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5916a1d9-f56a-402a-8ea5-7823c13fe110', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 91,
  91, 'Introduction to Simulation', 3,
  26, 26,
  true, false, false,
  'content', 79
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5916a1d9-f56a-402a-8ea5-7823c13fe110', 'content_point', 'Definition, application in real life systems or situations', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5916a1d9-f56a-402a-8ea5-7823c13fe110', 'content_point', 'Advantages and limitations', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dbe6a02b-1b19-4ae3-b0e3-455c78261913', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '4421d677-4d06-4433-8cf5-f5656192f016', NULL, 92,
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
  'c10984e0-2120-497f-8a87-86fe3701feb1', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b5f7d53f-9a00-4ced-b5e4-eb3204b56ee2', NULL, 93,
  93, 'Virtual reality (VR) and Augmented Reality (AR)', 3,
  27, 27,
  true, false, false,
  'content', 81
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c10984e0-2120-497f-8a87-86fe3701feb1', 'content_point', 'Description and role of VR and AR', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c10984e0-2120-497f-8a87-86fe3701feb1', 'content_point', 'Compare AR and VR with examples of each', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3148b270-b83f-40fe-a580-23cece73d870', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b5f7d53f-9a00-4ced-b5e4-eb3204b56ee2', NULL, 94,
  95, 'Phases of SDLC', 3,
  27, 27,
  true, false, false,
  'content', 82
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3148b270-b83f-40fe-a580-23cece73d870', 'content_point', 'Investigation: problem identification, data collection, feasibility study (economic, technical, operational, organisational, schedule)', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3148b270-b83f-40fe-a580-23cece73d870', 'content_point', 'Analysis: detailed study of old system, functional requirement analysis, user and technical documentation', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3148b270-b83f-40fe-a580-23cece73d870', 'content_point', 'Design: user interface design, data design, process design', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3148b270-b83f-40fe-a580-23cece73d870', 'content_point', 'Development: developing software, integration of modules, unit, system and integration testing', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7c77e999-e9b5-4e7b-b536-e6b1e7243e24', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b5f7d53f-9a00-4ced-b5e4-eb3204b56ee2', NULL, 96,
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
  '6f12a129-b510-408f-93be-0afe25f7ef8d', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b5f7d53f-9a00-4ced-b5e4-eb3204b56ee2', NULL, 97,
  97, 'System Implementation and Maintenance', 3,
  28, 28,
  true, false, false,
  'content', 84
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6f12a129-b510-408f-93be-0afe25f7ef8d', 'content_point', 'Implementation strategies: direct (plunge), parallel, phased (piecemeal), and pilot', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6f12a129-b510-408f-93be-0afe25f7ef8d', 'content_point', 'Advantages and disadvantages of each type', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6f12a129-b510-408f-93be-0afe25f7ef8d', 'content_point', 'Maintenance: debugging, corrective, adaptive maintenance', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f7871c30-72c5-4cea-991d-0c59de3d44b7', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b5f7d53f-9a00-4ced-b5e4-eb3204b56ee2', NULL, 98,
  99, 'SDLC Models', 3,
  28, 28,
  true, false, false,
  'content', 85
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f7871c30-72c5-4cea-991d-0c59de3d44b7', 'content_point', 'Describe waterfall, V-shape, prototyping, spiral models', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f7871c30-72c5-4cea-991d-0c59de3d44b7', 'content_point', 'Waterfall versus V-shape model', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ddcc2f7a-ec57-4c24-830b-4b9088144909', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b5f7d53f-9a00-4ced-b5e4-eb3204b56ee2', NULL, 100,
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
  'babb9e1b-a5fc-4620-b78a-4b4dacd5658f', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b5f7d53f-9a00-4ced-b5e4-eb3204b56ee2', NULL, NULL,
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
  'ee8b4e2a-7bef-435e-b799-f19387910d57', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b5f7d53f-9a00-4ced-b5e4-eb3204b56ee2', NULL, NULL,
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
  '9570797c-6f9b-4bee-9f11-c52274cab279', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '0b5d2573-8444-4a7b-9971-aba72a9248c8', NULL, 101,
  101, 'Project Management', 3,
  31, 31,
  true, false, false,
  'content', 89
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9570797c-6f9b-4bee-9f11-c52274cab279', 'content_point', 'Define a project and project management', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9570797c-6f9b-4bee-9f11-c52274cab279', 'content_point', 'Explain project management concepts: task, predecessor, successor, slack task/time, lag, lead, milestone, critical path/task, early finish, late finish, early start, late start', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '20bc22a4-9a88-4d3f-aa74-2ebbbacc215a', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '0b5d2573-8444-4a7b-9971-aba72a9248c8', NULL, 102,
  102, 'Project constraints and Role of project management team', 3,
  31, 31,
  true, false, false,
  'content', 90
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20bc22a4-9a88-4d3f-aa74-2ebbbacc215a', 'content_point', 'Scope, time, and cost', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20bc22a4-9a88-4d3f-aa74-2ebbbacc215a', 'content_point', 'Identify the roles and responsibilities of project management team members', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '54287257-bc0f-4df1-95a7-86e4c5ceea5b', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '0b5d2573-8444-4a7b-9971-aba72a9248c8', NULL, 103,
  103, 'Project management phases', 3,
  31, 31,
  true, false, false,
  'content', 91
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('54287257-bc0f-4df1-95a7-86e4c5ceea5b', 'content_point', 'Describe the activities of project initiation, planning, execution, control and monitoring, reporting stages', NULL, 1);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c0038606-e213-4352-b666-7575021cbe90', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '0b5d2573-8444-4a7b-9971-aba72a9248c8', NULL, 104,
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
  '54f27c80-e0b7-478d-87cc-58366e82daae', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '0b5d2573-8444-4a7b-9971-aba72a9248c8', NULL, 105,
  107, 'Project control and scheduling methods', 3,
  32, 32,
  true, false, false,
  'content', 93
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('54f27c80-e0b7-478d-87cc-58366e82daae', 'content_point', 'PERT chart, critical path analysis; use the network diagram to determine project deadline, slack or float (free and total), critical path and tasks', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('54f27c80-e0b7-478d-87cc-58366e82daae', 'content_point', 'Gantt chart', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('54f27c80-e0b7-478d-87cc-58366e82daae', 'content_point', 'Critical Path Method (CPM)', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('54f27c80-e0b7-478d-87cc-58366e82daae', 'content_point', 'Differences between PERT and Gantt; advantages and disadvantages of PERT and CPM', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f8f0973b-ac49-4abc-87d8-6a9598513c4e', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', '0b5d2573-8444-4a7b-9971-aba72a9248c8', NULL, 108,
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
  'b4f25534-6699-40ee-9a6a-1f216713df26', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', NULL, 109,
  109, 'E-commerce', 3,
  33, 33,
  true, false, false,
  'content', 95
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4f25534-6699-40ee-9a6a-1f216713df26', 'content_point', 'Definition and types', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4f25534-6699-40ee-9a6a-1f216713df26', 'content_point', 'E-commerce forms (B2C, B2B)', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4f25534-6699-40ee-9a6a-1f216713df26', 'content_point', 'Medium of purchase, fund transfer', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4f25534-6699-40ee-9a6a-1f216713df26', 'content_point', 'Advantages and disadvantages', NULL, 4);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '74fbdbdd-50fc-48fc-98aa-44cb4a878396', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', NULL, 110,
  110, 'E-banking', 3,
  33, 33,
  true, false, false,
  'content', 96
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('74fbdbdd-50fc-48fc-98aa-44cb4a878396', 'content_point', 'Describe e-banking activities', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('74fbdbdd-50fc-48fc-98aa-44cb4a878396', 'content_point', 'Types: usefulness of ATM, POS, and Internet banking transactions', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('74fbdbdd-50fc-48fc-98aa-44cb4a878396', 'content_point', 'Advantages and disadvantages of e-banking to banks and customers', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e70febc3-b46a-4c50-b838-93ae73e225b6', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', NULL, 111,
  111, 'E-Health', 3,
  33, 33,
  true, false, false,
  'content', 97
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e70febc3-b46a-4c50-b838-93ae73e225b6', 'content_point', 'Define e-health and its applications', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e70febc3-b46a-4c50-b838-93ae73e225b6', 'content_point', 'Role, advantages and disadvantages of e-health technologies e.g. medical information system, telemedicine, electronic medical records system', NULL, 2);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c735c740-eb12-44ba-a9c1-619dfac62b95', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', NULL, 112,
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
  'b73c2c37-d448-451b-8fcc-11e1869fc2e8', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', NULL, 113,
  113, 'Computer Assisted Learning (CAL)', 3,
  34, 34,
  true, false, false,
  'content', 99
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b73c2c37-d448-451b-8fcc-11e1869fc2e8', 'content_point', 'Define CAL', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b73c2c37-d448-451b-8fcc-11e1869fc2e8', 'content_point', 'Methods of course delivery e.g. servers, CD-ROM, didactic resources (e-books)', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b73c2c37-d448-451b-8fcc-11e1869fc2e8', 'content_point', 'Advantages and limitations', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e0d6450d-9922-4f39-aac8-9629d128039f', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', NULL, 114,
  115, 'E-government', 3,
  34, 34,
  true, false, false,
  'content', 100
);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e0d6450d-9922-4f39-aac8-9629d128039f', 'content_point', 'Define e-government', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e0d6450d-9922-4f39-aac8-9629d128039f', 'content_point', 'Describe forms: e-governance, e-taxation, e-vote', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e0d6450d-9922-4f39-aac8-9629d128039f', 'content_point', 'Implication of e-government to the government and citizens', NULL, 3);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ec6b1f95-6db8-4884-b9d0-6ddc2919a5d7', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', NULL, 116,
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
  '313315dc-d6e3-49b8-904d-67dedeb8b126', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', NULL, NULL,
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
  '2b90c058-f93a-419d-8f38-5fb4c70bde27', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'b7bc4bcd-bd1e-4e07-8c2d-028b4a18fa8a', NULL, NULL,
  NULL, 'Integration activities and Evaluation 6', 3,
  36, 36,
  true, false, false,
  'evaluation', 103
);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('b22d4e47-3d61-473a-9759-93a57d11f1fe', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Section 1: Computer system', 1, 'See PRACTICAL WORKBOOK');
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('b22d4e47-3d61-473a-9759-93a57d11f1fe', 'Identify and describe hardware installed and their role', 1, 1, 1, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('b22d4e47-3d61-473a-9759-93a57d11f1fe', 'Differentiating between the system and application software installed', 1, 1, 1, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('b22d4e47-3d61-473a-9759-93a57d11f1fe', 'Managing files using input devices (mouse, keyboard); creating, naming and renaming folders', 1, 2, 2, 3);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('cf4634da-ed6a-4626-b969-8b35d14dbb44', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Working with Application software: Microsoft Word', 2, NULL);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('cf4634da-ed6a-4626-b969-8b35d14dbb44', 'Open MS Word and save the file in a specified location', 1, 3, 3, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('cf4634da-ed6a-4626-b969-8b35d14dbb44', 'Inputting text, pictures, shapes; format and edit text; find and replace text', 1, 3, 3, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('cf4634da-ed6a-4626-b969-8b35d14dbb44', 'Working with page layout; add headers and footers; inserting and formatting tables and shapes; printing', 1, 3, 3, 3);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Section 2: Presentation Software', 3, 'See practical workbook');
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Describe main features of presentation software; select a suitable template, scheme and layout; create and save a new presentation', 1, 4, 4, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Opening an existing presentation; explain the features of tab commands (home, insert, design, transitions)', 1, 4, 4, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Add and format text; create a new slide; change font format; apply bulleted or numbered lists; add images and shapes; use Format Painter', 1, 5, 5, 3);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Insert charts; format chart elements (series, axes, titles, data labels, legend, plot area)', 1, 7, 7, 4);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Apply text outline or text effect; change chart elements and layout; edit data series', 1, 9, 9, 5);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Use chart button to label data; improve appearance; hide and show series and categories', 1, 10, 10, 6);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Change layout of chart elements (add, remove, position labels, axis titles, legends, trend lines); apply chart styles', 1, 11, 11, 7);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Working with SmartArt: insert, add text, add shapes, change position, flip, format', 2, 14, 14, 8);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Working with tables: insert, add rows and columns, apply styles, merge and split cells, adjust size, format data', 2, 15, 15, 9);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Importing into PowerPoint: object linking and embedding (OLE); embed Word tables and Excel tables and charts; link Excel charts', 2, 16, 16, 10);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Delivering your presentation: create a custom show; apply animation to text and graphics; timing; running a slide show', 2, 17, 17, 11);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('976acab0-472a-471c-88f7-0c386342f371', 'Shapes and picture enhancements: draw, resize, edit, reposition, merge, align, connect shapes; adjust picture appearance, border, style, cropping', 2, 19, 19, 12);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('ece535c9-0deb-410f-b064-35b5b7b90b16', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Section 3: Spreadsheet', 4, 'Practical manual');
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('ece535c9-0deb-410f-b064-35b5b7b90b16', 'Explain basic spreadsheet concepts (workbook, worksheet, sheet tabs, active sheet); introduction to MS Excel; features of the displayed screen; switching between worksheets', 2, 20, 20, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('ece535c9-0deb-410f-b064-35b5b7b90b16', 'Cell references: distinguish relative and absolute; add or remove rows and columns; format cell entries and cells including conditional formatting', 2, 21, 21, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('ece535c9-0deb-410f-b064-35b5b7b90b16', 'Data entry and editing: autofill, copy and paste, drag and drop, saving a workbook, editing and clearing cell contents, undo; modifying columns and rows', 2, 22, 22, 3);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('ece535c9-0deb-410f-b064-35b5b7b90b16', 'Formatting text: alignment, merging cells, underline, bold, italic, font type, size and colour; number formatting including accounting, percentage and decimal places', 2, 23, 23, 4);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('ece535c9-0deb-410f-b064-35b5b7b90b16', 'Spreadsheet functions for financial and statistical analysis: MAX, MIN, SUM, AVERAGE, COUNT, PRODUCT', 3, 25, 25, 5);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('ece535c9-0deb-410f-b064-35b5b7b90b16', 'IF function, SUMIF, COUNTIF, SUMPRODUCT, nested IF', 3, 26, 26, 6);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('ece535c9-0deb-410f-b064-35b5b7b90b16', 'RANK, ROUND, CONCATENATE, VLOOKUP and HLOOKUP', 3, 27, 27, 7);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('ece535c9-0deb-410f-b064-35b5b7b90b16', 'Represent data on a chart; format the chart; adjust labels, legend, titles; change chart type; swap rows and columns; link Excel formulae between worksheets; add Excel charts to Word or PowerPoint', 3, 28, 28, 8);

INSERT INTO practical_sections (id, syllabus_id, title, sequence, workbook_ref) VALUES ('183c8460-e1d6-45e1-b380-84b3ad175537', 'd2f5920a-95b3-4663-b14b-280cac4da1e3', 'Web Authoring', 5, NULL);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('183c8460-e1d6-45e1-b380-84b3ad175537', 'Web authoring', 3, 29, 29, 1);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('183c8460-e1d6-45e1-b380-84b3ad175537', 'Web authoring', 3, 31, 31, 2);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('183c8460-e1d6-45e1-b380-84b3ad175537', 'Web authoring', 3, 32, 32, 3);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('183c8460-e1d6-45e1-b380-84b3ad175537', 'Web authoring', 3, 33, 33, 4);
INSERT INTO practical_tasks (practical_section_id, description, term, week_from, week_to, sequence) VALUES ('183c8460-e1d6-45e1-b380-84b3ad175537', 'Web authoring', 3, 34, 34, 5);

COMMIT;
