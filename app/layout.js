import fs from "node:fs";
import path from "node:path";
import "./globals.css";

export const metadata = {
  title: "GCE Computer Science Coach — G.H.S. Mbonjo",
  description:
    "Progression sheets, lessons and objectives for GCE Computer Science and ICT — Government High School Mbonjo, Limbe",
};

export const viewport = { width: "device-width", initialScale: 1 };

// The school crest ships with the project. The MINESEC coat of arms does not,
// because it is a government emblem I should not guess at or redraw. Drop the
// official file at public/minesec.png and it appears automatically; until then
// the masthead simply omits it rather than showing a broken image.
function hasMinesec() {
  try {
    return fs.existsSync(path.join(process.cwd(), "public", "minesec.png"));
  } catch {
    return false;
  }
}

export default function RootLayout({ children }) {
  const minesec = hasMinesec();
  return (
    <html lang="en">
      <body>
        <header className="site">
          <div className="bar">
            {minesec && (
              <img
                className="crest"
                src="/minesec.png"
                alt="Ministry of Secondary Education, Republic of Cameroon"
              />
            )}
            <div className="titles">
              <p className="ministry">
                Republic of Cameroon · Ministry of Secondary Education
              </p>
              <h1>
                <a href="/">GCE Computer Science Coach</a>
              </h1>
              <p className="school">Government High School (Lycée) de Mbonjo, Limbe</p>
              <p className="motto">Discipline, Hardwork &amp; Success</p>
            </div>
            <img
              className="crest"
              src="/ghs-mbonjo.jpg"
              alt="G.H.S. Mbonjo crest"
            />
            <nav>
              <a href="/">Progression</a>
              <a href="/admin">Admin</a>
            </nav>
          </div>
        </header>
        <main className="wrap">{children}</main>
        <footer className="site">
          <div className="wrap">
            Curriculum transcribed from the Annual Harmonised Progression Sheets
            (Inspectorate General of Education) and the South West regional ICT
            progression sheet.
          </div>
        </footer>
      </body>
    </html>
  );
}
