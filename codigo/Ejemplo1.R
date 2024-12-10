# Ejemplo de RDD: Impacto de un programa de transferencias condicionadas
# La running variable es el índice de pobreza (0-100)
# El cutoff es 40 (hogares con índice < 40 reciben el programa)
# Outcome: Asistencia escolar de niños (%)

# Cargar librerías necesarias
library(tidyverse)
library(rdrobust)
library(rddensity)
library(ggplot2)

# Generar datos simulados
set.seed(123)
n <- 1000

# Generar running variable (índice de pobreza)
X <- runif(n, min = 0, max = 80)

# Generar el tratamiento (1 si índice < 40)
cutoff <- 40
D <- as.numeric(X < cutoff)

# Generar el outcome con un efecto del tratamiento
# Añadimos algo de ruido para hacerlo más realista
Y <- 65 + # línea base de asistencia escolar
  10 * D + # efecto del tratamiento
  0.3 * (X - cutoff) + # tendencia en X
  D * 0.2 * (X - cutoff) + # permite diferente pendiente post-tratamiento
  rnorm(n, 0, 5) # término de error

# Crear el dataset
data <- data.frame(
  indice_pobreza = X,
  tratamiento = D,
  asistencia_escolar = Y
)

# Visualización básica
ggplot(data, aes(x = indice_pobreza, y = asistencia_escolar)) +
  geom_point(alpha = 0.4) +
  geom_vline(xintercept = cutoff, linetype = "dashed", color = "red") +
  labs(
    title = "RDD: Impacto del Programa de Transferencias en Asistencia Escolar",
    x = "Índice de Pobreza",
    y = "Tasa de Asistencia Escolar (%)"
  ) +
  theme_minimal()

# Análisis RDD básico
rdd_result <- rdrobust(y = data$asistencia_escolar, 
                       x = data$indice_pobreza, 
                       c = cutoff)

# Imprimir resultados
summary(rdd_result)

# Test de manipulación (McCrary test)
density_test <- rddensity(X = data$indice_pobreza, c = cutoff)
summary(density_test)

# Análisis de sensibilidad con diferentes bandwidths
sensibilidad <- rdrobust(y = data$asistencia_escolar, 
                         x = data$indice_pobreza, 
                         c = cutoff,
                         bwselect = "mserd")

# Gráfico más elaborado con ajuste local
ggplot(data, aes(x = indice_pobreza, y = asistencia_escolar)) +
  geom_point(alpha = 0.4, size = 1) +
  geom_smooth(data = subset(data, indice_pobreza < cutoff),
              method = "loess", se = TRUE, color = "blue") +
  geom_smooth(data = subset(data, indice_pobreza >= cutoff),
              method = "loess", se = TRUE, color = "red") +
  geom_vline(xintercept = cutoff, linetype = "dashed") +
  labs(
    title = "RDD: Efecto del Programa en la Asistencia Escolar",
    subtitle = "Ajuste local a ambos lados del cutoff",
    x = "Índice de Pobreza",
    y = "Tasa de Asistencia Escolar (%)"
  ) +
  theme_minimal() +
  annotate("text", x = 20, y = 85, 
           label = "Hogares que reciben\nel programa", 
           color = "blue") +
  annotate("text", x = 60, y = 85, 
           label = "Hogares que no reciben\nel programa", 
           color = "red")

# Análisis de robustez: placebo tests
# Generamos cutoffs falsos
placebo_cutoffs <- c(30, 35, 45, 50)
placebo_results <- lapply(placebo_cutoffs, function(c) {
  rdrobust(y = data$asistencia_escolar, 
           x = data$indice_pobreza, 
           c = c)$coef[1]
})

# Función para crear bins óptimos para el gráfico RD
create_bins <- function(x, y, cutoff, bins = 30) {
  left <- x[x < cutoff]
  right <- x[x >= cutoff]
  
  bins_left <- cut(left, breaks = bins/2, labels = FALSE)
  bins_right <- cut(right, breaks = bins/2, labels = FALSE)
  
  left_means <- tapply(y[x < cutoff], bins_left, mean)
  right_means <- tapply(y[x >= cutoff], bins_right, mean)
  
  left_x <- tapply(x[x < cutoff], bins_left, mean)
  right_x <- tapply(x[x >= cutoff], bins_right, mean)
  
  return(list(
    x = c(left_x, right_x),
    y = c(left_means, right_means)
  ))
}

# Crear bins y graficar
binned_data <- create_bins(data$indice_pobreza, data$asistencia_escolar, cutoff)

# Gráfico final con bins
ggplot() +
  geom_point(data = data.frame(x = binned_data$x, y = binned_data$y),
             aes(x = x, y = y), size = 3) +
  geom_smooth(data = subset(data, indice_pobreza < cutoff),
              aes(x = indice_pobreza, y = asistencia_escolar),
              method = "lm", se = TRUE, color = "blue") +
  geom_smooth(data = subset(data, indice_pobreza >= cutoff),
              aes(x = indice_pobreza, y = asistencia_escolar),
              method = "lm", se = TRUE, color = "red") +
  geom_vline(xintercept = cutoff, linetype = "dashed") +
  labs(
    title = "RDD: Efecto del Programa en la Asistencia Escolar",
    subtitle = "Promedios por bin con ajuste lineal",
    x = "Índice de Pobreza",
    y = "Tasa de Asistencia Escolar (%)"
  ) +
  theme_minimal()

