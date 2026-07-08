DROP VIEW  IF EXISTS vista_global_biblioteca CASCADE;
DROP TABLE IF EXISTS multa        CASCADE;
DROP TABLE IF EXISTS prestamo     CASCADE;
DROP TABLE IF EXISTS autor_libro  CASCADE;
DROP TABLE IF EXISTS libro        CASCADE;
DROP TABLE IF EXISTS categoria    CASCADE;
DROP TABLE IF EXISTS autor        CASCADE;
DROP TABLE IF EXISTS usuario      CASCADE;

CREATE TABLE autor (
    id              SERIAL       PRIMARY KEY,
    nombre          VARCHAR(120) NOT NULL,
    nacionalidad    VARCHAR(60)
);

CREATE TABLE categoria (
    id      SERIAL       PRIMARY KEY,
    nombre  VARCHAR(80)  NOT NULL UNIQUE
);

CREATE TABLE libro (
    id           SERIAL       PRIMARY KEY,
    titulo       VARCHAR(200) NOT NULL,
    publicacion  DATE,
    categoria    INTEGER      NOT NULL,
    CONSTRAINT fk_libro_categoria
        FOREIGN KEY (categoria) REFERENCES categoria(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE autor_libro (
    autor  INTEGER NOT NULL,
    libro  INTEGER NOT NULL,
    PRIMARY KEY (autor, libro),
    CONSTRAINT fk_al_autor FOREIGN KEY (autor) REFERENCES autor(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_al_libro FOREIGN KEY (libro) REFERENCES libro(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE usuario (
    id              SERIAL       PRIMARY KEY,
    nombre          VARCHAR(120) NOT NULL,
    email           VARCHAR(150) UNIQUE,
    fecha_registro  DATE         NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE prestamo (
    usuarios   INTEGER NOT NULL,
    libros     INTEGER NOT NULL,
    prestamo   DATE    NOT NULL DEFAULT CURRENT_DATE,
    devolucion DATE,
    estado     VARCHAR(20) NOT NULL DEFAULT 'pendiente'
               CHECK (estado IN ('pendiente','devuelto','retrasado')),
    PRIMARY KEY (usuarios, libros, prestamo),
    CONSTRAINT fk_prestamo_usuario FOREIGN KEY (usuarios)
        REFERENCES usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_prestamo_libro FOREIGN KEY (libros)
        REFERENCES libro(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE multa (
    id                  SERIAL  PRIMARY KEY,
    prestamo_usuarios   INTEGER NOT NULL,
    prestamo_libros     INTEGER NOT NULL,
    prestamo_fecha      DATE    NOT NULL,
    monto               NUMERIC(10,2) NOT NULL CHECK (monto >= 0),
    pagado              BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_multa_prestamo
        FOREIGN KEY (prestamo_usuarios, prestamo_libros, prestamo_fecha)
        REFERENCES prestamo(usuarios, libros, prestamo)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
