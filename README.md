# h-query-language

Lenguaje subconjunto de SQL para extraer JSONs de los ficheros de creación de bases de datos.

## Comandos

Puedes usar `npm run build` para re-compilar el lenguaje con nuevas modificaciones.

Puedes usar `npm run test` para pasar el test sencillo.

## Ventajas

Si te fijas en el ejemplo, entenderás rápidamente la idea: complementar las definiciones de tablas y/o columnas con comentarios multilínea para proveer de más atributos a cada tabla y/o columna.

La ventaja de ceñirse a este subconjunto del SQL es poder crear un JSON sencillo que pueda describir los campos propios del SQL y también otros más, los «hiperatributos».

Básicamente, complementar simbióticamente los scripts de creación de base de datos SQL.