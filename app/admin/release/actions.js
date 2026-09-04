"use server";

import { revalidatePath } from "next/cache";
import { createClient, getUser } from "../../../lib/supabase-server";

/**
 * Release notes to a class, or take them back.
 *
 * Taking a note back does not delete anything a student has already written
 * about it. Their answers to the questions stay recorded, so a note released
 * again in revision week picks up where they left off.
 */
export async function setRelease(formData) {
  const supabase = await createClient();
  if (!supabase) return;

  const classId = String(formData.get("class_id") ?? "");
  if (!classId) return;

  const wanted = new Set(formData.getAll("release").map(String));
  const offered = formData.getAll("offered").map(String);
  if (offered.length === 0) return;

  // The signed-in teacher, named rather than guessed. Taking the first row of
  // the teachers table happens to work while row level security is doing its
  // job, which is exactly the kind of accidental correctness that stops being
  // correct the day a policy changes.
  const user = await getUser();
  const { data: teacher } = await supabase
    .from("teachers")
    .select("id")
    .eq("auth_user_id", user?.id ?? "")
    .maybeSingle();
  if (!teacher) return;

  // A class this teacher does not own is not theirs to release notes to.
  const { data: owned } = await supabase
    .from("classes")
    .select("id")
    .eq("id", classId)
    .eq("teacher_id", teacher.id)
    .is("deleted_at", null)
    .maybeSingle();
  if (!owned) return;

  const toAdd = offered.filter((id) => wanted.has(id));
  const toRemove = offered.filter((id) => !wanted.has(id));

  if (toAdd.length > 0) {
    await supabase.from("note_releases").upsert(
      toAdd.map((id) => ({
        class_id: classId,
        note_section_id: id,
        released_by: teacher.id,
      })),
      { onConflict: "class_id,note_section_id" }
    );
  }
  if (toRemove.length > 0) {
    await supabase
      .from("note_releases")
      .delete()
      .eq("class_id", classId)
      .in("note_section_id", toRemove);
  }
  revalidatePath("/admin/release");
}
