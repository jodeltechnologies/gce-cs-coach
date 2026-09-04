# Three fixes

Two bugs you found, and the sheet closed.

**Upload the whole download to GitHub, then run the two SQL files in order,
`phase14.sql` before `phase15.sql`.** Both go after `phase13.sql`.

---

## 1. Messages never reached you

`phase13.sql` turned row level security on for `messages`,
`self_check_attempts` and `note_releases`, and then wrote no policies for
them. My comment said the anon key would reach none of those tables, which was
true and was the point. What it missed is that **your own session obeys the
same policies**. With none written, you could read nothing and write nothing
either.

So a student pressing Send really did insert a row, through a function that
runs as its owner and steps past the policies. Your inbox then looked in the
same table by the ordinary path and was told there was nothing there. No error
on either side. The message existed and was unreachable.

The same fault broke releasing notes, since that page writes to
`note_releases` directly.

**Nothing was lost.** Every message already sent appears the moment
`phase14.sql` runs.

## 2. Notes stayed visible

I had only held back the two sources written for 2026/2027. Every older source
stayed open, so those chapters carried on showing.

**Any source can now be held back**, and the choice is yours. Each card on
Release notes says how much the class can currently see, with a red line on
anything still open. Release all and Take all back save ticking forty boxes.

## 3. The progression sheet was open to anybody

You are right, and it was open in two separate ways. Closing one without the
other would have looked like a fix without being one.

**The routes were open.** Signing out left `/`, `/syllabus` and `/lesson`
serving the whole year to whoever asked.

**The data was open, which is the part that mattered.** Every curriculum table
carried a policy reading `FOR SELECT USING (true)`, meaning anybody at all,
signed in or not. The anon key sits in the page source of every visit, so the
sheet could be read straight from the API whatever the pages did. Hiding a
link does not close a door.

Both are shut now. There are three layers, and each is there because the
others can fail:

| | |
|---|---|
| `middleware.js` | Turns the request away at the door |
| `lib/guards.js` | The page checks again, so a route the matcher forgets is still closed |
| `phase15.sql` | The database refuses. This is the only real protection |

**Students are unaffected.** Everything they see comes through functions that
run as their owner and never consult these policies. I checked that function
by function before writing the file rather than assuming it.

Where people now go:

| Who | Asking for | Goes to |
|---|---|---|
| Nobody | the sheet or admin | teacher sign-in |
| Student | the sheet | their own progress page |
| Student | admin | their own dashboard |
| Teacher | anything | through |

A student following an old link to the sheet lands on the teacher sign-in, so
that page now carries a line pointing them at student sign-in. Without it they
would sit staring at a form they have no account for.

---

## Running it

### GitHub

Upload the `app`, `lib` and `db` folders, plus **`middleware.js`, which sits
at the top level of the repository, not inside a folder**. Wait for Vercel to
say Ready.

### Supabase, in order

**`phase14.sql` first.** It prints six rows. The first must say **true**. If
it says false you are running the editor as a different account from the one
the app uses, and the counts below it will mislead you.

**`phase15.sql` second.** It prints two tables.

- The first is what you can read signed in. Every count should be above zero.
- The second is what an anonymous request can read. **All four must be zero.**
  That is the check that proves the sheet is shut.

If the second table is not all zeros, stop and send it to me.

---

## Then check it in the app

**Signed out, in a private window**, try the site address. You should land on
sign-in, not on the sheet. Try `/syllabus/` followed by any id you have seen
before. Same thing.

**As a student**, the site address should take you to your own progress page,
not the sheet.

**As yourself**, everything as before.

**Admin, Messages.** Anything a student sent earlier is there now.

**Admin, Release notes.** Hold back a source, then check as a student that it
has gone from Notes. That is the check worth doing twice, since it is the one
that was broken.

---

## Still outstanding

- The after-school Lower Sixth times, whenever you have them.
- The Cameroon law citations in Lower Sixth lessons 36 and 37.
- Terms 2 and 3 of the notes.
