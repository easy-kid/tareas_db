SELECT id, nombre
FROM alumno
ORDER BY id;

SELECT c.id           AS curso_id,
       c.nombre       AS curso_nombre,
       p.nombre       AS profesor_nombre
FROM curso c
JOIN profesor p ON p.id = c.profesor
ORDER BY c.id;

SELECT c.nombre AS curso_nombre
FROM alumno_curso ac
JOIN curso c ON c.id = ac.curso
WHERE ac.alumno = :alumno_id
ORDER BY c.nombre;

SELECT c.id,
       c.nombre                AS curso,
       COUNT(ac.alumno)        AS total_inscritos
FROM curso c
LEFT JOIN alumno_curso ac ON ac.curso = c.id
GROUP BY c.id, c.nombre
ORDER BY total_inscritos DESC, c.nombre;

SELECT h.dia,
       h.hora_inicio,
       h.hora_fin,
       s.nombre AS sala
FROM horario h
JOIN curso c ON c.id   = h.curso
JOIN sala  s ON s.id   = h.sala
WHERE c.nombre = 'Programación'
ORDER BY
    CASE h.dia
        WHEN 'Lunes'      THEN 1
        WHEN 'Martes'     THEN 2
        WHEN 'Miercoles'  THEN 3
        WHEN 'Jueves'     THEN 4
        WHEN 'Viernes'    THEN 5
        WHEN 'Sabado'     THEN 6
        WHEN 'Domingo'    THEN 7
    END,
    h.hora_inicio;

SELECT s.id, s.nombre
FROM sala s
WHERE s.id NOT IN (
    SELECT DISTINCT sala
    FROM horario
    WHERE dia = 'Martes'
)
ORDER BY s.nombre;

SELECT s.id, s.nombre
FROM sala s
LEFT JOIN horario h
       ON h.sala = s.id
      AND h.dia  = 'Martes'
WHERE h.sala IS NULL
ORDER BY s.nombre;

UPDATE alumno
SET nombre = 'Javier Díaz Fernández'
WHERE id = 10;

UPDATE sala
SET capacidad = CEIL(capacidad * 1.05)
WHERE capacidad < 30;

UPDATE curso
SET profesor = 3
WHERE id = 6;

UPDATE horario h
SET hora_inicio = h.hora_inicio + INTERVAL '15 minutes',
    hora_fin    = h.hora_fin    + INTERVAL '15 minutes'
FROM curso c
WHERE c.id     = h.curso
  AND c.nombre = 'Filosofía';

DELETE FROM alumno_curso
WHERE alumno = 4 AND curso = 8;

DELETE FROM horario
WHERE curso = 2;

DELETE FROM curso
WHERE profesor = 5;

DROP VIEW IF EXISTS vista_global_academica;

CREATE VIEW vista_global_academica AS
SELECT
    a.id            AS alumno_id,
    a.nombre        AS alumno_nombre,
    c.id            AS curso_id,
    c.nombre        AS curso_nombre,
    p.id            AS profesor_id,
    p.nombre        AS profesor_nombre,
    h.dia           AS dia,
    h.hora_inicio   AS hora_inicio,
    h.hora_fin      AS hora_fin,
    s.id            AS sala_id,
    s.nombre        AS sala_nombre,
    s.capacidad     AS sala_capacidad
FROM alumno_curso ac
JOIN alumno    a ON a.id = ac.alumno
JOIN curso     c ON c.id = ac.curso
JOIN profesor  p ON p.id = c.profesor
LEFT JOIN horario  h ON h.curso = c.id
LEFT JOIN sala     s ON s.id    = h.sala;
