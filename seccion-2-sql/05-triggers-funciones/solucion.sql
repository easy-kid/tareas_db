CREATE TABLE jugador (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    elo INTEGER NOT NULL DEFAULT 1000
);

CREATE TABLE partido (
    id SERIAL PRIMARY KEY,
    jugador_ganador_id INTEGER REFERENCES jugador(id),
    jugador_perdedor_id INTEGER REFERENCES jugador(id),
    fecha TIMESTAMP DEFAULT now()
);

CREATE TABLE elo_historial (
    id SERIAL PRIMARY KEY,
    jugador_id INTEGER REFERENCES jugador(id),
    elo_anterior INTEGER,
    elo_nuevo INTEGER,
    cambio INTEGER,
    motivo TEXT,
    fecha TIMESTAMP DEFAULT now()
);

CREATE OR REPLACE FUNCTION auditar_elo()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.elo <> OLD.elo THEN
        INSERT INTO elo_historial (jugador_id, elo_anterior, elo_nuevo, cambio, motivo)
        VALUES (
            NEW.id,
            OLD.elo,
            NEW.elo,
            NEW.elo - OLD.elo,
            TG_ARGV[0]
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_auditar_elo
AFTER UPDATE OF elo ON jugador
FOR EACH ROW
EXECUTE FUNCTION auditar_elo('Actualización de ELO por partido jugado');

INSERT INTO jugador (nombre) VALUES ('Carlos Alcaraz');
INSERT INTO jugador (nombre) VALUES ('Jannik Sinner');
INSERT INTO jugador (nombre) VALUES ('Novak Djokovic');

SELECT * FROM jugador;

INSERT INTO partido (jugador_ganador_id, jugador_perdedor_id) VALUES (1, 2);

UPDATE jugador SET elo = elo + 16 WHERE id = 1;
UPDATE jugador SET elo = elo - 16 WHERE id = 2;

INSERT INTO partido (jugador_ganador_id, jugador_perdedor_id) VALUES (3, 1);

UPDATE jugador SET elo = elo + 20 WHERE id = 3;
UPDATE jugador SET elo = elo - 20 WHERE id = 1;

SELECT * FROM elo_historial;

SELECT * FROM jugador;
