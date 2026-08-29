// A client component cannot export metadata, and the login page needs to be
// one because it handles the password form. A layout supplies the tab title
// instead.
export const metadata = { title: "Sign in" };

export default function LoginLayout({ children }) {
  return children;
}
