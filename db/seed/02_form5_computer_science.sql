-- National Harmonised Progression Sheet for Computer Science Form 5
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
INSERT INTO levels (name, short_name) VALUES ('GCE Ordinary Level', 'O/L') ON CONFLICT (name) DO NOTHING;

DROP TABLE IF EXISTS target_syllabus;
CREATE TEMP TABLE target_syllabus AS
SELECT s.id FROM syllabi s
 WHERE s.form_level = 'Form 5' AND s.deleted_at IS NULL
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
  'd280ec19-0e1f-436e-806e-f8c5fcdf9c6b',
  (SELECT id FROM subjects WHERE name = 'Computer Science'),
  (SELECT id FROM levels   WHERE name = 'GCE Ordinary Level'),
  'National Harmonised Progression Sheet for Computer Science Form 5', 'Form 5', 'Inspectorate General of Education, Inspectorate of Pedagogy in charge of the Teaching of Computer Science',
  'national', NULL, 'National Harmonised Progression 2026/2027',
  2026, 36,
  3, NULL,
  NULL, 'Module', true,
  true, true,
  false
WHERE NOT EXISTS (SELECT 1 FROM target_syllabus)
ON CONFLICT (id) DO NOTHING;

DROP TABLE IF EXISTS target_syllabus;
CREATE TEMP TABLE target_syllabus AS
SELECT s.id FROM syllabi s
 WHERE s.form_level = 'Form 5' AND s.deleted_at IS NULL
 ORDER BY (SELECT count(*) FROM classes c WHERE c.syllabus_id = s.id) DESC,
          (SELECT count(*) FROM note_sources n WHERE n.syllabus_id = s.id) DESC,
          s.created_at
 LIMIT 1;

-- Stop here, loudly, rather than fail forty inserts later with a foreign
-- key message that says nothing about what went wrong.
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM target_syllabus) THEN
    RAISE EXCEPTION 'No syllabus row for Form 5 and none could be created';
  END IF;
END $$;

-- ------------------------------------------------------------------
-- 2. What this sheet is going to consist of.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS new_lesson_ids;
CREATE TEMP TABLE new_lesson_ids (id UUID PRIMARY KEY);
INSERT INTO new_lesson_ids (id) VALUES
  ('2e089d6f-34fb-5ced-9902-faee79254ae7'),
  ('7688e7a1-c1d1-511b-b86a-b6ebb4ba42bf'),
  ('2a62b118-1f2d-5230-aa0f-d8af6c2e1897'),
  ('73182402-17b8-5b66-80c0-d76c4aa72469'),
  ('5a593871-3a74-557f-86e9-8efd6b355119'),
  ('879e6c1f-ff31-5aac-9da4-7823a1f1f447'),
  ('42c5f076-ff33-5971-adfa-cb1acc6c2bb1'),
  ('b776aa60-8b1c-53dd-a831-2e02c9bec88a'),
  ('c9ca63f6-cff4-5d80-ae71-3f9b030d5b98'),
  ('28b795c2-db74-5152-b4cc-171306d86e17'),
  ('20e293d6-2159-523e-a0e2-38f3dbc31925'),
  ('c7dbd713-b85f-5fe6-9b5b-89afd115f89d'),
  ('cbc727dd-cf42-53eb-99cb-9a0fc37ceb1e'),
  ('87735a6c-be38-57e3-a5bf-5d0fd8d2b49b'),
  ('4fee4a98-3643-5420-9083-664fe4ef96af'),
  ('1ead9a9c-bd8e-5a8e-b272-e45956e03cd6'),
  ('55264793-24d0-5ee4-bfbe-914db5c05118'),
  ('4993ab6e-378e-5c9f-9a6d-ced04f5bfa1e'),
  ('60617863-4064-5401-b8d2-23aff5200f4d'),
  ('84f541b4-c4e0-52d7-ad09-7260b25c9efb'),
  ('40c00a04-65c8-580b-be69-8f92c8a8128d'),
  ('85deeca0-1819-5f4b-9fd5-dde681a4046e'),
  ('fe1b2fb9-4136-5d62-b06c-b78f9f1ccc78'),
  ('8c164910-9cb1-5a80-a38f-83d979a99283'),
  ('72002622-3768-5d6a-9cf0-504e0ddd951c'),
  ('578f2a51-8fee-589e-89ec-015545284f87'),
  ('e5cb7edc-fbdf-5278-9ed7-254168a8b9df'),
  ('7941ce6a-d1da-5310-8122-179662fd86bb'),
  ('d9ec8af7-2575-5811-9aac-c08b74066490'),
  ('460c3c54-b0c8-57ca-af9d-001e76b80701'),
  ('c63a80f4-99bb-51f6-9330-c247407d14ec'),
  ('f4eb3ca8-17f3-5ab6-9619-8aacb2bfdccb'),
  ('253eb78d-e614-5a10-991c-2803c3d74cac'),
  ('ea9fe6cb-86bb-58d8-bf38-10a4c69c8313'),
  ('907d780e-4afc-560e-b3f9-1b55c7f3df4f'),
  ('c5e6b0d3-914a-5e14-8110-bdd943e08360'),
  ('f71523d3-fb29-507b-b8d8-3a618e8017d4'),
  ('135bce20-bfc9-517e-a959-51a5a6d2534c'),
  ('8039934d-309f-5fa7-9d40-0c9233c3e363'),
  ('7fdd8171-ce86-52ef-b99a-63ab33c0f8db'),
  ('e326b97d-6152-595b-a39b-ed2baf93ab45'),
  ('af1a7aaf-a4b0-573a-a88d-5c2204b52c7f'),
  ('258ac047-a2a3-59fe-8388-35475369d85b'),
  ('a199b4d6-6191-50e4-9021-256fedd057a9'),
  ('31c5877e-d784-54c8-9dc2-e285d15bc8b8'),
  ('ffcf8639-40a6-5faa-9eec-38e9ec713b38'),
  ('3ab7f3d9-c2b8-53e5-98f1-1da03cf063fc'),
  ('937c0718-dc2d-5872-be2f-f39b225ac07f'),
  ('630364ec-82d5-5571-b6e9-f749b20c27db'),
  ('93672dfe-15f9-58f1-a27f-80d77c825b9f'),
  ('19f0272a-fa30-5370-af35-454bada8c217'),
  ('c59a4e62-d94a-5050-9938-e5178c6d716c'),
  ('d5bcb7c6-368e-50b4-baf1-ef96c5420113'),
  ('d2840ec8-8583-5af7-b3d2-07ed87f5dd6a'),
  ('a4688826-bb4e-5d1f-ac29-41e6206b23bd'),
  ('590dce8b-1552-574d-a4a7-cc479f73c960'),
  ('70c956b3-c5a3-5a67-8b1b-ae12b5256c90'),
  ('e153dab1-e418-5c6a-bedf-0a651b771d4f'),
  ('c2444e06-9add-542f-bd79-0fd1f4d5b5e2'),
  ('61c99696-8ddb-5067-96d2-f3c014fc51c3'),
  ('b01237d2-20fd-5f85-9ee2-ea7c8b029fd6'),
  ('be253956-d1aa-5fbc-b205-679b85a45330'),
  ('da72e03c-88ef-5f77-af9d-6f105e6cf498'),
  ('2bcbe4e5-6aa3-5cba-99fa-eb737feb0d2e'),
  ('00e5c59a-5086-50c1-b5fa-8dd6d51faa4e'),
  ('1688847f-fa23-571d-b60b-70c2100d5758'),
  ('eb1a4c65-d9d9-5da5-9b5b-d3d483a9124d'),
  ('37c64ca9-3e0e-5da0-b81f-a9f954a92dbd'),
  ('f757004d-10bf-557b-83aa-af2c4d7a47e8'),
  ('d6ae7020-728a-5845-a567-583db8f2fcc6'),
  ('ea0790eb-c2f3-5ce2-982d-2c01dabcf251'),
  ('766cc2bf-8da1-52e9-b074-8769f5c3e538'),
  ('1060e4b2-c82b-571d-88bc-d491e6a9a714'),
  ('07a421b5-832a-51f5-a401-9f37f6b35d76'),
  ('c5458ba0-7f95-5f84-9cfa-2bb3dc6b0811'),
  ('fe9eb0b8-5a96-5384-a3bc-c5adf7fc9d25'),
  ('2e5f4255-f909-5536-abc2-7a9875e6f10c'),
  ('f3a9c8b8-bb41-5993-9669-0d22d0fc1a17'),
  ('6b7b2d64-f4ff-58b7-b9b9-169e44bdac58'),
  ('6b57b1b4-3823-5dd0-9eb8-edf99ece27c5'),
  ('c1b5a68b-bab8-5ef5-bc86-ad07f6f2b6f3'),
  ('afaad3d2-ebb4-536c-8022-186d26238778'),
  ('008b2482-5d2b-5613-b0ae-123dace51479'),
  ('6341bbb8-3d98-5777-885d-1607556c5756'),
  ('aa94fd14-e82f-548b-b7d3-c1de496fb1d0'),
  ('2ca54430-3e4f-5b6c-807e-abef57561679'),
  ('718e9e08-eefc-5ac0-bfab-816ce8c38144'),
  ('0cfdbd79-f9cb-5d0d-8980-5e3aa3342e33'),
  ('457a8078-46bf-54e2-a333-b9f9e202adeb'),
  ('4661f764-80a6-5ee6-87b5-baf7d81f248a'),
  ('86ea5ce5-098b-5b71-b624-12f0c3b56531'),
  ('ea86a980-3484-5aab-a21e-f0e011202b9b'),
  ('6eb51bb2-1714-5163-935b-8eacdad7e547'),
  ('496b71d3-f204-5edc-8e90-85ebec65b06d'),
  ('43f1b5f9-0195-5ec9-958b-efe97e37e2e4'),
  ('3d03ea7d-13be-593f-977b-add22af9c37d'),
  ('e2daf4e9-608e-51c5-882f-708f1230e8e8'),
  ('c4fff1f2-59c0-56ec-832f-017c65402795'),
  ('14dc362a-76fd-5aff-a236-53f561180e52'),
  ('882f7a8d-dd7b-5c0f-9453-a8f8b1de02fd'),
  ('fd15c93c-f2ab-5abb-94ae-2692eb5804b7'),
  ('c83aac51-d0b1-5c6a-bbc7-6eee2114493e'),
  ('1d8b0d06-bb1b-5a4b-b716-17a637bc8e21'),
  ('ada76e9f-c688-568f-a4fb-fc91a41e5445'),
  ('f518b94b-edd7-5af7-87f3-c975bb888289');

DROP TABLE IF EXISTS new_comp_ids;
CREATE TEMP TABLE new_comp_ids (id UUID PRIMARY KEY);
INSERT INTO new_comp_ids (id) VALUES
  ('4931bd0a-3baf-5034-b348-a28f169aa5a0'),
  ('fbbd16cb-d90d-52d6-ac58-c7b5fd73a502'),
  ('7877b7e6-60a8-52a6-a876-a28c21748ed6'),
  ('771b76e8-183b-5a74-8320-c5a2b6960269'),
  ('4aa0df6c-1dd5-5207-b1f4-cafbb01e8b46'),
  ('38cb1f79-7f8e-51a8-9473-fbe7546fc3ce'),
  ('96d82bf9-41b4-557f-ac93-ae14b98f0e36'),
  ('e0593f92-07c1-5452-bf03-52a71b21f72f'),
  ('5284706e-4919-517c-b499-e71aeb43de24'),
  ('6f7fbf19-ad41-5f93-a920-119992f27f28'),
  ('8315ac79-ae54-5a89-973a-082fe5028c9f'),
  ('063973b1-6361-5576-ba1d-22d274b43c15'),
  ('91928cc7-d9bb-57a0-a8bd-2a8c3974c75e'),
  ('e057c48c-6e4d-500f-b789-31f326bf4fbe'),
  ('2318c65c-9a89-5d36-bbec-37a0073f80aa'),
  ('7d9101e7-22d4-5580-a0d0-fd5a67a96351'),
  ('0c7ff2e1-a9f3-54a4-befe-85e0fd3fafc1'),
  ('39f52bd2-576e-5d17-bd34-f710b0248ce5'),
  ('6c84227d-049c-5332-b809-0b38b62530f3'),
  ('ff4f0be6-8728-52b1-b276-05d8ae6d7533'),
  ('2f2f678d-3028-5a88-b97a-4f0ec3d656d3'),
  ('d234982c-0c81-5986-9cfb-061e8876a7e6'),
  ('de3308d3-d130-5748-a357-767930a51948');

DROP TABLE IF EXISTS new_module_ids;
CREATE TEMP TABLE new_module_ids (id UUID PRIMARY KEY);
INSERT INTO new_module_ids (id) VALUES
  ('1dfa7753-f563-557f-97a6-69478902daef'),
  ('df4137a6-5a80-5b98-b667-dda47cb185c5'),
  ('7c69c79f-0cbe-584c-ab87-e6217114e10d'),
  ('b57c82c5-7aa3-5794-aaff-0eabce484433'),
  ('be83a247-8136-5bcb-8b44-00157af86214'),
  ('ae91ff23-61c6-54d4-8826-f50665eee233'),
  ('b8bc06cc-9f8a-5904-8f9f-5746140bef4b');

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
  level_id   = (SELECT id FROM levels   WHERE name = 'GCE Ordinary Level'),
  title = 'National Harmonised Progression Sheet for Computer Science Form 5',
  form_level = 'Form 5',
  issuing_authority = 'Inspectorate General of Education, Inspectorate of Pedagogy in charge of the Teaching of Computer Science',
  scope = 'national', region = NULL,
  version_label = 'National Harmonised Progression 2026/2027',
  effective_from = 2026,
  total_weeks = 36,
  weekly_periods_theory = 3,
  weekly_periods_practical = NULL,
  coefficient = NULL,
  module_label = 'Module',
  has_modules = true,
  uses_competencies = true,
  has_competency_statements = true,
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

INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('1dfa7753-f563-557f-97a6-69478902daef', (SELECT id FROM target_syllabus), 'Network Systems 2', 1)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('df4137a6-5a80-5b98-b667-dda47cb185c5', (SELECT id FROM target_syllabus), 'Hardware and Software Systems 3', 2)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('7c69c79f-0cbe-584c-ab87-e6217114e10d', (SELECT id FROM target_syllabus), 'Problem Solving and Coding 3', 3)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('b57c82c5-7aa3-5794-aaff-0eabce484433', (SELECT id FROM target_syllabus), 'Data Manipulation', 4)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('be83a247-8136-5bcb-8b44-00157af86214', (SELECT id FROM target_syllabus), 'System Security', 5)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('ae91ff23-61c6-54d4-8826-f50665eee233', (SELECT id FROM target_syllabus), 'Data Manipulation 2', 6)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('b8bc06cc-9f8a-5904-8f9f-5746140bef4b', (SELECT id FROM target_syllabus), 'Ethics, Society and Legal Issues 3', 7)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();

INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('4931bd0a-3baf-5034-b348-a28f169aa5a0', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef', 'Social networks', 'Given the need to share experiences and knowledge, learners communicate using platforms that permit interaction in real-time.', 1)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('fbbd16cb-d90d-52d6-ac58-c7b5fd73a502', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5', 'Exploring Application Areas of Computers', 'Provided with a situation related to the use of AI, learners write appropriate prompts to get an output or response.', 2)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('7877b7e6-60a8-52a6-a876-a28c21748ed6', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d', 'Evaluating an information system', 'Given the description of an information system learners evaluate its effectiveness, efficiency, security, ease of use and reliability justifying their answer in each case.', 3)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('771b76e8-183b-5a74-8320-c5a2b6960269', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d', 'Developing a system', 'In a situation of developing a system for a school, business, party management, etc., learners select and design appropriate ways of organising data, describe the processing of data, and select appropriate hardware and software for the given task.', 4)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('4aa0df6c-1dd5-5207-b1f4-cafbb01e8b46', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d', 'Designing and implementing simple databases', 'Provided with a problem in an organisation related to databases, learners build simple database systems for the organisations. The implementation should meet the needs of the organisation.', 5)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('38cb1f79-7f8e-51a8-9473-fbe7546fc3ce', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d', 'Managing projects', 'In a situation where a number of activities (tasks) are given', 6)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('96d82bf9-41b4-557f-ac93-ae14b98f0e36', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d', 'Describing data structure', 'After analysing a problem such that the variables in a problem are known, learners choose the appropriate data type for each variable and determine the best data structure to use to guarantee efficient processing.', 7)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e0593f92-07c1-5452-bf03-52a71b21f72f', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d', 'Writing algorithms', 'Presented with a problem, learners express the solution by writing down instructions that will lead to solving the problem efficiently.', 8)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('5284706e-4919-517c-b499-e71aeb43de24', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d', 'Converting an algorithm into a program', 'In a situation where the algorithm for a problem is available, learners develop corresponding instructions in a programming language; using the appropriate IDE.', 9)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('6f7fbf19-ad41-5f93-a920-119992f27f28', (SELECT id FROM target_syllabus), 'b57c82c5-7aa3-5794-aaff-0eabce484433', 'Representing data in the computer', 'In a situation where data is stored in the computer, learners identify and use coding schemes to represent data', 10)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('8315ac79-ae54-5a89-973a-082fe5028c9f', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5', 'Describing peripheral devices', 'In a situation where a computer is to be equipped for various purposes, learners identify appropriate input and output peripheral devices for high productivity.', 11)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('063973b1-6361-5576-ba1d-22d274b43c15', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5', 'Creating digital content using a software', 'Given tasks to accomplish, learners use appropriate features of a software to correctly accomplish the task.', 12)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('91928cc7-d9bb-57a0-a8bd-2a8c3974c75e', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5', 'Proposing assistive technology for social inclusion', 'Given a situation with factors related to the aging and users with disabilities, learners select appropriate technologies for a given disability while clearly justifying their choices.', 13)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e057c48c-6e4d-500f-b789-31f326bf4fbe', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef', 'Exploring the concepts related to data communication', 'Given a situation with factors related to data communication systems, learners explain correctly, concisely, and precisely the mechanisms used in the situation.', 14)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('2318c65c-9a89-5d36-bbec-37a0073f80aa', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef', 'Setting up LANs', 'Given a situation that requires setting up a simple network, learners prescribe the appropriate tools and configuration to meet the needs of the situation.', 15)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('7d9101e7-22d4-5580-a0d0-fd5a67a96351', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214', 'Securing data, computers, and networks', 'Given a computing environment where computers, data and networks are exposed to security threats, learners identify potential risks and implement appropriate measures to protect data, computers and networks, justifying the security measures selected.', 16)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('0c7ff2e1-a9f3-54a4-befe-85e0fd3fafc1', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214', 'Evaluating the impacts of digital identities and digital footprints', 'Given a situation outlining the online practices of a user, learners evaluate their management of digital footprints, expose the risk they are facing and recommend tips for managing footprints and reputation.', 17)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('39f52bd2-576e-5d17-bd34-f710b0248ce5', (SELECT id FROM target_syllabus), 'ae91ff23-61c6-54d4-8826-f50665eee233', 'Analysing simple logic circuits and logic expressions', 'Presented with a logic circuit or expression, learners isolate the different components and correctly express the possible output', 18)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('6c84227d-049c-5332-b809-0b38b62530f3', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5', 'Describing internal components of the computer', 'Provided with a situation with factors related to devices that are not peripherals, learners select devices or features of these devices that are coherent to the situation and justify their choice.', 19)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('ff4f0be6-8728-52b1-b276-05d8ae6d7533', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef', 'Working on the Internet', 'Given a situation related to the use of the internet and its services, learners select appropriate service clearly justifying their choice', 20)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('2f2f678d-3028-5a88-b97a-4f0ec3d656d3', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5', 'Getting application software', 'Provided with tasks to produce or edit digital content, learners choose the most appropriate software for each task clearly justifying their choice.', 21)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('d234982c-0c81-5986-9cfb-061e8876a7e6', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5', 'Describing ways of acquiring and distributing software', 'Describe ways of acquiring or distributing software', 22)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('de3308d3-d130-5748-a357-767930a51948', (SELECT id FROM target_syllabus), 'b8bc06cc-9f8a-5904-8f9f-5746140bef4b', 'Examine licenses and copyright practices', 'Placed in a situation with issues related to intellectual property, learners propose ways of identifying free and copyrighted data or digital content, ways of protecting digital content and ways of using content protected by a given license. Proposals should be coherent with the situation and clearly justified.', 23)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();

-- Objectives are rebuilt wholesale rather than matched: they are the
-- Ministry's text and carry nothing of the teacher's.
DELETE FROM objectives WHERE lesson_id IN (SELECT id FROM new_lesson_ids);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2e089d6f-34fb-5ced-9902-faee79254ae7', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  '4931bd0a-3baf-5034-b348-a28f169aa5a0',
  NULL, NULL, 'Diagnostic evaluation',
  1, 1, 1,
  true, false, false,
  'diagnostic_evaluation', 1
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
  '7688e7a1-c1d1-511b-b86a-b6ebb4ba42bf', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  '4931bd0a-3baf-5034-b348-a28f169aa5a0',
  1, 1, 'Notions on social networks',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7688e7a1-c1d1-511b-b86a-b6ebb4ba42bf', 'objective', 'State the reasons for social networks.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7688e7a1-c1d1-511b-b86a-b6ebb4ba42bf', 'objective', 'State the characteristics of social networks.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7688e7a1-c1d1-511b-b86a-b6ebb4ba42bf', 'objective', 'State advantages and disadvantages of online social networks.', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7688e7a1-c1d1-511b-b86a-b6ebb4ba42bf', 'objective', 'Explain the impacts of online social networks.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2a62b118-1f2d-5230-aa0f-d8af6c2e1897', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  '4931bd0a-3baf-5034-b348-a28f169aa5a0',
  2, 2, 'Using online social networks',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2a62b118-1f2d-5230-aa0f-d8af6c2e1897', 'objective', 'Differentiate between social network and social media.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2a62b118-1f2d-5230-aa0f-d8af6c2e1897', 'objective', 'Differentiate between different online social networks.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2a62b118-1f2d-5230-aa0f-d8af6c2e1897', 'objective', 'Make use of an online social network to share resources and communicate.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '73182402-17b8-5b66-80c0-d76c4aa72469', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  '4931bd0a-3baf-5034-b348-a28f169aa5a0',
  3, 3, 'Integration activities',
  1, 1, 1,
  true, false, false,
  'integration_activity', 4
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
  '5a593871-3a74-557f-86e9-8efd6b355119', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  'fbbd16cb-d90d-52d6-ac58-c7b5fd73a502',
  4, 4, 'Introduction to Artificial Intelligence',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5a593871-3a74-557f-86e9-8efd6b355119', 'objective', 'Define AI.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5a593871-3a74-557f-86e9-8efd6b355119', 'objective', 'Explain the history and evolution of AI.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5a593871-3a74-557f-86e9-8efd6b355119', 'objective', 'Identify and categorise the different types of AI in real world.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '879e6c1f-ff31-5aac-9da4-7823a1f1f447', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  'fbbd16cb-d90d-52d6-ac58-c7b5fd73a502',
  5, 5, 'Applications and Ethics of Artificial Intelligence',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('879e6c1f-ff31-5aac-9da4-7823a1f1f447', 'objective', 'Identify common applications of AI.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('879e6c1f-ff31-5aac-9da4-7823a1f1f447', 'objective', 'Explain the uses of AI in different fields.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('879e6c1f-ff31-5aac-9da4-7823a1f1f447', 'objective', 'State the ethical issues related to AI.', 'remember', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '42c5f076-ff33-5971-adfa-cb1acc6c2bb1', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  'fbbd16cb-d90d-52d6-ac58-c7b5fd73a502',
  6, 6, 'The use of appropriate Prompts to generate AI responses',
  1, 2, 2,
  true, false, false,
  'content', 7
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('42c5f076-ff33-5971-adfa-cb1acc6c2bb1', 'objective', 'Examine prompt results.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('42c5f076-ff33-5971-adfa-cb1acc6c2bb1', 'objective', 'Discuss prompt results.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('42c5f076-ff33-5971-adfa-cb1acc6c2bb1', 'objective', 'Write appropriate prompts to solve problems within a given context.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b776aa60-8b1c-53dd-a831-2e02c9bec88a', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  'fbbd16cb-d90d-52d6-ac58-c7b5fd73a502',
  7, 7, 'Integration activities',
  1, 3, 3,
  true, false, false,
  'integration_activity', 8
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
  'c9ca63f6-cff4-5d80-ae71-3f9b030d5b98', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '7877b7e6-60a8-52a6-a876-a28c21748ed6',
  8, 8, 'Notions on organizations and information',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c9ca63f6-cff4-5d80-ae71-3f9b030d5b98', 'objective', 'Explain the concepts of information and organization.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c9ca63f6-cff4-5d80-ae71-3f9b030d5b98', 'objective', 'Explain the characteristics of good information.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c9ca63f6-cff4-5d80-ae71-3f9b030d5b98', 'objective', 'Explain the flow of information within an organization.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '28b795c2-db74-5152-b4cc-171306d86e17', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '7877b7e6-60a8-52a6-a876-a28c21748ed6',
  9, 9, 'Information systems',
  1, 3, 3,
  true, false, false,
  'content', 10
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('28b795c2-db74-5152-b4cc-171306d86e17', 'objective', 'Define an information system.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('28b795c2-db74-5152-b4cc-171306d86e17', 'objective', 'Differentiate manual and automated information systems.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('28b795c2-db74-5152-b4cc-171306d86e17', 'objective', 'Describe the elements of an information system.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '20e293d6-2159-523e-a0e2-38f3dbc31925', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '7877b7e6-60a8-52a6-a876-a28c21748ed6',
  10, 10, 'Types of information system',
  1, 4, 4,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20e293d6-2159-523e-a0e2-38f3dbc31925', 'objective', 'Describe common types of information system.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20e293d6-2159-523e-a0e2-38f3dbc31925', 'objective', 'Differentiate between batch processing and real- time processing.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('20e293d6-2159-523e-a0e2-38f3dbc31925', 'objective', 'Explain how choosing an appropriate process can help ensure the efficiency of an information system.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c7dbd713-b85f-5fe6-9b5b-89afd115f89d', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '7877b7e6-60a8-52a6-a876-a28c21748ed6',
  11, 11, 'Data capture methods',
  1, 4, 4,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c7dbd713-b85f-5fe6-9b5b-89afd115f89d', 'objective', 'Explain the concept of data capture.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c7dbd713-b85f-5fe6-9b5b-89afd115f89d', 'objective', 'Describe common manual and automated data capture methods.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c7dbd713-b85f-5fe6-9b5b-89afd115f89d', 'objective', 'Explain how automated data capture helps improve effectiveness, and reliability of an information system.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'cbc727dd-cf42-53eb-99cb-9a0fc37ceb1e', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '7877b7e6-60a8-52a6-a876-a28c21748ed6',
  12, 12, 'Data verification and validation',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cbc727dd-cf42-53eb-99cb-9a0fc37ceb1e', 'objective', 'Differentiate between data verification and data validation.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cbc727dd-cf42-53eb-99cb-9a0fc37ceb1e', 'objective', 'Describe data verification and data validation methods.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('cbc727dd-cf42-53eb-99cb-9a0fc37ceb1e', 'objective', 'Explain how data validation and data verification ensure the effectiveness, and reliability of an information system.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '87735a6c-be38-57e3-a5bf-5d0fd8d2b49b', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '7877b7e6-60a8-52a6-a876-a28c21748ed6',
  13, 13, 'Data integrity',
  1, 5, 5,
  true, false, false,
  'content', 14
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('87735a6c-be38-57e3-a5bf-5d0fd8d2b49b', 'objective', 'Explain the concept of data integrity.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('87735a6c-be38-57e3-a5bf-5d0fd8d2b49b', 'objective', 'Explain why ensuring data integrity is important in an information system.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('87735a6c-be38-57e3-a5bf-5d0fd8d2b49b', 'objective', 'Explain ways of ensuring data integrity in an information system.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4fee4a98-3643-5420-9083-664fe4ef96af', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '7877b7e6-60a8-52a6-a876-a28c21748ed6',
  14, 14, 'Integration activities',
  1, 5, 5,
  true, false, false,
  'integration_activity', 15
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
  '1ead9a9c-bd8e-5a8e-b272-e45956e03cd6', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '7877b7e6-60a8-52a6-a876-a28c21748ed6',
  NULL, NULL, 'Evaluation',
  1, 5, 5,
  true, false, false,
  'evaluation', 16
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
  '55264793-24d0-5ee4-bfbe-914db5c05118', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '7877b7e6-60a8-52a6-a876-a28c21748ed6',
  NULL, NULL, 'Remediation',
  1, 6, 6,
  true, false, false,
  'remediation', 17
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
  '4993ab6e-378e-5c9f-9a6d-ced04f5bfa1e', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '771b76e8-183b-5a74-8320-c5a2b6960269',
  15, 15, 'Stages of SDLC: investigation, analysis, design',
  1, 6, 6,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4993ab6e-378e-5c9f-9a6d-ced04f5bfa1e', 'objective', 'Describe the investigation, analysis and design stages of the SDLC.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4993ab6e-378e-5c9f-9a6d-ced04f5bfa1e', 'objective', 'Outline the functions of a system to be developed.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4993ab6e-378e-5c9f-9a6d-ced04f5bfa1e', 'objective', 'Explain the concept of prototyping.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4993ab6e-378e-5c9f-9a6d-ced04f5bfa1e', 'objective', 'Explain the need for appropriate choice of hardware and software for a system.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '60617863-4064-5401-b8d2-23aff5200f4d', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '771b76e8-183b-5a74-8320-c5a2b6960269',
  16, 16, 'Stages of SDLC: development, testing, implementation, maintenance',
  1, 6, 6,
  true, false, false,
  'content', 19
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('60617863-4064-5401-b8d2-23aff5200f4d', 'objective', 'Describe the development, testing, implementation, and maintenance stages of the SDLC.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('60617863-4064-5401-b8d2-23aff5200f4d', 'objective', 'Explain the need for documentation in system development.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '84f541b4-c4e0-52d7-ad09-7260b25c9efb', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '771b76e8-183b-5a74-8320-c5a2b6960269',
  17, 17, 'Implementation strategies',
  1, 7, 7,
  true, false, false,
  'content', 20
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('84f541b4-c4e0-52d7-ad09-7260b25c9efb', 'objective', 'Describe the different implementation strategies.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('84f541b4-c4e0-52d7-ad09-7260b25c9efb', 'objective', 'Outline the advantages and disadvantages of a given implementation strategy.', 'remember', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '40c00a04-65c8-580b-be69-8f92c8a8128d', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '771b76e8-183b-5a74-8320-c5a2b6960269',
  18, 18, 'Integration activities',
  1, 7, 7,
  true, false, false,
  'integration_activity', 21
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
  '85deeca0-1819-5f4b-9fd5-dde681a4046e', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '4aa0df6c-1dd5-5207-b1f4-cafbb01e8b46',
  19, 19, 'Introduction to databases',
  1, 7, 7,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('85deeca0-1819-5f4b-9fd5-dde681a4046e', 'objective', 'Describe common types of database.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('85deeca0-1819-5f4b-9fd5-dde681a4046e', 'objective', 'Outline advantages and disadvantages of flat file systems. State common features of a DBMS.', 'remember', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fe1b2fb9-4136-5d62-b06c-b78f9f1ccc78', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '4aa0df6c-1dd5-5207-b1f4-cafbb01e8b46',
  20, 20, 'Relational database design',
  1, 8, 8,
  true, false, false,
  'content', 23
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fe1b2fb9-4136-5d62-b06c-b78f9f1ccc78', 'objective', 'Explain the concepts of attribute, record, table, primary key, foreign key, relationship.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fe1b2fb9-4136-5d62-b06c-b78f9f1ccc78', 'objective', 'Identify attributes, tables, primary key, and relationships in a given situation.', 'analyse', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8c164910-9cb1-5a80-a38f-83d979a99283', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '4aa0df6c-1dd5-5207-b1f4-cafbb01e8b46',
  21, 21, 'Normalization and Relational models',
  1, 8, 8,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8c164910-9cb1-5a80-a38f-83d979a99283', 'objective', 'Explain the purpose of normalization.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8c164910-9cb1-5a80-a38f-83d979a99283', 'objective', 'State the properties of a database in 1NF, 2NF, and 3NF.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8c164910-9cb1-5a80-a38f-83d979a99283', 'objective', 'Identify attributes, tables, primary key, foreign key, and relationships in a given situation.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '72002622-3768-5d6a-9cf0-504e0ddd951c', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '4aa0df6c-1dd5-5207-b1f4-cafbb01e8b46',
  22, 22, 'Use an RDBMS to create tables',
  1, 8, 8,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('72002622-3768-5d6a-9cf0-504e0ddd951c', 'objective', 'Outline examples of an RDBMS.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('72002622-3768-5d6a-9cf0-504e0ddd951c', 'objective', 'Identify common features of a given GUI RDBMS.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('72002622-3768-5d6a-9cf0-504e0ddd951c', 'objective', 'Make use of a GUI RDBMS to create tables.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '578f2a51-8fee-589e-89ec-015545284f87', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '4aa0df6c-1dd5-5207-b1f4-cafbb01e8b46',
  23, 23, 'Use an RDBMS to create relationships',
  1, 9, 9,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('578f2a51-8fee-589e-89ec-015545284f87', 'objective', 'Make use of a GUI RDBMS to create relationships.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('578f2a51-8fee-589e-89ec-015545284f87', 'objective', 'Enter data in a table found in a GUI RDBMS.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('578f2a51-8fee-589e-89ec-015545284f87', 'objective', 'Perform simple operations such as sorting and filtering data with the aid of a GUI RDBMS.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e5cb7edc-fbdf-5278-9ed7-254168a8b9df', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '4aa0df6c-1dd5-5207-b1f4-cafbb01e8b46',
  24, 24, 'Use an RDBMS to create queries and reports',
  1, 9, 9,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e5cb7edc-fbdf-5278-9ed7-254168a8b9df', 'objective', 'Explain the concepts of database queries and reports.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e5cb7edc-fbdf-5278-9ed7-254168a8b9df', 'objective', 'Make use of a GUI RDBMS to create queries that is coherent to a situation.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e5cb7edc-fbdf-5278-9ed7-254168a8b9df', 'objective', 'Make use of a GUI RDBMS to create reports.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7941ce6a-d1da-5310-8122-179662fd86bb', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '4aa0df6c-1dd5-5207-b1f4-cafbb01e8b46',
  25, 25, 'Integration activities',
  1, 9, 9,
  true, false, false,
  'integration_activity', 28
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
  'd9ec8af7-2575-5811-9aac-c08b74066490', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '38cb1f79-7f8e-51a8-9473-fbe7546fc3ce',
  26, 26, 'Introduction to project management',
  1, 10, 10,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d9ec8af7-2575-5811-9aac-c08b74066490', 'objective', 'Explain the concept of project.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d9ec8af7-2575-5811-9aac-c08b74066490', 'objective', 'Explain the need for project management.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d9ec8af7-2575-5811-9aac-c08b74066490', 'objective', 'Describe the phases of the project life cycle.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '460c3c54-b0c8-57ca-af9d-001e76b80701', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '38cb1f79-7f8e-51a8-9473-fbe7546fc3ce',
  27, 27, 'Project management tools',
  1, 10, 10,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('460c3c54-b0c8-57ca-af9d-001e76b80701', 'objective', 'Describe tools used to plan, monitor and control a project. Produce the Gantt chart for a project.', 'understand', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c63a80f4-99bb-51f6-9330-c247407d14ec', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '38cb1f79-7f8e-51a8-9473-fbe7546fc3ce',
  28, 28, 'Project management concepts and metrics 1',
  1, 10, 10,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c63a80f4-99bb-51f6-9330-c247407d14ec', 'objective', 'Explain the concept of task, milestone, critical path, slack time, duration of project, critical tasks.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c63a80f4-99bb-51f6-9330-c247407d14ec', 'objective', 'Determine the critical path, slack time, and duration of a project from a Gantt chart.', 'analyse', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f4eb3ca8-17f3-5ab6-9619-8aacb2bfdccb', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '38cb1f79-7f8e-51a8-9473-fbe7546fc3ce',
  29, 29, 'Project management concepts and metrics 2',
  1, 11, 11,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f4eb3ca8-17f3-5ab6-9619-8aacb2bfdccb', 'objective', 'Explain the concepts of early start, early finish, late start, and late finish.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f4eb3ca8-17f3-5ab6-9619-8aacb2bfdccb', 'objective', 'Determine the early start, early finish, late start, and late finish in a given situation.', 'analyse', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '253eb78d-e614-5a10-991c-2803c3d74cac', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '38cb1f79-7f8e-51a8-9473-fbe7546fc3ce',
  30, 30, 'Integration activities',
  1, 11, 11,
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
  'ea9fe6cb-86bb-58d8-bf38-10a4c69c8313', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '38cb1f79-7f8e-51a8-9473-fbe7546fc3ce',
  NULL, NULL, 'Evaluation',
  1, 11, 11,
  true, false, false,
  'evaluation', 34
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
  '907d780e-4afc-560e-b3f9-1b55c7f3df4f', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '38cb1f79-7f8e-51a8-9473-fbe7546fc3ce',
  NULL, NULL, 'Remediation',
  1, 12, 12,
  true, false, false,
  'remediation', 35
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
  'c5e6b0d3-914a-5e14-8110-bdd943e08360', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '96d82bf9-41b4-557f-ac93-ae14b98f0e36',
  31, 31, 'Simple data types',
  1, 12, 12,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c5e6b0d3-914a-5e14-8110-bdd943e08360', 'objective', 'Explain the concept of data type.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c5e6b0d3-914a-5e14-8110-bdd943e08360', 'objective', 'Describe simple data types.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c5e6b0d3-914a-5e14-8110-bdd943e08360', 'objective', 'Choose appropriate simple data type for a given situation.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f71523d3-fb29-507b-b8d8-3a618e8017d4', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '96d82bf9-41b4-557f-ac93-ae14b98f0e36',
  32, 32, 'Data structures',
  1, 12, 12,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f71523d3-fb29-507b-b8d8-3a618e8017d4', 'objective', 'Differentiate between data type and data structure.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f71523d3-fb29-507b-b8d8-3a618e8017d4', 'objective', 'Describe the different data structures. Select appropriate data structure for a given situation.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '135bce20-bfc9-517e-a959-51a5a6d2534c', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '96d82bf9-41b4-557f-ac93-ae14b98f0e36',
  33, 33, 'Integration activities',
  2, 13, 13,
  true, false, false,
  'integration_activity', 38
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
  '8039934d-309f-5fa7-9d40-0c9233c3e363', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  'e0593f92-07c1-5452-bf03-52a71b21f72f',
  34, 34, 'Algorithms to solve common problems 1',
  2, 13, 13,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8039934d-309f-5fa7-9d40-0c9233c3e363', 'objective', 'Differentiate between pseudocode and flowchart.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8039934d-309f-5fa7-9d40-0c9233c3e363', 'objective', 'Produce pseudocode and flowchart to solve common. problems such as swapping, identification of maximum or minimum.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7fdd8171-ce86-52ef-b99a-63ab33c0f8db', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  'e0593f92-07c1-5452-bf03-52a71b21f72f',
  35, 35, 'Algorithms to solve common problems 2',
  2, 13, 13,
  true, false, false,
  'content', 40
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7fdd8171-ce86-52ef-b99a-63ab33c0f8db', 'objective', 'Differentiate between searching and sorting problems.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7fdd8171-ce86-52ef-b99a-63ab33c0f8db', 'objective', 'Explain the principles of linear search and bubble sort. Produce pseudocode and flowchart to solve common problems such as totalling, counting, …', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e326b97d-6152-595b-a39b-ed2baf93ab45', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  'e0593f92-07c1-5452-bf03-52a71b21f72f',
  36, 36, 'Notions on subroutines',
  2, 14, 14,
  true, false, false,
  'content', 41
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e326b97d-6152-595b-a39b-ed2baf93ab45', 'objective', 'Explain the concepts of subroutines, local variables, global variables, formal parameters, actual parameters.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e326b97d-6152-595b-a39b-ed2baf93ab45', 'objective', 'Identify common parts of a subroutine.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e326b97d-6152-595b-a39b-ed2baf93ab45', 'objective', 'Differentiate between procedures and functions.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'af1a7aaf-a4b0-573a-a88d-5c2204b52c7f', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  'e0593f92-07c1-5452-bf03-52a71b21f72f',
  37, 37, 'Algorithms as subroutines',
  2, 14, 14,
  true, false, false,
  'content', 42
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('af1a7aaf-a4b0-573a-a88d-5c2204b52c7f', 'objective', 'Produce procedures or functions to solve problems such as totalling, counting, max, min, swap.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '258ac047-a2a3-59fe-8388-35475369d85b', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  'e0593f92-07c1-5452-bf03-52a71b21f72f',
  38, 38, 'Algorithm correctness and efficiency',
  2, 14, 14,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('258ac047-a2a3-59fe-8388-35475369d85b', 'objective', 'Explain how dry running can be used to test the correctness of an algorithm.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('258ac047-a2a3-59fe-8388-35475369d85b', 'objective', 'Describe simple ways of measuring the efficiency of an algorithm.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('258ac047-a2a3-59fe-8388-35475369d85b', 'objective', 'Establish the correctness and efficiency of a given set of algorithms.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a199b4d6-6191-50e4-9021-256fedd057a9', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  'e0593f92-07c1-5452-bf03-52a71b21f72f',
  39, 39, 'Integration activities',
  2, 15, 15,
  true, false, false,
  'integration_activity', 44
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
  '31c5877e-d784-54c8-9dc2-e285d15bc8b8', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '5284706e-4919-517c-b499-e71aeb43de24',
  40, 40, 'Coding 1 (Python)',
  2, 15, 15,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('31c5877e-d784-54c8-9dc2-e285d15bc8b8', 'objective', 'State best practices when writing code.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('31c5877e-d784-54c8-9dc2-e285d15bc8b8', 'objective', 'Produce source code for the totalling, counting algorithms.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ffcf8639-40a6-5faa-9eec-38e9ec713b38', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '5284706e-4919-517c-b499-e71aeb43de24',
  41, 41, 'Coding 2 (Python)',
  2, 15, 15,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ffcf8639-40a6-5faa-9eec-38e9ec713b38', 'objective', 'Produce source code for maximum, minimum and swapping algorithms using subroutines.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3ab7f3d9-c2b8-53e5-98f1-1da03cf063fc', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '5284706e-4919-517c-b499-e71aeb43de24',
  42, 42, 'Coding 3 (Python)',
  2, 16, 16,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3ab7f3d9-c2b8-53e5-98f1-1da03cf063fc', 'objective', 'Produce source code for linear search algorithm and bubble sort algorithms.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '937c0718-dc2d-5872-be2f-f39b225ac07f', (SELECT id FROM target_syllabus), '7c69c79f-0cbe-584c-ab87-e6217114e10d',
  '5284706e-4919-517c-b499-e71aeb43de24',
  43, 43, 'Integration activities',
  2, 16, 16,
  true, false, false,
  'integration_activity', 48
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
  '630364ec-82d5-5571-b6e9-f749b20c27db', (SELECT id FROM target_syllabus), 'b57c82c5-7aa3-5794-aaff-0eabce484433',
  '6f7fbf19-ad41-5f93-a920-119992f27f28',
  44, 44, 'Notions on data encoding',
  2, 16, 16,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('630364ec-82d5-5571-b6e9-f749b20c27db', 'objective', 'Explain how data is represented in the computer.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('630364ec-82d5-5571-b6e9-f749b20c27db', 'objective', 'Distinguish between data numbers, characters, images and sound.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('630364ec-82d5-5571-b6e9-f749b20c27db', 'objective', 'Outline techniques used to encode numbers, characters, images, and sound.', 'remember', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '93672dfe-15f9-58f1-a27f-80d77c825b9f', (SELECT id FROM target_syllabus), 'b57c82c5-7aa3-5794-aaff-0eabce484433',
  '6f7fbf19-ad41-5f93-a920-119992f27f28',
  45, 45, 'Character and positive integers encoding',
  2, 17, 17,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('93672dfe-15f9-58f1-a27f-80d77c825b9f', 'objective', 'Apply a given character encoding scheme to represent a set of characters Determine the base 2 representation of a positive integer.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '19f0272a-fa30-5370-af35-454bada8c217', (SELECT id FROM target_syllabus), 'b57c82c5-7aa3-5794-aaff-0eabce484433',
  '6f7fbf19-ad41-5f93-a920-119992f27f28',
  46, 46, 'Addition and subtraction in base 2, 8 and 16',
  2, 17, 17,
  true, false, false,
  'content', 51
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('19f0272a-fa30-5370-af35-454bada8c217', 'objective', 'Identify symbols of base 2, 8 and 16.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('19f0272a-fa30-5370-af35-454bada8c217', 'objective', 'Perform addition in any number system.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('19f0272a-fa30-5370-af35-454bada8c217', 'objective', 'Perform subtraction in any number system.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c59a4e62-d94a-5050-9938-e5178c6d716c', (SELECT id FROM target_syllabus), 'b57c82c5-7aa3-5794-aaff-0eabce484433',
  '6f7fbf19-ad41-5f93-a920-119992f27f28',
  47, 47, 'Integration activities',
  2, 17, 17,
  true, false, false,
  'integration_activity', 52
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
  'd5bcb7c6-368e-50b4-baf1-ef96c5420113', (SELECT id FROM target_syllabus), 'b57c82c5-7aa3-5794-aaff-0eabce484433',
  '6f7fbf19-ad41-5f93-a920-119992f27f28',
  NULL, NULL, 'Evaluation',
  2, 18, 18,
  true, false, false,
  'evaluation', 53
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
  'd2840ec8-8583-5af7-b3d2-07ed87f5dd6a', (SELECT id FROM target_syllabus), 'b57c82c5-7aa3-5794-aaff-0eabce484433',
  '6f7fbf19-ad41-5f93-a920-119992f27f28',
  NULL, NULL, 'Remediation',
  2, 18, 18,
  true, false, false,
  'remediation', 54
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
  'a4688826-bb4e-5d1f-ac29-41e6206b23bd', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '8315ac79-ae54-5a89-973a-082fe5028c9f',
  48, 48, 'Input and output peripherals',
  2, 18, 18,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a4688826-bb4e-5d1f-ac29-41e6206b23bd', 'objective', 'Describe RFID readers, QR code readers, OMR readers, OCR readers, and contactless card readers.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a4688826-bb4e-5d1f-ac29-41e6206b23bd', 'objective', 'Describe plotters, 3D printer, and actuators.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a4688826-bb4e-5d1f-ac29-41e6206b23bd', 'objective', 'Choose appropriate input and output peripheral in a given context.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '590dce8b-1552-574d-a4a7-cc479f73c960', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '8315ac79-ae54-5a89-973a-082fe5028c9f',
  49, 49, 'Integration activities',
  2, 19, 19,
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
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '70c956b3-c5a3-5a67-8b1b-ae12b5256c90', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '063973b1-6361-5576-ba1d-22d274b43c15',
  50, 50, 'Using a word processor 1',
  2, 19, 19,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('70c956b3-c5a3-5a67-8b1b-ae12b5256c90', 'objective', 'Produce a formatted word-processed document that makes use of text, tables, graphics, and text boxes.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e153dab1-e418-5c6a-bedf-0a651b771d4f', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '063973b1-6361-5576-ba1d-22d274b43c15',
  51, 51, 'Using a word processor 2',
  2, 19, 19,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e153dab1-e418-5c6a-bedf-0a651b771d4f', 'objective', 'Reproduce a document of at most two pages with the help of a word processor.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c2444e06-9add-542f-bd79-0fd1f4d5b5e2', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '063973b1-6361-5576-ba1d-22d274b43c15',
  52, 52, 'Solve problems with spreadsheets 1',
  2, 20, 20,
  true, false, false,
  'content', 59
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c2444e06-9add-542f-bd79-0fd1f4d5b5e2', 'objective', 'Reproduce the data and formatting applied to a spreadsheet.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c2444e06-9add-542f-bd79-0fd1f4d5b5e2', 'objective', 'Determine appropriate formulas to meet the different goals in a problem.', 'analyse', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '61c99696-8ddb-5067-96d2-f3c014fc51c3', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '063973b1-6361-5576-ba1d-22d274b43c15',
  53, 53, 'Solve problems with spreadsheets 2',
  2, 20, 20,
  true, false, false,
  'content', 60
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61c99696-8ddb-5067-96d2-f3c014fc51c3', 'objective', 'Determine appropriate formulas to meet the different goals in a problem.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61c99696-8ddb-5067-96d2-f3c014fc51c3', 'objective', 'Represent specific spreadsheet data as a given chart.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('61c99696-8ddb-5067-96d2-f3c014fc51c3', 'objective', 'Make use of features of spreadsheets such as sort and filter.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b01237d2-20fd-5f85-9ee2-ea7c8b029fd6', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '063973b1-6361-5576-ba1d-22d274b43c15',
  54, 54, 'Create presentations',
  2, 20, 20,
  true, false, false,
  'content', 61
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b01237d2-20fd-5f85-9ee2-ea7c8b029fd6', 'objective', 'Create simple presentations of at most 5 slides when given a model of the presentation.', 'create', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b01237d2-20fd-5f85-9ee2-ea7c8b029fd6', 'objective', 'Modify a presentation by adding and formatting objects such as images, sound, and videos.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b01237d2-20fd-5f85-9ee2-ea7c8b029fd6', 'objective', 'Create animations using a presentation software that meet a given situation.', 'create', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'be253956-d1aa-5fbc-b205-679b85a45330', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '063973b1-6361-5576-ba1d-22d274b43c15',
  55, 55, 'Create publications',
  2, 21, 21,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be253956-d1aa-5fbc-b205-679b85a45330', 'objective', 'Produce a given publication when given the model of the publication.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'da72e03c-88ef-5f77-af9d-6f105e6cf498', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '063973b1-6361-5576-ba1d-22d274b43c15',
  56, 56, 'Create digital content using generative AI',
  2, 21, 21,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('da72e03c-88ef-5f77-af9d-6f105e6cf498', 'objective', 'Produce word processed documents, presentations, and publications using generative AI tools.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2bcbe4e5-6aa3-5cba-99fa-eb737feb0d2e', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '063973b1-6361-5576-ba1d-22d274b43c15',
  57, 57, 'Integration activities',
  2, 21, 21,
  true, false, false,
  'integration_activity', 64
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
  '00e5c59a-5086-50c1-b5fa-8dd6d51faa4e', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '91928cc7-d9bb-57a0-a8bd-2a8c3974c75e',
  58, 58, 'Assistive technology and disabilities',
  2, 22, 22,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('00e5c59a-5086-50c1-b5fa-8dd6d51faa4e', 'objective', 'Explain the concepts of disability, and assistive technology.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('00e5c59a-5086-50c1-b5fa-8dd6d51faa4e', 'objective', 'Describe common assistive technologies for a given disability.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('00e5c59a-5086-50c1-b5fa-8dd6d51faa4e', 'objective', 'Outline features common to operating systems aimed at helping the disabled.', 'remember', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1688847f-fa23-571d-b60b-70c2100d5758', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '91928cc7-d9bb-57a0-a8bd-2a8c3974c75e',
  59, 59, 'Assistive technologies for the elderly',
  2, 22, 22,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1688847f-fa23-571d-b60b-70c2100d5758', 'objective', 'Explain the importance of assistive technologies for the elderly.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1688847f-fa23-571d-b60b-70c2100d5758', 'objective', 'Describe technologies that can be used to assist the elderly.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'eb1a4c65-d9d9-5da5-9b5b-d3d483a9124d', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '91928cc7-d9bb-57a0-a8bd-2a8c3974c75e',
  60, 60, 'Integration activities',
  2, 22, 22,
  true, false, false,
  'integration_activity', 67
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
  '37c64ca9-3e0e-5da0-b81f-a9f954a92dbd', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '91928cc7-d9bb-57a0-a8bd-2a8c3974c75e',
  NULL, NULL, 'Evaluation',
  2, 23, 23,
  true, false, false,
  'evaluation', 68
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
  'f757004d-10bf-557b-83aa-af2c4d7a47e8', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '91928cc7-d9bb-57a0-a8bd-2a8c3974c75e',
  NULL, NULL, 'Remediation',
  2, 23, 23,
  true, false, false,
  'remediation', 69
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
  'd6ae7020-728a-5845-a567-583db8f2fcc6', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  'e057c48c-6e4d-500f-b789-31f326bf4fbe',
  61, 61, 'Notions on packets',
  2, 23, 23,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6ae7020-728a-5845-a567-583db8f2fcc6', 'objective', 'Explain the concepts packet header, payload, trailer, packet switching.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6ae7020-728a-5845-a567-583db8f2fcc6', 'objective', 'Describe the structure of a packet.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d6ae7020-728a-5845-a567-583db8f2fcc6', 'objective', 'Describe the USB interface and explain mechanisms it uses to transmit data.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ea0790eb-c2f3-5ce2-982d-2c01dabcf251', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  'e057c48c-6e4d-500f-b789-31f326bf4fbe',
  62, 62, 'Error detection and packet security',
  2, 24, 24,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ea0790eb-c2f3-5ce2-982d-2c01dabcf251', 'objective', 'Explain the need to check for errors after data transmission and how these errors occur.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ea0790eb-c2f3-5ce2-982d-2c01dabcf251', 'objective', 'Explain the need for and purpose of encryption when transmitting data.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ea0790eb-c2f3-5ce2-982d-2c01dabcf251', 'objective', 'Describe error detection methods and how data is encrypted.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '766cc2bf-8da1-52e9-b074-8769f5c3e538', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  'e057c48c-6e4d-500f-b789-31f326bf4fbe',
  63, 63, 'Integration activities',
  2, 24, 24,
  true, false, false,
  'integration_activity', 72
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
  '1060e4b2-c82b-571d-88bc-d491e6a9a714', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  '2318c65c-9a89-5d36-bbec-37a0073f80aa',
  64, 64, 'Network hardware',
  2, 24, 24,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1060e4b2-c82b-571d-88bc-d491e6a9a714', 'objective', 'Explain the role of NIC, modem, router, multiplexer, bridge, repeater in a network. Identify hardware needed for internet connectivity in a house, school or organizational network.', 'understand', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '07a421b5-832a-51f5-a401-9f37f6b35d76', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  '2318c65c-9a89-5d36-bbec-37a0073f80aa',
  65, 65, 'Network IP configuration',
  3, 25, 25,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07a421b5-832a-51f5-a401-9f37f6b35d76', 'objective', 'State the purpose of MAC address and IP address.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07a421b5-832a-51f5-a401-9f37f6b35d76', 'objective', 'Differentiate between IPv4 and IPv6 addresses.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07a421b5-832a-51f5-a401-9f37f6b35d76', 'objective', 'Compare static ip addresses to dynamic ip addresses.', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07a421b5-832a-51f5-a401-9f37f6b35d76', 'objective', 'Explain the purpose of configuring ip addresses on a LAN.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c5458ba0-7f95-5f84-9cfa-2bb3dc6b0811', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  '2318c65c-9a89-5d36-bbec-37a0073f80aa',
  66, 66, 'Integration activities',
  3, 25, 25,
  true, false, false,
  'integration_activity', 75
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
  'fe9eb0b8-5a96-5384-a3bc-c5adf7fc9d25', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214',
  '7d9101e7-22d4-5580-a0d0-fd5a67a96351',
  67, 67, 'Notions on security',
  3, 25, 25,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fe9eb0b8-5a96-5384-a3bc-c5adf7fc9d25', 'objective', 'Differentiate between computer security, data security, and network security.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fe9eb0b8-5a96-5384-a3bc-c5adf7fc9d25', 'objective', 'Differentiate between vulnerability, threat, and attack.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fe9eb0b8-5a96-5384-a3bc-c5adf7fc9d25', 'objective', 'Identify three security objectives Identify common vulnerabilities linked to data, computers, or networks in a given context.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2e5f4255-f909-5536-abc2-7a9875e6f10c', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214',
  '7d9101e7-22d4-5580-a0d0-fd5a67a96351',
  68, 68, 'Threats and attacks on computer systems',
  3, 26, 26,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2e5f4255-f909-5536-abc2-7a9875e6f10c', 'objective', 'Identify common threats on data, computers, and networks.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2e5f4255-f909-5536-abc2-7a9875e6f10c', 'objective', 'Describe common attacks on data, computers, and networks.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2e5f4255-f909-5536-abc2-7a9875e6f10c', 'objective', 'Describe the different types of malware.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f3a9c8b8-bb41-5993-9669-0d22d0fc1a17', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214',
  '7d9101e7-22d4-5580-a0d0-fd5a67a96351',
  69, 69, 'Data, computer, and network security measures',
  3, 26, 26,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f3a9c8b8-bb41-5993-9669-0d22d0fc1a17', 'objective', 'Explain measures to secure data.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f3a9c8b8-bb41-5993-9669-0d22d0fc1a17', 'objective', 'Explain measures to secure a computer.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f3a9c8b8-bb41-5993-9669-0d22d0fc1a17', 'objective', 'Explain measures to secure a network.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f3a9c8b8-bb41-5993-9669-0d22d0fc1a17', 'objective', 'Outline common data recovery strategies.', 'remember', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6b7b2d64-f4ff-58b7-b9b9-169e44bdac58', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214',
  '7d9101e7-22d4-5580-a0d0-fd5a67a96351',
  70, 70, 'Integration activities',
  3, 26, 26,
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
  '6b57b1b4-3823-5dd0-9eb8-edf99ece27c5', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214',
  '0c7ff2e1-a9f3-54a4-befe-85e0fd3fafc1',
  NULL, NULL, 'Evaluation',
  3, 27, 27,
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
  'c1b5a68b-bab8-5ef5-bc86-ad07f6f2b6f3', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214',
  '0c7ff2e1-a9f3-54a4-befe-85e0fd3fafc1',
  NULL, NULL, 'Remediation',
  3, 27, 27,
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
  'afaad3d2-ebb4-536c-8022-186d26238778', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214',
  '0c7ff2e1-a9f3-54a4-befe-85e0fd3fafc1',
  71, 71, 'Notions on digital identities and digital footprints',
  3, 27, 27,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('afaad3d2-ebb4-536c-8022-186d26238778', 'objective', 'Explain the following concepts: digital identity, password, username, identity theft, digital footprint, passive and active digital footprint.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('afaad3d2-ebb4-536c-8022-186d26238778', 'objective', 'Explain characteristics of a good password Explain ways that a user creates passive and active digital footprints.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '008b2482-5d2b-5613-b0ae-123dace51479', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214',
  '0c7ff2e1-a9f3-54a4-befe-85e0fd3fafc1',
  72, 72, 'Digital identities and footprints management',
  3, 28, 28,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('008b2482-5d2b-5613-b0ae-123dace51479', 'objective', 'Outline best practices to manage multiple digital identities.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('008b2482-5d2b-5613-b0ae-123dace51479', 'objective', 'State positive and negative effects of digital footprints.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('008b2482-5d2b-5613-b0ae-123dace51479', 'objective', 'Explain ways of protecting digital footprints.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6341bbb8-3d98-5777-885d-1607556c5756', (SELECT id FROM target_syllabus), 'be83a247-8136-5bcb-8b44-00157af86214',
  '0c7ff2e1-a9f3-54a4-befe-85e0fd3fafc1',
  73, 73, 'Integration activities',
  3, 28, 28,
  true, false, false,
  'integration_activity', 84
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
  'aa94fd14-e82f-548b-b7d3-c1de496fb1d0', (SELECT id FROM target_syllabus), 'ae91ff23-61c6-54d4-8826-f50665eee233',
  '39f52bd2-576e-5d17-bd34-f710b0248ce5',
  74, 74, 'Logic gates',
  3, 28, 28,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('aa94fd14-e82f-548b-b7d3-c1de496fb1d0', 'objective', 'Identify various logic gates.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('aa94fd14-e82f-548b-b7d3-c1de496fb1d0', 'objective', 'Describe the different types of logic gates Draw the truth table for a logic gate.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2ca54430-3e4f-5b6c-807e-abef57561679', (SELECT id FROM target_syllabus), 'ae91ff23-61c6-54d4-8826-f50665eee233',
  '39f52bd2-576e-5d17-bd34-f710b0248ce5',
  75, 75, 'Logic circuits and expressions',
  3, 29, 29,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ca54430-3e4f-5b6c-807e-abef57561679', 'objective', 'Identify logic gates in a circuit or an expression.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ca54430-3e4f-5b6c-807e-abef57561679', 'objective', 'Produce the truth table or a logic circuit or expression.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ca54430-3e4f-5b6c-807e-abef57561679', 'objective', 'Produce a logic circuit when given a logic expression.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '718e9e08-eefc-5ac0-bfab-816ce8c38144', (SELECT id FROM target_syllabus), 'ae91ff23-61c6-54d4-8826-f50665eee233',
  '39f52bd2-576e-5d17-bd34-f710b0248ce5',
  76, 76, 'De Morgan''s law and Boolean simplification',
  3, 29, 29,
  true, false, false,
  'content', 87
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('718e9e08-eefc-5ac0-bfab-816ce8c38144', 'objective', 'State the De Morgan''s laws.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('718e9e08-eefc-5ac0-bfab-816ce8c38144', 'objective', 'Identify situations where De Morgan''s law can be used.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('718e9e08-eefc-5ac0-bfab-816ce8c38144', 'objective', 'State common laws of Boolean simplification.', 'remember', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0cfdbd79-f9cb-5d0d-8980-5e3aa3342e33', (SELECT id FROM target_syllabus), 'ae91ff23-61c6-54d4-8826-f50665eee233',
  '39f52bd2-576e-5d17-bd34-f710b0248ce5',
  77, 77, 'Integration activities',
  3, 29, 29,
  true, false, false,
  'integration_activity', 88
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
  '457a8078-46bf-54e2-a333-b9f9e202adeb', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '6c84227d-049c-5332-b809-0b38b62530f3',
  78, 78, 'Storage and processing devices',
  3, 30, 30,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('457a8078-46bf-54e2-a333-b9f9e202adeb', 'objective', 'Describe processing and storage devices.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('457a8078-46bf-54e2-a333-b9f9e202adeb', 'objective', 'Describe the machine instruction cycle.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4661f764-80a6-5ee6-87b5-baf7d81f248a', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '6c84227d-049c-5332-b809-0b38b62530f3',
  79, 79, 'Other internal components',
  3, 30, 30,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4661f764-80a6-5ee6-87b5-baf7d81f248a', 'objective', 'State the main ports on the motherboard.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4661f764-80a6-5ee6-87b5-baf7d81f248a', 'objective', 'Describe the different types of bus.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4661f764-80a6-5ee6-87b5-baf7d81f248a', 'objective', 'State the role of the CMOS and battery.', 'remember', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '86ea5ce5-098b-5b71-b624-12f0c3b56531', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '6c84227d-049c-5332-b809-0b38b62530f3',
  80, 80, 'Integration activities',
  3, 30, 30,
  true, false, false,
  'integration_activity', 91
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
  'ea86a980-3484-5aab-a21e-f0e011202b9b', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  'ff4f0be6-8728-52b1-b276-05d8ae6d7533',
  81, 81, 'Notions on the internet',
  3, 31, 31,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ea86a980-3484-5aab-a21e-f0e011202b9b', 'objective', 'Explain the concepts of internet, intranet, extranet, protocol.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ea86a980-3484-5aab-a21e-f0e011202b9b', 'objective', 'Outline advantages and disadvantages of the internet.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ea86a980-3484-5aab-a21e-f0e011202b9b', 'objective', 'Explain the role of ISP and browsers in accessing the internet. Describe the importance of URL and its nomenclature.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6eb51bb2-1714-5163-935b-8eacdad7e547', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  'ff4f0be6-8728-52b1-b276-05d8ae6d7533',
  82, 82, 'Notions on digital currency',
  3, 31, 31,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6eb51bb2-1714-5163-935b-8eacdad7e547', 'objective', 'Outline common internet services.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6eb51bb2-1714-5163-935b-8eacdad7e547', 'objective', 'Explain the concept of digital currencies and how they are used.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6eb51bb2-1714-5163-935b-8eacdad7e547', 'objective', 'State examples of digital currencies.', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6eb51bb2-1714-5163-935b-8eacdad7e547', 'objective', 'Explain the process of block chain and how it is used to track digital currency transactions.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '496b71d3-f204-5edc-8e90-85ebec65b06d', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  'ff4f0be6-8728-52b1-b276-05d8ae6d7533',
  83, 83, 'Web authoring services',
  3, 31, 31,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('496b71d3-f204-5edc-8e90-85ebec65b06d', 'objective', 'Outline examples of web authoring tools.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('496b71d3-f204-5edc-8e90-85ebec65b06d', 'objective', 'State the role of HTML.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('496b71d3-f204-5edc-8e90-85ebec65b06d', 'objective', 'Build a simple web page using HTML and CSS.', 'create', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '43f1b5f9-0195-5ec9-958b-efe97e37e2e4', (SELECT id FROM target_syllabus), '1dfa7753-f563-557f-97a6-69478902daef',
  'ff4f0be6-8728-52b1-b276-05d8ae6d7533',
  84, 84, 'Integration activities',
  3, 32, 32,
  true, false, false,
  'integration_activity', 95
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
  '3d03ea7d-13be-593f-977b-add22af9c37d', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '2f2f678d-3028-5a88-b97a-4f0ec3d656d3',
  85, 85, 'Types of application software',
  3, 32, 32,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3d03ea7d-13be-593f-977b-add22af9c37d', 'objective', 'Describe common application software for productivity, personal interest, graphics and media, and communication and collaboration. Choose application software for a given situation.', 'understand', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e2daf4e9-608e-51c5-882f-708f1230e8e8', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  '2f2f678d-3028-5a88-b97a-4f0ec3d656d3',
  86, 86, 'Integration activities',
  3, 32, 32,
  true, false, false,
  'integration_activity', 97
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
  'c4fff1f2-59c0-56ec-832f-017c65402795', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  'd234982c-0c81-5986-9cfb-061e8876a7e6',
  87, 87, 'Methods to obtain software',
  3, 33, 33,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c4fff1f2-59c0-56ec-832f-017c65402795', 'objective', 'Describe the different methods of obtaining software Choose appropriate method to obtain software.', 'understand', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '14dc362a-76fd-5aff-a236-53f561180e52', (SELECT id FROM target_syllabus), 'df4137a6-5a80-5b98-b667-dda47cb185c5',
  'd234982c-0c81-5986-9cfb-061e8876a7e6',
  88, 88, 'Integration activities',
  3, 33, 33,
  true, false, false,
  'integration_activity', 99
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
  '882f7a8d-dd7b-5c0f-9453-a8f8b1de02fd', (SELECT id FROM target_syllabus), 'b8bc06cc-9f8a-5904-8f9f-5746140bef4b',
  'de3308d3-d130-5748-a357-767930a51948',
  89, 89, 'Protecting Intellectual property',
  3, 33, 33,
  true, false, false,
  'content', 100
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('882f7a8d-dd7b-5c0f-9453-a8f8b1de02fd', 'objective', 'Explain the concepts of intellectual property, trademark, patent, copyright, license…', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('882f7a8d-dd7b-5c0f-9453-a8f8b1de02fd', 'objective', 'Identify the freedoms provided by a given type of license.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('882f7a8d-dd7b-5c0f-9453-a8f8b1de02fd', 'objective', 'State possible national and international consequences of non-respect of intellectual property.', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('882f7a8d-dd7b-5c0f-9453-a8f8b1de02fd', 'objective', 'Identify exceptions and legal limitations of using and sharing copyrighted content.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fd15c93c-f2ab-5abb-94ae-2692eb5804b7', (SELECT id FROM target_syllabus), 'b8bc06cc-9f8a-5904-8f9f-5746140bef4b',
  'de3308d3-d130-5748-a357-767930a51948',
  90, 90, 'Assigning and respecting digital licenses',
  3, 34, 34,
  true, false, false,
  'content', 101
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fd15c93c-f2ab-5abb-94ae-2692eb5804b7', 'objective', 'Match each type of creative common license to a given permission.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fd15c93c-f2ab-5abb-94ae-2692eb5804b7', 'objective', 'Explain ways of identifying free and copyrighted digital content.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fd15c93c-f2ab-5abb-94ae-2692eb5804b7', 'objective', 'State platforms where free digital content can be found.', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fd15c93c-f2ab-5abb-94ae-2692eb5804b7', 'objective', 'State ways of sharing and using digital content legally.', 'remember', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c83aac51-d0b1-5c6a-bbc7-6eee2114493e', (SELECT id FROM target_syllabus), 'b8bc06cc-9f8a-5904-8f9f-5746140bef4b',
  'de3308d3-d130-5748-a357-767930a51948',
  91, 91, 'Integration activities',
  3, 34, 34,
  true, false, false,
  'integration_activity', 102
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
  '1d8b0d06-bb1b-5a4b-b716-17a637bc8e21', (SELECT id FROM target_syllabus), 'b8bc06cc-9f8a-5904-8f9f-5746140bef4b',
  'de3308d3-d130-5748-a357-767930a51948',
  NULL, NULL, 'Evaluation',
  3, 34, 34,
  true, false, false,
  'evaluation', 103
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
  'ada76e9f-c688-568f-a4fb-fc91a41e5445', (SELECT id FROM target_syllabus), 'b8bc06cc-9f8a-5904-8f9f-5746140bef4b',
  'de3308d3-d130-5748-a357-767930a51948',
  NULL, NULL, 'Remediation',
  3, 35, 35,
  true, false, false,
  'remediation', 104
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
  'f518b94b-edd7-5af7-87f3-c975bb888289', (SELECT id FROM target_syllabus), 'b8bc06cc-9f8a-5904-8f9f-5746140bef4b',
  NULL,
  NULL, NULL, 'Revision',
  3, 35, 36,
  true, false, false,
  'revision', 105
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
