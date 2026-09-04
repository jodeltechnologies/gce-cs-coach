import { createServerClient } from "@supabase/ssr";
import { NextResponse } from "next/server";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

/**
 * Three jobs:
 *   1. Refresh the Supabase session cookie on every request, so a teacher is
 *      not signed out mid-lesson.
 *   2. Keep /admin closed to anyone not signed in.
 *   3. Keep the progression sheet closed too. It is the teacher's planning
 *      document: the whole year, every objective, every assessment week.
 *      Students get the next ten lessons on their own page instead.
 *
 * This is the outer gate, for convenience and for sending people somewhere
 * useful. The real defence is Row Level Security in the database: even if
 * this file were deleted, an unauthenticated request still could not read
 * the sheet. Never rely on a redirect alone to protect data.
 *
 * The student cookie is only checked for presence here. It is signed, and
 * that signature is verified on the server by getStudentSession, but the
 * check needs node crypto and middleware does not have it. Presence is
 * enough for deciding where to send somebody. It decides nothing about what
 * they may read.
 */

// Reachable without signing in at all.
const OPEN = ["/login", "/student/login", "/auth", "/api"];

// The teacher's own pages.
const TEACHER_ONLY = ["/admin"];

// The progression sheet and everything hanging off it.
const SHEET = ["/syllabus", "/lesson"];

function startsWithAny(path, list) {
  return list.some((p) => path === p || path.startsWith(p + "/"));
}
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
  if (startsWithAny(path, OPEN)) return response;

  const hasStudent = Boolean(request.cookies.get("gce_student")?.value);
  const isSheet = path === "/" || startsWithAny(path, SHEET);
  const isAdmin = startsWithAny(path, TEACHER_ONLY);

  const goTo = (pathname, keepNext) => {
    const to = request.nextUrl.clone();
    to.pathname = pathname;
    to.search = "";
    if (keepNext) to.searchParams.set("next", path);
    return NextResponse.redirect(to);
  };

  if (user) return response;

  // A signed-in student is sent to their own side rather than refused. Being
  // turned away by a site you are signed into reads as a fault, and they will
  // try the same link again instead of going where they meant.
  if (hasStudent) {
    if (isSheet) return goTo("/student/progress");
    if (isAdmin) return goTo("/student");
    return response;
  }

  if (isAdmin || isSheet) return goTo("/login", true);

  return response;
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico|.*\\.(?:jpg|png|svg|ico)$).*)"],
};
