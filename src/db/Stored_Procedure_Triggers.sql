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

-- CRIA INVENTARIO
CREATE OR REPLACE PROCEDURE cria_inventario(novo_num_slots INTEGER)
AS $$
BEGIN
  INSERT INTO inventario(num_slots) VALUES (novo_num_slots);
END;
$$ LANGUAGE plpgsql;

-- CRIA INSTANCIA ITEM
CREATE OR REPLACE PROCEDURE cria_inventario(id_novo_item INTEGER, id_inventario INTEGER)
AS $$
BEGIN
  INSERT INTO Instancia_Item(id_invent, id_item) VALUES (id_invent, id_novo_item);
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------------------------
-------------------- CRIA A ESTRURUTA DE PERSONAGENS  ---------------------
---------------------------------------------------------------------------

-- CRIA PC
CREATE OR REPLACE PROCEDURE cria_pc(
  nome_novo_pc CHAR(50),
  novo_nivel_pc INTEGER,
  valor_nova_vida INTEGER,
  valor_nova_mana INTEGER,
  valor_novo_ouro INTEGER,
  valor_novo_orbs INTEGER,
  valor_novo_atk_base INTEGER,
  valor_novo_arm_base INTEGER,
  id_armadura_pc INTEGER,
  id_arma_pc INTEGER,
  id_sala_pc INTEGER)
AS $$
DECLARE
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Personagem
                 WHERE Personagem.nome = nome_novo_pc) THEN

    INSERT INTO Personagem (nome)
    VALUES (nome_novo_pc)
    RETURNING id_personagem INTO novo_id;

    INSERT INTO PC (id_pc,vida, mana, ouro, orbs, atk_base, arm_base, armadura, arma, sala)
    VALUES (novo_id, valor_nova_vida, valor_nova_mana, valor_novo_ouro, valor_novo_orbs, valor_novo_atk_base, valor_novo_arm_base, id_armadura_pc, id_arma_pc, id_sala_pc);
  END IF;
END;
$$ LANGUAGE plpgsql;


-- CRIA Mercador
CREATE OR REPLACE PROCEDURE cria_pc(
  nome_novo_mercador CHAR(50),
  funcao_novo_npc CHAR(10),
  descricao_novo_npc CHAR(400),
  valor_novo_ouro INTEGER,
  id_inventario_mercador INTEGER,
  id_sala_mercador INTEGER)
AS $$
DECLARE
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Personagem
                 WHERE Personagem.nome = nome_novo_mercador) THEN

    INSERT INTO Personagem (nome)
    VALUES (nome_novo_mercador)
    RETURNING id_personagem INTO novo_id;

    INSERT INTO NPC (id_npc, funcao, descricao)
    VALUES (novp_id, funcao_novo_npc, descricao_novo_npc);
    
    INSERT INTO MErcador (id_mercador, ouro, inventario, sala)
    VALUES (novo_id,valor_novo_ouro, id_inventario_mercador, id_sala_mercador);
  END IF;
END;
$$ LANGUAGE plpgsql;


-- CRIA Inimigo Comum
CREATE OR REPLACE PROCEDURE cria_pc(
  nome_novo_inm_com CHAR(50),
  funcao_novo_npc CHAR(10),
  descricao_novo_npc CHAR(400),
  valor_nova_vida INTEGER,
  valor_nivel_inm_com INTEGER
  valor_novo_atk_base INTEGER,
  valor_novo_arm_base INTEGER,
  valor_novo_ouro_drop INTEGER,
  valor_novo_orbs_drop INTEGER,
AS $$
DECLARE
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Personagem
                 WHERE Personagem.nome = nome_novo_pc) THEN

    INSERT INTO Personagem (nome)
    VALUES (nome_novo_inm_com)
    RETURNING id_personagem INTO novo_id;
    
    INSERT INTO NPC (id_npc, funcao, descricao)
    VALUES (novp_id, funcao_novo_npc, descricao_novo_npc);

    INSERT INTO Inim_Comum (id_inm_com, vida, nivel, atk_base, arm_base, ouro_drop, orb_drop)
    VALUES (novp_id, valor_nova_vida, valor_nivel_inm_com, valor_novo_atk_base, valor_novo_arm_base, valor_novo_ouro_drop, valor_novo_orbs_drop);
  
  END IF;
END;
$$ LANGUAGE plpgsql;


-- CRIA CHEFE
CREATE OR REPLACE PROCEDURE cria_pc(
  nome_novo_chefe CHAR(50),
  funcao_novo_npc CHAR(10),
  descricao_novo_npc CHAR(400),
  valor_nova_vida INTEGER,
  valor_nivel_chefe INTEGER
  valor_novo_atk_base INTEGER,
  valor_novo_arm_base INTEGER,
  valor_novo_ouro_drop INTEGER,
  valor_novo_orbs_drop INTEGER,
  arma_chefe INTEGER,
  sala_chefe INTEGER)
AS $$
DECLARE
  novo_id INTEGER;

BEGIN
  IF NOT EXISTS (SELECT 1
                 FROM Personagem
                 WHERE Personagem.nome = nome_novo_chefe) THEN

    INSERT INTO Personagem (nome)
    VALUES (nome_novo_chefe)
    RETURNING id_personagem INTO novo_id;
    
    INSERT INTO NPC (id_npc, funcao, descricao)
    VALUES (novp_id, funcao_novo_npc, descricao_novo_npc);

    INSERT INTO Inim_Comum (id_chefe, vida, nivel, atk_base, arm_base, ouro_drop, orb_drop, arma, sala)
    VALUES (novp_id, valor_nova_vida, valor_nivel_chefe, valor_novo_atk_base, valor_novo_arm_base, valor_novo_ouro_drop, valor_novo_orbs_drop,arma_chefe,sala_chefe);
  
  END IF;
END;
$$ LANGUAGE plpgsql;


-- CRIA  Instancia de Inimigo Comum
CREATE OR REPLACE PROCEDURE cria_pc(
  id_novo_inm_com INTEGER,
  id_nova_sala INTEGER)
DECLARE
  valor_nova_vida INTEGER,
  valor_nivel_inm_com INTEGER
  valor_novo_atk_base INTEGER,
  valor_novo_arm_base INTEGER,
  valor_novo_ouro_drop INTEGER,
  valor_novo_orbs_drop INTEGER,
AS $$
BEGIN
    
    SELECT Inm_Com.vida, Inm_Com.nivel, Inm_Com.atk_base, Inm_Com.arm_base, Inm_Com.ouro_drop, Inm_Com.orb_drop INTO 
            valor_nova_vida, valor_nivel_inm_com, valor_novo_atk_base, valor_novo_arm_base, valor_novo_ouro_drop, valor_novo_orbs_drop
    FROM Inimigo_Comum
    WHERE id_novo_inm_com = Inimigo_Comum.id_inm_com;

    INSERT INTO Instancia_inim_comum (id_inm_com, sala, vida, nivel, atk_base, arm_base, ouro_drop, orb_drop)
    VALUES (id_novo_inm_com, id_nova_sala, valor_nova_vida, valor_nivel_inm_com, valor_novo_atk_base, valor_novo_arm_base, valor_novo_ouro_drop, valor_novo_orbs_drop);
  
END;
$$ LANGUAGE plpgsql;
