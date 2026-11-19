# Job de AWS Glue (tipo Spark, script en Python).
# Prepara los datos: lee la zona RAW (CSV) y escribe la zona TRUSTED (Parquet).
# Glue ejecuta este codigo PySpark en un cluster de Spark sin servidor.

from pyspark.sql import SparkSession
from pyspark.sql.functions import col

spark = SparkSession.builder.getOrCreate()

B = "s3://saber11-datalake-mm"

# 1. Resultados Saber 11: nombres cortos y puntajes como numeros
saber = spark.read.csv(B + "/raw/saber11/", header=True)
saber = saber.select(
    col("cole_cod_depto_ubicacion").cast("int").alias("cod_depto"),
    col("cole_depto_ubicacion").alias("departamento"),
    col("cole_naturaleza").alias("naturaleza"),
    col("estu_genero").alias("genero"),
    col("fami_estratovivienda").alias("estrato"),
    col("punt_matematicas").cast("int").alias("puntaje_matematicas"),
    col("punt_ingles").cast("int").alias("puntaje_ingles"),
    col("punt_global").cast("int").alias("puntaje_global"),
)
saber.write.mode("overwrite").parquet(B + "/trusted/saber11/")

# 2. Departamentos (viene de la base de datos)
deptos = spark.read.csv(B + "/raw/departamentos/", header=True, inferSchema=True)
deptos.write.mode("overwrite").parquet(B + "/trusted/departamentos/")

# 3. Estratos (viene del archivo de la EC2)
estratos = spark.read.csv(B + "/raw/estratos/", header=True)
estratos.write.mode("overwrite").parquet(B + "/trusted/estratos/")
