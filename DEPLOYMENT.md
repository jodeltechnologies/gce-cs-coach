# Deployment

GCE Computer Science Coach — Government High School (Lycée) de Mbonjo, Limbe.

GitHub + Vercel + Supabase. About 45 minutes the first time.

Three services, three jobs:

| | What it does | Cost |
|---|---|---|
| **Supabase** | The database — your curriculum now, students and marks later | Free tier is enough |
| **GitHub** | Holds the code; Vercel watches it for changes | Free |
| **Vercel** | Runs the website | Free (Hobby) |

You do not need to understand the code. Follow the steps in order. Where a step
matters more than it looks, I say why.

---

## Before you start

Create free accounts at **github.com**, **vercel.com** and **supabase.com**.
Sign into Vercel *using your GitHub account* — it makes Step 5 much shorter.

Unzip `gce-cs-coach.zip` somewhere you can find it. Everything below refers to
files inside that folder.

---

## Step 1 — Supabase: create the database

1. Go to **supabase.com/dashboard** → **New project**.
2. Fill in:
   - **Name**: `gce-cs-coach`
   - **Database Password**: generate one and **save it somewhere safe now**.
     You cannot see it again, and you need it for the command-line option in
     Step 2.
   - **Region**: pick the one geographically closest to Cameroon — usually
     `West EU (London)` or `Central EU (Frankfurt)`.

**The region choice is permanent and it matters.** A database in Singapore will
feel noticeably slow from Limbe on a weak connection, and moving it later means
rebuilding the project. Choose carefully once.

Wait about two minutes while the project is created.

---

## Step 2 — Load the schema and the curriculum

Open **SQL Editor** in the left sidebar. You will run six files **in this exact
order**. For each: open the file from the project folder, copy all of it, paste
into a new query, click **Run**.

| Order | File | What it does |
|---|---|---|
| 1 | `db/schema.sql` | Creates the 27 tables |
| 2 | `db/rls.sql` | **Security. Do not skip this.** |
| 3 | `db/auth.sql` | Teacher login and write access |
| 4 | `db/seed/01_form4_computer_science.sql` | Form 4 — 107 rows, 161 objectives |
| 5 | `db/seed/02_form5_computer_science.sql` | Form 5 — 108 rows, 177 objectives |
| 6 | `db/seed/03_lower_sixth_ict.sql` | Lower Sixth ICT — 103 rows, 136 content points |
| 7 | `db/phase2.sql` | Repairs cross-year links; opens up classes and the planner |
| 8 | `db/phase3.sql` | Lesson editing, file uploads, question bank |
| 9 | `db/phase4.sql` | Indexes for the student roll and question bank |
| 10 | `db/phase5.sql` | Provenance and review columns for imported questions |
| 11 | `db/seed/04_past_questions.sql` | 522 past-paper questions — **must come after phase5** |
| 12 | `db/seed/05_notes.sql` | The eight chapters of course notes |
| 13 | `db/seed/06_tags.sql` | Links questions and note chapters to lessons |
| 14 | `db/phase6.sql` | Student sign-in, and the functions students read through |
| 15 | `db/phase7.sql` | Per-option feedback and structured question parts |
| 16 | `db/seed/07_authored_questions.sql` | 80 authored questions — **after phase7** |
| 17 | `db/phase8.sql` | Recording practice, weak topics, mastery |
| 18 | `db/phase9.sql` | Letting students choose topic, length and timer |

**Form 4 must load before Form 5.** Form 5's file links its categories of action
back to Form 4's by name, so running them out of order leaves those links empty.

The three curriculum seed files are around 90 KB each and the question seed is
around 280 KB. The web editor handles them but may pause for a few seconds. If
it complains about size, use the command-line option below.

`04_past_questions.sql` refuses to run if phase5 has not been applied, rather
than failing halfway through and leaving a half-loaded bank behind. When it
finishes it prints how many questions arrived and how many are waiting to be
checked; roughly 400 of the 522 will be, which is expected. Work through them at
**/admin/questions/review**. Until a question is checked it will not mark a
student, so nothing is at risk from loading them all at once.

### Why `db/rls.sql` is not optional

Supabase automatically publishes every table as a web API. The key your website
uses is embedded in the page, so anyone who opens your site in a browser can
read it and call that API directly.

Without `rls.sql`, that means **anyone on the internet can read and change every
row you have** — including your students' names, phone numbers and marks.

`rls.sql` locks everything except the published Ministry curriculum, which is
public information anyway. Run it before you enter a single student.

### Check it worked

```sql
SELECT s.form_level,
       count(DISTINCT l.id) AS rows_on_sheet,
       count(DISTINCT o.id) AS objectives
FROM syllabi s
LEFT JOIN lessons    l ON l.syllabus_id = s.id
LEFT JOIN objectives o ON o.lesson_id   = l.id
GROUP BY s.form_level
ORDER BY s.form_level;
```

Expected:

| form_level | rows_on_sheet | objectives |
|---|---|---|
| Form 4 | 107 | 161 |
| Form 5 | 108 | 177 |
| Lower Sixth | 103 | 136 |

Then confirm the cross-year links landed. This should return **6 rows**:

```sql
SELECT c.category_of_action AS form5,
       p.category_of_action AS continues_from,
       c.link_confirmed
FROM competencies c
JOIN competencies p ON p.id = c.continues_from_id;
```

And confirm the security is on. **Every row must say `true`:**

```sql
SELECT tablename, rowsecurity FROM pg_tables
WHERE schemaname = 'public' ORDER BY rowsecurity, tablename;
```

If any row says `false`, `rls.sql` did not run and that table is readable by
anyone on the internet. Stop and fix that before continuing.

### Command-line alternative

Faster, with clearer errors. The connection string is under **Project Settings →
Database → Connection string → URI**.

```bash
psql "YOUR-CONNECTION-STRING" -f db/schema.sql
psql "YOUR-CONNECTION-STRING" -f db/rls.sql
psql "YOUR-CONNECTION-STRING" -f db/auth.sql
psql "YOUR-CONNECTION-STRING" -f db/seed/01_form4_computer_science.sql
psql "YOUR-CONNECTION-STRING" -f db/seed/02_form5_computer_science.sql
psql "YOUR-CONNECTION-STRING" -f db/seed/03_lower_sixth_ict.sql
```

### Copy your two keys

**Project Settings → API**. Copy these — you need them in Step 5.

- **Project URL** — like `https://abcdefgh.supabase.co`
- **anon public key** — a long string. Newer Supabase projects may label this
  the **publishable key**; either is the right one.

There is a third key called **service_role** (or **secret**). Ignore it. Never
put it on a website or in GitHub — it bypasses every security policy you just
set up.

---

## Step 3 — Create your teacher account

The public pages need no login. The admin area does.

### 3a. Close the door first

**Authentication → Sign In / Providers → turn OFF "Allow new users to sign up".**

Do this before creating your own account. Left on, anyone on the internet can
register on your school system. The policies in `auth.sql` would still stop them
writing anything, but there is no reason to let strangers create accounts at all.

### 3b. Create the login

**Authentication → Users → Add user → Create new user.**

Use your real email and a strong password. Tick **Auto Confirm User** so you can
sign in immediately without a confirmation email.

### 3c. Link it to a teacher record

Back in the **SQL Editor**, with your own details:

```sql
INSERT INTO teachers (full_name, email, password_hash, grade, auth_user_id)
SELECT 'YOUR FULL NAME',
       'you@example.com',
       'managed-by-supabase-auth',
       'YOUR GRADE',
       id
FROM auth.users
WHERE email = 'you@example.com';
```

Check it linked. This must return **exactly one row**:

```sql
SELECT t.full_name, u.email
FROM teachers t JOIN auth.users u ON u.id = t.auth_user_id;
```

**Creating the login alone is not enough.** Signing in without that `teachers`
row lets you reach the admin area, but the database refuses every save. That is
the security working correctly. The admin page detects it and tells you plainly
rather than letting saves fail in silence.

`password_hash` holds a placeholder on purpose. Supabase Auth keeps the real
password; this system never sees or stores it. The column stays in the schema
for the student login codes, which work differently.

---

## Step 4 — GitHub: put the code online

From a terminal inside the project folder:

```bash
git init
git add .
git commit -m "GCE Computer Science Coach - curriculum, schema and admin"
```

Create a new **empty** repository on github.com — no README, no .gitignore, this
project already has them. Call it `gce-cs-coach`. **Private** is a sensible
choice. Then run the two lines GitHub shows you:

```bash
git remote add origin https://github.com/YOUR-USERNAME/gce-cs-coach.git
git branch -M main
git push -u origin main
```

A `.gitignore` is already included, so `node_modules` and any `.env.local` stay
off GitHub. Keep it that way — a leaked key is the most common way small
projects get compromised.

---

## Step 5 — Vercel: publish the website

1. Go to **vercel.com/new**.
2. Find `gce-cs-coach` and click **Import**.
3. Leave the framework as **Next.js**. Change nothing in the build settings.
4. Open **Environment Variables** and add both:

   | Name | Value |
   |---|---|
   | `NEXT_PUBLIC_SUPABASE_URL` | your Project URL from Step 2 |
   | `NEXT_PUBLIC_SUPABASE_ANON_KEY` | your anon public / publishable key |

5. Click **Deploy**. Two or three minutes.

You get an address like `gce-cs-coach.vercel.app`. Open it and you should see
your three progression sheets. Click one: the whole year, by term and week, with
every objective in place.

If you forget the variables, the site still deploys and tells you which ones are
missing rather than showing an error page. Add them under **Settings →
Environment Variables**, then **Deployments → ⋯ → Redeploy**.

---

## Step 6 — First things to do once it is live

1. Go to `/admin` and sign in with the account from Step 3.
2. Open **Classes** and create your Form 5 class. Then use the term planner:
   mark lessons taught and record the week you actually taught them. Two or
   three entries and it starts telling you how far behind the sheet you are.
3. Open **Exam frequency**. Fill in Form 5's 23 categories first — that is the
   class sitting the GCE. Rough is fine; you can change it any time.
4. Open **Cross-year links** and decide the six proposals. If it says
   *"None loaded — run db/phase2.sql"*, that file has not been run yet.

Exam frequency is the single field that turns this from a record of the syllabus
into something that can tell a weak student what to revise first. Nothing else
in the system can supply it.

---

## Adding the MINESEC emblem

The school crest is included. The MINESEC coat of arms is not — it is a
government emblem and I will not guess at or redraw an official seal.

Save the official file as **`public/minesec.png`**, then:

```bash
git add public/minesec.png
git commit -m "Add MINESEC emblem"
git push
```

Vercel redeploys itself and the emblem appears in the masthead, left of the
ministry line. Until then the header leaves the space out rather than showing a
broken image.

---

## Two things that will bite you later

**Supabase pauses free projects after 7 days with no activity.** For a teacher
this is a real trap: you go away for the holidays, come back in September, and
the site looks dead. Nothing is lost — log into the Supabase dashboard and click
**Restore**, and everything comes back. But know it in advance so you don't
panic. If this becomes something you rely on daily, the paid tier removes it.

**Vercel redeploys on every push to GitHub.** That is mostly a feature: correct a
lesson title, push, and the site updates itself. It also means a mistake goes
live immediately. Vercel keeps every previous deployment, so **Deployments → ⋯ →
Promote to Production** on an older one gets you back in about thirty seconds.

---

## Changing the curriculum later

The YAML files in `tools/curriculum/` are the source of truth and are plain
readable text. If a lesson title or objective is wrong:

1. Edit the YAML.
2. Check it:
   ```bash
   python3 tools/load_curriculum.py --validate tools/curriculum/*.yaml
   ```
3. Regenerate:
   ```bash
   python3 tools/load_curriculum.py --emit-sql \
     tools/curriculum/form5_computer_science.yaml \
     > db/seed/02_form5_computer_science.sql
   ```
4. In Supabase, remove the old rows and run the new file:
   ```sql
   DELETE FROM syllabi WHERE form_level = 'Form 5';
   ```
   `ON DELETE CASCADE` takes that syllabus's modules, categories, lessons and
   objectives with it.
5. Commit and push.

**One warning about step 4.** Deleting a syllabus also deletes any exam
frequencies and confirmed links you have entered for it, because they live on
the category rows. Save them first:

```sql
SELECT category_of_action, exam_frequency, link_confirmed
FROM competencies c
JOIN syllabi s ON s.id = c.syllabus_id
WHERE s.form_level = 'Form 5' AND (exam_frequency IS NOT NULL OR link_confirmed);
```

The loader **refuses to emit SQL if validation fails**, so a broken sheet can
never reach the database.

---

## Local development

Node 20 or newer.

```bash
npm install
cp .env.local.example .env.local     # paste your two keys into it
npm run dev
```

Open `http://localhost:3000`.

---

## If something is wrong

**Site loads but says "two settings missing"** — the Vercel environment
variables are absent or misspelled. Check for a trailing space in the pasted key.

**"Connected, but the query failed"** — `schema.sql` or `rls.sql` has not run.
Go back to Step 2.

**"Database is empty"** — the tables exist but no seed file ran. Step 2, files 4
to 6.

**"Account not linked"** — you signed in but have no `teachers` row. Step 3c.

**Signed in, but saves do nothing** — same cause. The database is refusing the
write because Row Level Security cannot find you in `teachers`.

**Build fails on Vercel** — send me the log. The website was written but never
built, because the environment I worked in has no internet access and so cannot
run `npm install`. The database side is verified: table ordering checked, all
three curriculum files validating with zero errors, generated SQL checked
statement by statement. But the front end is untested, and I would rather say so
than let you find out at the wrong moment. Likely candidates are a package
version and a small syntax slip, both quick to fix.


---

## Letting students in

Students do not use Supabase auth. Most have no email address, so sign up,
confirm by email and reset by email have nothing to send anything to. They sign
in at **/student/login** with the code printed on the register, and choose a PIN
the first time.

`phase6.sql` ends by hashing a test PIN. If pgcrypto is not reachable it stops
there with a message telling you to enable the extension, rather than letting
the first student to try signing in meet an error about `gen_salt`.

**Set one environment variable before this works.** In Vercel, add:

```
STUDENT_SESSION_SECRET = <a random string of at least 24 characters>
```

The session cookie is signed with it. Without a signature the cookie is just a
student id in a text file, and any student could type another one and read
their classmate's marks. The app refuses to start a session rather than sign
with a default, because a predictable secret is the same as no secret and the
failure would be silent.

To generate one:

```bash
openssl rand -base64 32
```

### Getting a class onto the roll

**Admin, Students, "Import a class list from Excel."** Takes an .xlsx or .csv
file, or a column of names pasted straight out of Excel. Columns headed Name,
Matricule, Sex, Date of birth, Guardian or Phone are picked up automatically,
and a list with no headings at all is read as names.

It reports every name: those added with their login code, and those skipped
with the reason. Running it twice is safe — a student already on the roll is
skipped rather than duplicated.

The old binary `.xls` cannot be read. Save as `.xlsx` first.

### What a student can reach

- **/student** — their name, class, and the two things below
- **/student/notes** — every chapter with its diagrams
- **/student/practice** — ten past questions at a time, marked one by one

Practice only offers questions a teacher has already checked. An unreviewed
question may have been misread by OCR or have no printed answer, and telling a
student they are wrong on that basis is worse than not asking.

### Why the answers are not in the page

The question is sent to the browser without its correct option. Marking happens
in the database after the student chooses. Anything sent to a browser can be
read by the person holding it, and a practice test whose answers sit in the page
source is not practice.

### If a student forgets their PIN

The teacher clears it with "Reset their PIN" on the student's page, and the student sets a new one on
their next sign-in. There is no email reset, because there is no email. Five
wrong PINs pause that code for fifteen minutes, so a code found on a desk cannot
be guessed at four digits.
