# Punto 3 - Ingesta automática a S3

`ingesta.sh` corre en la EC2 y copia las 3 fuentes a la zona **raw** del bucket:

| Fuente | Destino en S3 |
|---|---|
| URL datos.gov.co | `raw/saber11/saber11.csv` |
| Archivo de la EC2 | `raw/estratos/estratos.csv` |
| Tabla de RDS MariaDB | `raw/departamentos/departamentos.csv` |

Es automática porque cron la ejecuta cada hora (`crontab.txt`).
Cada tabla queda en su propia carpeta para que el crawler cree una tabla por carpeta.

## Pasos (en la EC2)

```bash
cp proyecto2-saber11/punto3-ingesta/ingesta.sh ~/
nano ~/ingesta.sh          # poner BUCKET, RDS_HOST y RDS_PASS
chmod +x ~/ingesta.sh
~/ingesta.sh               # primera ejecución manual
crontab -e                 # pegar la línea de crontab.txt
```

## Verificación

```bash
crontab -l
cat ~/ingesta.log
aws s3 ls s3://saber11-datalake-mm/raw/ --recursive --human-readable
aws s3 cp s3://saber11-datalake-mm/raw/departamentos/departamentos.csv - | head -5
```
