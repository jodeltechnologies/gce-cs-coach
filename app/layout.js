import "./globals.css";

// Browser tab. The template means every page reads "<page> · GCE CS Coach"
// without each one having to repeat the suffix. app/icon.png supplies the tab
// icon automatically — that is the school crest.
export const metadata = {
  title: {
    default: "GCE Computer Science Coach · G.H.S. Mbonjo",
    template: "%s · GCE CS Coach",
  },
  description:
    "Progression sheets, lesson notes and term planning for GCE Computer Science and ICT — Government High School (Lycée) de Mbonjo, Limbe.",
  applicationName: "GCE CS Coach",
};

export const viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: "#1b8a2b",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        <header className="site">
          <div className="bar">
            <img
              className="crest"
              src="/minesec.png"
              alt="Ministry of Secondary Education, Republic of Cameroon"
            />
            <div className="titles">
              <p className="ministry">
                Republic of Cameroon · Ministry of Secondary Education
              </p>
              <h1>
                <a href="/">GCE Computer Science Coach</a>
              </h1>
              <p className="school">
                Government High School (Lycée) de Mbonjo, Limbe
              </p>
              <p className="motto">Discipline, Hardwork &amp; Success</p>
            </div>
            <img className="crest" src="/ghs-mbonjo.jpg" alt="G.H.S. Mbonjo crest" />
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
