# Punto 1 - Caso de estudio

**Datos:** resultados de las pruebas Saber 11, periodo 2020-2 (ICFES).
Fuente: https://www.datos.gov.co/Educaci-n/Saber-11-2020-2/rnvb-vnyh (504.872 estudiantes).

De todas las columnas solo se usan 8: código y nombre del departamento del colegio,
naturaleza del colegio (oficial / no oficial), género, estrato, y los puntajes de
matemáticas, inglés y global.

Además se usan dos tablas pequeñas:
- `departamentos` (en RDS MariaDB): código del departamento y su región natural.
- `estratos.csv` (archivo en la EC2): cada estrato con su nivel socioeconómico (bajo, medio, alto).

## Preguntas de negocio

1. ¿Cuáles son los 10 departamentos con mejor puntaje global promedio?
2. ¿Quién obtiene mejor puntaje global, los colegios oficiales o los no oficiales?
3. ¿Cómo cambia el puntaje global según el nivel socioeconómico? (usa el archivo de la EC2)
4. ¿Qué región de Colombia tiene el mejor y el peor puntaje en inglés? (usa la base de datos)
5. ¿Hay diferencia entre hombres y mujeres en el puntaje de matemáticas?

## Respuestas obtenidas

| Pregunta | Resultado |
|---|---|
| 1 | Bogotá (267.0), Santander (264.6) y Boyacá (261.0) encabezan el top 10 |
| 2 | No oficiales 270.8 vs oficiales 241.8 |
| 3 | Medio 264.3, Alto 264.2, Bajo 244.3, Sin estrato 209.6 |
| 4 | Mejor: Insular (51.9). Peor: Amazonia (43.7) |
| 5 | Hombres 52.6 vs mujeres 49.7 |
