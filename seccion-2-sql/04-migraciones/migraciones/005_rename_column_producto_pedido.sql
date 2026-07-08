ALTER TABLE producto_pedido RENAME COLUMN productos TO producto_id;
ALTER TABLE producto_pedido RENAME COLUMN pedidos TO pedido_id;
INSERT INTO schema_migrations (version) VALUES ('005_rename_column_producto_pedido');
