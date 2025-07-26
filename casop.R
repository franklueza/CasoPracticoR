# Directorio de trabajo
getwd()

# Instalando paquetes
install.packages(c("skimr", "janitor", "DataExplorer"))

# Llamando a librerias a usar
# Incluye readr, dplyr, ggplot2, entre otras

library(tidyverse)
library(skimr)

  
# Leyendo el archivo

titanic <- read.csv("Titanicv2.csv")

view(titanic)
head(titanic, 10)

# Renombrando algunas de las columnas del data frame
df_titanic <- rename(titanic, 
                     IdPasajero = PassengerId,
                     Sobreviviente = Survived,
                     Nivel_Socieconomico = Pclass,
                     Nombre = Name,
                     Sexo = Sex,
                     Edad = Age,
                     Tarifa = Fare,
                     Cabina = Cabin,
                     Embarcacion = Embarked
)

head(df_titanic)

view(df_titanic)


# Explorando los datos

str(df_titanic)  # Estructura de los datos
skim(df_titanic) # Resumen general del data frame
glimpse(df_titanic) # Nombres de las columnas y estructura

# Checando valores nulos

colSums(is.na(df_titanic)) # Conteo de valores nulos

summary(df_titanic) # Resumen estadístivo del data frame

# Analisis previo

# Puerto de embarque, con tres categorías únicas.
# Precio del ticket tiene solo un valor faltante, completitud del 99.8%
# Observamos que en Edad existe una dispersión importante de 14.2 respecto a 
# la media
# Cabina tiene 327 registros vacíos

# Los registros en la columna Edad existen 86 datos nulos 
# que representan el (86/418)*100 = 20.5441% de los datos
# Los datos de las cabinas ya previamente en el planteamiento del problema se 
# sabia que podia contener datos nulos



# Limpieza de los datos
# Columna Sobreviviente utilizaremos la funcion factor() para mejor manejo de 
# los datos categoricos

df_titanic$Sobreviviente <- factor(df_titanic$Sobreviviente, 
                                   levels = c("Yes", "No"))


# Miremos más de cerca la columna Edad a través de un histograma
df_titanic %>%
  ggplot(aes(x = Edad)) +
  geom_histogram()

# Vamos a imputar (rellenar) los valores faltante a través de la mediana

df_titanic$Edad[is.na(df_titanic$Edad)] <- median(df_titanic$Edad, na.rm = TRUE) 

colSums(is.na(df_titanic)) # Conteo de valores nulos nuevamente

df_titanic %>%
  ggplot(aes(x = Edad)) +
  geom_histogram()+
  labs(
    title = "Distribución de la Edad de los Pasajeros",
    x = "Edad",
    y = "Frecuencia"
  )

# Valor mínimo de la columna "Edad"
edad_min <- min(df_titanic$Edad)
print(edad_min)

# Valor máximo de la columna "Edad"
edad_max <- max(df_titanic$Edad)
print(edad_max)

# Crear un boxplot de la columna "Edad"

ggplot(df_titanic, aes(x = "", y = Edad)) +  # "" para un solo grupo
  geom_boxplot() +
  labs(
    title = "Distribución de la Edad de los Pasajeros",
    x = "",
    y = "Edad"
  ) 

# Proporción de sobrevivientes
table(df_titanic$Sobreviviente)

# Sobrevivientes por género
table(df_titanic$Sexo, df_titanic$Sobreviviente)

# Sobrevivientes por género
df_titanic %>% 
  ggplot(aes(x = Sexo, fill = Sobreviviente)) +
  geom_bar() +
  labs(title = "Recuento de Sobrevivientes por Género", x = "Género", y = "Recuento")


# Vamos a crear una tabla con los porcentajes de sobrevivientes

porcentaje_tabla <- df_titanic %>%
  group_by(Sexo, Sobreviviente) %>%
  summarise(count = n(), .groups = 'drop') %>%
  mutate(porcentaje = count / sum(count) * 100)

porcentaje_tabla

# Sexo   Sobreviviente count porcentaje
# female Yes             152       36.4
# male   No              266       63.6


#______________

# Relación entre edad y supervivencia

df_titanic %>% 
  ggplot(aes(x = Edad, fill = Sobreviviente)) +
  geom_histogram(binwidth = 5, position = "identity", alpha = 0.6) +
  labs(title = "Distribución de Edad y Supervivencia", x = "Edad", y = "Frecuencia")



# Filtrar solo a las mujeres
mujeres <- df_titanic %>%
  filter(Sexo == "female")

# Crear una tabla de contingencia para sobrevivientes y no sobrevivientes
recuento_mujeres <- table(mujeres$Sobreviviente)

# Mostrar el recuento
print(recuento_mujeres)

# Filtrar solo a los hombres
hombres <- df_titanic %>%
  filter(Sexo == "male")

# Crear una tabla de contingencia para sobrevivientes y no sobrevivientes
recuento_hombres <- table(hombres$Sobreviviente)

# Mostrar el recuento
print(recuento_hombres)

#______________


# Sobrevivientes por clase socioeconómica
table(df_titanic$Nivel_Socieconomico, df_titanic$Sobreviviente)

df_titanic %>% 
  ggplot(aes(x = Nivel_Socieconomico, fill = Sobreviviente)) +
  geom_bar() +
  labs(title = "Recuento de Sobrevivientes por Clase Socioeconómica", x = "Clase", y = "Recuento")

#df_titanic %>% 
#  ggplot(aes(x=Sobreviviente, fill = Nivel_Socieconomico )) +
#  geom_bar()

#             Yes  No
# Lower Clas    72 146
# Middle Class  30  63
# Upper Class   50  57

#_____________

# Tarifa vs Sobrevivientes
ggplot(df_titanic, aes(x = Tarifa, fill = Sobreviviente)) +
  geom_density(alpha = 0.6) +
  labs(
    title = "Relación entre Tarifas y Supervivencia",
    x = "Tarifa",
    y = "Densidad")

# Se observa que las personas que pagaron una tarifa más alta tuvieron mayor 
# probabilidad de sobrevivir


#__________

# Edades de las personas que sobrevivieron y su clase

sobrevivientes <- df_titanic %>% 
  filter(Sobreviviente=="Yes") %>% 
  select(Edad, Nivel_Socieconomico)

sobrevivientes

sobrevivientes %>% 
  ggplot(aes(x = Nivel_Socieconomico, y = Edad, fill = Nivel_Socieconomico)) +
  geom_boxplot() +
  labs(title = "Distribución de Edades de Sobrevivientes por Clase", x = "Clase", y = "Edad")
#________
# Crear una tabla con los conteos y porcentajes
datos_nivel_socioeconomico <- df_titanic %>%
  group_by(Nivel_Socieconomico, Sobreviviente) %>%
  summarise(count = n(), .groups = 'drop') %>%
  group_by(Nivel_Socieconomico) %>%
  mutate(porcentaje = count / sum(count) * 100)
datos_nivel_socioeconomico
# Convertir a data frame
datos_nivel_socioeconomico <- as.data.frame(datos_nivel_socioeconomico)

# Crear el gráfico de barras apiladas con porcentajes
ggplot(datos_nivel_socioeconomico, aes(x = Nivel_Socieconomico, y = count, fill = Sobreviviente)) +
  geom_bar(stat = "identity", position = "fill") + # Barras apiladas como proporciones
  geom_text(aes(label = paste0(round(porcentaje, 1), "%")), 
            position = position_fill(vjust = 0.5), size = 3) + # Agregar porcentajes
  labs(
    title = "Proporción de Sobrevivientes por Clase Socioeconómica",
    x = "Clase Socioeconómica",
    y = "Proporción"
  ) +
  scale_y_continuous(labels = scales::percent_format()) + # Formato de porcentaje en el eje Y
  theme_minimal() +
  theme(
    legend.position = "top", # Posición de la leyenda
    plot.title = element_text(hjust = 0.5) # Centrar el título
  )

#_________

# Sobrevivientes por puerto de embarque
table(df_titanic$Embarcacion, df_titanic$Sobreviviente)


# Calcular porcentajes (no globales) dentro de cada embarque
datos_embarcacion <- df_titanic %>%
  group_by(Embarcacion, Sobreviviente) %>%
  summarise(count = n(), .groups = 'drop') %>%
  group_by(Embarcacion) %>%
  mutate(porcentaje = count / sum(count) * 100)

# Mostrar los resultados
print(datos_embarcacion)


# Convertir a data frame
datos_embarcacion <- datos_embarcacion %>%
  as.data.frame()

print(datos_embarcacion)

grafico_embarcacion <- ggplot(datos_embarcacion, aes(x = Embarcacion, y = porcentaje, fill = Sobreviviente)) +
  geom_bar(stat = "identity", position = "fill") +
  geom_text(aes(label = paste0(round(porcentaje, 1), "%")), 
            position = position_fill(vjust = 0.5), size = 3) +
  labs(
    title = "Proporción de Sobrevivientes por Lugar de Embarcación",
    x = "Lugar de Embarcación",
    y = "Porcentaje"
  ) +
  scale_y_continuous(labels = scales::percent_format()) +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(hjust = 0.5)
  )

print(grafico_embarcacion)


# Matriz de correlación
cor_matrix <- cor(df_titanic[, c("Edad", "Tarifa", "SibSp", "Parch")], use = "complete.obs")
cor_matrix

# No se observa alguna relación significativa entre la edad y el número de 
#hermanos/cónyuges o padres/hijos a bordo 

#_____________

# Grupos de edad que sobrevivieron

df_titanic <- df_titanic %>%
  mutate(GrupoEdad = case_when(
    Edad < 18 ~ "Niño",
    Edad >= 18 & Edad < 65 ~ "Adulto",
    TRUE ~ "Anciano"
  ))

view(df_titanic)

#Proporcion de sobrevivencia por grupo de edad

prop_edad_supervivencia <- df_titanic %>%
  group_by(GrupoEdad, Sobreviviente) %>%
  summarise(count = n(), .groups = 'drop') %>%
  group_by(GrupoEdad) %>%
  mutate(porcentaje = count / sum(count) * 100)

print(prop_edad_supervivencia)

# Convertir a data frame
prop_edad_supervivencia <- prop_edad_supervivencia %>%
  as.data.frame()
prop_edad_supervivencia

ggplot(prop_edad_supervivencia, aes(x = GrupoEdad, y = porcentaje, fill = Sobreviviente)) +
  geom_bar(stat = "identity", position = "fill") +
  geom_text(aes(label = paste0(round(porcentaje, 1), "%")), 
            position = position_fill(vjust = 0.5), size = 3) +
  labs(
    title = "Proporción de Sobrevivientes por Grupo de Edad",
    x = "Grupo de Edad",
    y = "Porcentaje"
  ) +
  scale_y_continuous(labels = scales::percent_format())
  