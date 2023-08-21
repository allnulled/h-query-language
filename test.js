const fs = require("fs");
const parser = require(__dirname + "/h-query-language.js");
const file_example_1 = fs.readFileSync(__dirname + "/h-query-languaje.example.sql").toString();
const ast = parser.parse(file_example_1);
console.log(ast);