CREATE DATABASE hades;

CREATE TABLE mundo (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  data_criacao TIMESTAMP NOT NULL,
  data_atualizacao TIMESTAMP NOT NULL
);

CREATE TABLE sala (
  id SERIAL PRIMARY KEY,
  tipo VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  eh_chefe BOOLEAN NOT NULL,
  eh_npc BOOLEAN NOT NULL,
  mundo_id INT NOT NULL REFERENCES mundo(id),
  data_criacao TIMESTAMP NOT NULL,
  data_atualizacao TIMESTAMP NOT NULL
);

CREATE TABLE npc (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  mundo_id INT NOT NULL REFERENCES mundo(id),
  funcao VARCHAR(255) NOT NULL,
  descricao_completa VARCHAR(255),
  data_criacao TIMESTAMP NOT NULL,
  data_atualizacao TIMESTAMP NOT NULL
);

CREATE TABLE chefe (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  mundo_id INT NOT NULL REFERENCES mundo(id),
  data_criacao TIMESTAMP NOT NULL,
  data_atualizacao TIMESTAMP NOT NULL
);

CREATE TABLE npc_sala (
  id SERIAL PRIMARY KEY,
  tipo VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  sala_id INT NOT NULL REFERENCES sala(id),
  npc_id INT NOT NULL REFERENCES npc(id),
  data_criacao TIMESTAMP NOT NULL,
  data_atualizacao TIMESTAMP NOT NULL
);

CREATE TABLE pc (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  status BOOLEAN NOT NULL,
  sala_id INT NOT NULL REFERENCES sala(id),
  data_criacao TIMESTAMP NOT NULL,
  data_atualizacao TIMESTAMP NOT NULL
);

CREATE TABLE bencao (
id SERIAL PRIMARY KEY,
nome VARCHAR(255) UNIQUE NOT NULL,
raridade VARCHAR(255) CHECK (raridade IN ('Comum', 'Raro', 'Épico', 'Heroico', 'Lendário', 'Duo')) NOT NULL,
habilidade VARCHAR(255) CHECK (habilidade IN ('Ataque', 'Especial', 'Elenco', 'Traço', 'Chamada')) NOT NULL,
nivel INT CHECK (nivel >0 AND nivel <=5) NOT NULL,
data_criacao TIMESTAMP NOT NULL,
data_atualizacao TIMESTAMP NOT NULL
);

CREATE TABLE arma (
id SERIAL PRIMARY KEY,
nome VARCHAR(255) UNIQUE NOT NULL,
tipo VARCHAR(255) CHECK (tipo IN ('Espada', 'Lança', 'Escudo', 'Arco', 'Punho', 'Foice')) NOT NULL,
data_criacao TIMESTAMP NOT NULL,
data_atualizacao TIMESTAMP NOT NULL
);

CREATE TABLE inventario (
id SERIAL PRIMARY KEY,
nome VARCHAR(255) UNIQUE NOT NULL, 
tipo VARCHAR(255) CHECK (tipo IN ('Item', 'Arma', 'Bencao'))NOT NULL, 
jogador_id INT REFERENCES pc(id)NOT NULL, 
data_criacao TIMESTAMP NOT NULL, 
data_atualizacao TIMESTAMP NOT NULL
);
