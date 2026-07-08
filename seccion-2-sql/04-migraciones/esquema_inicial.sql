CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion TEXT
);

CREATE TABLE producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio_unidad INTEGER NOT NULL,
    categoria_id INTEGER REFERENCES categoria(id)
);

CREATE TABLE pedido (
    id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER REFERENCES cliente(id)
);

CREATE TABLE producto_pedido (
    productos INTEGER REFERENCES producto(id),
    pedidos INTEGER REFERENCES pedido(id),
    PRIMARY KEY (productos, pedidos)
);

CREATE TABLE schema_migrations (
    version VARCHAR(255) PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
