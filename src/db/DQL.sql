SELECT id AS id_mundo, nome, data_criacao, data_atualizacao
FROM mundo;

SELECT *
FROM mundo
WHERE nome = 'Tártaro';

SELECT id AS id_chefe, nome, mundo_id, data_criacao, data_atualizacao
FROM chefe;

SELECT *
FROM chefe
WHERE nome = 'As 3 Fúrias';

SELECT id AS id_npc, nome, mundo_id, funcao, descricao_completa, data_criacao, data_atualizacao
FROM npc;

SELECT *
FROM npc
WHERE nome = 'Caronte';

SELECT
  inventario.id AS id_inventario,
  inventario.nome AS nome_inventario,
  inventario.tipo AS tipo_inventario,
  pc.nome AS nome_personagem
FROM inventario_player AS inventario
JOIN pc ON inventario.jogador_id = pc.id;

SELECT bencao.id AS id_bencao, bencao.nome, bencao.raridade, bencao.habilidade, bencao.nivel, pc.nome
FROM bencao_player
JOIN bencao ON bencao_player.bencao_id = bencao.id
JOIN pc ON bencao_player.jogador_id = pc.id;

SELECT id AS id_bencao, nome, raridade, habilidade, nivel
FROM bencao
WHERE nome = 'Benção de Zeus';

SELECT id AS id_personagem, nome
FROM pc;

SELECT nome, tipo
FROM inventario_player
WHERE nome = 'Romã do poder';

SELECT *
FROM arma
WHERE nome = 'Stygius';

SELECT id AS id_arma, nome, tipo, data_criacao, data_atualizacao
FROM arma;
