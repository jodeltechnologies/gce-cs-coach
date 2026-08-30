import { Literata, Outfit } from "next/font/google";
import Link from "next/link";
import "./globals.css";

// Two fonts, each doing one job.
//
// Literata is a reading face: Google commissioned it for Google Books, so it
// was drawn for long passages on a screen rather than for headlines. That is
// exactly what a lesson note is. It is what carries the notes a student reads.
//
// Outfit handles the interface — buttons, tags, headings — where you scan
// rather than read. It is a geometric sans with a wide, confident cap height,
// which is what gives the JODEL site its look: headlines that feel engineered
// rather than typed.
//
// next/font downloads both at build time and serves them from your own domain.
// No request ever goes to Google from a student's phone, which means one less
// thing to fail on a weak connection, and nothing to load twice.
const reading = Literata({
  subsets: ["latin"],
  display: "swap",
  variable: "--font-reading",
});

const ui = Outfit({
  subsets: ["latin"],
  display: "swap",
  variable: "--font-ui",
});

export const metadata = {
  metadataBase: new URL("https://gce-cs-coach.vercel.app"),
  title: {
    default: "GCE Computer Science Coach · G.H.S. Mbonjo",
    template: "%s · GCE CS Coach",
  },
  description:
    "Progression sheets, lesson notes and term planning for GCE Computer Science and ICT — Government High School (Lycée) de Mbonjo, Limbe.",
  applicationName: "GCE CS Coach",
  openGraph: {
    title: "GCE Computer Science Coach",
    description:
      "Progression sheets, lesson notes and term planning for GCE Computer Science and ICT — G.H.S. Mbonjo, Limbe.",
    siteName: "GCE CS Coach",
    locale: "en_GB",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "GCE Computer Science Coach",
    description:
      "Progression sheets, lesson notes and term planning — G.H.S. Mbonjo, Limbe.",
  },
};

export const viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: "#1b8a2b",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en" className={`${reading.variable} ${ui.variable}`}>
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
                <Link href="/">GCE Computer Science Coach</Link>
              </h1>
              <p className="school">
                Government High School (Lycée) de Mbonjo, Limbe
              </p>
              <p className="motto">Discipline, Hardwork &amp; Success</p>
            </div>
            <img className="crest" src="/ghs-mbonjo.jpg" alt="G.H.S. Mbonjo crest" />
            <nav>
              <Link href="/">Progression</Link>
              <Link href="/admin">Admin</Link>
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
