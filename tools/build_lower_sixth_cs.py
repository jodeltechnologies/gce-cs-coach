"""Transcribe the supplied national Lower Sixth CS PDF and emit repeatable SQL.
Usage: python3 tools/build_lower_sixth_cs.py /path/to/sheet.pdf
Module/category ranges below join labels split across page boundaries.
The Ministry's lesson numbering and wording are preserved, including typos.
"""
import sys, re
from pathlib import Path
import pdfplumber, yaml
import build_progression as base

MODULES = [
 (1, 'Computer Applications, Artificial Intelligence & Emerging technologies and their Socio-Economic Implications'),
 (22, 'Computer Organisation and Architecture'),
 (56, 'Problem-Solving and Algorithm Design'),
 (74, 'Programming I'), (93, 'Data Structures 1'), (101, 'Algorithm Efficiency'),
 (106, 'Computer Networks and Data Communication'),
 (118, 'Introduction to Web Development Technologies'),
]
CATEGORIES = [
 (1, 'Exploring AI Concepts and Emerging technologies'),
 (8, 'Description of Computer Systems'), (11, 'Utilization of digital resources'),
 (15, 'Application areas of computers and evaluating the Implications of Computers'),
 (22, 'Representing data in Computer Systems'),
 (32, 'Designing and Analysing Digital Logic Circuits'),
 (39, 'Exploring Computer Organisation and Architecture'),
 (48, 'Managing Computer Memory'),
 (53, 'Understanding Peripheral Communication and Data Transfer'),
 (56, 'Designing Algorithms'), (67, 'Designing Modular Algorithms'),
 (74, 'Understanding Programming Language Concepts'),
 (93, 'Selecting and Manipulating Data Structures'),
 (101, 'Evaluating Algorithm Efficiency'), (106, 'Exploring Internet Technologies'),
 (118, 'Designing simple Web Pages'),
]
def at(ranges, number):
 return next(label for start, label in reversed(ranges) if number >= start)
def clean(v):
 return re.sub(r'\s+', ' ', v or '').strip()

def build(path):
 rows=[]; week=1; number=1
 with pdfplumber.open(path) as pdf:
  for pg in pdf.pages:
   for table in pg.extract_tables():
    for r in table:
     if len(r)!=11 or clean(r[5])=='Lesson Title': continue
     if clean(r[1]).isdigit(): week=int(clean(r[1]))
     title=clean(r[5]); digits=re.findall(r'\d+',r[4] or '')
     if digits:
      number=int(digits[0])
      kind='integration_activity' if title.lower().startswith('integration') else 'content'
      rows.append(dict(no=number,title=title,week=week,kind=kind,obj_raw=r[6] or ''))
     elif title.lower() in ('evaluation','remediation'):
      rows.append(dict(no=None,title=title,week=week,kind=title.lower(),obj_raw='',after=number))
     elif title or clean(r[6]):
      assert rows, 'Unexpected continuation before first lesson'
      rows[-1]['title'] += (' '+title) if title else ''
      rows[-1]['obj_raw'] += '\n'+(r[6] or '')
 numbers=[r['no'] for r in rows if r['no']]
 assert numbers==list(range(1,123)), f'Missing or repeated lessons: {numbers}'
 syl={**base.SHEETS['l6']['syllabus'], 'title':'National Harmonised Progression Sheet for Computer Science Lower Sixth', 'subject':'Computer Science'}
 lessons=[]
 for r in rows:
  n=r['no'] or r['after']
  ls=dict(title=r['title'].strip(),kind=r['kind'],term=base.term_of(r['week']),week=r['week'],module=at(MODULES,n),competency=at(CATEGORIES,n),nature=['th'])
  if r['no']:ls['lesson_no']=r['no']
  objectives=base.bullets(r['obj_raw'])
  if objectives:ls['objectives']=objectives
  lessons.append(ls)
 for week in (34,35,36):
  lessons.append(dict(title='Revision',kind='revision',term=3,week=week,nature=['th']))
 doc=dict(syllabus=syl,modules=[dict(sequence=i,title=label) for i,(_,label) in enumerate(MODULES,1)],competencies=[dict(sequence=i,category=label,statement=None,module=at(MODULES,n)) for i,(n,label) in enumerate(CATEGORIES,1)],lessons=lessons)
 return doc

if __name__=='__main__':
 root=Path(__file__).resolve().parents[1]
 doc=build(sys.argv[1])
 base.SHEETS['l6cs']=dict(fallback_id='740cda5d-4792-5fa5-8eb1-639fdb2d19a2')
 (root/'tools/curriculum/lower_sixth_computer_science.yaml').write_text(yaml.safe_dump(doc,sort_keys=False,allow_unicode=True,width=100))
 (root/'db/seed/12_lower_sixth_computer_science.sql').write_text(base.emit_sql('l6cs',doc))
 print(f"{len(doc['lessons'])} rows, {sum(len(l.get('objectives',[])) for l in doc['lessons'])} objectives, all 122 lesson numbers checked")
