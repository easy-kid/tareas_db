INSERT INTO categoria (nombre) VALUES
    ('Ficción'),
    ('No ficción'),
    ('Ciencia'),
    ('Historia'),
    ('Tecnología');

INSERT INTO autor (nombre, nacionalidad) VALUES
    ('Gabriel García Márquez', 'Colombiano'),
    ('Isabel Allende', 'Chilena'),
    ('Mario Vargas Llosa', 'Peruano'),
    ('Yuval Noah Harari', 'Israelí'),
    ('Carl Sagan', 'Estadounidense'),
    ('Stephen Hawking', 'Británico'),
    ('Donald Knuth', 'Estadounidense'),
    ('Robert C. Martin', 'Estadounidense');

INSERT INTO libro (titulo, publicacion, categoria) VALUES
    ('Cien años de soledad',    '1967-05-30', 1),
    ('La casa de los espíritus','1982-10-01', 1),
    ('La ciudad y los perros',  '1963-01-01', 1),
    ('Sapiens',                 '2011-03-15', 2),
    ('Cosmos',                  '1980-09-01', 3),
    ('Breve historia del tiempo','1988-04-01',3),
    ('The Art of Computer Programming','1968-01-01',5),
    ('Clean Code',              '2008-08-11', 5),
    ('Homo Deus',               '2015-09-01', 2),
    ('Una breve historia de casi todo','2003-05-06',3);

INSERT INTO autor_libro (autor, libro) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (4, 9),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (5, 10),
    (6, 10);

INSERT INTO usuario (nombre, email, fecha_registro) VALUES
    ('Ana Martínez',  'ana@example.com',    '2022-01-15'),
    ('Bruno Pérez',   'bruno@example.com',  '2022-03-20'),
    ('Carla Rojas',   'carla@example.com',  '2022-06-10'),
    ('Diego Torres',  'diego@example.com',  '2023-02-01'),
    ('Elena Soto',    'elena@example.com',  '2023-07-22');

INSERT INTO prestamo (usuarios, libros, prestamo, devolucion, estado) VALUES
    (1, 1, '2023-03-01', '2023-03-10', 'devuelto'),
    (1, 4, '2023-05-05', '2023-05-25', 'retrasado'),
    (2, 2, '2023-07-10', '2023-07-18', 'devuelto'),
    (2, 6, '2023-10-15',  NULL,         'pendiente'),
    (3, 8, '2023-11-01', '2023-11-20', 'retrasado'),
    (4, 3, '2024-01-20', '2024-01-25', 'devuelto'),
    (5, 9, '2024-02-10',  NULL,         'pendiente'),
    (1, 5, '2023-04-12', '2023-04-15', 'devuelto');

INSERT INTO multa (prestamo_usuarios, prestamo_libros, prestamo_fecha, monto, pagado) VALUES
    (1, 4, '2023-05-05', 5000.00, FALSE),
    (3, 8, '2023-11-01', 3500.00, TRUE);
