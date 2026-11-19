# Punto 4 - Preparación de datos (raw -> trusted) con Glue y Spark

`glue_raw_a_trusted.py` es un script **PySpark** que corre como **job de AWS Glue**
(Glue ejecuta Spark sin servidor). Hace tres cosas:

1. Deja solo las 8 columnas útiles y les pone nombres cortos.
2. Convierte los puntajes y el código de departamento de texto a número (`int`).
3. Guarda las 3 tablas en la zona **trusted** en formato **Parquet** (columnar y comprimido).

## Pasos

AWS Glue -> ETL jobs -> **Script editor** -> Engine: Spark -> "Start fresh" -> pegar el script.

Job details:
- Name: `saber11-raw-a-trusted`
- IAM Role: `LabRole`
- Worker type: G.1X, Requested number of workers: 2

Save -> Run. Esperar a que quede en **Succeeded** (pestaña Runs).

## Verificación

```bash
aws s3 ls s3://saber11-datalake-mm/trusted/ --recursive --human-readable
```

En el notebook (punto 7) hay una celda que compara filas raw vs trusted:
`filas raw: 504872 | filas trusted: 504872`.
