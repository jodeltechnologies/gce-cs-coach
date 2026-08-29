import { getSupabase } from "../lib/supabase";

export const metadata = { title: "Progression sheets" };

export const dynamic = "force-dynamic";

function SetupNotice() {
  return (
    <div className="notice">
      <h3>Almost there — two settings missing</h3>
      <p>
        The site is deployed but has not been told where your database is. Add
        these two variables in Vercel under{" "}
        <strong>Settings → Environment Variables</strong>, then redeploy:
      </p>
      <ul>
        <li>
          <code>NEXT_PUBLIC_SUPABASE_URL</code>
        </li>
        <li>
          <code>NEXT_PUBLIC_SUPABASE_ANON_KEY</code>
        </li>
      </ul>
      <p>
        Both are in your Supabase dashboard under{" "}
        <strong>Project Settings → API</strong>. Full walkthrough is in{" "}
        <code>DEPLOYMENT.md</code>.
      </p>
    </div>
  );
}

function ErrorNotice({ message }) {
  return (
    <div className="notice">
      <h3>Connected, but the query failed</h3>
      <p>{message}</p>
      <p>
        The usual cause is that <code>db/schema.sql</code> or{" "}
        <code>db/rls.sql</code> has not been run yet in the Supabase SQL Editor.
        Step 2 of <code>DEPLOYMENT.md</code>.
      </p>
    </div>
  );
}

export default async function Home() {
  const supabase = getSupabase();
  if (!supabase) return <SetupNotice />;

  const { data: syllabi, error } = await supabase
    .from("syllabi")
    .select("id, title, form_level, scope, region, coefficient, total_weeks")
    .order("form_level");

  if (error) return <ErrorNotice message={error.message} />;

  if (!syllabi || syllabi.length === 0) {
    return (
      <div className="notice">
        <h3>Database is empty</h3>
        <p>
          The tables exist but no progression sheet has been loaded. Run the
          three files in <code>db/seed/</code> in the Supabase SQL Editor.
        </p>
      </div>
    );
  }

  const counts = await Promise.all(
    syllabi.map(async (s) => {
      const [lessons, objectives, cats] = await Promise.all([
        supabase
          .from("lessons")
          .select("id", { count: "exact", head: true })
          .eq("syllabus_id", s.id),
        supabase
          .from("competencies")
          .select("id", { count: "exact", head: true })
          .eq("syllabus_id", s.id),
        supabase
          .from("modules")
          .select("id", { count: "exact", head: true })
          .eq("syllabus_id", s.id),
      ]);
      return {
        rows: lessons.count ?? 0,
        categories: objectives.count ?? 0,
        modules: cats.count ?? 0,
      };
    })
  );

  return (
    <>
      <h2>Progression sheets</h2>
      <p className="lede">
        Choose a sheet to see the year laid out by term and week.
      </p>

      {syllabi.map((s, i) => (
        <a className="card" key={s.id} href={`/syllabus/${s.id}`}>
          <h3>{s.form_level}</h3>
          <div className="meta">{s.title}</div>
          <div className="tags">
            <span className="tag">{counts[i].rows} rows</span>
            {counts[i].categories > 0 && (
              <span className="tag">
                {counts[i].categories} categories of action
              </span>
            )}
            {counts[i].modules > 0 && (
              <span className="tag">{counts[i].modules} modules</span>
            )}
            <span className="tag plain">
              {s.scope === "regional" ? `${s.region} regional` : "National"}
            </span>
            {s.coefficient && (
              <span className="tag plain">Coefficient {s.coefficient}</span>
            )}
          </div>
        </a>
      ))}
    </>
  );
}
