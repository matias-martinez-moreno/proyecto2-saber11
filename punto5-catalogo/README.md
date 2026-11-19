# Punto 5 - Catalogación con AWS Glue y EMR/Hive

## Glue Crawler

AWS Glue -> Data Catalog -> Crawlers -> Create crawler:
- Name: `saber11-crawler`
- Data source: S3, path `s3://saber11-datalake-mm/trusted/`, exclude pattern `**/_SUCCESS`
- IAM Role: `LabRole`
- Target database: crear `saber11_db`

Run crawler. Crea 3 tablas: `saber11`, `departamentos` y `estratos`.

## EMR / Hive

El clúster EMR se creó con el **Glue Data Catalog como metastore de Hive y Spark**,
por eso las tablas del crawler se ven en Hive sin volver a crearlas.
En HUE (puerto 8888) -> editor Hive -> correr `hive.sql`.

`hive.sql` también crea una tabla externa **desde Hive** (`estratos_hive`).
Esa tabla aparece después en la consola de Glue y en Athena: el catálogo es uno solo.

## Verificación

```bash
aws glue get-tables --database-name saber11_db --query "TableList[].Name"
```

## HDFS y YARN del clúster (NameNode, DataNodes)

Terminal del nodo primario: EC2 -> instancia del primario del EMR -> Conectar ->
EC2 Instance Connect, usuario `hadoop`.

```bash
hdfs dfsadmin -report | grep -E 'Live datanodes|^Name:'      # 2 DataNodes vivos
yarn node -list                                               # 2 NodeManagers RUNNING
hdfs dfs -mkdir -p /user/hadoop/saber11
hdfs dfs -D dfs.replication=2 -cp -f s3://saber11-datalake-mm/raw/saber11/saber11.csv /user/hadoop/saber11/
hdfs fsck /user/hadoop/saber11/saber11.csv -files -blocks -locations   # el bloque en los 2 DataNodes
hive -S -e "SELECT COUNT(*) FROM saber11_db.saber11"           # Hive por línea de comandos
```

Interfaces web (abrir los puertos 9870 y 8088 del primario para tu IP):
`http://DNS-PRIMARIO:9870` (NameNode -> pestaña Datanodes) y `http://DNS-PRIMARIO:8088` (YARN).

Nota: en HUE, si abre el editor MySQL, cambiar a Hive con el icono `</>` de la barra izquierda.
