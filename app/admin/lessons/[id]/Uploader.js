"use client";

import { useState } from "react";
import { createBrowserClient } from "@supabase/ssr";
import { attachResource } from "../actions";

const KIND_BY_EXT = {
  pdf: "pdf",
  png: "image",
  jpg: "image",
  jpeg: "image",
  gif: "image",
  webp: "image",
  mp3: "audio",
  m4a: "audio",
  wav: "audio",
  mp4: "video",
  webm: "video",
};

function humanSize(bytes) {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${Math.round(bytes / 1024)} KB`;
  return `${(bytes / 1024 / 1024).toFixed(1)} MB`;
}

/**
 * Uploads directly from the browser to Supabase Storage.
 *
 * Deliberately not a server action: Vercel caps a request body at roughly
 * 4.5 MB, and a scanned chapter of notes goes past that easily. Going
 * straight to Supabase also means the file makes one network trip instead of
 * two, which matters on a connection that drops.
 */
export default function Uploader({ lessonId }) {
  const [status, setStatus] = useState(null);
  const [busy, setBusy] = useState(false);
  const [caption, setCaption] = useState("");

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  async function onPick(e) {
    const file = e.target.files?.[0];
    if (!file) return;

    setBusy(true);
    setStatus(`Uploading ${file.name} (${humanSize(file.size)})…`);

    try {
      const supabase = createBrowserClient(url, key);
      const ext = (file.name.split(".").pop() ?? "").toLowerCase();
      const safe = file.name.replace(/[^a-zA-Z0-9._-]/g, "_");
      const path = `${lessonId}/${Date.now()}-${safe}`;

      const { error } = await supabase.storage
        .from("resources")
        .upload(path, file, { cacheControl: "3600", upsert: false });

      if (error) {
        setStatus(`Upload failed: ${error.message}`);
        setBusy(false);
        return;
      }

      const {
        data: { publicUrl },
      } = supabase.storage.from("resources").getPublicUrl(path);

      const fd = new FormData();
      fd.set("lesson_id", lessonId);
      fd.set("url", publicUrl);
      fd.set("caption", caption || file.name);
      fd.set("kind", KIND_BY_EXT[ext] ?? "link");
      fd.set("size_bytes", String(file.size));
      await attachResource(fd);

      setStatus(`Attached ${file.name}.`);
      setCaption("");
      e.target.value = "";
    } catch (err) {
      setStatus(`Upload failed: ${err?.message ?? "unknown error"}`);
    }
    setBusy(false);
  }

  if (!url || !key) return null;

  return (
    <div style={{ marginTop: 10 }}>
      <label className="field">
        <span>Caption (optional)</span>
        <input
          type="text"
          value={caption}
          onChange={(e) => setCaption(e.target.value)}
          placeholder="Chapter 7 handout"
        />
      </label>

      <input
        type="file"
        onChange={onPick}
        disabled={busy}
        accept=".pdf,.png,.jpg,.jpeg,.gif,.webp,.mp3,.m4a,.wav,.mp4,.webm"
        style={{ fontSize: "0.9rem" }}
      />

      {status && (
        <p style={{ fontSize: "0.84rem", color: "var(--muted)", marginTop: 8 }}>
          {status}
        </p>
      )}

      <p style={{ fontSize: "0.78rem", color: "var(--muted)", marginTop: 8 }}>
        Files under 500 KB are cached on students&apos; phones automatically.
        Anything larger asks them first — data costs money.
      </p>
    </div>
  );
}
