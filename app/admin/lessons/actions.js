"use server";

import { revalidatePath } from "next/cache";
import { createClient, getUser } from "../../../lib/supabase-server";

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

/** Save a lesson's student-facing notes, private teacher notes and status. */
export async function saveLesson(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("lesson_id");
  if (!id) return;

  const status = String(formData.get("status") ?? "draft");
  const allowed = ["draft", "published", "archived"];

  const content = String(formData.get("content") ?? "").trim();
  const teacherNotes = String(formData.get("teacher_notes") ?? "").trim();
  const durationRaw = String(formData.get("duration_minutes") ?? "").trim();

  await supabase
    .from("lessons")
    .update({
      content: content || null,
      teacher_notes: teacherNotes || null,
      duration_minutes: durationRaw === "" ? null : Number(durationRaw),
      status: allowed.includes(status) ? status : "draft",
      updated_at: new Date().toISOString(),
    })
    .eq("id", id);

  revalidatePath(`/admin/lessons/${id}`);
  revalidatePath("/admin/lessons");
  revalidatePath("/admin");
}

/**
 * Add one objective to a lesson.
 *
 * The Ministry's own objectives are loaded from the progression sheet and
 * should not normally be edited — they are what the exam is set against.
 * This is for objectives you add yourself, which is why new ones are marked
 * as such rather than being silently mixed in.
 */
export async function addObjective(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const lessonId = formData.get("lesson_id");
  const description = String(formData.get("description") ?? "").trim();
  if (!lessonId || !description) return;

  const { data: existing } = await supabase
    .from("objectives")
    .select("sequence")
    .eq("lesson_id", lessonId)
    .order("sequence", { ascending: false })
    .limit(1);

  await supabase.from("objectives").insert({
    lesson_id: lessonId,
    kind: "objective",
    description,
    sequence: (existing?.[0]?.sequence ?? 0) + 1,
  });

  revalidatePath(`/admin/lessons/${lessonId}`);
}

export async function deleteObjective(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("objective_id");
  const lessonId = formData.get("lesson_id");
  if (!id) return;

  // Soft delete: the row stays so a deletion made here still reaches a phone
  // that has been offline, and so a mistake can be undone.
  await supabase
    .from("objectives")
    .update({ deleted_at: new Date().toISOString() })
    .eq("id", id);

  revalidatePath(`/admin/lessons/${lessonId}`);
}

/**
 * Record a file that the browser has already uploaded to Supabase Storage.
 * The file itself never passes through this server — see the note in
 * phase3.sql about the 4.5 MB request limit.
 */
export async function attachResource(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const lessonId = formData.get("lesson_id");
  const url = String(formData.get("url") ?? "").trim();
  const caption = String(formData.get("caption") ?? "").trim();
  const kind = String(formData.get("kind") ?? "pdf");
  const sizeRaw = String(formData.get("size_bytes") ?? "").trim();
  if (!lessonId || !url) return;

  const size = sizeRaw === "" ? null : Number(sizeRaw);

  await supabase.from("lesson_resources").insert({
    lesson_id: lessonId,
    kind: ["image", "video", "pdf", "link", "audio"].includes(kind) ? kind : "pdf",
    url,
    caption: caption || null,
    size_bytes: size,
    // Anything under 500 KB is cheap enough to cache on a student's phone
    // without asking. Larger files prompt first — student data costs money.
    offline_cache: size != null && size < 500_000,
  });

  revalidatePath(`/admin/lessons/${lessonId}`);
}

export async function removeResource(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("resource_id");
  const lessonId = formData.get("lesson_id");
  if (!id) return;

  await supabase
    .from("lesson_resources")
    .update({ deleted_at: new Date().toISOString() })
    .eq("id", id);

  revalidatePath(`/admin/lessons/${lessonId}`);
}
