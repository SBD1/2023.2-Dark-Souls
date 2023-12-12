-- REALIZA MUDANCA DE SALA
CREATE OR REPLACE FUNCTION realizou_troca_sala(
  id_pc_jogando INTEGER,
  sala_alvo CHAR(9)
)
RETURNS BOOLEAN
AS $troca_sala$
DECLARE
  id_sala_pc INTEGER;
  id_sala_alvo INTEGER;
  num_inm_sala INTEGER;
  dificuldade_sala_pc INTEGER;
  chefe_vivo BOOLEAN;
BEGIN


  SELECT Sala.id_sala, Sala.dificuldade INTO id_sala_pc, dificuldade_sala_pc
  FROM Sala
  JOIN PC ON PC.sala = Sala.id_sala
  WHERE PC.id_pc = id_pc_jogando;

  IF(dificuldade_sala_pc >= 1 AND dificuldade_sala_pc < 10) THEN
    SELECT COUNT(*) INTO num_inm_sala
    FROM Instancia_inim_Comum
    WHERE Instancia_inim_Comum.sala = id_sala_pc;
  END IF;

  IF (dificuldade_sala_pc = 10) THEN
    chefe_vivo := TRUE;
    SELECT
      CASE
        WHEN Chefe.vida = 0 THEN FALSE
        WHEN Chefe.vida > 0 THEN TRUE
        ELSE TRUE
      END
    INTO chefe_vivo
    FROM Chefe
    WHERE Chefe.sala = id_sala_pc;
  END IF;

  IF(num_inm_sala > 0 OR chefe_vivo = TRUE) THEN
  	RAISE NOTICE 'A sala possui inimigos';
    RETURN FALSE;
  ELSE

    IF(sala_alvo = 'proximo') THEN
      SELECT Viagem_Destino.id_destino INTO id_sala_alvo 
	  FROM Viagem_Destino 
	  WHERE Viagem_Destino.id_sala = id_sala_pc;
      
	  IF(id_sala_alvo IS NOT NULL) THEN
	  	UPDATE PC
      	SET sala = id_sala_alvo
      	WHERE id_pc = id_pc_jogando;
      	RETURN TRUE;
	  ELSE
	  	RAISE NOTICE 'Nao possui proxima sala, sala limite';
		RETURN FALSE;
	  END IF;
	  
    END IF;

    IF(sala_alvo = 'anterior') THEN
      SELECT Viagem_Destino.id_sala INTO id_sala_alvo 
	  FROM Viagem_Destino 
	  WHERE Viagem_Destino.id_destino = id_sala_pc;
	  
	  IF(id_sala_alvo IS NOT NULL) THEN 
      	UPDATE PC
      	SET sala = id_sala_alvo
      	WHERE id_pc = id_pc_jogando;
      	RETURN TRUE;
	  ELSE
	  	RAISE NOTICE 'Nao possui proxima sala, sala limite';
		RETURN FALSE;
	  END IF;
	  
    END IF;
  END IF;
END;
$troca_sala$ LANGUAGE plpgsql;

-- REALIZA MUDANCA DE MUNDO
CREATE OR REPLACE FUNCTION realizou_troca_mundo(
  id_pc_jogando INTEGER,
  mundo_alvo CHAR(9)
)
RETURN BOOLEAN
AS $troca_mundo$
DECLARE
  id_mundo_pc INTEGER;
  id_mundo_alvo INTEGER;
  id_sala_prox_mundo INTEGER;
  chefe_vivo BOOLEAN;
BEGIN

  
  SELECT Sala.mundo INTO id_mundo_pc
  FROM Sala
  JOIN PC ON PC.sala = Sala.id_sala
  WHERE PC.id_pc = id_pc_jogando;
   
  SELECT
    CASE
      WHEN Chefe.vida = 0 THEN FALSE
      WHEN Chefe.vida > 0 THEN TRUE
    END
  INTO chefe_vivo
  FROM Sala 
  JOIN Mundo ON Mundo.id_mundo = id_mundo_pc
  JOIN Chafe ON Chefe.sala = Sala.id_sala;

  
  IF(chefe_vivo = TRUE) THEN
    RETURN FALSE;
  ELSE 
    
    IF(mundo_alvo = 'proximo') THEN
      SELECT Viagem_Mundo_Destino.id_mundo_destino INTO id_mundo_alvo FROM Viagem_Mundo_Destino WHERE Viagem_Mundo_Destino.id_mundo = id_mundo_pc THEN
      SELECT Sala.id_sala INTO id_sala_prox_mundo FROM Sala Where Sala.mundo = id_mundo_alvo LIMIT 1 THEN
      UPDATE PC
      SET sala = id_sala_prox_mundo
      WHERE id_pc = id_pc_jogando;
      RETURN TRUE;
    END IF;
    
    IF(sala_alvo = 'anterior') THEN
      SELECT Viagem_Mundo_Destino.id_mundo INTO id_mundo_alvo FROM Viagem_Mundo_Destino WHERE Viagem_Mundo_Destino.id_mundo_destino = id_mundo_pc THEN
      SELECT Sala.id_sala INTO id_sala_prox_mundo FROM Sala Where Sala.mundo = id_mundo_alvo LIMIT 1 THEN
      UPDATE PC
      SET sala = id_sala_prox_mundo
      WHERE id_pc = id_pc_jogando;
      RETURN TRUE;
    END IF;
  
  END IF;
  ELSE
    RAISE NOTICE 'Nao possui Salas para viagem';
  END IF;
END;
$troca_sala$ LANGUAGE plpgsql;  

-- PC realiza ataque basico

CREATE OR REPLACE FUNCTION pc_realizou_atk_basico(
  id_pc_jogando INTEGER,
  id_npc_alvo INTEGER,
  eh_chefe BOOLEAN;
)
RETURNS BOOLEAN
AS $pc_atk_basico$
DECLARE
  dano_arma INTEGER;
  dano_base INTEGER;
  vida_npc INTEGER;
  armadura_npc INTEGER;
  ouro_dropado INTEGER;
  orb_dropada INTEGER;
  dano_causado INTEGER;
BEGIN

  SELECT Arma.val_dano INTO dano_arma
  FROM Arma
  JOIN PC ON PC.id_pc = id_pc_jogando
  WHERE PC.arma = Arma.id_arma;

  SELECT PC.atk_base INTO dano_base
  FROM PC
  WHERE PC.id_pc = id_pc_jogando;

  IF EXISTS (SELECT 1 FROM Instancia_inim_comum WHERE Instancia_inim_comum.id_instancia = id_npc_alvo) THEN
    SELECT Instancia_inim_comum.vida, Instancia_inim_comum.arm_base, Instancia_inim_comum.ouro_drop, Instancia_inim_comum.orb_drop INTO vida_npc, armadura_npc, ouro_dropado, orb_dropada
    FROM Instancia_inim_Comum
    WHERE Instancia_inim_Comum.id_instancia = id_npc_alvo;
  ELSE
  	IF EXISTS (SELECT 1 FROM Chefe WHERE Chefe.id_chefe = id_npc_alvo AND eh_chefe = TRUE) THEN
    	SELECT Chefe.vida, Chefe.arm_base, Chefe.ouro_drop, Chefe.orb_drop INTO vida_npc, armadura_npc, ouro_dropado, orb_dropada
    	FROM Chefe
    	WHERE Chefe.id_instancia = id_npc_alvo;
	ELSE
		RAISE NOTICE 'Nao existe Instancia deste Inimigo';
		RETURN FALSE;
	END IF;
  END IF;

  dano_causado := GREATEST(0, dano_arma + dano_base - armadura_npc);

  IF (eh_chefe = TRUE ) THEN
    IF(vida_npc - dano_causado <= 0) THEN
      UPDATE Chefe
      SET vida = 0
      WHERE id_instancia = id_npc_alvo;

      UPDATE PC
      SET ouro = ouro + ouro_dropado,
          orbs = orbs + orb_dropada
      WHERE PC.id_pc = id_pc_jogando;
		
	  RETURN TRUE;
	  
    ELSE
      UPDATE Chefe
      SET vida = vida - dano_causado
      WHERE id_instancia = id_npc_alvo;
	  RETURN TRUE;
    END IF;
  ELSE
    IF(vida_npc - dano_causado <= 0) THEN
      DELETE FROM Instancia_inim_Comum
      WHERE id_instancia = id_npc_alvo;

      UPDATE PC
      SET ouro = ouro + ouro_dropado,
          orbs = orbs + orb_dropada
      WHERE PC.id_pc = id_pc_jogando;
	  RETURN TRUE;
    ELSE
      UPDATE Instancia_inim_comum
      SET vida = vida - dano_causado
      WHERE id_instancia = id_npc_alvo;
	END IF;
  END IF;
  RETURN TRUE;
END;
$pc_atk_basico$ LANGUAGE plpgsql;

-- NPC realiza ataque basico

CREATE OR REPLACE FUNCTION npc_realizou_atk_basico(
  id_pc_jogando INTEGER,
  id_npc_atk INTEGER,
  eh_chefe BOOLEAN;
)
RETURNS BOOLEAN
AS $npc_atk_basico$
DECLARE
  dano_arma INTEGER DEFAULT 0;
  dano_base INTEGER;
  vida_pc INTEGER;
  arm_base_pc INTEGER;
  armadura_pc INTEGER;
  dano_causado INTEGER;
  eh_chefe BOOLEAN DEFAULT FALSE;
BEGIN

  SELECT Armadura.val_armor INTO armadura_pc
  FROM Armadura
  JOIN PC ON PC.id_pc = id_pc_jogando
  WHERE PC.armadura = Armadura.id_armadura;

  SELECT PC.vida, PC.arm_base INTO vida_pc, arm_base_pc
  FROM PC
  WHERE PC.id_pc = id_pc_jogando;

  IF EXISTS (SELECT 1 FROM Instancia_inim_comum WHERE Instancia_inim_comum.id_instancia = id_npc_alvo) THEN
    SELECT Instancia_inim_comum.atk_base INTO dano_base
    FROM Instancia_inim_Comum
    WHERE Instancia_inim_Comum.id_instancia = id_npc_atk;
  ELSE
    IF EXISTS (SELECT 1 FROM Chefe WHERE Chefe.id_chefe = id_npc_alvo and eh_chefe = TRUE) THEN
      SELECT Chefe.atk_base INTO dano_base
      FROM Chefe
      WHERE Chefe.id_instancia = id_npc_atk;

      SELECT Arma.val_dano INTO dano_arma
      FROM Arma
      JOIN Chefe ON Chefe.id_chefe = id_npc_atk
      WHERE Chefe.arma = Arma.id_arma;

    ELSE
      RAISE NOTICE 'Nao existe esta instancia para te atacar';
      RETURN FALSE;
	  END IF;
  END IF;

  dano_causado := GREATEST(0, dano_arma + dano_base - armadura_pc - arm_base_pc);

  IF(vida_pc - dano_causado <= 0) THEN
    UPDATE PC
    SET vida = 0
    WHERE id_pc = id_pc_jogando;
    RETURN TRUE;
  ELSE
    UPDATE PC
    SET vida = vida - dano_causado
    WHERE id_pc = id_pc_jogando;
  END IF;
  RETURN TRUE;
END;
$npc_atk_basico$ LANGUAGE plpgsql;

-- VIDA ATUAL DO PERSONAGEM

CREATE OR REPLACE PROCEDURE get_vida_atual(
  id_pc_jogando INTEGER
)
AS $get_vida_atual$
DECLARE
  vida_atual INTEGER;
BEGIN

  SELECT vida INTO vida_atual FROM PC WHERE id_pc = id_pc_jogando;
  
  RAISE NOTICE 'A vida atual do personagem é %', vida_atual;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE NOTICE 'Personagem não encontrado';
  WHEN OTHERS THEN
    RAISE NOTICE 'Um erro ocorreu';
END $get_vida_atual$ LANGUAGE plpgsql;

-- USAR benção
CREATE OR REPLACE FUNCTION usar_bencao(
  id_pc_usando INTEGER
)
RETURNS BOOLEAN
AS $usar_bencao$
DECLARE
  vida_bencao INTEGER;
  mana_bencao INTEGER;
  atk_base_bencao INTEGER;
  arm_base_bencao INTEGER;
  operacao_bencao CHAR(3);
  vida_pc INTEGER;
  mana_pc INTEGER;
  atk_base_pc INTEGER;
  arm_base_pc INTEGER;
BEGIN

  SELECT Bencao.vida, Bencao.mana, Bencao.atk_base, Bencao.arm_base, Bencao.operacao
  INTO vida_bencao, mana_bencao, atk_base_bencao, arm_base_bencao, operacao_bencao
  FROM Bencao
  WHERE Bencao.id_pc = id_pc_usando;

  IF NOT FOUND THEN
    RETURN FALSE;
  END IF;

  SELECT PC.vida, PC.mana, PC.atk_base, PC.arm_base
  INTO vida_pc, mana_pc, atk_base_pc, arm_base_pc
  FROM PC
  WHERE PC.id_pc = id_pc_usando;

  IF operacao_bencao = '+' THEN
    UPDATE PC
    SET vida = vida_pc + vida_bencao,
        mana = mana_pc + mana_bencao,
        atk_base = atk_base_pc + atk_base_bencao,
        arm_base = arm_base_pc + arm_base_bencao
    WHERE id_pc = id_pc_usando;
  ELSEIF operacao_bencao = '-' THEN
    UPDATE PC
    SET vida = vida_pc - vida_bencao,
        mana = mana_pc - mana_bencao,
        atk_base = atk_base_pc - atk_base_bencao,
        arm_base = arm_base_pc - arm_base_bencao
    WHERE id_pc = id_pc_usando;
  END IF;

  RETURN TRUE;
END;
$usar_bencao$ LANGUAGE plpgsql;

-- Usar poção de vida
CREATE OR REPLACE PROCEDURE usar_pocao_vida(
  id_pc_usando INTEGER,
  id_pocao INTEGER)
AS $$
DECLARE
  val_vida INTEGER;
  max_utilizacao_cons INTEGER;
BEGIN
  -- Seleciona a poção de vida com base no id_pocao
  SELECT Pocao_Vida.val_vida, Consumivel.max_utilizacao
  INTO val_vida, max_utilizacao_cons
  FROM Pocao_Vida, Consumivel
  WHERE Pocao_Vida.id_pocao_vida = id_pocao AND Consumivel.id_cons = id_pocao;

  -- Verifica se a poção de vida foi encontrada e se ainda pode ser usada
  IF NOT FOUND OR max_utilizacao_cons <= 0 THEN
    RAISE NOTICE 'Poção de vida não encontrada ou já foi totalmente utilizada';
  ELSE
    -- Atualiza a vida do personagem principal
    UPDATE PC
    SET vida = vida + val_vida
    WHERE id_pc = id_pc_usando;

    -- Atualiza a quantidade de utilizações restantes da poção de vida
    UPDATE Consumivel
    SET max_utilizacao = max_utilizacao_cons - 1
    WHERE id_cons = id_pocao;

    RAISE NOTICE 'Poção de vida usada com sucesso!';
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Usar poção de mana
CREATE OR REPLACE PROCEDURE usar_pocao_mana(
  id_pc_usando INTEGER,
  id_pocao INTEGER)
AS $$
DECLARE
  val_mana INTEGER;
  max_utilizacao_cons INTEGER;
BEGIN
  -- Seleciona a poção de mana com base no id_pocao
  SELECT Pocao_Mana.val_mana, Consumivel.max_utilizacao
  INTO val_mana, max_utilizacao_cons
  FROM Pocao_Mana, Consumivel
  WHERE Pocao_Mana.id_pocao_mana = id_pocao AND Consumivel.id_cons = id_pocao;

  -- Verifica se a poção de mana foi encontrada e se ainda pode ser usada
  IF NOT FOUND OR max_utilizacao_cons <= 0 THEN
    RAISE NOTICE 'Poção de mana não encontrada ou já foi totalmente utilizada';
  ELSE
    -- Atualiza a mana do personagem principal
    UPDATE PC
    SET mana = mana + val_mana
    WHERE id_pc = id_pc_usando;

    -- Atualiza a quantidade de utilizações restantes da poção de mana
    UPDATE Consumivel
    SET max_utilizacao = max_utilizacao_cons - 1
    WHERE id_cons = id_pocao;

    RAISE NOTICE 'Poção de mana usada com sucesso!';
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Procedimento para trocar de arma
CREATE OR REPLACE PROCEDURE troca_arma(
  p_id_pc INTEGER,
  id_nova_arma INTEGER)
AS $$
DECLARE
  id_arma_atual INTEGER;
BEGIN
  -- Obtém a arma atual do personagem
  SELECT arma INTO id_arma_atual
  FROM PC
  WHERE id_pc = p_id_pc;

  -- Verifica se a nova arma está no inventário do personagem
  IF EXISTS (SELECT 1
             FROM Instancia_Item
             WHERE id_invent = p_id_pc AND id_item = id_nova_arma) THEN

    -- Troca a arma atual do personagem pela nova arma
    UPDATE PC
    SET arma = id_nova_arma
    WHERE id_pc = p_id_pc;

    -- Atualiza o inventário do personagem
    DELETE FROM Instancia_Item
    WHERE id_invent = p_id_pc AND id_item = id_nova_arma;

    INSERT INTO Instancia_Item (id_invent, id_item)
    VALUES (p_id_pc, id_arma_atual);
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Procedimento para trocar de armadura
CREATE OR REPLACE PROCEDURE troca_armadura(
  p_id_pc INTEGER,
  id_nova_armadura INTEGER)
AS $$
DECLARE
  id_armadura_atual INTEGER;
BEGIN
  -- Obtém a armadura atual do personagem
  SELECT armadura INTO id_armadura_atual
  FROM PC
  WHERE id_pc = p_id_pc;

  -- Verifica se a nova armadura está no inventário do personagem
  IF EXISTS (SELECT 1
             FROM Instancia_Item
             WHERE id_invent = p_id_pc AND id_item = id_nova_armadura) THEN

    -- Troca a armadura atual do personagem pela nova armadura
    UPDATE PC
    SET armadura = id_nova_armadura
    WHERE id_pc = p_id_pc;

    -- Atualiza o inventário do personagem
    DELETE FROM Instancia_Item
    WHERE id_invent = p_id_pc AND id_item = id_nova_armadura;

    INSERT INTO Instancia_Item (id_invent, id_item)
    VALUES (p_id_pc, id_armadura_atual);
  END IF;
END;
$$ LANGUAGE plpgsql;