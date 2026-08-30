"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { createClient, getUser } from "../../../lib/supabase-server";

const TYPES = [
  "mcq",
  "true_false",
  "short_answer",
  "structured",
  "practical",
  "algorithm",
  "flowchart",
  "trace_table",
];

// Only these mark themselves. A structured answer on normalization cannot be
// marked by comparing strings, and a confidently wrong score is worse than no
// score at all — so those wait for you.
const AUTO_MARKABLE = new Set(["mcq", "true_false"]);

async function teacherOrNull(supabase) {
  const user = await getUser();
  if (!user) return null;
  const { data } = await supabase
    .from("teachers")
    .select("id")
    .eq("auth_user_id", user.id)
    .maybeSingle();
  return data ?? null;
}

function readFields(formData) {
  const question_type = String(formData.get("question_type") ?? "structured");
  const source = String(formData.get("source") ?? "teacher");
  const difficulty = String(formData.get("difficulty") ?? "");
  const yearRaw = String(formData.get("source_year") ?? "").trim();

  return {
    question_text: String(formData.get("question_text") ?? "").trim(),
    question_type: TYPES.includes(question_type) ? question_type : "structured",
    marks: Number(String(formData.get("marks") ?? "1")) || 1,
    difficulty: ["easy", "medium", "hard"].includes(difficulty) ? difficulty : null,
    source: ["gce_past", "mock", "textbook", "teacher"].includes(source)
      ? source
      : "teacher",
    source_year: yearRaw === "" ? null : Number(yearRaw),
    source_paper: String(formData.get("source_paper") ?? "").trim() || null,
    source_number: String(formData.get("source_number") ?? "").trim() || null,
    model_answer: String(formData.get("model_answer") ?? "").trim() || null,
    marking_guide: String(formData.get("marking_guide") ?? "").trim() || null,
    auto_markable: AUTO_MARKABLE.has(question_type),
  };
}

async function saveOptions(supabase, questionId, formData, type) {
  // Clear and rewrite. Options are few and always edited together, so this is
  // simpler and safer than working out which ones changed.
  await supabase.from("question_options").delete().eq("question_id", questionId);

  if (type === "true_false") {
    const correct = String(formData.get("tf_correct") ?? "true");
    await supabase.from("question_options").insert([
      { question_id: questionId, label: "A", option_text: "True", is_correct: correct === "true", sequence: 1 },
      { question_id: questionId, label: "B", option_text: "False", is_correct: correct === "false", sequence: 2 },
    ]);
    return;
  }

  if (type !== "mcq") return;

  const correct = String(formData.get("mcq_correct") ?? "A");
  const rows = [];
  ["A", "B", "C", "D"].forEach((label, i) => {
    const text = String(formData.get(`option_${label}`) ?? "").trim();
    if (!text) return;
    rows.push({
      question_id: questionId,
      label,
      option_text: text,
      is_correct: label === correct,
      sequence: i + 1,
    });
  });
  if (rows.length > 0) await supabase.from("question_options").insert(rows);
}

async function saveLessonTags(supabase, questionId, formData) {
  await supabase.from("question_lessons").delete().eq("question_id", questionId);
  const lessons = formData.getAll("lesson_ids").filter(Boolean);
  if (lessons.length === 0) return;
  await supabase.from("question_lessons").insert(
    lessons.map((lesson_id, i) => ({
      question_id: questionId,
      lesson_id,
      is_primary: i === 0,
    }))
  );
}

export async function createQuestion(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const syllabus_id = formData.get("syllabus_id");
  const fields = readFields(formData);
  if (!syllabus_id || !fields.question_text) return;

  const { data: question, error } = await supabase
    .from("questions")
    .insert({ syllabus_id, ...fields })
    .select("id")
    .single();

  if (error || !question) return;

  await saveOptions(supabase, question.id, formData, fields.question_type);
  await saveLessonTags(supabase, question.id, formData);

  revalidatePath("/admin/questions");
  redirect(`/admin/questions/${question.id}`);
}

export async function updateQuestion(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("question_id");
  if (!id) return;
  const fields = readFields(formData);
  if (!fields.question_text) return;

  // An imported question is still unreviewed unless the teacher says otherwise
  // on this save. phase5.sql forbids auto_markable and needs_review together,
  // so these two have to be decided as a pair or the update is rejected.
  const { data: existing } = await supabase
    .from("questions")
    .select("needs_review")
    .eq("id", id)
    .maybeSingle();

  const confirmed = String(formData.get("mark_reviewed") ?? "") === "on";
  const stillNeedsReview = Boolean(existing?.needs_review) && !confirmed;

  const teacher = await teacherOrNull(supabase);

  await supabase
    .from("questions")
    .update({
      ...fields,
      needs_review: stillNeedsReview,
      auto_markable: fields.auto_markable && !stillNeedsReview,
      ...(existing?.needs_review && confirmed
        ? { reviewed_at: new Date().toISOString(), reviewed_by: teacher?.id ?? null }
        : {}),
      updated_at: new Date().toISOString(),
    })
    .eq("id", id);

  await saveOptions(supabase, id, formData, fields.question_type);
  await saveLessonTags(supabase, id, formData);

  revalidatePath(`/admin/questions/${id}`);
  revalidatePath("/admin/questions");
}

// ---------------------------------------------------------------------------
// The review queue
//
// Imported questions arrive with needs_review set and auto_markable false.
// These two actions are how that doubt is cleared, one question at a time.
// ---------------------------------------------------------------------------

export async function approveQuestion(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  const teacher = await teacherOrNull(supabase);
  if (!teacher) return;

  const id = formData.get("question_id");
  if (!id) return;
  const correct = String(formData.get("correct_label") ?? "").trim();

  const { data: q } = await supabase
    .from("questions")
    .select("question_type")
    .eq("id", id)
    .maybeSingle();
  if (!q) return;

  if (q.question_type === "mcq") {
    // Approving an MCQ with no correct option would produce a question that
    // marks every student wrong, so refuse rather than write a bad row.
    if (!correct) return;
    await supabase
      .from("question_options")
      .update({ is_correct: false })
      .eq("question_id", id);
    const { error } = await supabase
      .from("question_options")
      .update({ is_correct: true })
      .eq("question_id", id)
      .eq("label", correct);
    if (error) return;
  }

  await supabase
    .from("questions")
    .update({
      needs_review: false,
      reviewed_at: new Date().toISOString(),
      reviewed_by: teacher.id,
      // Order matters: phase5.sql forbids auto_markable while needs_review is
      // true, so both have to move in the same update.
      auto_markable: AUTO_MARKABLE.has(q.question_type),
      updated_at: new Date().toISOString(),
    })
    .eq("id", id);

  revalidatePath("/admin/questions/review");
  revalidatePath("/admin/questions");
}

export async function rejectQuestion(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("question_id");
  if (!id) return;

  // Soft delete, same as any other removal. A question too damaged to use is
  // still evidence of what was on the page, and the import can be re-run
  // without it coming back: the id is derived from the text, so the seed's
  // ON CONFLICT DO NOTHING skips it.
  await supabase
    .from("questions")
    .update({ deleted_at: new Date().toISOString() })
    .eq("id", id);

  revalidatePath("/admin/questions/review");
  revalidatePath("/admin/questions");
}

export async function deleteQuestion(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("question_id");
  if (!id) return;

  // Soft delete. A question that has been answered by students must not
  // vanish, or their marks stop making sense.
  await supabase
    .from("questions")
    .update({ deleted_at: new Date().toISOString() })
    .eq("id", id);

  revalidatePath("/admin/questions");
  redirect("/admin/questions");
}
