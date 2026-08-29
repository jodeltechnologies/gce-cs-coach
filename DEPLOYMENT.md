# Deployment

GitHub + Vercel + Supabase, as you asked. Roughly 40 minutes the first time.

Three services, three jobs:

| | What it does | Cost |
|---|---|---|
| **Supabase** | Holds the database — your curriculum, and later your students and marks | Free tier is enough |
| **GitHub** | Holds the code, and is what Vercel watches for changes | Free |
| **Vercel** | Runs the website | Free (Hobby) |

You do not need to understand the code. Follow the steps in order.

---

## Before you start

Create free accounts if you don't have them: **github.com**, **vercel.com**,
**supabase.com**. Sign into Vercel using your GitHub account — it makes step 3
much shorter.

---

## Step 1 — Supabase: create the database

1. Go to **supabase.com/dashboard** and click **New project**.
2. Fill in:
   - **Name**: `gce-cs-coach`
   - **Database Password**: generate one and **save it somewhere safe**. You
     cannot see it again, and you need it for the command-line loading option
     in Step 2.
   - **Region**: choose the one geographically closest to Cameroon — at the
     time of writing that is usually `West EU (London)` or `Central EU
     (Frankfurt)`. This matters. A database in Singapore will feel noticeably
     slow from Limbe on a weak connection.
3. Wait about two minutes while the project is created.

---

## Step 2 — Load the schema and the curriculum

In the Supabase dashboard, open **SQL Editor** in the left sidebar. You will run
five files, **in this exact order**. For each one: open the file from this
project, copy all of it, paste into a new query, click **Run**.

| Order | File | What it does |
|---|---|---|
| 1 | `db/schema.sql` | Creates the 27 tables |
| 2 | `db/rls.sql` | **Security. Do not skip this.** |
| 3 | `db/seed/01_form4_computer_science.sql` | Loads Form 4 |
| 4 | `db/seed/02_form5_computer_science.sql` | Loads Form 5 |
| 5 | `db/seed/03_lower_sixth_ict.sql` | Loads Lower Sixth ICT |

The three seed files are around 90 KB each. The web editor handles them, but it
may pause for a few seconds. If it complains about size, use the command-line
option below instead.

**Why `db/rls.sql` is not optional.** Supabase automatically publishes every
table as a web API. The key your website uses is visible to anyone who opens the
page in a browser. Without `rls.sql`, that means anyone on the internet could
read and change every row — including your students' names, phone numbers and
marks. `rls.sql` locks everything except the published Ministry curriculum,
which is public information anyway. Run it before you enter a single student.

### Checking it worked

Run this in the SQL Editor:

```sql
SELECT s.form_level,
       count(DISTINCT l.id)  AS rows_on_sheet,
       count(DISTINCT o.id)  AS objectives
FROM syllabi s
LEFT JOIN lessons    l ON l.syllabus_id = s.id
LEFT JOIN objectives o ON o.lesson_id   = l.id
GROUP BY s.form_level
ORDER BY s.form_level;
```

You should see:

| form_level | rows_on_sheet | objectives |
|---|---|---|
| Form 4 | 107 | 161 |
| Form 5 | 108 | 177 |
| Lower Sixth | 103 | 136 |

And this, to confirm the security is on. **Every row must say `true`:**

```sql
SELECT tablename, rowsecurity FROM pg_tables
WHERE schemaname = 'public' ORDER BY rowsecurity, tablename;
```

### Command-line alternative

If you have `psql` installed, this is faster and gives clearer errors. The
connection string is in Supabase under **Project Settings → Database →
Connection string → URI**.

```bash
psql "YOUR-CONNECTION-STRING" -f db/schema.sql
psql "YOUR-CONNECTION-STRING" -f db/rls.sql
psql "YOUR-CONNECTION-STRING" -f db/seed/01_form4_computer_science.sql
psql "YOUR-CONNECTION-STRING" -f db/seed/02_form5_computer_science.sql
psql "YOUR-CONNECTION-STRING" -f db/seed/03_lower_sixth_ict.sql
```

### Copy your two keys

Go to **Project Settings → API** and copy these. You need them in Step 3.

- **Project URL** — looks like `https://abcdefgh.supabase.co`
- **anon public** key — a long string starting `eyJ...`

There is a third key called **service_role**. Ignore it for now, and never put
it on a website or in GitHub. It bypasses all the security you just set up.

---

## Step 3 — GitHub: put the code online

Unzip this project, then from a terminal inside the folder:

```bash
git init
git add .
git commit -m "GCE Computer Science Coach - curriculum and schema"
```

Create a new **empty** repository on github.com (no README, no .gitignore — this
project already has them). Call it `gce-cs-coach`. Set it to **Private** if you
prefer. Then run the two lines GitHub shows you, which look like:

```bash
git remote add origin https://github.com/YOUR-USERNAME/gce-cs-coach.git
git branch -M main
git push -u origin main
```

**A `.gitignore` is already included**, so `node_modules` and any `.env.local`
file stay off GitHub. Keep it that way — a leaked key is the most common way
small projects get compromised.

---

## Step 4 — Vercel: publish the website

1. Go to **vercel.com/new**.
2. Find `gce-cs-coach` in the list and click **Import**.
3. Leave the framework as **Next.js**. Do not change the build settings.
4. Open **Environment Variables** and add both:

   | Name | Value |
   |---|---|
   | `NEXT_PUBLIC_SUPABASE_URL` | your Project URL from Step 2 |
   | `NEXT_PUBLIC_SUPABASE_ANON_KEY` | your anon public key from Step 2 |

5. Click **Deploy** and wait two or three minutes.

You get a live address like `gce-cs-coach.vercel.app`. Open it. You should see
your three progression sheets. Click one and the whole year appears, laid out by
term and week with every objective.

**If you forget the variables**, the site still deploys and tells you which ones
are missing rather than showing an error page. Add them under **Settings →
Environment Variables**, then **Deployments → ⋯ → Redeploy**.

---

## Two things that will bite you later

**Supabase pauses free projects after 7 days of no activity.** For a teacher this
is a real trap: you go on holiday, come back in September, and the site is dead.
It is not lost — you log into the Supabase dashboard and click **Restore**, and
it comes back with all your data. But know it in advance so you don't panic. If
the project becomes something you rely on daily, the paid tier removes this.

**Vercel redeploys automatically on every push to GitHub.** That is a feature:
correct a lesson title in the YAML, regenerate the SQL, push, and the site
updates itself. It also means a broken change goes live immediately. Vercel
keeps every previous deployment, so **Deployments → ⋯ → Promote to Production**
on an older one gets you back in about thirty seconds.

---

## Changing the curriculum later

The YAML files in `tools/curriculum/` are the source of truth, and they are
plain readable text. If a lesson title or objective is wrong:

1. Edit the YAML.
2. Check it: `python3 tools/load_curriculum.py --validate tools/curriculum/*.yaml`
3. Regenerate: `python3 tools/load_curriculum.py --emit-sql tools/curriculum/form5_computer_science.yaml > db/seed/02_form5_computer_science.sql`
4. In Supabase, delete the old rows and re-run the new file:
   ```sql
   DELETE FROM syllabi WHERE form_level = 'Form 5';
   ```
   The `ON DELETE CASCADE` in the schema removes that syllabus's modules,
   categories, lessons and objectives with it. Then run the regenerated file.
5. Commit and push. Vercel updates itself.

The loader **refuses to produce SQL if validation fails**, so a broken sheet
cannot reach the database.

---

## Local development

If you want to run it on your own laptop:

```bash
npm install
cp .env.local.example .env.local     # then paste your two keys into it
npm run dev
```

Open `http://localhost:3000`.

---

## Honest note on what has been tested

The database side is verified. The schema was checked for table-ordering
problems, all three curriculum files validate with zero errors, and the
generated SQL was checked statement by statement.

The website was **written but not built**, because the environment I worked in
had no internet access and therefore could not run `npm install`. If the first
Vercel build reports an error, send me the log and I'll fix it — the likely
candidates are a package version and a small syntax slip, both quick.
