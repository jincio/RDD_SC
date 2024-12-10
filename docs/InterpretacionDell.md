# Análisis de RD en el Estudio de la Mita Minera

## Diseño de la Investigación

Dell utiliza un diseño de regresión discontinua (RD) para estudiar los efectos de largo plazo de la mita, un sistema de trabajo forzado que operó en Perú y Bolivia entre 1573 y 1812. El diseño de RD aprovecha una discontinuidad geográfica clara: algunas comunidades fueron obligadas a contribuir con trabajadores para la mita mientras que otras comunidades adyacentes fueron exentas.

## Implementación del RD

### Variables Clave
- **Running variable**: Ubicación geográfica (latitud y longitud)
- **Cutoff**: El límite geográfico de la mita
- **Outcomes**: Consumo de hogares, desnutrición infantil, educación, infraestructura vial

### Especificación Econométrica

Dell emplea tres especificaciones principales:

1. Polinomio cúbico en latitud y longitud
2. Polinomio cúbico en distancia a Potosí
3. Polinomio cúbico en distancia al límite de la mita

La ecuación base es:

cidb = α + γmitad + X'idβ + f(ubicación geográficad) + φb + εidb

donde:
- cidb: variable de resultado 
- mitad: indicador de tratamiento
- f(ubicación geográficad): polinomio RD
- φb: efectos fijos por segmento de frontera

### Validación del Diseño

Dell demuestra que:
- Las características geográficas son similares a ambos lados del límite
- No hay diferencias significativas en variables pre-tratamiento
- Las tasas tributarias y demografía eran similares antes de la mita

## Resultados Principales

El análisis RD encuentra que la mita tiene efectos negativos persistentes:

- Reduce el consumo actual de hogares en ~25%
- Aumenta la desnutrición infantil en 6 puntos porcentuales
- Menor presencia de haciendas históricamente
- Menor desarrollo de infraestructura vial

## Innovaciones Metodológicas

1. **RD Multidimensional**: Desarrolla métodos para RD con running variable en dos dimensiones (latitud/longitud)

2. **Múltiples Especificaciones**: Usa tres especificaciones diferentes del polinomio RD para demostrar robustez

3. **Validación Histórica**: Complementa el análisis cuantitativo con evidencia histórica detallada sobre el mecanismo de asignación de la mita

## Limitaciones Reconocidas

- Tamaño de muestra limitado para algunas especificaciones flexibles
- Posible migración histórica selectiva
- Dificultad para separar efectos directos vs. indirectos

# Interpretación de la Tabla II: Efectos de la Mita en Estándares de Vida

## Estructura de la Tabla

La Tabla II presenta los resultados principales en dos bloques:
1. Consumo del hogar (columnas 1-3)
2. Desnutrición infantil (columnas 4-7)

## Variables Dependientes

1. **Log Equivalent Household Consumption (2001)**
   - Logaritmo del consumo del hogar ajustado
   - Medida principal de bienestar económico

2. **Stunted Growth, Children 6-9 (2005)**
   - Variable binaria de desnutrición infantil
   - Indica si el niño tiene retraso en el crecimiento

## Especificaciones

La tabla presenta tres paneles con diferentes especificaciones del polinomio RD:
- Panel A: Polinomio cúbico en latitud y longitud
- Panel B: Polinomio cúbico en distancia a Potosí
- Panel C: Polinomio cúbico en distancia al límite de la mita

## Resultados Principales

### Consumo del Hogar
- En el Panel B, columna 1: coeficiente de -0.337
- Interpretación: La mita reduce el consumo del hogar en aproximadamente 33.7%
- Estadísticamente significativo al 1% (tres asteriscos)
- El efecto es robusto a diferentes especificaciones y muestras

### Desnutrición Infantil
- En el Panel B, columna 4: coeficiente de 0.080
- Interpretación: La mita aumenta la probabilidad de desnutrición en 8 puntos porcentuales
- Estadísticamente significativo al 1%
- El efecto persiste en diferentes especificaciones

## Robustez de los Resultados

- Los resultados son consistentes a través de diferentes:
  1. Tamaños de muestra (100km, 75km, 50km del límite)
  2. Especificaciones del polinomio RD
  3. Controles geográficos y efectos fijos

## Importancia de los Resultados

- Demuestran efectos persistentes y significativos de la mita
- Los efectos son económicamente grandes
- Los resultados son robustos a múltiples especificaciones
- Evidencia clara de la persistencia de instituciones históricas

## Notas sobre Interpretación

1. Los errores estándar están en paréntesis
2. La significancia estadística se indica con asteriscos:
   - * = 10%
   - ** = 5%
   - *** = 1%
3. Los resultados incluyen controles geográficos y efectos fijos por segmento de frontera

Los resultados del Panel A (polinomio cúbico en longitud y latitud) no son un placebo - son una especificación alternativa válida del RDD. De hecho, Dell explica en el paper por qué estos resultados son diferentes y menos precisos:

1. **Poder Estadístico**: La encuesta de hogares tiene una muestra relativamente pequeña (solo muestrea alrededor de un cuarto de los distritos) y hay error de medición en la variable dependiente. Esto hace que sea difícil estimar con precisión una especificación tan flexible como el polinomio cúbico en longitud-latitud.

2. **Flexibilidad vs Precisión**: El polinomio en longitud-latitud es la especificación más flexible de las tres, lo que significa que:
   - Tiene más grados de libertad
   - Requiere estimar más parámetros
   - Necesita más datos para obtener estimaciones precisas
# Especificaciones Cúbicas en el RDD

## 1. Polinomio Cúbico en Latitud y Longitud (Panel A)

La ecuación base es:

cidb = α + γmitad + f(longitudd, latitudd) + X'idβ + φb + εidb

donde f(longitudd, latitudd) es un polinomio cúbico que incluye:

f(long, lat) = β₁long + β₂lat + β₃long² + β₄lat² + β₅(long×lat) + β₆long³ + β₇lat³ + β₈(long²×lat) + β₉(long×lat²)

Esta especificación:
- Tiene 9 términos en el polinomio
- Permite interacciones entre longitud y latitud
- Es la más flexible de las tres especificaciones

## 2. Polinomio Cúbico en Distancia a Potosí (Panel B)

La ecuación simplifica a una dimensión:

cidb = α + γmitad + f(distancia_Potosíd) + X'idβ + φb + εidb

donde f(distancia_Potosíd) es:

f(dist) = β₁dist + β₂dist² + β₃dist³

Esta especificación:
- Tiene solo 3 términos en el polinomio
- Es más parsimoniosa
- Se basa en la importancia histórica de la distancia a Potosí

## 3. Polinomio Cúbico en Distancia al Límite de la Mita (Panel C)

Similar al Panel B pero usando distancia al límite:

cidb = α + γmitad + f(distancia_límited) + X'idβ + φb + εidb

donde f(distancia_límited) es:

f(dist_lim) = β₁dist_lim + β₂dist_lim² + β₃dist_lim³

#### Comparación de Especificaciones

1. **Complejidad**:
   - Panel A: 9 términos
   - Panel B: 3 términos
   - Panel C: 3 términos

2. **Poder Estadístico**:
   - Panel A: Requiere más observaciones para precisión
   - Paneles B y C: Más precisos con muestras pequeñas

3. **Flexibilidad**:
   - Panel A: Más flexible, captura patrones espaciales complejos
   - Paneles B y C: Más restrictivos pero más precisos

## Notas Importantes

1. Todas las especificaciones incluyen:
   - Controles geográficos (X'idβ)
   - Efectos fijos por segmento de frontera (φb)
   - Error estándar robusto (εidb)

2. La elección entre especificaciones implica un trade-off entre:
   - Flexibilidad para capturar patrones espaciales
   - Precisión estadística
   - Parsimonia del modelo
3. **Trade-off en el RDD**: Hay un trade-off importante entre:
   - Tener una especificación muy flexible que capture bien la variación suave en el espacio
   - Tener suficiente poder estadístico para detectar la discontinuidad

4. **Magnitud Similar**: Es importante notar que aunque los coeficientes en el Panel A no son estadísticamente significativos, su magnitud es similar a los otros paneles. Por ejemplo, para el consumo:
   - Panel A: -0.284
   - Panel B: -0.337
   - Panel C: -0.277

5. **Evidencia Complementaria**: Dell usa los datos de desnutrición infantil (que tienen una muestra mucho más grande) como comprobación adicional. Con estos datos, incluso la especificación más flexible (Panel A) encuentra efectos significativos.

Por lo tanto, la falta de significancia estadística en el Panel A parece ser más un problema de poder estadístico que una indicación de que no hay efecto. La evidencia en su conjunto, considerando todas las especificaciones y conjuntos de datos, apunta consistentemente a un efecto negativo de la mita.

## Conclusión

El uso innovador de RD permite a Dell establecer una relación causal convincente entre la mita colonial y el subdesarrollo actual, proporcionando evidencia sobre la persistencia de instituciones históricas.