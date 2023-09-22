#!/usr/bin/env node

const fs = require("fs");
const path = require("path");
const hql_parser_path = path.resolve(__dirname, "hyper-query-language.js");
const hql_parser = require(hql_parser_path);
const args = process.argv;
const node_path = args.shift();
const binary_path = args.shift();

try {
    console.log(`[*] `)
    console.log(`[*] Bienvenid@ a «Hyper-Query-Language: Interfaz de línea de comandos»`)
    console.log(`[*] `)
    console.log(`[*] Se van a traducir ${args.length} fichero(s).`)
    for(let index = 0; index < args.length; index++) {
        const file = path.resolve(args[index]);
        const file_dest = path.resolve(args[index] + ".json");
        console.log(`[*] `)
        console.log(`[*] Procesando fichero ${index+1}/${args.length}:`)
        console.log(`[*]   - de: ${file}`);
        console.log(`[*]   - a:  ${file_dest}`);
        const file_contents = fs.readFileSync(file).toString();
        const ast = hql_parser.parse(file_contents);
        fs.writeFileSync(file_dest, JSON.stringify(ast, null, 2), "utf8");
        console.log(`[*] ✔ Ok fichero.`)
    }
    console.log(`[*] `)
    console.log(`[*] ✔✔✔ Se procesaron todos los ficheros`)
    console.log(`[*] `)
} catch (error) {
    console.error(error);
}