ALTER TABLE pedido ADD COLUMN estado TEXT DEFAULT 'pendiente';
INSERT INTO schema_migrations (version) VALUES ('006_add_estado_to_pedido');
