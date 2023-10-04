# hyper-query-language

Lenguaje subconjunto de SQL para extraer JSONs de los ficheros de creación de bases de datos.




## Instalar

Puedes usar:

```sh
git clone https://github.com/allnulled/hyper-query-language.git .
```

...para instalarlo, o descargártelo directamente desde Github.

También puedes instalártelo con npm así:

```sh
npm install --global hyper-query-language
```

Puedes ir a la última versión de NPM aquí:

  - [https://www.npmjs.com/package/hyper-query-language](https://www.npmjs.com/package/hyper-query-language)

Entonces podrás acceder a «`hyper-query-language: interfaz de línea de comandos`» así:

```sh
./node_modules/.bin/hql script_1.sql script_2.sql script_3.sql
```

...o si te lo descargas con el flag de `--global` directamente así:

```sh
hql script_1.sql script_2.sql script_3.sql
```

...y podrás acceder a la API de Node.js así:

```js
const hql_parser = require("hyper-query-language");
const ast = hql_parser.parse(`CREATE TABLE x (id INTEGER PRIMARY KEY);`);
```

## Comandos

Puedes usar `npm link` para tener el lenguaje desde línea de comandos, si te lo descargas a través de `git clone` o Github. Si te lo descargas por `npm` tendrás al `hql` automáticamente disponible por línea de comandos.

Puedes usar `npm run build` para re-compilar el lenguaje con nuevas modificaciones.

Puedes usar `npm run test` para pasar el test sencillo.

## Ventajas

Si te fijas en el ejemplo, entenderás rápidamente la idea: complementar las definiciones de tablas y/o columnas con comentarios multilínea para proveer de más atributos a cada tabla y/o columna.

La ventaja de ceñirse a este subconjunto del SQL es poder crear un JSON sencillo que pueda describir los campos propios del SQL y también otros más, los «hiperatributos».

Básicamente, complementar simbióticamente los scripts de creación de base de datos SQL.

## Línea de comandos

El programa `hql` se instalará a partir del comando `npm link`, que es voluntario.

El programa `hql` sólo acepta 1 tipo de parámetro: ficheros `sql` o `hql` que pasará a su versión `*.json`. Por ejemplo:

```sh
hql un-modulo.sql otro-modulo.sql otro-mas.sql
```

Por ejemplo, cuando lo usas contra el ejemplo...

```sh
hql hyper-query-languaje.example.sql
```

...sale esto:

```
[*] 
[*] Bienvenid@ a «Hyper-Query-Language: Interfaz de línea de comandos»
[*] 
[*] Se van a traducir 1 fichero(s).
[*] 
[*] Procesando fichero 1/1:
[*]   - de: /path/to/project/hyper-query-language/hyper-query-languaje.example.sql
[*]   - a:  /path/to/project/hyper-query-language/hyper-query-languaje.example.sql.json
[*] ✔ Ok fichero.
[*] 
[*] ✔✔✔ Se procesaron todos los ficheros
[*] 
```

## Desarrollo

Para desarrollar tus scripts de creación de base de datos conforme al estándar HQL adecuado, puedes usar la línea de comandos contra ficheros, que te dará los errores por línea de comandos.

Alternativamente, puedes aprovechar:

  - La aplicación online de [PEGjs online](https://pegjs.org/online)
  - El script de sintaxis [hyper-query-language.pegjs](https://raw.githubusercontent.com/allnulled/hyper-query-language/main/hyper-query-language.pegjs) para la sintaxis de PEGjs.
  - El script de creación de bases de datos [hyper-query-languaje.example.sql](https://raw.githubusercontent.com/allnulled/hyper-query-language/main/hyper-query-language.example.sql) para el script de prueba de PEGjs.

Adapta el script de ejemplo a tu casuística de modelo de datos, y así podrás probar rápidamente nuevos modelos de datos contra el lenguaje. Los scripts validados en esta aplicación deberían ser válidos para el [restero](https://github.com/allnulled/restero/tree/main) y así podrás desplegar APIs REST HTTP automáticamente de la forma más rápida y cómoda.

## Versiones

Para consultar las versiones, ves al [CHANGELOG.md](./CHANGELOG.md).

## Sintaxis

La sintaxis de HQL solo permite la sentencia `CREATE TABLE` del SQL. Dentro de la creación de tablas, se permiten 4 sentencias:

  - **Clave primaria.** Todas las tablas deben tener `id` como clave primaria autoincremental para que [`restero`](https://github.com/allnulled/restero) funcione posteriormente. Por lo cual, aunque se permita una sintaxis de claves primarias (`PRIMARY KEY (clave_1, clave_2, clave_3)`), no debe usarse, porque la clave primaria siempre debe ir con `id INTEGER PRIMARY KEY AUTOÏNCREMENT` o `AUTO_INCREMENT` para MySQL, y esto se hace con la sentencia de **Columna**. Por lo cual, este tipo de sentencia, aunque permitida, está totalmente desaconsejada.
  - **Columna.** Esta sentencia es la más habitual, y es la adecuada para construir una nueva columna dentro de la tabla que estamos describiendo. El tipo de dato no es libre, y solo se permiten: `INTEGER`, `VARCHAR`, `TEXT`, `DATETIME`, `REAL`, `BLOB`. Ejemplos:
     - `id INTEGER PRIMARY KEY AUTOINCREMENT`
     - `nombre VARCHAR(255)`
     - `nacimiento DATETIME`
     - ...
  - **Clave foránea.** Sirve para crear referencias de columnas de otras tablas. Ejemplos:
     - `FOREIGN KEY (columna_1) REFERENCES tabla_2 (columna_2)`
  - **Constricción única**. Sirve para crear restricciones de unicidad entre múltiples columnas, las cuales conjuntamente deben presentar unicidad en cada registro. Esta sentencia solo se puede usar contra `mysql` y no contra `sqlite`. Ejemplo:
     - `CONSTRAINT columna_nueva UNIQUE (columna_1, columna_2, columna_3)`

Básicamente, con estos 3 tipos de sentencia debemos poder diseñar bases de datos que se ajusten a los requisitos de [`restero`](https://github.com/allnulled/restero) para poder desplegar aplicaciones REST automáticamente.

## Ejemplos

Esto es un ejemplo muy sencillo de la sintaxis soportada por el HQL:

```sql
CREATE TABLE Tabla /*
  @hiperatributo1: valor
  @hiperatributo2: valor
  @hiperatributo3: valor
  @hiperatributos4:
    - hipersubatributo1: valor
    - hipersubatributo1: valor 2
    - hipersubatributo1: valor 3
  @hiperatributo5: valor
  @hiperatributo6: valor
  @hiperatributo7: valor
*/ (
  id INTEGER PRIMARY KEY AUTOINCREMENT /*
    @hiperatributo8: valor
    @hiperatributo9: valor
    @hiperatributo10: valor
  */,
  columna VARCHAR(255)
);
```

Como se ve, está el SQL, y luego están los hiperatributos, aplicados a tabla y/o a columna. En el caso del `@hiperatributos4` está usando los *hipersubatributos*, que es un hiperatributo compuesto de varios hiperatributos. Por llamarlo de alguna forma.