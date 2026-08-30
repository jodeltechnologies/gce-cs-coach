"use server";

import { redirect } from "next/navigation";
import { createClient } from "../../lib/supabase-server";
import {
  startStudentSession,
  endStudentSession,
  getStudentSession,
  isStudentAuthConfigured,
} from "../../lib/student-session";

/**
 * Everything a student can do runs through here.
 *
 * The database functions these call are SECURITY DEFINER, so Row Level
 * Security stays shut on the tables themselves. A student never reads a table
 * directly; they read exactly the columns a function chooses to return.
 */

export async function signIn(prevState, formData) {
  if (!isStudentAuthConfigured()) {
    return { error: "Student sign-in is not set up on this server yet." };
  }
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected to the database." };

  const code = String(formData.get("code") ?? "").trim();
  const pin = String(formData.get("pin") ?? "").trim();
  if (!code) return { error: "Enter the code from your register." };

  const { data, error } = await supabase.rpc("student_sign_in", {
    p_code: code,
    p_pin: pin || "",
  });
  if (error) return { error: error.message };

  const row = Array.isArray(data) ? data[0] : data;
  if (!row) {
    // Deliberately vague. Saying "that code exists but the PIN is wrong"
    // tells someone holding a found code that it is worth guessing.
    return {
      error:
        "That code and PIN did not match. Check them, or ask your teacher. " +
        "After five wrong tries the code pauses for fifteen minutes.",
    };
  }

  if (row.needs_pin) {
    return { needsPin: true, code, name: row.full_name };
  }

  await startStudentSession(row.student_id, row.full_name);
  redirect("/student");
}

export async function setPin(prevState, formData) {
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected to the database." };

  const code = String(formData.get("code") ?? "").trim();
  const pin = String(formData.get("pin") ?? "").trim();
  const again = String(formData.get("pin_again") ?? "").trim();

  if (!/^[0-9]{4,6}$/.test(pin)) {
    return { needsPin: true, code, error: "Your PIN must be 4 to 6 digits." };
  }
  if (pin !== again) {
    return { needsPin: true, code, error: "The two PINs are not the same." };
  }

  const { data, error } = await supabase.rpc("student_set_pin", {
    p_code: code,
    p_pin: pin,
  });
  if (error) return { needsPin: true, code, error: error.message };

  const row = Array.isArray(data) ? data[0] : data;
  if (!row) {
    return {
      needsPin: true,
      code,
      error: "That code already has a PIN. Ask your teacher to reset it.",
    };
  }

  await startStudentSession(row.student_id, row.full_name);
  redirect("/student");
}

export async function signOut() {
  await endStudentSession();
  redirect("/student/login");
}

/**
 * Start a practice run and get its questions.
 *
 * The attempt row is created before the first question is shown, so a run
 * abandoned halfway still leaves a record of what was answered. Waiting until
 * the end to save would lose exactly the sessions worth studying: the ones a
 * student walked away from.
 */
export async function startPractice() {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data: prof } = await supabase.rpc("student_profile", {
    p_student: session.id,
  });
  const profile = Array.isArray(prof) ? prof[0] : prof;
  if (!profile?.syllabus_id) return { error: "You are not in a class yet." };

  const { data: attemptId, error: aErr } = await supabase.rpc(
    "student_start_practice",
    { p_student: session.id, p_syllabus: profile.syllabus_id }
  );
  if (aErr) return { error: aErr.message };

  const { data, error } = await supabase.rpc("student_practice", {
    p_syllabus: profile.syllabus_id,
    p_limit: 10,
    p_student: session.id,
  });
  if (error) return { error: error.message };

  return { attemptId, questions: data ?? [] };
}

/**
 * Mark one answer and record it in the same call.
 *
 * Not two calls. A student who sees the mark and closes the tab before the
 * save would leave no trace of the question they got wrong, which is the part
 * worth keeping.
 */
export async function checkAnswer(attemptId, questionId, label) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data, error } = await supabase.rpc("student_answer", {
    p_attempt: attemptId,
    p_student: session.id,
    p_question: questionId,
    p_label: label,
  });
  if (error) return { error: error.message };
  const row = Array.isArray(data) ? data[0] : data;
  if (!row) return { error: "That question has no marked answer." };
  return {
    correct: row.correct,
    correctLabel: row.correct_label,
    explanation: row.explanation ?? null,
    // Why the option they actually chose was wrong. Only theirs: handing over
    // the notes for every option would turn the next attempt into a lookup.
    yourFeedback: row.your_feedback ?? null,
  };
}

export async function finishPractice(attemptId) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data, error } = await supabase.rpc("student_finish_practice", {
    p_attempt: attemptId,
    p_student: session.id,
  });
  if (error) return { error: error.message };
  // The mastery table is a cache of the answers, refreshed here rather than
  // kept up to date by a trigger on every answer.
  await supabase.rpc("refresh_lesson_mastery", { p_student: session.id });
  const row = Array.isArray(data) ? data[0] : data;
  return { score: row?.score ?? 0, outOf: row?.out_of ?? 0 };
}
