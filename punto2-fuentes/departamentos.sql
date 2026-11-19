-- Fuente BASE DE DATOS (RDS MariaDB)
-- Catalogo de departamentos con su region natural.
-- Se carga desde la EC2 con:
--   mysql --ssl -h ENDPOINT_RDS -u admin -p < departamentos.sql

CREATE DATABASE IF NOT EXISTS saber;
USE saber;

DROP TABLE IF EXISTS departamentos;

CREATE TABLE departamentos (
  codigo INT PRIMARY KEY,
  nombre VARCHAR(40),
  region VARCHAR(20)
);

INSERT INTO departamentos VALUES
(5,  'ANTIOQUIA',       'Andina'),
(8,  'ATLANTICO',       'Caribe'),
(11, 'BOGOTA',          'Andina'),
(13, 'BOLIVAR',         'Caribe'),
(15, 'BOYACA',          'Andina'),
(17, 'CALDAS',          'Andina'),
(18, 'CAQUETA',         'Amazonia'),
(19, 'CAUCA',           'Pacifica'),
(20, 'CESAR',           'Caribe'),
(23, 'CORDOBA',         'Caribe'),
(25, 'CUNDINAMARCA',    'Andina'),
(27, 'CHOCO',           'Pacifica'),
(41, 'HUILA',           'Andina'),
(44, 'LA GUAJIRA',      'Caribe'),
(47, 'MAGDALENA',       'Caribe'),
(50, 'META',            'Orinoquia'),
(52, 'NARINO',          'Pacifica'),
(54, 'NORTE SANTANDER', 'Andina'),
(63, 'QUINDIO',         'Andina'),
(66, 'RISARALDA',       'Andina'),
(68, 'SANTANDER',       'Andina'),
(70, 'SUCRE',           'Caribe'),
(73, 'TOLIMA',          'Andina'),
(76, 'VALLE',           'Pacifica'),
(81, 'ARAUCA',          'Orinoquia'),
(85, 'CASANARE',        'Orinoquia'),
(86, 'PUTUMAYO',        'Amazonia'),
(88, 'SAN ANDRES',      'Insular'),
(91, 'AMAZONAS',        'Amazonia'),
(94, 'GUAINIA',         'Amazonia'),
(95, 'GUAVIARE',        'Amazonia'),
(97, 'VAUPES',          'Amazonia'),
(99, 'VICHADA',         'Orinoquia');

SELECT COUNT(*) AS total_departamentos FROM departamentos;
