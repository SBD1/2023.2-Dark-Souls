BEGIN TRANSACTION; 

CREATE DATABASE hades;

CREATE TABLE Item (
    id_item INT NOT NULL AUTO_INCREMENT,
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
    raridade CHAR(25) NOT NULL UNIQUE,
    FOREIGN KEY (id_arma) REFERENCES Item(id_item),
    PRIMARY KEY (id_arma)
);

CREATE TABLE Armadura (
    id_armadura SERIAL,
    val_armor INT NOT NULL,
    PRIMARY KEY (id_armadura),
    FOREIGN KEY (id_armadura) REFERENCES Item(id_item)
);

CREATE TABLE Orbs (
    id_orbs SERIAL,
    PRIMARY KEY (id_orbs),
    FOREIGN KEY (id_orbs) REFERENCES Item(id_item)
);

CREATE TABLE Consumivel (
    id_cons SERIAL,
    max_utilizacao INT NOT NULL,
    PRIMARY KEY (id_cons),
    FOREIGN KEY (id_cons) REFERENCES Item(id_item)
);

CREATE TABLE Pocao_Vida (
    id_pocao_vida SERIAL,
    val_vida INT NOT NULL UNIQUE,
    PRIMARY KEY (id_pocao_vida),
    FOREIGN KEY (id_pocao_vida) REFERENCES Consumivel(id_cons)
);

CREATE TABLE Pocao_Mana (
    id_pocao_mana SERIAL,
    val_mana INT NOT NULL UNIQUE,
    PRIMARY KEY (id_pocao_mana),
    FOREIGN KEY (id_pocao_mana) REFERENCES Consumivel(id_cons)
);

CREATE TABLE Instancia_Item (
    id_invent INT NOT NULL,
    id_item INT NOT NULL,
    FOREIGN KEY (id_invent) REFERENCES Inventario(id_invent),
    FOREIGN KEY (id_item) REFERENCES Item(id_item)
);

CREATE TABLE Inventario (
    id_invent SERIAL,
    num_slots INT NOT NULL UNIQUE,
    PRIMARY KEY (id_invent),
);

CREATE TABLE personagem (
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
);

CREATE TABLE Mercador (
    id_mercador SERIAL,
    id_invent INT NOT NULL,
    ouro INT NOT NULL,
    orbs INT NOT NULL,
    PRIMARY KEY (id_mercador),
    FOREIGN KEY (id_mercador) REFERENCES NPC(id_npc),
    FOREIGN KEY (id_invent) REFERENCES Inventario(id_invent),
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
);

CREATE TABLE chefe (
    id_chefe SERIAL,
    arma INT NOT NULL,
    vida INT NOT NULL,
    nivel INT NOT NULL,
    atk_base INT NOT NULL,
    arm_base INT NOT NULL,
    ouro_drop INT NOT NULL,
    orb_drop INT NOT NULL,
    PRIMARY KEY (id_chefe),
    FOREIGN KEY (id_chefe) REFERENCES NPC(id_npc),
    FOREIGN KEY (arma) REFERENCES Arma(id_arma)
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
    FOREIGN KEY (armadura) REFERENCES Armadura(id_armadura),
    FOREIGN KEY (arma) REFERENCES Arma(id_arma),
    FOREIGN KEY (sala) REFERENCES Sala(id_sala),
    FOREIGN KEY (id_npc) REFERENCES Personagem(id_personagem)
);

CREATE TABLE Instancia_NPC (
    id_npc INT NOT NULL,
    id_sala INT NOT NULL,
    FOREIGN KEY (id_npc) REFERENCES NPC (id_npc),
    FOREIGN KEY (id_sala) REFERENCES Sala (id_sala)
);

CREATE TABLE bencao (
    id_pc INT NOT NULL,
    vida INT NOT NULL,
    mana INT NOT NULL,
    atk_base INT NOT NULL,
    arm_base INT NOT NULL,
    operacao CHAR(3) UNIQUE NOT NULL,
    PRIMARY KEY (id_bencao),
    FOREIGN KEY (id_pc) REFERENCES PC(id_pc)
);

CREATE TABLE sala (
    id_sala SERIAL,
    mundo INT NOT NULL,
    dificuldade INT NOT NULL,
    PRIMARY KEY (id_sala),
    FOREIGN KEY (mundo) REFERENCES Mundo (id_mundo)
);

CREATE TABLE Viagem_Origem (
    id_sala INT NOT NULL,
    id_origem INT NOT NULL,
    PRIMARY KEY (id_sala),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala),
    FOREIGN KEY (id_origem) REFERENCES Sala(id_sala)
);

CREATE TABLE Viagem_Destino (
    id_sala INT NOT NULL,
    id_destino INT NOT NULL,
    PRIMARY KEY (id_sala),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala),
    FOREIGN KEY (id_origem) REFERENCES Sala(id_sala)
);

CREATE TABLE mundo (
    id_mundo SERIAL,
    id_anterior INT,
    id_proximo INT,
    dificuldade INT NOT NULL,
    PRIMARY KEY (id_mundo),
    FOREIGN KEY (id_anterior) REFERENCES Mundo (id_mundo),
    FOREIGN KEY (id_proximo) REFERENCES Mundo (id_mundo)
);
