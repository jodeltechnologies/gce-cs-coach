import Link from "next/link";
import { createClient, getUser } from "../../../../lib/supabase-server";
import {
  updateStudent,
  regenerateCode,
  enrolStudent,
  setEnrolmentStatus,
  resetStudentPin,
} from "../actions";

export const metadata = { title: "Student" };
export const dynamic = "force-dynamic";

const STATUSES = ["active", "repeating", "transferred", "withdrawn"];

export default async function StudentPage({ params }) {
  const { id } = await params;
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

  const { data: student } = await supabase
    .from("students")
    .select("*")
    .eq("id", id)
    .maybeSingle();

  if (!student) {
    return (
      <>
        <h2>Student not found</h2>
        <p className="lede">
          <Link href="/admin/students">Back to the roll</Link>
        </p>
      </>
    );
  }

  const [{ data: enrolments }, { data: classes }] = await Promise.all([
    supabase
      .from("enrolments")
      .select("id, status, enrolled_on, classes(id, name, form_level, academic_year)")
      .eq("student_id", id)
      .is("deleted_at", null),
    supabase
      .from("classes")
      .select("id, name, academic_year")
      .eq("teacher_id", teacher.id)
      .order("academic_year", { ascending: false }),
  ]);

  const enrolledIds = new Set((enrolments ?? []).map((e) => e.classes?.id));
  const available = (classes ?? []).filter((c) => !enrolledIds.has(c.id));

  return (
    <>
      <h2>{student.full_name}</h2>
      <p className="lede">
        {student.matricule ? `${student.matricule} · ` : ""}
        Login code <strong>{student.login_code}</strong>
      </p>

      <div className="notice">
        <h3>Login code</h3>
        <p style={{ fontSize: "0.88rem", marginBottom: 10 }}>
          This is what the student types instead of an email. Regenerating it
          makes the old one stop working immediately, so only do it if a code
          has been shared around or lost.
        </p>
        <div className="code-slip" style={{ maxWidth: 240 }}>
          <div className="code-name">{student.full_name}</div>
          <div className="code-value">{student.login_code}</div>
        </div>
        <div style={{ display: "flex", gap: 16, marginTop: 12 }}>
          <form action={regenerateCode}>
            <input type="hidden" name="student_id" value={student.id} />
            <button className="link" type="submit">
              Generate a new code
            </button>
          </form>
          <form action={resetStudentPin}>
            <input type="hidden" name="student_id" value={student.id} />
            <button className="link" type="submit">
              Reset their PIN
            </button>
          </form>
        </div>
        <p style={{ fontSize: "0.82rem", color: "var(--muted)", marginTop: 8 }}>
          Resetting the PIN keeps the code. The student chooses a new PIN the
          next time they sign in. Do it in person, so you can see who is asking.
        </p>
      </div>

      <h3>Classes</h3>
      {(enrolments ?? []).length === 0 && (
        <p className="lede">Not enrolled in any class yet.</p>
      )}
      {(enrolments ?? []).map((e) => (
        <div className="row" key={e.id}>
          <div className="name">
            {e.classes ? (
              <Link href={`/admin/classes/${e.classes.id}`}>
                {e.classes.name}
              </Link>
            ) : (
              "Unknown class"
            )}
          </div>
          <div className="sub">
            {e.classes?.form_level} · {e.classes?.academic_year} · enrolled{" "}
            {e.enrolled_on}
          </div>
          <form action={setEnrolmentStatus} style={{ marginTop: 8, display: "flex", gap: 8 }}>
            <input type="hidden" name="enrolment_id" value={e.id} />
            <input type="hidden" name="student_id" value={student.id} />
            <select
              name="status"
              defaultValue={e.status}
              style={{ width: "auto", padding: "6px 10px", fontSize: "0.85rem" }}
            >
              {STATUSES.map((s) => (
                <option key={s} value={s}>
                  {s}
                </option>
              ))}
            </select>
            <button className="link" type="submit">
              Update
            </button>
          </form>
        </div>
      ))}

      {available.length > 0 && (
        <form action={enrolStudent} style={{ marginTop: 14, display: "flex", gap: 8, flexWrap: "wrap" }}>
          <input type="hidden" name="student_id" value={student.id} />
          <select name="class_id" style={{ width: "auto", flex: 1, minWidth: 180 }}>
            {available.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name} · {c.academic_year}
              </option>
            ))}
          </select>
          <button className="primary" type="submit">
            Enrol
          </button>
        </form>
      )}

      <h3 style={{ marginTop: 34 }}>Details</h3>
      <form action={updateStudent} style={{ maxWidth: 460 }}>
        <input type="hidden" name="student_id" value={student.id} />

        <label className="field">
          <span>Full name</span>
          <input type="text" name="full_name" defaultValue={student.full_name} required />
        </label>

        <div style={{ display: "flex", gap: 12 }}>
          <label className="field" style={{ flex: 1 }}>
            <span>Matricule</span>
            <input type="text" name="matricule" defaultValue={student.matricule ?? ""} />
          </label>
          <label className="field" style={{ width: 110 }}>
            <span>Sex</span>
            <select name="sex" defaultValue={student.sex ?? ""}>
              <option value="">—</option>
              <option value="F">F</option>
              <option value="M">M</option>
            </select>
          </label>
        </div>

        <label className="field">
          <span>Date of birth</span>
          <input
            type="text"
            name="date_of_birth"
            defaultValue={student.date_of_birth ?? ""}
            placeholder="2008-03-14"
          />
        </label>

        <label className="field">
          <span>Guardian name</span>
          <input type="text" name="guardian_name" defaultValue={student.guardian_name ?? ""} />
        </label>

        <div style={{ display: "flex", gap: 12 }}>
          <label className="field" style={{ flex: 1 }}>
            <span>Guardian phone</span>
            <input
              type="text"
              name="guardian_phone"
              defaultValue={student.guardian_phone ?? ""}
            />
          </label>
          <label className="field" style={{ flex: 1 }}>
            <span>Student phone</span>
            <input
              type="text"
              name="student_phone"
              defaultValue={student.student_phone ?? ""}
            />
          </label>
        </div>

        <button className="primary" type="submit">
          Save details
        </button>
      </form>

      <p className="lede" style={{ marginTop: 30 }}>
        <Link href="/admin/students">Back to the roll</Link>
      </p>
    </>
  );
}
