/*
    ISAAC MARTIN NAVARRO ALVAREZ
    Database: biblioteca
    Fecha: 2017-10-03 8:25
*/

 -- autores,libros,editoriales,idiomas,paises,usuarios,
 -- personas,alumnos,prestamo,tipo_persona

CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

CREATE TABLE IF NOT EXISTS autores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    email VARCHAR(200) NOT NULL DEFAULT 'sin@correo'
)ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE IF NOT EXISTS idiomas(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

CREATE TABLE IF NOT EXISTS categorias(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

CREATE TABLE IF NOT EXISTS paises(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
nombre_alfa2 CHAR(2) NOT NULL
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

create TABLE IF NOT EXISTS tipo_personas(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
descripcion ENUM('docentes','alumnos','administrativos','otros') NOT NULL
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

CREATE TABLE IF NOT EXISTS usuarios(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
username VARCHAR(16) NOT NULL UNIQUE,
password VARCHAR(200) NOT NULL,
crate_at DATETIME NOT NULL DEFAULT current_timestamp
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

CREATE TABLE IF NOT EXISTS editoriales(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
pais_id INT UNSIGNED NOT NULL,
email VARCHAR(200) NOT NULL DEFAULT 'sin@correo',
wep VARCHAR (200) NOT NULL DEFAULT 'www.nowep.com',
constraint fk_editoriales_paises
foreign key (pais_id)
references paises (id)
on delete restrict
on update cascade
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

CREATE TABLE IF NOT EXISTS personas(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombres VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
RFC char(16) not null,
fecha_nacimiento date not null,
tipo_persona_id int unsigned not null,
constraint fk_persona_tipo_persona
foreign key (tipo_persona_id)
references tipo_personas (id)
on delete restrict
on update cascade
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

CREATE TABLE IF NOT EXISTS alumnos(
persona_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
no_control CHAR(50) NOT NULL,
generacion CHAR(50) NOT NULL,
turno enum('Matutino','Vespertino'),
carrera varchar(200) not null,
constraint fk_alumno_persona
foreign key (persona_id)
references personas (id)
on delete restrict
on update cascade
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

CREATE TABLE IF NOT EXISTS libros(
id int unsigned auto_increment primary key,
isn char(17) not null default '',
titulo varchar(200) not null,
editorial_id int unsigned not null,
idioma_id int unsigned not null,
categoria_id int unsigned not null,
constraint fk_libros_editoriales
	foreign key (editorial_id)
	references editoriales (id)
		on delete restrict
		on update cascade,
constraint fk_libros_idiomas
	foreign key (idioma_id)
	references idiomas (id)
		on delete restrict
		on update cascade,
constraint fk_libros_categorias
foreign key (categoria_id)
references categorias (id)
on delete restrict
on update cascade
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

create table if not exists libros_has_autores(
libro_id int unsigned,
autor_id int unsigned,
primary key (libro_id,autor_id),
constraint fk_libros_autores
	foreign key (autor_id)
	references autores (id)
		on delete restrict
		on update cascade,
constraint fk_libroshasautores_libros
	foreign key (libro_id)
    references libros (id)
		on delete restrict
        on update cascade
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

CREATE TABLE IF NOT EXISTS prestamos(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id INT UNSIGNED NOT NULL,
persona_id INT UNSIGNED NOT NULL,
fecha_salida DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
fecha_regreso DATETIME NOT NULL DEFAULT '1999-01-01',
grupo_actual CHAR(7) NOT NULL,
CONSTRAINT fk_prestamos_usuarios
	FOREIGN KEY (usuario_id)
	REFERENCES usuarios (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
CONSTRAINT fk_prestamos_personas
	FOREIGN KEY (persona_id)
	REFERENCES personas (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;

CREATE TABLE IF NOT EXISTS prestamos_has_libros(
prestamo_id INT UNSIGNED,
libro_id INT UNSIGNED,
PRIMARY KEY (prestamo_id, libro_id),
constraint fk_prestamoshaslibros_prestamos
	foreign key (prestamo_id)
    references prestamos (id)
		on delete restrict
        on update cascade,
constraint fk_prestamoshaslibros_libros
	foreign key (libro_id)
	references libros (id)
		on delete restrict
        on update cascade
)ENGINE=InnoDB CHARSET=utf8 COLLATE=UTF8_general_ci;
