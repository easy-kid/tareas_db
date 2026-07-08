ALTER TABLE producto ADD CONSTRAINT nombre_unico UNIQUE(nombre);
INSERT INTO schema_migrations (version) VALUES ('003_add_unique_constraint_to_nombre_producto');
