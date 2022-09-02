function snakeToPascal(str) {
  return str
    .split("_")
    .map(s => (s = s.charAt(0).toUpperCase() + s.slice(1)))
    .join("");
}
const string = "admin_post_big_binary";
console.log(snakeToPascal(string));
