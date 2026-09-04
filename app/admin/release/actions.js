"use server";

import { revalidatePath } from "next/cache";
import { createClient } from "../../../lib/supabase-server";

/**
 * Releasing notes to a class.
 *
 * Everything here goes through a database function rather than writing to
 * note_releases from this file. The first version wrote to the table
 * directly, which failed silently: row level security was on and no policy
 * had been written, so every insert was refused and the page reported
 * success. A function that raises when the class is not yours is harder to
 * be wrong about quietly.
 */

/** Hold a whole source back, or open it to everybody. */
export async function setMode(formData) {
  const supabase = await createClient();
  if (!supabase) return;

  const sourceId = String(formData.get("source_id") ?? "");
  const mode = String(formData.get("mode") ?? "");
  if (!sourceId || !["open", "staged"].includes(mode)) return;

  await supabase.rpc("set_source_release_mode", {
    p_source: sourceId,
    p_mode: mode,
  });
  revalidatePath("/admin/release");
}

/** Release or withdraw every chapter of one source at once. */
export async function releaseAll(formData) {
  const supabase = await createClient();
  if (!supabase) return;

  const classId = String(formData.get("class_id") ?? "");
  const sourceId = String(formData.get("source_id") ?? "");
  const release = String(formData.get("release") ?? "") === "yes";
  if (!classId || !sourceId) return;

  await supabase.rpc("release_whole_source", {
    p_class: classId,
    p_source: sourceId,
    p_release: release,
  });
  revalidatePath("/admin/release");
}

/** Save the ticks for one source. */
export async function setRelease(formData) {
  const supabase = await createClient();
  if (!supabase) return;

  const classId = String(formData.get("class_id") ?? "");
  const offered = formData.getAll("offered").map(String);
  const wanted = formData.getAll("release").map(String);
  if (!classId || offered.length === 0) return;

  await supabase.rpc("set_releases", {
    p_class: classId,
    p_offered: offered,
    p_release: wanted,
  });
  revalidatePath("/admin/release");
}
