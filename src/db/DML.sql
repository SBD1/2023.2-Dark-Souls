INSERT INTO mundo (nome, data_criacao, data_atualizacao)
VALUES
  ('Tártaro', NOW(), NOW()),
  ('O Campo de Asfódelos', NOW(), NOW()),
  ('Campos Elísios', NOW(), NOW()),
  ('Saída do Submundo', NOW(), NOW());

INSERT INTO sala (tipo, descricao, eh_chefe, eh_npc, mundo_id, data_criacao, data_atualizacao)
SELECT 'Sala Normal', 'Sala normal do Tártaro', FALSE, FALSE, id, NOW(), NOW() FROM mundo WHERE nome = 'Tártaro'
UNION ALL SELECT 'Sala Chefe', 'Sala do chefe do Tártaro', TRUE, FALSE, id, NOW(), NOW() FROM mundo WHERE nome = 'Tártaro'
UNION ALL SELECT 'Sala NPC', 'Sala do NPC Sísifo', FALSE, TRUE, id, NOW(), NOW() FROM mundo WHERE nome = 'Tártaro'
UNION ALL SELECT 'Sala Normal', 'Sala normal do Campo de Asfódelos', FALSE, FALSE, id, NOW(), NOW() FROM mundo WHERE nome = 'O Campo de Asfódelos'
UNION ALL SELECT 'Sala Chefe', 'Sala do chefe do Campo de Asfódelos', TRUE, FALSE, id, NOW(), NOW() FROM mundo WHERE nome = 'O Campo de Asfódelos'
UNION ALL SELECT 'Sala NPC', 'Sala do NPC Eurídice', FALSE, TRUE, id, NOW(), NOW() FROM mundo WHERE nome = 'O Campo de Asfódelos'
UNION ALL SELECT 'Sala Normal', 'Sala normal dos Campos Elísios', FALSE, FALSE, id, NOW(), NOW() FROM mundo WHERE nome = 'Campos Elísios'
UNION ALL SELECT 'Sala Chefe', 'Sala do chefe dos Campos Elísios', TRUE, FALSE, id, NOW(), NOW() FROM mundo WHERE nome = 'Campos Elísios'
UNION ALL SELECT 'Sala NPC', 'Sala do NPC Pátroclo', FALSE, TRUE, id, NOW(), NOW() FROM mundo WHERE nome = 'Campos Elísios'
UNION ALL SELECT 'Sala Normal', 'Sala normal da Saída do Submundo', FALSE, FALSE, id, NOW(), NOW() FROM mundo WHERE nome = 'Saída do Submundo'
UNION ALL SELECT 'Sala Chefe', 'Sala do chefe da Saída do Submundo', TRUE, FALSE, id, NOW(), NOW() FROM mundo WHERE nome = 'Saída do Submundo'
UNION ALL SELECT 'Sala NPC', 'Sala do NPC Caronte', FALSE, TRUE, id, NOW(), NOW() FROM mundo WHERE nome = 'Saída do Submundo';

INSERT INTO npc (nome, mundo_id, funcao, descricao_completa, data_criacao, data_atualizacao)
SELECT 'Sísifo', id,'Fornece ouro orbes roxos ou vida','Sísifo é condenado a empurrar uma pedra morro acima para sempre. Ele é um NPC amigável que pode fornecer recompensas ao jogador.',NOW(),NOW() FROM mundo WHERE nome = 'Tártaro'
UNION ALL SELECT'Caronte',id,'Fornece bênçãos temporárias','Caronte é o barqueiro que leva os mortos para o Submundo. Ele é um NPC neutro que pode fornecer bênçãos temporárias ao jogador.',NOW(),NOW() FROM mundo WHERE nome =  'Tártaro'
UNION ALL SELECT'Euridice',id,'Evolui duas bênçãos aleatórias de raridade ou quatro bênçãos de nível ou dá vida','Euridice é uma mulher que Hades amava. Ela é uma NPC amigável que pode evoluir as bênçãos do jogador.',NOW(),NOW() FROM mundo WHERE nome =  'O Campo de Asfódelos'
UNION ALL SELECT'Pátroclo',id,'Fornece upgrades de dano por 10 câmaras restaura "Desafios à Morte" ou dá vida','Pátroclo foi o amigo de Aquiles. Ele é um NPC amigável que pode fornecer upgrades ao jogador.',NOW(),NOW() FROM mundo WHERE nome =  'Campos Elísios'
UNION ALL SELECT'Caronte',id,'Fornece bençãos temporárias','Caronte é o barqueiro que leva os mortos para o Submundo. Ele é um NPC neutro que pode fornecer bênçãos temporárias ao jogador.',NOW(),NOW() FROM mundo WHERE nome =  'Saída do Submundo';

INSERT INTO chefe (nome, mundo_id, data_criacao, data_atualizacao)
SELECT 'As 3 Fúrias', id, NOW(), NOW() FROM mundo WHERE nome = 'Tártaro'
UNION ALL SELECT 'Hydra', id, NOW(), NOW() FROM mundo WHERE nome = 'O Campo de Asfódelos'
UNION ALL SELECT 'Teseu e Astério', id, NOW(), NOW() FROM mundo WHERE nome = 'Campos Elísios'
UNION ALL SELECT 'Hades', id, NOW(), NOW() FROM mundo WHERE nome = 'Saída do Submundo';

INSERT INTO bencao (nome, raridade, habilidade, nivel, data_criacao, data_atualizacao)
VALUES
  ('Benção de Zeus', 'Lendária', 'Invocar Raios', 1, NOW(), NOW()),
  ('Benção de Poseidon', 'Rara', 'Empurra os inimigos para longe', 1, NOW(), NOW()),
  ('Benção de Ártemis', 'Épica', 'Aumenta a chance de dano crítico do jogador', 1, NOW(), NOW()),
  ('Benção de Ares', 'Lendária', 'Inflige condenação aos inimigos', 1, NOW(), NOW()),
  ('Benção de Atenas', 'Rara', 'Reflete os ataques inimigos', 1, NOW(), NOW()),
  ('Benção de Afrodite', 'Épica', 'Faz os inimigos ficarem fracos', 1, NOW(), NOW()),
  ('Benção de Caos', 'Lendária', 'Concede uma habilidade aleatória', 1, NOW(), NOW()),
  ('Benção de Hermes', 'Rara', 'Aumenta a velocidade do jogador', 1, NOW(), NOW()),
  ('Benção de Deméter', 'Épica', 'Aplica frio aos inimigos', 1, NOW(), NOW()),
  ('Benção de Dionísio', 'Rara', 'Intoxica os inimigos', 1, NOW(), NOW()),
  ('Benção de Aquiles', 'Épica', 'Contribui para a liberação de novas armas e diálogo na história', 1, NOW(), NOW());


INSERT INTO bencao_player (bencao_id, jogador_id, data_criacao, data_atualizacao)
SELECT id, 1, NOW(), NOW() FROM bencao;

INSERT INTO pc (nome, status, sala_id, data_criacao, data_atualizacao)
VALUES
  ('O jogador', TRUE, (SELECT id FROM sala LIMIT 1), NOW(), NOW());

INSERT INTO inventario_player (nome, tipo, jogador_id, data_criacao, data_atualizacao)
VALUES
  ('Romã do poder', 'Item', 1, NOW(), NOW());

INSERT INTO arma (nome, tipo, data_criacao, data_atualizacao)
VALUES
  ('Stygius', 'Lâmina Estigia', NOW(), NOW()),
  ('Varatha', 'Lança Eterna', NOW(), NOW()),
  ('Aegis', 'Escudo do Caos', NOW(), NOW()),
  ('Malphôn', 'Punhos Gêmeos', NOW(), NOW()),
  ('Coronacht', 'Arco em Busca de Coração', NOW(), NOW()),
  ('Exagryph', 'Canhão de Diamante', NOW(), NOW());

INSERT INTO personagem (nome, pc_id)
VALUES
  ('O jogador', (SELECT id FROM pc WHERE nome = 'O jogador'));
