# App de Streamlit: consume la API (API Gateway + Lambda) y muestra cada respuesta.
# Correr en la EC2 con:
#   python3 -m streamlit run app.py --server.port 8501 --server.address 0.0.0.0

import requests
import pandas as pd
import streamlit as st

API = "https://xxxxxxxxxx.execute-api.us-east-1.amazonaws.com/default/saber11-api"

preguntas = {
    "1": "Top 10 departamentos por puntaje global",
    "2": "Colegios oficiales vs no oficiales",
    "3": "Puntaje global por nivel socioeconomico",
    "4": "Puntaje de ingles por region",
    "5": "Puntaje de matematicas por genero",
}

st.title("Pruebas Saber 11 (2020-2)")
n = st.selectbox("Pregunta de negocio", list(preguntas), format_func=lambda k: k + ". " + preguntas[k])

datos = pd.DataFrame(requests.get(API, params={"n": n}).json())
categoria = datos.columns[0]
valor = datos.columns[1]
datos[valor] = pd.to_numeric(datos[valor])

st.dataframe(datos)
st.bar_chart(datos, x=categoria, y=valor)
