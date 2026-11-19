-- Punto 5: catalogacion vista desde EMR/Hive (editor Hive de HUE).
-- El cluster EMR usa el Glue Data Catalog como metastore,
-- por eso aqui aparecen las tablas que creo el crawler.

SHOW DATABASES;
USE saber11_db;
SHOW TABLES;
DESCRIBE saber11;
SELECT COUNT(*) FROM saber11;

-- Tabla externa creada DESDE Hive sobre la zona raw.
-- Despues de crearla, aparece tambien en la consola de Glue y en Athena.
CREATE EXTERNAL TABLE IF NOT EXISTS estratos_hive (
  estrato STRING,
  nivel STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3://saber11-datalake-mm/raw/estratos/'
TBLPROPERTIES ('skip.header.line.count'='1');

SELECT * FROM estratos_hive;
