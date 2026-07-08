CREATE INDEX idx_producto_nombre_precio ON producto(nombre, precio_unidad);
INSERT INTO schema_migrations (version) VALUES ('007_create_index_producto_nombre_precio');
