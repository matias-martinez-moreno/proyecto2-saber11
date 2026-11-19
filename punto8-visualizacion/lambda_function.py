# Lambda que expone las respuestas de la zona refined.
# API Gateway la llama con: GET .../saber11-api?n=1   (n = numero de pregunta, 1 a 5)

import csv
import json
import boto3

BUCKET = "saber11-datalake-mm"
s3 = boto3.client("s3")


def lambda_handler(event, context):
    parametros = event.get("queryStringParameters") or {}
    n = parametros.get("n", "1")

    # Spark guarda cada respuesta como una carpeta con un archivo part-....csv
    objetos = s3.list_objects_v2(Bucket=BUCKET, Prefix="refined/p" + n + "/")["Contents"]
    archivo = [o["Key"] for o in objetos if o["Key"].endswith(".csv")][0]

    texto = s3.get_object(Bucket=BUCKET, Key=archivo)["Body"].read().decode("utf-8")
    filas = list(csv.DictReader(texto.splitlines()))

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(filas, ensure_ascii=False),
    }
