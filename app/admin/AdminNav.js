"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const LINKS = [
  { href: "/admin", label: "Overview", exact: true },
  { href: "/admin/timetable", label: "My timetable" },
  { href: "/admin/lessons", label: "Lesson notes" },
  { href: "/admin/classes", label: "Classes" },
  { href: "/admin/students", label: "Students" },
  { href: "/admin/assessments", label: "Tests" },
  { href: "/admin/marking", label: "Marking" },
  { href: "/admin/progress", label: "Class progress" },
  { href: "/admin/notes", label: "Course notes" },
  { href: "/admin/questions", label: "Questions" },
  { href: "/admin/questions/review", label: "Check imports" },
  { href: "/admin/exam-frequency", label: "Exam frequency" },
  { href: "/admin/links", label: "Cross-year links" },
];

/**
 * Sticks to the top of every admin screen so you can jump straight between
 * them. Every item is a Link rather than a plain anchor, so moving between
 * them fetches only the part of the page that changed instead of reloading
 * the whole thing — which is the difference between instant and several
 * seconds on a weak connection.
 */
export default function AdminNav() {
  const path = usePathname();
  // /admin/questions/review sits underneath /admin/questions, so a plain
  // startsWith would light up both. The longest matching href wins.
  const best = LINKS.reduce((acc, l) => {
    const hit = l.exact ? path === l.href : path.startsWith(l.href);
    if (!hit) return acc;
    return !acc || l.href.length > acc.length ? l.href : acc;
  }, null);
  return (
    <nav className="subnav">
      {LINKS.map((l) => {
        const active = l.href === best;
        return (
          <Link
            key={l.href}
            href={l.href}
            className={active ? "subnav-item active" : "subnav-item"}
          >
            {l.label}
          </Link>
        );
      })}
    </nav>
  );
}
