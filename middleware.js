import { createServerClient } from "@supabase/ssr";
import { NextResponse } from "next/server";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

/**
 * Two jobs:
 *   1. Refresh the Supabase session cookie on every request, so a teacher is
 *      not signed out mid-lesson.
 *   2. Keep /admin closed to anyone not signed in.
 *
 * This is the outer gate, for convenience and clarity. The real defence is
 * Row Level Security in the database: even if this file were deleted, an
 * unauthenticated request still could not read a student or change a mark.
 * Never rely on a redirect alone to protect data.
 */
export async function middleware(request) {
  let response = NextResponse.next({ request });

  if (!url || !key) return response;

  const supabase = createServerClient(url, key, {
    cookies: {
      getAll() {
        return request.cookies.getAll();
      },
      setAll(list) {
        for (const { name, value } of list) request.cookies.set(name, value);
        response = NextResponse.next({ request });
        for (const { name, value, options } of list) {
          response.cookies.set(name, value, options);
        }
      },
    },
  });

  const {
    data: { user },
  } = await supabase.auth.getUser();

  const path = request.nextUrl.pathname;
  if (!user && path.startsWith("/admin")) {
    const to = request.nextUrl.clone();
    to.pathname = "/login";
    to.searchParams.set("next", path);
    return NextResponse.redirect(to);
  }

  return response;
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico|.*\\.(?:jpg|png|svg|ico)$).*)"],
};
