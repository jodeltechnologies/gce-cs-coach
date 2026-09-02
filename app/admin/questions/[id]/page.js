import Link from "next/link";
import { createClient } from "../../../../lib/supabase-server";
import { updateQuestion, deleteQuestion } from "../actions";
import QuestionForm from "../QuestionForm";

export const metadata = { title: "Edit question" };
export const dynamic = "force-dynamic";

export default async function EditQuestionPage({ params }) {
  const { id } = await params;
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const { data: question } = await supabase
    .from("questions").select("*").eq("id", id).maybeSingle();

  if (!question) {
    return (
      <>
        <h2>Question not found</h2>
        <p className="lede"><Link href="/admin/questions">Back to the bank</Link></p>
      </>
    );
  }

  const [{ data: syllabi }, { data: lessons }, { data: options }, { data: tags }] =
    await Promise.all([
      supabase.from("syllabi").select("id, form_level").order("form_level"),
      supabase.from("lessons")
        .select("id, syllabus_id, lesson_no_start, title")
        .is("deleted_at", null)
        .eq("lesson_kind", "content").order("sequence"),
      supabase.from("question_options")
        .select("label, option_text, is_correct").eq("question_id", id).order("sequence"),
      supabase.from("question_lessons").select("lesson_id").eq("question_id", id),
    ]);

  return (
    <>
      <h2>Edit question</h2>
      <p className="lede"><Link href="/admin/questions">Back to the bank</Link></p>

      <QuestionForm
        action={updateQuestion}
        syllabi={syllabi ?? []}
        lessons={lessons ?? []}
        question={question}
        options={options ?? []}
        taggedLessonIds={(tags ?? []).map((t) => t.lesson_id)}
      />

      <form action={deleteQuestion} style={{ marginTop: 30 }}>
        <input type="hidden" name="question_id" value={question.id} />
        <button className="link" type="submit" style={{ color: "var(--red)" }}>
          Remove this question
        </button>
      </form>
      <p style={{ fontSize: "0.8rem", color: "var(--muted)" }}>
        Removing hides it from the bank. Answers students have already given
        stay intact, so past marks keep their meaning.
      </p>
    </>
  );
}
