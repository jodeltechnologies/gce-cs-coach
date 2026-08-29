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

// Ambiguous characters are left out on purpose. A code gets read off paper,
// sometimes copied by hand from a board, and often typed on a cracked phone
// screen. O against 0 and I against 1 cause more support work than they save.
const ALPHABET = "ABCDEFGHJKMNPQRSTUVWXYZ23456789";

function randomCode() {
  let out = "";
  for (let i = 0; i < 6; i++) {
    out += ALPHABET[Math.floor(Math.random() * ALPHABET.length)];
  }
  return `MBJ-${out}`;
}

/** A code nobody else holds. Retries on the unlikely collision. */
async function uniqueCode(supabase) {
  for (let attempt = 0; attempt < 12; attempt++) {
    const code = randomCode();
    const { data } = await supabase
      .from("students")
      .select("id")
      .eq("login_code", code)
      .maybeSingle();
    if (!data) return code;
  }
  return `MBJ-${Date.now().toString(36).toUpperCase().slice(-6)}`;
}

export async function addStudent(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const full_name = String(formData.get("full_name") ?? "").trim();
  if (!full_name) return;

  const classId = formData.get("class_id");
  const sex = String(formData.get("sex") ?? "");
  const dob = String(formData.get("date_of_birth") ?? "").trim();

  const { data: student, error } = await supabase
    .from("students")
    .insert({
      full_name,
      matricule: String(formData.get("matricule") ?? "").trim() || null,
      sex: sex === "M" || sex === "F" ? sex : null,
      date_of_birth: dob || null,
      guardian_name: String(formData.get("guardian_name") ?? "").trim() || null,
      guardian_phone: String(formData.get("guardian_phone") ?? "").trim() || null,
      student_phone: String(formData.get("student_phone") ?? "").trim() || null,
      login_code: await uniqueCode(supabase),
    })
    .select("id")
    .single();

  if (error || !student) return;

  // Enrol straight away when a class was chosen. Creating a student and then
  // forgetting to put them in a class is the obvious way to end up with a
  // register that is missing people.
  if (classId) {
    await supabase.from("enrolments").insert({
      class_id: classId,
      student_id: student.id,
      status: "active",
    });
  }

  revalidatePath("/admin/students");
  revalidatePath("/admin");
}

export async function updateStudent(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("student_id");
  if (!id) return;
  const sex = String(formData.get("sex") ?? "");
  const dob = String(formData.get("date_of_birth") ?? "").trim();

  await supabase
    .from("students")
    .update({
      full_name: String(formData.get("full_name") ?? "").trim(),
      matricule: String(formData.get("matricule") ?? "").trim() || null,
      sex: sex === "M" || sex === "F" ? sex : null,
      date_of_birth: dob || null,
      guardian_name: String(formData.get("guardian_name") ?? "").trim() || null,
      guardian_phone: String(formData.get("guardian_phone") ?? "").trim() || null,
      student_phone: String(formData.get("student_phone") ?? "").trim() || null,
      updated_at: new Date().toISOString(),
    })
    .eq("id", id);

  revalidatePath(`/admin/students/${id}`);
  revalidatePath("/admin/students");
}

export async function regenerateCode(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("student_id");
  if (!id) return;

  await supabase
    .from("students")
    .update({
      login_code: await uniqueCode(supabase),
      updated_at: new Date().toISOString(),
    })
    .eq("id", id);

  revalidatePath(`/admin/students/${id}`);
}

export async function enrolStudent(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const student_id = formData.get("student_id");
  const class_id = formData.get("class_id");
  if (!student_id || !class_id) return;

  await supabase
    .from("enrolments")
    .upsert(
      { student_id, class_id, status: "active", deleted_at: null },
      { onConflict: "class_id,student_id" }
    );

  revalidatePath(`/admin/students/${student_id}`);
  revalidatePath("/admin/students");
}

export async function setEnrolmentStatus(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("enrolment_id");
  const student_id = formData.get("student_id");
  const status = String(formData.get("status") ?? "");
  if (!id || !["active", "transferred", "withdrawn", "repeating"].includes(status))
    return;

  // A student who leaves is marked, never deleted. Their marks stay attached
  // to the class they actually sat in, which is what makes last year's results
  // still mean something.
  await supabase
    .from("enrolments")
    .update({ status, updated_at: new Date().toISOString() })
    .eq("id", id);

  revalidatePath(`/admin/students/${student_id}`);
  revalidatePath("/admin/students");
}
