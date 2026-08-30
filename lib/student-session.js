import crypto from "node:crypto";
import { cookies } from "next/headers";

/**
 * Student sessions.
 *
 * Students do not go through Supabase auth: they have no email, so the sign
 * up, confirm and reset flow has nothing to send anything to. They sign in
 * with a paper code and a PIN, and this holds the result.
 *
 * The cookie carries the student id and an HMAC of it. Without the signature
 * the id is just a string in a cookie jar, and any student could type another
 * student's id and read their marks. The secret never leaves the server.
 */

const COOKIE = "gce_student";
const MAX_AGE = 60 * 60 * 24 * 30; // a term is longer than a month, but a
                                   // shared phone should not stay signed in
                                   // for a whole year

function secret() {
  const s = process.env.STUDENT_SESSION_SECRET;
  if (!s || s.length < 24) {
    // Failing loudly beats signing with a default: a predictable secret is the
    // same as no signature at all, and it would not be obvious that anything
    // was wrong until someone noticed they could read another student's marks.
    throw new Error(
      "STUDENT_SESSION_SECRET is missing or too short. Set it to a random " +
      "string of at least 24 characters in your environment variables."
    );
  }
  return s;
}

function sign(value) {
  return crypto.createHmac("sha256", secret()).update(value).digest("base64url");
}

export function isStudentAuthConfigured() {
  const s = process.env.STUDENT_SESSION_SECRET;
  return Boolean(s && s.length >= 24);
}

export async function startStudentSession(studentId, fullName) {
  const payload = `${studentId}.${Buffer.from(fullName).toString("base64url")}`;
  const cookieStore = await cookies();
  cookieStore.set(COOKIE, `${payload}.${sign(payload)}`, {
    httpOnly: true,
    sameSite: "lax",
    secure: process.env.NODE_ENV === "production",
    path: "/",
    maxAge: MAX_AGE,
  });
}

export async function getStudentSession() {
  if (!isStudentAuthConfigured()) return null;
  const cookieStore = await cookies();
  const raw = cookieStore.get(COOKIE)?.value;
  if (!raw) return null;

  const cut = raw.lastIndexOf(".");
  if (cut < 0) return null;
  const payload = raw.slice(0, cut);
  const signature = raw.slice(cut + 1);

  const expected = sign(payload);
  // Constant-time compare: a plain === leaks how much of the signature was
  // right through how long the comparison took.
  const a = Buffer.from(signature);
  const b = Buffer.from(expected);
  if (a.length !== b.length || !crypto.timingSafeEqual(a, b)) return null;

  const [id, name] = payload.split(".");
  if (!id) return null;
  return {
    id,
    fullName: name ? Buffer.from(name, "base64url").toString("utf8") : "",
  };
}

export async function endStudentSession() {
  const cookieStore = await cookies();
  cookieStore.delete(COOKIE);
}
