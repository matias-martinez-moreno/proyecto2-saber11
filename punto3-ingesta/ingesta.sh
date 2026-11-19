#!/bin/bash
# Ingesta automatica: lleva las 3 fuentes a la zona RAW del datalake (S3).
# Corre en la EC2 y se ejecuta solo con cron (ver crontab.txt).

BUCKET="saber11-datalake-mm"
RDS_HOST="saber-db.xxxxxxxxxxxx.us-east-1.rds.amazonaws.com"
RDS_USER="admin"
RDS_PASS="CambiarEstaClave123"

URL='https://www.datos.gov.co/resource/rnvb-vnyh.csv?$select=cole_cod_depto_ubicacion,cole_depto_ubicacion,cole_naturaleza,estu_genero,fami_estratovivienda,punt_matematicas,punt_ingles,punt_global&$limit=600000'

# 1. Fuente URL: resultados Saber 11 2020-2 desde datos.gov.co
curl -s -o /tmp/saber11.csv "$URL"
aws s3 cp /tmp/saber11.csv s3://$BUCKET/raw/saber11/saber11.csv

# 2. Fuente ARCHIVO: estratos.csv que esta guardado en esta EC2
aws s3 cp /home/ec2-user/datos/estratos.csv s3://$BUCKET/raw/estratos/estratos.csv

# 3. Fuente BASE DE DATOS: tabla departamentos de RDS MariaDB
mysql --ssl -h $RDS_HOST -u $RDS_USER -p$RDS_PASS -B -e "SELECT * FROM saber.departamentos" | tr '\t' ',' > /tmp/departamentos.csv
aws s3 cp /tmp/departamentos.csv s3://$BUCKET/raw/departamentos/departamentos.csv

echo "$(date) ingesta terminada" >> /home/ec2-user/ingesta.log
