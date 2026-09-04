"use server";

import { revalidatePath } from "next/cache";
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
/** The topics a student can pick from, with how they have done in each. */
export async function practiceTopics() {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data: prof } = await supabase.rpc("student_profile", {
    p_student: session.id,
  });
  const profile = Array.isArray(prof) ? prof[0] : prof;
  if (!profile?.syllabus_id) return { error: "You are not in a class yet." };

  const { data, error } = await supabase.rpc("student_practice_topics", {
    p_syllabus: profile.syllabus_id,
    p_student: session.id,
  });
  if (error) return { error: error.message };
  return { topics: data ?? [] };
}

export async function startPractice({ lessonId = null, count = 10, mode = "mixed" } = {}) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data: prof } = await supabase.rpc("student_profile", {
    p_student: session.id,
  });
  const profile = Array.isArray(prof) ? prof[0] : prof;
  if (!profile?.syllabus_id) return { error: "You are not in a class yet." };

  // Clamp here as well as in SQL. A count arriving from a query string is
  // whatever the address bar contained.
  const n = Math.min(Math.max(Number(count) || 10, 1), 50);
  const chosenMode = ["mixed", "weak", "lesson"].includes(mode) ? mode : "mixed";

  const { data: attemptId, error: aErr } = await supabase.rpc(
    "student_start_practice",
    {
      p_student: session.id,
      p_syllabus: profile.syllabus_id,
      p_lesson: lessonId,
      p_mode: chosenMode,
    }
  );
  if (aErr) return { error: aErr.message };

  const { data, error } = await supabase.rpc("student_practice", {
    p_syllabus: profile.syllabus_id,
    p_limit: n,
    p_student: session.id,
    p_lesson: lessonId,
    p_mode: chosenMode,
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

/**
 * A set of structured questions to work through.
 *
 * These are not marked. The student writes an answer, then sees the model
 * answer and the marks, and judges their own against it — which is what
 * happens when a script comes back. Pretending to score a paragraph would be
 * worse than not scoring it.
 */
export async function startStructured({ lessonId = null, count = 2 } = {}) {
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
    {
      p_student: session.id,
      p_syllabus: profile.syllabus_id,
      p_lesson: lessonId,
      p_mode: lessonId ? "lesson" : "mixed",
    }
  );
  if (aErr) return { error: aErr.message };

  const { data, error } = await supabase.rpc("student_structured", {
    p_syllabus: profile.syllabus_id,
    p_lesson: lessonId,
    p_limit: Math.min(Math.max(Number(count) || 2, 1), 10),
  });
  if (error) return { error: error.message };
  return { attemptId, questions: data ?? [] };
}

/** Save what was written, then hand back the model answer. */
export async function submitPart(attemptId, partId, response) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data, error } = await supabase.rpc("student_answer_part", {
    p_attempt: attemptId,
    p_student: session.id,
    p_part: partId,
    p_response: response ?? "",
  });
  if (error) return { error: error.message };
  const row = Array.isArray(data) ? data[0] : data;
  return {
    modelAnswer: row?.model_answer ?? null,
    marks: row?.marks ?? null,
  };
}

// ---------------------------------------------------------------------------
// Tests set by the teacher
//
// Different from practice in one way that shapes everything below: a test is
// graded, so nothing tells the student whether an answer was right until they
// submit. A student who learns question three was wrong before answering
// question four is sitting a different test from one who does not.
// ---------------------------------------------------------------------------

export async function myAssessments() {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data, error } = await supabase.rpc("student_assessments", {
    p_student: session.id,
  });
  if (error) return { error: error.message };
  return { assessments: data ?? [] };
}

export async function openAssessment(assessmentId) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data: attemptId, error } = await supabase.rpc(
    "student_start_assessment",
    { p_student: session.id, p_assessment: assessmentId }
  );
  if (error) return { error: error.message };
  if (!attemptId) {
    // The function returns null for every refusal rather than saying which,
    // so this covers all of them honestly instead of guessing.
    return {
      error:
        "You cannot open this test. It may be closed, not set for your class, " +
        "or you may have already submitted it.",
    };
  }

  const { data: questions, error: qErr } = await supabase.rpc(
    "student_assessment_questions",
    { p_student: session.id, p_attempt: attemptId }
  );
  if (qErr) return { error: qErr.message };
  return { attemptId, questions: questions ?? [] };
}

/** Save one answer. Says nothing about whether it was right. */
export async function saveTestAnswer(attemptId, questionId, label, response) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data, error } = await supabase.rpc("student_assessment_answer", {
    p_attempt: attemptId,
    p_student: session.id,
    p_question: questionId,
    p_label: label ?? null,
    p_response: response ?? null,
  });
  if (error) return { error: error.message };
  return { saved: data === true };
}

export async function submitAssessment(attemptId) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { data, error } = await supabase.rpc("student_submit_assessment", {
    p_attempt: attemptId,
    p_student: session.id,
  });
  if (error) return { error: error.message };
  const row = Array.isArray(data) ? data[0] : data;
  return {
    score: row?.score ?? 0,
    outOf: row?.out_of ?? 0,
    awaitingMarking: Number(row?.awaiting_marking ?? 0),
  };
}

// ---------------------------------------------------------------------------
// The questions at the foot of a note
// ---------------------------------------------------------------------------

/**
 * Record what a student said about one question.
 *
 * Nothing here marks a written answer. The student compares their own against
 * the model and reports which of three things happened, and that report is
 * stored as a report. It shows on the progress page and on the teacher's, and
 * it is labelled everywhere as the student's own judgement rather than as a
 * score, because a number would suggest a precision that is not there.
 */
export async function recordSelfCheck(sectionId, index, question, report) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const { error } = await supabase.rpc("record_self_check", {
    p_student: session.id,
    p_section: sectionId,
    p_index: Number(index),
    p_question: String(question ?? "").slice(0, 500),
    p_report: report,
  });
  if (error) return { error: error.message };
  return { saved: true };
}

// ---------------------------------------------------------------------------
// Writing to the teacher
// ---------------------------------------------------------------------------

export async function sendMessage(prevState, formData) {
  const session = await getStudentSession();
  if (!session) return { error: "Signed out." };
  const supabase = await createClient();
  if (!supabase) return { error: "Not connected." };

  const body = String(formData.get("body") ?? "").trim();
  if (!body) return { error: "Write something first." };

  const { error } = await supabase.rpc("student_send_message", {
    p_student: session.id,
    p_body: body,
    p_lesson: formData.get("lesson_id") || null,
    p_section: formData.get("note_section_id") || null,
  });
  if (error) {
    // The rate limit raises rather than returning a code, so the message is
    // turned into something a student can act on.
    if (String(error.message).includes("too many messages")) {
      return {
        error:
          "You have sent a lot of messages in the last hour. Wait a while, " +
          "then send the rest in one message.",
      };
    }
    return { error: error.message };
  }
  revalidatePath("/student/messages");
  return { sent: true };
}
