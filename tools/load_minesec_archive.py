"""Emit repeatable SQL for the MINESEC archive. No approved question is edited.
Usage: python3 tools/load_minesec_archive.py db/imports/minesec/computer_science_ol.json OUTPUT_DIRECTORY
Apply db/phase16_past_paper_archive.sql before the numbered output files.
"""
import json,sys
from pathlib import Path

def quote(v):return "'"+str(v).replace("'","''")+"'"
def payload(v):
 return quote(json.dumps(v,ensure_ascii=False))+ '::jsonb'
TARGET="(SELECT s.id FROM public.syllabi s JOIN public.subjects sub ON sub.id=s.subject_id WHERE s.form_level='Form 5' AND sub.name='Computer Science' AND s.deleted_at IS NULL LIMIT 1)"
CANON="regexp_replace(lower(%s),'\\s+',' ','g')"

def emit(doc,out):
 out.mkdir(parents=True,exist_ok=True)
 # Full source text is kept once per SHA-256. Every catalogue URL remains linked.
 sql=['BEGIN;',f'CREATE TEMP TABLE archive_target ON COMMIT DROP AS SELECT {TARGET} AS id;',"DO $$ BEGIN IF (SELECT id FROM archive_target) IS NULL THEN RAISE EXCEPTION 'Active Form 5 Computer Science syllabus missing'; END IF; END $$;"]
 for p in doc['papers']:
  sql.append(f"INSERT INTO public.exam_papers(id,syllabus_id,title,source,source_year,paper_number,pdf_url,sha256,page_count,full_text,extraction_status,import_flags) SELECT (x->>'id')::uuid,(SELECT id FROM archive_target),x->>'title',x->>'source',(x->>'source_year')::integer,(x->>'paper_number')::integer,x->>'pdf_url',x->>'sha256',(x->>'page_count')::integer,x->>'full_text',x->>'extraction_status',ARRAY(SELECT jsonb_array_elements_text(x->'import_flags')) FROM (SELECT {payload(p)} AS x) t ON CONFLICT(id) DO NOTHING;")
 for p in doc['aliases']:
  sql.append(f"INSERT INTO public.exam_paper_sources(source_url,paper_id,listed_title,listed_year,pdf_url) VALUES ({quote(p['source_url'])},{quote(p['paper_id'])}::uuid,{quote(p['listed_title'])},{p['listed_year']},{quote(p['pdf_url'])}) ON CONFLICT(source_url) DO NOTHING;")
 sql.append('COMMIT;');(out/'00_sources.sql').write_text('\n'.join(sql))
 for batch,start in enumerate(range(0,len(doc['questions']),40),1):
  chunk=doc['questions'][start:start+40];ids={q['id'] for q in chunk};links=[l for l in doc['links'] if l['question_id'] in ids]
  sql=['BEGIN;',f'CREATE TEMP TABLE imported_questions ON COMMIT DROP AS SELECT x FROM jsonb_array_elements({payload(chunk)}) x;',f'CREATE TEMP TABLE archive_target ON COMMIT DROP AS SELECT {TARGET} AS id;']
  # Canonical keys include all option text, so equal stems with different options stay distinct.
  sql.append("""CREATE TEMP TABLE question_map ON COMMIT DROP AS
SELECT (i.x->>'id')::uuid AS incoming_id,COALESCE(
 (SELECT q.id FROM public.questions q WHERE q.syllabus_id=(SELECT id FROM archive_target) AND q.deleted_at IS NULL AND q.question_type=i.x->>'type'
 AND regexp_replace(lower(trim(q.question_text)),'\\s+',' ','g')=regexp_replace(lower(trim(i.x->>'text')),'\\s+',' ','g')
 AND COALESCE((SELECT string_agg(o.label||':'||regexp_replace(lower(trim(o.option_text)),'\\s+',' ','g'),'|' ORDER BY o.label) FROM public.question_options o WHERE o.question_id=q.id AND o.deleted_at IS NULL),'')=
 COALESCE((SELECT string_agg((v->>'label')||':'||regexp_replace(lower(trim(v->>'option_text')),'\\s+',' ','g'),'|' ORDER BY v->>'label') FROM jsonb_array_elements(i.x->'options') v),'')
 ORDER BY q.needs_review,q.created_at LIMIT 1), (i.x->>'id')::uuid) AS question_id FROM imported_questions i;""")
  sql.append("""INSERT INTO public.questions(id,syllabus_id,question_text,question_type,marks,source,source_year,source_paper,source_number,media_url,auto_markable,needs_review,import_batch,import_page,import_flags)
SELECT m.question_id,(SELECT id FROM archive_target),i.x->>'text',i.x->>'type',(i.x->>'marks')::numeric,i.x->>'source',(i.x->>'year')::integer,i.x->>'paper',i.x->>'number',i.x->>'media_url',false,true,'minesec-ol-cs-2026-10', (i.x->>'page')::integer, ARRAY(SELECT jsonb_array_elements_text(i.x->'flags'))
FROM imported_questions i JOIN question_map m ON m.incoming_id=(i.x->>'id')::uuid
WHERE NOT EXISTS(SELECT 1 FROM public.questions q WHERE q.id=m.question_id)
ON CONFLICT(id) DO NOTHING;""")
  sql.append("""INSERT INTO public.question_options(question_id,label,option_text,is_correct,sequence)
SELECT m.question_id,v->>'label',v->>'option_text',false,ascii(v->>'label')-64
FROM imported_questions i JOIN question_map m ON m.incoming_id=(i.x->>'id')::uuid CROSS JOIN LATERAL jsonb_array_elements(i.x->'options') v
WHERE m.incoming_id=m.question_id AND NOT EXISTS(SELECT 1 FROM public.question_options o WHERE o.question_id=m.question_id AND o.label=v->>'label');""")
  sql.append(f"""INSERT INTO public.exam_paper_questions(paper_id,question_id,source_number,source_page)
SELECT (l->>'paper_id')::uuid,m.question_id,l->>'source_number',(l->>'source_page')::integer FROM jsonb_array_elements({payload(links)}) l JOIN question_map m ON m.incoming_id=(l->>'question_id')::uuid
ON CONFLICT(paper_id,source_number) DO NOTHING;""")
  sql.append('COMMIT;');(out/f'{batch:02d}_questions.sql').write_text('\n'.join(sql))
 print(f"{len(doc['papers'])} unique PDFs, {len(doc['aliases'])} source links, {len(doc['questions'])} extracted questions, {len(doc['links'])} occurrences")
if __name__=='__main__':emit(json.loads(Path(sys.argv[1]).read_text()),Path(sys.argv[2]))
