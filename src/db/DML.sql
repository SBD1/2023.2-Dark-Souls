INSERT INTO mundo (nome, data_criacao, data_atualizacao)
VALUES
  ('Tártaro', NOW(), NOW()),
  ('O Campo de Asfódelos', NOW(), NOW()),
  ('Campos Elísios', NOW(), NOW()),
  ('Saída do Submundo', NOW(), NOW());


INSERT INTO sala (tipo, descricao, eh_chefe, eh_npc, mundo_id, data_criacao, data_atualizacao)
VALUES
  ('Sala Normal', 'Sala normal do Tártaro', FALSE, FALSE, 1, NOW(), NOW()),
  ('Sala Chefe', 'Sala do chefe do Tártaro', TRUE, FALSE, 1, NOW(), NOW()),
  ('Sala NPC', 'Sala do NPC Sísifo', FALSE, TRUE, 1, NOW(), NOW()),
  ('Sala Normal', 'Sala normal do Campo de Asfódelos', FALSE, FALSE, 2, NOW(), NOW()),
  ('Sala Chefe', 'Sala do chefe do Campo de Asfódelos', TRUE, FALSE, 2, NOW(), NOW()),
  ('Sala NPC', 'Sala do NPC Eurídice', FALSE, TRUE, 2, NOW(), NOW()),
  ('Sala Normal', 'Sala normal dos Campos Elísios', FALSE, FALSE, 3, NOW(), NOW()),
  ('Sala Chefe', 'Sala do chefe dos Campos Elísios', TRUE, FALSE, 3, NOW(), NOW()),
  ('Sala NPC', 'Sala do NPC Pátroclo', FALSE, TRUE, 3, NOW(), NOW()),
  ('Sala Normal', 'Sala normal da Saída do Submundo', FALSE, FALSE, 4, NOW(), NOW()),
  ('Sala Chefe', 'Sala do chefe da Saída do Submundo', TRUE, FALSE, 4, NOW(), NOW()),
  ('Sala NPC', 'Sala do NPC Caronte', FALSE, TRUE, 4, NOW(), NOW());


INSERT INTO npc (nome, mundo_id, funcao, descricao_completa, data_criacao, data_atualizacao)
VALUES
  ('Sísifo', 1, 'Fornece ouro, orbes roxos ou vida', 'Sísifo é condenado a empurrar uma pedra morro acima para sempre. Ele é um NPC amigável que pode fornecer recompensas ao jogador.', NOW(), NOW()),
  ('Caronte', 1, 'Fornece bênçãos temporárias', 'Caronte é o barqueiro que leva os mortos para o Submundo. Ele é um NPC neutro que pode fornecer bênçãos temporárias ao jogador.', NOW(), NOW()),
  ('Euridice', 2, 'Evolui duas bênçãos aleatórias de raridade ou quatro bênçãos de nível ou dá vida', 'Euridice é uma mulher que Hades amava. Ela é uma NPC amigável que pode evoluir as bênçãos do jogador.', NOW(), NOW()),
  ('Pátroclo', 3, 'Fornece upgrades de dano por 10 câmaras, restaura "Desafios à Morte" ou dá vida', 'Pátroclo foi o amigo de Aquiles. Ele é um NPC amigável que pode fornecer upgrades ao jogador.', NOW(), NOW()),
  ('Caronte', 4, 'Fornece bençãos temporárias', 'Caronte é o barqueiro que leva os mortos para o Submundo. Ele é um NPC neutro que pode fornecer bênçãos temporárias ao jogador.', NOW(), NOW());


INSERT INTO chefe (nome, mundo_id, data_criacao, data_atualizacao)
VALUES
  ('As 3 Fúrias', 1, NOW(), NOW()),
  ('Hydra', 2, NOW(), NOW()),
  ('Teseu e Astério', 3, NOW(), NOW()),
  ('Hades', 4, NOW(), NOW());


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
VALUES
  (1, 1, NOW(), NOW()),
  (2, 1, NOW(), NOW()),
  (3, 1, NOW(), NOW()),
  (4, 1, NOW(), NOW()),
  (5, 1, NOW(), NOW()),
  (6, 1, NOW(), NOW()),
  (7, 1, NOW(), NOW()),
  (8, 1, NOW(), NOW()),
  (9, 1, NOW(), NOW()),
  (10, 1, NOW(), NOW()),
  (11, 1, NOW(), NOW());


INSERT INTO pc (nome, data_criacao, data_atualizacao)
VALUES
  ('O jogador', NOW(), NOW());


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
  ('O jogador', 1);
