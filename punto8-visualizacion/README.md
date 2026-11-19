# Punto 8 - Visualización y app con API Gateway + Streamlit

- **Gráficas (matplotlib):** las últimas celdas del notebook `punto7-pyspark/saber11.ipynb`.
- **API:** `lambda_function.py` lee una respuesta de `refined/` y la devuelve en JSON.
  API Gateway le da una URL pública.
- **App:** `app.py` (Streamlit) llama a la API y muestra la tabla y una gráfica de barras.

## Lambda + API Gateway

1. Lambda -> Create function -> `saber11-api`, Python 3.12, rol existente `LabRole`.
2. Pegar `lambda_function.py` (cambiar `BUCKET`) -> Deploy.
3. Add trigger -> API Gateway -> Create a new API -> HTTP API -> Security: Open -> Add.
4. Copiar el "API endpoint" (pestaña Configuration -> Triggers).

Equivalente por CLI (así se creó la API en este proyecto):
```bash
ARN=$(aws lambda get-function --function-name saber11-api --query Configuration.FunctionArn --output text)
aws apigatewayv2 create-api --name saber11-api --protocol-type HTTP --target "$ARN"
aws lambda add-permission --function-name saber11-api --statement-id apigw-invoke \
  --action lambda:InvokeFunction --principal apigateway.amazonaws.com \
  --source-arn "arn:aws:execute-api:us-east-1:CUENTA:API_ID/*"
curl "https://API_ID.execute-api.us-east-1.amazonaws.com/saber11-api?n=2"
```

Prueba (si se creó por consola):
```bash
curl "https://xxxxxxxxxx.execute-api.us-east-1.amazonaws.com/default/saber11-api?n=2"
```

## Streamlit en la EC2

```bash
pip3 install streamlit requests pandas
cp proyecto2-saber11/punto8-visualizacion/app.py ~/
nano ~/app.py     # pegar la URL de la API en API = "..."
nohup python3 -m streamlit run ~/app.py --server.port 8501 --server.address 0.0.0.0 > ~/streamlit.log 2>&1 &
```

Abrir en el navegador: `http://IP-PUBLICA-EC2:8501`.

No se pone Streamlit directamente detrás de API Gateway porque Streamlit usa WebSockets
y API Gateway (HTTP API) no los reenvía. Por eso API Gateway expone los datos (Lambda)
y Streamlit los consume.
