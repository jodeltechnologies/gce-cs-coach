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

/** Mark one answer. The correct option is decided in the database. */
export async function checkAnswer(questionId, label) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data, error } = await supabase.rpc("student_check", {
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
