CREATE DATABASE hades;
ROLLBACK;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS Bencao;
DROP TABLE IF EXISTS Instancia_Inim_Comum;
DROP TABLE IF EXISTS Instancia_Item;
DROP TABLE IF EXISTS PC;
DROP TABLE IF EXISTS Chefe;
DROP TABLE IF EXISTS Inimigo_Comum;
DROP TABLE IF EXISTS Mercador;
DROP TABLE IF EXISTS NPC;
DROP TABLE IF EXISTS Personagem;
DROP TABLE IF EXISTS Viagem_Destino;
DROP TABLE IF EXISTS Viagem_Origem;
DROP TABLE IF EXISTS Sala;
DROP TABLE IF EXISTS Viagem_Mundo_Destino;
DROP TABLE IF EXISTS Viagem_Mundo_Origem;
DROP TABLE IF EXISTS Mundo;
DROP TABLE IF EXISTS Pocao_Mana;
DROP TABLE IF EXISTS Pocao_Vida;
DROP TABLE IF EXISTS Consumivel;
DROP TABLE IF EXISTS Orbs;
DROP TABLE IF EXISTS Armadura;
DROP TABLE IF EXISTS Arma;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Inventario;

CREATE TABLE Item (
    id_item SERIAL,
    nome VARCHAR(50) NOT NULL,
    descricao CHAR(400) NOT NULL,
    valor_ouro INT NOT NULL,
    tipo CHAR(25) NOT NULL,
    nivel_min INT NOT NULL,
    PRIMARY KEY (id_item)
);

CREATE TABLE Arma (
    id_arma SERIAL,
    val_dano INT NOT NULL,
    raridade CHAR(25) NOT NULL,
    FOREIGN KEY (id_arma) REFERENCES Item(id_item)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    PRIMARY KEY (id_arma)
);

CREATE TABLE Armadura (
    id_armadura SERIAL,
    val_armor INT NOT NULL,
    PRIMARY KEY (id_armadura),
    FOREIGN KEY (id_armadura) REFERENCES Item(id_item)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Orbs (
    id_orbs SERIAL,
    PRIMARY KEY (id_orbs),
    FOREIGN KEY (id_orbs) REFERENCES Item(id_item)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Consumivel (
    id_cons SERIAL,
    max_utilizacao INT NOT NULL,
    PRIMARY KEY (id_cons),
    FOREIGN KEY (id_cons) REFERENCES Item(id_item)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Pocao_Vida (
    id_pocao_vida SERIAL,
    val_vida INT NOT NULL UNIQUE,
    PRIMARY KEY (id_pocao_vida),
    FOREIGN KEY (id_pocao_vida) REFERENCES Consumivel(id_cons)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Pocao_Mana (
    id_pocao_mana SERIAL,
    val_mana INT NOT NULL UNIQUE,
    PRIMARY KEY (id_pocao_mana),
    FOREIGN KEY (id_pocao_mana) REFERENCES Consumivel(id_cons)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Inventario (
    id_invent SERIAL,
    num_slots INT NOT NULL UNIQUE,
    PRIMARY KEY (id_invent)
);

CREATE TABLE Instancia_Item (
    id_instancia SERIAL,
    id_invent INT NOT NULL,
    id_item INT NOT NULL,
    PRIMARY KEY (id_instancia),
    FOREIGN KEY (id_invent) REFERENCES Inventario(id_invent)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (id_item) REFERENCES Item(id_item)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Mundo (
    id_mundo SERIAL,
    nome CHAR(40),
    id_anterior INT,
    id_proximo INT,
    dificuldade INT NOT NULL,
    PRIMARY KEY (id_mundo)
);

CREATE TABLE Viagem_Mundo_Destino (
    id_mundo INT NOT NULL,
    id_mundo_destino INT NOT NULL,
    PRIMARY KEY (id_mundo),
    FOREIGN KEY (id_mundo) REFERENCES Mundo(id_mundo)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (id_mundo_destino) REFERENCES Mundo(id_mundo)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
CREATE TABLE Sala (
    id_sala SERIAL,
    nome CHAR(40),
    mundo INT NOT NULL,
    dificuldade INT NOT NULL,
    PRIMARY KEY (id_sala),
    FOREIGN KEY (mundo) REFERENCES Mundo(id_mundo)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);


CREATE TABLE Viagem_Destino (
    id_sala INT NOT NULL,
    id_destino INT NOT NULL,
    PRIMARY KEY (id_sala),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (id_destino) REFERENCES Sala(id_sala)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Personagem (
  id_personagem SERIAL,
  nome CHAR(40),
  PRIMARY KEY (id_personagem)
);

CREATE TABLE NPC (
    id_npc SERIAL,
    funcao CHAR(10) NOT NULL,
    descricao CHAR(400) NOT NULL,
    PRIMARY KEY (id_npc),
    FOREIGN KEY (id_npc) REFERENCES Personagem(id_personagem)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Mercador (
    id_mercador SERIAL,
    inventario INT NOT NULL,
    sala INT NOT NULL,
    ouro INT NOT NULL,
    orbs INT NOT NULL,
    PRIMARY KEY (id_mercador),
    FOREIGN KEY (id_mercador) REFERENCES NPC(id_npc)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (inventario) REFERENCES Inventario(id_invent)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (sala) REFERENCES Sala(id_sala)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Inimigo_Comum (
    id_inm_com SERIAL,
    vida INT NOT NULL,
    nivel INT NOT NULL,
    atk_base INT NOT NULL,
    arm_base INT NOT NULL,
    ouro_drop INT NOT NULL,
    orb_drop INT NOT NULL,
    UNIQUE (vida, nivel),
    PRIMARY KEY (id_inm_com),
    FOREIGN KEY (id_inm_com) REFERENCES NPC(id_npc)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Chefe (
    id_chefe SERIAL,
    arma INT NOT NULL,
    sala INT NOT NULL,
    vida INT NOT NULL,
    nivel INT NOT NULL,
    atk_base INT NOT NULL,
    arm_base INT NOT NULL,
    ouro_drop INT NOT NULL,
    orb_drop INT NOT NULL,
    PRIMARY KEY (id_chefe),
    FOREIGN KEY (id_chefe) REFERENCES NPC(id_npc)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (arma) REFERENCES Arma(id_arma)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (sala) REFERENCES Sala(id_sala)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE PC (
    id_pc SERIAL,
    vida INT NOT NULL,
    mana INT NOT NULL,
    ouro INT NOT NULL,
    orbs INT NOT NULL,
    atk_base INT NOT NULL,
    arm_base INT NOT NULL,
    armadura INT NOT NULL,
    arma INT NOT NULL,
    sala INT NOT NULL,
    PRIMARY KEY (id_pc),
    FOREIGN KEY (armadura) REFERENCES Armadura(id_armadura)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (arma) REFERENCES Arma(id_arma)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (sala) REFERENCES Sala(id_sala)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (id_pc) REFERENCES Personagem(id_personagem)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Instancia_Inim_Comum (
    id_instancia SERIAL,
    id_inm_com INT NOT NULL,
    sala INT NOT NULL,
    vida INT NOT NULL,
    NIVEL INT NOT NULL,
    atk_base INT NOT NULL,
    arm_base INT NOT NULL,
    ouro_drop INT NOT NULL,
    orb_drop INT NOT NULL,
    PRIMARY KEY (id_instancia),
    FOREIGN KEY (id_inm_com) REFERENCES Inimigo_Comum (id_inm_com)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (sala) REFERENCES Sala (id_sala)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Bencao (
    id_bencao SERIAL,
    id_pc INT NOT NULL,
    vida INT NOT NULL,
    mana INT NOT NULL,
    atk_base INT NOT NULL,
    arm_base INT NOT NULL,
    operacao CHAR(3) UNIQUE NOT NULL,
    PRIMARY KEY (id_bencao),
    FOREIGN KEY (id_pc) REFERENCES PC(id_pc)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

COMMIT;

