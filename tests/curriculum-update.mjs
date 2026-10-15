import { PGlite } from '@electric-sql/pglite';
import { readFileSync } from 'node:fs';
import assert from 'node:assert/strict';
const db = new PGlite();
const read = (name) => readFileSync(new URL('../'+name, import.meta.url), 'utf8');
await db.exec(read('db/schema.sql').replace('CREATE EXTENSION IF NOT EXISTS "pgcrypto";', ''));
await db.exec('ALTER TABLE note_sources ADD COLUMN syllabus_id UUID REFERENCES syllabi(id);');
await db.exec('ALTER TABLE attempts ADD COLUMN lesson_id UUID REFERENCES lessons(id);');
const seed = async (name) => {
 try { await db.exec(read(name)); }
 catch (e) { console.error(name, e.message, e.query?.slice(0,200)); process.exit(1); }
};
await seed('db/seed/02_form5_computer_science.sql');
await seed('db/seed/03_lower_sixth_ict.sql');
const snapshot = async () => (await db.query(`SELECT s.id, s.title, count(l.id)::int as rows FROM syllabi s JOIN lessons l ON l.syllabus_id=s.id AND l.deleted_at IS NULL WHERE s.form_level='Form 5' GROUP BY s.id`)).rows;
const form5 = await snapshot();
await seed('db/seed/12_lower_sixth_computer_science.sql');
const before = (await db.query('SELECT count(*)::int as n FROM objectives')).rows[0].n;
await seed('db/seed/12_lower_sixth_computer_science.sql');
await seed('db/seed/03_lower_sixth_ict.sql');
assert.equal((await db.query('SELECT count(*)::int as n FROM objectives')).rows[0].n, before);
assert.deepEqual(await snapshot(),form5);
const rows=(await db.query(`SELECT sub.name,count(l.id)::int as rows FROM syllabi s JOIN subjects sub ON sub.id=s.subject_id JOIN lessons l ON l.syllabus_id=s.id WHERE s.form_level='Lower Sixth' AND l.deleted_at IS NULL GROUP BY sub.name`)).rows;
assert.equal(rows.length,2);
assert.equal(rows.find(x=>x.name==='Computer Science').rows,137);
// Check the retirement script with a real stored class and syllabus.
await db.exec(`INSERT INTO syllabi(subject_id,level_id,title,form_level,version_label,effective_from) SELECT subject_id,level_id,'Old Form 4','Form 4','old',2025 FROM syllabi LIMIT 1;`);
await seed('db/retire_form4.sql');
await seed('db/retire_form4.sql');
assert.equal((await db.query("SELECT count(*)::int as n FROM syllabi WHERE form_level='Form 4' AND deleted_at IS NULL")).rows[0].n,0);
assert.equal((await db.query("SELECT count(*)::int as n FROM syllabi WHERE form_level='Form 4'")).rows[0].n,1);
console.log('SQL executes successfully. Repeat imports preserve Form 5, keep ICT and CS separate, and retire Form 4 without destroying records.');
await db.close();
