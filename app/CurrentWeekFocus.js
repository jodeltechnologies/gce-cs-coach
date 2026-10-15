"use client";

import { useEffect, useState } from "react";
import { currentWeek, formatRange, schoolNow, toISO } from "../lib/school-calendar";

/** Recheck after midnight and when a suspended phone tab becomes visible. */
export default function CurrentWeekFocus({ weeks }) {
  const [week, setWeek] = useState(undefined);
  useEffect(() => {
    let lastDate;
    const update = () => {
      const now = schoolNow();
      const date = toISO(now);
      if (date === lastDate) return;
      lastDate = date;
      const current = currentWeek(now);
      setWeek(current);
      // Keep a deliberately shared lesson/week anchor on first open.
      if (window.location.hash) return;
      const number = current && weeks.find((n) => n >= current.week);
      const target = number && document.getElementById(`week-${number}`);
      if (target) requestAnimationFrame(() => target.scrollIntoView({ block: "start" }));
    };
    update();
    const timer = setInterval(update, 60000);
    document.addEventListener("visibilitychange", update);
    return () => {
      clearInterval(timer);
      document.removeEventListener("visibilitychange", update);
    };
  }, [weeks]);

  useEffect(() => {
    document.querySelectorAll("[data-progression-week]").forEach((el) => {
      el.classList.toggle("current-progression-week", Number(el.dataset.progressionWeek) === week?.week);
    });
  }, [week]);

  if (week === undefined) return <p className="week-status">Finding the current teaching week…</p>;
  if (!week) return <p className="week-status">The 2026/2027 teaching year has ended.</p>;
  return (
    <p className="week-status">
      <strong>Week {week.week}</strong> · {formatRange(week.start, week.end)}{" "}
      {weeks.includes(week.week) ? <a href={`#week-${week.week}`}>Go to this week</a> : <span>No separate lessons listed for this week. Showing the next available week.</span>}
    </p>
  );
}
