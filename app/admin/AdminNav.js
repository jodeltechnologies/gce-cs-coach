"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const LINKS = [
  { href: "/admin", label: "Overview", exact: true },
  { href: "/admin/lessons", label: "Lesson notes" },
  { href: "/admin/classes", label: "Classes" },
  { href: "/admin/students", label: "Students" },
  { href: "/admin/questions", label: "Questions" },
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
  return (
    <nav className="subnav">
      {LINKS.map((l) => {
        const active = l.exact ? path === l.href : path.startsWith(l.href);
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
