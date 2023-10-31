SELECT id_mundo, nome, data_criacao, data_atualizacao
FROM mundo;


SELECT *
FROM mundo
WHERE nome = 'Tártaro';


SELECT chefe.id_chefe, chefe.nome, chefe.mundo_id, chefe.data_criacao, chefe.data_atualizacao
FROM chefe;


SELECT *
FROM chefe
WHERE nome = 'As 3 Fúrias';


SELECT npc.id_npc, npc.nome, npc.mundo_id, npc.funcao, npc.descricao_completa, npc.data_criacao, npc.data_atualizacao
FROM npc;


SELECT *
FROM npc
WHERE nome = 'Caronte';


SELECT
  inventario.id_inventário AS id_inventário,
  inventario.nome AS nome_inventário,
  inventario.tipo AS tipo_inventário,
  personagem.nome AS nome_personagem
FROM inventario
JOIN personagem ON inventario.jogador_id = personagem.id_personagem;


SELECT bencao.id_bencao, bencao.nome, bencao.raridade, bencao.habilidade, bencao.nivel, personagem.nome
FROM bencao_player
JOIN bencao ON bencao_player.bencao_id = bencao.id_bencao
JOIN personagem ON bencao_player.jogador_id = personagem.id_personagem;


SELECT bencao.id_bencao, bencao.nome, bencao.raridade, bencao.habilidade, bencao.nivel
FROM bencao
WHERE bencao.nome = 'Benção de Zeus';


SELECT personagem.id_personagem, personagem.nome
FROM personagem;


SELECT nome, tipo
FROM inventario_player
WHERE nome = 'Romã do poder';


SELECT *
FROM arma
WHERE nome = 'Stygius';


SELECT arma.id_arma, arma.nome, arma.tipo, arma.data_criacao, arma.data_atualizacao
FROM arma;
