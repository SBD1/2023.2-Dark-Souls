
-- Cria Novo Mundo
CREATE OR REPLACE FUNCTION cria_mundo(nome_novo_mundo CHAR(40), dificuldade_mundo INTEGER)
RETURNS VOID AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM Mundo WHERE nome = nome_novo_mundo) THEN
    INSERT INTO Mundo (
      nome, dificuldade
    ) VALUES (nome_novo_mundo, dificuldade_mundo);
    RAISE NOTICE 'Criando Mundo %', nome_novo_mundo;
  ELSE
    RAISE NOTICE 'Nao foi possivel criar o mundo %', nome_novo_mundo;
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_sala(nome_nova_sala CHAR(40), dificuldade_sala INTEGER, mundo INTEGER)
RETURNS VOID AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM Sala WHERE nome = nome_nova_sala) THEN
    INSERT INTO Sala (
      nome, dificuldade, mundo
    ) VALUES (mundo ,nome_nova_sala, dificuldade_sala);
    RAISE NOTICE 'Criando Sala %', nome_nova_sala;
  ELSE
    RAISE NOTICE 'Nao foi possivel criar a sala %', nome_nova_sala;
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_mundo(nome_novo_mundo CHAR(40), dificuldade_mundo INTEGER)
RETURNS VOID AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM Mundo WHERE nome = nome_novo_mundo) THEN
    INSERT INTO Mundo (
      nome, dificuldade
    ) VALUES (nome_novo_mundo, dificuldade_mundo);
    RAISE NOTICE 'Criando Mundo %', nome_novo_mundo;
  ELSE
    RAISE NOTICE 'Nao foi possivel criar o mundo %', nome_novo_mundo;
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_sala(nome_nova_sala CHAR(40), dificuldade_sala INTEGER, mundo INTEGER)
RETURNS VOID AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM Sala WHERE nome = nome_nova_sala) THEN
    INSERT INTO Sala (
      nome, dificuldade, mundo
    ) VALUES (mundo ,nome_nova_sala, dificuldade_sala);
    RAISE NOTICE 'Criando Sala %', nome_nova_sala;
  ELSE
    RAISE NOTICE 'Nao foi possivel criar a sala %', nome_nova_sala;
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_viagem(dificuldade_player INTEGER, mundo INTEGER)
RETURNS VOID AS $$
DECLARE
  contador INTEGER DEFAULT 1;
  id_base INTEGER;
BEGIN
  IF EXISTS (SELECT 1 FROM Sala JOIN Mundo ON Sala.mundo = Mundo.id_mundo) THEN
    SELECT Sala.id_sala INTO id_base FROM Sala JOIN Mundo ON Sala.mundo = Mundo.id_mundo LIMIT 1;
  	id_base = id_base -1;
  ELSE
    RAISE NOTICE 'A tabela está vazia';
    RETURN;
  END IF;  	
  
  IF (dificuldade_player = 1) THEN
    WHILE contador <= 2 LOOP
      IF NOT EXISTS (
          SELECT 1
          FROM Viagem_Origem
          JOIN Sala ON Viagem_Origem.id_sala = Sala.id_sala
          JOIN Mundo ON Sala.mundo = Mundo.id_mundo
          WHERE Viagem_Origem.id_sala = contador
      ) THEN
        INSERT INTO Viagem_Origem (id_sala, id_origem) VALUES (contador + id_base, contador +id_base + 1);
      ELSE
        RAISE NOTICE 'Relacao ja existe';
      END IF;

      contador = contador + 1;
    END LOOP;
  ELSE
    RAISE NOTICE 'Dificuldade nao implementada ainda';
  END IF;
END;
$$ LANGUAGE plpgsql;

