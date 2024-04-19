-- Creación de la base de datos MyDrugs
CREATE DATABASE MyDrugs;

-- Uso de la base de datos recién creada
USE MyDrugs;

-- Creación de la tabla origen_drogas para almacenar información sobre el origen de las drogas
CREATE TABLE origen_drogas(
    id_origen_drogas INT PRIMARY KEY AUTO_INCREMENT,
    origen VARCHAR(255) NOT NULL
);

-- Creación de la tabla drogas para almacenar información sobre las drogas
CREATE TABLE drogas(
    id_drogas INT PRIMARY KEY AUTO_INCREMENT,
    id_origen_drogas INT,
    nombre_comun VARCHAR(255) NOT NULL,
    nombre_cientifico VARCHAR(255) NOT NULL,
    clasificacion_farmacologica VARCHAR(255) NOT NULL,
    descripcion_quimica VARCHAR(255) NOT NULL,
    descripcion_fisica VARCHAR(255) NOT NULL,
    imagen BLOB NOT NULL,
    divisibles TINYINT NOT NULL,
    FOREIGN KEY (id_origen_drogas) REFERENCES origen_drogas(id_origen_drogas) ON DELETE SET NULL
);

-- La tabla 'drogas' tiene una clave externa 'id_origen_drogas' que hace referencia a la columna 'id_origen_drogas' en la tabla 'origen_drogas'. 
-- Esta relación establece la procedencia de las drogas, conectando cada droga con su origen.

-- Creación de la tabla riesgos para almacenar información sobre los riesgos asociados con las drogas
CREATE TABLE riesgos(
    id_riesgos INT PRIMARY KEY AUTO_INCREMENT,
    id_drogas INT,
    problemas_de_salud_fisica TEXT(255) NOT NULL,
    problemas_de_salud_mental TEXT(255) NOT NULL,
    tasa_de_mortalidad VARCHAR(255) NOT NULL,
    timepos_de_deteccion VARCHAR(255) NOT  NULL,
    dosis_recomendadas VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'riesgos' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esta relación vincula los riesgos específicos asociados con cada droga.

-- Creación de la tabla clasificacion_legal para almacenar información sobre la clasificación legal de las drogas en diferentes países
CREATE TABLE paises(
id_paises INT PRIMARY KEY AUTO_INCREMENT,
nombre_pais VARCHAR(255) NOT NULL
);
CREATE TABLE clasificacion_legal(
    id_clasificacion_legal INT PRIMARY KEY AUTO_INCREMENT,
    id_drogas INT,
    id_paises INT,
    clasificacion VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas),
    FOREIGN KEY (id_paises) REFERENCES paises(id_paises) ON DELETE SET NULL
);

-- La tabla 'clasificacion_legal' tiene dos claves externas:
-- 1. 'id_drogas' hace referencia a la columna 'id_drogas' en la tabla 'drogas', estableciendo la relación con las drogas.
-- 2. 'id_paises' hace referencia a la columna 'id_paises' en la tabla 'paises', conectando cada clasificación legal con un país específico.

-- Creación de la tabla articulos para almacenar información sobre los artículos relacionados con las drogas
CREATE TABLE articulos(
    id_arcticulos INT PRIMARY KEY AUTO_INCREMENT,
    id_drogas INT,
    fecha_de_publicacion DATE NOT NULL,
    enlace_articulo VARCHAR(255) NOT NULL,
    resumen VARCHAR(255) NOT NULL,
    revista VARCHAR(255) NOT NULL,
    autor TEXT(30) NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'articulos' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esto permite asociar artículos específicos con las drogas a las que hacen referencia.

-- Creación de la tabla analisis_de_pureza para almacenar información sobre los análisis de pureza de las drogas
CREATE TABLE analisis_de_pureza(
    id_analisis_de_pureza INT PRIMARY KEY AUTO_INCREMENT,
    id_drogas INT,
    fecha_analisis DATE NOT NULL,
    porcentaje_pureza FLOAT NOT NULL,
    ciudad_droga TEXT(50) NOT NULL,
    metodo_de_analisis VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'analisis_de_pureza' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esta relación permite asociar análisis de pureza específicos con las drogas correspondientes.

-- Creación de la tabla precio_analisis para almacenar información sobre los precios de análisis de pureza
CREATE TABLE precio_analisis(
    id_precio_analisis INT PRIMARY KEY AUTO_INCREMENT,
    id_analisis_de_pureza INT,
    precio_analisis FLOAT NOT NULL,
    FOREIGN KEY (id_analisis_de_pureza) REFERENCES analisis_de_pureza(id_analisis_de_pureza)
);

-- La tabla 'precio_analisis' tiene una clave externa 'id_analisis_de_pureza' que hace referencia a la columna 'id_analisis_de_pureza' en la tabla 'analisis_de_pureza'.
-- Esto permite asociar precios específicos de análisis con los análisis de pureza correspondientes.

-- Creación de la tabla ubicaciones para almacenar información sobre las ubicaciones relacionadas con las drogas
CREATE TABLE ubicaciones(
    id_ubicacion INT PRIMARY KEY AUTO_INCREMENT,
    nombre_punto VARCHAR(255) NOT NULL,
    calle VARCHAR(255),
    codigo_postal VARCHAR(20),
    ciudad VARCHAR(100),
    provincia VARCHAR(100),
    pais_ub VARCHAR(100),
    url_maps VARCHAR(500)
);

-- La tabla 'ubicaciones' almacena información sobre las ubicaciones relacionadas con las drogas, como los puntos de venta o los lugares de análisis.

-- Creación de la tabla precio_envio para almacenar información sobre los precios de envío relacionados con las drogas
CREATE TABLE precio_envio(
    id_precio_envio INT PRIMARY KEY AUTO_INCREMENT,
    id_ubicacion INT,
    id_analisis_de_pureza INT,
    precio FLOAT NOT NULL,
    FOREIGN KEY (id_ubicacion) REFERENCES ubicaciones(id_ubicacion) ON UPDATE CASCADE,
    FOREIGN KEY (id_analisis_de_pureza) REFERENCES analisis_de_pureza(id_analisis_de_pureza)
);

-- La tabla 'precio_envio' tiene dos claves externas:
-- 1. 'id_ubicacion' hace referencia a la columna 'id_ubicacion' en la tabla 'ubicaciones', vinculando los precios de envío con ubicaciones específicas.
-- 2. 'id_analisis_de_pureza' hace referencia a la columna 'id_analisis_de_pureza' en la tabla 'analisis_de_pureza', relacionando los precios de envío con análisis de pureza específicos.

-- Creación de la tabla noticias para almacenar información sobre las noticias relacionadas con las drogas
CREATE TABLE noticias (
    id_noticia INT PRIMARY KEY AUTO_INCREMENT,
    titulo_noticia VARCHAR(255) NOT NULL ,
    id_drogas INT,
    fecha_noticia DATE NOT NULL,
    fecha_de_publicacion DATE NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'noticias' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esto permite asociar noticias específicas con las drogas a las que hacen referencia.

-- Creación de la tabla interacciones para almacenar información sobre las interacciones entre drogas
CREATE TABLE interacciones(
    id_interacciones INT PRIMARY KEY AUTO_INCREMENT,
    tipo_interaccion VARCHAR(255) NOT NULL,
    descripcion VARCHAR(1000) NOT NULL
);

-- La tabla 'interacciones' almacena información sobre las diferentes interacciones entre drogas.

-- Creación de la tabla efectos para almacenar información sobre los efectos de las drogas
CREATE TABLE efectos(
    id_efectos INT PRIMARY KEY AUTO_INCREMENT,
    id_drogas INT,
    efecto_fisico VARCHAR(255) NOT NULL,
    efecto_psicologico VARCHAR(255) NOT NULL,
    duracion VARCHAR(255) NOT NULL,
    tolerancia VARCHAR(255) NOT NULL,
    dependencia VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'efectos' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esto permite asociar efectos específicos con las drogas correspondientes.

-- Creación de la tabla interaccion_droga para almacenar información sobre las interacciones entre diferentes drogas
CREATE TABLE interaccion_droga(
    id_interaccion INT,
    id_droga1 INT,
    id_droga2 INT,
    FOREIGN KEY (id_droga1) REFERENCES drogas(id_drogas),
    FOREIGN KEY (id_droga2) REFERENCES drogas(id_drogas),
    FOREIGN KEY (id_interaccion) REFERENCES interacciones(id_interacciones)
);

-- La tabla 'interaccion_droga' establece relaciones entre diferentes drogas y sus interacciones.

-- Creación de la tabla programa_de_ayuda para almacenar información sobre los programas de ayuda relacionados con las drogas
CREATE TABLE programa_de_ayuda(
    id_programa_ayuda INT PRIMARY KEY AUTO_INCREMENT,
    id_drogas INT,
    nombre_programa VARCHAR(255) NOT NULL,
    tipo_programa Varchar(255) NOT NULL,
    descripcion_programa VARCHAR(255) NOT NULL,
    ubicacion_programa VARCHAR(255) NOT NULL,
    contacto_programa VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'programa_de_ayuda' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esto permite asociar programas de ayuda específicos con las drogas correspondientes.

-- Creación de la tabla alertas para almacenar información sobre las alertas relacionadas con las drogas
CREATE TABLE alertas(
    id_alertas INT PRIMARY KEY AUTO_INCREMENT,
    id_drogas INT,
    tipo_alerta VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'alertas' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esto permite asociar alertas específicas con las drogas correspondientes.

-- Creación de la tabla imagenes para almacenar imágenes relacionadas con las drogas
CREATE TABLE imagenes(
    id_imagenes INT PRIMARY KEY AUTO_INCREMENT, 
    id_drogas INT,
    tipo_de_imagen VARCHAR(200) NOT NULL,
    imagen BLOB,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'imagenes' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esto permite asociar imágenes específicas con las drogas correspondientes.

-- Creación de la tabla adulterantes para almacenar información sobre los adulterantes de las drogas
CREATE TABLE adulterantes(
    id_adulterantes INT PRIMARY KEY AUTO_INCREMENT,
    id_drogas INT, 
    efectos_adulterantes VARCHAR(255) NOT NULL,
    nombres_adulterantes VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'adulterantes' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esto permite asociar información sobre adulterantes específicos con las drogas correspondientes.

-- Creación de la tabla pobaciones_de_riesgo para almacenar información sobre las poblaciones de riesgo relacionadas con las drogas
CREATE TABLE pobaciones_de_riesgo(
    id_poblaciones_de_riesgo INT PRIMARY KEY AUTO_INCREMENT,
    id_drogas INT,
    poblacion VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_drogas) REFERENCES drogas(id_drogas)
);

-- La tabla 'pobaciones_de_riesgo' tiene una clave externa 'id_drogas' que hace referencia a la columna 'id_drogas' en la tabla 'drogas'.
-- Esto permite asociar información sobre poblaciones de riesgo específicas con las drogas correspondientes.

-- Creación de la tabla trabajador para almacenar información sobre los trabajadores
CREATE TABLE trabajador(
    id_trabajador INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_trabajador CHAR(255),
    dni_trabajador INT NOT NULL,
    telefono_trabajador INT NOT NULL
);

-- Creación de la tabla rol para almacenar información sobre los roles de los trabajadores
CREATE TABLE rol(
    id_rol INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(255),
    descripcion_rol VARCHAR(255),
    id_trabajador INT NOT NULL
);

-- Creación de la tabla relacion_rol_trabajador para establecer la relación entre roles y trabajadores
CREATE TABLE relacion_rol_trabajador(
    id_rol INT NOT NULL,
    id_trabajador INT NOT NULL,
    PRIMARY KEY (id_rol, id_trabajador),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_trabajador) REFERENCES rol(id_rol)ON DELETE CASCADE ON UPDATE CASCADE
);

-- La tabla 'relacion_rol_trabajador' establece una relación muchos a muchos entre roles y trabajadores.
-- Esto permite asignar múltiples roles a un trabajador y viceversa.

-- Creación de la tabla contrato para almacenar información sobre los contratos de los trabajadores
CREATE TABLE contrato(
    id_contrato INT NOT NULL PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);

-- Creación de la tabla control_de_registros para mantener registros de acciones realizadas en la base de datos
CREATE TABLE control_de_registros(
    id_c INT AUTO_INCREMENT PRIMARY KEY,
    tabla VARCHAR(255),
    id_registro_eliminado INT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creación de la tabla auditoria para mantener registros de auditoría de cambios en la base de datos
CREATE TABLE auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabla VARCHAR(255) NOT NULL,
    operacion VARCHAR(10) NOT NULL,
    fecha DATETIME NOT NULL,
    usuario VARCHAR(255) NOT NULL,
    valores_viejos VARCHAR(255) DEFAULT NULL,
    valores_nuevos VARCHAR(255) DEFAULT NULL
);

-- Índices para búsquedas por nombre común de droga
CREATE INDEX idx_nombre_comun ON drogas (nombre_comun);

-- Índices para búsquedas por nombre científico de droga
CREATE INDEX idx_nombre_cientifico ON drogas (nombre_cientifico);

-- Índices para búsquedas por fecha de publicación de artículos
CREATE INDEX idx_fecha_publicacion_articulos ON articulos (fecha_de_publicacion);

-- Índices para búsquedas por fecha de análisis de pureza
CREATE INDEX idx_fecha_analisis_pureza ON analisis_de_pureza (fecha_analisis);

-- Índices adicionales para optimizar consultas SELECT
CREATE INDEX idx_id_origen_drogas ON drogas (id_origen_drogas);
CREATE INDEX idx_id_paises ON clasificacion_legal (id_paises);
CREATE INDEX idx_id_ubicacion ON precio_envio (id_ubicacion);
CREATE INDEX idx_id_drogas_noticias ON noticias (id_drogas);

-- Índices para optimizar la búsqueda de noticias y artículos por título y resumen
CREATE INDEX idx_titulo_noticia ON noticias (titulo_noticia);
CREATE INDEX idx_resumen ON articulos (resumen);

-- Índices para optimizar búsquedas por descripción física y programa de ayuda
CREATE INDEX idx_descripcion_fisica ON drogas (descripcion_fisica);
CREATE INDEX idx_descripcion_programa ON programa_de_ayuda (descripcion_programa);

-- Índices para optimizar búsquedas por relaciones
CREATE INDEX idx_id_drogas_riesgos ON riesgos (id_drogas);
CREATE INDEX idx_id_drogas_articulos ON articulos (id_drogas);

-- Índices para optimizar análisis de precios
CREATE INDEX idx_precio_analisis ON precio_analisis (precio_analisis);

-- Índices para optimizar búsquedas por fecha de publicación de noticias
CREATE INDEX idx_fecha_de_publicacion_noticias ON noticias (fecha_de_publicacion);

-- Índices para optimizar búsquedas por usuario en relación rol-trabajador
CREATE INDEX idx_id_trabajador_relacion_rol_trabajador ON relacion_rol_trabajador (id_trabajador);


-- Trigger prevencion_errores: Se dispara antes de eliminar una fila de la tabla 'drogas'.
-- Registra la eliminación en la tabla 'control_de_registros' y detiene la eliminación con un mensaje de error.
DELIMITER //
CREATE TRIGGER prevencion_errores
BEFORE DELETE ON drogas
FOR EACH ROW
BEGIN
    INSERT INTO control_de_registros (tabla, id_registro_eliminado)
    VALUES ('drogas', OLD.id_drogas);
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='La eliminación id_drogas está deshabilitada';
END;
//
DELIMITER ;

-- Trigger eliminar_trabajador_contrato_vencido: Se dispara después de actualizar una fila en la tabla 'contrato'.
-- Elimina el trabajador asociado si la fecha de fin del contrato es anterior a la fecha actual.

-- Trigger validar_datos: Se dispara antes de insertar una fila en la tabla 'drogas'.
-- Verifica que los campos obligatorios no estén vacíos y genera un mensaje de error si lo están.
DELIMITER //
CREATE TRIGGER validar_datos
BEFORE INSERT ON drogas
FOR EACH ROW
BEGIN
    IF NEW.nombre_comun IS NULL OR NEW.nombre_comun = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='El nombre común no puede ser nulo o vacío';
    END IF;

    IF NEW.nombre_cientifico IS NULL OR NEW.nombre_cientifico = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='El nombre científico no puede ser nulo o vacío';
    END IF;

    IF NEW.clasificacion_farmacologica IS NULL OR NEW.clasificacion_farmacologica = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='La clasificación farmacológica no puede ser nula o vacía';
    END IF;
END;
//
DELIMITER ;
