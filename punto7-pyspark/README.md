# Punto 7 - Analítica con PySpark

`saber11.ipynb` corre en JupyterHub del clúster EMR (`https://DNS-DEL-MASTER:9443`,
usuario `jovyan`, clave `jupyter`), con el kernel **PySpark**.

Qué hace:
1. Lee la zona trusted y crea vistas temporales.
2. Verifica que raw y trusted tengan las mismas filas.
3. Punto 6: responde las 5 preguntas con `spark.sql(...)` (SparkSQL).
4. Punto 7: responde las mismas 5 preguntas con la API de DataFrames (`groupBy`, `agg`, `join`, `orderBy`).
5. Guarda las 5 respuestas en `s3://saber11-datalake-mm/refined/p1/` ... `p5/` (CSV).
6. Punto 8: hace dos gráficas con matplotlib.

## Pasos

JupyterHub -> Upload -> `saber11.ipynb` -> cambiar `BUCKET` en la primera celda -> Run All.

## Verificación

```bash
aws s3 ls s3://saber11-datalake-mm/refined/ --recursive
aws s3 cp s3://saber11-datalake-mm/refined/p2/ ./p2 --recursive
cat ./p2/*.csv
```
