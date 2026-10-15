import {PGlite} from '@electric-sql/pglite';
import {readFileSync,readdirSync,mkdtempSync,rmSync} from 'node:fs';
import {execFileSync} from 'node:child_process';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import assert from 'node:assert/strict';
const read=p=>readFileSync(new URL('../'+p,import.meta.url),'utf8');
const root=new URL('../',import.meta.url).pathname;
const temp=mkdtempSync(join(tmpdir(),'gce-minesec-'));
execFileSync('python3',[root+'tools/load_minesec_archive.py',root+'db/imports/minesec/computer_science_ol.json',temp]);
const db=new PGlite();
try{
 await db.exec(read('db/schema.sql').replace('CREATE EXTENSION IF NOT EXISTS "pgcrypto";',''));
 await db.exec(`CREATE ROLE authenticated;CREATE FUNCTION public.is_teacher() RETURNS boolean LANGUAGE sql AS 'SELECT true'; ALTER TABLE questions ADD needs_review boolean NOT NULL DEFAULT false, ADD import_batch text, ADD import_page integer, ADD import_flags text[]; ALTER TABLE note_sources ADD syllabus_id uuid; ALTER TABLE attempts ADD lesson_id uuid;`);
 await db.exec(read('db/seed/02_form5_computer_science.sql'));
 await db.exec(read('db/phase16_past_paper_archive.sql'));
 const dataset=JSON.parse(read('db/imports/minesec/computer_science_ol.json'));
 const first=dataset.questions[0],existing='00000000-0000-4000-8000-000000000001';
 const syllabus=(await db.query("SELECT id FROM syllabi WHERE form_level='Form 5' AND deleted_at IS NULL LIMIT 1")).rows[0].id;
 await db.query("INSERT INTO questions(id,syllabus_id,question_text,question_type,marks,needs_review,auto_markable,model_answer) VALUES($1,$2,$3,$4,1,false,true,'Reviewed answer')",[existing,syllabus,first.text,first.type]);
 for(let i=0;i<first.options.length;i++){const o=first.options[i];await db.query('INSERT INTO question_options(question_id,label,option_text,is_correct,sequence) VALUES($1,$2,$3,$4,$5)',[existing,o.label,o.option_text,o.label==='C',i+1]);}
 let snapshot;
 for(let run=0;run<2;run++){
  for(const f of readdirSync(temp).sort())await db.exec(readFileSync(join(temp,f),'utf8'));
  const result=(await db.query(`SELECT (SELECT count(*)::int FROM questions) AS questions,(SELECT count(*)::int FROM question_options) AS options,(SELECT count(*)::int FROM exam_paper_questions) AS links`)).rows[0];
  if(run===0)snapshot=result;else assert.deepEqual(result,snapshot);
 }
 assert.equal((await db.query('SELECT count(*)::int n FROM exam_papers')).rows[0].n,39);
 assert.equal((await db.query('SELECT count(*)::int n FROM exam_paper_sources')).rows[0].n,53);
 assert.equal((await db.query('SELECT count(*)::int n FROM exam_paper_questions')).rows[0].n,565);
 assert.equal((await db.query("SELECT count(*)::int n FROM questions WHERE auto_markable AND import_batch='minesec-ol-cs-2026-10'")).rows[0].n,0);
 const approved=(await db.query('SELECT model_answer,needs_review,auto_markable FROM questions WHERE id=$1',[existing])).rows[0];
 assert.deepEqual(approved,{model_answer:'Reviewed answer',needs_review:false,auto_markable:true});
 assert.ok((await db.query('SELECT count(*)::int n FROM exam_paper_questions WHERE question_id=$1',[existing])).rows[0].n>0);
 console.log('Archive imports repeat without duplicates, retain all 53 sources, and leave unchecked questions out of automatic marking.');
}finally{await db.close();rmSync(temp,{recursive:true,force:true});}
