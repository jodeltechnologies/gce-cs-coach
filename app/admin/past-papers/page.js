import Link from 'next/link';
import {notFound} from 'next/navigation';
import { requireTeacher } from '../../../lib/guards';
export const dynamic = 'force-dynamic';
export const metadata = { title: 'Past papers' };
export default async function PastPapers({ searchParams }) {
 const { supabase,teacher } = await requireTeacher();
 if (!supabase) return <p>Not connected.</p>;
 if(!teacher)notFound();
 const sp = await searchParams;
 const {data:papers,error} = await supabase.from('exam_papers').select('id,title,source,source_year,paper_number,pdf_url,page_count,extraction_status,import_flags,exam_paper_sources(source_url,listed_year,listed_title),exam_paper_questions(question_id)').order('source_year',{ascending:false,nullsFirst:false}).order('paper_number');
 if(error) return <div className="notice">The past-paper archive is not available yet. {error.message}</div>;
 const years=[...new Set((papers??[]).map(p=>p.source_year).filter(Boolean))].sort((a,b)=>b-a);
 const filtered=(papers??[]).filter(p=>(!sp?.number || String(p.paper_number)===sp.number) && (!sp?.year || String(p.source_year)===sp.year) && (!sp?.kind || p.source===sp.kind));
 const selected=sp?.paper && (papers??[]).find(p=>p.id===sp.paper);
 let text=null;
 if(selected){const {data}=await supabase.from('exam_papers').select('full_text').eq('id',selected.id).single();text=data?.full_text;}
 return <>
 <h2>Computer Science past papers</h2>
 <p className="lede">Original Ordinary Level papers and mocks from MINESEC. Years shown below come from the PDF where confirmed. Repeated website listings share one document.</p>
 <div className="tags"><span className="tag">{papers?.length??0} unique documents</span><span className="tag">{(papers??[]).reduce((n,p)=>n+p.exam_paper_sources.length,0)} source listings</span><Link className="tag" href="/admin/practical-guide">Paper 3 teaching guide</Link><Link className="tag" href="/admin/questions/review">Check imported questions</Link></div>
 <form className="paper-filters" method="get"><label>Printed year <select name="year" defaultValue={sp?.year??''}><option value="">All years</option>{years.map(y=><option key={y}>{y}</option>)}</select></label><label>Exam type <select name="kind" defaultValue={sp?.kind??''}><option value="">GCE and mocks</option><option value="gce_past">GCE papers</option><option value="mock">Mocks</option></select></label><label>Paper <select name="number" defaultValue={sp?.number??''}><option value="">All papers</option><option value="1">Paper 1</option><option value="2">Paper 2</option><option value="3">Paper 3</option></select></label><button type="submit">Filter</button><Link href="/admin/past-papers">Clear</Link></form>
 {selected&&<section className="notice"><h3>{selected.title}</h3><a href={selected.pdf_url} target="_blank" rel="noopener noreferrer">Open original PDF, including diagrams</a><details><summary>Read the extracted source text</summary><pre className="paper-source-text">{text}</pre></details></section>}
 {filtered.map(p=><article className="card" key={p.id}><h3>{p.title}</h3><div className="tags"><span className="tag">{p.page_count} pages</span><span className="tag">{p.exam_paper_questions.length} linked questions / tasks</span>{p.import_flags.length>0&&<span className="tag warn">Check source details</span>}</div><p><a href={p.pdf_url} target="_blank" rel="noopener noreferrer">Open original PDF</a>{' · '}<Link href={`/admin/past-papers?paper=${p.id}`}>Source text and details</Link></p>{p.extraction_status==='source_only'&&<p className="muted">The supplied file has no complete questions ready for the question bank. The available source text is preserved.</p>}<details><summary>{p.exam_paper_sources.length} MINESEC listing{p.exam_paper_sources.length===1?'':'s'}</summary><ul>{p.exam_paper_sources.map(s=><li key={s.source_url}><a href={s.source_url} target="_blank" rel="noopener noreferrer">{s.listed_title}</a></li>)}</ul>{p.import_flags.includes('listed_year_differs_from_pdf')&&<p>The listing year differs from the year printed in the PDF.</p>}{p.import_flags.includes('printed_year_unconfirmed')&&<p>No printed examination year could be confirmed from the cover.</p>}</details></article>)}
 {filtered.length===0&&<p>No papers match these filters.</p>}
 </>;
}
