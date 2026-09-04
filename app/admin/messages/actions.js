"use server";

import { revalidatePath } from "next/cache";
import { createClient } from "../../../lib/supabase-server";

/**
 * Reply to a student.
 *
 * Sending a reply also marks that student's messages as read, in the same
 * database call. Two calls would leave an unread count that was wrong for as
 * long as the second one took, and wrong counts stop being looked at.
 */
export async function reply(formData) {
  const supabase = await createClient();
  if (!supabase) return;

  const studentId = String(formData.get("student_id") ?? "");
  const body = String(formData.get("body") ?? "").trim();
  if (!studentId || !body) return;

  await supabase.rpc("teacher_reply", { p_student: studentId, p_body: body });
  revalidatePath("/admin/messages");
}
