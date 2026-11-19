# Punto 6 - Consultas SQL en Athena, EMR/Hive y SparkSQL

`consultas.sql` tiene las 5 preguntas. Se corren **iguales** en los 3 motores:

| Motor | Dónde | Cómo |
|---|---|---|
| Athena | Consola de Athena | Database `saber11_db`, pegar cada consulta y Run |
| Hive | HUE en EMR (puerto 8888) | `USE saber11_db;` y luego cada consulta |
| SparkSQL | Notebook en JupyterHub (punto 7) | celdas con `spark.sql("...")` |

Antes de la primera consulta en Athena hay que configurar la ubicación de resultados:
Settings -> Manage -> `s3://saber11-datalake-mm/athena/`.

## Resultados esperados (iguales en los 3 motores)

| Pregunta | Resultado |
|---|---|
| 1 | BOGOTÁ 267.0, SANTANDER 264.6, BOYACA 261.0, CUNDINAMARCA 258.3, ... |
| 2 | NO OFICIAL 270.8, OFICIAL 241.8 |
| 3 | Medio 264.3, Alto 264.2, Bajo 244.3, Sin estrato 209.6 |
| 4 | Insular 51.9, Andina 48.3, Orinoquia 46.2, Pacifica 45.1, Caribe 44.7, Amazonia 43.7 |
| 5 | M 52.6, F 49.7 |
