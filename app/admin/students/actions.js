"use server";

import { revalidatePath } from "next/cache";
import { createClient, getUser } from "../../../lib/supabase-server";
import { readXlsx, readDelimited } from "../../../lib/sheet-reader";

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

/**
 * Add a student, and say what happened.
 *
 * This used to return silently on every failure, which meant a teacher
 * pressing the button saw the page reload unchanged and had no way to tell a
 * permissions problem from a duplicate matricule from a typo. Silence is the
 * worst possible error message: it looks like the app is broken when usually
 * one specific thing is wrong and the database already said what it was.
 */
export async function addStudent(prevState, formData) {
  const supabase = await createClient();
  if (!supabase) {
    return { error: "The app is not connected to a database yet." };
  }

  const user = await getUser();
  if (!user) {
    return { error: "You are signed out. Reload the page and sign in again." };
  }
  const teacher = await teacherOrNull(supabase);
  if (!teacher) {
    return {
      error:
        "Your sign-in is not linked to a teacher record, so the database is " +
        "refusing the write. Run the INSERT INTO teachers step at the bottom " +
        "of db/auth.sql with your email.",
    };
  }

  const full_name = String(formData.get("full_name") ?? "").trim();
  if (!full_name) return { error: "A name is required." };

  const classId = formData.get("class_id");
  const sex = String(formData.get("sex") ?? "");
  const dob = String(formData.get("date_of_birth") ?? "").trim();
  if (dob && !/^\d{4}-\d{2}-\d{2}$/.test(dob)) {
    return { error: `Date of birth should look like 2008-03-14, not "${dob}".` };
  }

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
    .select("id, full_name, login_code")
    .single();

  if (error) {
    // Postgres already knows exactly what is wrong. Pass it through rather
    // than replacing it with a friendlier sentence that says less.
    if (error.code === "42501") {
      return {
        error:
          "The database refused the insert (row level security). Check that " +
          "db/phase2.sql has been run and that your teachers row has your " +
          "auth_user_id set.",
      };
    }
    if (error.code === "23505") {
      return { error: "That matricule is already used by another student." };
    }
    return { error: `${error.message}${error.hint ? ` — ${error.hint}` : ""}` };
  }
  if (!student) {
    return { error: "The student was not created and no reason was given." };
  }

  // Enrol straight away when a class was chosen. Creating a student and then
  // forgetting to put them in a class is the obvious way to end up with a
  // register that is missing people.
  if (classId) {
    const { error: enrolError } = await supabase.from("enrolments").insert({
      class_id: classId,
      student_id: student.id,
      status: "active",
    });
    if (enrolError) {
      // The student exists; only the class link failed. Say so precisely,
      // because "it did not work" would send a teacher hunting for a student
      // who is already there.
      return {
        error: `${student.full_name} was created but could not be added to ` +
               `the class: ${enrolError.message}`,
        code: student.login_code,
      };
    }
  }

  revalidatePath("/admin/students");
  revalidatePath("/admin");
  return {
    ok: `${student.full_name} added.`,
    code: student.login_code,
  };
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

// ---------------------------------------------------------------------------
// Bulk import
//
// A teacher's class list already exists, in Excel or on a printed register.
// Retyping forty names into a form is an hour of work and a fresh chance to
// misspell every one of them.
// ---------------------------------------------------------------------------

/** Guess which column holds what, from the header row. */
function mapColumns(header) {
  const norm = (s) => String(s ?? "").toLowerCase().replace(/[^a-z]/g, "");
  const find = (...words) =>
    header.findIndex((h) => words.some((w) => norm(h).includes(w)));

  return {
    full_name: find("name", "nom", "student", "eleve"),
    matricule: find("matricule", "matric", "regno", "registration", "id"),
    sex: find("sex", "gender", "sexe"),
    date_of_birth: find("birth", "dob", "naissance"),
    guardian_name: find("guardian", "parent", "tuteur"),
    guardian_phone: find("guardianphone", "parentphone", "phone", "tel", "contact"),
  };
}

const HEADER_WORDS = /name|nom|matric|sex|gender|birth|dob|guardian|parent|phone|tel/i;

export async function importStudents(prevState, formData) {
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected to the database." };
  const teacher = await teacherOrNull(supabase);
  if (!teacher) {
    return {
      error:
        "Your sign-in is not linked to a teacher record, so the database is " +
        "refusing the write. Run the INSERT INTO teachers step in db/auth.sql.",
    };
  }

  const classId = formData.get("class_id") || null;
  const pasted = String(formData.get("pasted") ?? "").trim();
  const file = formData.get("file");

  let rows = [];
  try {
    if (file && typeof file.arrayBuffer === "function" && file.size > 0) {
      const buf = Buffer.from(await file.arrayBuffer());
      const name = String(file.name ?? "").toLowerCase();
      if (name.endsWith(".xlsx") || name.endsWith(".xlsm")) {
        rows = readXlsx(buf);
      } else if (name.endsWith(".xls")) {
        // The old binary .xls is a different format entirely, not a zip, so it
        // cannot be read here. Saying so beats a confusing parse error.
        return {
          error:
            "That is the old .xls format. Open it in Excel and use " +
            "File, Save As, Excel Workbook (.xlsx), then upload again.",
        };
      } else {
        rows = readDelimited(buf.toString("utf8"));
      }
    } else if (pasted) {
      rows = readDelimited(pasted);
    } else {
      return { error: "Choose a file or paste the list first." };
    }
  } catch (e) {
    return { error: `That file could not be read: ${e.message}` };
  }

  if (rows.length === 0) return { error: "Nothing readable in that list." };

  // A header row is one whose cells are column names rather than a person.
  const looksLikeHeader =
    rows[0].filter((c) => HEADER_WORDS.test(c)).length >= 1 &&
    rows[0].every((c) => c.length < 30);
  const cols = looksLikeHeader
    ? mapColumns(rows[0])
    : { full_name: 0, matricule: -1, sex: -1, date_of_birth: -1,
        guardian_name: -1, guardian_phone: -1 };
  const body = looksLikeHeader ? rows.slice(1) : rows;

  if (cols.full_name < 0) {
    return {
      error:
        "No name column found. Name the column 'Name', or paste just the " +
        "names, one per line.",
    };
  }

  // Existing names, so re-uploading the same register does not double the roll.
  const { data: existing } = await supabase
    .from("students")
    .select("full_name, matricule")
    .is("deleted_at", null);
  const seenNames = new Set(
    (existing ?? []).map((s) => s.full_name.toLowerCase().replace(/\s+/g, " "))
  );
  const seenMatricules = new Set(
    (existing ?? []).filter((s) => s.matricule).map((s) => s.matricule.toLowerCase())
  );

  const at = (row, i) => (i >= 0 && i < row.length ? String(row[i] ?? "").trim() : "");
  const added = [];
  const skipped = [];

  for (const row of body) {
    const full_name = at(row, cols.full_name).replace(/\s+/g, " ");
    if (!full_name) continue;
    if (full_name.length > 120) {
      skipped.push({ name: full_name.slice(0, 40), why: "name too long to be a name" });
      continue;
    }

    const key = full_name.toLowerCase();
    if (seenNames.has(key)) {
      skipped.push({ name: full_name, why: "already on the roll" });
      continue;
    }
    const matricule = at(row, cols.matricule) || null;
    if (matricule && seenMatricules.has(matricule.toLowerCase())) {
      skipped.push({ name: full_name, why: `matricule ${matricule} already used` });
      continue;
    }

    const rawSex = at(row, cols.sex).toUpperCase().slice(0, 1);
    const dob = at(row, cols.date_of_birth);

    const { data: student, error } = await supabase
      .from("students")
      .insert({
        full_name,
        matricule,
        sex: rawSex === "M" || rawSex === "F" ? rawSex : null,
        date_of_birth: /^\d{4}-\d{2}-\d{2}$/.test(dob) ? dob : null,
        guardian_name: at(row, cols.guardian_name) || null,
        guardian_phone: at(row, cols.guardian_phone) || null,
        login_code: await uniqueCode(supabase),
      })
      .select("id, full_name, login_code")
      .single();

    if (error || !student) {
      skipped.push({ name: full_name, why: error?.message ?? "insert refused" });
      continue;
    }

    seenNames.add(key);
    if (matricule) seenMatricules.add(matricule.toLowerCase());

    if (classId) {
      await supabase.from("enrolments").insert({
        class_id: classId,
        student_id: student.id,
        status: "active",
      });
    }
    added.push({ name: student.full_name, code: student.login_code });
  }

  revalidatePath("/admin/students");
  revalidatePath("/admin");

  if (added.length === 0 && skipped.length === 0) {
    return { error: "No names were found in that list." };
  }
  return { added, skipped, usedHeader: looksLikeHeader };
}

/**
 * Clear a forgotten PIN.
 *
 * There is no email reset because there is no email. The student comes to the
 * teacher, who can see who is asking, and sets a new PIN on the next sign-in.
 */
export async function resetStudentPin(formData) {
  const supabase = await createClient();
  if (!supabase) return;
  if (!(await teacherOrNull(supabase))) return;

  const id = formData.get("student_id");
  if (!id) return;

  await supabase.rpc("clear_student_pin", { p_student: id });
  revalidatePath(`/admin/students/${id}`);
}
