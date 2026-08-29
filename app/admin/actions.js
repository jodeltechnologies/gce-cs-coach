"use server";

import { revalidatePath } from "next/cache";
import { createClient } from "../../lib/supabase-server";

const FREQUENCIES = ["rare", "occasional", "frequent", "almost_certain"];

/**
 * Save exam frequencies. The form submits one field per category, named
 * freq:<uuid>, so the whole sheet can be set in one pass and one save.
 *
 * Every write goes through the anon key with the teacher's session attached,
 * so Row Level Security decides whether it is allowed. If someone posts this
 * form without being signed in, the database refuses it — the check does not
 * depend on this code being correct.
 */
export async function saveExamFrequencies(formData) {
  const supabase = await createClient();
  if (!supabase) return;

  const updates = [];
  for (const [field, value] of formData.entries()) {
    if (!field.startsWith("freq:")) continue;
    const id = field.slice(5);
    if (value === "" || value === "unset") {
      updates.push({ id, exam_frequency: null });
    } else if (FREQUENCIES.includes(value)) {
      updates.push({ id, exam_frequency: value });
    }
  }

  for (const u of updates) {
    await supabase
      .from("competencies")
      .update({ exam_frequency: u.exam_frequency, updated_at: new Date().toISOString() })
      .eq("id", u.id);
  }

  revalidatePath("/admin");
  revalidatePath("/admin/exam-frequency");
}

/** Confirm or reject one proposed cross-year link. */
export async function decideLink(formData) {
  const supabase = await createClient();
  if (!supabase) return;

  const id = formData.get("id");
  const decision = formData.get("decision");
  if (!id) return;

  if (decision === "confirm") {
    await supabase
      .from("competencies")
      .update({ link_confirmed: true, updated_at: new Date().toISOString() })
      .eq("id", id);
  } else if (decision === "reject") {
    // Rejecting clears the link entirely rather than marking it false, so the
    // same wrong suggestion is not offered again on the next visit.
    await supabase
      .from("competencies")
      .update({
        continues_from_id: null,
        link_confirmed: false,
        updated_at: new Date().toISOString(),
      })
      .eq("id", id);
  }

  revalidatePath("/admin");
  revalidatePath("/admin/links");
}
