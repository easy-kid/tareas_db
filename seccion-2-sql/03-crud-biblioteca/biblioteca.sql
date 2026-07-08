SELECT u.id,
       u.nombre,
       COUNT(*) AS prestamos_retrasados
FROM prestamo p
JOIN usuario u ON u.id = p.usuarios
WHERE p.estado = 'retrasado'
GROUP BY u.id, u.nombre
ORDER BY prestamos_retrasados DESC, u.nombre;

SELECT l.id,
       l.titulo,
       COUNT(*) AS num_autores
FROM autor_libro al
JOIN libro l ON l.id = al.libro
GROUP BY l.id, l.titulo
HAVING COUNT(*) > 1
ORDER BY num_autores DESC, l.titulo;

SELECT u.id,
       u.nombre,
       COALESCE(SUM(m.monto), 0) AS total_multas,
       COUNT(m.id)               AS cantidad_multas
FROM usuario u
LEFT JOIN prestamo p
       ON p.usuarios = u.id
LEFT JOIN multa m
       ON m.prestamo_usuarios = p.usuarios
      AND m.prestamo_libros   = p.libros
      AND m.prestamo_fecha    = p.prestamo
GROUP BY u.id, u.nombre
ORDER BY total_multas DESC;

SELECT c.nombre                              AS categoria,
       EXTRACT(YEAR FROM l.publicacion)::INT AS anio,
       COUNT(*)                              AS num_libros
FROM libro l
JOIN categoria c ON c.id = l.categoria
GROUP BY c.nombre, EXTRACT(YEAR FROM l.publicacion)
ORDER BY c.nombre, anio;

SELECT l.id,
       l.titulo,
       COUNT(*) AS num_prestamos
FROM prestamo p
JOIN libro l ON l.id = p.libros
WHERE EXTRACT(YEAR FROM p.prestamo) = 2023
GROUP BY l.id, l.titulo
ORDER BY num_prestamos DESC, l.titulo;

SELECT
    AVG(CASE WHEN pagado = TRUE  THEN monto END) AS promedio_pagadas,
    AVG(CASE WHEN pagado = FALSE THEN monto END) AS promedio_no_pagadas,
    COUNT(*) FILTER (WHERE pagado = TRUE)  AS num_pagadas,
    COUNT(*) FILTER (WHERE pagado = FALSE) AS num_no_pagadas
FROM multa;

UPDATE prestamo
SET estado = 'retrasado'
WHERE devolucion IS NOT NULL
  AND devolucion > prestamo + INTERVAL '15 days'
  AND estado <> 'retrasado';

UPDATE prestamo
SET estado = 'retrasado'
WHERE devolucion IS NULL
  AND prestamo + INTERVAL '15 days' < CURRENT_DATE
  AND estado = 'pendiente';

UPDATE prestamo
SET devolucion = CURRENT_DATE,
    estado     = 'devuelto'
WHERE usuarios = :id_usuario
  AND libros   = :id_libro
  AND prestamo = :fecha_prestamo
  AND estado   = 'pendiente';

UPDATE multa
SET pagado = TRUE
WHERE id = :id_multa;

DELETE FROM prestamo
WHERE devolucion IS NOT NULL
  AND devolucion < CURRENT_DATE - INTERVAL '1 year';

DELETE FROM libro
WHERE id NOT IN (
    SELECT DISTINCT libro FROM autor_libro
);

DROP VIEW IF EXISTS vista_global_biblioteca;

CREATE VIEW vista_global_biblioteca AS
SELECT
    u.id            AS usuario_id,
    u.nombre        AS usuario_nombre,
    l.id            AS libro_id,
    l.titulo        AS libro_titulo,
    a.nombre        AS autor_nombre,
    c.nombre        AS categoria_nombre,
    p.prestamo      AS fecha_prestamo,
    p.devolucion    AS fecha_devolucion,
    p.estado        AS estado_prestamo,
    m.monto         AS monto_multa,
    m.pagado        AS multa_pagada
FROM prestamo p
JOIN usuario   u ON u.id = p.usuarios
JOIN libro     l ON l.id = p.libros
JOIN categoria c ON c.id = l.categoria
JOIN autor_libro al ON al.libro = l.id
JOIN autor     a ON a.id = al.autor
LEFT JOIN multa m
       ON m.prestamo_usuarios = p.usuarios
      AND m.prestamo_libros   = p.libros
      AND m.prestamo_fecha    = p.prestamo;
