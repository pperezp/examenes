CREATE DATABASE examenes;

USE examenes;

CREATE TABLE ramo(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    PRIMARY KEY(id)
);

CREATE TABLE examen(
    id INT AUTO_INCREMENT,
    fecha DATETIME,
    ramo INT,
    detalle VARCHAR(100),
    PRIMARY KEY(id),
    FOREIGN KEY(ramo) REFERENCES ramo(id)
);

CREATE TABLE info(
    id INT AUTO_INCREMENT,
    user_agent VARCHAR(200),
    remote_addr VARCHAR(100),
    request_method VARCHAR(100),
    query_string VARCHAR(100),
    fecha DATETIME,
    PRIMARY KEY(id)
);

INSERT INTO ramo VALUES(NULL, 'Programación Java');
INSERT INTO ramo VALUES(NULL, 'Programación Android');
INSERT INTO ramo VALUES(NULL, 'Programación Web');
INSERT INTO ramo VALUES(NULL, 'Arquitectura de software');
INSERT INTO ramo VALUES(NULL, 'Gestión de proyectos informáticos');
INSERT INTO ramo VALUES(NULL, 'Estructura de datos y Algoritmos');
INSERT INTO ramo VALUES(NULL, 'Especificación de requerimientos');

INSERT INTO examen VALUES(NULL, '2018-07-10 11:20', '1', 'Lab 315 (Diurno)');
INSERT INTO examen VALUES(NULL, '2018-07-19 19:00', '1', 'Lab 315 (Vespertino)');
INSERT INTO examen VALUES(NULL, '2018-07-09 19:00', '2', 'Lab 315 (Diurno y Vespertino)');
INSERT INTO examen VALUES(NULL, '2018-07-12 14:25', '3', 'Lab 315 (Sección de Jueves)');
INSERT INTO examen VALUES(NULL, '2018-07-12 16:00', '3', 'Lab 315 (Sección de Miércoles)');
INSERT INTO examen VALUES(NULL, '2018-07-11 19:00', '4', 'Lab 315');
INSERT INTO examen VALUES(NULL, '2018-07-12 19:00', '5', 'Lab 315 (Diurno y Vespertino)');
INSERT INTO examen VALUES(NULL, '2018-07-13 14:25', '6', 'Lab 315 (Sección de Martes)');
INSERT INTO examen VALUES(NULL, '2018-07-13 16:00', '6', 'Lab 315 (Sección de Miércoles)');
INSERT INTO examen VALUES(NULL, '2018-07-12 19:00', '7', 'Sala 304');


/* Obtener la información de un examen según fecha e ID de ramo*/
DELIMITER $$
CREATE PROCEDURE getExamen(
	mes INT,
    anio INT, 
    idRamo INT
)BEGIN
    SET lc_time_names = 'es_ES';
    SELECT 
        r.nombre AS 'Ramo',
        DATE_FORMAT(e.fecha, '%a %d de %M (%H:%i %p)') AS 'Fecha',
        e.detalle AS 'Detalle'
    FROM
        ramo r
        INNER JOIN examen e ON r.id = e.ramo
    WHERE 
        e.fecha > NOW() AND
        e.fecha > CONCAT(anio,'-',mes,'-01') AND
        r.id = idRamo
    ORDER BY
        e.fecha ASC;
END $$
DELIMITER ;
/* Obtener la información de un examen según fecha e ID de ramo*/


/*Obtener la información de Todos los examenes según fecha*/
DELIMITER $$
CREATE PROCEDURE getExamenes(
	mes INT,
    anio INT 
)BEGIN
    SET lc_time_names = 'es_ES';
    SELECT 
        r.nombre AS 'Ramo',
        DATE_FORMAT(e.fecha, '%a %d de %M (%H:%i %p)') AS 'Fecha',
        e.detalle AS 'Detalle'
    FROM
        ramo r
        INNER JOIN examen e ON r.id = e.ramo
    WHERE 
        e.fecha > NOW() AND
        e.fecha > CONCAT(anio,'-',mes,'-01')
    ORDER BY
        e.fecha ASC;
END $$
DELIMITER ;
/*Obtener la información de Todos los examenes según fecha*/



/* Lista de ramos */
DELIMITER $$
CREATE PROCEDURE getRamos()
BEGIN
    SELECT * FROM ramo ORDER BY nombre ASC;
END $$
DELIMITER ;
/* Lista de ramos */



DROP PROCEDURE getExamenes;
DROP PROCEDURE getRamos;
DROP PROCEDURE getExamen;