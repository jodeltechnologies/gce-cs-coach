"use client";

import { useState } from "react";
import { createBrowserClient } from "@supabase/ssr";
import { attachResource } from "../actions";

const KIND_BY_EXT = {
  pdf: "pdf", png: "image", jpg: "image", jpeg: "image", gif: "image",
  webp: "image", mp3: "audio", m4a: "audio", wav: "audio",
  mp4: "video", webm: "video",
};

function humanSize(b) {
  if (b < 1024) return `${b} B`;
  if (b < 1024 * 1024) return `${Math.round(b / 1024)} KB`;
  return `${(b / 1024 / 1024).toFixed(1)} MB`;
}

/**
 * Pull the text out of a PDF, in the browser.
 *
 * pdfjs is loaded only when a PDF is actually chosen, so the extra weight
 * never reaches anyone who is not uploading one.
 *
 * A caution worth understanding: this reads text that is genuinely stored in
 * the file. A PDF made by photographing or scanning pages contains pictures
 * of words, not words, and will come back empty. That is not a fault in the
 * extraction — the text simply is not in the file. For those you still have
 * the PDF as an attachment, and you type the notes yourself.
 */
async function extractPdfText(file, onProgress) {
  const pdfjs = await import("pdfjs-dist");
  pdfjs.GlobalWorkerOptions.workerSrc = new URL(
    "pdfjs-dist/build/pdf.worker.min.mjs",
    import.meta.url
  ).toString();

  const buf = await file.arrayBuffer();
  const doc = await pdfjs.getDocument({ data: buf }).promise;
  const pages = [];

  for (let n = 1; n <= doc.numPages; n++) {
    onProgress?.(`Reading page ${n} of ${doc.numPages}…`);
    const page = await doc.getPage(n);
    const content = await page.getTextContent();

    // Rebuild lines by y position. Without this every word arrives as its own
    // fragment and the result is one endless paragraph.
    const lines = new Map();
    for (const item of content.items) {
      if (!item.str) continue;
      const y = Math.round(item.transform[5]);
      if (!lines.has(y)) lines.set(y, []);
      lines.get(y).push(item.str);
    }
    const ordered = [...lines.entries()]
      .sort((a, b) => b[0] - a[0])
      .map(([, parts]) => parts.join(" ").replace(/\s+/g, " ").trim())
      .filter(Boolean);

    pages.push(ordered.join("\n"));
  }

  return pages.join("\n\n");
}

export default function Uploader({ lessonId }) {
  const [status, setStatus] = useState(null);
  const [busy, setBusy] = useState(false);
  const [caption, setCaption] = useState("");
  const [extracted, setExtracted] = useState(null);

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  async function onPick(e) {
    const file = e.target.files?.[0];
    if (!file) return;

    setBusy(true);
    setExtracted(null);
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

      const { data: { publicUrl } } = supabase.storage
        .from("resources")
        .getPublicUrl(path);

      const fd = new FormData();
      fd.set("lesson_id", lessonId);
      fd.set("url", publicUrl);
      fd.set("caption", caption || file.name);
      fd.set("kind", KIND_BY_EXT[ext] ?? "link");
      fd.set("size_bytes", String(file.size));
      await attachResource(fd);

      setStatus(`Attached ${file.name}.`);
      setCaption("");

      if (ext === "pdf") {
        setStatus("Attached. Reading the text out of the PDF…");
        try {
          const text = await extractPdfText(file, setStatus);
          if (text.trim().length < 40) {
            setStatus(
              "Attached. No text found inside this PDF — it is most likely a scan, which stores pictures of words rather than words. The file is still attached; type the notes yourself."
            );
          } else {
            setExtracted(text);
            setStatus(
              `Attached, and pulled out about ${text.split(/\s+/).length} words. Check it below, then copy it into the notes.`
            );
          }
        } catch (err) {
          setStatus(
            `Attached, but could not read the text: ${err?.message ?? "unknown error"}`
          );
        }
      }

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
        <p style={{ fontSize: "0.86rem", color: "var(--muted)", marginTop: 10 }}>
          {status}
        </p>
      )}

      {extracted && (
        <div style={{ marginTop: 14 }}>
          <p style={{ fontSize: "0.84rem", color: "var(--muted)" }}>
            Extracted text. PDFs rarely convert perfectly — check the headings
            and any tables before you publish it.
          </p>
          <textarea
            readOnly
            value={extracted}
            style={{
              width: "100%",
              minHeight: 220,
              padding: "10px 12px",
              fontFamily: "var(--font-reading), Georgia, serif",
              fontSize: "0.92rem",
              lineHeight: 1.6,
              color: "var(--ink)",
              background: "var(--surface)",
              border: "1px solid var(--line)",
              borderRadius: 8,
            }}
          />
          <button
            type="button"
            className="primary"
            style={{ marginTop: 8 }}
            onClick={() => {
              const box = document.querySelector('textarea[name="content"]');
              if (box) {
                box.value = box.value ? box.value + "\n\n" + extracted : extracted;
                box.focus();
                setStatus("Copied into Notes for students. Now press Save lesson.");
              }
            }}
          >
            Copy into student notes
          </button>
        </div>
      )}

      <p style={{ fontSize: "0.78rem", color: "var(--muted)", marginTop: 10 }}>
        Files under 500 KB are cached on students&apos; phones automatically.
        Anything larger asks them first — data costs money.
      </p>
    </div>
  );
}
