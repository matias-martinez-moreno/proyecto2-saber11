# Proyecto 2: big data con las pruebas Saber 11

Sistemas distribuidos. Autor: Matías Martínez Moreno.

Pipeline en AWS (us-east-1) con los resultados de Saber 11, periodo 2020-2 (datos.gov.co, 504.872 estudiantes):
ingesta a un data lake en S3, limpieza con Glue y Spark, catálogo, consultas con Athena, Hive y SparkSQL,
análisis con PySpark y una app en Streamlit detrás de una API.

Cada carpeta `puntoN-*` tiene el código, un README con los pasos y una carpeta `evidencias/` con capturas
(los recuadros rojos marcan qué mirar).

## Caso de estudio

Se compara el puntaje de los estudiantes según departamento, tipo de colegio, estrato, región y género.
Las 5 preguntas están en [punto1](punto1-caso-de-estudio).

Hay tres fuentes: la API de datos.gov.co (puntajes), una tabla en RDS MariaDB (región de cada departamento)
y un archivo en la EC2 (nivel de cada estrato).

## Carpetas

| Carpeta | Contenido |
|---|---|
| [punto1-caso-de-estudio](punto1-caso-de-estudio) | caso de estudio y preguntas |
| [punto2-fuentes](punto2-fuentes) | RDS MariaDB, archivo en la EC2 y URL |
| [punto3-ingesta](punto3-ingesta) | `ingesta.sh` con cron, deja los datos en `raw/` |
| [punto4-preparacion](punto4-preparacion) | job de Glue (PySpark): `raw/` a `trusted/` en Parquet |
| [punto5-catalogo](punto5-catalogo) | crawler de Glue y tablas en Hive |
| [punto6-consultas-sql](punto6-consultas-sql) | las 5 preguntas en Athena, Hive y SparkSQL |
| [punto7-pyspark](punto7-pyspark) | notebook con PySpark, escribe `refined/` |
| [punto8-visualizacion](punto8-visualizacion) | Lambda, API Gateway y Streamlit |

`bootstrap-emr.sh` instala pandas y matplotlib al crear el clúster EMR.

## Nombres usados

Cambiarlos por los propios al reproducir.

| Recurso | Nombre |
|---|---|
| Bucket S3 | `saber11-datalake-mm` (`raw/`, `trusted/`, `refined/`, `athena/`) |
| EC2 | `saber-ec2` |
| RDS | `saber-db`, usuario `admin`, base `saber` |
| Glue | job `saber11-raw-a-trusted`, crawler `saber11-crawler`, base `saber11_db` |
| EMR | `saber11-emr` (emr-7.10.0, 3 nodos m5.xlarge) |
| Lambda | `saber11-api` |

## Cómo reproducirlo

1. Crear el bucket S3 y el clúster EMR.
2. Punto 2: crear la EC2 y la RDS, cargar `departamentos.sql` y copiar `estratos.csv` a la EC2.
3. Punto 3: copiar `ingesta.sh` a la EC2, correrlo y programarlo con cron.
4. Punto 4: crear y correr el job de Glue con `glue_raw_a_trusted.py`.
5. Punto 5: crear y correr el crawler; revisar las tablas en HUE con `hive.sql`.
6. Punto 6: correr `consultas.sql` en Athena, Hive y SparkSQL.
7. Punto 7: subir `saber11.ipynb` a JupyterHub y ejecutarlo completo.
8. Punto 8: crear la Lambda y la API, y correr `app.py` en la EC2.

Las claves y contraseñas del repo son de ejemplo (`CambiarEstaClave123`, `xxxxxxxxxx`).
