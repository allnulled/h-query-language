# h-query-language

Lenguaje subconjunto de SQL para extraer JSONs de los ficheros de creación de bases de datos.

## Instalar

Puedes usar `git clone https://github.com/allnulled/h-query-language.git` para instalarlo, o descargártelo directamente

## Comandos

Puedes usar `npm link` para tener el lenguaje desde línea de comandos.

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
hql h-query-languaje.example.sql
```

...sale esto:

```
[*] 
[*] Bienvenid@ a «Hyper-Query-Language: Interfaz de línea de comandos»
[*] 
[*] Se van a traducir 1 fichero(s).
[*] 
[*] Procesando fichero 1/1:
[*]   - de: /home/carlos/Escritorio/Nuevo4/h-query-language/h-query-languaje.example.sql
[*]   - a:  /home/carlos/Escritorio/Nuevo4/h-query-language/h-query-languaje.example.sql.json
[*] ✔ Ok fichero.
[*] 
[*] ✔✔✔ Se procesaron todos los ficheros
```

## Desarrollo

Para desarrollar tus scripts de creación de base de datos conforme al estándar HQL adecuado, puedes usar la línea de comandos contra ficheros, que te dará los errores por línea de comandos.

Alternativamente, puedes aprovechar:

  - La aplicación online de [PEGjs online](https://pegjs.org/online)
  - El script de sintaxis [h-query-language.pegjs](https://raw.githubusercontent.com/allnulled/h-query-language/main/h-query-language.pegjs) para la sintaxis de PEGjs.
  - El script de creación de bases de datos [h-query-languaje.example.sql](https://raw.githubusercontent.com/allnulled/h-query-language/main/h-query-languaje.example.sql) para el script de prueba de PEGjs.

Adapta el script de ejemplo a tu casuística de modelo de datos, y así podrás probar rápidamente nuevos modelos de datos contra el lenguaje. Los scripts validados en esta aplicación deberían ser válidos para el [HQL-Deployer](https://github.com/allnulled/hql-deployer/tree/main). Así podrás desplegar APIs REST HTTP automáticamente de la forma más rápida y cómoda.

## Versiones

Para consultar las versiones, ves al [CHANGELOG.md](./CHANGELOG.md).

## Limitaciones

De momento, los problemas encontrados son:

  - Si quieres tener multiple keys, no puedes decírselo a la base de datos en el script de creación. Tienes que hacerlo indirectamente, por otro lado, triggers, atomizar un insert embediendo un select incremental al crear una instancia, cosas así.
