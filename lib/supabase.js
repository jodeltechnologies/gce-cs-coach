import { createClient } from "@supabase/supabase-js";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

/**
 * Returns a Supabase client, or null if the environment variables have not
 * been set yet.
 *
 * Returning null rather than throwing is deliberate. If this threw, the very
 * first Vercel deployment would fail before you had a chance to add the
 * variables, and a failed build is a confusing thing to debug. Instead the
 * site deploys, and every page shows a short setup notice telling you exactly
 * what is missing.
 */
export function getSupabase() {
  if (!url || !key) return null;
  return createClient(url, key, { auth: { persistSession: false } });
}

export const isConfigured = Boolean(url && key);
