CREATE DATABASE hades;


CREATE TABLE mundo (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE sala (
  id INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  eh_chefe BOOLEAN NOT NULL,
  eh_npc BOOLEAN NOT NULL,
  mundo_id INT NOT NULL,
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (mundo_id) REFERENCES mundo (id)
);


CREATE TABLE npc (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  mundo_id INT NOT NULL,
  funcao VARCHAR(255) NOT NULL,
  descricao_completa VARCHAR(255),
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (mundo_id) REFERENCES mundo (id)
);


CREATE TABLE npc (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  mundo_id INT NOT NULL,
  armadura INT NOT NULL,
  descricao_completa VARCHAR(255),
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (mundo_id) REFERENCES mundo (id)
);


CREATE TABLE chefe (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  mundo_id INT NOT NULL,
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (mundo_id) REFERENCES mundo (id)
);


CREATE TABLE npc_room (
  id INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  sala_id INT NOT NULL,
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (sala_id) REFERENCES sala (id),
  FOREIGN KEY (npc_id) REFERENCES NPC (id)
);


CREATE TABLE npc_room (
  id INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  sala_id INT NOT NULL,
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (sala_id) REFERENCES sala (id),
  FOREIGN KEY (npc_id) REFERENCES NPC (id),
);


CREATE TABLE pc (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  status BOOLEAN NOT NULL,
  sala_id INT NOT NULL,
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (sala_id) REFERENCES sala (id)
);


CREATE TABLE bencao (
id INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL UNIQUE,
raridade VARCHAR(255) NOT NULL CHECK (raridade IN (‘Comum’, ‘Raro’, ‘Épico’, ‘Heroico’, ‘Lendário’, ‘Duo’)),
habilidade VARCHAR(255) NOT NULL CHECK (habilidade IN (‘Ataque’, ‘Especial’, ‘Elenco’, ‘Traço’, ‘Chamada’)),
nivel INT NOT NULL CHECK (nivel >0 AND nivel <=5),
data_criacao DATETIME NOT NULL,
data_atualizacao DATETIME NOT NULL,
PRIMARY KEY (id)
);


CREATE TABLE arma (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL UNIQUE,
  tipo VARCHAR(255) NOT NULL CHECK (tipo IN (‘Espada’, ‘Lança’, ‘Escudo’, ‘Arco’, ‘Punho’, ‘Foice’)),
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE inventario (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL, tipo VARCHAR(255) NOT NULL CHECK (tipo IN (‘Item’, ‘Arma’, ‘Bencao’)),
  jogador_id INT NOT NULL,
  data_criacao DATETIME NOT NULL,
  data_atualizacao DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (jogador_id) REFERENCES pc (id)
);
