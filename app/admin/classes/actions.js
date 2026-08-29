"use server";

import { revalidatePath } from "next/cache";
import { createClient, getUser } from "../../../lib/supabase-server";

async function currentTeacher(supabase) {
  const user = await getUser();
  if (!user) return null;
  const { data } = await supabase
    .from("teachers")
    .select("id")
    .eq("auth_user_id", user.id)
    .maybeSingle();
  return data ?? null;
}

export async function createClass(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  const teacher = await currentTeacher(supabase);
  if (!teacher) return;

  const name = String(formData.get("name") ?? "").trim();
  const syllabus_id = formData.get("syllabus_id");
  const academic_year = String(formData.get("academic_year") ?? "").trim();
  const examRaw = String(formData.get("exam_year") ?? "").trim();

  if (!name || !syllabus_id || !academic_year) return;

  const { data: syllabus } = await supabase
    .from("syllabi")
    .select("form_level")
    .eq("id", syllabus_id)
    .maybeSingle();

  await supabase.from("classes").insert({
    teacher_id: teacher.id,
    syllabus_id,
    name,
    form_level: syllabus?.form_level ?? null,
    academic_year,
    // Form 4 does not sit the GCE. Storing a fake exam year there would
    // corrupt every readiness calculation later, so it stays null.
    exam_year: examRaw === "" ? null : Number(examRaw),
  });

  revalidatePath("/admin/classes");
  revalidatePath("/admin");
}

/**
 * Save one term of the scheme of work.
 *
 * The form posts three fields per lesson: status, the week it was actually
 * taught, and an observation. One save per term rather than one per lesson,
 * because every save is a round trip and the connection is not reliable.
 */
export async function saveScheme(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  const teacher = await currentTeacher(supabase);
  if (!teacher) return;

  const classId = formData.get("class_id");
  const term = formData.get("term");
  if (!classId) return;

  const VALID = ["planned", "taught", "postponed", "skipped"];
  const rows = [];

  for (const [field, value] of formData.entries()) {
    if (!field.startsWith("status:")) continue;
    const lessonId = field.slice(7);
    const status = String(value);
    if (!VALID.includes(status)) continue;

    const weekRaw = String(formData.get(`week:${lessonId}`) ?? "").trim();
    const observation = String(formData.get(`obs:${lessonId}`) ?? "").trim();

    // A lesson still marked planned with nothing written against it has no
    // information in it. Skip rather than filling the table with empty rows.
    if (status === "planned" && !weekRaw && !observation) continue;

    rows.push({
      class_id: classId,
      lesson_id: lessonId,
      status,
      actual_week: weekRaw === "" ? null : Number(weekRaw),
      actual_term: term ? Number(term) : null,
      observation: observation || null,
      updated_at: new Date().toISOString(),
    });
  }

  if (rows.length > 0) {
    await supabase
      .from("scheme_entries")
      .upsert(rows, { onConflict: "class_id,lesson_id" });
  }

  revalidatePath(`/admin/classes/${classId}`);
  revalidatePath("/admin/classes");
}
