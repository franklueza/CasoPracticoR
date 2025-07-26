# CasoPracticoR
## Objetivo
Realiza un análisis exploratorio en R, del conjunto de datos Titanic para comprender mejor qué características (por ejemplo, edad, nivel socioeconómico, costo de ticket, puerto de
embarcación, etcétera) tienen los pasajeros que sobrevivieron o no sobrevivieron al evento. Una vez finalizado el análisis, en un documento pdf comparte un resumen no mayor a 2
párrafos con tus descubrimientos más importantes.  

### Detalle de las columnas
- PassangerId: Identificador único del pasajero.
- Survived: Indicada si el pasajero sobrevivió o no (Yes, No).
- Pclass: Nivel socioeconómico (Upper Class, Middle Class, Lower Class).
- Name: Nombredel pasajero.
- Sex: Género del pasajero.
- Age: Edaddel pasajero.
- SibSp: Número total de herman@s y espos@s del pasajero.
- Parch: Número total de padres e hijos del pasajero.
- Ticket: Número de ticket del pasajero.
- Fare: Costo del ticket.
- Cabin: Número de cabina del pasajero (puede contener carácteres vacíos).
- Embarked: Puerto de embarcación del pasajero

### Análisis
El análisis realizado sobre el dataset Titanicv2.csv revela información clave sobre los pasajeros y sus probabilidades de supervivencia. A continuación, se presenta un resumen completo de los hallazgos:  

1. Dataset
- Número total de registros: 418 pasajeros.
- Variables principales: IdPasajero, Sobreviviente, Nivel_Socieconomico, Nombre, Sexo, Edad, Tarifa, Cabina, Embarcacion.
- Valores faltantes:
- Edad: 86 valores faltantes (20.57%).
- Cabina: 327 valores faltantes (~78.23%).
- Tarifa: 1 valor faltante (~0.24%).
2. Dsitribución de sobrevivientes y por género  
- Total de sobrevivientes (Yes): 152 (36.4%).  
- Total de no sobrevivientes (No): 266 (63.6%).  
Distribución por Género  
- Mujeres (female):  
- Sobrevivieron: 152 (100% de las mujeres).   
No sobrevivieron: 0  
- Hombres (male):  
Sobrevivieron: 0 (0% de los hombres).    
No sobrevivieron: 266 (100%).  
3. Distribución por edad  
- Rango de edades: 0.17 a 76 años.  
- Mediana de edad: 27 años (usada para imputar valores faltantes).  
- Grupos de edad:  
- Niños (< 18 años):  
Sobrevivieron: 41.46%.  
No sobrevivieron: 58.53%.  
- Adultos (18–65 años):  
Sobrevivieron: 35.73%.  
No sobrevivieron: 64.26%.  
- Ancianos (≥ 65 años):  
Sobrevivieron: 50%.  
No sobrevivieron: 50%.  
4. Relación entra variables  
Clase Socioeconómica y Supervivencia  
- Primera clase:
Sobrevivieron: 50 (46.7%).  
No sobrevivieron: 57 (53.3%).
- Segunda clase:  
Sobrevivieron: 30 (32.3%).  
No sobrevivieron: 63 (67.7%).  
- Tercera clase:
Sobrevivieron: 72 (33.00%).  
No sobrevivieron: 146 (67.00%).
5. Tarifa y Supervivencia  
Las personas que pagaron tarifas más altas tuvieron una mayor probabilidad de sobrevivir.
6. Puerto de Embarque y Supervivencia
- Cherbourg
Sobrevivieron: 40 (39.21%).   
No sobrevivieron: 62 (60.78%).  
- Queenstown
Sobrevivieron: 24 (52.17%).  
No sobrevivieron: 22 (47.8%).  
- Southampton  
Sobrevivieron: 88 (32.59%).  
No sobrevivieron: 182 (67.40%).  
7. Gáficos
![Análisis TiTanic.](https://github.com/franklueza/CasoPracticoR/blob/6c9b30e63cee3516a5aa92f264bdcbae5d4fbf36/ConjuntoGraficas.png)
##Conclusiones  
El análisis exploratorio del conjunto de datos del Titanic revela patrones significativos en las características de los pasajeros que influyeron en su probabilidad de supervivencia. En primer lugar, el género fue el factor más determinante: todas las mujeres a bordo sobrevivieron, mientras que ningún hombre logró hacerlo. Además, la clase socioeconómica jugó un papel crucial, con pasajeros de primera clase mostrando las mayores tasas de supervivencia (46.7%), seguidos por aquellos de segunda clase (32.3%) y tercera clase (33.0%). Este patrón refuerza la idea de que el acceso prioritario a los botes salvavidas estuvo influenciado por el estatus socioeconómico.

En cuanto a la edad, los adultos (18–65 años) representaron la mayoría de los sobrevivientes (35.73%), aunque los niños (< 18 años) también mostraron una tasa considerable de supervivencia (41.46%). Sorprendentemente, los ancianos (≥ 65 años) tuvieron una tasa de supervivencia del 50%, lo que sugiere que, aunque su número era reducido, algunos lograron sobrevivir. Por último, el puerto de embarque también mostró diferencias notables: Queenstown registró la mayor proporción de sobrevivientes (52.2%), seguido por Cherbourg (39.2%) y Southampton (32.6%). Estos hallazgos subrayan cómo factores como género, clase socioeconómica, edad y ubicación de embarque definieron las posibilidades de supervivencia en esta tragedia.
  
