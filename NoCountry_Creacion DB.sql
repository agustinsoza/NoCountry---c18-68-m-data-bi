--CRECION Y PUESTA EN USO DE LA BASE DE DATOS

DROP DATABASE NoCountry;

CREATE DATABASE NoCountry;

USE NoCountry;


-- CREACION TABLA AUXILIAR PARA CARGAR DATASET

CREATE TABLE aux_Encuestas (
	Edad INT,
	Desgaste VARCHAR(5),
	Tipo_Viaje VARCHAR(20),
	Tarifa_Diaria INT,
	Departamento VARCHAR(50),
	Distancia_Trabajo INT,
	Años_Estudio INT,
	Campo_Estudio VARCHAR(100),
	Contador_Empleado INT,
	id_Empleado INT,
	Satisfaccion_Ambiente INT,
	Genero VARCHAR(10),
	Tarifa_Hora INT,
	Participacion INT,
	Grado_Laboral INT,
	Rol_Trabajo VARCHAR(50),
	Satisfaccion_Laboral INT,
	Estado_Civil VARCHAR(15),
	Ingreso_Mensual INT,
	Tarifa_Mensual INT,
	Cant_Empresas INT,
	Mayor_18 VARCHAR(5),
	Horas_Extra VARCHAR(5),
	Porcentaje_Aumento INT,
	Rendimiento INT,
	Satisfaccion_Relacionamiento INT,
	Horas_Estandar INT,
	Opcion_Accionaria INT,
	Cant_Años_trabajados INT,
	Entrenamiento_Ultimo_Año INT,
	Balance_Vida_Trabajo INT,
	Cant_Años_Empresa INT,
	Cant_Años_Puesto INT,
	Cant_Años_Ultimo_Asc INT,
	Cant_Años_Mismo_Gerente INT
);

BULK INSERT aux_Encuestas
FROM 'C:\Users\Usuario\Documents\PROGRAMACION\TRABAJO\NoCountry - Simlacion Data BI\HR_atrittion.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Delimitador de campos
    ROWTERMINATOR = '\n',  -- Delimitador de filas
    FIRSTROW = 2           -- Si hay encabezado en el CSV, usa FIRSTROW = 2
);

--CREACION Y CARGA DE TABLAS PARA BASE DE DATOS

CREATE TABLE dim_Genero (
	id_Genero INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Genero VARCHAR(10)
);

CREATE TABLE dim_Educacion (
	id_Educacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Campo_Estudio VARCHAR(100)
);

CREATE TABLE dim_EstadoCivil (
	id_Estado_Civil INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Estado_Civil VARCHAR(15)
);

CREATE TABLE dim_Departamento (
	id_Departamento INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Departamento VARCHAR(50)
);

CREATE TABLE dim_Empleados (
	id_Empleado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_Genero INT,
	id_Educacion INT,
	id_Estado_Civil INT,
	Rango_Etario VARCHAR(15),
	CONSTRAINT id_Genero FOREIGN KEY (id_Genero) REFERENCES dim_Genero(id_Genero),
	CONSTRAINT id_Educacion FOREIGN KEY (id_Educacion) REFERENCES dim_Educacion(id_Educacion),
	CONSTRAINT id_Estado_Civil FOREIGN KEY (id_Estado_Civil) REFERENCES dim_EstadoCivil(id_Estado_Civil)
);

CREATE TABLE dim_RolTrabajo (
	id_Rol INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Rol_Trabajo VARCHAR(50),
	id_Departamento INT,
	CONSTRAINT id_Departamento FOREIGN KEY (id_Departamento) REFERENCES dim_Departamento(id_Departamento)
);

CREATE TABLE dim_Viajes (
	id_Tipo_Viaje INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Tipo_Viaje VARCHAR(20)
);

CREATE TABLE fact_Encuestas (
	id_Encuestas INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_Empleado INT,
	id_Rol INT,
	id_Tipo_Viaje INT,
	Satisfaccion_Ambiente INT,
	Satisfaccion_Laboral INT,
	Satisfaccion_Relacionamiento INT,
	Distancia_Trabajo INT,
	Balance_Vida_Trabajo INT,
	Grado_Laboral INT,
	Participacion INT,
	Rendimiento INT,
	Horas_Extra VARCHAR(5),
	Tarifa_Hora INT,
	Tarifa_Diaria INT,
	Ingreso_Mensual INT,
	Porcentaje_Aumento INT,
	Cant_Empresas INT,
	Cant_Años_Trabajados INT,
	Cant_Años_Empresa INT,
	Cant_Años_Puesto INT,
	Cant_Años_Ultimo_Asc INT,
	Cant_Años_Mismo_Gerente INT,
	Desgaste VARCHAR(5),
	CONSTRAINT id_Empleado FOREIGN KEY (id_Empleado) REFERENCES dim_Empleados(id_Empleado),
	CONSTRAINT id_Tipo_Viaje FOREIGN KEY (id_Tipo_Viaje) REFERENCES dim_Viajes(id_Tipo_Viaje),
	CONSTRAINT id_Rol FOREIGN KEY (id_Rol) REFERENCES dim_RolTrabajo(id_Rol)
);


INSERT INTO dim_Genero (Genero)
SELECT DISTINCT Genero FROM aux_Encuestas;

INSERT INTO dim_Educacion (Campo_Estudio)
SELECT DISTINCT Campo_Estudio FROM aux_Encuestas;

INSERT INTO dim_EstadoCivil (Estado_Civil)
SELECT DISTINCT Estado_Civil FROM aux_Encuestas;

INSERT INTO dim_Departamento (Departamento)
SELECT DISTINCT Departamento FROM aux_Encuestas;

INSERT INTO dim_Viajes (Tipo_Viaje)
SELECT DISTINCT Tipo_Viaje FROM aux_Encuestas;

SET IDENTITY_INSERT dim_Empleados ON;

INSERT INTO dim_Empleados (id_Empleado)
SELECT DISTINCT id_Empleado FROM aux_Encuestas;

SET IDENTITY_INSERT dim_Empleados OFF;

INSERT INTO dim_RolTrabajo (Rol_Trabajo)
SELECT DISTINCT Rol_Trabajo FROM aux_Encuestas;

UPDATE Em
SET Em.id_Genero = derivada.id_Genero,
	Em.id_Estado_Civil = derivada.id_Estado_Civil,
	Em.id_Educacion = derivada.id_Educacion,
	Em.Rango_Etario = derivada.Rango_Etario
FROM dim_Empleados Em
INNER JOIN (
    SELECT	En.id_Empleado,
			Ge.id_Genero, 
			Ec.id_Estado_Civil, 
			Ed.id_Educacion, 
			CASE
				WHEN En.Edad <= 30 THEN '18 a 30 años'
				WHEN En.Edad BETWEEN 31 AND 40 THEN '31 a 40 años'
				WHEN En.Edad BETWEEN 41 AND 50 THEN '41 a 50 años'
				WHEN En.Edad > 50 THEN 'Mayor a 50 años'
			END AS Rango_Etario
    FROM aux_Encuestas En
    INNER JOIN dim_Genero Ge ON En.Genero = Ge.Genero
	INNER JOIN dim_EstadoCivil Ec ON En.Estado_Civil = Ec.Estado_Civil
	INNER JOIN dim_Educacion Ed ON En.Campo_Estudio = Ed.Campo_Estudio
) AS derivada
ON Em.id_Empleado = derivada.id_Empleado;

UPDATE Rt
SET Rt.id_Departamento = derivada.id_Departamento
FROM dim_RolTrabajo Rt
INNER JOIN (
    SELECT	En.Rol_Trabajo,
			De.id_Departamento
    FROM aux_Encuestas En
    INNER JOIN dim_Departamento De ON En.Departamento = De.Departamento
) AS derivada
ON Rt.Rol_Trabajo = derivada.Rol_Trabajo;

INSERT INTO fact_Encuestas (id_Empleado)
SELECT id_Empleado FROM dim_Empleados ORDER BY id_Empleado;

UPDATE Enc
SET Enc.id_Rol = derivada.id_Rol,
	Enc.id_Tipo_Viaje = derivada.id_Tipo_Viaje,
	Enc.Satisfaccion_Ambiente = derivada.Satisfaccion_Ambiente,
	Enc.Satisfaccion_Laboral = derivada.Satisfaccion_Laboral,
	Enc.Satisfaccion_Relacionamiento = derivada.Satisfaccion_Relacionamiento,
	Enc.Distancia_Trabajo = derivada.Distancia_Trabajo,
	Enc.Balance_Vida_Trabajo = derivada.Balance_Vida_Trabajo,
	Enc.Grado_Laboral = derivada.Grado_Laboral,
	Enc.Participacion = derivada.Participacion,
	Enc.Rendimiento = derivada.Rendimiento,
	Enc.Horas_Extra = derivada.Horas_Extra,
	Enc.Tarifa_Hora = derivada.Tarifa_Hora,
	Enc.Tarifa_Diaria = derivada.Tarifa_Diaria,
	Enc.Ingreso_Mensual = derivada.Ingreso_Mensual,
	Enc.Porcentaje_Aumento = derivada.Porcentaje_Aumento,
	Enc.Cant_Empresas = derivada.Cant_Empresas,
	Enc.Cant_Años_Trabajados = derivada.Cant_Años_Trabajados,
	Enc.Cant_Años_Empresa = derivada.Cant_Años_Empresa,
	Enc.Cant_Años_Puesto = derivada.Cant_Años_Puesto,
	Enc.Cant_Años_Ultimo_Asc = derivada.Cant_Años_Ultimo_Asc,
	Enc.Cant_Años_Mismo_Gerente = derivada.Cant_Años_Mismo_Gerente,
	Enc.Desgaste = derivada.Desgaste
FROM fact_Encuestas Enc
INNER JOIN (
	SELECT	En.id_Empleado,
			RT.id_Rol,
			TV.id_Tipo_Viaje,
			En.Satisfaccion_Ambiente,
			En.Satisfaccion_Laboral,
			En.Satisfaccion_Relacionamiento,
			En.Distancia_Trabajo,
			En.Balance_Vida_Trabajo,
			En.Grado_Laboral,
			En.Participacion,
			En.Rendimiento,
			En.Horas_Extra,
			En.Tarifa_Hora,
			En.Tarifa_Diaria,
			En.Ingreso_Mensual,
			En.Porcentaje_Aumento,
			En.Cant_Empresas,
			En.Cant_Años_Trabajados,
			En.Cant_Años_Empresa,
			En.Cant_Años_Puesto,
			En.Cant_Años_Ultimo_Asc,
			En.Cant_Años_Mismo_Gerente,
			En.Desgaste
	FROM aux_Encuestas En
	INNER JOIN dim_RolTrabajo RT ON En.Rol_Trabajo = RT.Rol_Trabajo
	INNER JOIN dim_Viajes TV ON En.Tipo_Viaje = TV.Tipo_Viaje
) AS derivada
ON Enc.id_Empleado = derivada.id_Empleado;


SELECT * FROM fact_Encuestas;


