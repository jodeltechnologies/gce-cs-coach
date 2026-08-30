"use server";

import { revalidatePath } from "next/cache";
import { createClient } from "../../../lib/supabase-server";

/**
 * Record a mark against a written answer.
 *
 * The mark and the comment go in together. A mark with no comment tells a
 * student what they got and nothing about why, which is the part that changes
 * the next attempt.
 */
export async function markAnswer(prevState, formData) {
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const id = formData.get("answer_id");
  const raw = String(formData.get("marks") ?? "").trim();
  const total = Number(formData.get("total") ?? 0);
  if (!id) return { error: "No answer chosen." };

  const marks = Number(raw);
  if (raw === "" || Number.isNaN(marks)) {
    return { error: "Enter a mark." };
  }
  if (marks < 0 || (total > 0 && marks > total)) {
    return { error: `The mark must be between 0 and ${total}.` };
  }

  const { error } = await supabase.rpc("mark_answer", {
    p_answer: id,
    p_marks: marks,
    p_feedback: String(formData.get("feedback") ?? ""),
  });
  if (error) return { error: error.message };

  revalidatePath("/admin/marking");
  return { ok: `Marked ${marks} out of ${total}.` };
}
