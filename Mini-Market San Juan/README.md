# Mini Market Dashboard

**Autor:** Carlos Bernal  
**Objetivo:** Proyecto de análisis de ventas de un mini market, usando Power BI para mostrar resumen mensual y comparativa mes a mes.

---

## Descripción del proyecto
El proyecto analiza ventas de un mini market incluyendo:
- Evolución mensual de ingresos.
- Comparativa mes a mes.
- Ingresos por producto.

El dataset contiene ventas de septiembre y octubre de 2025.

---

## Medidas y cálculos

- **Diferencia de Stock:**  
  Calculo para observar necesidad de reposición de stock.
   ```DAX
   Diferencia de stock =
   SUM(Inventario[stock_actual]) - SUM(Inventario[stock_minimo])

- **Productos bajo Stock Mínimo:**  
  Productos con necesidad de reposición inmediata de stock.
  ```DAX
  Productos bajo stock mínimo =
  CALCULATE(
    COUNTROWS(Inventario),
    FILTER(
        Inventario,
        Inventario[stock_actual] < Inventario[stock_minimo]
    )
  )

- **Productos sin Ventas:**  
  Productos sin movimiento en el local.
  ```DAX
  Productos sin ventas = 
  CALCULATE(
    COUNTROWS(Inventario),
    FILTER(
        Inventario,
        ISBLANK([Ingresos Totales]) || [Ingresos Totales] = 0
    )
  )

- **Ingresos Totales:**  
  Suma de unidades vendidas multiplicadas por el precio de venta.  
  ```DAX
  Ingresos Totales =
  CALCULATE(
      SUMX(
          Ventas,
          Ventas[unidades_vendidas] * RELATED(Inventario[precio_venta])
      ),
      ALLSELECTED(Calendario[Date])
  )
- **Ingresos mes Anterior:**  
  Suma de unidades vendidas multiplicadas por el precio de venta del mes de septiembre.  
  ```DAX
  Ingresos Mes Anterior =
  CALCULATE(
    SUMX(
        Ventas,
        Ventas[unidades_vendidas] * RELATED(Inventario[precio_venta])
    ),
    FILTER(
        ALL(Ventas),
        MONTH(Ventas[fecha]) = 9
    )
  )
- **Variación Mensual:**  
  El calculo de la variación de las ventas mensuales.  
  ```DAX
  Variación Mensual = [Ingresos Totales] - [Ingresos Mes Anterior]

- **Variación en Porcentaje:**  
  Porcentaje de la variación de las ventas mensuales.  
  ```DAX
  Variación % =
  DIVIDE(
    [Variación Mensual],
    [Ingresos Mes Anterior]
  )

## Visuales

### Resumen Mensual
- Tarjetas KPI: ingresos totales, diferencia de stock, productos bajo stock mínimo, productos sin ventas.
- Segementador de datos: filtros por producto y por mes.
- Gráficos de Barras: Ingresos totales por producto, frecuencia de compra de los clientes, Stock Actual vs Stock Mínimo.
- Tabla de detalle: Productos y ingresos totales.

### Comparativa mes a mes
- Gráfico de líneas: evolución de ingresos por mes.
- Tarjetas KPI: ingresos totales y variación mensual.
- Tabla de detalle: unidades vendidas y ingresos por producto con sus fechas.
- Segementador de datos: filtros por fecha y año.


## Conclusiones
- Los productos con más ingresos son el Queso y La Gaseosa de 2L.
- La variación mensual muestra que octubre superó a septiembre.
- Se identificaron productos con necesidad de reposición de stock mínimo y productos sin ventas, lo que permite optimizar inventario.
- El dashboard permite identificar tendencias de ventas y productos clave para la toma de decisiones, integrando información de ventas e inventario.

## Notas
- El dataset solo incluye septiembre y octubre.
- La medida de Mes Anterior se calculó manualmente para este dataset pequeño.
- Todas las medidas respetan filtros aplicados en los visuales.
