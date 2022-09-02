function snakeToPascal(str) {
  str += "";
  str = str.split("_");
  for (var i = 0; i < str.length; i++) {
    str[i] = str[i].slice(0, 1).toUpperCase() + str[i].slice(1, str[i].length);
  }
  return str.join("");
}
const string = "admin_post_big_binary";
console.log(snakeToPascal(string));
