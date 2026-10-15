-- National Harmonised Progression Sheet for Computer Science Lower Sixth
--
-- The 2026/2027 national sheet. It replaces the sheet previously loaded
-- for this form level, IN PLACE.
--
-- The syllabus row keeps its id. note_sources.syllabus_id and
-- classes.syllabus_id both point at it, so a new id would cut every
-- student off from their notes and every class from its sheet.
--
-- Nothing is deleted. Seven tables hang off lessons(id): objectives,
-- lesson_note_sections, lesson_resources (the uploaded handouts),
-- question_lessons (question tagging), lesson_mastery (student progress),
-- scheme_entries and assessments. Five would cascade and two would refuse
-- the delete outright. So old rows are archived instead, and every
-- attachment is carried across to the new row of the same name.
--
-- Ids are derived from the sheet, so running this twice changes nothing.

BEGIN;

-- Both 2026/2027 sheets close with a Revision block. 'revision' is a new
-- lesson kind; without this the inserts below fail the check constraint.
ALTER TABLE lessons DROP CONSTRAINT IF EXISTS lessons_lesson_kind_check;
ALTER TABLE lessons ADD CONSTRAINT lessons_lesson_kind_check CHECK (
  lesson_kind IN ('content','diagnostic_evaluation','integration_activity',
                  'evaluation','remediation','practical','revision'));

-- ------------------------------------------------------------------
-- 1. Find the syllabus row this sheet belongs to.
--
-- Found rather than assumed. Hard-coding the id from an earlier seed
-- fails on any database where that seed ran with a different one, and it
-- fails late: the UPDATE silently matches nothing and the first INSERT
-- then reports a foreign key violation with no hint of the cause.
--
-- Preference order is the row your classes point at, then the row your
-- notes point at, then the oldest. Those are the same row on a healthy
-- database; where they differ, the classes win, because that is the sheet
-- your students are actually attached to.
-- ------------------------------------------------------------------

INSERT INTO subjects (name) VALUES ('Computer Science') ON CONFLICT (name) DO NOTHING;
INSERT INTO levels (name, short_name) VALUES ('GCE Advanced Level', 'A/L') ON CONFLICT (name) DO NOTHING;

DROP TABLE IF EXISTS target_syllabus;
CREATE TEMP TABLE target_syllabus AS
SELECT s.id FROM syllabi s
 WHERE s.form_level = 'Lower Sixth' AND s.deleted_at IS NULL AND s.subject_id = (SELECT id FROM subjects WHERE name = 'Computer Science')
 ORDER BY (SELECT count(*) FROM classes c WHERE c.syllabus_id = s.id) DESC,
          (SELECT count(*) FROM note_sources n WHERE n.syllabus_id = s.id) DESC,
          s.created_at
 LIMIT 1;

-- Nothing for this form level yet, so start one.
INSERT INTO syllabi (
  id, subject_id, level_id, title, form_level, issuing_authority, scope,
  region, version_label, effective_from, total_weeks, weekly_periods_theory,
  weekly_periods_practical, coefficient, module_label, has_modules,
  uses_competencies, has_competency_statements, has_practical_stream)
SELECT
  '740cda5d-4792-5fa5-8eb1-639fdb2d19a2',
  (SELECT id FROM subjects WHERE name = 'Computer Science'),
  (SELECT id FROM levels   WHERE name = 'GCE Advanced Level'),
  'National Harmonised Progression Sheet for Computer Science Lower Sixth', 'Lower Sixth', 'Inspectorate General of Education, Inspectorate of Pedagogy in charge of the Teaching of Computer Science',
  'national', NULL, 'National Harmonised Progression 2026/2027',
  2026, 36,
  8, NULL,
  NULL, 'Module', true,
  true, false,
  false
WHERE NOT EXISTS (SELECT 1 FROM target_syllabus)
ON CONFLICT (id) DO NOTHING;

DROP TABLE IF EXISTS target_syllabus;
CREATE TEMP TABLE target_syllabus AS
SELECT s.id FROM syllabi s
 WHERE s.form_level = 'Lower Sixth' AND s.deleted_at IS NULL AND s.subject_id = (SELECT id FROM subjects WHERE name = 'Computer Science')
 ORDER BY (SELECT count(*) FROM classes c WHERE c.syllabus_id = s.id) DESC,
          (SELECT count(*) FROM note_sources n WHERE n.syllabus_id = s.id) DESC,
          s.created_at
 LIMIT 1;

-- Stop here, loudly, rather than fail forty inserts later with a foreign
-- key message that says nothing about what went wrong.
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM target_syllabus) THEN
    RAISE EXCEPTION 'No syllabus row for Lower Sixth and none could be created';
  END IF;
END $$;

-- ------------------------------------------------------------------
-- 2. What this sheet is going to consist of.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS new_lesson_ids;
CREATE TEMP TABLE new_lesson_ids (id UUID PRIMARY KEY);
INSERT INTO new_lesson_ids (id) VALUES
  ('9115c6be-7307-5ae8-bb57-70f887a5db0a'),
  ('61146a58-d677-522c-8873-7b878ffeaab6'),
  ('8ed7d902-6993-50b6-8157-1f11dd6cb579'),
  ('985c46cc-4f2c-5705-b769-08171c24dbbf'),
  ('7625c809-f41e-510d-81f6-6183a3e3cb12'),
  ('bcae5d1a-9ede-5a12-b382-b625071e3209'),
  ('e984a016-b1ad-51de-9f83-ace6ca2d53aa'),
  ('9ee8d33e-eaed-5ba6-96e8-4da26fc8bd99'),
  ('fe85e845-552e-5bb0-9274-4e413c5ff5c3'),
  ('3fee5bfa-8870-50fc-8082-54be26f25db1'),
  ('a8c2122b-0530-5f40-958d-542e1ba642e0'),
  ('a667bd47-3f2f-546f-8b73-f8043c31ffb7'),
  ('9326f60e-ea6e-529d-9654-846753bf9b38'),
  ('04d44b96-ae03-5afb-9a5b-314df7d054dc'),
  ('5543c929-2386-501b-813c-abd595db7619'),
  ('4747734a-dd19-572d-80b2-a2404c13fb87'),
  ('207c4f06-b6d7-5b5f-89cb-05facb331086'),
  ('ee6a0465-2251-5a4f-9788-23a9186d24ba'),
  ('eaddedcb-51e0-5b36-9d48-12d8898edd0b'),
  ('3fe3d8fc-cc55-5bb6-8416-91a72472a1f9'),
  ('ce9b3ae5-00aa-573a-b66f-96982543a5fd'),
  ('b58e582f-8afb-544a-a373-6041c2d707ca'),
  ('c57cdf32-08af-5d3a-b72b-e552583a90e7'),
  ('3e85e795-430a-5980-8ab3-6bddeef7b8b9'),
  ('e2abf33a-4ec0-5daf-8efb-09b470338f8e'),
  ('b79b397c-15fc-542f-aa5c-e96c5a29f4c2'),
  ('cc1b7351-3a4a-5854-ae41-ef21a5604e2b'),
  ('a285ccb4-a198-5360-b5d2-9b5a6df560b7'),
  ('807a552d-cecf-5b0a-8e77-4635db7d3e11'),
  ('05720d04-7e85-575f-a11c-033ef0f803ff'),
  ('d8e391d7-32e9-5558-a6e5-37c57dc09141'),
  ('615ff235-f2e7-5762-8e53-5d11b2bbbf77'),
  ('30f51d7e-2ebd-5f8e-b324-b7b951d30cbe'),
  ('6f9ef15f-5452-57ce-a843-2b8078721923'),
  ('e520efaf-68b0-5264-9030-d3fb87a1da58'),
  ('a46ab2ef-a827-529c-ac2c-8cd3749ba175'),
  ('8828a246-9536-5330-b0b4-6b1e587735b4'),
  ('7b4620f5-3a66-5fa0-bb5a-1dbd5db8e61e'),
  ('1dadee41-7239-5acb-b3d1-e6cf44c3d100'),
  ('a1ea451d-78ce-539c-915f-1919b1a557aa'),
  ('e882ecfa-243c-5083-ba6c-67cbc353b2bd'),
  ('03dfa9dc-6ce4-5aa9-91a2-503b5f0ab95d'),
  ('3819a812-8527-5762-9834-efa0a4cb1f5e'),
  ('a9a21434-2460-5f7b-9ee0-ab65ccb40be3'),
  ('98ba3b8f-0888-5cd4-9741-bbe6e09aca9c'),
  ('c46d42f7-a716-5200-a69a-73792a8b463c'),
  ('239fadf7-ce8d-5d31-b8a4-8b5b1d922b96'),
  ('9198e81d-10ad-5989-8268-cfba87aa8bb9'),
  ('c12ff0fb-db4a-57ee-8112-a27a24c3999a'),
  ('46470bdd-8972-5d99-a7ef-fdb523d7821b'),
  ('f65a7de0-0f70-5caf-a71c-2992b7212029'),
  ('9d6e861e-3bd0-50a4-8516-7a3f8a38fe19'),
  ('59f3ddbc-ef7f-5e9c-8eda-349075257f33'),
  ('28beab4a-f6ee-521f-942a-780f6d31fa6b'),
  ('0ba8d072-dbc4-5c3e-bdcb-21e3551b0ef6'),
  ('2c04cd58-5b34-5882-b972-88ba038d39d7'),
  ('9426382c-bf32-502b-91da-c790298952fc'),
  ('ef23bde6-7d34-5910-97b0-d27761b41418'),
  ('aefa03a1-0c01-5774-b5b0-4f7aafb422ef'),
  ('6335dd2f-6631-5bb2-afcc-1b245a660abf'),
  ('f7631d3c-d7fd-569e-838f-21b55f87bb12'),
  ('60e8a468-52a5-5f5e-9302-36d97c193f6c'),
  ('22cf42ff-1b50-507c-8294-d93e89125c65'),
  ('12b84d74-2f72-57dc-9377-6826bdde9c78'),
  ('09608fb5-e2a3-5991-b553-1084d05bd046'),
  ('caff8ba8-2b93-55ed-ba4d-f79d6f41c154'),
  ('8daa8a29-8769-5aa0-8a10-789a41f41e96'),
  ('8f187f7f-b05a-532b-8981-307aa482a047'),
  ('768cf23d-6237-5250-ae83-745b5120d6f4'),
  ('b243423c-b2a8-5f0d-8224-f276e2cfe603'),
  ('67188d2a-1a9e-5d93-8eb8-1aa448e3f2ea'),
  ('5655aa0a-0c2b-5f3a-8a7c-23e0de506ef1'),
  ('cdd0c354-b808-56f5-bfe7-f4a73b16a1fb'),
  ('ad8dcc41-a34c-5db0-a195-9c24b050417f'),
  ('e845a706-7a7c-585d-9e6a-3615f6201c8f'),
  ('a0200b77-0fbf-5dff-9068-5bb7ccb1ab22'),
  ('9d7407c5-f01a-5ec3-a9a2-ffa864bf2800'),
  ('049b3fe7-4647-57ff-8524-d4c5278669b6'),
  ('9a4ecdbd-72d9-5734-9629-143f56cb1149'),
  ('69066fcb-4fd1-50d9-b658-cc58e1411770'),
  ('8b54699a-8f4a-53c1-9141-fd41a14a8c50'),
  ('e9c81c84-2318-5118-8673-9e1bb5e6abb5'),
  ('7dff9fa1-26a5-5660-a1f0-ab2887ec8ebc'),
  ('00a94e82-40e8-5fff-b093-20201ba53689'),
  ('925324fb-7a31-558d-ac45-4d20f4158def'),
  ('003b4f86-375f-59aa-a255-63a896d80bce'),
  ('d14b75ed-8b82-5546-8991-32a47d744ffd'),
  ('8dfa9561-e7c4-5b33-875a-21c3ceb586af'),
  ('ca1f187f-3aca-5b19-bc6e-8efa12e6a002'),
  ('e5c57c82-04d1-5237-9efc-2142bfab1b4d'),
  ('2712ab9b-a561-5345-9b35-8c85f6019228'),
  ('e9d5e6bf-693a-54b4-9859-00290809fe7d'),
  ('9e0e4e93-a931-5b54-a981-798cd0cd4623'),
  ('d5a3471d-52b7-5f8e-a7c2-ea1f664ff944'),
  ('44901413-51bc-5593-a323-dc2e7911c8bb'),
  ('adc1b386-0328-5d5e-973c-868738a02152'),
  ('9ecb4c0b-2293-54c9-a390-a0adbe83e4d0'),
  ('67d2ce0d-6538-5c7f-8836-b2f60490942c'),
  ('704a46dc-691b-5a67-b164-442b574d4d9f'),
  ('250c748f-cc29-5bb4-8879-18414fe11f58'),
  ('7e3631d4-a4dc-5ef0-b561-1d562929ed73'),
  ('0ff0c895-8c71-5250-bcb7-567e57c17271'),
  ('1beec596-3d78-522a-9ffd-0ad20ebd7879'),
  ('591cdce2-8c2a-5c66-bee0-5c8863c361d5'),
  ('1fa9d78d-fdff-5cfb-ad44-476f66781290'),
  ('5d6939b4-0f3f-5d71-be49-1090fda1e5c7'),
  ('c49b9267-ab1c-5808-9ba8-3a4e0c217575'),
  ('c072fbef-fa60-57c0-9b9f-6064143a642a'),
  ('7a947061-ada4-5ae5-85b8-06d445f5ce1b'),
  ('a89fa203-4bd8-5d68-9f31-46b5475d993d'),
  ('90814be2-9b3f-52df-8710-1d7d6a5bdbc6'),
  ('2ce257aa-a298-521d-b096-f706b8eb4240'),
  ('caa83235-3f98-5817-b04b-e25623be7ba4'),
  ('57a6dbdd-a876-50d2-a2db-3f12ed97a063'),
  ('097df07f-cb29-5e3f-a212-231faa6ee9d4'),
  ('ebe5c5b7-b07c-5926-90b1-c36aa5a61421'),
  ('53ae8e03-b31e-5ec6-a121-4c7171b0408c'),
  ('b478c9bf-fc1c-560a-9007-78a07e90a098'),
  ('c44bbe23-2cb6-57b3-a09a-d2e1a7a31b8a'),
  ('63c4a9d5-730c-5914-aa8b-8457c41c476d'),
  ('68a4d011-cd3d-5054-9555-2207d7576b94'),
  ('4e02f301-d66b-5322-bcb1-d81de0f99cea'),
  ('ae206363-3a34-5895-a1ad-a38373e2a25b'),
  ('78438dae-5537-500a-b976-2078012386ec'),
  ('bf5c211c-9384-5b86-b6c7-e987c83ba30b'),
  ('19a3da30-4e50-5d8e-9bd1-38ec468bb096'),
  ('dd9391c7-7358-5a7d-99cc-0f12f8b1258e'),
  ('d79a8c3e-d228-554f-a4c3-5dc8cc0a88d5'),
  ('312164ce-c7b3-5aca-b84d-7d791c05363d'),
  ('62c64ce5-39ee-5154-bec8-11260f647a52'),
  ('ede3e07f-494c-5cf9-941e-e37282b2a60f'),
  ('63e740bb-bac2-55b7-ba6b-355b61760aa8'),
  ('d745cede-5f88-593d-bdd9-34c0866fe700'),
  ('4ea264ec-7825-5ae4-8aff-2793db8c323c'),
  ('94a357cc-063f-5f71-9b4f-f28e76834be0'),
  ('bf0355a2-c7a7-53ce-9aa0-897a952f6bf0'),
  ('f2c7b618-ea72-5ca8-bc01-b1dcbaeb50d4');

DROP TABLE IF EXISTS new_comp_ids;
CREATE TEMP TABLE new_comp_ids (id UUID PRIMARY KEY);
INSERT INTO new_comp_ids (id) VALUES
  ('67897cf8-6c51-5cb6-9ce6-973672612017'),
  ('d3a6e2df-1218-5dbd-8c29-0c911edf86f4'),
  ('b51971a2-0820-541d-bb43-88d4733ce352'),
  ('789d1f8a-c91c-5a0b-aec0-035260118835'),
  ('8f5e1f53-784e-58b2-a617-e833f4bc2580'),
  ('996a93ea-5781-5d93-99bf-620aa42ad5d9'),
  ('a3e39011-9cf8-57fe-9a8b-a09a1e3857c0'),
  ('e94bfd7e-8fba-5697-a428-03a39c255a3b'),
  ('48d422f7-39e9-5592-9252-9c6ebb1c0e17'),
  ('a995edf1-9b16-5d3d-8c97-f3f60cac931b'),
  ('610b76e2-1750-522d-8908-be5e36ed9a86'),
  ('cc23c721-9b82-5481-9007-0af1f8382e35'),
  ('840517c7-e44c-50e0-bb23-9226c9528f46'),
  ('0e822c33-dcf5-5511-bead-68e5a7baf73c'),
  ('3067f4de-46d5-544d-b79d-db28e2915ab7'),
  ('65b30987-963e-57cf-b00d-b124cd51439e');

DROP TABLE IF EXISTS new_module_ids;
CREATE TEMP TABLE new_module_ids (id UUID PRIMARY KEY);
INSERT INTO new_module_ids (id) VALUES
  ('ec8e9254-3973-5991-8a67-7b94dcbd8580'),
  ('6c24cf56-a7f0-57d9-978d-d969ac9f173f'),
  ('a9a841d7-8e5f-55be-afb4-e16839371658'),
  ('7d53b1c7-3890-5d06-b8d5-e753f6517d50'),
  ('40f4d578-4799-5dbb-bc18-33a1c196d6dc'),
  ('8c1b9b89-0b69-5617-b663-7d6ab194bdee'),
  ('6688cc90-efc9-5a5a-a9b0-5895e51d7e58'),
  ('13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1');

-- The outgoing sheet, captured before anything moves. On a second run
-- this comes back empty, which is what makes the re-run a no-op.
DROP TABLE IF EXISTS old_lessons;
CREATE TEMP TABLE old_lessons AS
SELECT id, title, status, content FROM lessons
 WHERE syllabus_id = (SELECT id FROM target_syllabus) AND deleted_at IS NULL
   AND id NOT IN (SELECT id FROM new_lesson_ids);

-- Exam frequency is the teacher's judgement, not the Ministry's, and it
-- is keyed by the name of the category of action rather than by id.
DROP TABLE IF EXISTS old_freq;
CREATE TEMP TABLE old_freq AS
SELECT category_of_action, exam_frequency, continues_from_id, link_confirmed
  FROM competencies WHERE syllabus_id = (SELECT id FROM target_syllabus) AND exam_frequency IS NOT NULL;

-- ------------------------------------------------------------------
-- 3. The sheet header
-- ------------------------------------------------------------------

UPDATE syllabi SET
  subject_id = (SELECT id FROM subjects WHERE name = 'Computer Science'),
  level_id   = (SELECT id FROM levels   WHERE name = 'GCE Advanced Level'),
  title = 'National Harmonised Progression Sheet for Computer Science Lower Sixth',
  form_level = 'Lower Sixth',
  issuing_authority = 'Inspectorate General of Education, Inspectorate of Pedagogy in charge of the Teaching of Computer Science',
  scope = 'national', region = NULL,
  version_label = 'National Harmonised Progression 2026/2027',
  effective_from = 2026,
  total_weeks = 36,
  weekly_periods_theory = 8,
  weekly_periods_practical = NULL,
  coefficient = NULL,
  module_label = 'Module',
  has_modules = true,
  uses_competencies = true,
  has_competency_statements = false,
  has_practical_stream = false,
  updated_at = now()
WHERE id = (SELECT id FROM target_syllabus);

-- ------------------------------------------------------------------
-- 4. Archive the outgoing rows.
--
-- The sequence has to move because of UNIQUE (syllabus_id, sequence),
-- which a soft delete does not exempt a row from. Offsetting past the
-- current maximum leaves room for this to be run again.
-- ------------------------------------------------------------------

UPDATE lessons SET deleted_at = now(), status = 'archived',
  sequence = sequence + 1000 + (SELECT coalesce(max(sequence), 0)
                                  FROM lessons WHERE syllabus_id = (SELECT id FROM target_syllabus))
 WHERE syllabus_id = (SELECT id FROM target_syllabus) AND deleted_at IS NULL
   AND id NOT IN (SELECT id FROM new_lesson_ids);

UPDATE competencies SET deleted_at = now(),
  sequence = sequence + 1000 + (SELECT coalesce(max(sequence), 0)
                                  FROM competencies WHERE syllabus_id = (SELECT id FROM target_syllabus))
 WHERE syllabus_id = (SELECT id FROM target_syllabus) AND deleted_at IS NULL
   AND id NOT IN (SELECT id FROM new_comp_ids);

UPDATE modules SET deleted_at = now(),
  sequence = sequence + 1000 + (SELECT coalesce(max(sequence), 0)
                                  FROM modules WHERE syllabus_id = (SELECT id FROM target_syllabus))
 WHERE syllabus_id = (SELECT id FROM target_syllabus) AND deleted_at IS NULL
   AND id NOT IN (SELECT id FROM new_module_ids);

-- ------------------------------------------------------------------
-- 5. The new sheet
-- ------------------------------------------------------------------

INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('ec8e9254-3973-5991-8a67-7b94dcbd8580', (SELECT id FROM target_syllabus), 'Computer Applications, Artificial Intelligence & Emerging technologies and their Socio-Economic Implications', 1)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('6c24cf56-a7f0-57d9-978d-d969ac9f173f', (SELECT id FROM target_syllabus), 'Computer Organisation and Architecture', 2)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('a9a841d7-8e5f-55be-afb4-e16839371658', (SELECT id FROM target_syllabus), 'Problem-Solving and Algorithm Design', 3)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('7d53b1c7-3890-5d06-b8d5-e753f6517d50', (SELECT id FROM target_syllabus), 'Programming I', 4)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('40f4d578-4799-5dbb-bc18-33a1c196d6dc', (SELECT id FROM target_syllabus), 'Data Structures 1', 5)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('8c1b9b89-0b69-5617-b663-7d6ab194bdee', (SELECT id FROM target_syllabus), 'Algorithm Efficiency', 6)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('6688cc90-efc9-5a5a-a9b0-5895e51d7e58', (SELECT id FROM target_syllabus), 'Computer Networks and Data Communication', 7)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1', (SELECT id FROM target_syllabus), 'Introduction to Web Development Technologies', 8)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();

INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('67897cf8-6c51-5cb6-9ce6-973672612017', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580', 'Exploring AI Concepts and Emerging technologies', NULL, 1)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('d3a6e2df-1218-5dbd-8c29-0c911edf86f4', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580', 'Description of Computer Systems', NULL, 2)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('b51971a2-0820-541d-bb43-88d4733ce352', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580', 'Utilization of digital resources', NULL, 3)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('789d1f8a-c91c-5a0b-aec0-035260118835', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580', 'Application areas of computers and evaluating the Implications of Computers', NULL, 4)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('8f5e1f53-784e-58b2-a617-e833f4bc2580', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f', 'Representing data in Computer Systems', NULL, 5)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('996a93ea-5781-5d93-99bf-620aa42ad5d9', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f', 'Designing and Analysing Digital Logic Circuits', NULL, 6)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('a3e39011-9cf8-57fe-9a8b-a09a1e3857c0', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f', 'Exploring Computer Organisation and Architecture', NULL, 7)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e94bfd7e-8fba-5697-a428-03a39c255a3b', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f', 'Managing Computer Memory', NULL, 8)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('48d422f7-39e9-5592-9252-9c6ebb1c0e17', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f', 'Understanding Peripheral Communication and Data Transfer', NULL, 9)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('a995edf1-9b16-5d3d-8c97-f3f60cac931b', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658', 'Designing Algorithms', NULL, 10)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('610b76e2-1750-522d-8908-be5e36ed9a86', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658', 'Designing Modular Algorithms', NULL, 11)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('cc23c721-9b82-5481-9007-0af1f8382e35', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50', 'Understanding Programming Language Concepts', NULL, 12)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('840517c7-e44c-50e0-bb23-9226c9528f46', (SELECT id FROM target_syllabus), '40f4d578-4799-5dbb-bc18-33a1c196d6dc', 'Selecting and Manipulating Data Structures', NULL, 13)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('0e822c33-dcf5-5511-bead-68e5a7baf73c', (SELECT id FROM target_syllabus), '8c1b9b89-0b69-5617-b663-7d6ab194bdee', 'Evaluating Algorithm Efficiency', NULL, 14)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('3067f4de-46d5-544d-b79d-db28e2915ab7', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58', 'Exploring Internet Technologies', NULL, 15)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('65b30987-963e-57cf-b00d-b124cd51439e', (SELECT id FROM target_syllabus), '13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1', 'Designing simple Web Pages', NULL, 16)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();

-- Objectives are rebuilt wholesale rather than matched: they are the
-- Ministry's text and carry nothing of the teacher's.
DELETE FROM objectives WHERE lesson_id IN (SELECT id FROM new_lesson_ids);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9115c6be-7307-5ae8-bb57-70f887a5db0a', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '67897cf8-6c51-5cb6-9ce6-973672612017',
  1, 1, 'Introduction to artificial intelligence – Part 1',
  1, 1, 1,
  true, false, false,
  'content', 1
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9115c6be-7307-5ae8-bb57-70f887a5db0a', 'objective', 'Define AI and explain its history and evolution.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9115c6be-7307-5ae8-bb57-70f887a5db0a', 'objective', 'Identify and describe the main types of AI.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9115c6be-7307-5ae8-bb57-70f887a5db0a', 'objective', 'Explain common applications of AI.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '61146a58-d677-522c-8873-7b878ffeaab6', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '67897cf8-6c51-5cb6-9ce6-973672612017',
  2, 2, 'Introduction to artificial intelligence – Part 2',
  1, 1, 1,
  true, false, false,
  'content', 2
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61146a58-d677-522c-8873-7b878ffeaab6', 'objective', 'Explain ethical issues associated with AI.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61146a58-d677-522c-8873-7b878ffeaab6', 'objective', 'Examine the potential risks and benefits of AI.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61146a58-d677-522c-8873-7b878ffeaab6', 'objective', 'Discuss principles for the responsible use of AI.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8ed7d902-6993-50b6-8157-1f11dd6cb579', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '67897cf8-6c51-5cb6-9ce6-973672612017',
  3, 3, 'AI techniques and Machine Learning',
  1, 1, 1,
  true, false, false,
  'content', 3
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8ed7d902-6993-50b6-8157-1f11dd6cb579', 'objective', 'Describe common AI techniques and their applications.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8ed7d902-6993-50b6-8157-1f11dd6cb579', 'objective', 'Explain the characteristics of intelligent systems.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8ed7d902-6993-50b6-8157-1f11dd6cb579', 'objective', 'Compare AI techniques and intelligent systems based on their applications.', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8ed7d902-6993-50b6-8157-1f11dd6cb579', 'objective', 'Define Machine Learning.', 'remember', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8ed7d902-6993-50b6-8157-1f11dd6cb579', 'objective', 'Explain the basic principles of Machine Learning.', 'understand', 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8ed7d902-6993-50b6-8157-1f11dd6cb579', 'objective', 'Distinguish between supervised, unsupervised and reinforcement learning.', 'understand', 6);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '985c46cc-4f2c-5705-b769-08171c24dbbf', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '67897cf8-6c51-5cb6-9ce6-973672612017',
  4, 4, 'Developing AI Systems and the importance of data in AI systems – Part 1',
  1, 1, 1,
  true, false, false,
  'content', 4
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('985c46cc-4f2c-5705-b769-08171c24dbbf', 'objective', 'Explain the stages involved in developing an AI system.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('985c46cc-4f2c-5705-b769-08171c24dbbf', 'objective', 'Identify programming languages and tools used in AI development.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('985c46cc-4f2c-5705-b769-08171c24dbbf', 'objective', 'Explain why Python is widely used in AI development.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7625c809-f41e-510d-81f6-6183a3e3cb12', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '67897cf8-6c51-5cb6-9ce6-973672612017',
  5, 5, 'Developing AI Systems and the importance of data in AI systems – Part 2',
  1, 2, 2,
  true, false, false,
  'content', 5
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7625c809-f41e-510d-81f6-6183a3e3cb12', 'objective', 'Distinguish between primary and secondary data.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7625c809-f41e-510d-81f6-6183a3e3cb12', 'objective', 'Classify different types of data including quantitative, qualitative, structured and unstructured data.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7625c809-f41e-510d-81f6-6183a3e3cb12', 'objective', 'Relate the quality and type of training data to the performance and reliability of an AI system.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bcae5d1a-9ede-5a12-b382-b625071e3209', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '67897cf8-6c51-5cb6-9ce6-973672612017',
  6, 6, 'Data collection and Data analysis',
  1, 2, 2,
  true, false, false,
  'content', 6
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bcae5d1a-9ede-5a12-b382-b625071e3209', 'objective', 'Use questionnaires, interviews and observation collection methods Collect data using digital forms and online surveys.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bcae5d1a-9ede-5a12-b382-b625071e3209', 'objective', 'Describe data analysis.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bcae5d1a-9ede-5a12-b382-b625071e3209', 'objective', 'List examples of tools that can be used for data analysis (machine learning, spreadsheets, DBMS…...).', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bcae5d1a-9ede-5a12-b382-b625071e3209', 'objective', 'Explain the objectives of data analysis (organise, calculate, transform, interpret…..).', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e984a016-b1ad-51de-9f83-ace6ca2d53aa', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '67897cf8-6c51-5cb6-9ce6-973672612017',
  7, 7, 'Integration Activity',
  1, 2, 2,
  true, false, false,
  'integration_activity', 7
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9ee8d33e-eaed-5ba6-96e8-4da26fc8bd99', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  'd3a6e2df-1218-5dbd-8c29-0c911edf86f4',
  8, 8, 'Components of a computer and basic operations. – Part 1',
  1, 2, 2,
  true, false, false,
  'content', 8
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9ee8d33e-eaed-5ba6-96e8-4da26fc8bd99', 'objective', 'Describe types of computers.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9ee8d33e-eaed-5ba6-96e8-4da26fc8bd99', 'objective', 'Describe how the computer systems function.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9ee8d33e-eaed-5ba6-96e8-4da26fc8bd99', 'objective', 'Identify input and output devices.', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9ee8d33e-eaed-5ba6-96e8-4da26fc8bd99', 'objective', 'Connect correctly input, processing and output devices.', NULL, 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9ee8d33e-eaed-5ba6-96e8-4da26fc8bd99', 'objective', 'Power a computer using soft and warm booting.', NULL, 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fe85e845-552e-5bb0-9274-4e413c5ff5c3', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  'd3a6e2df-1218-5dbd-8c29-0c911edf86f4',
  9, 9, 'Components of a computer and basic operations. – Part 2',
  1, 3, 3,
  true, false, false,
  'content', 9
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fe85e845-552e-5bb0-9274-4e413c5ff5c3', 'objective', 'Transfer data/information to/from peripheral devices.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fe85e845-552e-5bb0-9274-4e413c5ff5c3', 'objective', 'Enter information into a computer system.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fe85e845-552e-5bb0-9274-4e413c5ff5c3', 'objective', 'Print a document.', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fe85e845-552e-5bb0-9274-4e413c5ff5c3', 'objective', 'Identify the hardware resources commonly required to run AI- enabled applications and explain their roles.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3fee5bfa-8870-50fc-8082-54be26f25db1', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  'd3a6e2df-1218-5dbd-8c29-0c911edf86f4',
  10, 10, 'Integration Activity',
  1, 3, 3,
  true, false, false,
  'integration_activity', 10
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a8c2122b-0530-5f40-958d-542e1ba642e0', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  'b51971a2-0820-541d-bb43-88d4733ce352',
  11, 11, 'Communication and collaboration tools',
  1, 3, 3,
  true, false, false,
  'content', 11
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a8c2122b-0530-5f40-958d-542e1ba642e0', 'objective', 'Describe communication and collaboration tools.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a8c2122b-0530-5f40-958d-542e1ba642e0', 'objective', 'Select a suitable communication and collaboration tool for a given situation.', 'evaluate', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a8c2122b-0530-5f40-958d-542e1ba642e0', 'objective', 'Set up a learning environment using communication and collaboration tools.', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a8c2122b-0530-5f40-958d-542e1ba642e0', 'objective', 'Share information/data over a network.', NULL, 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a8c2122b-0530-5f40-958d-542e1ba642e0', 'objective', 'Participate in learning using communication and collaboration tools.', NULL, 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a8c2122b-0530-5f40-958d-542e1ba642e0', 'objective', 'Communicate, collaborate and share resources using social media.', NULL, 6);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a667bd47-3f2f-546f-8b73-f8043c31ffb7', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  'b51971a2-0820-541d-bb43-88d4733ce352',
  12, 12, 'Digital systems: manual, automated, processing, simulation and modelling – Part 1',
  1, 3, 3,
  true, false, false,
  'content', 12
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a667bd47-3f2f-546f-8b73-f8043c31ffb7', 'objective', 'Describe manual and automated systems.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a667bd47-3f2f-546f-8b73-f8043c31ffb7', 'objective', 'Compare manual and automated systems.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a667bd47-3f2f-546f-8b73-f8043c31ffb7', 'objective', 'Describe monitoring and control systems.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a667bd47-3f2f-546f-8b73-f8043c31ffb7', 'objective', 'Describe batch and online processing systems.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9326f60e-ea6e-529d-9654-846753bf9b38', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  'b51971a2-0820-541d-bb43-88d4733ce352',
  13, 13, 'Digital systems: manual, automated, processing, simulation and modelling – Part 2',
  1, 4, 4,
  true, false, false,
  'content', 13
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9326f60e-ea6e-529d-9654-846753bf9b38', 'objective', 'Describe simulations and modelling systems.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9326f60e-ea6e-529d-9654-846753bf9b38', 'objective', 'Outline the advantages and disadvantages of manual and automated systems.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9326f60e-ea6e-529d-9654-846753bf9b38', 'objective', 'Explain how automated systems can use AI techniques to monitor conditions, make predictions and support decisions.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '04d44b96-ae03-5afb-9a5b-314df7d054dc', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  'b51971a2-0820-541d-bb43-88d4733ce352',
  14, 14, 'Integration Activity',
  1, 4, 4,
  true, false, false,
  'integration_activity', 14
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5543c929-2386-501b-813c-abd595db7619', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '789d1f8a-c91c-5a0b-aec0-035260118835',
  15, 15, 'Computer Applications and Productivity Tools',
  1, 4, 4,
  true, false, false,
  'content', 15
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5543c929-2386-501b-813c-abd595db7619', 'objective', 'Identify domains of use of general-purpose and other computing applications.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5543c929-2386-501b-813c-abd595db7619', 'objective', 'Exploit productivity tools such as word processors and desktop publishers.', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5543c929-2386-501b-813c-abd595db7619', 'objective', 'Determine the use of general-purpose applications in commerce, industry, science, education, arts and media.', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5543c929-2386-501b-813c-abd595db7619', 'objective', 'Accomplish tasks using productivity tools such as spreadsheets, word processors, databases and presentation software.', NULL, 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4747734a-dd19-572d-80b2-a2404c13fb87', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '789d1f8a-c91c-5a0b-aec0-035260118835',
  16, 16, 'Social and Economic Implications of Computers, Security of Computer Systems. – Part 1',
  1, 4, 4,
  true, false, false,
  'content', 16
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4747734a-dd19-572d-80b2-a2404c13fb87', 'objective', 'Identify social and economic effects of computerisation.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4747734a-dd19-572d-80b2-a2404c13fb87', 'objective', 'Explain how computing affects employment, products, services, and working environments.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4747734a-dd19-572d-80b2-a2404c13fb87', 'objective', 'Evaluate the advantages and disadvantages of computerisation to people, organisations, and society.', 'evaluate', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4747734a-dd19-572d-80b2-a2404c13fb87', 'objective', 'Explain the concepts of computer system security, reliability, and resilience.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '207c4f06-b6d7-5b5f-89cb-05facb331086', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '789d1f8a-c91c-5a0b-aec0-035260118835',
  17, 17, 'Social and Economic Implications of Computers, Security of Computer Systems. – Part 2',
  1, 5, 5,
  true, false, false,
  'content', 17
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('207c4f06-b6d7-5b5f-89cb-05facb331086', 'objective', 'Explain how confidentiality, integrity, privacy and availability contribute to computer system security.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('207c4f06-b6d7-5b5f-89cb-05facb331086', 'objective', 'Analyse the consequences of system failure, data loss, and security breaches.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('207c4f06-b6d7-5b5f-89cb-05facb331086', 'objective', 'Evaluate the social, economic, privacy and security implications of deploying AI-based systems.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ee6a0465-2251-5a4f-9788-23a9186d24ba', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '789d1f8a-c91c-5a0b-aec0-035260118835',
  18, 18, 'Computer Crimes, Professional Ethics and Conduct.',
  1, 5, 5,
  true, false, false,
  'content', 18
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ee6a0465-2251-5a4f-9788-23a9186d24ba', 'objective', 'Define computer crime and identify common types of computer crime.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ee6a0465-2251-5a4f-9788-23a9186d24ba', 'objective', 'Explain how selected computer crimes are committed and their effects.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ee6a0465-2251-5a4f-9788-23a9186d24ba', 'objective', 'Describe measures used to prevent and combat computer crime.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ee6a0465-2251-5a4f-9788-23a9186d24ba', 'objective', 'Identify professional, ethical, and moral responsibilities in the use of information systems.', 'analyse', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ee6a0465-2251-5a4f-9788-23a9186d24ba', 'objective', 'Explain ethical principles governing the use and management of computerised information.', 'understand', 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ee6a0465-2251-5a4f-9788-23a9186d24ba', 'objective', 'Apply professional codes of conduct to given computing situations.', 'apply', 6);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'eaddedcb-51e0-5b36-9d48-12d8898edd0b', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '789d1f8a-c91c-5a0b-aec0-035260118835',
  NULL, NULL, 'Evaluation',
  1, 5, 5,
  true, false, false,
  'evaluation', 19
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3fe3d8fc-cc55-5bb6-8416-91a72472a1f9', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '789d1f8a-c91c-5a0b-aec0-035260118835',
  NULL, NULL, 'Remediation',
  1, 5, 5,
  true, false, false,
  'remediation', 20
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ce9b3ae5-00aa-573a-b66f-96982543a5fd', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '789d1f8a-c91c-5a0b-aec0-035260118835',
  19, 19, 'Legislation and Global Communication, Responsible and Ethical Use of Computers – Part 1',
  1, 6, 6,
  true, false, false,
  'content', 21
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ce9b3ae5-00aa-573a-b66f-96982543a5fd', 'objective', 'Explain the purpose of laws relating to computer misuse, copyright, and data protection.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ce9b3ae5-00aa-573a-b66f-96982543a5fd', 'objective', 'Analyse the effects of global communication on citizenship and cultural issues.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ce9b3ae5-00aa-573a-b66f-96982543a5fd', 'objective', 'Evaluate the impact of the digital divide and promote responsible participation in the digital society.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b58e582f-8afb-544a-a373-6041c2d707ca', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '789d1f8a-c91c-5a0b-aec0-035260118835',
  20, 20, 'Legislation and Global Communication, Responsible and Ethical Use of Computers – Part 2',
  1, 6, 6,
  true, false, false,
  'content', 22
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b58e582f-8afb-544a-a373-6041c2d707ca', 'objective', 'Examine the effects of the use of computer material on health and the workplace.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b58e582f-8afb-544a-a373-6041c2d707ca', 'objective', 'Differentiate between legislation and ethical issues related to the use of computers.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b58e582f-8afb-544a-a373-6041c2d707ca', 'objective', 'Emulate professional, ethical and moral obligations of computing.', NULL, 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c57cdf32-08af-5d3a-b72b-e552583a90e7', (SELECT id FROM target_syllabus), 'ec8e9254-3973-5991-8a67-7b94dcbd8580',
  '789d1f8a-c91c-5a0b-aec0-035260118835',
  21, 21, 'Integration Activity',
  1, 6, 6,
  true, false, false,
  'integration_activity', 23
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3e85e795-430a-5980-8ab3-6bddeef7b8b9', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  22, 22, 'Computer Hardware Components and Embedded Systems – Part 1',
  1, 6, 6,
  true, false, false,
  'content', 24
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3e85e795-430a-5980-8ab3-6bddeef7b8b9', 'objective', 'Connect computer hardware components and outline the benefits and drawbacks of embedded systems.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3e85e795-430a-5980-8ab3-6bddeef7b8b9', 'objective', 'Describe principal operations of peripherals including laser/3D printers, microphones, speakers, magnetic disks, flash memory, optical drives, touch screens and virtual headsets.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e2abf33a-4ec0-5daf-8efb-09b470338f8e', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  23, 23, 'Computer Hardware Components and Embedded Systems – Part 2',
  1, 7, 7,
  true, false, false,
  'content', 25
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e2abf33a-4ec0-5daf-8efb-09b470338f8e', 'objective', 'Explain the roles of internal components including motherboard, power supply, video card and sound card, and relate hardware devices to applications and people.', 'understand', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b79b397c-15fc-542f-aa5c-e96c5a29f4c2', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  24, 24, 'Base Conversions',
  1, 7, 7,
  true, false, false,
  'content', 26
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b79b397c-15fc-542f-aa5c-e96c5a29f4c2', 'objective', 'Describe common number systems and their characteristics.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b79b397c-15fc-542f-aa5c-e96c5a29f4c2', 'objective', 'Explain the applications of number systems in computing.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b79b397c-15fc-542f-aa5c-e96c5a29f4c2', 'objective', 'Determine the positional value of digits in different number systems Convert numbers between binary and decimal. Convert numbers between binary, octal and hexadecimal. Convert numbers between decimal, octal and hexadecimal.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cc1b7351-3a4a-5854-ae41-ef21a5604e2b', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  25, 25, 'operations on Number Systems and Computer Data Units – Part 1',
  1, 7, 7,
  true, false, false,
  'content', 27
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cc1b7351-3a4a-5854-ae41-ef21a5604e2b', 'objective', 'Carry out arithmetic operations in bases 2, 8, 10 and 16.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cc1b7351-3a4a-5854-ae41-ef21a5604e2b', 'objective', 'Distinguish kibi/kilo, mebi/mega, gibi/giga and tebi/tera.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a285ccb4-a198-5360-b5d2-9b5a6df560b7', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  26, 26, 'operations on Number Systems and Computer Data Units – Part 2',
  1, 7, 7,
  true, false, false,
  'content', 28
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a285ccb4-a198-5360-b5d2-9b5a6df560b7', 'objective', 'Describe practical applications of BCD and hexadecimal.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a285ccb4-a198-5360-b5d2-9b5a6df560b7', 'objective', 'Explain how binary and hexadecimal representations support the storage and processing of data used by AI systems.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '807a552d-cecf-5b0a-8e77-4635db7d3e11', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  27, 27, 'Representation of signed integers',
  1, 8, 8,
  true, false, false,
  'content', 29
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('807a552d-cecf-5b0a-8e77-4635db7d3e11', 'objective', 'Describe methods used to represent signed integers, including sign magnitude, one’s complement, and two’s complement.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('807a552d-cecf-5b0a-8e77-4635db7d3e11', 'objective', 'Represent and interpret signed integers using different binary representation methods.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '05720d04-7e85-575f-a11c-033ef0f803ff', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  28, 28, 'Signed Integer Arithmetic',
  1, 8, 8,
  true, false, false,
  'content', 30
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('05720d04-7e85-575f-a11c-033ef0f803ff', 'objective', 'Perform addition and subtraction of signed integers using sign- magnitude, one’s complement, and two’s complement representations.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('05720d04-7e85-575f-a11c-033ef0f803ff', 'objective', 'Identify overflow and underflow conditions when performing signed integer arithmetic.', 'analyse', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd8e391d7-32e9-5558-a6e5-37c57dc09141', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  29, 29, 'Representation of characters, images and sound – Part 1',
  1, 8, 8,
  true, false, false,
  'content', 31
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d8e391d7-32e9-5558-a6e5-37c57dc09141', 'objective', 'Explain different character encoding schemes (ASCII, EBCDIC, Unicode).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d8e391d7-32e9-5558-a6e5-37c57dc09141', 'objective', 'Describe basic principles of digitizing images (pixels, resolution, colour depth).', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '615ff235-f2e7-5762-8e53-5d11b2bbbf77', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  30, 30, 'Representation of characters, images and sound – Part 2',
  1, 8, 8,
  true, false, false,
  'content', 32
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('615ff235-f2e7-5762-8e53-5d11b2bbbf77', 'objective', 'Describe basic principles of digitizing sound (sampling rate, bit depth).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('615ff235-f2e7-5762-8e53-5d11b2bbbf77', 'objective', 'Explain how character, image and sound data can be represented as digital inputs for AI applications.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '30f51d7e-2ebd-5f8e-b324-b7b951d30cbe', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '8f5e1f53-784e-58b2-a617-e833f4bc2580',
  31, 31, 'Integration Activity',
  1, 9, 9,
  true, false, false,
  'integration_activity', 33
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6f9ef15f-5452-57ce-a843-2b8078721923', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '996a93ea-5781-5d93-99bf-620aa42ad5d9',
  32, 32, 'Digital Logic and Logic Gates',
  1, 9, 9,
  true, false, false,
  'content', 34
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6f9ef15f-5452-57ce-a843-2b8078721923', 'objective', 'Explain the role of digital logic circuits in computer systems.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6f9ef15f-5452-57ce-a843-2b8078721923', 'objective', 'Describe the functions and symbols of basic, universal, and exclusive logic gates.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6f9ef15f-5452-57ce-a843-2b8078721923', 'objective', 'Construct truth tables for different logic gates.', 'create', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e520efaf-68b0-5264-9030-d3fb87a1da58', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '996a93ea-5781-5d93-99bf-620aa42ad5d9',
  33, 33, 'Logic Circuit Design 1 – Part 1',
  1, 9, 9,
  true, false, false,
  'content', 35
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e520efaf-68b0-5264-9030-d3fb87a1da58', 'objective', 'Define combinational logic circuit.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e520efaf-68b0-5264-9030-d3fb87a1da58', 'objective', 'Explain the relationship between logic gates, inputs, and outputs in digital circuits.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e520efaf-68b0-5264-9030-d3fb87a1da58', 'objective', 'Design simple combinational circuits using logic gates.', 'create', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a46ab2ef-a827-529c-ac2c-8cd3749ba175', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '996a93ea-5781-5d93-99bf-620aa42ad5d9',
  34, 34, 'Logic Circuit Design 1 – Part 2',
  1, 9, 9,
  true, false, false,
  'content', 36
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a46ab2ef-a827-529c-ac2c-8cd3749ba175', 'objective', 'Analyse digital circuits by deriving outputs and constructing truth tables.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a46ab2ef-a827-529c-ac2c-8cd3749ba175', 'objective', 'Explain how logic circuits provide the basic computational operations used by AI-enabled digital systems.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8828a246-9536-5330-b0b4-6b1e587735b4', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '996a93ea-5781-5d93-99bf-620aa42ad5d9',
  35, 35, 'Binary Arithmetic Circuits',
  1, 10, 10,
  true, false, false,
  'content', 37
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8828a246-9536-5330-b0b4-6b1e587735b4', 'objective', 'Explain the operation of half-adder and full-adder circuits.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8828a246-9536-5330-b0b4-6b1e587735b4', 'objective', 'Design and analyse binary addition circuits using logic gates.', 'create', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8828a246-9536-5330-b0b4-6b1e587735b4', 'objective', 'Explain the operation of half-subtractor and full-subtractor circuits.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7b4620f5-3a66-5fa0-bb5a-1dbd5db8e61e', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '996a93ea-5781-5d93-99bf-620aa42ad5d9',
  36, 36, 'Sequential Logic Circuits',
  1, 10, 10,
  true, false, false,
  'content', 38
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7b4620f5-3a66-5fa0-bb5a-1dbd5db8e61e', 'objective', 'Define sequential logic circuit.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7b4620f5-3a66-5fa0-bb5a-1dbd5db8e61e', 'objective', 'Explain the difference between combinational and sequential logic circuits.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7b4620f5-3a66-5fa0-bb5a-1dbd5db8e61e', 'objective', 'Describe the purpose and operation of flip-flops in digital systems.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7b4620f5-3a66-5fa0-bb5a-1dbd5db8e61e', 'objective', 'Derive truth tables and determine outputs of SR and JK flip- flops.', 'apply', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1dadee41-7239-5acb-b3d1-e6cf44c3d100', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '996a93ea-5781-5d93-99bf-620aa42ad5d9',
  37, 37, 'Practical Digital Logic and Sequential Circuits',
  1, 10, 10,
  true, false, false,
  'content', 39
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1dadee41-7239-5acb-b3d1-e6cf44c3d100', 'objective', 'Construct logic circuits/truth tables, implement universal NAND/NOR logic, design simple circuits such as traffic lights, deduce inputs/outputs and identify application areas.', 'create', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1dadee41-7239-5acb-b3d1-e6cf44c3d100', 'objective', 'Produce truth tables for half/full adders; describe SR and JK flip-flops and their role as storage elements; derive flip-flop truth tables.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1dadee41-7239-5acb-b3d1-e6cf44c3d100', 'objective', 'Perform Boolean algebra using De Morgan''s laws.', 'apply', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1dadee41-7239-5acb-b3d1-e6cf44c3d100', 'objective', 'Relate sequential logic and storage elements to the operation of hardware used in AI and intelligent systems.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a1ea451d-78ce-539c-915f-1919b1a557aa', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '996a93ea-5781-5d93-99bf-620aa42ad5d9',
  38, 38, 'Integration Activity',
  1, 10, 10,
  true, false, false,
  'integration_activity', 40
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e882ecfa-243c-5083-ba6c-67cbc353b2bd', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '996a93ea-5781-5d93-99bf-620aa42ad5d9',
  NULL, NULL, 'Evaluation',
  1, 11, 11,
  true, false, false,
  'evaluation', 41
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '03dfa9dc-6ce4-5aa9-91a2-503b5f0ab95d', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '996a93ea-5781-5d93-99bf-620aa42ad5d9',
  NULL, NULL, 'Remediation',
  1, 11, 11,
  true, false, false,
  'remediation', 42
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3819a812-8527-5762-9834-efa0a4cb1f5e', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'a3e39011-9cf8-57fe-9a8b-a09a1e3857c0',
  39, 39, 'Introduction to Computer Organisation and Architecture – Part 1',
  1, 11, 11,
  true, false, false,
  'content', 43
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3819a812-8527-5762-9834-efa0a4cb1f5e', 'objective', 'Define computer organisation and computer architecture.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3819a812-8527-5762-9834-efa0a4cb1f5e', 'objective', 'Differentiate between organisation and architecture.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3819a812-8527-5762-9834-efa0a4cb1f5e', 'objective', 'Identify major computer system components.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a9a21434-2460-5f7b-9ee0-ab65ccb40be3', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'a3e39011-9cf8-57fe-9a8b-a09a1e3857c0',
  40, 40, 'Introduction to Computer Organisation and Architecture – Part 2',
  1, 11, 11,
  true, false, false,
  'content', 44
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a9a21434-2460-5f7b-9ee0-ab65ccb40be3', 'objective', 'Explain the roles of the CPU, memory and I/O devices.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a9a21434-2460-5f7b-9ee0-ab65ccb40be3', 'objective', 'Explain the stored-program concept.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a9a21434-2460-5f7b-9ee0-ab65ccb40be3', 'objective', 'Describe and illustrate the organisation of Von Neumann and Harvard architectures.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '98ba3b8f-0888-5cd4-9741-bbe6e09aca9c', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'a3e39011-9cf8-57fe-9a8b-a09a1e3857c0',
  41, 41, 'Advanced Processor Architectures – Part 1',
  1, 12, 12,
  true, false, false,
  'content', 45
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('98ba3b8f-0888-5cd4-9741-bbe6e09aca9c', 'objective', 'Outline differences between RISC and CISC architectures and the importance/use of pipelining and registers in RISC.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('98ba3b8f-0888-5cd4-9741-bbe6e09aca9c', 'objective', 'Compare Von Neumann with Flynn(SISD, SIMD, MISD, MIMD), CRAY, Dataflow and Harvard architectures.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('98ba3b8f-0888-5cd4-9741-bbe6e09aca9c', 'objective', 'Analise parallel processing techniques used to improve computational performance.', NULL, 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c46d42f7-a716-5200-a69a-73792a8b463c', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'a3e39011-9cf8-57fe-9a8b-a09a1e3857c0',
  42, 42, 'Advanced Processor Architectures – Part 2',
  1, 12, 12,
  true, false, false,
  'content', 46
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c46d42f7-a716-5200-a69a-73792a8b463c', 'objective', 'Outline roles of virtual machines and explain their benefits and limitations.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c46d42f7-a716-5200-a69a-73792a8b463c', 'objective', 'Compare the advantages and limitations of Von Neumann and Harvard architectures.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c46d42f7-a716-5200-a69a-73792a8b463c', 'objective', 'Explain why parallel processing and specialized processor architectures are important for AI workloads.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '239fadf7-ce8d-5d31-b8a4-8b5b1d922b96', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'a3e39011-9cf8-57fe-9a8b-a09a1e3857c0',
  43, 43, 'System Communication and Timing',
  1, 12, 12,
  true, false, false,
  'content', 47
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('239fadf7-ce8d-5d31-b8a4-8b5b1d922b96', 'objective', 'Explain the purpose of system buses in a computer system.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('239fadf7-ce8d-5d31-b8a4-8b5b1d922b96', 'objective', 'Describe the functions of the data bus, address bus, and control bus.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('239fadf7-ce8d-5d31-b8a4-8b5b1d922b96', 'objective', 'Illustrate how system buses enable communication between the CPU, memory, and I/O devices.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('239fadf7-ce8d-5d31-b8a4-8b5b1d922b96', 'objective', 'Explain how data are transferred between computer-system components.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('239fadf7-ce8d-5d31-b8a4-8b5b1d922b96', 'objective', 'Explain roles of the system clock and Immediate Access Store (IAS).', 'understand', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9198e81d-10ad-5989-8268-cfba87aa8bb9', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'a3e39011-9cf8-57fe-9a8b-a09a1e3857c0',
  44, 44, 'The Processor, Its Components and the machine cycle',
  1, 12, 12,
  true, false, false,
  'content', 48
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9198e81d-10ad-5989-8268-cfba87aa8bb9', 'objective', 'Explain the functions of the major components of the processor, including the Control Unit, ALU, and registers.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9198e81d-10ad-5989-8268-cfba87aa8bb9', 'objective', 'Describe fetch, decode and execute stages.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9198e81d-10ad-5989-8268-cfba87aa8bb9', 'objective', 'Trace instruction execution.', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9198e81d-10ad-5989-8268-cfba87aa8bb9', 'objective', 'Identify registers used.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c12ff0fb-db4a-57ee-8112-a27a24c3999a', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'a3e39011-9cf8-57fe-9a8b-a09a1e3857c0',
  45, 45, 'Interrupts, Polling and Parallel Processing',
  2, 13, 13,
  true, false, false,
  'content', 49
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c12ff0fb-db4a-57ee-8112-a27a24c3999a', 'objective', 'Explain situations in which polling occurs and where interrupts occur; compare pipelining and parallel processing.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c12ff0fb-db4a-57ee-8112-a27a24c3999a', 'objective', 'Describe interrupt-detection strategy.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c12ff0fb-db4a-57ee-8112-a27a24c3999a', 'objective', 'Relate cycle efficiency to performance.', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c12ff0fb-db4a-57ee-8112-a27a24c3999a', 'objective', 'Explain how interrupts and parallel processing can improve the responsiveness and performance of AI-enabled systems.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '46470bdd-8972-5d99-a7ef-fdb523d7821b', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'a3e39011-9cf8-57fe-9a8b-a09a1e3857c0',
  46, 46, 'Assembly Instructions and Addressing Modes',
  2, 13, 13,
  true, false, false,
  'content', 50
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('46470bdd-8972-5d99-a7ef-fdb523d7821b', 'objective', 'Trace a simple assembly-language program and explain/manipulate instruction sets, including data movement, I/O, arithmetic, unconditional/conditional and compare instructions.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('46470bdd-8972-5d99-a7ef-fdb523d7821b', 'objective', 'Give examples of instruction formats; explain fixed- versus variable-length instructions; and distinguish immediate, direct, indirect, register, relative and indexed addressing modes.', 'remember', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f65a7de0-0f70-5caf-a71c-2992b7212029', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'a3e39011-9cf8-57fe-9a8b-a09a1e3857c0',
  47, 47, 'Integration Activity',
  2, 13, 13,
  true, false, false,
  'integration_activity', 51
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9d6e861e-3bd0-50a4-8516-7a3f8a38fe19', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'e94bfd7e-8fba-5697-a428-03a39c255a3b',
  48, 48, 'Primary Storage – Part 1',
  2, 13, 13,
  true, false, false,
  'content', 52
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d6e861e-3bd0-50a4-8516-7a3f8a38fe19', 'objective', 'Explain the concept of memory hierarchy.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d6e861e-3bd0-50a4-8516-7a3f8a38fe19', 'objective', 'Evaluate the relationship between speed, capacity, and cost in memory organisation.', 'evaluate', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d6e861e-3bd0-50a4-8516-7a3f8a38fe19', 'objective', 'Explain the functions and characteristics of primary memory (RAM, ROM, Cache).', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d6e861e-3bd0-50a4-8516-7a3f8a38fe19', 'objective', 'Differentiate between RAM and ROM types.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '59f3ddbc-ef7f-5e9c-8eda-349075257f33', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'e94bfd7e-8fba-5697-a428-03a39c255a3b',
  49, 49, 'Primary Storage – Part 2',
  2, 14, 14,
  true, false, false,
  'content', 53
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('59f3ddbc-ef7f-5e9c-8eda-349075257f33', 'objective', 'State applications of RAM, ROM and Cache.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('59f3ddbc-ef7f-5e9c-8eda-349075257f33', 'objective', 'Differentiate SRAM and DRAM.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('59f3ddbc-ef7f-5e9c-8eda-349075257f33', 'objective', 'Explain how memory capacity, speed and hierarchy affect the performance of AI applications and data processing.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '28beab4a-f6ee-521f-942a-780f6d31fa6b', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'e94bfd7e-8fba-5697-a428-03a39c255a3b',
  50, 50, 'Memory Addressing Concepts',
  2, 14, 14,
  true, false, false,
  'content', 54
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('28beab4a-f6ee-521f-942a-780f6d31fa6b', 'objective', 'Explain memory addressing concepts.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('28beab4a-f6ee-521f-942a-780f6d31fa6b', 'objective', 'Perform memory capacity calculations.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('28beab4a-f6ee-521f-942a-780f6d31fa6b', 'objective', 'Calculate the number of memory locations from address lines. Solve problems involving memory organisation.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0ba8d072-dbc4-5c3e-bdcb-21e3551b0ef6', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'e94bfd7e-8fba-5697-a428-03a39c255a3b',
  51, 51, 'Secondary Storage Technologies',
  2, 14, 14,
  true, false, false,
  'content', 55
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0ba8d072-dbc4-5c3e-bdcb-21e3551b0ef6', 'objective', 'Describe different secondary storage technologies (HDD, SSD, optical media).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0ba8d072-dbc4-5c3e-bdcb-21e3551b0ef6', 'objective', 'Classify storage devices based on their technologies.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0ba8d072-dbc4-5c3e-bdcb-21e3551b0ef6', 'objective', 'Analyse factors that influence the performance of storage devices.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2c04cd58-5b34-5882-b972-88ba038d39d7', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  'e94bfd7e-8fba-5697-a428-03a39c255a3b',
  52, 52, 'Integration Activity',
  2, 14, 14,
  true, false, false,
  'integration_activity', 56
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2c04cd58-5b34-5882-b972-88ba038d39d7', 'objective', 'Integrate the concepts and practical skills developed in the category to solve a contextual problem.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2c04cd58-5b34-5882-b972-88ba038d39d7', 'objective', 'Apply memory concepts to propose an appropriate storage arrangement for an AI application and justify the choice.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9426382c-bf32-502b-91da-c790298952fc', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '48d422f7-39e9-5592-9252-9c6ebb1c0e17',
  53, 53, 'Peripheral Devices and Interfaces',
  2, 15, 15,
  true, false, false,
  'content', 57
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9426382c-bf32-502b-91da-c790298952fc', 'objective', 'Analyse the characteristics used to evaluate the performance and suitability of peripheral devices.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9426382c-bf32-502b-91da-c790298952fc', 'objective', 'Explain how different interfaces and communication methods that enable peripherals to exchange data with a computer system.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ef23bde6-7d34-5910-97b0-d27761b41418', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '48d422f7-39e9-5592-9252-9c6ebb1c0e17',
  54, 54, 'The I/O Controller',
  2, 15, 15,
  true, false, false,
  'content', 58
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ef23bde6-7d34-5910-97b0-d27761b41418', 'objective', 'Explain the role of I/O controllers in managing communication between the processor and peripheral devices.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ef23bde6-7d34-5910-97b0-d27761b41418', 'objective', 'Describe polling and interrupt-driven processing as techniques for handling I/O operations.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'aefa03a1-0c01-5774-b5b0-4f7aafb422ef', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '48d422f7-39e9-5592-9252-9c6ebb1c0e17',
  55, 55, 'Integration Activity',
  2, 15, 15,
  true, false, false,
  'integration_activity', 59
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6335dd2f-6631-5bb2-afcc-1b245a660abf', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '48d422f7-39e9-5592-9252-9c6ebb1c0e17',
  NULL, NULL, 'Evaluation',
  2, 15, 15,
  true, false, false,
  'evaluation', 60
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f7631d3c-d7fd-569e-838f-21b55f87bb12', (SELECT id FROM target_syllabus), '6c24cf56-a7f0-57d9-978d-d969ac9f173f',
  '48d422f7-39e9-5592-9252-9c6ebb1c0e17',
  NULL, NULL, 'Remediation',
  2, 16, 16,
  true, false, false,
  'remediation', 61
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '60e8a468-52a5-5f5e-9302-36d97c193f6c', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  56, 56, 'Algorithm Design Approaches 1',
  2, 16, 16,
  true, false, false,
  'content', 62
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('60e8a468-52a5-5f5e-9302-36d97c193f6c', 'objective', 'Explain common algorithm design approaches/strategies (brute force, divide and conquer, stepwise refinement, greedy algorithm, ….).', 'understand', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '22cf42ff-1b50-507c-8294-d93e89125c65', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  57, 57, 'Algorithm Design Approaches 2',
  2, 16, 16,
  true, false, false,
  'content', 63
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('22cf42ff-1b50-507c-8294-d93e89125c65', 'objective', 'Differentiate between top-down and bottom-up design.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('22cf42ff-1b50-507c-8294-d93e89125c65', 'objective', 'Apply stepwise refinement to develop an algorithm.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '12b84d74-2f72-57dc-9377-6826bdde9c78', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  58, 58, 'Represenation of algorithms – Part 1',
  2, 16, 16,
  true, false, false,
  'content', 64
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('12b84d74-2f72-57dc-9377-6826bdde9c78', 'objective', 'Describe forms and characteristics of algorithms and write steps to solve a problem.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('12b84d74-2f72-57dc-9377-6826bdde9c78', 'objective', 'Distinguish good and poor algorithms with respect to stated characteristics.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('12b84d74-2f72-57dc-9377-6826bdde9c78', 'objective', 'Use control constructs to show how a problem can be solved and determine the appropriate course of action under prevailing conditions.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '09608fb5-e2a3-5991-b553-1084d05bd046', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  59, 59, 'Represenation of algorithms – Part 2',
  2, 17, 17,
  true, false, false,
  'content', 65
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('09608fb5-e2a3-5991-b553-1084d05bd046', 'objective', 'Interpret algorithms represented in various ways, convert an algorithm from one form to another and represent an algorithm in various ways.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('09608fb5-e2a3-5991-b553-1084d05bd046', 'objective', 'Use an algorithmic representation to describe a simple AI decision-making or classification process.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'caff8ba8-2b93-55ed-ba4d-f79d6f41c154', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  60, 60, 'Algorithm Design Strategies',
  2, 17, 17,
  true, false, false,
  'content', 66
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caff8ba8-2b93-55ed-ba4d-f79d6f41c154', 'objective', 'Identify the strategies used in existing algorithms.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caff8ba8-2b93-55ed-ba4d-f79d6f41c154', 'objective', 'Select an appropriate strategy for a given problem.', 'evaluate', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8daa8a29-8769-5aa0-8a10-789a41f41e96', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  61, 61, 'Sequence and Selection Structures 1',
  2, 17, 17,
  true, false, false,
  'content', 67
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8daa8a29-8769-5aa0-8a10-789a41f41e96', 'objective', 'Explain the concept and need for control structures.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8daa8a29-8769-5aa0-8a10-789a41f41e96', 'objective', 'Explain sequence and selection control structures.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8f187f7f-b05a-532b-8981-307aa482a047', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  62, 62, 'Sequence and Selection Structures 2',
  2, 17, 17,
  true, false, false,
  'content', 68
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8f187f7f-b05a-532b-8981-307aa482a047', 'objective', 'Define dry running and trace table.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8f187f7f-b05a-532b-8981-307aa482a047', 'objective', 'Design and trace algorithms using simple selection (decision- making) constructs.', 'create', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8f187f7f-b05a-532b-8981-307aa482a047', 'objective', 'Design and trace a simple decision algorithm that could be used as a rule-based component of an AI system.', 'create', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '768cf23d-6237-5250-ae83-745b5120d6f4', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  63, 63, 'Sequence and Selection Structures',
  2, 18, 18,
  true, false, false,
  'content', 69
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('768cf23d-6237-5250-ae83-745b5120d6f4', 'objective', 'Explain the need for multiple selection structures in algorithm design.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('768cf23d-6237-5250-ae83-745b5120d6f4', 'objective', 'Design algorithms using nested IF and CASE constructs.', 'create', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('768cf23d-6237-5250-ae83-745b5120d6f4', 'objective', 'Trace algorithms involving multiple decision paths.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b243423c-b2a8-5f0d-8224-f276e2cfe603', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  64, 64, 'Repetition Structures 1a',
  2, 18, 18,
  true, false, false,
  'content', 70
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b243423c-b2a8-5f0d-8224-f276e2cfe603', 'objective', 'Explain the concept, purpose, and types of repetition structures.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b243423c-b2a8-5f0d-8224-f276e2cfe603', 'objective', 'Define count controlled loop.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b243423c-b2a8-5f0d-8224-f276e2cfe603', 'objective', 'Explain the syntax, characteristics, and execution of the FOR loop.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b243423c-b2a8-5f0d-8224-f276e2cfe603', 'objective', 'Construct and trace algorithms using the FOR loop to solve simple computational problems.', 'create', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '67188d2a-1a9e-5d93-8eb8-1aa448e3f2ea', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  65, 65, 'Repetition Structures – Part 1',
  2, 18, 18,
  true, false, false,
  'content', 71
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67188d2a-1a9e-5d93-8eb8-1aa448e3f2ea', 'objective', 'Explain the concept and characteristics of condition-controlled loop.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67188d2a-1a9e-5d93-8eb8-1aa448e3f2ea', 'objective', 'Distinguish between post test and pre-test loop.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67188d2a-1a9e-5d93-8eb8-1aa448e3f2ea', 'objective', 'Describe the syntax and execution of the WHILE and REPEAT...UNTIL loops.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5655aa0a-0c2b-5f3a-8a7c-23e0de506ef1', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  'a995edf1-9b16-5d3d-8c97-f3f60cac931b',
  66, 66, 'Repetition Structures – Part 2',
  2, 18, 18,
  true, false, false,
  'content', 72
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5655aa0a-0c2b-5f3a-8a7c-23e0de506ef1', 'objective', 'Construct and trace simple algorithms using the WHILE and REPEAT...UNTIL loops.', 'create', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5655aa0a-0c2b-5f3a-8a7c-23e0de506ef1', 'objective', 'Develop a repetition-based algorithm for processing a dataset as a preliminary step in an AI application.', 'create', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cdd0c354-b808-56f5-bfe7-f4a73b16a1fb', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  '610b76e2-1750-522d-8908-be5e36ed9a86',
  67, 67, 'Subroutines',
  2, 19, 19,
  true, false, false,
  'content', 73
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cdd0c354-b808-56f5-bfe7-f4a73b16a1fb', 'objective', 'Explain the concept, purpose, and characteristics of subroutines in algorithm design.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cdd0c354-b808-56f5-bfe7-f4a73b16a1fb', 'objective', 'Differentiate between procedures and functions. Demonstrate how subroutines are called within algorithms.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ad8dcc41-a34c-5db0-a195-9c24b050417f', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  '610b76e2-1750-522d-8908-be5e36ed9a86',
  68, 68, 'Parameter Passing',
  2, 19, 19,
  true, false, false,
  'content', 74
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ad8dcc41-a34c-5db0-a195-9c24b050417f', 'objective', 'Explain the purpose of parameters in subroutines.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ad8dcc41-a34c-5db0-a195-9c24b050417f', 'objective', 'Differentiate between formal and actual parameters.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ad8dcc41-a34c-5db0-a195-9c24b050417f', 'objective', 'Explain different methods of passing parameters to subroutines, including pass-by-value and pass-by-reference.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e845a706-7a7c-585d-9e6a-3615f6201c8f', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  '610b76e2-1750-522d-8908-be5e36ed9a86',
  69, 69, 'Processing Subroutine Calls',
  2, 19, 19,
  true, false, false,
  'content', 75
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e845a706-7a7c-585d-9e6a-3615f6201c8f', 'objective', 'Explain how the processor executes subroutine calls during program execution.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e845a706-7a7c-585d-9e6a-3615f6201c8f', 'objective', 'Describe the role of the stack in storing return addresses and supporting subroutine execution.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e845a706-7a7c-585d-9e6a-3615f6201c8f', 'objective', 'Explain how subroutines can modularise data-processing tasks within an AI-oriented program.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a0200b77-0fbf-5dff-9068-5bb7ccb1ab22', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  '610b76e2-1750-522d-8908-be5e36ed9a86',
  70, 70, 'Processing Subroutine Calls',
  2, 19, 19,
  true, false, false,
  'content', 76
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a0200b77-0fbf-5dff-9068-5bb7ccb1ab22', 'objective', 'Trace the sequence of operations involved in calling and returning from a subroutine.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a0200b77-0fbf-5dff-9068-5bb7ccb1ab22', 'objective', 'Explain the concept and characteristics of recursion.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9d7407c5-f01a-5ec3-a9a2-ffa864bf2800', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  '610b76e2-1750-522d-8908-be5e36ed9a86',
  71, 71, 'Recursion',
  2, 20, 20,
  true, false, false,
  'content', 77
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d7407c5-f01a-5ec3-a9a2-ffa864bf2800', 'objective', 'Define recursion.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d7407c5-f01a-5ec3-a9a2-ffa864bf2800', 'objective', 'Trace the execution of recursive algorithms.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9d7407c5-f01a-5ec3-a9a2-ffa864bf2800', 'objective', 'Develop simple recursive solutions to computational problems.', 'create', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '049b3fe7-4647-57ff-8524-d4c5278669b6', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  '610b76e2-1750-522d-8908-be5e36ed9a86',
  72, 72, 'Recursion Limitations and Complexity',
  2, 20, 20,
  true, false, false,
  'content', 78
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('049b3fe7-4647-57ff-8524-d4c5278669b6', 'objective', 'Explain how the operating system uses stacks during recursive function calls.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('049b3fe7-4647-57ff-8524-d4c5278669b6', 'objective', 'Differentiate between iteration and recursion Dry run recursive algorithms.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('049b3fe7-4647-57ff-8524-d4c5278669b6', 'objective', 'Assess limitations of recursion, including high runtime space use and difficulties with high values.', 'evaluate', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('049b3fe7-4647-57ff-8524-d4c5278669b6', 'objective', 'Compare iterative and recursive approaches for solving computational tasks that may occur in AI data processing.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9a4ecdbd-72d9-5734-9629-143f56cb1149', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  '610b76e2-1750-522d-8908-be5e36ed9a86',
  73, 73, 'Integration Activity',
  2, 20, 20,
  true, false, false,
  'integration_activity', 79
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '69066fcb-4fd1-50d9-b658-cc58e1411770', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  '610b76e2-1750-522d-8908-be5e36ed9a86',
  NULL, NULL, 'Evaluation',
  2, 20, 20,
  true, false, false,
  'evaluation', 80
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8b54699a-8f4a-53c1-9141-fd41a14a8c50', (SELECT id FROM target_syllabus), 'a9a841d7-8e5f-55be-afb4-e16839371658',
  '610b76e2-1750-522d-8908-be5e36ed9a86',
  NULL, NULL, 'Remediation',
  2, 21, 21,
  true, false, false,
  'remediation', 81
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e9c81c84-2318-5118-8673-9e1bb5e6abb5', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  74, 74, 'Programming Language Basics',
  2, 21, 21,
  true, false, false,
  'content', 82
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e9c81c84-2318-5118-8673-9e1bb5e6abb5', 'objective', 'Explain the role of programming languages (PLs) in software development.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e9c81c84-2318-5118-8673-9e1bb5e6abb5', 'objective', 'Categorise PLs into low-level and high-level languages.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e9c81c84-2318-5118-8673-9e1bb5e6abb5', 'objective', 'Compare the characteristics, advantages, and limitations of low-level and high-level PLs.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7dff9fa1-26a5-5660-a1f0-ab2887ec8ebc', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  75, 75, 'programming paradigms 1',
  2, 21, 21,
  true, false, false,
  'content', 83
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7dff9fa1-26a5-5660-a1f0-ab2887ec8ebc', 'objective', 'Define programming paradigm.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7dff9fa1-26a5-5660-a1f0-ab2887ec8ebc', 'objective', 'Describe imperative(procedural, OOP) and declarative (Logic, functional, SQL) programming paradigms.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7dff9fa1-26a5-5660-a1f0-ab2887ec8ebc', 'objective', 'Differentiate the imperative and declarative programming paradigms using suitable examples.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7dff9fa1-26a5-5660-a1f0-ab2887ec8ebc', 'objective', 'Justify the use of imperative and declarative programming for different software development tasks.', 'evaluate', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7dff9fa1-26a5-5660-a1f0-ab2887ec8ebc', 'objective', 'Compare imperative and declarative programming approaches used in the development of AI and data-driven applications.', 'analyse', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '00a94e82-40e8-5fff-b093-20201ba53689', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  76, 76, 'programming paradigms 2',
  2, 21, 21,
  true, false, false,
  'content', 84
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('00a94e82-40e8-5fff-b093-20201ba53689', 'objective', 'Explain the core concepts of object-oriented programming (OOP): class, object, attributes, and methods, using suitable examples.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('00a94e82-40e8-5fff-b093-20201ba53689', 'objective', 'Describe, with suitable examples, the key characteristics of OOP: encapsulation, abstraction, inheritance (single, multiple, and multi-level), polymorphism, coupling, and cohesion.', NULL, 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '925324fb-7a31-558d-ac45-4d20f4158def', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  77, 77, 'Language Translators',
  2, 22, 22,
  true, false, false,
  'content', 85
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('925324fb-7a31-558d-ac45-4d20f4158def', 'objective', 'Explain the purpose of language translators.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('925324fb-7a31-558d-ac45-4d20f4158def', 'objective', 'Describe and distinguish the functions of an assembler, compiler, and interpreter.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('925324fb-7a31-558d-ac45-4d20f4158def', 'objective', 'Explain the main stages involved in program translation and compilation.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '003b4f86-375f-59aa-a255-63a896d80bce', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  78, 78, 'Program Errors and Debugging',
  2, 22, 22,
  true, false, false,
  'content', 86
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('003b4f86-375f-59aa-a255-63a896d80bce', 'objective', 'Explain the terms syntax, semantics, syntax error, semantic error, and runtime error, using suitable examples.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('003b4f86-375f-59aa-a255-63a896d80bce', 'objective', 'Describe the purpose and use of common debugging concepts and tools, including debuggers, breakpoints, watchpoints, and step execution.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('003b4f86-375f-59aa-a255-63a896d80bce', 'objective', 'Use debugging tools to identify and correct errors in a program that processes data for an AI application.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd14b75ed-8b82-5546-8991-32a47d744ffd', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  79, 79, 'Integration Activity',
  2, 22, 22,
  true, false, false,
  'integration_activity', 87
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8dfa9561-e7c4-5b33-875a-21c3ceb586af', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  80, 80, 'Introduction to C & Python Programming 1',
  2, 22, 22,
  true, false, false,
  'content', 88
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8dfa9561-e7c4-5b33-875a-21c3ceb586af', 'objective', 'Describe the features and applications of C & Python.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8dfa9561-e7c4-5b33-875a-21c3ceb586af', 'objective', 'Explain the basic syntax and structure of C & Python programs.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ca1f187f-3aca-5b19-bc6e-8efa12e6a002', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  81, 81, 'Introduction to C & Python Programming 2',
  2, 23, 23,
  true, false, false,
  'content', 89
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ca1f187f-3aca-5b19-bc6e-8efa12e6a002', 'objective', 'Write simple C & Python programs using print statement Declare and use variables in C & Python.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ca1f187f-3aca-5b19-bc6e-8efa12e6a002', 'objective', 'Write a simple program that prepares or formats input data for use in an AI application.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e5c57c82-04d1-5237-9efc-2142bfab1b4d', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  82, 82, 'Introduction to C & Python Programming 3',
  2, 23, 23,
  true, false, false,
  'content', 90
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e5c57c82-04d1-5237-9efc-2142bfab1b4d', 'objective', 'Identify and use C & Python data types (integer, float, string, Boolean).', 'analyse', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2712ab9b-a561-5345-9b35-8c85f6019228', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  83, 83, 'Python/C Operators and Expressions 1',
  2, 23, 23,
  true, false, false,
  'content', 91
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2712ab9b-a561-5345-9b35-8c85f6019228', 'objective', 'Identify common C & Python operators.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2712ab9b-a561-5345-9b35-8c85f6019228', 'objective', 'Explain how C & Python expressions are evaluated.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2712ab9b-a561-5345-9b35-8c85f6019228', 'objective', 'Construct C & Python expressions to solve simple problems.', 'create', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e9d5e6bf-693a-54b4-9859-00290809fe7d', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  84, 84, 'Python/C Operators and Expressions 2',
  2, 23, 23,
  true, false, false,
  'content', 92
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e9d5e6bf-693a-54b4-9859-00290809fe7d', 'objective', 'Use input() in Python or scanf() in C to accept user input Combine input and output statements in simple programs.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e9d5e6bf-693a-54b4-9859-00290809fe7d', 'objective', 'Use program input and output to collect, validate and display data that could be used by an AI system.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9e0e4e93-a931-5b54-a981-798cd0cd4623', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  85, 85, 'Python/C Selection Structures 1',
  2, 24, 24,
  true, false, false,
  'content', 93
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9e0e4e93-a931-5b54-a981-798cd0cd4623', 'objective', 'Explain the use of selection structures in C & Python.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9e0e4e93-a931-5b54-a981-798cd0cd4623', 'objective', 'Construct C & Python programs using simple and multiple selection.', 'create', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd5a3471d-52b7-5f8e-a7c2-ea1f664ff944', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  86, 86, 'Python /C Selection Structures 2',
  2, 24, 24,
  true, false, false,
  'content', 94
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d5a3471d-52b7-5f8e-a7c2-ea1f664ff944', 'objective', 'Apply selection structures to solve computational problems C & Python.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '44901413-51bc-5593-a323-dc2e7911c8bb', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  87, 87, 'Python/C Iterative Structures',
  2, 24, 24,
  true, false, false,
  'content', 95
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('44901413-51bc-5593-a323-dc2e7911c8bb', 'objective', 'Explain the use of iteration structures in C & Python.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('44901413-51bc-5593-a323-dc2e7911c8bb', 'objective', 'Construct C & Python programs using for and while loops.', 'create', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('44901413-51bc-5593-a323-dc2e7911c8bb', 'objective', 'Apply iteration structures to solve computational problems.', 'apply', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('44901413-51bc-5593-a323-dc2e7911c8bb', 'objective', 'Apply iteration structures to process a dataset or repeated computations used in a simple AI-related task.', 'apply', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'adc1b386-0328-5d5e-973c-868738a02152', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  88, 88, 'Writing and Debugging C programs',
  2, 24, 24,
  true, false, false,
  'content', 96
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('adc1b386-0328-5d5e-973c-868738a02152', 'objective', 'Apply algorithmic design C coding to solve a simple problem Debug simple syntax and logic errors in C programs.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9ecb4c0b-2293-54c9-a390-a0adbe83e4d0', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  89, 89, 'Writing and Debugging Python programs',
  3, 25, 25,
  true, false, false,
  'content', 97
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9ecb4c0b-2293-54c9-a390-a0adbe83e4d0', 'objective', 'Apply algorithmic design Python coding to solve a simple problem Debug simple syntax and logic errors in Python programs.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '67d2ce0d-6538-5c7f-8836-b2f60490942c', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  90, 90, 'Python Program Development and Debugging Project – Part 1',
  3, 25, 25,
  true, false, false,
  'content', 98
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67d2ce0d-6538-5c7f-8836-b2f60490942c', 'objective', 'Apply algorithmic design to develop a complete Python solution to a contextual problem.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('67d2ce0d-6538-5c7f-8836-b2f60490942c', 'objective', 'Test and debug the program using systematic techniques.', 'analyse', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '704a46dc-691b-5a67-b164-442b574d4d9f', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  91, 91, 'Python Program Development and Debugging Project – Part 2',
  3, 25, 25,
  true, false, false,
  'content', 99
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('704a46dc-691b-5a67-b164-442b574d4d9f', 'objective', 'Present and explain the final solution.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('704a46dc-691b-5a67-b164-442b574d4d9f', 'objective', 'Develop, test and explain a Python solution for a contextual problem involving data or a simple AI-related feature.', NULL, 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '250c748f-cc29-5bb4-8879-18414fe11f58', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  92, 92, 'Integration Activity',
  3, 25, 25,
  true, false, false,
  'integration_activity', 100
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7e3631d4-a4dc-5ef0-b561-1d562929ed73', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  NULL, NULL, 'Evaluation',
  3, 26, 26,
  true, false, false,
  'evaluation', 101
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0ff0c895-8c71-5250-bcb7-567e57c17271', (SELECT id FROM target_syllabus), '7d53b1c7-3890-5d06-b8d5-e753f6517d50',
  'cc23c721-9b82-5481-9007-0af1f8382e35',
  NULL, NULL, 'Remediation',
  3, 26, 26,
  true, false, false,
  'remediation', 102
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1beec596-3d78-522a-9ffd-0ad20ebd7879', (SELECT id FROM target_syllabus), '40f4d578-4799-5dbb-bc18-33a1c196d6dc',
  '840517c7-e44c-50e0-bb23-9226c9528f46',
  93, 93, 'Primitive Data Types',
  3, 26, 26,
  true, false, false,
  'content', 103
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1beec596-3d78-522a-9ffd-0ad20ebd7879', 'objective', 'Explain the concept and characteristics of primitive data types used in programming.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1beec596-3d78-522a-9ffd-0ad20ebd7879', 'objective', 'Describe common primitive data types and their applications.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1beec596-3d78-522a-9ffd-0ad20ebd7879', 'objective', 'Explain the need for data structures in organising and managing collections of data.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '591cdce2-8c2a-5c66-bee0-5c8863c361d5', (SELECT id FROM target_syllabus), '40f4d578-4799-5dbb-bc18-33a1c196d6dc',
  '840517c7-e44c-50e0-bb23-9226c9528f46',
  94, 94, 'Arrays',
  3, 26, 26,
  true, false, false,
  'content', 104
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('591cdce2-8c2a-5c66-bee0-5c8863c361d5', 'objective', 'Explain the structure and characteristics of arrays.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('591cdce2-8c2a-5c66-bee0-5c8863c361d5', 'objective', 'Distinguish between 1D and 2D arrays.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('591cdce2-8c2a-5c66-bee0-5c8863c361d5', 'objective', 'Represent and manipulate data using arrays.', 'apply', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('591cdce2-8c2a-5c66-bee0-5c8863c361d5', 'objective', 'Use arrays to organise and process a collection of data that could serve as input to an AI application.', 'apply', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1fa9d78d-fdff-5cfb-ad44-476f66781290', (SELECT id FROM target_syllabus), '40f4d578-4799-5dbb-bc18-33a1c196d6dc',
  '840517c7-e44c-50e0-bb23-9226c9528f46',
  95, 95, 'Records',
  3, 27, 27,
  true, false, false,
  'content', 105
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1fa9d78d-fdff-5cfb-ad44-476f66781290', 'objective', 'Explain the structure and characteristics of records.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1fa9d78d-fdff-5cfb-ad44-476f66781290', 'objective', 'Differentiate between arrays and 2D records based on their organisation and use.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1fa9d78d-fdff-5cfb-ad44-476f66781290', 'objective', 'Represent and manipulate data using records.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5d6939b4-0f3f-5d71-be49-1090fda1e5c7', (SELECT id FROM target_syllabus), '40f4d578-4799-5dbb-bc18-33a1c196d6dc',
  '840517c7-e44c-50e0-bb23-9226c9528f46',
  96, 96, 'Data Types, Memory Allocation and Data Structures',
  3, 27, 27,
  true, false, false,
  'content', 106
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5d6939b4-0f3f-5d71-be49-1090fda1e5c7', 'objective', 'Associate a data type with the amount of memory allocated to an identifier having that data type.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5d6939b4-0f3f-5d71-be49-1090fda1e5c7', 'objective', 'Calculate the memory allocated to each simple data type.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5d6939b4-0f3f-5d71-be49-1090fda1e5c7', 'objective', 'Represent a range of data of the same type as an array; declare string data as an array of characters; represent heterogeneous data as a record; and declare a list (enumeration).', 'apply', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5d6939b4-0f3f-5d71-be49-1090fda1e5c7', 'objective', 'Compare pointer-driven data structures with fixed data structures such as arrays.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c49b9267-ab1c-5808-9ba8-3a4e0c217575', (SELECT id FROM target_syllabus), '40f4d578-4799-5dbb-bc18-33a1c196d6dc',
  '840517c7-e44c-50e0-bb23-9226c9528f46',
  97, 97, 'Linked lists',
  3, 27, 27,
  true, false, false,
  'content', 107
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c49b9267-ab1c-5808-9ba8-3a4e0c217575', 'objective', 'Explain the structure and characteristics of linked lists.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c49b9267-ab1c-5808-9ba8-3a4e0c217575', 'objective', 'Represent and manipulate data using linked lists in programming problems.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c49b9267-ab1c-5808-9ba8-3a4e0c217575', 'objective', 'Explain how linked lists can support dynamic data management in applications that process AI-related datasets.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c072fbef-fa60-57c0-9b9f-6064143a642a', (SELECT id FROM target_syllabus), '40f4d578-4799-5dbb-bc18-33a1c196d6dc',
  '840517c7-e44c-50e0-bb23-9226c9528f46',
  98, 98, 'Hash Tables',
  3, 27, 27,
  true, false, false,
  'content', 108
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c072fbef-fa60-57c0-9b9f-6064143a642a', 'objective', 'Explain the structure and characteristics of hash tables.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c072fbef-fa60-57c0-9b9f-6064143a642a', 'objective', 'Represent and manipulate data using hash tables in programming problems.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c072fbef-fa60-57c0-9b9f-6064143a642a', 'objective', 'Explain linear probing and its importance when managing collision in hash tables.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c072fbef-fa60-57c0-9b9f-6064143a642a', 'objective', 'Explain how linked lists can be used to handle collisions in hash tables through separate chaining.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7a947061-ada4-5ae5-85b8-06d445f5ce1b', (SELECT id FROM target_syllabus), '40f4d578-4799-5dbb-bc18-33a1c196d6dc',
  '840517c7-e44c-50e0-bb23-9226c9528f46',
  99, 99, 'Using Repetition Structures to process arrays and lists',
  3, 28, 28,
  true, false, false,
  'content', 109
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7a947061-ada4-5ae5-85b8-06d445f5ce1b', 'objective', 'Develop algorithms using repetition structures to process arrays, validate input, generate tables, and print repetitive patterns.', 'create', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a89fa203-4bd8-5d68-9f31-46b5475d993d', (SELECT id FROM target_syllabus), '40f4d578-4799-5dbb-bc18-33a1c196d6dc',
  '840517c7-e44c-50e0-bb23-9226c9528f46',
  100, 100, 'Integration Activity',
  3, 28, 28,
  true, false, false,
  'integration_activity', 110
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a89fa203-4bd8-5d68-9f31-46b5475d993d', 'objective', 'Integrate the concepts and practical skills developed in the category to solve a contextual problem.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a89fa203-4bd8-5d68-9f31-46b5475d993d', 'objective', 'Integrate data-structure skills to design an efficient data- processing solution for a simple AI application.', NULL, 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '90814be2-9b3f-52df-8710-1d7d6a5bdbc6', (SELECT id FROM target_syllabus), '8c1b9b89-0b69-5617-b663-7d6ab194bdee',
  '0e822c33-dcf5-5511-bead-68e5a7baf73c',
  101, 101, 'Complexity of Algorithms',
  3, 28, 28,
  true, false, false,
  'content', 111
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90814be2-9b3f-52df-8710-1d7d6a5bdbc6', 'objective', 'Explain the concepts of time complexity and space complexity. Estimate the time and space requirements of simple algorithms by counting operations and memory usage.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90814be2-9b3f-52df-8710-1d7d6a5bdbc6', 'objective', 'Compare simple algorithms based on their estimated resource requirements.', 'analyse', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2ce257aa-a298-521d-b096-f706b8eb4240', (SELECT id FROM target_syllabus), '8c1b9b89-0b69-5617-b663-7d6ab194bdee',
  '0e822c33-dcf5-5511-bead-68e5a7baf73c',
  102, 102, 'Big-O Notation',
  3, 28, 28,
  true, false, false,
  'content', 112
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ce257aa-a298-521d-b096-f706b8eb4240', 'objective', 'Explain the purpose of Big-O notation in algorithm analysis.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ce257aa-a298-521d-b096-f706b8eb4240', 'objective', 'Express the time complexity.', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ce257aa-a298-521d-b096-f706b8eb4240', 'objective', 'of simple algorithms using Big- O notation.', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ce257aa-a298-521d-b096-f706b8eb4240', 'objective', 'Compare the time complexity of common searching and sorting algorithms.', 'analyse', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ce257aa-a298-521d-b096-f706b8eb4240', 'objective', 'Explain the concepts of P and NP complexity classes.', 'understand', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'caa83235-3f98-5817-b04b-e25623be7ba4', (SELECT id FROM target_syllabus), '8c1b9b89-0b69-5617-b663-7d6ab194bdee',
  '0e822c33-dcf5-5511-bead-68e5a7baf73c',
  103, 103, 'Computational problem types',
  3, 29, 29,
  true, false, false,
  'content', 113
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caa83235-3f98-5817-b04b-e25623be7ba4', 'objective', 'Distinguish between tractable and intractable problems using appropriate examples.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caa83235-3f98-5817-b04b-e25623be7ba4', 'objective', 'Differentiate between decidable and undecidable problems (Halting problem, Travelling Salesman problem).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caa83235-3f98-5817-b04b-e25623be7ba4', 'objective', 'Provide an informal definition of turing machine.', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caa83235-3f98-5817-b04b-e25623be7ba4', 'objective', 'Differetiate between computable and non computable functions using appropriate examples.', NULL, 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caa83235-3f98-5817-b04b-e25623be7ba4', 'objective', 'Explain how heuristics can be applied to obtain practical solutions to intractable problems.', 'understand', 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('caa83235-3f98-5817-b04b-e25623be7ba4', 'objective', 'Explain why some AI-related computational problems are computationally difficult and relate them to P and NP concepts.', 'understand', 6);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '57a6dbdd-a876-50d2-a2db-3f12ed97a063', (SELECT id FROM target_syllabus), '8c1b9b89-0b69-5617-b663-7d6ab194bdee',
  '0e822c33-dcf5-5511-bead-68e5a7baf73c',
  104, 104, 'Algorithm Complexity, Dry Runs and Optimisation',
  3, 29, 29,
  true, false, false,
  'content', 114
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('57a6dbdd-a876-50d2-a2db-3f12ed97a063', 'objective', 'Determine time and space complexity from the number of executions of key operations and perform dry runs.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('57a6dbdd-a876-50d2-a2db-3f12ed97a063', 'objective', 'Optimize an algorithm to improve efficiency and evaluate efficiency in terms of number of steps.', NULL, 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '097df07f-cb29-5e3f-a212-231faa6ee9d4', (SELECT id FROM target_syllabus), '8c1b9b89-0b69-5617-b663-7d6ab194bdee',
  '0e822c33-dcf5-5511-bead-68e5a7baf73c',
  105, 105, 'Integration Activity',
  3, 29, 29,
  true, false, false,
  'integration_activity', 115
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ebe5c5b7-b07c-5926-90b1-c36aa5a61421', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  106, 106, 'Introduction to Computer Networks 1',
  3, 29, 29,
  true, false, false,
  'content', 116
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ebe5c5b7-b07c-5926-90b1-c36aa5a61421', 'objective', 'Define Computer Network.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ebe5c5b7-b07c-5926-90b1-c36aa5a61421', 'objective', 'Identify and give the role of network devices.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ebe5c5b7-b07c-5926-90b1-c36aa5a61421', 'objective', 'Explore the main network types by geographic scope.', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ebe5c5b7-b07c-5926-90b1-c36aa5a61421', 'objective', 'Identify network components and explain how network connectivity enables AI services and cloud-based intelligent applications.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '53ae8e03-b31e-5ec6-a121-4c7171b0408c', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  107, 107, 'Introduction to Computer Networks 2',
  3, 30, 30,
  true, false, false,
  'content', 117
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53ae8e03-b31e-5ec6-a121-4c7171b0408c', 'objective', 'Distinguish between peer-to-peer and client-server network.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53ae8e03-b31e-5ec6-a121-4c7171b0408c', 'objective', 'Describe star, bus, ring and mesh topologies.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53ae8e03-b31e-5ec6-a121-4c7171b0408c', 'objective', 'Describe the different types of network cabling7media.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53ae8e03-b31e-5ec6-a121-4c7171b0408c', 'objective', 'Classify transmission media as guided or unguided.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b478c9bf-fc1c-560a-9007-78a07e90a098', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  108, 108, 'Introduction to Computer Networks 4',
  3, 30, 30,
  true, false, false,
  'content', 118
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b478c9bf-fc1c-560a-9007-78a07e90a098', 'objective', 'Compare common transmission media based on their characteristics.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b478c9bf-fc1c-560a-9007-78a07e90a098', 'objective', 'Select suitable transmission media for given applications.', 'evaluate', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c44bbe23-2cb6-57b3-a09a-d2e1a7a31b8a', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  109, 109, 'Network Connections, Architectures and Hardware',
  3, 30, 30,
  true, false, false,
  'content', 119
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c44bbe23-2cb6-57b3-a09a-d2e1a7a31b8a', 'objective', 'Describe types of network connections such as point-to-point and multipoint.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c44bbe23-2cb6-57b3-a09a-d2e1a7a31b8a', 'objective', 'Explain features of network operating systems, including multitasking and multi-user features.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c44bbe23-2cb6-57b3-a09a-d2e1a7a31b8a', 'objective', 'Outline network software.', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c44bbe23-2cb6-57b3-a09a-d2e1a7a31b8a', 'objective', 'Differentiate types of network architectures.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c44bbe23-2cb6-57b3-a09a-d2e1a7a31b8a', 'objective', 'Select and connect network hardware components such as cables, switches, routers and modems.', 'evaluate', 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c44bbe23-2cb6-57b3-a09a-d2e1a7a31b8a', 'objective', 'Compare transmission media using data rate, transmission distance and ease of installation.', 'analyse', 6);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c44bbe23-2cb6-57b3-a09a-d2e1a7a31b8a', 'objective', 'Explain how network architecture and hardware support the transmission of data to and from AI and cloud services.', 'understand', 7);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '63c4a9d5-730c-5914-aa8b-8457c41c476d', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  110, 110, 'The OSI model',
  3, 30, 30,
  true, false, false,
  'content', 120
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('63c4a9d5-730c-5914-aa8b-8457c41c476d', 'objective', 'Explain the purpose of communication protocols and standards.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('63c4a9d5-730c-5914-aa8b-8457c41c476d', 'objective', 'Describe the layers of the OSI reference model.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('63c4a9d5-730c-5914-aa8b-8457c41c476d', 'objective', 'Relate communication protocols to the layers of the OSI model.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '68a4d011-cd3d-5054-9555-2207d7576b94', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  111, 111, 'IP addressing',
  3, 31, 31,
  true, false, false,
  'content', 121
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('68a4d011-cd3d-5054-9555-2207d7576b94', 'objective', 'Explain the Structure of an IP address.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('68a4d011-cd3d-5054-9555-2207d7576b94', 'objective', 'Explain the different Classes of IP address.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('68a4d011-cd3d-5054-9555-2207d7576b94', 'objective', 'Describe the different types of IP address.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('68a4d011-cd3d-5054-9555-2207d7576b94', 'objective', 'Explain the notion of CIDR and subnetting.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4e02f301-d66b-5322-bcb1-d81de0f99cea', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  112, 112, 'Network Configuration and Troubleshooting',
  3, 31, 31,
  true, false, false,
  'content', 122
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4e02f301-d66b-5322-bcb1-d81de0f99cea', 'objective', 'Configure the operating system for networking.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4e02f301-d66b-5322-bcb1-d81de0f99cea', 'objective', 'Explain how mobile communication technology works.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4e02f301-d66b-5322-bcb1-d81de0f99cea', 'objective', 'Explain the difference between wired and wireless transmission.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4e02f301-d66b-5322-bcb1-d81de0f99cea', 'objective', 'Outline errors that may occur in a network.', 'remember', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4e02f301-d66b-5322-bcb1-d81de0f99cea', 'objective', 'Set up and troubleshoot a network.', NULL, 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4e02f301-d66b-5322-bcb1-d81de0f99cea', 'objective', 'Use network troubleshooting techniques to maintain reliable connectivity for an AI-enabled or cloud-based application.', 'apply', 6);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ae206363-3a34-5895-a1ad-a38373e2a25b', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  113, 113, 'Data Communication Modes and Transmission',
  3, 31, 31,
  true, false, false,
  'content', 123
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae206363-3a34-5895-a1ad-a38373e2a25b', 'objective', 'Identify the features of data-communication networks.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae206363-3a34-5895-a1ad-a38373e2a25b', 'objective', 'Describe simplex, half-duplex and duplex communication modes.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae206363-3a34-5895-a1ad-a38373e2a25b', 'objective', 'Differentiate parallel and serial digital-data transmission.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae206363-3a34-5895-a1ad-a38373e2a25b', 'objective', 'Explain synchronous and asynchronous transmission.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae206363-3a34-5895-a1ad-a38373e2a25b', 'objective', 'Explain the functions of multiplexers and demultiplexers.', 'understand', 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae206363-3a34-5895-a1ad-a38373e2a25b', 'objective', 'Differentiate baseband and broadband transmission.', 'understand', 6);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae206363-3a34-5895-a1ad-a38373e2a25b', 'objective', 'Explain the purpose of data transmission and determine differences between transmission modes.', 'understand', 7);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae206363-3a34-5895-a1ad-a38373e2a25b', 'objective', 'Compare serial and parallel transmission based on speed and number of bits transmitted at a time.', 'analyse', 8);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ae206363-3a34-5895-a1ad-a38373e2a25b', 'objective', 'Explain advantages and disadvantages of analogue and digital signal transmission.', 'understand', 9);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '78438dae-5537-500a-b976-2078012386ec', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  114, 114, 'Network and Data Security',
  3, 31, 31,
  true, false, false,
  'content', 124
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78438dae-5537-500a-b976-2078012386ec', 'objective', 'Explain data security and safety principles for protecting data/networks from malware and unauthorized access.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78438dae-5537-500a-b976-2078012386ec', 'objective', 'Use antivirus software to protect a computer/network from viruses, Trojan horses and worms.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78438dae-5537-500a-b976-2078012386ec', 'objective', 'Describe error-detecting codes such as parity bits, Hamming codes and cyclic redundancy checks/checksum.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78438dae-5537-500a-b976-2078012386ec', 'objective', 'Explain measures used to protect computers and networks from intruders and natural disasters, including passwords, firewalls, encryption and backup.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78438dae-5537-500a-b976-2078012386ec', 'objective', 'Scan a computer system using antivirus software.', NULL, 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78438dae-5537-500a-b976-2078012386ec', 'objective', 'Set up a firewall and web filtering using antivirus software.', NULL, 6);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('78438dae-5537-500a-b976-2078012386ec', 'objective', 'Save data on cloud-storage systems such as Google Drive.', NULL, 7);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bf5c211c-9384-5b86-b6c7-e987c83ba30b', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  115, 115, 'Network Standards, Protocols and Internet Development',
  3, 32, 32,
  true, false, false,
  'content', 125
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf5c211c-9384-5b86-b6c7-e987c83ba30b', 'objective', 'Describe different network standards and protocols.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf5c211c-9384-5b86-b6c7-e987c83ba30b', 'objective', 'Produce a report comparing the OSI and TCP reference models.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf5c211c-9384-5b86-b6c7-e987c83ba30b', 'objective', 'Discuss Internet protocols such as TCP, UDP, IP and FTP.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf5c211c-9384-5b86-b6c7-e987c83ba30b', 'objective', 'Describe the history of the Internet.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf5c211c-9384-5b86-b6c7-e987c83ba30b', 'objective', 'Explain intranet, extranet and Internet.', 'understand', 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf5c211c-9384-5b86-b6c7-e987c83ba30b', 'objective', 'Explain how Internet protocols support the exchange of data required by AI and cloud-based services.', 'understand', 6);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '19a3da30-4e50-5d8e-9bd1-38ec468bb096', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  116, 116, 'Internet Services and Safe Online Use',
  3, 32, 32,
  true, false, false,
  'content', 126
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('19a3da30-4e50-5d8e-9bd1-38ec468bb096', 'objective', 'Describe Internet services such as e-commerce, e-learning and e-banking.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('19a3da30-4e50-5d8e-9bd1-38ec468bb096', 'objective', 'Exchange information using email and use search engines.', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('19a3da30-4e50-5d8e-9bd1-38ec468bb096', 'objective', 'Do business online while observing safety and security risks.', NULL, 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('19a3da30-4e50-5d8e-9bd1-38ec468bb096', 'objective', 'Change privacy settings and ensure privacy online.', NULL, 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'dd9391c7-7358-5a7d-99cc-0f12f8b1258e', (SELECT id FROM target_syllabus), '6688cc90-efc9-5a5a-a9b0-5895e51d7e58',
  '3067f4de-46d5-544d-b79d-db28e2915ab7',
  117, 117, 'Integration Activity',
  3, 32, 32,
  true, false, false,
  'integration_activity', 127
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dd9391c7-7358-5a7d-99cc-0f12f8b1258e', 'objective', 'Integrate the concepts and practical skills developed in the category to solve a contextual problem.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('dd9391c7-7358-5a7d-99cc-0f12f8b1258e', 'objective', 'Evaluate the safe and responsible use of AI-enabled Internet services, including privacy, security and information reliability.', 'evaluate', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd79a8c3e-d228-554f-a4c3-5dc8cc0a88d5', (SELECT id FROM target_syllabus), '13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1',
  '65b30987-963e-57cf-b00d-b124cd51439e',
  118, 118, 'Introduction to Web technology, Internet Connectivity, Online Services and Information Literacy',
  3, 32, 32,
  true, false, false,
  'content', 128
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d79a8c3e-d228-554f-a4c3-5dc8cc0a88d5', 'objective', 'Describe common Internet services and their uses.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d79a8c3e-d228-554f-a4c3-5dc8cc0a88d5', 'objective', 'Explain the functions of web browsers, search engines, and email systems.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d79a8c3e-d228-554f-a4c3-5dc8cc0a88d5', 'objective', 'Explain the role of markup languages in web development.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d79a8c3e-d228-554f-a4c3-5dc8cc0a88d5', 'objective', 'Select suitable hardware/software for Internet connectivity and access websites using a browser.', 'evaluate', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d79a8c3e-d228-554f-a4c3-5dc8cc0a88d5', 'objective', 'Select an appropriate Internet service for a given context and manage browser bookmarks.', 'evaluate', 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d79a8c3e-d228-554f-a4c3-5dc8cc0a88d5', 'objective', 'Apply for a job or scholarship online.', 'apply', 6);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d79a8c3e-d228-554f-a4c3-5dc8cc0a88d5', 'objective', 'Assess online information for relevance, bias, validity, reliability and sufficiency.', 'evaluate', 7);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d79a8c3e-d228-554f-a4c3-5dc8cc0a88d5', 'objective', 'Download images, files, software and drivers from the Internet.', NULL, 8);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '312164ce-c7b3-5aca-b84d-7d791c05363d', (SELECT id FROM target_syllabus), '13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1',
  '65b30987-963e-57cf-b00d-b124cd51439e',
  119, 119, 'Introduction to HTML 1',
  3, 33, 33,
  true, false, false,
  'content', 129
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('312164ce-c7b3-5aca-b84d-7d791c05363d', 'objective', 'Introduce the structure of an HTML document.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('312164ce-c7b3-5aca-b84d-7d791c05363d', 'objective', 'Use basic HTML tags for text and headings.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('312164ce-c7b3-5aca-b84d-7d791c05363d', 'objective', 'Use HTML tags for lists, links, and images.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '62c64ce5-39ee-5154-bec8-11260f647a52', (SELECT id FROM target_syllabus), '13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1',
  '65b30987-963e-57cf-b00d-b124cd51439e',
  120, 120, 'Introduction to HTML 2',
  3, 33, 33,
  true, false, false,
  'content', 130
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62c64ce5-39ee-5154-bec8-11260f647a52', 'objective', 'Use HTML tags to create tables.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('62c64ce5-39ee-5154-bec8-11260f647a52', 'objective', 'Assess AI-generated or AI-assisted online information for relevance, bias, validity, reliability and sufficiency.', 'evaluate', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ede3e07f-494c-5cf9-941e-e37282b2a60f', (SELECT id FROM target_syllabus), '13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1',
  '65b30987-963e-57cf-b00d-b124cd51439e',
  121, 121, 'Introduction to CSS 1',
  3, 33, 33,
  true, false, false,
  'content', 131
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ede3e07f-494c-5cf9-941e-e37282b2a60f', 'objective', 'Introduce CSS and its role in styling.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ede3e07f-494c-5cf9-941e-e37282b2a60f', 'objective', 'Apply CSS to style text, colours, and layout. Combine HTML and CSS to build a structured webpage.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '63e740bb-bac2-55b7-ba6b-355b61760aa8', (SELECT id FROM target_syllabus), '13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1',
  '65b30987-963e-57cf-b00d-b124cd51439e',
  122, 122, 'Integration Activity',
  3, 33, 33,
  true, false, false,
  'integration_activity', 132
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd745cede-5f88-593d-bdd9-34c0866fe700', (SELECT id FROM target_syllabus), '13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1',
  '65b30987-963e-57cf-b00d-b124cd51439e',
  NULL, NULL, 'Evaluation',
  3, 34, 34,
  true, false, false,
  'evaluation', 133
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4ea264ec-7825-5ae4-8aff-2793db8c323c', (SELECT id FROM target_syllabus), '13f53c6b-5b76-5610-ac8c-c1dc1f5d7dd1',
  '65b30987-963e-57cf-b00d-b124cd51439e',
  NULL, NULL, 'Remediation',
  3, 34, 34,
  true, false, false,
  'remediation', 134
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '94a357cc-063f-5f71-9b4f-f28e76834be0', (SELECT id FROM target_syllabus), NULL,
  NULL,
  NULL, NULL, 'Revision',
  3, 34, 34,
  true, false, false,
  'revision', 135
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bf0355a2-c7a7-53ce-9aa0-897a952f6bf0', (SELECT id FROM target_syllabus), NULL,
  NULL,
  NULL, NULL, 'Revision',
  3, 35, 35,
  true, false, false,
  'revision', 136
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f2c7b618-ea72-5ca8-bc01-b1dcbaeb50d4', (SELECT id FROM target_syllabus), NULL,
  NULL,
  NULL, NULL, 'Revision',
  3, 36, 36,
  true, false, false,
  'revision', 137
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();

-- ------------------------------------------------------------------
-- 6. Carry the attachments across.
--
-- Matched on the lesson title, stripped of case and punctuation, and
-- ONLY where that title is unique on both sides. Twenty-three rows are
-- called "Integration activities"; there is no way to tell which old one
-- is which new one, so those keep their attachments on the archived row
-- rather than being guessed at.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS moved;
CREATE TEMP TABLE moved AS
WITH k AS (SELECT '[^a-zA-Z0-9]' AS strip),
old_u AS (
  SELECT id, key, status, content FROM (
    SELECT o.id, o.status, o.content,
           lower(regexp_replace(o.title, '[^a-zA-Z0-9]', '', 'g')) AS key,
           count(*) OVER (PARTITION BY lower(regexp_replace(o.title, '[^a-zA-Z0-9]', '', 'g'))) AS n
      FROM old_lessons o) t WHERE n = 1),
new_u AS (
  SELECT id, key FROM (
    SELECT n.id,
           lower(regexp_replace(n.title, '[^a-zA-Z0-9]', '', 'g')) AS key,
           count(*) OVER (PARTITION BY lower(regexp_replace(n.title, '[^a-zA-Z0-9]', '', 'g'))) AS c
      FROM lessons n WHERE n.syllabus_id = (SELECT id FROM target_syllabus) AND n.deleted_at IS NULL) t
  WHERE c = 1)
SELECT o.id AS old_id, n.id AS new_id, o.status AS old_status, o.content AS old_content
  FROM old_u o JOIN new_u n USING (key);

-- One old row maps to at most one new row and vice versa, so none of
-- these can collide with the composite keys on lesson_id.
UPDATE lesson_resources t SET lesson_id = m.new_id FROM moved m WHERE t.lesson_id = m.old_id;
UPDATE question_lessons t SET lesson_id = m.new_id FROM moved m WHERE t.lesson_id = m.old_id;
UPDATE lesson_mastery t SET lesson_id = m.new_id FROM moved m WHERE t.lesson_id = m.old_id;
UPDATE lesson_note_sections t SET lesson_id = m.new_id FROM moved m WHERE t.lesson_id = m.old_id;
UPDATE scheme_entries t SET lesson_id = m.new_id FROM moved m WHERE t.lesson_id = m.old_id;
UPDATE assessments t SET lesson_id = m.new_id FROM moved m WHERE t.lesson_id = m.old_id;
UPDATE attempts t SET lesson_id = m.new_id FROM moved m WHERE t.lesson_id = m.old_id;

-- A lesson that had notes written and published keeps them.
UPDATE lessons n SET status = 'published', content = m.old_content, updated_at = now()
  FROM moved m
 WHERE n.id = m.new_id AND m.old_status = 'published'
   AND coalesce(m.old_content, '') <> '' AND coalesce(n.content, '') = '';

UPDATE competencies c SET exam_frequency = f.exam_frequency,
       continues_from_id = f.continues_from_id, link_confirmed = f.link_confirmed
  FROM old_freq f
 WHERE c.syllabus_id = (SELECT id FROM target_syllabus) AND c.deleted_at IS NULL
   AND c.category_of_action = f.category_of_action;

-- Written notes attach to the lesson of the same name, rebuilt from the
-- sheet each time rather than stored by hand.
INSERT INTO lesson_note_sections (lesson_id, note_section_id, coverage)
SELECT l.id, s.id, 'full'
  FROM note_sections s
  JOIN note_sources src ON src.id = s.note_source_id
  JOIN lessons l ON lower(regexp_replace(l.title, '[^a-zA-Z0-9]', '', 'g'))
                 = lower(regexp_replace(s.title, '[^a-zA-Z0-9]', '', 'g'))
 WHERE l.syllabus_id = (SELECT id FROM target_syllabus) AND l.deleted_at IS NULL
   AND src.syllabus_id = (SELECT id FROM target_syllabus) AND s.deleted_at IS NULL
ON CONFLICT (lesson_id, note_section_id) DO NOTHING;

COMMIT;

-- ------------------------------------------------------------------
-- What happened. One result table; read every row.
-- ------------------------------------------------------------------

SELECT 'rows on the new sheet' AS item, count(*)::text AS value FROM lessons
 WHERE syllabus_id = (SELECT id FROM target_syllabus) AND deleted_at IS NULL
UNION ALL SELECT 'numbered lessons', count(*)::text FROM lessons
 WHERE syllabus_id = (SELECT id FROM target_syllabus) AND deleted_at IS NULL AND lesson_no_start IS NOT NULL
UNION ALL SELECT 'objectives', count(*)::text FROM objectives o
 JOIN lessons l ON l.id = o.lesson_id WHERE l.syllabus_id = (SELECT id FROM target_syllabus) AND l.deleted_at IS NULL
UNION ALL SELECT 'categories of action', count(*)::text FROM competencies
 WHERE syllabus_id = (SELECT id FROM target_syllabus) AND deleted_at IS NULL
UNION ALL SELECT 'modules', count(*)::text FROM modules
 WHERE syllabus_id = (SELECT id FROM target_syllabus) AND deleted_at IS NULL
UNION ALL SELECT 'rows archived from the old sheet', count(*)::text FROM lessons
 WHERE syllabus_id = (SELECT id FROM target_syllabus) AND deleted_at IS NOT NULL
UNION ALL SELECT 'notes attached to a lesson', count(*)::text
  FROM lesson_note_sections lns JOIN lessons l ON l.id = lns.lesson_id
 WHERE l.syllabus_id = (SELECT id FROM target_syllabus) AND l.deleted_at IS NULL
UNION ALL SELECT 'notes with no lesson on the new sheet', count(*)::text
  FROM note_sections s JOIN note_sources src ON src.id = s.note_source_id
 WHERE src.syllabus_id = (SELECT id FROM target_syllabus) AND s.deleted_at IS NULL
   AND NOT EXISTS (SELECT 1 FROM lesson_note_sections lns
                     JOIN lessons l ON l.id = lns.lesson_id AND l.deleted_at IS NULL
                    WHERE lns.note_section_id = s.id)
UNION ALL SELECT 'uploaded files still attached', count(*)::text
  FROM lesson_resources r JOIN lessons l ON l.id = r.lesson_id
 WHERE l.syllabus_id = (SELECT id FROM target_syllabus) AND l.deleted_at IS NULL AND r.deleted_at IS NULL;
