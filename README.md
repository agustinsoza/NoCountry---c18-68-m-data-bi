# **Análisis de retención de empleados y reconocimiento de desempeño de la empresa Generic Drug Research & Development**


La empresa Generic Drug Research & Development quiere adoptar un enfoque integral que valore el bienestar, el compromiso y el desarrollo de sus empleados, e ir más allá de la simple retención de sus colaboradores y crear un ambiente laboral próspero que impulse su productividad.

A menudo las empresas se quedan cortas en sus esfuerzos por retener a sus empleados. Si bien la compensación económica es un factor importante para la retención de los colaboradores, existen estudios recientes que han demostrado que las empresas que no profundizan en el análisis del ambiente laboral y se enfocan únicamente en aspectos salariales son las mismas empresa donde sus colaboradores tienen mayor tendencia a abandonar sus puestos de trabajo por razones que no están relacionadas con el salario, como la falta de compromiso, la mala comunicación y la insatisfacción con su jefe o con la cultura de la empresa.

El objetivo de este estudio es:  **Comprender los factores que influyen en el Attrition de los colaboradores de la empresa Generic Drug Research & Development.**

Nuestro equipo sera el encargado de analizar el conjunto de datos proporcionado por la empresa para identificar patrones y tendencias a traves de las siguientes tecnologias.



## NUESTRO EQUIPO

**Agustin Soza**

**Rol:** Analista BI / Analista de datos

LinkedIn: www.linkedin.com/in/agustinsoza

**Cecilia Aponte**

**Rol:** Analista de datos

LinkedIn: www.linkedin.com/in/ceci-aponte-data

## Tecnologias utilizadas

![tecnologias](https://github.com/agustinsoza/NoCountry---c18-68-m-data-bi/blob/main/imagentecnologias.png)

## Data

Se realizo la busqueda  de la data en la plataforma Kaggle, especificamente se utilizo el siguiente dataset:

[Dataset](https://www.kaggle.com/datasets/murugeshm1/hremployeeattritions-dataset)


Para identificar los factores que influyen en el Attrition de los colaboradores y desarrollar estrategias de retención efectivas, la empresa recopilo una variedad de datos. 
Estos datos los podemos categorizar, según la naturaleza y relevancia para los distintos aspectos de nuestro análisis laboral, de la siguiente manera:


![Clasificacion](https://github.com/agustinsoza/NoCountry---c18-68-m-data-bi/blob/main/ImagenClasificacion.png)

## Revisión y validación del datos

El análisis exploratorio de datos es una etapa crucial en el proyecto de análisis de datos, especialmente cuando se busca entender y mitigar el Attrition laboral.
Este proceso implica varias tareas importantes:

*   Manipular valores faltantes (en caso de encontrarlos) ya que pueden sesgar los resultados del análisis,
*   calcularemos medidas de tendencia central y dispersión generando una visión general de la distribución de los datos,
*   analizaremos correlaciones entre variables, esto evaluar el efecto de las variables en la probabilidad de que ocurra el desgaste (Attrition) de puestos que tanto preocupa a nuestro cliente, 
*   codificaremos las variables categóricas, estas deben ser transformadas en un formato numérico para que puedan ser utilizadas en modelos de análisis y predicción, y buscaremos normalizar las variables numéricas de ser necesario.

**Entorno de trabajo: Python3**

En primer lugar se realizó la importación de las librerías, cargamos los datos en un DataFrame de Pandas, para obtener la información general sobre el conjunto de datos(dimensiones, tipos de datos y presencia de valores faltantes). Identificaremos las variables categóricas y numéricas.

Librerias utilizadas: 

* Pandas 
* Statsmodels.api 
* Numpy 
* Matplotlib.pyplot
* LogisticRegression
* Classification_report
* Confusion_matrix
* Seaborn as sns


# Creacion de Modelo Entidad-Relación

A partir del Dataset proporcionado por nuestro cliente, y realizada la revisión y validació de los datos, se diseñó un Modelo Entidad-Relación. 
El objetivo principal es transformar un dataset en una base de datos Entidad-Relación bien estructurada, lo que te permitirá realizar análisis detallados sobre los factores que influyen en el Attrition de los colaboradores. 

Teniendo en cuenta que el Attrition puede tener un impacto significativo en las finanzas de la empresa, ya que implica pérdida de productividad, se identificaron las preguntas clave que deben responderse. 
 

1.  ¿Qué factores están relacionados con el Desgaste?
2.  ¿Existe alguna variación en el Desgaste según el nivel educativo de los colaboradores?
3.  ¿Cuál es el nivel de satisfacción de mis colaboradores?
4.  ¿Cuál es el nivel de attrition para los colaboradores que trabajan en la empresa tiempo mayor dentro la empresa?
5.  ¿ Es el salario el factor determinante para que un colaborador baje la productividad?
6. ¿Cómo varía el desgaste según las clasificaciones de rendimiento de los empleados?


## Modelo

El [Modelo]consta de ocho entidades:

![Modelo](https://github.com/agustinsoza/NoCountry---c18-68-m-data-bi/blob/main/Modelo_ER_NoCountry.png)

1. Entidad Genero
Almacena el genero del colaborador.

1. Entidad Nivel Educativo

Atributo que almacena es el campo de estudio.

3. Entidad Estado Civil

Almacena el estado civil del colaborador.

4. Entidad Empleado

Se generó un identificdor por colaborador y se ingresa a cada uno en un rago defenido de edad.

5. Entidad Entrevista

Almacenan diferentes aspectos evaluados en las encuestas, incluyendo satisfacción con el ambiente, carga de trabajo, relación con el supervisor.

6. Entidad Rol

Almacena el nombre del cargo del colaborador 

7. Entidad Departamento

Almacena el nombre del departamento al que esta asignado el colaborador.

8. Entidad Viajes

Almacena la frecuencia con la que viajan por negocios los colaboradores.



# Visualización

## Consultas realizadas

(https://www.gallup.com/394373/indicator-employee-engagement.aspx)

(https://www.workhuman.com/topics/retention-and-turnover/)

(https://www.pwc.com/us/en/products/listen-platform/employee-experience-guide.html)

https://docs.python.org/es/3.10/ 

https://docs.python.org/es/3/library/importlib.html#module-importlib   

https://www.ibm.com/es-es/topics/exploratory-data-analysis 

https://repositorio.utdt.edu/handle/20.500.13098/11151 

https://digibug.ugr.es/handle/10481/52019 

Tamayo Contreras, P. Percepción y satisfacción laboral como precursores de rotación de personal. Granada: Universidad de Granada, 2016. [http://hdl.handle.net/10481/42600]
