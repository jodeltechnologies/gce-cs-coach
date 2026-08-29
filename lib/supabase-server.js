import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

export const isConfigured = Boolean(url && key);

/**
 * Supabase client for server components and server actions.
 * Reads and writes the session cookie, so the signed-in teacher is known.
 * Returns null when the environment variables are missing, so a fresh
 * deployment shows a setup notice instead of failing the build.
 */
export async function createClient() {
  if (!isConfigured) return null;
  const cookieStore = await cookies();
  return createServerClient(url, key, {
    cookies: {
      getAll() {
        return cookieStore.getAll();
      },
      setAll(list) {
        try {
          for (const { name, value, options } of list) {
            cookieStore.set(name, value, options);
          }
        } catch {
          // Server components cannot set cookies. Middleware refreshes the
          // session instead, so ignoring this is correct rather than lazy.
        }
      },
    },
  });
}

/** The signed-in user, or null. */
export async function getUser() {
  const supabase = await createClient();
  if (!supabase) return null;
  const { data } = await supabase.auth.getUser();
  return data?.user ?? null;
}
