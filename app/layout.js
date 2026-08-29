import "./globals.css";

export const metadata = {
  title: "GCE Computer Science Coach",
  description:
    "Progression sheets, lessons and objectives for GCE Computer Science and ICT — G.H.S. Mbonjo, Limbe",
};

export const viewport = {
  width: "device-width",
  initialScale: 1,
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        <header className="site">
          <div className="wrap">
            <h1>
              <a href="/">GCE Computer Science Coach</a>
            </h1>
            <p>Government High School Mbonjo, Limbe</p>
          </div>
        </header>
        <main className="wrap">{children}</main>
        <footer className="site">
          <div className="wrap">
            Curriculum data transcribed from the Annual Harmonised Progression
            Sheets (Inspectorate General of Education) and the South West
            regional ICT progression sheet.
          </div>
        </footer>
      </body>
    </html>
  );
}
