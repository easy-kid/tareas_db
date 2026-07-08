ALTER TABLE producto ALTER COLUMN precio_unidad TYPE INTEGER USING precio_unidad::INTEGER;
DELETE FROM schema_migrations WHERE version = '002_change_precio_to_decimal';
