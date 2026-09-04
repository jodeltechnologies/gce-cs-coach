# Two fixes

Both faults were mine, and both were the same kind of mistake in different
places. Something was switched on for safety and then never given permission
to work.

---

## 1. Messages never reached you

`phase13.sql` turned row level security on for `messages`,
`self_check_attempts` and `note_releases`, and then wrote no policies for
them. My comment said the anon key would reach none of those tables, which was
true and was the point.

What it missed is that **your own session is subject to the same policies**.
With none written, you could read nothing and write nothing either.

So a student pressing Send really did insert a row. That goes through a
function which runs as its owner and steps past the policies. Your inbox then
looked in the same table through the ordinary path and was told there was
nothing there. No error on either side. The message existed and was
unreachable.

The same fault broke releasing notes, because that page reads and writes
`note_releases` directly.

**Nothing was lost.** Every message a student sent is sitting in the table and
will appear the moment this is loaded.

## 2. Notes stayed visible

I only held back the two sources written for 2026/2027. Every older source
kept its release mode as open, so those chapters carried on showing. That is
what you were seeing on the student Notes screen.

That was deliberate, so a class would not have notes pulled away mid-term. But
it was the wrong call to make on your behalf. **Any source can now be held
back**, and the choice is yours.

---

## What to do

### Step 1, GitHub

Four files. Upload the `app` and `db` folders from this download.

| File | |
|---|---|
| `db/phase14.sql` | New |
| `app/admin/release/page.js` | Replaces |
| `app/admin/release/actions.js` | Replaces |
| `app/globals.css` | Replaces |

Wait for Vercel to say Ready.

### Step 2, Supabase

Paste `db/phase14.sql` whole and run it. It must go after `phase13.sql`.

It prints six rows at the end. **The first must say true.** If it says false,
you are running the SQL editor as a different account from the one the app
signs in with, and the counts below it will be wrong. The fix is to check in
the app rather than in the editor.

The other rows tell you how many messages, self checks and releases you can
now see. If messages had been sent before today, that count will not be zero.

---

## Then check it

**Admin, Messages.** Anything a student has already sent should be there now.

**Admin, Release notes.** One card for each source, with how many chapters the
class can currently see.

- A source marked **open** shows a red line saying the class sees all of it.
- **Hold back** switches it off. The class immediately sees none of it.
- **Choose chapters** opens the tick list. **Release all** and **Take all
  back** save you ticking forty boxes.

**As a student.** Sign in and open Notes. A source you have held back should
show only the chapters you released, and a source you have released nothing
from should not appear at all.

That last one is the check worth doing twice, since it is the one that was
broken.

---

## A note on how it is fixed

The teacher policies lean on two helpers, `is_my_class` and `is_my_student`.
Both run as their owner rather than as the caller.

That matters more than it looks. A policy that has to read another table in
order to decide is itself subject to *that* table's policies. Written the
obvious way, the check reads nothing, concludes nothing, and refuses every
row, which is precisely how the first version failed. Running the lookup as
the owner is what stops the check quietly answering no to everything.

Releasing notes also no longer writes to the table from the page. It calls a
function that raises an error when the class is not yours. The old code wrote
directly, was refused by the very policies that did not exist, and reported
success anyway. A refusal that says so is worth more than a save that lies.

Students still never touch any of these tables. Everything they do goes
through a function that takes their id from a signed cookie the server checked
first.
