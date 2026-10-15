BEGIN;
CREATE TABLE IF NOT EXISTS public.exam_papers (
 id uuid PRIMARY KEY,
 syllabus_id uuid NOT NULL REFERENCES public.syllabi(id),
 title text NOT NULL,
 source text NOT NULL CHECK (source IN ('gce_past','mock')),
 source_year integer,
 paper_number integer NOT NULL CHECK (paper_number BETWEEN 1 AND 3),
 pdf_url text NOT NULL,
 sha256 text NOT NULL UNIQUE,
 page_count integer NOT NULL,
 full_text text NOT NULL,
 extraction_status text NOT NULL CHECK (extraction_status IN ('extracted_for_review','source_only')),
 import_flags text[] NOT NULL DEFAULT '{}',
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS public.exam_paper_sources (
 source_url text PRIMARY KEY,
 paper_id uuid NOT NULL REFERENCES public.exam_papers(id),
 listed_title text NOT NULL,
 listed_year integer NOT NULL,
 pdf_url text NOT NULL
);
CREATE TABLE IF NOT EXISTS public.exam_paper_questions (
 paper_id uuid NOT NULL REFERENCES public.exam_papers(id),
 question_id uuid NOT NULL REFERENCES public.questions(id),
 source_number text NOT NULL,
 source_page integer NOT NULL,
 PRIMARY KEY (paper_id,source_number)
);
CREATE INDEX IF NOT EXISTS exam_papers_by_year ON public.exam_papers(syllabus_id,source_year,paper_number);
CREATE INDEX IF NOT EXISTS exam_paper_sources_by_paper ON public.exam_paper_sources(paper_id);
CREATE INDEX IF NOT EXISTS exam_paper_questions_by_question ON public.exam_paper_questions(question_id);
ALTER TABLE public.exam_papers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exam_paper_sources ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exam_paper_questions ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS teacher_reads_exam_papers ON public.exam_papers;
CREATE POLICY teacher_reads_exam_papers ON public.exam_papers FOR SELECT TO authenticated USING (public.is_teacher());
DROP POLICY IF EXISTS teacher_reads_exam_paper_sources ON public.exam_paper_sources;
CREATE POLICY teacher_reads_exam_paper_sources ON public.exam_paper_sources FOR SELECT TO authenticated USING (public.is_teacher());
DROP POLICY IF EXISTS teacher_reads_exam_paper_questions ON public.exam_paper_questions;
CREATE POLICY teacher_reads_exam_paper_questions ON public.exam_paper_questions FOR SELECT TO authenticated USING (public.is_teacher());
GRANT SELECT ON public.exam_papers,public.exam_paper_sources,public.exam_paper_questions TO authenticated;
COMMIT;
