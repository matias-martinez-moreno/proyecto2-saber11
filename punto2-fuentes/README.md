# Punto 2 - Fuentes de datos

| Fuente | Dónde está | Qué tiene |
|---|---|---|
| URL | datos.gov.co (API Socrata) | Resultados Saber 11 2020-2 |
| Base de datos | RDS MariaDB `saber-db`, base `saber` | Tabla `departamentos` (33 filas) |
| Archivo | EC2 `saber-ec2`, `/home/ec2-user/datos/estratos.csv` | Estratos y nivel (7 filas) |

## Pasos

1. Crear la EC2 (Amazon Linux 2023, rol `LabInstanceProfile`, puertos 22 y 8501).
2. En la EC2:
   ```bash
   sudo dnf install -y mariadb105 cronie git python3-pip
   sudo systemctl enable --now crond
   git clone https://github.com/USUARIO/proyecto2-saber11.git
   mkdir -p ~/datos
   cp proyecto2-saber11/punto2-fuentes/estratos.csv ~/datos/
   ```
3. Crear la RDS MariaDB con "Connect to an EC2 compute resource" apuntando a `saber-ec2`
   (sin Enhanced Monitoring).
4. Cargar la tabla desde la EC2:
   ```bash
   mysql --ssl -h ENDPOINT_RDS -u admin -p < proyecto2-saber11/punto2-fuentes/departamentos.sql
   ```

## Verificación

```bash
cat ~/datos/estratos.csv
mysql --ssl -h ENDPOINT_RDS -u admin -p -e "SELECT COUNT(*) FROM saber.departamentos; SELECT * FROM saber.departamentos LIMIT 5;"
curl -s 'https://www.datos.gov.co/resource/rnvb-vnyh.csv?$limit=3'
```
