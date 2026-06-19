/*Creación de la tabla*/
CREATE TABLE cotizacion_dolar (
    fecha DATE,
    cotizacion DOUBLE
);

/*¿Cuántos registros tenemos por año? ¿Algún año tiene significativamente menos días de cotización que otros?*/
SELECT YEAR(fecha) AS anio, count(cotizacion) AS registros FROM cotizacionbcp.cotizacion_dolar GROUP BY YEAR(fecha);

/*¿Cuál fue la cotización más alta y más baja de todo el histórico, y en qué fecha ocurrió cada una?*/
SELECT cotizacion, fecha FROM cotizacionbcp.cotizacion_dolar WHERE cotizacion = (SELECT MAX(cotizacion) FROM cotizacionbcp.cotizacion_dolar)
OR cotizacion = (SELECT MIN(cotizacion) FROM cotizacionbcp.cotizacion_dolar);

/*¿Cuál fue el promedio anual del dólar para cada año?*/
SELECT YEAR(fecha) AS anio, ROUND(AVG(cotizacion),2) as promedio FROM cotizacionbcp.cotizacion_dolar 
GROUP BY anio
ORDER BY anio;

/*¿Cuál fue el mes con el promedio de cotización más alto históricamente? ¿Y el más bajo?*/
(SELECT MONTHNAME(fecha) AS mes, ROUND(AVG(cotizacion),2) AS promedio 
 FROM cotizacionbcp.cotizacion_dolar
 GROUP BY MONTH(fecha)
 ORDER BY promedio DESC 
 LIMIT 1)
UNION ALL
(SELECT MONTHNAME(fecha) AS mes, ROUND(AVG(cotizacion),2) AS promedio 
 FROM cotizacionbcp.cotizacion_dolar
 GROUP BY MONTH(fecha)
 ORDER BY promedio ASC 
 LIMIT 1);

/*¿En qué año el dólar tuvo la mayor variación entre el valor máximo y mínimo del año?*/
SELECT YEAR(fecha), MAX(cotizacion) AS max, MIN(cotizacion) AS min, ROUND(MAX(cotizacion) - MIN(cotizacion),2) AS diferencia FROM cotizacionbcp.cotizacion_dolar
GROUP BY YEAR(fecha)
ORDER BY diferencia DESC LIMIT 1;

/*¿Cuál fue la variación porcentual del promedio anual año a año?*/
SELECT actual.anio AS Año_base, 
actual.promedio_anual AS Promedio_base,
siguiente.anio AS Año_siguiente,
siguiente.promedio_anual AS Promedio_siguiente,
ROUND((siguiente.promedio_anual - actual.promedio_anual)/actual.promedio_anual*100,2) AS Porcentaje_Variacion_Anual
FROM (SELECT YEAR(fecha) AS anio, ROUND(AVG(cotizacion),2) AS promedio_anual FROM cotizacionbcp.cotizacion_dolar
GROUP BY YEAR(fecha)) AS actual
INNER JOIN (SELECT YEAR(fecha) AS anio, ROUND(AVG(cotizacion),2) AS promedio_anual FROM cotizacionbcp.cotizacion_dolar
GROUP BY YEAR(fecha)) AS siguiente ON actual.anio = siguiente.anio - 1
ORDER BY actual.anio;

/*¿Cuál fue la cotización al primer y último día hábil de cada año?*/
SELECT 
    fechas.anio,
    fechas.primer_dia,
    c_inicio.cotizacion AS cotizacion_inicial,
    fechas.ultimo_dia,
    c_fin.cotizacion AS cotizacion_final 
FROM (
    SELECT 
        YEAR(fecha) AS anio, 
        MIN(fecha) AS primer_dia, 
        MAX(fecha) AS ultimo_dia 
    FROM cotizacionbcp.cotizacion_dolar
    GROUP BY YEAR(fecha)
) AS fechas
INNER JOIN cotizacionbcp.cotizacion_dolar AS c_inicio ON fechas.primer_dia = c_inicio.fecha
INNER JOIN cotizacionbcp.cotizacion_dolar AS c_fin ON fechas.ultimo_dia = c_fin.fecha;

/*¿Cuántos días por año el dólar estuvo por encima del promedio anual?*/
SELECT Prom_anual.anio AS Anio, COUNT(cotizacion_diaria.cotizacion) AS Dias_año FROM 
(SELECT YEAR(fecha) AS anio, AVG(cotizacion) AS promedio_anual FROM cotizacionbcp.cotizacion_dolar GROUP BY anio) AS Prom_anual 
LEFT JOIN (SELECT fecha, cotizacion FROM cotizacionbcp.cotizacion_dolar) AS cotizacion_diaria
ON YEAR(cotizacion_diaria.fecha) = Prom_anual.anio AND cotizacion_diaria.cotizacion > Prom_anual.promedio_anual
GROUP BY Prom_anual.anio;

USE cotizacionbcp;

/*
-- VISTAS
-- Creadas como paso intermedio para resolver
-- las limitaciones de MySQL 5.6, que no permite
-- subconsultas en el FROM dentro de una vista.
-- Cada vista intermedia es utilizada por la
-- vista principal correspondiente.
*/

-- Vista independiente: promedio anual
CREATE VIEW v_promedio_anual AS
SELECT YEAR(fecha) AS anio, ROUND(AVG(cotizacion),2) AS promedio
FROM cotizacion_dolar
GROUP BY anio;

-- Vista intermedia: extremos de fecha por año
CREATE VIEW v_fechas_extremas AS
SELECT 
    YEAR(fecha) AS anio, 
    MIN(fecha) AS primer_dia, 
    MAX(fecha) AS ultimo_dia 
FROM cotizacion_dolar
GROUP BY YEAR(fecha);

-- Vista intermedia: promedio anual base (usada por v_variacion_porcentual)
CREATE VIEW v_promedio_anual_base AS
SELECT YEAR(fecha) AS anio, ROUND(AVG(cotizacion),2) AS promedio_anual 
FROM cotizacion_dolar
GROUP BY YEAR(fecha);

-- Vista principal: cotización al inicio y fin de cada año
-- Depende de v_fechas_extremas
CREATE VIEW v_cotizacion_extremos AS
SELECT 
    fechas.anio,
    fechas.primer_dia,
    c_inicio.cotizacion AS cotizacion_inicial,
    fechas.ultimo_dia,
    c_fin.cotizacion AS cotizacion_final 
FROM v_fechas_extremas AS fechas
INNER JOIN cotizacion_dolar AS c_inicio ON fechas.primer_dia = c_inicio.fecha
INNER JOIN cotizacion_dolar AS c_fin ON fechas.ultimo_dia = c_fin.fecha;

-- Vista principal: variación porcentual año a año
-- Depende de v_promedio_anual_base
CREATE VIEW v_variacion_porcentual AS
SELECT 
    actual.anio AS anio_base, 
    actual.promedio_anual AS promedio_base,
    siguiente.anio AS anio_siguiente,
    siguiente.promedio_anual AS promedio_siguiente,
    ROUND((siguiente.promedio_anual - actual.promedio_anual)/actual.promedio_anual*100,2) AS porcentaje_variacion
FROM v_promedio_anual_base AS actual
INNER JOIN v_promedio_anual_base AS siguiente ON actual.anio = siguiente.anio - 1
ORDER BY actual.anio;
