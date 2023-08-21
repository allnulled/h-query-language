HQL_Lenguaje = HQL_Sentencias
HQL_Sentencias = _* sentencias:HQL_Sentencia* _* { return sentencias }
HQL_Sentencia = HQL_Sentencia_CREATE_TABLE
HQL_Sentencia_CREATE_TABLE = 
  token1:(_* ("CREATE TABLE"/"create table") _+)
  tabla:HQL_Id
  token2:( _* )
  atributos:HQL_Hiperdetalles_de_columna?
  token3:( _* "(" _*)
  composicion:HQL_Composicion_de_tabla
  token4:(_* ");")
    { return { tabla, atributos, composicion } }
HQL_Composicion_de_tabla = 
  sentencia1:HQL_Sentencia_CREATE_COLUMN_o_FOREIGN_KEY_1
  sentenciaN:HQL_Sentencia_CREATE_COLUMN_o_FOREIGN_KEY_n*
    { return [].concat([sentencia1]).concat(sentenciaN); }
HQL_Sentencia_CREATE_COLUMN_o_FOREIGN_KEY_1 =
  HQL_Sentencia_FOREIGN_KEY /
  HQL_Sentencia_CREATE_COLUMN
HQL_Sentencia_CREATE_COLUMN = 
  token1:(_*)
  columna:HQL_Id
  token2:(_+)
  tipo:HQL_Tipos
  detalles:HQL_Detalles_de_columna
  hiperdetalles:HQL_Hiperdetalles_de_columna?
    { return { sentencia: "columna", columna, tipo, detalles, hiperdetalles } }
HQL_Detalles_de_columna = (!(","/"\n"/"/*").)* { return text().trim() }
HQL_Hiperdetalles_de_columna =
  token1:"/*"
  atributos:HQL_Hiperatributos
  token2:(_* "*/")
  { return atributos }
HQL_Hiperatributos = HQL_Hiperatributo*
HQL_Hiperatributo =
  token1:(___ (__ __)? (__ __)? "@")
  hiperatributo:HQL_Hiperatributo_texto
    { return hiperatributo }
HQL_Hiperatributo_texto = (!(___).)+ { return text() }
HQL_Tipos = ("INTEGER"/"integer"/"int"/"VARCHAR"/"varchar"/"TEXT"/"text"/"DATETIME"/"datetime")
HQL_Sentencia_FOREIGN_KEY = 
  token1:(_* ("FOREIGN KEY"/"foreign key") _* "(")
  columna:HQL_Id
  token2:(")" _+ ("REFERENCES"/"references") _+)
  tabla_foranea:HQL_Id
  token3:(_* "(" _*)
  columna_foranea:HQL_Id
  token4:(_* ")" _*)
    { return { sentencia: "clave foránea", columna, tabla_foranea, columna_foranea } }
HQL_Sentencia_CREATE_COLUMN_o_FOREIGN_KEY_n =
  token1:(_* "," _*)
  sentencia:HQL_Sentencia_CREATE_COLUMN_o_FOREIGN_KEY_1
    { return sentencia }
HQL_Id = [A-Za-z_] [A-Za-z0-9_$]* { return text() }
___ = "\r" / "\n" {}
__ = "\t" / " " {}
_ = __ / ___ {}