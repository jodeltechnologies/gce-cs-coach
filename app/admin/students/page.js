import Link from "next/link";
import { createClient, getUser } from "../../../lib/supabase-server";
import AddStudentForm from "./AddStudentForm";
import ImportStudents from "./ImportStudents";

export const metadata = { title: "Students" };
export const dynamic = "force-dynamic";

export default async function StudentsPage({ searchParams }) {
  const supabase = await createClient();
  if (!supabase) return <p>Not configured.</p>;

  const user = await getUser();
  const { data: teacher } = await supabase
    .from("teachers")
    .select("id")
    .eq("auth_user_id", user?.id ?? "")
    .maybeSingle();

  if (!teacher) {
    return (
      <div className="notice bad">
        <h3>Account not linked</h3>
        <p>
          Go back to <Link href="/admin">Admin</Link> for the fix.
        </p>
      </div>
    );
  }

  const sp = await searchParams;
  const classFilter = sp?.class ?? "";
  const showCodes = sp?.codes === "1";

  const { data: classes } = await supabase
    .from("classes")
    .select("id, name, form_level, academic_year")
    .eq("teacher_id", teacher.id)
    .order("academic_year", { ascending: false });

  // Enrolments carry the class link, so start there when a class is chosen.
  let students = [];
  if (classFilter) {
    const { data } = await supabase
      .from("enrolments")
      .select(
        "id, status, students(id, full_name, matricule, sex, login_code, guardian_phone)"
      )
      .eq("class_id", classFilter)
      .is("deleted_at", null);
    students = (data ?? [])
      .filter((e) => e.students)
      .map((e) => ({ ...e.students, enrolment_status: e.status }))
      .sort((a, b) => a.full_name.localeCompare(b.full_name));
  } else {
    const { data } = await supabase
      .from("students")
      .select("id, full_name, matricule, sex, login_code, guardian_phone")
      .is("deleted_at", null)
      .order("full_name");
    students = data ?? [];
  }

  const noClasses = !classes || classes.length === 0;

  return (
    <>
      <h2>Students</h2>
      <p className="lede">
        The roll. Each student gets a short code they use to sign in — there is
        no email, because most of them do not have one they check.
      </p>

      {noClasses && (
        <div className="notice">
          <h3>Create a class first</h3>
          <p>
            A student needs somewhere to be enrolled.{" "}
            <Link href="/admin/classes">Add a class</Link>, then come back.
          </p>
        </div>
      )}

      <div style={{ display: "flex", gap: 6, flexWrap: "wrap", marginBottom: 16 }}>
        <Link
          href="/admin/students"
          className={classFilter === "" ? "tag" : "tag plain"}
          style={{ padding: "6px 13px" }}
        >
          Everyone ({students.length === 0 && classFilter ? "" : ""}
          {classFilter ? "" : students.length})
        </Link>
        {(classes ?? []).map((c) => (
          <Link
            key={c.id}
            href={`/admin/students?class=${c.id}`}
            className={classFilter === c.id ? "tag" : "tag plain"}
            style={{ padding: "6px 13px" }}
          >
            {c.name}
          </Link>
        ))}
      </div>

      {students.length > 0 && (
        <div className="tags" style={{ marginBottom: 14 }}>
          <span className="tag plain">{students.length} students</span>
          <Link
            href={
              classFilter
                ? `/admin/students?class=${classFilter}&codes=${showCodes ? "0" : "1"}`
                : `/admin/students?codes=${showCodes ? "0" : "1"}`
            }
            className={showCodes ? "tag gold" : "tag plain"}
            style={{ padding: "5px 12px" }}
          >
            {showCodes ? "Hide login codes" : "Show login codes to print"}
          </Link>
        </div>
      )}

      {showCodes && students.length > 0 && (
        <div className="notice">
          <h3>Login codes</h3>
          <p style={{ fontSize: "0.86rem" }}>
            Print this, cut it up, hand each student their slip. Codes leave out
            O, 0, I and 1 — those cause more trouble than they are worth when a
            code is copied off a board onto a cracked phone screen.
          </p>
          <div className="codes">
            {students.map((s) => (
              <div className="code-slip" key={s.id}>
                <div className="code-name">{s.full_name}</div>
                <div className="code-value">{s.login_code}</div>
              </div>
            ))}
          </div>
        </div>
      )}

      {students.map((s) => (
        <Link className="row" key={s.id} href={`/admin/students/${s.id}`} style={{ display: "block", color: "inherit" }}>
          <div className="name">{s.full_name}</div>
          <div className="tags" style={{ marginTop: 5 }}>
            {s.matricule && <span className="tag plain">{s.matricule}</span>}
            {s.sex && <span className="tag plain">{s.sex}</span>}
            {s.enrolment_status && s.enrolment_status !== "active" && (
              <span className="tag alert">{s.enrolment_status}</span>
            )}
            {!s.guardian_phone && (
              <span className="tag gold">No guardian phone</span>
            )}
          </div>
        </Link>
      ))}

      {students.length === 0 && !noClasses && (
        <div className="notice">
          <h3>Nobody here yet</h3>
          <p>Add your first student below.</p>
        </div>
      )}

      <h3 style={{ marginTop: 34 }}>Add a student</h3>
      <div style={{ marginBottom: 18 }}>
        <ImportStudents classes={classes} defaultClass={classFilter} />
      </div>
      <AddStudentForm classes={classes} defaultClass={classFilter} />
    </>
  );
}
