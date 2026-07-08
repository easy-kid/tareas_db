ALTER TABLE cliente
  ADD COLUMN calle TEXT,
  ADD COLUMN ciudad TEXT;

UPDATE cliente
SET calle = split_part(direccion, ',', 1),
    ciudad = split_part(direccion, ',', 2);

ALTER TABLE cliente DROP COLUMN direccion;

INSERT INTO schema_migrations (version) VALUES ('009_separate_direccion_cliente_to_street_and_city');
