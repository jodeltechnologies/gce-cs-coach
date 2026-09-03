-- National Harmonised Lower Sixth Progression Sheet for Information & Communication Technology
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

INSERT INTO subjects (name) VALUES ('Information and Communication Technology') ON CONFLICT (name) DO NOTHING;
INSERT INTO levels (name, short_name) VALUES ('GCE Advanced Level', 'A/L') ON CONFLICT (name) DO NOTHING;

DROP TABLE IF EXISTS target_syllabus;
CREATE TEMP TABLE target_syllabus AS
SELECT s.id FROM syllabi s
 WHERE s.form_level = 'Lower Sixth' AND s.deleted_at IS NULL
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
  'b1d5eedc-70f1-4c68-b4ae-7de9e311fc1c',
  (SELECT id FROM subjects WHERE name = 'Information and Communication Technology'),
  (SELECT id FROM levels   WHERE name = 'GCE Advanced Level'),
  'National Harmonised Lower Sixth Progression Sheet for Information & Communication Technology', 'Lower Sixth', 'Inspectorate General of Education, Inspectorate of Pedagogy in charge of the Teaching of Computer Science',
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
 WHERE s.form_level = 'Lower Sixth' AND s.deleted_at IS NULL
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
  ('4146a719-7f22-59fe-abdc-370b4633e42e'),
  ('defac6bf-3000-5843-8fc4-95f45f6edd27'),
  ('1e29f9be-bd8d-5669-baac-cff04bc57eec'),
  ('0b1bbe1d-fe59-5b14-8fc2-762ed3b57b37'),
  ('ac6a40b7-279c-58bb-8c2f-8abfd1662e11'),
  ('a882c73e-4402-56b8-996e-59ce7daed66b'),
  ('3fcc0e62-49c6-5b68-b542-6862e1140aa9'),
  ('3771d1ea-be70-5391-b30a-9c83e9f6fc2d'),
  ('7ff2f57a-1761-5e72-8dc1-154ea499043c'),
  ('276977f5-86e8-51a7-9538-3db12650e981'),
  ('c8cb5943-a818-54e6-89dd-401e9056728a'),
  ('ec50d70e-8b7c-5f8f-8ad6-6ffa64c123b5'),
  ('57ad17ad-5d87-593f-98e1-c7bdea64e962'),
  ('ec28cc07-b74e-5517-a3db-9ffbfd3834ce'),
  ('ad33a160-4ae5-5fd4-9b5b-1ff6ff0434c9'),
  ('250577d6-261c-5209-b4fd-991b30fe7e4d'),
  ('2562c6d1-ac6e-5099-a1cd-d3c3517ca996'),
  ('8e0cfa56-b7ec-500a-8da8-d7a0eecf6ea0'),
  ('36462e43-bc26-5e16-b9d8-d097463eff4a'),
  ('7566e640-bf53-5c85-b582-64ad742266d7'),
  ('b20be4ef-377b-55a0-a8d7-1344eeafd534'),
  ('32d4b7d1-f281-54c2-9a4c-e9997b577596'),
  ('7c6d2c94-c52a-51f7-8186-eddf5a52b95c'),
  ('def13e76-2dca-5abc-9b85-1bdf3d087af0'),
  ('03b1272a-06a4-5c6a-be44-4ccaf816fd7b'),
  ('502d2d2f-ef56-52b6-a915-c75e97618bba'),
  ('13494487-0588-5fc5-adcb-21d95c78db0d'),
  ('07a2154c-4110-5833-821c-1c9332fce7f3'),
  ('25d7af29-a68b-5ba5-8b86-a41811a70679'),
  ('7024e4d4-a79d-5dd7-9a80-764e519696f6'),
  ('c97e8511-58a9-545c-9c01-9b1fc1656a9c'),
  ('93254295-9f6c-5238-9bb9-cb47894d2f00'),
  ('d0b7018a-f6c9-50b9-9713-41d6a01920e0'),
  ('fb3f9398-226a-5de2-af56-170cbeed9780'),
  ('b1a6c8ab-6afd-5734-a976-1c6c9a5ee005'),
  ('4bc9ce68-1497-50ff-b6d2-8fa266f881de'),
  ('34cce036-4f2e-5d80-a7de-fbad068f1c81'),
  ('3933f789-586e-57f4-9551-911df0e07217'),
  ('c9298c23-1c26-5994-9900-268f2b78489f'),
  ('ea802248-d8c8-5986-b85b-a3134e39fd50'),
  ('1a6bd6e4-b6a9-5bc2-8284-a73ecffae1e2'),
  ('76fc8526-9ee4-559f-ab0c-47813a1aaa83'),
  ('f40f3006-21a2-5756-86d1-01ae04a130b8'),
  ('55450b04-3caa-59b4-80f4-fb6c10937866'),
  ('575140f4-faec-582c-94d2-bd88fbce08d7'),
  ('82c0cd33-437e-58ad-8c7d-1717a2d08092'),
  ('2bdb3aba-0d8b-5555-a18e-b411c81acf61'),
  ('133ba569-70b5-5165-ada0-3e1119eccf1e'),
  ('ed586cb6-2e80-5a66-abb3-bcce2b0a0420'),
  ('f5b2a9e6-bcad-502e-ae74-3d828e05a140'),
  ('e43edb97-bb27-5fe3-95a4-89fb7845a5b9'),
  ('e7998683-e61d-5c25-9ce8-9eed9c01799f'),
  ('977b0a05-d65f-5d1e-adac-00363bfb6e3e'),
  ('18a37fc0-9adf-570f-aa10-fef40e3a0cc7'),
  ('8287fe7b-e6e0-5701-9c52-e66f2f3bb8cb'),
  ('c458013c-ffd6-56e0-9caf-7305135c9574'),
  ('ac66daa8-6932-5178-8921-65f0796911ea'),
  ('8037984e-af47-5d7a-8dce-a0b4eb70a2e6'),
  ('7577135d-c436-572b-ba21-b86bbdfbd29d'),
  ('2abdc0da-f59a-5c9c-babb-5c056f65044f'),
  ('67d5cc64-94d4-539e-8708-4b0a8e588cf3'),
  ('b25cadc1-131f-5590-b8c7-bfc133297f1b'),
  ('e1f4f5b9-853b-5890-8e8f-d044d1ae2be9'),
  ('04515d2a-bb3e-5d53-b6d5-f64a4e879bf7'),
  ('3db06467-6f52-5f7f-ab98-cfd539771d0c'),
  ('5cefd3a4-8e72-562c-9322-8c28038ed69d'),
  ('f7abf33b-eb78-5f74-8443-af8c18ca930c'),
  ('1f57d02a-4ee6-5b86-a4b0-3a25856bb26d'),
  ('d772cdac-1913-5620-b1ea-a9c0812b5c1f'),
  ('580591ac-c50b-51b2-b1e6-b19b332834a0'),
  ('10ba0519-f583-5aa7-a9a3-2a407be70704'),
  ('0b749b3a-042a-5b2f-b28b-9ad6e8d66b68'),
  ('efd16fa2-a187-5fb9-aae0-bc240ea5e5a6'),
  ('bf9777ad-57a2-57cd-bfe5-5aed8e6f6932'),
  ('45366509-0993-5c35-9920-3fb341f0b333'),
  ('053d2a10-48a7-5682-9725-4e389505547a'),
  ('25ac369c-eef6-591c-8e4c-226f65a6b546'),
  ('d8b19cce-7b4e-5f61-9eb8-fb1e9b85054a'),
  ('daed1695-f6d8-5316-87ea-4e715bfc3197'),
  ('b4778cb6-d19f-5f20-8ec0-598f222a06e9'),
  ('02b219b2-fca9-53cd-9362-0c723ad50982'),
  ('2f5fd5a3-e9a0-547e-a499-bc428a5f88f8'),
  ('75541fc4-e26b-5764-8757-3cde7c444ec9'),
  ('7cab8797-7518-579d-ae23-ad7a45e40bed'),
  ('c89fa51a-73d1-592d-8fc4-be67a5307794'),
  ('a7b69421-821f-5acb-a206-67e580cceae2'),
  ('1e74c24f-936b-52ae-8f69-da716df1f460'),
  ('807fd404-e36e-53c7-aeb4-a01259217bef'),
  ('2ff82afc-948c-552f-ad7b-e9d7632786bc'),
  ('85064535-c45c-5683-bbe9-4ed4a629d271'),
  ('8a315fa7-2be1-5c47-b327-1f3c865cc3a1'),
  ('89335fc8-06e8-5a30-a810-2c6c3a13104f'),
  ('d74e4ecd-cc01-59ee-9fb7-d2116d358f98'),
  ('3af33401-bd4d-5f18-be45-82efa610ef9d'),
  ('0675ba71-689f-5055-a86e-988b44f204b5'),
  ('e3df1dfc-82fa-5261-adc6-4f448106d8f5'),
  ('1f240df6-f563-55fc-a25a-737371a162f5'),
  ('2a0dcd22-fc89-5ef1-babc-af837b411dae'),
  ('9050ff22-3b26-5f6e-959c-da6b2ce4cef0'),
  ('090d233e-f8b5-57e2-9124-a788f3c9a953'),
  ('87b746de-e15c-5ecd-aaf3-71b78c44dd95'),
  ('0230bd6e-5ad6-5ea6-b4ad-99ca63e6fadf'),
  ('740c4748-0551-5d26-abc7-88dc5d230476'),
  ('90ad241c-0b77-51d2-894d-6ff0bf740716'),
  ('26bb72a0-879a-5fd2-8e1d-d4a1002320e8'),
  ('432bfe2f-0b27-5c5c-bf66-b8b33ece5ec9'),
  ('1aa282ed-2c8f-56cf-b0d7-8e1f96c61549'),
  ('6c319b75-fe57-563c-8bab-57538f50c983'),
  ('3be9132f-5389-59d7-88a4-9f3d8fcf32cf'),
  ('48ebc7e6-8b9e-5665-8a9b-35d5ca7688a2'),
  ('53a3e043-d136-5ca8-a1d4-6dc5e7afd43a'),
  ('33d59e1f-4892-5cd6-bbb8-d52d635d866e'),
  ('196cf332-121b-5aba-ac2a-24cba302622d'),
  ('be852494-7c87-5e04-a257-1b99ea3bec3c'),
  ('efacb5d1-146c-5e28-a7c7-f2371f4e70f4'),
  ('020d7563-9060-5407-9aff-faa3a9896fd4'),
  ('a230e376-6614-52ab-8f91-60ec94ff3fde'),
  ('d747fb28-8e7d-58fd-a114-d14016d70f07'),
  ('34a0537c-4078-5228-8332-3e0ee7cf9473'),
  ('e58ea640-a2fe-5a58-9b97-5db645aed024'),
  ('048e6fd1-ba47-582c-a0c2-3daa7bd9c3d5'),
  ('6a5d140b-1f59-5026-9250-132298b2c8f0'),
  ('61bdfa2e-5fcf-51ad-93e9-f9db71bad032'),
  ('3431f40e-24f7-529b-82fa-862b45cc448a'),
  ('3017c889-fb7a-53fb-a6c0-ae5afdba3069');

DROP TABLE IF EXISTS new_comp_ids;
CREATE TEMP TABLE new_comp_ids (id UUID PRIMARY KEY);
INSERT INTO new_comp_ids (id) VALUES
  ('65ac05e3-a835-5772-920f-8a919b919fd6'),
  ('830acb3a-4573-5563-9cda-43602aa2fd30'),
  ('44b5cf57-a434-5c4f-bcc7-707deb75dba0'),
  ('af1eb006-e993-5b7a-9adf-a5b35f2f9675'),
  ('0666fd6c-f109-5674-9bf2-1df9a86a4455'),
  ('31af8d70-30f8-50b4-9b0c-2c0891157ffb'),
  ('10e83d61-1765-5e26-a605-f8d17d8d6733'),
  ('993300b1-eb0c-5fd2-adf3-ce9054db7ae3'),
  ('52e21c21-52c0-552e-ac0b-8f57dab65dbd'),
  ('8b731be1-5f87-5408-a5bc-d50434791e0a'),
  ('4382cb4f-68be-5032-907b-4d1eed4eefaa'),
  ('caaac11e-b955-53bf-a70d-8c4f81a38dc7'),
  ('1fb28a5a-011f-598d-a0d2-f99d0e41155c'),
  ('166d5a9b-4ea3-5087-87f8-cd35abf03e24'),
  ('c9785f29-72ff-5342-b8d3-54cc48031baf'),
  ('f10ac2bc-d88a-559f-8589-22e3474f0415'),
  ('a60b7173-21a6-5d56-8660-147722e05933'),
  ('058df9b2-0004-583a-b7c2-295fac317f2c'),
  ('2669441c-d28a-5263-9573-dcd185ec34e0'),
  ('89d29b21-7f91-5bb5-b490-4cf26298f774'),
  ('d330ecdb-a288-5bb1-b280-032796a90f61'),
  ('e1036e41-be20-5f29-b943-18298e4af913'),
  ('b7db2566-60df-540e-a8fc-a03089929f1a'),
  ('f2fbc32f-b43b-544a-9bee-83faa31da178'),
  ('c1597efa-27c6-5b16-85f0-4fd053988465'),
  ('6c6f4f78-d9e8-58f0-9640-96df4f295b36');

DROP TABLE IF EXISTS new_module_ids;
CREATE TEMP TABLE new_module_ids (id UUID PRIMARY KEY);
INSERT INTO new_module_ids (id) VALUES
  ('9d8c1629-d8e2-5770-8a24-d3d706d0737d'),
  ('2f0e60c8-d69c-5445-bc16-31925a7d6d8e'),
  ('3de0008f-bcac-5962-bbda-493c5b336cae'),
  ('4ec0615d-ca9c-5b3c-8105-8eadaf108c60');

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
  subject_id = (SELECT id FROM subjects WHERE name = 'Information and Communication Technology'),
  level_id   = (SELECT id FROM levels   WHERE name = 'GCE Advanced Level'),
  title = 'National Harmonised Lower Sixth Progression Sheet for Information & Communication Technology',
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

INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('9d8c1629-d8e2-5770-8a24-d3d706d0737d', (SELECT id FROM target_syllabus), 'Computing Systems and Components', 1)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('2f0e60c8-d69c-5445-bc16-31925a7d6d8e', (SELECT id FROM target_syllabus), 'Impacting society with digital technologies', 2)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('3de0008f-bcac-5962-bbda-493c5b336cae', (SELECT id FROM target_syllabus), 'Practical Problem solving in the digital world', 3)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO modules (id, syllabus_id, title, sequence) VALUES ('4ec0615d-ca9c-5b3c-8105-8eadaf108c60', (SELECT id FROM target_syllabus), 'Building ICT systems', 4)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();

INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('65ac05e3-a835-5772-920f-8a919b919fd6', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d', 'History and Evolution of Computing', NULL, 1)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('830acb3a-4573-5563-9cda-43602aa2fd30', (SELECT id FROM target_syllabus), '2f0e60c8-d69c-5445-bc16-31925a7d6d8e', 'Exploring AI Concepts', NULL, 2)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('44b5cf57-a434-5c4f-bcc7-707deb75dba0', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d', 'Description of computing trends and categorization of computers', NULL, 3)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('af1eb006-e993-5b7a-9adf-a5b35f2f9675', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d', 'Hardware and Categorisation of Hardware components', NULL, 4)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('0666fd6c-f109-5674-9bf2-1df9a86a4455', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d', 'Computer Software', NULL, 5)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('31af8d70-30f8-50b4-9b0c-2c0891157ffb', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d', 'Operating Systems', NULL, 6)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('10e83d61-1765-5e26-a605-f8d17d8d6733', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d', 'Hardware and Software Maintenance', NULL, 7)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('993300b1-eb0c-5fd2-adf3-ce9054db7ae3', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d', 'Assistive technologies and computer ergonomics', NULL, 8)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('52e21c21-52c0-552e-ac0b-8f57dab65dbd', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d', 'Using a word processor', NULL, 9)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('8b731be1-5f87-5408-a5bc-d50434791e0a', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae', 'Using electronic spreadsheets', NULL, 10)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('4382cb4f-68be-5032-907b-4d1eed4eefaa', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae', 'Digital Citizenship and Ethics', NULL, 11)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('caaac11e-b955-53bf-a70d-8c4f81a38dc7', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae', 'Cybersecurity', NULL, 12)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('1fb28a5a-011f-598d-a0d2-f99d0e41155c', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae', 'Description of Systems', NULL, 13)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('166d5a9b-4ea3-5087-87f8-cd35abf03e24', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae', 'Information Systems and Data processing', NULL, 14)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('c9785f29-72ff-5342-b8d3-54cc48031baf', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae', 'Artificial Intelligence and emerging technologies', NULL, 15)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('f10ac2bc-d88a-559f-8589-22e3474f0415', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'SDLC and SDLC models', NULL, 16)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('a60b7173-21a6-5d56-8660-147722e05933', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Modelling Data in an Information System', NULL, 17)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('058df9b2-0004-583a-b7c2-295fac317f2c', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Software Testing', NULL, 18)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('2669441c-d28a-5263-9573-dcd185ec34e0', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Representing numbers', NULL, 19)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('89d29b21-7f91-5bb5-b490-4cf26298f774', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Building Logic Circuits', NULL, 20)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('d330ecdb-a288-5bb1-b280-032796a90f61', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Developing Software — Data Types and Structures', NULL, 21)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('e1036e41-be20-5f29-b943-18298e4af913', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Designing Software', NULL, 22)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('b7db2566-60df-540e-a8fc-a03089929f1a', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Writing and Testing Algorithms', NULL, 23)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('f2fbc32f-b43b-544a-9bee-83faa31da178', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Programming Paradigms and Software Reuse', NULL, 24)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('c1597efa-27c6-5b16-85f0-4fd053988465', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Implementing algorithms', NULL, 25)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();
INSERT INTO competencies (id, syllabus_id, module_id, category_of_action, competency_statement, sequence) VALUES ('6c6f4f78-d9e8-58f0-9640-96df4f295b36', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60', 'Writing functions and testing a developed program', NULL, 26)
ON CONFLICT (id) DO UPDATE SET module_id = EXCLUDED.module_id, category_of_action = EXCLUDED.category_of_action, competency_statement = EXCLUDED.competency_statement, sequence = EXCLUDED.sequence, deleted_at = NULL, updated_at = now();

-- Objectives are rebuilt wholesale rather than matched: they are the
-- Ministry's text and carry nothing of the teacher's.
DELETE FROM objectives WHERE lesson_id IN (SELECT id FROM new_lesson_ids);

INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4146a719-7f22-59fe-abdc-370b4633e42e', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '65ac05e3-a835-5772-920f-8a919b919fd6',
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
  'defac6bf-3000-5843-8fc4-95f45f6edd27', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '65ac05e3-a835-5772-920f-8a919b919fd6',
  1, 1, 'History and Evolution of Computing',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('defac6bf-3000-5843-8fc4-95f45f6edd27', 'objective', 'Identify the generations of computers and the main technology used in each period.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('defac6bf-3000-5843-8fc4-95f45f6edd27', 'objective', 'Compare characteristics such as size, processing capability and price across generations.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('defac6bf-3000-5843-8fc4-95f45f6edd27', 'objective', 'Differentiate between the Von Neumann and Harvard architecture.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('defac6bf-3000-5843-8fc4-95f45f6edd27', 'objective', 'Explain the stored program concept.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1e29f9be-bd8d-5669-baac-cff04bc57eec', (SELECT id FROM target_syllabus), '2f0e60c8-d69c-5445-bc16-31925a7d6d8e',
  '830acb3a-4573-5563-9cda-43602aa2fd30',
  2, 2, 'Introduction to Artificial Intelligence (AI)',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e29f9be-bd8d-5669-baac-cff04bc57eec', 'objective', 'Define AI and explain its history and evolution.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e29f9be-bd8d-5669-baac-cff04bc57eec', 'objective', 'Identify and describe the main types of AI.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e29f9be-bd8d-5669-baac-cff04bc57eec', 'objective', 'Explain common applications of AI.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0b1bbe1d-fe59-5b14-8fc2-762ed3b57b37', (SELECT id FROM target_syllabus), '2f0e60c8-d69c-5445-bc16-31925a7d6d8e',
  '830acb3a-4573-5563-9cda-43602aa2fd30',
  3, 3, 'AI Ethics and Responsible Use',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0b1bbe1d-fe59-5b14-8fc2-762ed3b57b37', 'objective', 'Explain ethical issues associated with AI.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0b1bbe1d-fe59-5b14-8fc2-762ed3b57b37', 'objective', 'Examine the potential risks and benefits of AI.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0b1bbe1d-fe59-5b14-8fc2-762ed3b57b37', 'objective', 'Discuss principles for the responsible use of AI.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ac6a40b7-279c-58bb-8c2f-8abfd1662e11', (SELECT id FROM target_syllabus), '2f0e60c8-d69c-5445-bc16-31925a7d6d8e',
  '830acb3a-4573-5563-9cda-43602aa2fd30',
  4, 4, 'AI Techniques and Intelligent Systems',
  1, 1, 1,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ac6a40b7-279c-58bb-8c2f-8abfd1662e11', 'objective', 'Describe common AI techniques and their applications.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ac6a40b7-279c-58bb-8c2f-8abfd1662e11', 'objective', 'Explain the characteristics of intelligent systems.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ac6a40b7-279c-58bb-8c2f-8abfd1662e11', 'objective', 'Compare AI techniques and intelligent systems based on their applications.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a882c73e-4402-56b8-996e-59ce7daed66b', (SELECT id FROM target_syllabus), '2f0e60c8-d69c-5445-bc16-31925a7d6d8e',
  '830acb3a-4573-5563-9cda-43602aa2fd30',
  5, 5, 'Machine Learning',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a882c73e-4402-56b8-996e-59ce7daed66b', 'objective', 'Define Machine Learning.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a882c73e-4402-56b8-996e-59ce7daed66b', 'objective', 'Explain the basic principles of Machine Learning.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a882c73e-4402-56b8-996e-59ce7daed66b', 'objective', 'Distinguish between supervised, unsupervised and reinforcement learning.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3fcc0e62-49c6-5b68-b542-6862e1140aa9', (SELECT id FROM target_syllabus), '2f0e60c8-d69c-5445-bc16-31925a7d6d8e',
  '830acb3a-4573-5563-9cda-43602aa2fd30',
  6, 6, 'Developing AI Systems',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3fcc0e62-49c6-5b68-b542-6862e1140aa9', 'objective', 'Explain the stages involved in developing an AI system.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3fcc0e62-49c6-5b68-b542-6862e1140aa9', 'objective', 'Identify programming languages and tools used in AI development.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3fcc0e62-49c6-5b68-b542-6862e1140aa9', 'objective', 'Explain why Python is widely used in AI development.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3771d1ea-be70-5391-b30a-9c83e9f6fc2d', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '44b5cf57-a434-5c4f-bcc7-707deb75dba0',
  7, 7, 'Types of Computers',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3771d1ea-be70-5391-b30a-9c83e9f6fc2d', 'objective', 'Identify types of computers (supercomputer, mainframe, minicomputer, microcomputer).', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3771d1ea-be70-5391-b30a-9c83e9f6fc2d', 'objective', 'Describe each type of computer with respect to size, power, cost and purpose.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3771d1ea-be70-5391-b30a-9c83e9f6fc2d', 'objective', 'Choose an appropriate computer type suited to a given situation.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7ff2f57a-1761-5e72-8dc1-154ea499043c', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '44b5cf57-a434-5c4f-bcc7-707deb75dba0',
  8, 8, 'Basic Components of a Computer',
  1, 2, 2,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7ff2f57a-1761-5e72-8dc1-154ea499043c', 'objective', 'Explain the concepts of hardware, input, output, storage and processing device.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7ff2f57a-1761-5e72-8dc1-154ea499043c', 'objective', 'State the purpose of common devices in each category (input, output, storage, and processing).', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7ff2f57a-1761-5e72-8dc1-154ea499043c', 'objective', 'Choose an appropriate device for a given situation.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '276977f5-86e8-51a7-9538-3db12650e981', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '44b5cf57-a434-5c4f-bcc7-707deb75dba0',
  9, 9, 'Input devices',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('276977f5-86e8-51a7-9538-3db12650e981', 'objective', 'Explain the concept of automatic data capture.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('276977f5-86e8-51a7-9538-3db12650e981', 'objective', 'Describe the following automatic data capture devices (MICR, OCR, OMR, barcode reader, QR code reader, card readers, RFID readers, Biometric readers).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('276977f5-86e8-51a7-9538-3db12650e981', 'objective', 'Explain how AI-based image recognition extends automatic data capture beyond QR/barcode reading.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c8cb5943-a818-54e6-89dd-401e9056728a', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  'af1eb006-e993-5b7a-9adf-a5b35f2f9675',
  10, 10, 'Output devices',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c8cb5943-a818-54e6-89dd-401e9056728a', 'objective', 'Differentiate between the different types of printers (dot matrix printer, laser printer, inkjet printer).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c8cb5943-a818-54e6-89dd-401e9056728a', 'objective', 'Describe the following output devices (projector, graph plotter, 3D printers, actuators).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c8cb5943-a818-54e6-89dd-401e9056728a', 'objective', 'Justify choice of an output device in a given situation.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ec50d70e-8b7c-5f8f-8ad6-6ffa64c123b5', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  'af1eb006-e993-5b7a-9adf-a5b35f2f9675',
  11, 11, 'Secondary Storage media and devices',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ec50d70e-8b7c-5f8f-8ad6-6ffa64c123b5', 'objective', 'Differentiate between secondary storage and primary storage.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ec50d70e-8b7c-5f8f-8ad6-6ffa64c123b5', 'objective', 'Describe the different types of secondary storage media and devices (Magnetic storage, Optical storage, and Solid-state drives).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ec50d70e-8b7c-5f8f-8ad6-6ffa64c123b5', 'objective', 'Justify choice of a storage media and device in a given situation.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '57ad17ad-5d87-593f-98e1-c7bdea64e962', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  'af1eb006-e993-5b7a-9adf-a5b35f2f9675',
  12, 12, 'Primary Storage devices',
  1, 3, 3,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('57ad17ad-5d87-593f-98e1-c7bdea64e962', 'objective', 'Describe types of primary storage (RAM, ROM, cache, registers).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('57ad17ad-5d87-593f-98e1-c7bdea64e962', 'objective', 'Compare memory types based on access speed, cost and storage capacity.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('57ad17ad-5d87-593f-98e1-c7bdea64e962', 'objective', 'Explain why large-scale AI/machine-learning training requires significant secondary storage capacity for its datasets.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ec28cc07-b74e-5517-a3db-9ffbfd3834ce', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  'af1eb006-e993-5b7a-9adf-a5b35f2f9675',
  13, 13, 'Processing device and the machine instruction cycle',
  1, 4, 4,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ec28cc07-b74e-5517-a3db-9ffbfd3834ce', 'objective', 'Differentiate between CPU and GPU.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ec28cc07-b74e-5517-a3db-9ffbfd3834ce', 'objective', 'Describe the different stages of the machine instruction cycle.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ec28cc07-b74e-5517-a3db-9ffbfd3834ce', 'objective', 'Explain why AI/machine-learning workloads rely heavily on parallel GPU processing rather than the CPU alone.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ad33a160-4ae5-5fd4-9b5b-1ff6ff0434c9', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  'af1eb006-e993-5b7a-9adf-a5b35f2f9675',
  14, 14, 'Processor architectures, parallel & distributed computing',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ad33a160-4ae5-5fd4-9b5b-1ff6ff0434c9', 'objective', 'Explain processor architectures (CISC and RISC).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ad33a160-4ae5-5fd4-9b5b-1ff6ff0434c9', 'objective', 'Describe Flynn''s architectures (SIMD, SISD, MISD, MIMD).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ad33a160-4ae5-5fd4-9b5b-1ff6ff0434c9', 'objective', 'Differentiate between parallel and distributed computing.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '250577d6-261c-5209-b4fd-991b30fe7e4d', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  'af1eb006-e993-5b7a-9adf-a5b35f2f9675',
  15, 15, 'Conversion between units of storage and units of processing',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('250577d6-261c-5209-b4fd-991b30fe7e4d', 'objective', 'Identify units of storage and units of processing.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('250577d6-261c-5209-b4fd-991b30fe7e4d', 'objective', 'State the relationships between storage units (bits, bytes, terabytes,...) and processing units (Hertz, Kilohertz, Gigahertz).', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('250577d6-261c-5209-b4fd-991b30fe7e4d', 'objective', 'Convert from one unit of storage to another.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2562c6d1-ac6e-5099-a1cd-d3c3517ca996', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '0666fd6c-f109-5674-9bf2-1df9a86a4455',
  16, 16, 'Definitions and classification of software',
  1, 4, 4,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2562c6d1-ac6e-5099-a1cd-d3c3517ca996', 'objective', 'Explain the concept of software.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2562c6d1-ac6e-5099-a1cd-d3c3517ca996', 'objective', 'Explain the difference between system software and application software.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2562c6d1-ac6e-5099-a1cd-d3c3517ca996', 'objective', 'Establish with examples the difference between open source and proprietary software.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8e0cfa56-b7ec-500a-8da8-d7a0eecf6ea0', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '0666fd6c-f109-5674-9bf2-1df9a86a4455',
  17, 17, 'Application software',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8e0cfa56-b7ec-500a-8da8-d7a0eecf6ea0', 'objective', 'Differentiate between general purpose, specific purpose and tailor-made software.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8e0cfa56-b7ec-500a-8da8-d7a0eecf6ea0', 'objective', 'Describe common types of application software (word processor, browser, spreadsheet, desktop publishing,, graphic, Presentation, artificial intelligence, etc).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8e0cfa56-b7ec-500a-8da8-d7a0eecf6ea0', 'objective', 'Choose appropriate application software for a given task or situation.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '36462e43-bc26-5e16-b9d8-d097463eff4a', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '0666fd6c-f109-5674-9bf2-1df9a86a4455',
  NULL, NULL, 'Evaluation No 1',
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
  '7566e640-bf53-5c85-b582-64ad742266d7', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '0666fd6c-f109-5674-9bf2-1df9a86a4455',
  NULL, NULL, 'Remediation No 1',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7566e640-bf53-5c85-b582-64ad742266d7', 'objective', 'Review and correct the common errors identified in Evaluation No 1.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7566e640-bf53-5c85-b582-64ad742266d7', 'objective', 'Reinforce weak areas in computing history, AI concepts and hardware categorisation through guided practice.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7566e640-bf53-5c85-b582-64ad742266d7', 'objective', 'Support learners who under-performed before moving into computer software and operating systems.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b20be4ef-377b-55a0-a8d7-1344eeafd534', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '0666fd6c-f109-5674-9bf2-1df9a86a4455',
  18, 18, 'System software and examples',
  1, 5, 5,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b20be4ef-377b-55a0-a8d7-1344eeafd534', 'objective', 'Describe the different types of system software (operating system, device drivers, utility software).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b20be4ef-377b-55a0-a8d7-1344eeafd534', 'objective', 'Describe common types of utility software (antivirus, disk cleaner, defragmenter, File management, File compression, etc).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b20be4ef-377b-55a0-a8d7-1344eeafd534', 'objective', 'Identify examples of AI-powered utility software, such as intelligent antivirus and predictive disk optimisation.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '32d4b7d1-f281-54c2-9a4c-e9997b577596', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '31af8d70-30f8-50b4-9b0c-2c0891157ffb',
  19, 19, 'Notions of the Operating System',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('32d4b7d1-f281-54c2-9a4c-e9997b577596', 'objective', 'Outline major landmarks in the history and evolution of operating systems.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('32d4b7d1-f281-54c2-9a4c-e9997b577596', 'objective', 'Describe types of operating systems (single user, batch, online, multi-user, NOS, multitasking, real-time).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('32d4b7d1-f281-54c2-9a4c-e9997b577596', 'objective', 'State functions of an operating system.', 'remember', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7c6d2c94-c52a-51f7-8186-eddf5a52b95c', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '31af8d70-30f8-50b4-9b0c-2c0891157ffb',
  20, 20, 'Functions of an operating system 1',
  1, 6, 6,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7c6d2c94-c52a-51f7-8186-eddf5a52b95c', 'objective', 'Distinguish between pre-emptive and non-pre-emptive scheduling.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7c6d2c94-c52a-51f7-8186-eddf5a52b95c', 'objective', 'Describe scheduling algorithms (FCFS, SJF, SRT, round robin).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7c6d2c94-c52a-51f7-8186-eddf5a52b95c', 'objective', 'Explain briefly how AI techniques are used in modern operating systems for predictive process scheduling.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'def13e76-2dca-5abc-9b85-1bdf3d087af0', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '31af8d70-30f8-50b4-9b0c-2c0891157ffb',
  21, 21, 'Functions of the operating system 2',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('def13e76-2dca-5abc-9b85-1bdf3d087af0', 'objective', 'Explain how the operating system manages memory, files, Devices (Input & output).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('def13e76-2dca-5abc-9b85-1bdf3d087af0', 'objective', 'Explain the following concepts as used in operating systems: deallocation, virtual memory, buffering, spooling, metadata.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '03b1272a-06a4-5c6a-be44-4ccaf816fd7b', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '31af8d70-30f8-50b4-9b0c-2c0891157ffb',
  22, 22, 'Installing an operating system and user interfaces',
  1, 6, 6,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('03b1272a-06a4-5c6a-be44-4ccaf816fd7b', 'objective', 'Install an operating system (Windows or Linux).', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('03b1272a-06a4-5c6a-be44-4ccaf816fd7b', 'objective', 'Identify OS interfaces (GUI, CLI) and their strengths and weaknesses.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('03b1272a-06a4-5c6a-be44-4ccaf816fd7b', 'objective', 'Select appropriate interface for a given context.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '502d2d2f-ef56-52b6-a915-c75e97618bba', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '31af8d70-30f8-50b4-9b0c-2c0891157ffb',
  23, 23, 'Using the GUI of an operating system',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('502d2d2f-ef56-52b6-a915-c75e97618bba', 'objective', 'Explain the following concepts: file, folder, file format.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('502d2d2f-ef56-52b6-a915-c75e97618bba', 'objective', 'Perform operations (creation, renaming, deleting, copying, cutting, compressing, …) on files and folders using the GUI of an operating system.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('502d2d2f-ef56-52b6-a915-c75e97618bba', 'objective', 'Set up an OS to avoid unauthorised access using a GUI.', NULL, 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '13494487-0588-5fc5-adcb-21d95c78db0d', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '31af8d70-30f8-50b4-9b0c-2c0891157ffb',
  24, 24, 'Using the CLI of an operating system',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('13494487-0588-5fc5-adcb-21d95c78db0d', 'objective', 'Launch and identify command line environments (MS-DOS or Linux).', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('13494487-0588-5fc5-adcb-21d95c78db0d', 'objective', 'Perform operations on files and folders using the CLI.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('13494487-0588-5fc5-adcb-21d95c78db0d', 'objective', 'Write and execute a command-line script to automate a task.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '07a2154c-4110-5833-821c-1c9332fce7f3', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '10e83d61-1765-5e26-a605-f8d17d8d6733',
  25, 25, 'Hardware faults identification and correction',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07a2154c-4110-5833-821c-1c9332fce7f3', 'objective', 'Explain the following concepts computer maintenance, preventive maintenance, corrective maintenance.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('07a2154c-4110-5833-821c-1c9332fce7f3', 'objective', 'Describe common hardware faults in a computer system and techniques to curb them.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '25d7af29-a68b-5ba5-8b86-a41811a70679', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '10e83d61-1765-5e26-a605-f8d17d8d6733',
  26, 26, 'Software faults identification and correction',
  1, 7, 7,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('25d7af29-a68b-5ba5-8b86-a41811a70679', 'objective', 'Differentiate between hardware and software maintenance.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('25d7af29-a68b-5ba5-8b86-a41811a70679', 'objective', 'Describe common software faults and how to curb them.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7024e4d4-a79d-5dd7-9a80-764e519696f6', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '993300b1-eb0c-5fd2-adf3-ce9054db7ae3',
  27, 27, 'Assistive technology',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7024e4d4-a79d-5dd7-9a80-764e519696f6', 'objective', 'Explain the concept of assistive technology.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7024e4d4-a79d-5dd7-9a80-764e519696f6', 'objective', 'Describe assistive technologies (Braille keyboard, audio devices, automatic speech recognition).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7024e4d4-a79d-5dd7-9a80-764e519696f6', 'objective', 'Explain how AI-based speech recognition and predictive text have improved assistive technology for learners with disabilities.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c97e8511-58a9-545c-9c01-9b1fc1656a9c', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '993300b1-eb0c-5fd2-adf3-ce9054db7ae3',
  28, 28, 'Computer ergonomics',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c97e8511-58a9-545c-9c01-9b1fc1656a9c', 'objective', 'Explain the concept of computer ergonomics.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c97e8511-58a9-545c-9c01-9b1fc1656a9c', 'objective', 'Explain computer-related health hazards and their causes. (musculoskeletal disorders, eye strain).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c97e8511-58a9-545c-9c01-9b1fc1656a9c', 'objective', 'Describe correct posture, habits, and equipment positioning to avoid computer related health hazards.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '93254295-9f6c-5238-9bb9-cb47894d2f00', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '52e21c21-52c0-552e-ac0b-8f57dab65dbd',
  29, 29, 'Editing and Formatting text',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('93254295-9f6c-5238-9bb9-cb47894d2f00', 'objective', 'Perform text formatting with a word processor.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('93254295-9f6c-5238-9bb9-cb47894d2f00', 'objective', 'Perform text editing with a word processor.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('93254295-9f6c-5238-9bb9-cb47894d2f00', 'objective', 'Identify how AI-based writing assistants support grammar, style and content suggestions during text editing.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd0b7018a-f6c9-50b9-9713-41d6a01920e0', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '52e21c21-52c0-552e-ac0b-8f57dab65dbd',
  30, 30, 'Editing and formatting images and tables',
  1, 8, 8,
  true, false, false,
  'content', 33
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d0b7018a-f6c9-50b9-9713-41d6a01920e0', 'objective', 'Perform editing and formatting of images and graphics.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d0b7018a-f6c9-50b9-9713-41d6a01920e0', 'objective', 'Perform editing and formatting of tables.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'fb3f9398-226a-5de2-af56-170cbeed9780', (SELECT id FROM target_syllabus), '9d8c1629-d8e2-5770-8a24-d3d706d0737d',
  '52e21c21-52c0-552e-ac0b-8f57dab65dbd',
  31, 31, 'Using Text boxes and adjusting Page layout',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fb3f9398-226a-5de2-af56-170cbeed9780', 'objective', 'Perform editing and formatting of text boxes.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fb3f9398-226a-5de2-af56-170cbeed9780', 'objective', 'Modify features of a page (margins, orientation, size, columns, …).', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('fb3f9398-226a-5de2-af56-170cbeed9780', 'objective', 'Add comments to sections of a document.', NULL, 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b1a6c8ab-6afd-5734-a976-1c6c9a5ee005', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  NULL,
  NULL, NULL, 'Integration Activity No 1',
  1, 9, 9,
  true, false, false,
  'integration_activity', 35
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b1a6c8ab-6afd-5734-a976-1c6c9a5ee005', 'objective', 'Given a computer system to be made operational for a stated user, including one requiring assistive technology, select and justify appropriate system and application software.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b1a6c8ab-6afd-5734-a976-1c6c9a5ee005', 'objective', 'Install/configure the operating system and required software, applying correct ergonomic setup and safe working practices.', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b1a6c8ab-6afd-5734-a976-1c6c9a5ee005', 'objective', 'Demonstrate at least one accessibility feature suited to the stated user''s needs.', NULL, 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '4bc9ce68-1497-50ff-b6d2-8fa266f881de', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '8b731be1-5f87-5408-a5bc-d50434791e0a',
  32, 32, 'Introduction to spreadsheets',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4bc9ce68-1497-50ff-b6d2-8fa266f881de', 'objective', 'Describe the following spreadsheet components: row, column, row number, column number, cell, cell address, range, formula, sheet.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4bc9ce68-1497-50ff-b6d2-8fa266f881de', 'objective', 'Select a row, column, cell, range, and non-contiguous cells on an electronic spreadsheet.', 'evaluate', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('4bc9ce68-1497-50ff-b6d2-8fa266f881de', 'objective', 'Perform basic editing and formatting using a spreadsheet.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '34cce036-4f2e-5d80-a7de-fbad068f1c81', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '8b731be1-5f87-5408-a5bc-d50434791e0a',
  33, 33, 'Performing calculations using spreadsheets',
  1, 9, 9,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34cce036-4f2e-5d80-a7de-fbad068f1c81', 'objective', 'Perform basic arithmetic operations using an electronic spreadsheet (without using functions).', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34cce036-4f2e-5d80-a7de-fbad068f1c81', 'objective', 'Perform calculations using the SUM, AVERAGE, COUNT, PRODUCT, IF function, COUNTIF.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34cce036-4f2e-5d80-a7de-fbad068f1c81', 'objective', 'Explain how AI-powered spreadsheet functions can automatically detect data trends and generate forecasts.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3933f789-586e-57f4-9551-911df0e07217', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '8b731be1-5f87-5408-a5bc-d50434791e0a',
  34, 34, 'Types of cells referencing and calculations',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3933f789-586e-57f4-9551-911df0e07217', 'objective', 'Differentiate between the different types of cells referencing.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3933f789-586e-57f4-9551-911df0e07217', 'objective', 'Solve data problems using appropriate spreadsheet functions (SUM, AVERAGE, COUNT, PRODUCT, IF function, COUNTIF, RANK) and cell reference.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c9298c23-1c26-5994-9900-268f2b78489f', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '8b731be1-5f87-5408-a5bc-d50434791e0a',
  NULL, NULL, 'Evaluation No 2',
  1, 10, 10,
  true, false, false,
  'evaluation', 39
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
  'ea802248-d8c8-5986-b85b-a3134e39fd50', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '8b731be1-5f87-5408-a5bc-d50434791e0a',
  NULL, NULL, 'Remediation No 2',
  1, 10, 10,
  true, false, false,
  'remediation', 40
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ea802248-d8c8-5986-b85b-a3134e39fd50', 'objective', 'Review and correct the common errors identified in Evaluation No 2.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ea802248-d8c8-5986-b85b-a3134e39fd50', 'objective', 'Reinforce weak areas in software, operating systems and productivity tools (word processor, spreadsheet) through guided practice.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ea802248-d8c8-5986-b85b-a3134e39fd50', 'objective', 'Support learners who under-performed before continuing with the next block.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1a6bd6e4-b6a9-5bc2-8284-a73ecffae1e2', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '4382cb4f-68be-5032-907b-4d1eed4eefaa',
  35, 35, 'Positive and Negative Uses of Computer Systems',
  1, 10, 10,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1a6bd6e4-b6a9-5bc2-8284-a73ecffae1e2', 'objective', 'State positive and negative uses of computer systems.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1a6bd6e4-b6a9-5bc2-8284-a73ecffae1e2', 'objective', 'Explain the social and economic effects of computer systems.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1a6bd6e4-b6a9-5bc2-8284-a73ecffae1e2', 'objective', 'Explain how ICT can be responsibly used to influence communication and culture.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '76fc8526-9ee4-559f-ab0c-47813a1aaa83', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '4382cb4f-68be-5032-907b-4d1eed4eefaa',
  36, 36, 'Computer Ethics, Legislation and Cameroon Law',
  1, 11, 11,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('76fc8526-9ee4-559f-ab0c-47813a1aaa83', 'objective', 'Explain the code of ethics and moral obligation of computer users.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('76fc8526-9ee4-559f-ab0c-47813a1aaa83', 'objective', 'Explain unethical acts with focus on those punishable by Cameroon law.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('76fc8526-9ee4-559f-ab0c-47813a1aaa83', 'objective', 'Discuss ethical concerns raised by AI-generated content, deepfakes and algorithmic bias.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f40f3006-21a2-5756-86d1-01ae04a130b8', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '4382cb4f-68be-5032-907b-4d1eed4eefaa',
  37, 37, 'Data Protection, Copyright and the Digital Divide',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f40f3006-21a2-5756-86d1-01ae04a130b8', 'objective', 'Demonstrate knowledge of current data protection and copyright acts.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f40f3006-21a2-5756-86d1-01ae04a130b8', 'objective', 'Determine the effects of global communication on citizenship, culture and digital divide.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f40f3006-21a2-5756-86d1-01ae04a130b8', 'objective', 'Suggest practical ways of reducing the digital divide in the community.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '55450b04-3caa-59b4-80f4-fb6c10937866', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'caaac11e-b955-53bf-a70d-8c4f81a38dc7',
  38, 38, 'Protecting Computer Systems from Illegal Access',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('55450b04-3caa-59b4-80f4-fb6c10937866', 'objective', 'Explain the security, reliability and resilience of computer systems.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('55450b04-3caa-59b4-80f4-fb6c10937866', 'objective', 'Describe measures used to protect systems from illegal access (passwords, security codes, encryption, biometrics, physical security).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('55450b04-3caa-59b4-80f4-fb6c10937866', 'objective', 'Explain the necessity of data handling and backup.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '575140f4-faec-582c-94d2-bd88fbce08d7', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'caaac11e-b955-53bf-a70d-8c4f81a38dc7',
  39, 39, 'System Recovery and Safe Working Practices',
  1, 11, 11,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('575140f4-faec-582c-94d2-bd88fbce08d7', 'objective', 'State the importance of recovery in the event of system failure.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('575140f4-faec-582c-94d2-bd88fbce08d7', 'objective', 'Explain the importance of privacy and safe working practices.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('575140f4-faec-582c-94d2-bd88fbce08d7', 'objective', 'Illustrate with examples how safe working practices protect a computer system.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '82c0cd33-437e-58ad-8c7d-1717a2d08092', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'caaac11e-b955-53bf-a70d-8c4f81a38dc7',
  40, 40, 'Computer Crimes and Combat Measures',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('82c0cd33-437e-58ad-8c7d-1717a2d08092', 'objective', 'Describe data handling and computer-related crime (copyright infringement, plagiarism, computer-assisted crime).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('82c0cd33-437e-58ad-8c7d-1717a2d08092', 'objective', 'Classify computer crimes into computer-related and computer- assisted crimes.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('82c0cd33-437e-58ad-8c7d-1717a2d08092', 'objective', 'Associate types of computer crimes to specific measures used to combat them.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2bdb3aba-0d8b-5555-a18e-b411c81acf61', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'caaac11e-b955-53bf-a70d-8c4f81a38dc7',
  41, 41, 'Malware — Types and Characteristics',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2bdb3aba-0d8b-5555-a18e-b411c81acf61', 'objective', 'Describe different types of malware (virus, worm, Trojan horse, rootkit, backdoor, spyware).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2bdb3aba-0d8b-5555-a18e-b411c81acf61', 'objective', 'Compare the different types of malware based on how they spread and their effects.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2bdb3aba-0d8b-5555-a18e-b411c81acf61', 'objective', 'Explain how AI is used both to detect malware through behavioural analysis and to create more sophisticated, AI- generated attacks.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '133ba569-70b5-5165-ada0-3e1119eccf1e', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'caaac11e-b955-53bf-a70d-8c4f81a38dc7',
  42, 42, 'Protecting a Computer System from Malware',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('133ba569-70b5-5165-ada0-3e1119eccf1e', 'objective', 'Explain good practices (opening trusted attachments, scanning email, downloading from trusted websites) to protect against malware.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('133ba569-70b5-5165-ada0-3e1119eccf1e', 'objective', 'Scan a computer system using an antivirus.', NULL, 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('133ba569-70b5-5165-ada0-3e1119eccf1e', 'objective', 'Set up protection against unauthorised access using a firewall.', NULL, 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ed586cb6-2e80-5a66-abb3-bcce2b0a0420', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  NULL,
  NULL, NULL, 'Integration Activity No 2',
  1, 12, 12,
  true, false, false,
  'integration_activity', 49
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ed586cb6-2e80-5a66-abb3-bcce2b0a0420', 'objective', 'Produce a properly formatted document and an accompanying spreadsheet performing at least one calculation, both relevant to a stated real-life task.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ed586cb6-2e80-5a66-abb3-bcce2b0a0420', 'objective', 'Identify the ethical, legal and data-protection obligations that apply to handling the data used in the task.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ed586cb6-2e80-5a66-abb3-bcce2b0a0420', 'objective', 'Apply at least two practical measures to protect the data/system used from unauthorised access or malware.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f5b2a9e6-bcad-502e-ae74-3d828e05a140', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '1fb28a5a-011f-598d-a0d2-f99d0e41155c',
  43, 43, 'Types of Systems',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f5b2a9e6-bcad-502e-ae74-3d828e05a140', 'objective', 'Describe a system and distinguish between natural and artificial systems.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f5b2a9e6-bcad-502e-ae74-3d828e05a140', 'objective', 'Differentiate between manual and automatic systems (e.g. email, e-learning).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f5b2a9e6-bcad-502e-ae74-3d828e05a140', 'objective', 'Categorise systems in the learner''s environment (manual, automatic).', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e43edb97-bb27-5fe3-95a4-89fb7845a5b9', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '1fb28a5a-011f-598d-a0d2-f99d0e41155c',
  44, 44, 'Modelling a System with a Data Flow Diagram',
  2, 13, 13,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e43edb97-bb27-5fe3-95a4-89fb7845a5b9', 'objective', 'Propose limitations on an identified manual system.', 'evaluate', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e43edb97-bb27-5fe3-95a4-89fb7845a5b9', 'objective', 'Produce a data flow diagram for a given system.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e43edb97-bb27-5fe3-95a4-89fb7845a5b9', 'objective', 'Identify an AI-driven system as an example of an automatic system that can be modelled with a data flow diagram.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e7998683-e61d-5c25-9ce8-9eed9c01799f', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '166d5a9b-4ea3-5087-87f8-cd35abf03e24',
  45, 45, 'Introduction to Information Systems',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e7998683-e61d-5c25-9ce8-9eed9c01799f', 'objective', 'Define an information system.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e7998683-e61d-5c25-9ce8-9eed9c01799f', 'objective', 'state the components of an information system and their role (people, procedure, technology, data).', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e7998683-e61d-5c25-9ce8-9eed9c01799f', 'objective', 'Describe the hierarchical structure of an organisation.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e7998683-e61d-5c25-9ce8-9eed9c01799f', 'objective', 'Identify factors affecting the success or failure of an information system.', 'analyse', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e7998683-e61d-5c25-9ce8-9eed9c01799f', 'objective', 'Establish the necessity for information systems in a library, hospital, company or school.', 'evaluate', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '977b0a05-d65f-5d1e-adac-00363bfb6e3e', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '166d5a9b-4ea3-5087-87f8-cd35abf03e24',
  46, 46, 'Types of Information Systems',
  2, 13, 13,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('977b0a05-d65f-5d1e-adac-00363bfb6e3e', 'objective', 'Describe types of information systems (MIS, DSS, EIS, TPS, GIS, HIS, LIS).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('977b0a05-d65f-5d1e-adac-00363bfb6e3e', 'objective', 'Compare TPS, MIS, DSS and EIS based on purpose, users and inputs.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('977b0a05-d65f-5d1e-adac-00363bfb6e3e', 'objective', 'Select a suitable information system for a given context.', 'evaluate', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('977b0a05-d65f-5d1e-adac-00363bfb6e3e', 'objective', 'Explain how AI techniques enhance Decision Support Systems (DSS) and Executive Information Systems (EIS).', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '18a37fc0-9adf-570f-aa10-fef40e3a0cc7', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  '166d5a9b-4ea3-5087-87f8-cd35abf03e24',
  47, 47, 'General and Commercial Data Processing',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('18a37fc0-9adf-570f-aa10-fef40e3a0cc7', 'objective', 'State examples of general and commercial data processing systems (stock control, order processing, …).', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('18a37fc0-9adf-570f-aa10-fef40e3a0cc7', 'objective', 'Explain how general and commercial data processing works.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('18a37fc0-9adf-570f-aa10-fef40e3a0cc7', 'objective', 'Differentiate between real time processing and batch processing.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('18a37fc0-9adf-570f-aa10-fef40e3a0cc7', 'objective', 'Explain how Machine Learning extends traditional data processing by detecting patterns and making predictions from data.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8287fe7b-e6e0-5701-9c52-e66f2f3bb8cb', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  48, 48, 'Computer Systems in Industry and Science',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8287fe7b-e6e0-5701-9c52-e66f2f3bb8cb', 'objective', 'Describe the application of computer systems in sciences and industries (weather forecasting, CAD, CAM, image processing, simulation).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8287fe7b-e6e0-5701-9c52-e66f2f3bb8cb', 'objective', 'Explain how industrial, technical and scientific systems work.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8287fe7b-e6e0-5701-9c52-e66f2f3bb8cb', 'objective', 'Evaluate the level of automation and technological tools used in a manufacturing or scientific organisation.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c458013c-ffd6-56e0-9caf-7305135c9574', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  49, 49, 'Robots and Their Application in Daily Life',
  2, 14, 14,
  true, false, false,
  'content', 56
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c458013c-ffd6-56e0-9caf-7305135c9574', 'objective', 'Describe a robot.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c458013c-ffd6-56e0-9caf-7305135c9574', 'objective', 'Explain how robots are used in manufacturing, health and the home.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c458013c-ffd6-56e0-9caf-7305135c9574', 'objective', 'Illustrate with examples situations that may need the use of robots.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'ac66daa8-6932-5178-8921-65f0796911ea', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  50, 50, 'Monitoring systems, Control systems, and Monitoring & Control systems',
  2, 14, 14,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ac66daa8-6932-5178-8921-65f0796911ea', 'objective', 'Differentiate between monitoring system and control system.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ac66daa8-6932-5178-8921-65f0796911ea', 'objective', 'Explain how a monitoring system works and give examples of such a system in real-life.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ac66daa8-6932-5178-8921-65f0796911ea', 'objective', 'Explain how a control system works and give examples of such a system in real-life.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ac66daa8-6932-5178-8921-65f0796911ea', 'objective', 'Explain how a monitoring & control system work and give examples of such a system in real-life.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('ac66daa8-6932-5178-8921-65f0796911ea', 'objective', 'Describe how monitoring, control, and monitoring & control systems are used in different areas of life.', 'understand', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8037984e-af47-5d7a-8dce-a0b4eb70a2e6', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  51, 51, 'Simulation and Modelling',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8037984e-af47-5d7a-8dce-a0b4eb70a2e6', 'objective', 'Differentiate between simulation and modelling.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8037984e-af47-5d7a-8dce-a0b4eb70a2e6', 'objective', 'Explain the concept of simulation using games, videos and head- mounted displays as examples.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8037984e-af47-5d7a-8dce-a0b4eb70a2e6', 'objective', 'Establish advantages and limitations of simulation.', 'evaluate', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8037984e-af47-5d7a-8dce-a0b4eb70a2e6', 'objective', 'Describe how simulations are used in different domains of life.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8037984e-af47-5d7a-8dce-a0b4eb70a2e6', 'objective', 'Design a simulation of a situation in the learner''s environment using technology.', 'create', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7577135d-c436-572b-ba21-b86bbdfbd29d', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  52, 52, 'Embedded systems and IoT',
  2, 15, 15,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7577135d-c436-572b-ba21-b86bbdfbd29d', 'objective', 'Differentiate between an embedded system and an IoT system.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7577135d-c436-572b-ba21-b86bbdfbd29d', 'objective', 'Explain how an embedded system works and give examples of embedded systems.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7577135d-c436-572b-ba21-b86bbdfbd29d', 'objective', 'Explain how an IoT system works and give examples of IoT systems.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7577135d-c436-572b-ba21-b86bbdfbd29d', 'objective', 'Describe how embedded systems are used in different areas of life.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7577135d-c436-572b-ba21-b86bbdfbd29d', 'objective', 'Describe how IoT systems are used in different areas of life.', 'understand', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2abdc0da-f59a-5c9c-babb-5c056f65044f', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  53, 53, 'Virtual Reality and Augmented Reality',
  2, 15, 15,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2abdc0da-f59a-5c9c-babb-5c056f65044f', 'objective', 'Explain the concepts of Virtual Reality (VR) and Augmented Reality (AR).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2abdc0da-f59a-5c9c-babb-5c056f65044f', 'objective', 'Explain how Virtual Reality (VR) works and describe its role in different areas of life.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2abdc0da-f59a-5c9c-babb-5c056f65044f', 'objective', 'Explain how Augmented Reality (AR) works and describe its role in different areas of life.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2abdc0da-f59a-5c9c-babb-5c056f65044f', 'objective', 'Differentiate between AR and VR systems.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '67d5cc64-94d4-539e-8708-4b0a8e588cf3', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  NULL, NULL, 'Evaluation No 3',
  2, 15, 15,
  true, false, false,
  'evaluation', 61
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
  'b25cadc1-131f-5590-b8c7-bfc133297f1b', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  NULL, NULL, 'Remediation No 3',
  2, 16, 16,
  true, false, false,
  'remediation', 62
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b25cadc1-131f-5590-b8c7-bfc133297f1b', 'objective', 'Review and correct the common errors identified in Evaluation No 3.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b25cadc1-131f-5590-b8c7-bfc133297f1b', 'objective', 'Reinforce weak areas in digital citizenship, cybersecurity and information systems through guided practice.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b25cadc1-131f-5590-b8c7-bfc133297f1b', 'objective', 'Support learners who under-performed before continuing into Second Term.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e1f4f5b9-853b-5890-8e8f-d044d1ae2be9', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  54, 54, 'Multimedia Systems and Authoring',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e1f4f5b9-853b-5890-8e8f-d044d1ae2be9', 'objective', 'Explain the concept of multimedia, multimedia authoring tool.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e1f4f5b9-853b-5890-8e8f-d044d1ae2be9', 'objective', 'Differentiate between multimedia and non-multimedia content.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e1f4f5b9-853b-5890-8e8f-d044d1ae2be9', 'objective', 'Explain how multimedia systems work and give examples of multimedia authoring tools.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e1f4f5b9-853b-5890-8e8f-d044d1ae2be9', 'objective', 'State the features of multimedia authoring tools and use one to produce a short multimedia content.', 'remember', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '04515d2a-bb3e-5d53-b6d5-f64a4e879bf7', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  55, 55, 'Multimodal Systems',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('04515d2a-bb3e-5d53-b6d5-f64a4e879bf7', 'objective', 'Differentiate between a unimodal and a multimodal system.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('04515d2a-bb3e-5d53-b6d5-f64a4e879bf7', 'objective', 'Explain how multimodal systems work.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('04515d2a-bb3e-5d53-b6d5-f64a4e879bf7', 'objective', 'State real-world examples of multimodal systems.', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('04515d2a-bb3e-5d53-b6d5-f64a4e879bf7', 'objective', 'Describe how multimodal systems are used in different areas of life.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3db06467-6f52-5f7f-ab98-cfd539771d0c', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  56, 56, 'AI technologies',
  2, 16, 16,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3db06467-6f52-5f7f-ab98-cfd539771d0c', 'objective', 'Differentiate between machine learning, neural networks, and deep learning.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3db06467-6f52-5f7f-ab98-cfd539771d0c', 'objective', 'Describe application areas of machine learning, neural network and deep learning.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3db06467-6f52-5f7f-ab98-cfd539771d0c', 'objective', 'Analyse real-world problems across diverse domains (healthcare, agriculture, finance, …) and determine whether they require traditional machine learning, neural networks, or deep Learning solutions.', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3db06467-6f52-5f7f-ab98-cfd539771d0c', 'objective', 'Train a simple visual machine learning model using an interactive no-code environment.', 'apply', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '5cefd3a4-8e72-562c-9322-8c28038ed69d', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  57, 57, 'Generative AI',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5cefd3a4-8e72-562c-9322-8c28038ed69d', 'objective', 'Explain the concepts of generative AI and large language models.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5cefd3a4-8e72-562c-9322-8c28038ed69d', 'objective', 'Explain how generative AI works and give examples of generative AIs.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5cefd3a4-8e72-562c-9322-8c28038ed69d', 'objective', 'Explain the concepts of hallucinations, bias, and outline common sources of bias.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5cefd3a4-8e72-562c-9322-8c28038ed69d', 'objective', 'Evaluate the impact of Generative AI applications on working and living standards.', 'evaluate', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('5cefd3a4-8e72-562c-9322-8c28038ed69d', 'objective', 'Discuss ethical ways of using generative AI.', 'understand', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'f7abf33b-eb78-5f74-8443-af8c18ca930c', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  'c9785f29-72ff-5342-b8d3-54cc48031baf',
  58, 58, 'Using generative AI for day-to-day activities',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f7abf33b-eb78-5f74-8443-af8c18ca930c', 'objective', 'Formulate structured prompts to execute real-world workplace or day to day tasks using Generative AI.', 'create', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('f7abf33b-eb78-5f74-8443-af8c18ca930c', 'objective', 'Refine prompts and write effective follow-up prompts.', 'create', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1f57d02a-4ee6-5b86-a4b0-3a25856bb26d', (SELECT id FROM target_syllabus), '3de0008f-bcac-5962-bbda-493c5b336cae',
  NULL,
  NULL, NULL, 'Integration Activity No 3',
  2, 17, 17,
  true, false, false,
  'integration_activity', 68
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1f57d02a-4ee6-5b86-a4b0-3a25856bb26d', 'objective', 'Given a described organisation or process, model it as a system (data flow diagram) and identify the type of information system best suited to it.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1f57d02a-4ee6-5b86-a4b0-3a25856bb26d', 'objective', 'Propose how automation, robotics or AI could improve the process, referencing suitable examples from the categories studied.', 'evaluate', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1f57d02a-4ee6-5b86-a4b0-3a25856bb26d', 'objective', 'Justify the proposed system and technology choices against the organisation''s stated needs.', 'evaluate', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd772cdac-1913-5620-b1ea-a9c0812b5c1f', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'f10ac2bc-d88a-559f-8589-22e3474f0415',
  59, 59, 'Introduction to the System Development Life Cycle (SDLC)',
  2, 17, 17,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d772cdac-1913-5620-b1ea-a9c0812b5c1f', 'objective', 'Define the System Development Life Cycle (SDLC).', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d772cdac-1913-5620-b1ea-a9c0812b5c1f', 'objective', 'Describe each stage in the SDLC.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d772cdac-1913-5620-b1ea-a9c0812b5c1f', 'objective', 'Identify activities involved at each stage of the SDLC.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '580591ac-c50b-51b2-b1e6-b19b332834a0', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'f10ac2bc-d88a-559f-8589-22e3474f0415',
  60, 60, 'SDLC Models',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('580591ac-c50b-51b2-b1e6-b19b332834a0', 'objective', 'Describe the waterfall, prototyping, Agile, Boehm''s spiral model.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('580591ac-c50b-51b2-b1e6-b19b332834a0', 'objective', 'Compare SDLC models (waterfall, prototyping, Agile, Boehm''s spiral).', 'analyse', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '10ba0519-f583-5aa7-a9a3-2a407be70704', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'f10ac2bc-d88a-559f-8589-22e3474f0415',
  61, 61, 'The prototyping model',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('10ba0519-f583-5aa7-a9a3-2a407be70704', 'objective', 'Explain the steps involved in prototyping.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('10ba0519-f583-5aa7-a9a3-2a407be70704', 'objective', 'Explain reasons for using prototyping in system development.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('10ba0519-f583-5aa7-a9a3-2a407be70704', 'objective', 'Compare the types of prototyping based on cost, time and reusability.', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('10ba0519-f583-5aa7-a9a3-2a407be70704', 'objective', 'Choose the appropriate type of prototyping for a given context.', 'evaluate', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('10ba0519-f583-5aa7-a9a3-2a407be70704', 'objective', 'Explain how AI-assisted prototyping tools can accelerate the creation of a system prototype.', 'understand', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0b749b3a-042a-5b2f-b28b-9ad6e8d66b68', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'f10ac2bc-d88a-559f-8589-22e3474f0415',
  62, 62, 'Changeover Strategies',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0b749b3a-042a-5b2f-b28b-9ad6e8d66b68', 'objective', 'Identify the stage of the SDLC where changeover is applied.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0b749b3a-042a-5b2f-b28b-9ad6e8d66b68', 'objective', 'Explain the different changeover strategies (direct, parallel, pilot and phased).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0b749b3a-042a-5b2f-b28b-9ad6e8d66b68', 'objective', 'Explain advantages and disadvantages of each change over strategy.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0b749b3a-042a-5b2f-b28b-9ad6e8d66b68', 'objective', 'Propose a suitable changeover strategy for a given context.', 'evaluate', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'efd16fa2-a187-5fb9-aae0-bc240ea5e5a6', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'a60b7173-21a6-5d56-8660-147722e05933',
  63, 63, 'Data Modelling Concepts',
  2, 18, 18,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('efd16fa2-a187-5fb9-aae0-bc240ea5e5a6', 'objective', 'Distinguish between flat file and relational databases.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('efd16fa2-a187-5fb9-aae0-bc240ea5e5a6', 'objective', 'Explain the different types of database model (ER model, relational model, object-oriented model).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('efd16fa2-a187-5fb9-aae0-bc240ea5e5a6', 'objective', 'Describe the different levels of data modelling (conceptual, logical and physical).', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('efd16fa2-a187-5fb9-aae0-bc240ea5e5a6', 'objective', 'Outline steps involved in relational data modelling (designing tables, determining primary keys, modelling relationships, normalise models, model queries).', 'remember', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('efd16fa2-a187-5fb9-aae0-bc240ea5e5a6', 'objective', 'Justify the choice of a database model for a given real-life situation.', 'evaluate', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'bf9777ad-57a2-57cd-bfe5-5aed8e6f6932', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'a60b7173-21a6-5d56-8660-147722e05933',
  64, 64, 'Entity Relationship Model Concepts and representation systems',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf9777ad-57a2-57cd-bfe5-5aed8e6f6932', 'objective', 'Explain the notions of entity type (table), entity (record) attribute, primary key, relationship, cardinality, foreign key.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf9777ad-57a2-57cd-bfe5-5aed8e6f6932', 'objective', 'Describe the different types of relationship (one to one, one to many and many to many).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf9777ad-57a2-57cd-bfe5-5aed8e6f6932', 'objective', 'Outline common ER modelling notation systems (Chen, Crow’s foot).', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('bf9777ad-57a2-57cd-bfe5-5aed8e6f6932', 'objective', 'Identify the symbols in a given ER modelling notation system (Chen, Crow’s foot).', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '45366509-0993-5c35-9920-3fb341f0b333', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'a60b7173-21a6-5d56-8660-147722e05933',
  65, 65, 'Designing an ER diagram and normalisation',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('45366509-0993-5c35-9920-3fb341f0b333', 'objective', 'Identify attributes, entity types, primary keys, relationships when given a scenario related to database modelling.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('45366509-0993-5c35-9920-3fb341f0b333', 'objective', 'Produce simple ER diagrams (maximum 3 entities) for a given real-life scenario using Chen or Crow’s foot notations.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('45366509-0993-5c35-9920-3fb341f0b333', 'objective', 'Describe the main types of normal forms (1NF, 2NF, and 3NF).', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '053d2a10-48a7-5682-9725-4e389505547a', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'a60b7173-21a6-5d56-8660-147722e05933',
  66, 66, 'Normalisation and converting ER model to relational model.',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('053d2a10-48a7-5682-9725-4e389505547a', 'objective', 'Transform entities into 1NF, 2NF and 3NF.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('053d2a10-48a7-5682-9725-4e389505547a', 'objective', 'Verify the respect of normal forms by an ER model.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('053d2a10-48a7-5682-9725-4e389505547a', 'objective', 'Outline rules for moving from an ER model to a relational model.', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('053d2a10-48a7-5682-9725-4e389505547a', 'objective', 'Transform an ER model into a relational model.', 'apply', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '25ac369c-eef6-591c-8e4c-226f65a6b546', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'a60b7173-21a6-5d56-8660-147722e05933',
  67, 67, 'Implementing a relational model',
  2, 19, 19,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('25ac369c-eef6-591c-8e4c-226f65a6b546', 'objective', 'Explain the concepts of DBMS and RDBMS.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('25ac369c-eef6-591c-8e4c-226f65a6b546', 'objective', 'State examples of Relational Database Management Systems (Access, Open base, MySQL).', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('25ac369c-eef6-591c-8e4c-226f65a6b546', 'objective', 'Represent a relational model using a relational database management system (Access, Open base, MySQL).', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd8b19cce-7b4e-5f61-9eb8-fb1e9b85054a', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'a60b7173-21a6-5d56-8660-147722e05933',
  68, 68, 'Using an RDBMS for sorting, filtering and queries',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d8b19cce-7b4e-5f61-9eb8-fb1e9b85054a', 'objective', 'Explain the concepts of sorting, filtering and queries as used in databases.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d8b19cce-7b4e-5f61-9eb8-fb1e9b85054a', 'objective', 'Perform sorting and filtering using an RDBMS.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d8b19cce-7b4e-5f61-9eb8-fb1e9b85054a', 'objective', 'Write an execute queries using an RDBMS.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'daed1695-f6d8-5316-87ea-4e715bfc3197', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  NULL,
  NULL, NULL, 'Integration Activity No 4',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('daed1695-f6d8-5316-87ea-4e715bfc3197', 'objective', 'Given a stated information system project (the one modelled in Integration Activity No 4, or a new case), produce a simple prototype or simulation, including a multimedia/VR-AR element where relevant.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('daed1695-f6d8-5316-87ea-4e715bfc3197', 'objective', 'Model the system''s data using an Entity Relationship diagram and explain the relationships identified.', 'create', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('daed1695-f6d8-5316-87ea-4e715bfc3197', 'objective', 'Explain how the prototype and data model would guide full system development.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'b4778cb6-d19f-5f20-8ec0-598f222a06e9', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '058df9b2-0004-583a-b7c2-295fac317f2c',
  69, 69, 'Types of software testing',
  2, 20, 20,
  true, false, false,
  'content', 80
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4778cb6-d19f-5f20-8ec0-598f222a06e9', 'objective', 'Explain the concept of software testing.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4778cb6-d19f-5f20-8ec0-598f222a06e9', 'objective', 'Explain reasons for testing an information system.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4778cb6-d19f-5f20-8ec0-598f222a06e9', 'objective', 'Differentiate between black-box and white box testing.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4778cb6-d19f-5f20-8ec0-598f222a06e9', 'objective', 'Describe types of testing by explaining how they work, their purpose, and who conducts the test (system testing, volume testing, module testing, integration testing, acceptance testing).', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('b4778cb6-d19f-5f20-8ec0-598f222a06e9', 'objective', 'Select a suitable testing method for a given context.', 'evaluate', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '02b219b2-fca9-53cd-9362-0c723ad50982', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '058df9b2-0004-583a-b7c2-295fac317f2c',
  70, 70, 'Module testing',
  2, 20, 20,
  true, false, false,
  'content', 81
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('02b219b2-fca9-53cd-9362-0c723ad50982', 'objective', 'Explain the concepts of test case, test data, bug, actual results, expected results, and test report as used in software testing.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('02b219b2-fca9-53cd-9362-0c723ad50982', 'objective', 'Outline the procedure for module testing.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('02b219b2-fca9-53cd-9362-0c723ad50982', 'objective', 'Carry out the procedure for module testing.', 'apply', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('02b219b2-fca9-53cd-9362-0c723ad50982', 'objective', 'Identify how AI-powered testing tools can automatically generate test cases and flag anomalies.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2f5fd5a3-e9a0-547e-a499-bc428a5f88f8', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '058df9b2-0004-583a-b7c2-295fac317f2c',
  NULL, NULL, 'Evaluation No 4',
  2, 21, 21,
  true, false, false,
  'evaluation', 82
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
  '75541fc4-e26b-5764-8757-3cde7c444ec9', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '058df9b2-0004-583a-b7c2-295fac317f2c',
  NULL, NULL, 'Remediation No 4',
  2, 21, 21,
  true, false, false,
  'remediation', 83
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('75541fc4-e26b-5764-8757-3cde7c444ec9', 'objective', 'Review and correct the common errors identified in Evaluation No 4.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('75541fc4-e26b-5764-8757-3cde7c444ec9', 'objective', 'Reinforce weak areas in emerging technologies, systems design and database modelling through guided practice.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('75541fc4-e26b-5764-8757-3cde7c444ec9', 'objective', 'Support learners who under-performed before continuing with the next block.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '7cab8797-7518-579d-ae23-ad7a45e40bed', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '058df9b2-0004-583a-b7c2-295fac317f2c',
  71, 71, 'Introduction to data representation and number systems',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7cab8797-7518-579d-ae23-ad7a45e40bed', 'objective', 'Explain the concept of data representation and number system.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7cab8797-7518-579d-ae23-ad7a45e40bed', 'objective', 'Explain how data is represented in the computer.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7cab8797-7518-579d-ae23-ad7a45e40bed', 'objective', 'Differentiate between bit, nibble, byte, and word.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7cab8797-7518-579d-ae23-ad7a45e40bed', 'objective', 'Identify number systems (binary, octal, decimal, hexadecimal).', 'analyse', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7cab8797-7518-579d-ae23-ad7a45e40bed', 'objective', 'Convert from base 10 to base 2, 8 and 16.', 'apply', 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('7cab8797-7518-579d-ae23-ad7a45e40bed', 'objective', 'Explain how positive numbers are represented in the computer.', 'understand', 6);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'c89fa51a-73d1-592d-8fc4-be67a5307794', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '2669441c-d28a-5263-9573-dcd185ec34e0',
  72, 72, 'Conversion between number systems and representing negative numbers',
  2, 21, 21,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c89fa51a-73d1-592d-8fc4-be67a5307794', 'objective', 'Convert from base 2, 8, and 16 to base 10.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c89fa51a-73d1-592d-8fc4-be67a5307794', 'objective', 'Outline ways of representing negative numbers.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c89fa51a-73d1-592d-8fc4-be67a5307794', 'objective', 'Describe sign magnitude, One’s complement, and two’s complement representation.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('c89fa51a-73d1-592d-8fc4-be67a5307794', 'objective', 'Compute one''s complement and two''s complement of a binary number.', 'apply', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a7b69421-821f-5acb-a206-67e580cceae2', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '2669441c-d28a-5263-9573-dcd185ec34e0',
  73, 73, 'Subtraction and representing negative numbers',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a7b69421-821f-5acb-a206-67e580cceae2', 'objective', 'Perform addition in base 2, 8, and 16.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a7b69421-821f-5acb-a206-67e580cceae2', 'objective', 'Carry out subtraction in base 2, 8 and 16.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1e74c24f-936b-52ae-8f69-da716df1f460', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '89d29b21-7f91-5bb5-b490-4cf26298f774',
  74, 74, 'Logic gates',
  2, 22, 22,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e74c24f-936b-52ae-8f69-da716df1f460', 'objective', 'Identify different logic gates (OR, AND, NOT, NAND, NOR, XOR, XNOR).', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e74c24f-936b-52ae-8f69-da716df1f460', 'objective', 'Sketch logic gate symbols.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1e74c24f-936b-52ae-8f69-da716df1f460', 'objective', 'Draw truth tables for given logic gates and expressions (up to 3 input variables).', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '807fd404-e36e-53c7-aeb4-a01259217bef', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '89d29b21-7f91-5bb5-b490-4cf26298f774',
  75, 75, 'Logic circuits',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('807fd404-e36e-53c7-aeb4-a01259217bef', 'objective', 'Explain the concepts of logic circuit and Boolean expressions.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('807fd404-e36e-53c7-aeb4-a01259217bef', 'objective', 'Derive a logic circuit from a Boolean expression.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('807fd404-e36e-53c7-aeb4-a01259217bef', 'objective', 'Derive a Boolean expression from a logic circuit.', 'apply', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('807fd404-e36e-53c7-aeb4-a01259217bef', 'objective', 'Produce a truth table from a Boolean expression or logic circuit.', 'apply', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2ff82afc-948c-552f-ad7b-e9d7632786bc', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '89d29b21-7f91-5bb5-b490-4cf26298f774',
  76, 76, 'Boolean expressions from truth table and De Morgan’s laws',
  2, 22, 22,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ff82afc-948c-552f-ad7b-e9d7632786bc', 'objective', 'State the ways of getting a Boolean expression from a truth table.', 'remember', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ff82afc-948c-552f-ad7b-e9d7632786bc', 'objective', 'Derive Boolean expressions from truth tables.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ff82afc-948c-552f-ad7b-e9d7632786bc', 'objective', 'State the De Morgan’s laws.', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2ff82afc-948c-552f-ad7b-e9d7632786bc', 'objective', 'Establish the correctness of the De Morgan’s laws.', 'evaluate', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '85064535-c45c-5683-bbe9-4ed4a629d271', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '89d29b21-7f91-5bb5-b490-4cf26298f774',
  77, 77, 'Simplification of Boolean expressions',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('85064535-c45c-5683-bbe9-4ed4a629d271', 'objective', 'Explain the purpose and advantages of simplifying Boolean expressions.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('85064535-c45c-5683-bbe9-4ed4a629d271', 'objective', 'State laws used in simplifying Boolean expressions.', 'remember', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('85064535-c45c-5683-bbe9-4ed4a629d271', 'objective', 'Simplify a Boolean expression using appropriate laws.', 'apply', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('85064535-c45c-5683-bbe9-4ed4a629d271', 'objective', 'Identify when to use De Morgan’s laws in Boolean simplification.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '8a315fa7-2be1-5c47-b327-1f3c865cc3a1', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'd330ecdb-a288-5bb1-b280-032796a90f61',
  78, 78, 'Data Types and Data structures',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a315fa7-2be1-5c47-b327-1f3c865cc3a1', 'objective', 'Identify standard data types (integer, real, Boolean, character, string).', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a315fa7-2be1-5c47-b327-1f3c865cc3a1', 'objective', 'Choose a suitable data type for a simple problem.', 'evaluate', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a315fa7-2be1-5c47-b327-1f3c865cc3a1', 'objective', 'Explain what a data structure is and why it is useful.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a315fa7-2be1-5c47-b327-1f3c865cc3a1', 'objective', 'Describe arrays, records, stack, and queue.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('8a315fa7-2be1-5c47-b327-1f3c865cc3a1', 'objective', 'Choose appropriate data structure in a given situation.', 'evaluate', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '89335fc8-06e8-5a30-a810-2c6c3a13104f', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'd330ecdb-a288-5bb1-b280-032796a90f61',
  79, 79, 'Operations on data structures',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('89335fc8-06e8-5a30-a810-2c6c3a13104f', 'objective', 'Explain how elements are accessed in arrays, records, stack, and queue.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('89335fc8-06e8-5a30-a810-2c6c3a13104f', 'objective', 'Carry out common operations on arrays, records, stack, and queue.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('89335fc8-06e8-5a30-a810-2c6c3a13104f', 'objective', 'Combine arrays and records to construct new data types.', 'create', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd74e4ecd-cc01-59ee-9fb7-d2116d358f98', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  NULL,
  NULL, NULL, 'Integration Activity No 5',
  2, 23, 23,
  true, false, false,
  'integration_activity', 93
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d74e4ecd-cc01-59ee-9fb7-d2116d358f98', 'objective', 'Turn the Entity Relationship model from Integration Activity No 5 (or a new stated case) into a normalised relational database, and test it for correctness.', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d74e4ecd-cc01-59ee-9fb7-d2116d358f98', 'objective', 'Solve a stated problem using binary arithmetic/number-base conversion, and represent its logic using a logic circuit or Boolean expression.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d74e4ecd-cc01-59ee-9fb7-d2116d358f98', 'objective', 'Explain how correct logic and thorough testing underpin a reliable database/system.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3af33401-bd4d-5f18-be45-82efa610ef9d', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'e1036e41-be20-5f29-b943-18298e4af913',
  80, 80, 'Approaches to Software Design',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3af33401-bd4d-5f18-be45-82efa610ef9d', 'objective', 'Describe the following software design techniques top-down design, stepwise refinement, incremental construction, divide- and-conquer, bottom-up design and modular design.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3af33401-bd4d-5f18-be45-82efa610ef9d', 'objective', 'Select a suitable design method for a given problem.', 'evaluate', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0675ba71-689f-5055-a86e-988b44f204b5', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'e1036e41-be20-5f29-b943-18298e4af913',
  81, 81, 'Applying software design techniques',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0675ba71-689f-5055-a86e-988b44f204b5', 'objective', 'Break down a problem into smaller units using a software design technique.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0675ba71-689f-5055-a86e-988b44f204b5', 'objective', 'Adapt an existing solution to a new problem.', 'create', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e3df1dfc-82fa-5261-adc6-4f448106d8f5', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'e1036e41-be20-5f29-b943-18298e4af913',
  82, 82, 'Representing Software Design',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e3df1dfc-82fa-5261-adc6-4f448106d8f5', 'objective', 'Explain the uses of unit and structure diagrams (class, sequence, composite).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e3df1dfc-82fa-5261-adc6-4f448106d8f5', 'objective', 'Describe the Unified Modelling Language (UML) model.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e3df1dfc-82fa-5261-adc6-4f448106d8f5', 'objective', 'Sketch a structure diagram for a given software design scenario.', 'remember', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '1f240df6-f563-55fc-a25a-737371a162f5', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'e1036e41-be20-5f29-b943-18298e4af913',
  83, 83, 'Introduction to Algorithms',
  2, 24, 24,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1f240df6-f563-55fc-a25a-737371a162f5', 'objective', 'Explain what an algorithm is.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1f240df6-f563-55fc-a25a-737371a162f5', 'objective', 'Explain the characteristics of an algorithm.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1f240df6-f563-55fc-a25a-737371a162f5', 'objective', 'Outline the different ways of representing an algorithm.', 'remember', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1f240df6-f563-55fc-a25a-737371a162f5', 'objective', 'State advantages and disadvantages of pseudocode and flowcharts.', 'remember', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '2a0dcd22-fc89-5ef1-babc-af837b411dae', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  84, 84, 'Algorithmic instructions',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2a0dcd22-fc89-5ef1-babc-af837b411dae', 'objective', 'Describe declarative, input, output, and assignment instructions.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('2a0dcd22-fc89-5ef1-babc-af837b411dae', 'objective', 'Describe the different types of control structures.', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '9050ff22-3b26-5f6e-959c-da6b2ce4cef0', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  85, 85, 'Representing Algorithms — Flowcharts',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9050ff22-3b26-5f6e-959c-da6b2ce4cef0', 'objective', 'Represent algorithms using flowcharts.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9050ff22-3b26-5f6e-959c-da6b2ce4cef0', 'objective', 'Use standard flowchart symbols correctly.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('9050ff22-3b26-5f6e-959c-da6b2ce4cef0', 'objective', 'Draw a flowchart for a simple real-life problem.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '090d233e-f8b5-57e2-9124-a788f3c9a953', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  86, 86, 'Representing Algorithms — Pseudocode',
  3, 25, 25,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('090d233e-f8b5-57e2-9124-a788f3c9a953', 'objective', 'Represent algorithms using pseudocode.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('090d233e-f8b5-57e2-9124-a788f3c9a953', 'objective', 'Write pseudocode for a simple real-life problems.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('090d233e-f8b5-57e2-9124-a788f3c9a953', 'objective', 'Distinguish a rule-based algorithm from a machine-learning algorithm that learns its own rules from data.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '87b746de-e15c-5ecd-aaf3-71b78c44dd95', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  87, 87, 'Control Structures — Sequence and Selection',
  3, 25, 25,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('87b746de-e15c-5ecd-aaf3-71b78c44dd95', 'objective', 'Write algorithms using sequence constructs.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('87b746de-e15c-5ecd-aaf3-71b78c44dd95', 'objective', 'Write algorithms using selection constructs.', 'apply', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '0230bd6e-5ad6-5ea6-b4ad-99ca63e6fadf', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  88, 88, 'Control Structures — Loops',
  3, 26, 26,
  true, false, false,
  'content', 102
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0230bd6e-5ad6-5ea6-b4ad-99ca63e6fadf', 'objective', 'Describe the different types of loops.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0230bd6e-5ad6-5ea6-b4ad-99ca63e6fadf', 'objective', 'Write algorithms that make use of the loop control structure.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('0230bd6e-5ad6-5ea6-b4ad-99ca63e6fadf', 'objective', 'Differentiate between loops and recursion.', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '740c4748-0551-5d26-abc7-88dc5d230476', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  89, 89, 'Sorting and Searching',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('740c4748-0551-5d26-abc7-88dc5d230476', 'objective', 'Explain searching techniques (binary and sequential searches).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('740c4748-0551-5d26-abc7-88dc5d230476', 'objective', 'Explain sorting techniques (bubble, merge and insertion sorts).', 'understand', 2);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '90ad241c-0b77-51d2-894d-6ff0bf740716', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  90, 90, 'Establishing Correctness of Algorithms',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90ad241c-0b77-51d2-894d-6ff0bf740716', 'objective', 'Explain the concepts of dry running and trace tables.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90ad241c-0b77-51d2-894d-6ff0bf740716', 'objective', 'Establish the correctness of an algorithm using dry running.', 'evaluate', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('90ad241c-0b77-51d2-894d-6ff0bf740716', 'objective', 'Draw a trace table for an algorithm.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '26bb72a0-879a-5fd2-8e1d-d4a1002320e8', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  91, 91, 'Evaluating Algorithm Performance',
  3, 26, 26,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('26bb72a0-879a-5fd2-8e1d-d4a1002320e8', 'objective', 'Explain the concept of complexity of an algorithm.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('26bb72a0-879a-5fd2-8e1d-d4a1002320e8', 'objective', 'Examine the performance of an algorithm using time efficiency.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('26bb72a0-879a-5fd2-8e1d-d4a1002320e8', 'objective', 'Compare two algorithms solving the same problem based on time efficiency.', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('26bb72a0-879a-5fd2-8e1d-d4a1002320e8', 'objective', 'Explain how accuracy, precision and recall are used to evaluate the performance of an AI/machine-learning algorithm.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '432bfe2f-0b27-5c5c-bf66-b8b33ece5ec9', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  NULL, NULL, 'Evaluation No 5',
  3, 27, 27,
  true, false, false,
  'evaluation', 106
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
  '1aa282ed-2c8f-56cf-b0d7-8e1f96c61549', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'b7db2566-60df-540e-a8fc-a03089929f1a',
  NULL, NULL, 'Remediation No 5',
  3, 27, 27,
  true, false, false,
  'remediation', 107
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1aa282ed-2c8f-56cf-b0d7-8e1f96c61549', 'objective', 'Review and correct the common errors identified in Evaluation No 5.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1aa282ed-2c8f-56cf-b0d7-8e1f96c61549', 'objective', 'Reinforce weak areas in binary arithmetic, logic circuits and algorithm writing through guided practice.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('1aa282ed-2c8f-56cf-b0d7-8e1f96c61549', 'objective', 'Support learners who under-performed before moving into the final programming block of Third Term.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6c319b75-fe57-563c-8bab-57538f50c983', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'f2fbc32f-b43b-544a-9bee-83faa31da178',
  92, 92, 'Programming Paradigms',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6c319b75-fe57-563c-8bab-57538f50c983', 'objective', 'Distinguish between types of programming paradigms (imperative/procedural, declarative, functional, logic and object- oriented).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6c319b75-fe57-563c-8bab-57538f50c983', 'objective', 'Explain the relative advantages and disadvantages of each paradigm.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6c319b75-fe57-563c-8bab-57538f50c983', 'objective', 'Explain the properties of object-oriented programming (encapsulation, polymorphism).', 'understand', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3be9132f-5389-59d7-88a4-9f3d8fcf32cf', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'f2fbc32f-b43b-544a-9bee-83faa31da178',
  93, 93, 'Software Reuse',
  3, 27, 27,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3be9132f-5389-59d7-88a4-9f3d8fcf32cf', 'objective', 'Explain software reuse and the importance of library units, repositories and software packages.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3be9132f-5389-59d7-88a4-9f3d8fcf32cf', 'objective', 'Explain the types of software reuse (internal and external).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3be9132f-5389-59d7-88a4-9f3d8fcf32cf', 'objective', 'Explain the criteria for selecting software for reuse (reduce development cost, time, labour, maintenance effort, etc).', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3be9132f-5389-59d7-88a4-9f3d8fcf32cf', 'objective', 'Identify popular AI/machine-learning libraries and frameworks as an example of software reuse.', 'analyse', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '48ebc7e6-8b9e-5665-8a9b-35d5ca7688a2', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'f2fbc32f-b43b-544a-9bee-83faa31da178',
  94, 94, 'Internally versus Externally Developed Software',
  3, 28, 28,
  true, false, false,
  'content', 110
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('48ebc7e6-8b9e-5665-8a9b-35d5ca7688a2', 'objective', 'Distinguish between internally and externally developed software.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('48ebc7e6-8b9e-5665-8a9b-35d5ca7688a2', 'objective', 'Determine the importance of software reuse when outsourcing.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('48ebc7e6-8b9e-5665-8a9b-35d5ca7688a2', 'objective', 'Explain the advantages and disadvantages of internally developed software and externally developed software.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('48ebc7e6-8b9e-5665-8a9b-35d5ca7688a2', 'objective', 'Choose between developing software internally or externally for a given context.', 'evaluate', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '53a3e043-d136-5ca8-a1d4-6dc5e7afd43a', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  NULL,
  NULL, NULL, 'Integration Activity No 6',
  3, 28, 28,
  true, false, false,
  'integration_activity', 111
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53a3e043-d136-5ca8-a1d4-6dc5e7afd43a', 'objective', 'Given a stated problem, design a solution using appropriate data structures and represent it as an algorithm (flowchart or pseudocode).', NULL, 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53a3e043-d136-5ca8-a1d4-6dc5e7afd43a', 'objective', 'Trace and test the algorithm against sample data, evaluating its correctness and efficiency.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('53a3e043-d136-5ca8-a1d4-6dc5e7afd43a', 'objective', 'Refine the algorithm/design based on the evaluation.', 'create', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '33d59e1f-4892-5cd6-bbb8-d52d635d866e', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'c1597efa-27c6-5b16-85f0-4fd053988465',
  95, 95, 'Language Translators and IDE',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('33d59e1f-4892-5cd6-bbb8-d52d635d866e', 'objective', 'Differentiate between language translators (compiler, interpreter, assembler).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('33d59e1f-4892-5cd6-bbb8-d52d635d866e', 'objective', 'Explain advantages and disadvantages of a given language translator.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('33d59e1f-4892-5cd6-bbb8-d52d635d866e', 'objective', 'Explain lexical analysis, code generation, parsing and preprocessing.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('33d59e1f-4892-5cd6-bbb8-d52d635d866e', 'objective', 'Explain the concept of IDE and give examples.', 'understand', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('33d59e1f-4892-5cd6-bbb8-d52d635d866e', 'objective', 'Outline core features of an IDE.', 'remember', 5);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '196cf332-121b-5aba-ac2a-24cba302622d', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'c1597efa-27c6-5b16-85f0-4fd053988465',
  96, 96, 'introduction to coding',
  3, 28, 28,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('196cf332-121b-5aba-ac2a-24cba302622d', 'objective', 'Explain the concept of program, coding, and programming language.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('196cf332-121b-5aba-ac2a-24cba302622d', 'objective', 'Install an IDE.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('196cf332-121b-5aba-ac2a-24cba302622d', 'objective', 'Explain strategies that can help learners easily adapt and use a programming language.', 'understand', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('196cf332-121b-5aba-ac2a-24cba302622d', 'objective', 'Explain the meaning of syntax and semantics as used in programming.', 'understand', 4);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'be852494-7c87-5e04-a257-1b99ea3bec3c', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'c1597efa-27c6-5b16-85f0-4fd053988465',
  97, 97, 'Writing code 1 (C or Python)',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be852494-7c87-5e04-a257-1b99ea3bec3c', 'objective', 'Identify the structure of a python or C program.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be852494-7c87-5e04-a257-1b99ea3bec3c', 'objective', 'Write input, output, and assignment instructions in C and python.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('be852494-7c87-5e04-a257-1b99ea3bec3c', 'objective', 'Write and debug simple programs in C or Python.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'efacb5d1-146c-5e28-a7c7-f2371f4e70f4', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'c1597efa-27c6-5b16-85f0-4fd053988465',
  98, 98, 'Writing code 2',
  3, 29, 29,
  true, false, false,
  'content', 115
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('efacb5d1-146c-5e28-a7c7-f2371f4e70f4', 'objective', 'Write and debug programs in C or Python that make use of selection control structures.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '020d7563-9060-5407-9aff-faa3a9896fd4', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'c1597efa-27c6-5b16-85f0-4fd053988465',
  99, 99, 'writing code 3',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('020d7563-9060-5407-9aff-faa3a9896fd4', 'objective', 'Write and debug programs in C or Python that make use of loop control structures.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'a230e376-6614-52ab-8f91-60ec94ff3fde', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'c1597efa-27c6-5b16-85f0-4fd053988465',
  100, 100, 'writing code 4',
  3, 29, 29,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('a230e376-6614-52ab-8f91-60ec94ff3fde', 'objective', 'Write and debug programs in C or Python that make use of arrays.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'd747fb28-8e7d-58fd-a114-d14016d70f07', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  'c1597efa-27c6-5b16-85f0-4fd053988465',
  101, 101, 'writing code 5',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('d747fb28-8e7d-58fd-a114-d14016d70f07', 'objective', 'Write and debug programs in C or Python that make use of arrays and records.', 'apply', 1);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '34a0537c-4078-5228-8332-3e0ee7cf9473', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '6c6f4f78-d9e8-58f0-9640-96df4f295b36',
  102, 102, 'Functions and procedures 1',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34a0537c-4078-5228-8332-3e0ee7cf9473', 'objective', 'Explain the importance of functions and procedures when writing programs (clarity, efficiency, reuse, maintainability).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34a0537c-4078-5228-8332-3e0ee7cf9473', 'objective', 'Explain the difference between functions and procedures.', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34a0537c-4078-5228-8332-3e0ee7cf9473', 'objective', 'Identify core components of a function (name, parameters, output).', 'analyse', 3);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34a0537c-4078-5228-8332-3e0ee7cf9473', 'objective', 'Write functions in C or Python that solve specific problems.', 'apply', 4);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34a0537c-4078-5228-8332-3e0ee7cf9473', 'objective', 'Perform function or procedure calls in C or Python.', 'apply', 5);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('34a0537c-4078-5228-8332-3e0ee7cf9473', 'objective', 'Explain stack mechanism for function call and parameter passing.', 'understand', 6);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  'e58ea640-a2fe-5a58-9b97-5db645aed024', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '6c6f4f78-d9e8-58f0-9640-96df4f295b36',
  103, 103, 'Functions and procedures 2',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e58ea640-a2fe-5a58-9b97-5db645aed024', 'objective', 'Write functions in C or Python that solve specific problems and debugged them.', 'apply', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e58ea640-a2fe-5a58-9b97-5db645aed024', 'objective', 'Perform function or procedure calls in C or Python.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('e58ea640-a2fe-5a58-9b97-5db645aed024', 'objective', 'Dry run a function call showing stack mechanisms.', NULL, 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '048e6fd1-ba47-582c-a0c2-3daa7bd9c3d5', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '6c6f4f78-d9e8-58f0-9640-96df4f295b36',
  104, 104, 'Testing a program 1',
  3, 30, 30,
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('048e6fd1-ba47-582c-a0c2-3daa7bd9c3d5', 'objective', 'Explain the steps involved in software testing (code review, static code analysis, unit testing, system testing).', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('048e6fd1-ba47-582c-a0c2-3daa7bd9c3d5', 'objective', 'Explain debugging and compare debugging techniques (brute force, induction, backtracking).', 'understand', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('048e6fd1-ba47-582c-a0c2-3daa7bd9c3d5', 'objective', 'Test a program using appropriate methods and tools.', 'analyse', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '6a5d140b-1f59-5026-9250-132298b2c8f0', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '6c6f4f78-d9e8-58f0-9640-96df4f295b36',
  105, 105, 'Testing a program 2',
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
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6a5d140b-1f59-5026-9250-132298b2c8f0', 'objective', 'Test and debug a program using appropriate methods and tools.', 'analyse', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6a5d140b-1f59-5026-9250-132298b2c8f0', 'objective', 'Test a developed program using boundary, correct and erroneous data.', 'analyse', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('6a5d140b-1f59-5026-9250-132298b2c8f0', 'objective', 'Produce a test report.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '61bdfa2e-5fcf-51ad-93e9-f9db71bad032', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '6c6f4f78-d9e8-58f0-9640-96df4f295b36',
  NULL, NULL, 'Evaluation No 6',
  3, 31, 31,
  true, false, false,
  'evaluation', 123
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
  '3431f40e-24f7-529b-82fa-862b45cc448a', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  '6c6f4f78-d9e8-58f0-9640-96df4f295b36',
  NULL, NULL, 'Remediation No 6',
  3, 31, 31,
  true, false, false,
  'remediation', 124
) ON CONFLICT (id) DO UPDATE SET
  module_id = EXCLUDED.module_id, competency_id = EXCLUDED.competency_id,
  lesson_no_start = EXCLUDED.lesson_no_start, lesson_no_end = EXCLUDED.lesson_no_end,
  title = EXCLUDED.title, term = EXCLUDED.term, week_from = EXCLUDED.week_from,
  week_to = EXCLUDED.week_to, is_theory = EXCLUDED.is_theory,
  is_practical = EXCLUDED.is_practical, is_digitalised = EXCLUDED.is_digitalised,
  lesson_kind = EXCLUDED.lesson_kind, sequence = EXCLUDED.sequence,
  deleted_at = NULL, updated_at = now();
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3431f40e-24f7-529b-82fa-862b45cc448a', 'objective', 'Review and correct the common errors identified in Evaluation No 6.', 'understand', 1);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3431f40e-24f7-529b-82fa-862b45cc448a', 'objective', 'Reinforce weak areas covered across the final programming and testing block through guided revision.', 'apply', 2);
INSERT INTO objectives (lesson_id, kind, description, bloom_level, sequence) VALUES ('3431f40e-24f7-529b-82fa-862b45cc448a', 'objective', 'Support learners in final preparation for end-of-year requirements. VISION PROGRAM.', 'apply', 3);
INSERT INTO lessons (
  id, syllabus_id, module_id, competency_id, lesson_no_start, lesson_no_end,
  title, term, week_from, week_to, is_theory, is_practical, is_digitalised,
  lesson_kind, sequence
) VALUES (
  '3017c889-fb7a-53fb-a6c0-ae5afdba3069', (SELECT id FROM target_syllabus), '4ec0615d-ca9c-5b3c-8105-8eadaf108c60',
  NULL,
  NULL, NULL, 'Revision',
  3, 32, 36,
  true, false, false,
  'revision', 125
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
