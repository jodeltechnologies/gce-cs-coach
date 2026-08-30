import LoginForm from "./LoginForm";

export const metadata = { title: "Sign in" };

export default function StudentLogin() {
  return (
    <main style={{ maxWidth: 380, margin: "0 auto", padding: "40px 20px" }}>
      <h2>Sign in</h2>
      <p className="lede">
        Use the code your teacher wrote on the register. The first time, you
        choose a PIN so nobody else can use your code.
      </p>
      <LoginForm />
    </main>
  );
}
