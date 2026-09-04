"use client";

import { useState } from "react";
import Link from "next/link";
import { createBrowserClient } from "@supabase/ssr";

export default function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const [busy, setBusy] = useState(false);

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!url || !key) {
    return (
      <div className="notice">
        <h3>Not configured yet</h3>
        <p>
          Add <code>NEXT_PUBLIC_SUPABASE_URL</code> and{" "}
          <code>NEXT_PUBLIC_SUPABASE_ANON_KEY</code> in Vercel, then redeploy.
        </p>
      </div>
    );
  }

  async function onSubmit(e) {
    e.preventDefault();
    setBusy(true);
    setError(null);
    const supabase = createBrowserClient(url, key);
    const { error } = await supabase.auth.signInWithPassword({
      email: email.trim(),
      password,
    });
    if (error) {
      setError(error.message);
      setBusy(false);
      return;
    }
    const next = new URLSearchParams(window.location.search).get("next");
    window.location.assign(next && next.startsWith("/") ? next : "/admin");
  }

  return (
    <>
      <h2>Teacher sign in</h2>
      <p className="lede">
        Only accounts created by the school administrator can sign in.
      </p>

      <form onSubmit={onSubmit} style={{ maxWidth: 380 }}>
        <label className="field">
          <span>Email</span>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            autoComplete="username"
            required
          />
        </label>
        <label className="field">
          <span>Password</span>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            autoComplete="current-password"
            required
          />
        </label>

        {error && (
          <div className="notice bad">
            <h3>Could not sign in</h3>
            <p>{error}</p>
          </div>
        )}

        <button className="primary" type="submit" disabled={busy}>
          {busy ? "Signing in…" : "Sign in"}
        </button>
      </form>

      {/* The progression sheet is closed now, so a student following an old
          link arrives here rather than at the sheet. Without this they would
          sit staring at a form they have no account for. */}
      <div className="notice" style={{ marginTop: 26 }}>
        <h3 style={{ marginTop: 0 }}>Are you a student?</h3>
        <p style={{ margin: 0 }}>
          This form is for teachers. Sign in with the code from your register
          at <Link className="link" href="/student/login">student sign-in</Link>.
        </p>
      </div>

      <p className="lede" style={{ marginTop: 22 }}>
        Forgot the password? There is no self-service reset yet. Reset it from
        the Supabase dashboard under Authentication, then Users.
      </p>
    </>
  );
}
