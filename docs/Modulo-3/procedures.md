# Procedures

O documento apresentado tem como objetivo conter os procedures necessários para o funcionamento do jogo

## Utilização de ataque básico do personagem pc 

#### **Objetivo** 
O personagem principal realiza um ataque básico sobre um npc na sala que se encontra, retirando-o uma quantidade de vida, atributo do npc.

#### **Processo**
<div>
    <ul>
        <li> Selecio-se o valor do ataque básico do pc.
        <li> Verifica se a vida do npc se encontra acima do valor 0.
        <li> Caso sim, realiza a redução da vida do npc e atualiza ela no banco.
    </ul>
</div>

```sql
CREATE OR REPLACE PROCEDURE realizou_atk_basico(
  id_pc_jogando INTEGER,
  id_npc_alvo INTEGER
)
AS $atk_basico$
DECLARE
  val_dano_pc INTEGER;
  val_vida_npc INTEGER;
BEGIN
  SELECT PC.atk_base INTO val_dano_pc
  FROM PC 
  WHERE pc.id_pc = id_pc_jogando;
  
  IF (SELECT Inimigo_Comum.vida FROM Inimigo_Comum WHERE Inimigo_Comum.id_inm_com = id_npc_alvo) <= 0 THEN
    RAISE NOTICE 'Inimigo morto';
  ELSE
    UPDATE Inimigo_Comum
    SET vida = vida - val_dano_pc
    WHERE id_npc_alvo = Inimigo_Comum.id_inm_com;
  END IF;
 END;
$atk_basico$ LANGUAGE plpgsql;
```

## Realiza a troca de sala do personagem pc 

#### **Objetivo** 
O personagem principal realiza uma troca de sala alguma das salas posteriores disponíveis.

#### **Processo**
<div>
    <ul>
        <li> Selecio-se a sala que o pc se encontra atualmente.
        <li> Verifica se sala esta disponível em uma tabela que guarda as viagens aceitas pelo jogo.
        <li> Caso sim, realiza a troca de sala do pc e atualiza ela no banco
    </ul>
</div>

|    Data    | Versão | Descrição                   | Autores                                                      |
| :--------: | :----: | --------------------------- | ------------------------------------------------------------ |
| 04/12/2023 | `1.0`  | Criação da primeira versão. | [Francisco Mizael Santos da Silca](https://github.com/frmiza) |
