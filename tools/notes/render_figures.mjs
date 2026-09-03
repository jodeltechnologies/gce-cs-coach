import sharp from "/home/claude/.npm-global/lib/node_modules/sharp/lib/index.js";
import fs from "fs";
const files = fs.readdirSync("fig").filter(f => f.endsWith(".svg"));
for (const f of files) {
  const buf = fs.readFileSync("fig/" + f);
  await sharp(buf, { density: 200 }).png().toFile("fig/" + f.replace(".svg", ".png"));
}
console.log("rendered", files.length);
