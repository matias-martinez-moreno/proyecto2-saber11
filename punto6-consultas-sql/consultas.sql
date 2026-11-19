-- Las 5 preguntas de negocio en SQL.
-- Son las mismas en los 3 motores:
--   Athena:   seleccionar la base de datos saber11_db y correr cada consulta
--   Hive:     correr primero "USE saber11_db;" en el editor Hive de HUE
--   SparkSQL: en el notebook, con spark.sql("...")

-- Pregunta 1: top 10 departamentos con mejor puntaje global promedio
SELECT departamento, ROUND(AVG(puntaje_global), 1) AS promedio_global
FROM saber11
GROUP BY departamento
ORDER BY promedio_global DESC
LIMIT 10;

-- Pregunta 2: colegios oficiales vs no oficiales
SELECT naturaleza, ROUND(AVG(puntaje_global), 1) AS promedio_global
FROM saber11
GROUP BY naturaleza
ORDER BY promedio_global DESC;

-- Pregunta 3: puntaje global por nivel socioeconomico (usa estratos, fuente ARCHIVO)
SELECT e.nivel, ROUND(AVG(s.puntaje_global), 1) AS promedio_global
FROM saber11 s
JOIN estratos e ON s.estrato = e.estrato
GROUP BY e.nivel
ORDER BY promedio_global DESC;

-- Pregunta 4: puntaje de ingles por region (usa departamentos, fuente BASE DE DATOS)
SELECT d.region, ROUND(AVG(s.puntaje_ingles), 1) AS promedio_ingles
FROM saber11 s
JOIN departamentos d ON s.cod_depto = d.codigo
GROUP BY d.region
ORDER BY promedio_ingles DESC;

-- Pregunta 5: puntaje de matematicas por genero
SELECT genero, ROUND(AVG(puntaje_matematicas), 1) AS promedio_matematicas
FROM saber11
WHERE genero IN ('F', 'M')
GROUP BY genero
ORDER BY promedio_matematicas DESC;
