-- REALIZA MUDANCA DE SALA
CREATE OR REPLACE FUNCTION realizou_troca_sala(
  id_pc_jogando INTEGER,
  sala_alvo CHAR(9)
)
RETURN BOOLEAN
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
    RETURN FALSE;
  ELSE 
    
    IF(sala_alvo = 'proximo') THEN
      SELECT Viagem_Destino.id_destino INTO id_sala_alvo FROM Viagem_Destino WHERE Viagem_Destino.id_sala = id_sala_pc THEN
      UPDATE PC
      SET sala = id_sala_alvo
      WHERE id_pc = id_pc_jogando;
      RETURN TRUE;
    END IF;
    
    IF(sala_alvo = 'anterior') THEN
      SELECT Viagem_Destino.id_sala INTO id_sala_alvo FROM Viagem_Destino WHERE Viagem_Destino.id_destino = id_sala_pc THEN
      UPDATE PC
      SET sala = id_sala_alvo
      WHERE id_pc = id_pc_jogando;
      RETURN TRUE;
    END IF;
  
  END IF;
  ELSE
    RAISE NOTICE 'Nao possui Salas para viagem';
  END IF;
END;
$troca_sala$ LANGUAGE plpgsql;  

-- REALIZA MUDANCA DE SALA
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
  id_npc_alvo INTEGER
)
AS $pc_atk_basico$
DECLARE
  dano_arma INTEGER;
  dano_base INTEGER;
  vida_npc INTEGER;
  armadura_npc INTEGER;
  ouro_dropado INTEGER;
  orb_dropada INTEGER;
  dano_causado INTEGER;
  eh_chefe INTEGER DEFAULT FALSE;
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
    eh_chefe := TRUE;
    SELECT Chefe.vida, Chefe.arm_base, Chefe.ouro_drop, Chefe.orb_drop INTO vida_npc, armadura_npc, ouro_dropado, orb_dropada  
    FROM Chefe
    WHERE Chefe.id_instancia = id_npc_alvo;
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
    
    ELSE
      UPDATE Chefe
      SET vida = vida - dano_causado
      WHERE id_instancia = id_npc_alvo;
    END IF;
  ELSE  
    IF(vida_npc - dano_causado <= 0) THEN
      DELETE FROM Instancia_inim_Comum 
      WHERE id_instancia = id_npc_alvo;
    
    UPDATE PC 
    SET ouro = ouro + ouro_dropado,
          orbs = orbs + orb_dropada
    WHERE PC.id_pc = id_pc_jogando;
    END IF;
  END IF;
      
END;
$pc_realiza_atk_basico$ LANGUAGE plpgsql;  


-- PC realiza ataque basico

CREATE OR REPLACE FUNCTION npc_realizou_atk_basico(
  id_pc_jogando INTEGER,
  id_npc_atk INTEGER
)
AS $npc_atk_basico$
DECLARE
  dano_arma INTEGER DEFAULT 0;
  dano_base INTEGER;
  vida_pc INTEGER;
  arm_base_pc INTEGER;
  armadura_pc INTEGER;
  dano_causado INTEGER;
  eh_chefe INTEGER DEFAULT FALSE;
BEGIN
  
  SELECT Armadura.val_armor INTO 
  FROM Armadura
  JOIN PC ON PC.id_pc = id_pc_jogando
  WHERE PC.armadura = Armadura.id_armadura;

  SELECT PC.vida, PC.arm_base INTO vida_pc, arm_base_pc_base
  FROM PC 
  WHERE PC.id_pc = id_pc_jogando;
  
  IF EXISTS (SELECT 1 FROM Instancia_inim_comum WHERE Instancia_inim_comum.id_instancia = id_npc_alvo) THEN
    SELECT Instancia_inim_comum.atk_base INTO dano_base  
    FROM Instancia_inim_Comum
    WHERE Instancia_inim_Comum.id_instancia = id_npc_atk;
  ELSE
    eh_chefe := TRUE;
    SELECT Chefe.atk_base INTO dano_base  
    FROM Chefe
    WHERE Chefe.id_instancia = id_npc_atk;
    
    SELECT Arma.val_dano INTO dano_arma
    FROM Arma
    JOIN Chefe ON Chefe.id_chefe = id_npc_atk
    WHERE Chefe.arma = Arma.id_arma;
  END IF;

  dano_causado := GREATEST(0, dano_arma + dano_base - armadura_pc - arm_base_pc);
  
  IF(vida_pc - dano_causado <= 0) THEN
    UPDATE PC
    SET vida = 0
    WHERE id_pc = id_pc_jogando;
  ELSE
    UPDATE PC 
    SET vida = vida - dano_causado
    WHERE id_pc = id_pc_jogando;
  END IF;
      
END;
$npc_realiza_atk_basico$ LANGUAGE plpgsql;  
