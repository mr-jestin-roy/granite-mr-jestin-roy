function main() {
  const stdin_array = ["6", "1 2 3 4 5 6", "0 2"];
  const n = Number(stdin_array[0]);
  const array = stdin_array[1].split(" ").map(num => Number(num));
  const [start, stop] = stdin_array[2].split(" ").map(num => Number(num));

  const total = array.reduce(
    (sum, curr, index) => (index <= stop && index >= start ? sum + curr : sum),
    0
  );
  // console.log(total);

  const reduceArr = array.map(num => num - total);

  console.log(reduceArr);
}
