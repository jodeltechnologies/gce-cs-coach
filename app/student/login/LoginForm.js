"use client";

import { useActionState } from "react";
import { signIn, setPin } from "../actions";

/**
 * One form with two states: signing in, and choosing a PIN the first time.
 *
 * Kept as one screen rather than two routes because a student on a borrowed
 * phone should not have to follow a redirect and find their place again. The
 * server decides which state applies; the client only renders it.
 */
export default function LoginForm() {
  const [state, action, pending] = useActionState(signIn, {});
  const [pinState, pinAction, pinPending] = useActionState(setPin, {});

  const choosing = state?.needsPin || pinState?.needsPin;
  const code = pinState?.code ?? state?.code ?? "";
  const error = pinState?.error ?? state?.error;

  if (choosing) {
    return (
      <form action={pinAction}>
        {error && (
          <div className="notice bad" style={{ marginBottom: 14 }}>
            <p style={{ margin: 0 }}>{error}</p>
          </div>
        )}
        <p>
          {state?.name ? `Welcome, ${state.name}. ` : ""}
          Choose a PIN of 4 to 6 digits. You will need it every time, so pick
          something you will remember and do not tell anyone.
        </p>
        <input type="hidden" name="code" value={code} />
        <label className="field">
          <span>New PIN</span>
          <input
            type="password" name="pin" inputMode="numeric"
            autoComplete="new-password" required minLength={4} maxLength={6}
          />
        </label>
        <label className="field">
          <span>Type it again</span>
          <input
            type="password" name="pin_again" inputMode="numeric"
            autoComplete="new-password" required minLength={4} maxLength={6}
          />
        </label>
        <button className="primary" type="submit" disabled={pinPending}>
          {pinPending ? "Saving…" : "Save my PIN"}
        </button>
      </form>
    );
  }

  return (
    <form action={action}>
      {error && (
        <div className="notice bad" style={{ marginBottom: 14 }}>
          <p style={{ margin: 0 }}>{error}</p>
        </div>
      )}
      <label className="field">
        <span>Your code</span>
        <input
          type="text" name="code" required placeholder="MBJ-XXXXXX"
          autoCapitalize="characters" autoCorrect="off" spellCheck="false"
          style={{ fontFamily: "ui-monospace, monospace", letterSpacing: "0.05em" }}
        />
      </label>
      <label className="field">
        <span>PIN</span>
        <input
          type="password" name="pin" inputMode="numeric"
          autoComplete="current-password"
          placeholder="Leave empty the first time"
        />
      </label>
      <button className="primary" type="submit" disabled={pending}>
        {pending ? "Checking…" : "Sign in"}
      </button>
    </form>
  );
}
