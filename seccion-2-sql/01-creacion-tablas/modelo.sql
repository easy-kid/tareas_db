DROP VIEW  IF EXISTS vista_global_academica CASCADE;
DROP TABLE IF EXISTS horario      CASCADE;
DROP TABLE IF EXISTS alumno_curso CASCADE;
DROP TABLE IF EXISTS curso        CASCADE;
DROP TABLE IF EXISTS alumno       CASCADE;
DROP TABLE IF EXISTS sala         CASCADE;
DROP TABLE IF EXISTS profesor     CASCADE;

CREATE TABLE profesor (
    id        SERIAL       PRIMARY KEY,
    nombre    VARCHAR(120) NOT NULL,
    email     VARCHAR(150) UNIQUE,
    telefono  VARCHAR(30)
);

CREATE TABLE sala (
    id         SERIAL       PRIMARY KEY,
    nombre     VARCHAR(80)  NOT NULL UNIQUE,
    capacidad  INTEGER      NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE alumno (
    id      SERIAL       PRIMARY KEY,
    nombre  VARCHAR(120) NOT NULL,
    email   VARCHAR(150) UNIQUE
);

CREATE TABLE curso (
    id        SERIAL       PRIMARY KEY,
    nombre    VARCHAR(120) NOT NULL,
    creditos  INTEGER      NOT NULL CHECK (creditos > 0),
    profesor  INTEGER      NOT NULL,
    CONSTRAINT fk_curso_profesor
        FOREIGN KEY (profesor) REFERENCES profesor(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE alumno_curso (
    alumno  INTEGER NOT NULL,
    curso   INTEGER NOT NULL,
    PRIMARY KEY (alumno, curso),
    CONSTRAINT fk_ac_alumno
        FOREIGN KEY (alumno) REFERENCES alumno(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_ac_curso
        FOREIGN KEY (curso) REFERENCES curso(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE horario (
    curso        INTEGER     NOT NULL,
    dia          VARCHAR(10) NOT NULL
                 CHECK (dia IN ('Lunes','Martes','Miercoles','Jueves',
                                'Viernes','Sabado','Domingo')),
    hora_inicio  TIME        NOT NULL,
    hora_fin     TIME        NOT NULL,
    sala         INTEGER     NOT NULL,
    PRIMARY KEY (curso, dia, hora_inicio),
    CONSTRAINT fk_horario_curso
        FOREIGN KEY (curso) REFERENCES curso(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_horario_sala
        FOREIGN KEY (sala) REFERENCES sala(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_horario_horas
        CHECK (hora_fin > hora_inicio)
);
