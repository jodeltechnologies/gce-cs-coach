import zlib from "node:zlib";

/**
 * Read the first sheet of an .xlsx file. No dependency.
 *
 * A teacher's class list lives in Excel, and telling them to convert it to CSV
 * first is a step that will be got wrong or forgotten. SheetJS would read this
 * in one line, but an .xlsx is a zip of XML and the part needed here — the
 * cells of one sheet as text — is small enough to read directly. Node already
 * ships the only hard piece, which is inflate.
 *
 * Everything a spreadsheet can also do is ignored on purpose: formulas are
 * read as their cached value, formatting is dropped, and only the first sheet
 * is looked at. This reads a list of names, not a workbook.
 */

/** Entries of a zip archive, by name. */
function unzip(buffer) {
  // Find the end-of-central-directory record. Reading the central directory
  // rather than scanning for local headers matters: when a file is written
  // with a data descriptor the local header's sizes are zero, and a scanner
  // that trusts them reads garbage.
  let eocd = -1;
  const min = Math.max(0, buffer.length - 66000);
  for (let i = buffer.length - 22; i >= min; i--) {
    if (buffer.readUInt32LE(i) === 0x06054b50) {
      eocd = i;
      break;
    }
  }
  if (eocd < 0) throw new Error("Not a zip file (no end-of-directory record).");

  const count = buffer.readUInt16LE(eocd + 10);
  let p = buffer.readUInt32LE(eocd + 16);
  const files = new Map();

  for (let n = 0; n < count; n++) {
    if (buffer.readUInt32LE(p) !== 0x02014b50) break;
    const method = buffer.readUInt16LE(p + 10);
    const compSize = buffer.readUInt32LE(p + 20);
    const nameLen = buffer.readUInt16LE(p + 28);
    const extraLen = buffer.readUInt16LE(p + 30);
    const commentLen = buffer.readUInt16LE(p + 32);
    const localOffset = buffer.readUInt32LE(p + 42);
    const name = buffer.toString("utf8", p + 46, p + 46 + nameLen);

    const lNameLen = buffer.readUInt16LE(localOffset + 26);
    const lExtraLen = buffer.readUInt16LE(localOffset + 28);
    const start = localOffset + 30 + lNameLen + lExtraLen;
    const raw = buffer.subarray(start, start + compSize);

    try {
      files.set(name, method === 0 ? raw : zlib.inflateRawSync(raw));
    } catch {
      // A part that will not inflate is one we probably do not need.
    }
    p += 46 + nameLen + extraLen + commentLen;
  }
  return files;
}

function decodeEntities(s) {
  return s
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&quot;/g, '"')
    .replace(/&apos;/g, "'")
    .replace(/&#(\d+);/g, (_, d) => String.fromCodePoint(Number(d)))
    .replace(/&#x([0-9a-fA-F]+);/g, (_, h) => String.fromCodePoint(parseInt(h, 16)))
    .replace(/&amp;/g, "&");
}

/** Text of every <t> inside one element, joined — a cell can be split across runs. */
function textOf(xml) {
  let out = "";
  const re = /<t\b[^>]*>([\s\S]*?)<\/t>/g;
  let m;
  while ((m = re.exec(xml)) !== null) out += m[1];
  return decodeEntities(out);
}

function sharedStrings(files) {
  const buf = files.get("xl/sharedStrings.xml");
  if (!buf) return [];
  const xml = buf.toString("utf8");
  const out = [];
  const re = /<si\b[^>]*>([\s\S]*?)<\/si>/g;
  let m;
  while ((m = re.exec(xml)) !== null) out.push(textOf(m[1]));
  return out;
}

/** "BC12" -> 54 (zero-based column index). */
function columnIndex(ref) {
  const letters = (ref.match(/^[A-Z]+/) || ["A"])[0];
  let n = 0;
  for (const ch of letters) n = n * 26 + (ch.charCodeAt(0) - 64);
  return n - 1;
}

function firstSheetName(files) {
  // Sheet order in workbook.xml is the order the tabs appear in, which is what
  // "the first sheet" means to the person who made the file.
  for (const key of ["xl/worksheets/sheet1.xml"]) {
    if (files.has(key)) return key;
  }
  for (const key of files.keys()) {
    if (key.startsWith("xl/worksheets/") && key.endsWith(".xml")) return key;
  }
  return null;
}

/**
 * Rows of the first sheet as arrays of strings.
 * Blank trailing cells are trimmed; fully blank rows are dropped.
 */
export function readXlsx(buffer) {
  const files = unzip(buffer);
  const strings = sharedStrings(files);
  const sheetKey = firstSheetName(files);
  if (!sheetKey) throw new Error("No worksheet found inside the file.");
  const xml = files.get(sheetKey).toString("utf8");

  const rows = [];
  const rowRe = /<row\b[^>]*>([\s\S]*?)<\/row>/g;
  let rowMatch;
  while ((rowMatch = rowRe.exec(xml)) !== null) {
    const cells = [];
    const cellRe = /<c\b([^>]*)\/>|<c\b([^>]*)>([\s\S]*?)<\/c>/g;
    let cellMatch;
    while ((cellMatch = cellRe.exec(rowMatch[1])) !== null) {
      const attrs = cellMatch[1] ?? cellMatch[2] ?? "";
      const inner = cellMatch[3] ?? "";
      const ref = (attrs.match(/r="([A-Z]+\d+)"/) || [])[1];
      const type = (attrs.match(/t="(\w+)"/) || [])[1];

      let value = "";
      if (type === "s") {
        const idx = Number((inner.match(/<v>(\d+)<\/v>/) || [])[1]);
        value = strings[idx] ?? "";
      } else if (type === "inlineStr") {
        value = textOf(inner);
      } else {
        const v = (inner.match(/<v>([\s\S]*?)<\/v>/) || [])[1];
        value = v ? decodeEntities(v) : "";
      }

      const at = ref ? columnIndex(ref) : cells.length;
      while (cells.length < at) cells.push("");
      cells[at] = String(value).trim();
    }
    while (cells.length && cells[cells.length - 1] === "") cells.pop();
    if (cells.some((c) => c !== "")) rows.push(cells);
  }
  return rows;
}

/**
 * Rows from CSV or tab-separated text.
 * Handles quoted fields, embedded commas and doubled quotes, because a class
 * list with "Ngwa, Divine" in it is not unusual.
 */
export function readDelimited(text) {
  const clean = text.replace(/\r\n?/g, "\n").trim();
  if (!clean) return [];
  // Pick the separator by counting candidates on the first line. Excel on a
  // French locale writes semicolons, which a comma-only parser reads as one
  // long field.
  const first = clean.split("\n")[0];
  const counts = { ",": 0, ";": 0, "\t": 0 };
  let q = false;
  for (const ch of first) {
    if (ch === '"') q = !q;
    else if (!q && ch in counts) counts[ch]++;
  }
  const sep = Object.entries(counts).sort((a, b) => b[1] - a[1])[0][1] > 0
    ? Object.entries(counts).sort((a, b) => b[1] - a[1])[0][0]
    : "\n";

  const rows = [];
  let row = [];
  let field = "";
  let inQuotes = false;
  for (let i = 0; i < clean.length; i++) {
    const ch = clean[i];
    if (inQuotes) {
      if (ch === '"') {
        if (clean[i + 1] === '"') { field += '"'; i++; }
        else inQuotes = false;
      } else field += ch;
      continue;
    }
    if (ch === '"') inQuotes = true;
    else if (sep !== "\n" && ch === sep) { row.push(field.trim()); field = ""; }
    else if (ch === "\n") {
      row.push(field.trim());
      field = "";
      if (row.some((c) => c !== "")) rows.push(row);
      row = [];
    } else field += ch;
  }
  row.push(field.trim());
  if (row.some((c) => c !== "")) rows.push(row);
  return rows;
}
