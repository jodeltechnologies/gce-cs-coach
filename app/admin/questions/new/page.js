import Link from "next/link";
import { createClient } from "../../../../lib/supabase-server";
import { createQuestion } from "../actions";
import QuestionForm from "../QuestionForm";

export const metadata = { title: "Add a question" };
export const dynamic = "force-dynamic";

export default async function NewQuestionPage() {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const [{ data: syllabi }, { data: lessons }] = await Promise.all([
    supabase.from("syllabi").select("id, form_level").order("form_level"),
    supabase
      .from("lessons")
      .select("id, syllabus_id, lesson_no_start, title")
      .is("deleted_at", null)
      .eq("lesson_kind", "content")
      .order("sequence"),
  ]);

  return (
    <>
      <h2>Add a question</h2>
      <p className="lede">
        <Link href="/admin/questions">Back to the bank</Link>
      </p>
      <QuestionForm
        action={createQuestion}
        syllabi={syllabi ?? []}
        lessons={lessons ?? []}
      />
    </>
  );
}
