/**
 * A small markdown renderer for note bodies.
 *
 * The notes only ever use six things: headings, paragraphs, bullets, images,
 * captions and inline emphasis. Pulling in a markdown library to handle a
 * subset that small would add a dependency, a bundle, and a sanitiser to think
 * about, for text this app generated itself and controls end to end.
 *
 * It deliberately does not render raw HTML. The bodies come from a PDF
 * extraction, so anything that looks like a tag is an accident of the source
 * and should appear as the characters it is.
 */

function inline(text, keyPrefix) {
  // *emphasis* and **strong**, nothing else
  const parts = [];
  const re = /(\*\*[^*]+\*\*|\*[^*]+\*)/g;
  let last = 0;
  let m;
  let n = 0;
  while ((m = re.exec(text)) !== null) {
    if (m.index > last) parts.push(text.slice(last, m.index));
    const body = m[0];
    if (body.startsWith("**")) {
      parts.push(<strong key={`${keyPrefix}-b${n++}`}>{body.slice(2, -2)}</strong>);
    } else {
      parts.push(<em key={`${keyPrefix}-i${n++}`}>{body.slice(1, -1)}</em>);
    }
    last = m.index + body.length;
  }
  if (last < text.length) parts.push(text.slice(last));
  return parts;
}

export default function NoteBody({ body }) {
  if (!body) return null;
  const blocks = body.split(/\n{2,}/);
  const out = [];
  let bullets = [];

  const flushBullets = (key) => {
    if (bullets.length === 0) return;
    out.push(
      <ul key={`ul-${key}`} style={{ margin: "0 0 16px", paddingLeft: 22 }}>
        {bullets.map((b, i) => (
          <li key={i} style={{ marginBottom: 6, lineHeight: 1.6 }}>
            {inline(b, `li-${key}-${i}`)}
          </li>
        ))}
      </ul>
    );
    bullets = [];
  };

  blocks.forEach((raw, i) => {
    const t = raw.trim();
    if (!t) return;

    const img = t.match(/^!\[(.*?)\]\((.*?)\)$/);
    if (img) {
      flushBullets(i);
      out.push(
        <figure key={i} style={{ margin: "18px 0", textAlign: "center" }}>
          {/* Plain img, not next/image: these are cropped straight out of the
              source pages at their own sizes and are never resized. */}
          <img
            src={img[2]}
            alt={img[1] || "Figure from the course notes"}
            style={{
              maxWidth: "100%",
              height: "auto",
              border: "1px solid var(--rule, #e5e2dc)",
              borderRadius: 6,
              background: "#fff",
            }}
          />
        </figure>
      );
      return;
    }

    if (t.startsWith("- ")) {
      bullets.push(t.slice(2));
      return;
    }
    flushBullets(i);

    const h = t.match(/^(#{1,6})\s+(.*)$/);
    if (h) {
      const level = Math.min(h[1].length, 6);
      const size = [1.5, 1.28, 1.12, 1.0, 0.95, 0.9][level - 1];
      const Tag = `h${Math.min(level + 1, 6)}`;
      out.push(
        <Tag
          key={i}
          style={{
            fontSize: `${size}rem`,
            margin: level <= 2 ? "28px 0 10px" : "22px 0 8px",
            lineHeight: 1.3,
          }}
        >
          {h[2]}
        </Tag>
      );
      return;
    }

    // a lone italic line following an image is its caption
    if (/^\*[^*]+\*$/.test(t)) {
      out.push(
        <p
          key={i}
          style={{
            textAlign: "center",
            fontSize: "0.84rem",
            color: "var(--muted)",
            margin: "-10px 0 18px",
          }}
        >
          {t.slice(1, -1)}
        </p>
      );
      return;
    }

    out.push(
      <p key={i} style={{ margin: "0 0 14px", lineHeight: 1.7 }}>
        {inline(t, `p-${i}`)}
      </p>
    );
  });
  flushBullets("end");

  return <div style={{ maxWidth: "68ch" }}>{out}</div>;
}
