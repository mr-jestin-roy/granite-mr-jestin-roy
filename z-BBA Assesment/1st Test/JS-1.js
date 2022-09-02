const fruitsArray = ["1 2 3 4", "3 4 5"];
let [array, another_array] = fruitsArray;

array = array.split(" ").map(item => Number(item));
another_array = another_array.split(" ").map(item => Number(item));
const commonElements = array.filter(item => another_array.includes(item));
// console.log(array);
// console.log(another_array);
console.log(commonElements);
