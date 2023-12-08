---------------------------------------------------------------------------
---------- CRIA A ESTRURUTA DE MUNDO SALAS E RELACOES ENTRE ELAS ----------
--------------------------------------------------------------------------

-- CRIA UM NOVO MUNDO
CREATE OR REPLACE PROCEDURE cria_mundo(
  nome_novo_mundo CHAR(40), 
  dificuldade_mundo INTEGER)
AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 
                 FROM Mundo 
                WHERE nome = nome_novo_mundo) THEN
    
    INSERT INTO Mundo (nome, dificuldade) 
    VALUES (nome_novo_mundo, dificuldade_mundo);
    RAISE NOTICE 'Criando Mundo %', nome_novo_mundo;
  ELSE
    RAISE NOTICE 'Nao foi possivel criar o mundo %', nome_novo_mundo;
  END IF;
END;
$$ LANGUAGE plpgsql;


-- CRIA NOVA SALA PARA UM MUNDO
CREATE OR REPLACE PROCEDURE cria_sala(
  nome_nova_sala CHAR(40), 
  dificuldade_sala INTEGER, 
  mundo INTEGER)
AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 
                 FROM Sala 
                 WHERE nome = nome_nova_sala) THEN
    
    INSERT INTO Sala (nome, dificuldade, mundo) 
    VALUES (nome_nova_sala, dificuldade_sala,mundo);
    RAISE NOTICE 'Criando Sala %', nome_nova_sala;
  ELSE
    RAISE NOTICE 'Nao foi possivel criar a sala %', nome_nova_sala;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- CRIA RELACAO DE SALAS EM UM MUNDO
CREATE OR REPLACE PROCEDURE cria_viagem(mundo INTEGER)
AS $$
DECLARE
  contador INTEGER DEFAULT 1;
  id_base INTEGER;
  numero_tuplas INTEGER;
BEGIN
  
  SELECT COUNT(*) INTO numero_tuplas 
  FROM Sala 
  JOIN Mundo ON Sala.mundo = Mundo.id_mundo;

  IF (numero_tuplas > 1) THEN
    SELECT Sala.id_sala INTO id_base 
    FROM Sala 
    JOIN Mundo ON Sala.mundo = Mundo.id_mundo LIMIT 1;
  	
    id_base = id_base -1;
  ELSE
    RAISE NOTICE 'A tabela está vazia';
    RETURN;
  END IF;  	
  
  IF (numero_tuplas = 1) THEN
    RETURN;
  END IF;

  WHILE contador <= numero_tuplas LOOP
    IF NOT EXISTS (
        SELECT 1
        FROM Viagem_Destino
        JOIN Sala ON Viagem_Destino.id_sala = Sala.id_sala
        JOIN Mundo ON Sala.mundo = Mundo.id_mundo
        WHERE Viagem_Destino.id_sala = contador
    ) THEN
      INSERT INTO Viagem_Destino (id_sala, id_destino) 
      VALUES (contador + id_base, contador +id_base + 1);
    ELSE
      RAISE NOTICE 'Relacao ja existe';
    END IF;

    contador = contador + 1;
  END LOOP;
END;
$$ LANGUAGE plpgsql;


---------------------------------------------------------------------------
----------------- CRIA A ESTRURUTA DE ITENS E INVENTARIO ------------------
---------------------------------------------------------------------------

-- CRIA ITEM ARMA
CREATE OR REPLACE PROCEDURE cria_arma(
  nome_nova_arma CHAR(50),
  descricao_nova_arma CHAR(400),
  valor_ouro_nova_arma INTEGER,
  nivel_min_nova_arma INTEGER,
  val_dano_nova_arma INTEGER,
  raridade_nova_arma CHAR(25))
AS $$
DECLARE
  tipo_novo_item CHAR(25) DEFAULT 'Arma';
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Item
                 WHERE Item.nome = nome_nova_arma) THEN

    INSERT INTO Item (nome, descricao, valor_ouro, tipo, nivel_min)
    VALUES (nome_nova_arma, descricao_nova_arma, valor_ouro_nova_arma,tipo_novo_item ,nivel_min_nova_arma)
    RETURNING id_item INTO novo_id;

    INSERT INTO Arma (id_arma, val_dano, raridade)
    VALUES (novo_id, val_dano_nova_arma, raridade_nova_arma);
  END IF;
END;
$$ LANGUAGE plpgsql;


-- CRIA NOVA ARMADURA
CREATE OR REPLACE PROCEDURE cria_armadura(
  nome_nova_armadura CHAR(50),
  descricao_nova_armadura CHAR(400),
  valor_ouro_nova_armadura INTEGER,
  nivel_min_nova_armadura INTEGER,
  valor_armor_nova_armadura INTEGER)
AS $$
DECLARE
  tipo_novo_item CHAR(25) DEFAULT 'Armadura';
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Item
                 WHERE Item.nome = nome_nova_armadura) THEN

    INSERT INTO Item (nome, descricao, valor_ouro, tipo, nivel_min)
    VALUES (nome_nova_armadura, descricao_nova_armadura, valor_ouro_nova_armadura, tipo_novo_item ,nivel_min_nova_armadura)
    RETURNING id_item INTO novo_id;

    INSERT INTO Armadura (id_armadura, val_armor)
    VALUES (novo_id, valor_armor_nova_armadura);
  END IF;
END;
$$ LANGUAGE plpgsql;

-- CRIA NOVA ORB
CREATE OR REPLACE PROCEDURE cria_orb(
  nome_nova_orb CHAR(50),
  descricao_nova_orb CHAR(400),
  valor_ouro_nova_orb INTEGER,
  nivel_min_nova_orb INTEGER)
AS $$
DECLARE
  tipo_novo_item CHAR(25) DEFAULT 'Orb';
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Item
                 WHERE Item.nome = nome_nova_orb) THEN

    INSERT INTO Item (nome, descricao, valor_ouro, tipo, nivel_min)
    VALUES (nome_nova_orb, descricao_nova_orb, valor_ouro_nova_orb, tipo_novo_item ,nivel_min_nova_orb)
    RETURNING id_item INTO novo_id;

    INSERT INTO Orbs (id_orbs)
    VALUES (novo_id);
  END IF;
END;
$$ LANGUAGE plpgsql;


-- CRiA POCAO VIDA E CONSUMIVEL
CREATE OR REPLACE PROCEDURE cria_pocao_vida(
  nome_nova_pocao_vida CHAR(50),
  descricao_nova_pocao_vida CHAR(400),
  valor_ouro_nova_pocao_vida INTEGER,
  nivel_min_nova_pocao_vida INTEGER,
  max_utilizacao_pocao_vida INTEGER,
  val_vida_nova_pocao_vida INTEGER)
AS $$
DECLARE
  tipo_novo_item CHAR(25) DEFAULT 'Pocao_Vida';
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Item
                 WHERE Item.nome = nome_nova_pocao_vida) THEN

    INSERT INTO Item (nome, descricao, valor_ouro, tipo, nivel_min)
    VALUES (nome_nova_pocao_vida, descricao_nova_pocao_vida, valor_ouro_nova_pocao_vida, tipo_novo_item ,nivel_min_nova_pocao_vida)
    RETURNING id_item INTO novo_id;

    INSERT INTO Consumivel (id_cons, max_utilizacao)
    VALUES (novo_id, max_utilizacao_pocao_vida);

    INSERT INTO Pocao_Vida (id_vida, val_vida)
    VALUES (novo_id, val_vida_nova_pocao_vida);
  END IF;
END;
$$ LANGUAGE plpgsql;


-- CRIA POCAO MANA E CONSUMIVEL
CREATE OR REPLACE PROCEDURE cria_pocao_mana(
  nome_nova_pocao_mana CHAR(50),
  descricao_nova_pocao_mana CHAR(400),
  valor_ouro_nova_pocao_mana INTEGER,
  nivel_min_nova_pocao_mana INTEGER,
  max_utilizacao_pocao_mana INTEGER,
  val_vida_nova_pocao_mana INTEGER)
AS $$
DECLARE
  tipo_novo_item CHAR(25) DEFAULT 'Pocao_Mana';
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Item
                 WHERE Item.nome = nome_nova_pocao_mana) THEN

    INSERT INTO Item (nome, descricao, valor_ouro, tipo, nivel_min)
    VALUES (nome_nova_pocao_mana, descricao_nova_pocao_mana, valor_ouro_nova_pocao_mana, tipo_novo_item ,nivel_min_nova_pocao_mana)
    RETURNING id_item INTO novo_id;

    INSERT INTO Consumivel (id_cons, max_utilizacao)
    VALUES (novo_id, max_utilizacao_pocao_mana);

    INSERT INTO Pocao_Mana (id_mana, val_mana)
    VALUES (novo_id, val_vida_nova_pocao_mana);
  END IF;
END;
$$ LANGUAGE plpgsql;

-- CRiA POCAO VIDA E CONSUMIVEL
CREATE OR REPLACE PROCEDURE cria_pocao_vida(
  nome_nova_pocao_vida CHAR(50),
  descricao_nova_pocao_vida CHAR(400),
  valor_ouro_nova_pocao_vida INTEGER,
  nivel_min_nova_pocao_vida INTEGER,
  max_utilizacao_pocao_vida INTEGER,
  val_vida_nova_pocao_vida INTEGER)
AS $$
DECLARE
  tipo_novo_item CHAR(25) DEFAULT 'Pocao_Vida';
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Item
                 WHERE Item.nome = nome_nova_pocao_vida) THEN

    INSERT INTO Item (nome, descricao, valor_ouro, tipo, nivel_min)
    VALUES (nome_nova_pocao_vida, descricao_nova_pocao_vida, valor_ouro_nova_pocao_vida, tipo_novo_item ,nivel_min_nova_pocao_vida)
    RETURNING id_item INTO novo_id;

    INSERT INTO Consumivel (id_cons, max_utilizacao)
    VALUES (novo_id, max_utilizacao_pocao_vida);

    INSERT INTO Pocao_Vida (id_pocao_vida, val_vida)
    VALUES (novo_id, val_vida_nova_pocao_vida);
  END IF;
END;
$$ LANGUAGE plpgsql;


-- CRIA POCAO MANA E CONSUMIVEL
CREATE OR REPLACE PROCEDURE cria_pocao_mana(
  nome_nova_pocao_mana CHAR(50),
  descricao_nova_pocao_mana CHAR(400),
  valor_ouro_nova_pocao_mana INTEGER,
  nivel_min_nova_pocao_mana INTEGER,
  max_utilizacao_pocao_mana INTEGER,
  val_vida_nova_pocao_mana INTEGER)
AS $$
DECLARE
  tipo_novo_item CHAR(25) DEFAULT 'Pocao_Mana';
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Item
                 WHERE Item.nome = nome_nova_pocao_mana) THEN

    INSERT INTO Item (nome, descricao, valor_ouro, tipo, nivel_min)
    VALUES (nome_nova_pocao_mana, descricao_nova_pocao_mana, valor_ouro_nova_pocao_mana, tipo_novo_item ,nivel_min_nova_pocao_mana)
    RETURNING id_item INTO novo_id;

    INSERT INTO Consumivel (id_cons, max_utilizacao)
    VALUES (novo_id, max_utilizacao_pocao_mana);

    INSERT INTO Pocao_Mana (id_pocao_mana, val_mana)
    VALUES (novo_id, val_vida_nova_pocao_mana);
  END IF;
END;
$$ LANGUAGE plpgsql;
