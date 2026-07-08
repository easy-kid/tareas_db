ALTER TABLE cliente ADD COLUMN telefono TEXT;
INSERT INTO schema_migrations (version) VALUES ('001_add_telefono_to_cliente');
