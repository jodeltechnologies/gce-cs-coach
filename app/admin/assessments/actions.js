"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { createClient, getUser } from "../../../lib/supabase-server";

async function teacherOrNull(supabase) {
  const user = await getUser();
  if (!user) return null;
  const { data } = await supabase
    .from("teachers").select("id").eq("auth_user_id", user.id).maybeSingle();
  return data ?? null;
}

/**
 * Create a test and fill it with questions in one step.
 *
 * Creating an empty paper and filling it later sounds tidier and produces a
 * list of half-made tests nobody finishes. One form, one action, and the
 * result is something that can actually be sat.
 */
export async function createAssessment(prevState, formData) {
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };
  if (!(await teacherOrNull(supabase))) {
    return {
      error:
        "Your sign-in is not linked to a teacher record, so the database is " +
        "refusing the write. Run the INSERT INTO teachers step in db/auth.sql.",
    };
  }

  const title = String(formData.get("title") ?? "").trim();
  const classId = formData.get("class_id");
  if (!title) return { error: "Give the test a title." };
  if (!classId) return { error: "Choose a class." };

  const closes = String(formData.get("closes_at") ?? "").trim();
  // A date with no time means the end of that day, which is what a teacher
  // means by "due Friday".
  const closesAt = closes ? new Date(`${closes}T23:59:59`).toISOString() : null;

  const { data: assessment, error } = await supabase
    .from("assessments")
    .insert({
      class_id: classId,
      title,
      kind: String(formData.get("kind") ?? "quiz"),
      duration_minutes: Number(formData.get("duration") ?? 0) || null,
      opens_at: new Date().toISOString(),
      closes_at: closesAt,
      show_results: String(formData.get("show_results") ?? "after_close"),
    })
    .select("id")
    .single();

  if (error) return { error: error.message };

  const { data: added, error: fillError } = await supabase.rpc("fill_assessment", {
    p_assessment: assessment.id,
    p_lesson: formData.get("lesson_id") || null,
    p_count: Number(formData.get("count") ?? 10),
    p_include_structured: formData.get("structured") === "on",
  });

  if (fillError) {
    return { error: `The test was created but no questions were added: ${fillError.message}` };
  }
  if (!added) {
    return {
      error:
        "The test was created but no questions matched. That topic may have " +
        "no checked questions yet — see the review queue.",
    };
  }

  revalidatePath("/admin/assessments");
  redirect(`/admin/assessments/${assessment.id}`);
}

export async function addMoreQuestions(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("assessment_id");
  if (!id) return;
  await supabase.rpc("fill_assessment", {
    p_assessment: id,
    p_lesson: formData.get("lesson_id") || null,
    p_count: Number(formData.get("count") ?? 5),
    p_include_structured: formData.get("structured") === "on",
  });
  revalidatePath(`/admin/assessments/${id}`);
}

export async function removeQuestion(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("assessment_id");
  const questionId = formData.get("question_id");
  if (!id || !questionId) return;

  await supabase
    .from("assessment_questions")
    .delete()
    .eq("assessment_id", id)
    .eq("question_id", questionId);

  // The total has to follow the questions, or the paper says 20 marks and adds
  // up to 18.
  const { data: rows } = await supabase
    .from("assessment_questions")
    .select("marks_override, questions(marks)")
    .eq("assessment_id", id);
  const total = (rows ?? []).reduce(
    (n, r) => n + Number(r.marks_override ?? r.questions?.marks ?? 0), 0);
  await supabase.from("assessments")
    .update({ total_marks: total, updated_at: new Date().toISOString() })
    .eq("id", id);

  revalidatePath(`/admin/assessments/${id}`);
}

/** Close a test now, whatever its deadline said. */
export async function closeAssessment(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;
  const id = formData.get("assessment_id");
  if (!id) return;
  await supabase.from("assessments")
    .update({ closes_at: new Date().toISOString(), updated_at: new Date().toISOString() })
    .eq("id", id);
  revalidatePath(`/admin/assessments/${id}`);
}
