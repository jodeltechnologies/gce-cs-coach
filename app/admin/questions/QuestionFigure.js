/**
 * Standard figures for questions whose diagrams did not survive scanning.
 *
 * Many past questions turn on a picture: a logic gate symbol, a truth table,
 * a flowchart shape. The pamphlet holds those as images, and nothing in the
 * import pipeline could read them, so the question arrived with its stem and
 * a set of options that refer to something the student cannot see.
 *
 * Some of those pictures are not specific to the question at all. An AND gate
 * symbol is an AND gate symbol; it is defined by the syllabus and drawn the
 * same way in every paper. Those can be redrawn once here and pointed at from
 * any question that needs them, which turns a broken question back into a
 * usable one.
 *
 * This does NOT extend to question-specific artwork — a particular
 * spreadsheet screenshot, a specific project network, one paper's own truth
 * table. Those are still lost, and the honest thing is to leave the question
 * marked as needing a diagram rather than to substitute something plausible.
 */

const S = { fill: "none", stroke: "currentColor", strokeWidth: 1.5 };

function AndShape({ x = 0, y = 0, negated = false }) {
  return (
    <>
      <path d={`M${x + 10} ${y} L${x + 46} ${y} A22 22 0 0 1 ${x + 46} ${y + 44} L${x + 10} ${y + 44} Z`} {...S} />
      {negated && <circle cx={x + 74} cy={y + 22} r="5" {...S} />}
      <line x1={x - 14} y1={y + 11} x2={x + 10} y2={y + 11} {...S} />
      <line x1={x - 14} y1={y + 33} x2={x + 10} y2={y + 33} {...S} />
      <line x1={x + (negated ? 79 : 68)} y1={y + 22} x2={x + 96} y2={y + 22} {...S} />
    </>
  );
}

function OrShape({ x = 0, y = 0, negated = false, exclusive = false }) {
  return (
    <>
      {exclusive && <path d={`M${x} ${y} Q${x + 24} ${y + 22} ${x} ${y + 44}`} {...S} />}
      <path d={`M${x + 10} ${y} Q${x + 34} ${y + 22} ${x + 10} ${y + 44} Q${x + 50} ${y + 44} ${x + 72} ${y + 22} Q${x + 50} ${y} ${x + 10} ${y} Z`} {...S} />
      {negated && <circle cx={x + 78} cy={y + 22} r="5" {...S} />}
      <line x1={x - 14} y1={y + 11} x2={x + 16} y2={y + 11} {...S} />
      <line x1={x - 14} y1={y + 33} x2={x + 16} y2={y + 33} {...S} />
      <line x1={x + (negated ? 83 : 72)} y1={y + 22} x2={x + 100} y2={y + 22} {...S} />
    </>
  );
}

function NotShape({ x = 0, y = 0 }) {
  return (
    <>
      <path d={`M${x + 10} ${y} L${x + 50} ${y + 22} L${x + 10} ${y + 44} Z`} {...S} />
      <circle cx={x + 56} cy={y + 22} r="5" {...S} />
      <line x1={x - 14} y1={y + 22} x2={x + 10} y2={y + 22} {...S} />
      <line x1={x + 61} y1={y + 22} x2={x + 80} y2={y + 22} {...S} />
    </>
  );
}

function Gate({ kind }) {
  const shape = {
    and: <AndShape x={30} y={12} />,
    nand: <AndShape x={30} y={12} negated />,
    or: <OrShape x={30} y={12} />,
    nor: <OrShape x={30} y={12} negated />,
    xor: <OrShape x={30} y={12} exclusive />,
    not: <NotShape x={30} y={12} />,
  }[kind];
  return (
    <svg viewBox="0 0 150 70" width="150" height="70" role="img"
         aria-label={`${kind.toUpperCase()} gate symbol`}
         style={{ color: "var(--ink, #2b2b2b)" }}>
      {shape}
    </svg>
  );
}

function TruthTable({ rows, headers }) {
  return (
    <table style={{ borderCollapse: "collapse", fontSize: "0.85rem", minWidth: 180 }}>
      <thead>
        <tr>
          {headers.map((h) => (
            <th key={h} style={{ border: "1px solid var(--rule, #ddd)", padding: "4px 12px", fontWeight: 600 }}>
              {h}
            </th>
          ))}
        </tr>
      </thead>
      <tbody>
        {rows.map((r, i) => (
          <tr key={i}>
            {r.map((c, j) => (
              <td key={j} style={{ border: "1px solid var(--rule, #ddd)", padding: "4px 12px", textAlign: "center" }}>
                {c}
              </td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
}

const IN2 = [[0, 0], [0, 1], [1, 0], [1, 1]];
const truth = (out) => IN2.map((r, i) => [...r, out[i]]);

export const FIGURES = {
  gate_and:  { label: "AND gate symbol",  render: () => <Gate kind="and" /> },
  gate_or:   { label: "OR gate symbol",   render: () => <Gate kind="or" /> },
  gate_not:  { label: "NOT gate symbol",  render: () => <Gate kind="not" /> },
  gate_nand: { label: "NAND gate symbol", render: () => <Gate kind="nand" /> },
  gate_nor:  { label: "NOR gate symbol",  render: () => <Gate kind="nor" /> },
  gate_xor:  { label: "XOR gate symbol",  render: () => <Gate kind="xor" /> },

  gates_all: {
    label: "The six gate symbols",
    render: () => (
      <div style={{ display: "flex", flexWrap: "wrap", gap: 4 }}>
        {["and", "or", "not", "nand", "nor", "xor"].map((k) => (
          <figure key={k} style={{ margin: 0, textAlign: "center" }}>
            <Gate kind={k} />
            <figcaption style={{ fontSize: "0.75rem", color: "var(--muted)" }}>
              {k.toUpperCase()}
            </figcaption>
          </figure>
        ))}
      </div>
    ),
  },

  truth_and:  { label: "AND truth table",  render: () => <TruthTable headers={["X", "Y", "Out"]} rows={truth([0, 0, 0, 1])} /> },
  truth_or:   { label: "OR truth table",   render: () => <TruthTable headers={["X", "Y", "Out"]} rows={truth([0, 1, 1, 1])} /> },
  truth_nand: { label: "NAND truth table", render: () => <TruthTable headers={["X", "Y", "Out"]} rows={truth([1, 1, 1, 0])} /> },
  truth_nor:  { label: "NOR truth table",  render: () => <TruthTable headers={["X", "Y", "Out"]} rows={truth([1, 0, 0, 0])} /> },
  truth_xor:  { label: "XOR truth table",  render: () => <TruthTable headers={["X", "Y", "Out"]} rows={truth([0, 1, 1, 0])} /> },
  truth_xnor: { label: "XNOR truth table", render: () => <TruthTable headers={["X", "Y", "Out"]} rows={truth([1, 0, 0, 1])} /> },
};

/**
 * Renders the figure named on a question, or nothing if the name is unknown.
 * An unknown name is not an error worth crashing a page over — the question
 * still reads, it just lacks its picture, which is the state it arrived in.
 */
export default function QuestionFigure({ name }) {
  const fig = name ? FIGURES[name] : null;
  if (!fig) return null;
  return (
    <figure style={{ margin: "12px 0", padding: "12px 14px",
                     background: "var(--surface, #faf9f6)",
                     border: "1px solid var(--rule, #e5e2dc)", borderRadius: 8 }}>
      {fig.render()}
      <figcaption style={{ fontSize: "0.75rem", color: "var(--muted)", marginTop: 6 }}>
        Redrawn to the standard symbol — the scan of this figure was not readable.
      </figcaption>
    </figure>
  );
}
