/**
 * Renders a note chapter.
 *
 * Two kinds of body arrive here. The written lesson notes are HTML the teacher
 * authored — headings, definition boxes, lists — and are rendered as they are.
 * The chapters lifted out of the PDF booklets are markdown, because that is
 * what the extractor could produce, and they carry the figures.
 *
 * The markdown path used to depend on blank lines to find its blocks, which
 * failed the moment a body arrived with single newlines: the whole chapter
 * became one paragraph with "####" sitting in the middle of the prose. It now
 * reads line by line and decides what each one is, so a heading is a heading
 * however the surrounding whitespace happens to be arranged.
 */

function inline(text, keyPrefix) {
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

function renderMarkdown(body) {
  const lines = body.split("\n");
  const out = [];
  let para = [];
  let bullets = [];
  let key = 0;

  const flushPara = () => {
    if (para.length === 0) return;
    const text = para.join(" ").trim();
    para = [];
    if (text) {
      out.push(
        <p key={`p${key++}`} style={{ margin: "0 0 14px", lineHeight: 1.75 }}>
          {inline(text, `p${key}`)}
        </p>
      );
    }
  };

  const flushBullets = () => {
    if (bullets.length === 0) return;
    const items = bullets;
    bullets = [];
    out.push(
      <ul key={`u${key++}`} style={{ margin: "0 0 16px", paddingLeft: 22 }}>
        {items.map((b, i) => (
          <li key={i} style={{ marginBottom: 6, lineHeight: 1.65 }}>
            {inline(b, `li${key}-${i}`)}
          </li>
        ))}
      </ul>
    );
  };

  const flushAll = () => {
    flushPara();
    flushBullets();
  };

  for (const raw of lines) {
    const t = raw.trim();

    if (!t) {
      flushPara();
      continue;
    }

    const img = t.match(/^!\[(.*?)\]\((.*?)\)\s*$/);
    if (img) {
      flushAll();
      out.push(
        <figure key={`f${key++}`} style={{ margin: "20px 0", textAlign: "center" }}>
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
      continue;
    }

    const h = t.match(/^(#{1,6})\s+(.*)$/);
    if (h) {
      flushAll();
      const level = Math.min(h[1].length, 6);
      const size = [1.45, 1.25, 1.1, 1.0, 0.95, 0.9][level - 1];
      // Section numbering reads better in a lighter face than the heading it
      // belongs to: "2.1. Number Systems", not "2.1." shouting alongside it.
      const parts = h[2].match(/^((?:\d+\.)+)\s*(.*)$/);
      out.push(
        <h3
          key={`h${key++}`}
          style={{
            fontSize: `${size}rem`,
            fontWeight: level <= 2 ? 700 : 600,
            margin: level <= 2 ? "30px 0 10px" : "24px 0 8px",
            lineHeight: 1.3,
          }}
        >
          {parts ? (
            <>
              <span style={{ color: "var(--muted)", fontWeight: 400 }}>
                {parts[1]}{" "}
              </span>
              {parts[2]}
            </>
          ) : (
            h[2]
          )}
        </h3>
      );
      continue;
    }

    if (/^[-*\u2022]\s+/.test(t)) {
      flushPara();
      bullets.push(t.replace(/^[-*\u2022]\s+/, ""));
      continue;
    }

    if (/^\*[^*]+\*$/.test(t)) {
      flushAll();
      out.push(
        <p
          key={`c${key++}`}
          style={{
            textAlign: "center",
            fontSize: "0.84rem",
            color: "var(--muted)",
            margin: "-12px 0 20px",
          }}
        >
          {t.slice(1, -1)}
        </p>
      );
      continue;
    }

    flushBullets();
    para.push(t);
  }
  flushAll();
  return out;
}

/**
 * Strip anything that could execute, then render.
 *
 * This HTML was written by the teacher and loaded from a seed file, not
 * submitted by a user, so this is a second line of defence rather than the
 * first. It still runs: a body that reaches the database by some other route
 * later should not be able to run a script because of an assumption made now.
 */
function sanitize(html) {
  return String(html)
    .replace(/<script\b[\s\S]*?<\/script>/gi, "")
    .replace(/<style\b[\s\S]*?<\/style>/gi, "")
    .replace(/<iframe\b[\s\S]*?<\/iframe>/gi, "")
    .replace(/\son\w+\s*=\s*"[^"]*"/gi, "")
    .replace(/\son\w+\s*=\s*'[^']*'/gi, "")
    .replace(/\son\w+\s*=\s*[^\s>]+/gi, "")
    .replace(/(href|src)\s*=\s*"\s*javascript:[^"]*"/gi, "");
}

/**
 * Pull the questions out of a note body.
 *
 * The seed writes them as a block of <li> holding a question and its answer.
 * On the teacher's screen that is fine as it stands. On a student's screen the
 * answers have to be held back, so the block is lifted out here and handed to
 * a component that can hide them. Returning the prose either side keeps the
 * note in one piece if the shape ever changes.
 */
export function splitSelfCheck(body) {
  const html = String(body ?? "");
  const open = html.indexOf('<div class="quiz">');
  if (open < 0) return { before: html, questions: [], after: "" };

  const close = html.indexOf("</div>", html.lastIndexOf("</ol>", html.length));
  const end = close < 0 ? html.length : close + 6;
  const block = html.slice(open, end);

  const questions = [];
  const item = /<li>\s*<p class="q">([\s\S]*?)<\/p>\s*<p class="a">([\s\S]*?)<\/p>\s*<\/li>/g;
  let m;
  while ((m = item.exec(block)) !== null) {
    questions.push({
      question: stripTags(m[1]),
      answer: stripTags(m[2]),
    });
  }

  const heading = /<h3>([\s\S]*?)<\/h3>/.exec(block);
  return {
    before: html.slice(0, open),
    questions,
    title: heading ? stripTags(heading[1]) : "Test yourself",
    after: html.slice(end),
  };
}

const ENTITIES = {
  amp: "&", lt: "<", gt: ">", quot: '"', apos: "'", nbsp: " ",
  times: "\u00d7", divide: "\u00f7", minus: "\u2212", deg: "\u00b0",
  hellip: "\u2026", mdash: "\u2014", ndash: "\u2013", rsquo: "\u2019",
  lsquo: "\u2018", ldquo: "\u201c", rdquo: "\u201d", middot: "\u00b7",
};

function stripTags(s) {
  return String(s)
    .replace(/<[^>]+>/g, "")
    // &amp; has to go last or it would double-decode the others, so the whole
    // lot is handled in a single pass instead.
    .replace(/&(#x?[0-9a-f]+|[a-z]+);/gi, (whole, name) => {
      if (name[0] === "#") {
        const code = name[1] === "x" || name[1] === "X"
          ? parseInt(name.slice(2), 16)
          : parseInt(name.slice(1), 10);
        return Number.isFinite(code) ? String.fromCodePoint(code) : whole;
      }
      return ENTITIES[name.toLowerCase()] ?? whole;
    })
    .replace(/\s+/g, " ")
    .trim();
}

export default function NoteBody({ body, format = "markdown", children }) {
  if (!body) return null;

  if (format === "html") {
    return (
      <div
        className="note-html"
        style={{ maxWidth: "68ch", lineHeight: 1.7 }}
        dangerouslySetInnerHTML={{ __html: sanitize(body) }}
      />
    );
  }

  return <div style={{ maxWidth: "68ch" }}>{renderMarkdown(body)}</div>;
}

/** The same note with the questions held back for a student to attempt. */
export function NoteBodyForStudent({ body, format = "markdown", checks }) {
  if (!body) return null;
  if (format !== "html") return <NoteBody body={body} format={format} />;

  const { before, questions, title, after } = splitSelfCheck(body);
  return (
    <div className="note-html" style={{ maxWidth: "68ch", lineHeight: 1.7 }}>
      <div dangerouslySetInnerHTML={{ __html: sanitize(before) }} />
      {questions.length > 0 && checks ? checks({ questions, title }) : null}
      {after ? <div dangerouslySetInnerHTML={{ __html: sanitize(after) }} /> : null}
    </div>
  );
}
