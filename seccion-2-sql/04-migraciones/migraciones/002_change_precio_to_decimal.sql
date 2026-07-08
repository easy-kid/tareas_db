ALTER TABLE producto ALTER COLUMN precio_unidad TYPE DECIMAL(10,2);
INSERT INTO schema_migrations (version) VALUES ('002_change_precio_to_decimal');
