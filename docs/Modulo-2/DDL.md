# Data Definition Language (DDL)

Data Definition Language (DDL) é uma parte da Structured Query Language (SQL) que é usada para definir e modificar a estrutura de um banco de dados. DDL consiste principalmente dos comandos `CREATE`, `ALTER` e `DROP`, que permitem aos usuários criar, alterar e remover objetos do banco de dados, como tabelas, colunas, índices, chaves e restrições.

Os usuários podem usar DDL para realizar uma variedade de tarefas, como criar um novo banco de dados, adicionar ou remover colunas em uma tabela, mudar o tipo ou o nome de uma coluna, criar ou remover relacionamentos entre tabelas, ou até mesmo apagar todo o banco de dados. Além disso, DDL suporta especificações de domínio, que permitem aos usuários definir os valores válidos para uma coluna ou um conjunto de colunas.

## Comandos

Os comandos DDL abaixo criam o banco de dados Hades e as tabelas Mundo, Sala, NPC, Chefe, NPC room, PC, Bencao, Arma e Inventario. As tabelas estão relacionadas entre si através de chaves estrangeiras para representar as relações entre os diferentes aspectos do jogo. Cada tabela inclui colunas para armazenar informações específicas sobre cada aspecto do jogo, bem como colunas para registrar a data de criação e atualização de cada registro. Além disso, várias restrições foram definidas para garantir a integridade dos dados. Com esses comandos DDL, você pode criar a estrutura do banco de dados para o seu jogo inspirado no universo do Hades.

1) Cria o banco de dados Hades. 
```sql
CREATE DATABASE hades;
```

2) Cria a tabela Item. 
```sql
CREATE TABLE Item (
    id_item INT NOT NULL AUTO_INCREMENT,
     nome VARCHAR(50) NOT NULL,
    descricao CHAR(400) NOT NULL,
    valor_ouro INT NOT NULL,
    tipo CHAR(25) NOT NULL,
    nivel_min INT NOT NULL,
    PRIMARY KEY (id_item)
);
```
3) Cria a tabela Arma. 
```sql
CREATE TABLE Arma (
    id_arma SERIAL,
    val_dano INT NOT NULL,
    raridade CHAR(25) NOT NULL UNIQUE,
    FOREIGN KEY (id_arma) REFERENCES Item(id_item),
    PRIMARY KEY (id_arma)
);
```
4) Cria a tabela Armadura. 
```sql
CREATE TABLE Armadura (
    id_armadura SERIAL,
    val_armor INT NOT NULL,
    PRIMARY KEY (id_armadura),
    FOREIGN KEY (id_armadura) REFERENCES Item(id_item)
);
```
5) Cria a tabela Orbs. 
```sql
CREATE TABLE Orbs (
    id_orbs SERIAL,
    PRIMARY KEY (id_orbs),
    FOREIGN KEY (id_orbs) REFERENCES Item(id_item)
);
```
6) Cria a tabela Consumivel. 
```sql
CREATE TABLE Consumivel (
    id_cons SERIAL,
    max_utilizacao INT NOT NULL,
    PRIMARY KEY (id_cons),
    FOREIGN KEY (id_cons) REFERENCES Item(id_item)
);
```
7) Cria a tabela Pocao Vida. 
```sql
CREATE TABLE Pocao_Vida (
    id_pocao_vida SERIAL,
    val_vida INT NOT NULL UNIQUE,
    PRIMARY KEY (id_pocao_vida),
    FOREIGN KEY (id_pocao_vida) REFERENCES Consumivel(id_cons)
);
```
8) Cria a tabela Pocao Mana. 
```sql
CREATE TABLE Pocao_Mana (
    id_pocao_mana SERIAL,
    val_mana INT NOT NULL UNIQUE,
    PRIMARY KEY (id_pocao_mana),
    FOREIGN KEY (id_pocao_mana) REFERENCES Consumivel(id_cons)
);
```
9) Cria a tabela Instancia Item. 
```sql
CREATE TABLE Instancia_Item (
    id_instancia = SERIAL,
    id_invent INT NOT NULL,
    id_item INT NOT NULL,
    PRIMARY KEY (id_instancia),
    FOREIGN KEY (id_invent) REFERENCES Inventario(id_invent),
    FOREIGN KEY (id_item) REFERENCES Item(id_item)
);
```
10) Cria a tabela Inventário. 
```sql
CREATE TABLE Inventario (
    id_invent SERIAL,
    num_slots INT NOT NULL UNIQUE,
    PRIMARY KEY (id_invent),
);
```
11) Cria a tabela Personagem. 
```sql
CREATE TABLE personagem (
  id_personagem SERIAL,
  nome CHAR(40),
  PRIMARY KEY (id_personagem)
);
```
12) Cria a tabela NPC. 
```sql
CREATE TABLE NPC (
    id_npc SERIAL,
    funcao CHAR(10) NOT NULL,
    descricao CHAR(400) NOT NULL,
    PRIMARY KEY (id_npc),
    FOREIGN KEY (id_npc) REFERENCES Personagem(id_personagem)
);
```
13) Cria a tabela Mercador. 
```sql
CREATE TABLE Mercador (
    id_mercador SERIAL,
    inventario INT NOT NULL,
    sala INT NOT NULL,
    ouro INT NOT NULL,
    orbs INT NOT NULL,
    PRIMARY KEY (id_mercador),
    FOREIGN KEY (id_mercador) REFERENCES NPC(id_npc),
    FOREIGN KEY (inventario) REFERENCES Inventario(id_invent),
    FOREIGN KEY (sala) REFERENCES Sala(id_sala)
);
```
14) Cria a tabela Inimigo Comum.
```sql
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
```
15) Cria a tabela Chefe.
```sql
CREATE TABLE chefe (
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
    FOREIGN KEY (id_chefe) REFERENCES NPC(id_npc),
    FOREIGN KEY (arma) REFERENCES Arma(id_arma),
    FOREIGN KEY (sala) REFERENCES Sala(id_sala)
);
```
16) Cria a tabela PC.
```sql
CREATE TABLE PC (
    id_pc SERIAL,
    vida INT NOT NULL,
    mana INT NOT NULL,
    ouro INT NOT NULL,
    orbs INT NOT NULL,
    atk_base INT NOT NULL,
    arm_base INT NOT NULL,
    bencao_pc INT NOT NULL,
    num_bencoes_ativas INT;
    armadura INT NOT NULL,
    arma INT NOT NULL,
    sala INT NOT NULL,
    PRIMARY KEY (id_pc),
    FOREIGN KEY (armadura) REFERENCES Armadura(id_armadura),
    FOREIGN KEY (arma) REFERENCES Arma(id_arma),
    FOREIGN KEY (sala) REFERENCES Sala(id_sala),
);
```
17) Cria a tabela Instancia Inimigo Comum.
```sql
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
    FOREIGN KEY (id_inm_com) REFERENCES Inimigo_Comum (id_inm_com),
    FOREIGN KEY (id_sala) REFERENCES Sala (id_sala)
);
```
18) Cria a tabela Bencao. 
```sql
CREATE TABLE bencao (
    id_bencao SERIAL,
    id_pc INT NOT NULL,
    vida INT NOT NULL,
    mana INT NOT NULL,
    atk_base INT NOT NULL,
    arm_base INT NOT NULL,
    operacao CHAR(3) UNIQUE NOT NULL,
    PRIMARY KEY (id_bencao),
    FOREIGN KEY (id_pc) REFERENCES PC(id_pc)
);
```
19) Cria a tabela Sala. 
```sql
CREATE TABLE sala (
    id_sala SERIAL,
    mundo INT NOT NULL,
    dificuldade INT NOT NULL,
    PRIMARY KEY (id_sala),
    FOREIGN KEY (mundo) REFERENCES Mundo (id_mundo)
);
```
20) Cria a tabela Viagem Origem.
```sql
CREATE TABLE Viagem_Origem (
    id_sala INT NOT NULL,
    id_origem INT NOT NULL,
    PRIMARY KEY (id_sala),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala),
    FOREIGN KEY (id_origem) REFERENCES Sala(id_sala)
);
```
21) Cria a tabela Viagem Destino.
```sql
CREATE TABLE Viagem_Destino (
    id_sala INT NOT NULL,
    id_destino INT NOT NULL,
    PRIMARY KEY (id_sala),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala),
    FOREIGN KEY (id_origem) REFERENCES Sala(id_sala)
);
```
22) Cria a tabela Mundo.
```sql
CREATE TABLE mundo (
    id_mundo SERIAL,
    nome CHAR(40),
    id_anterior INT,
    id_proximo INT,
    dificuldade INT NOT NULL,
    PRIMARY KEY (id_mundo),
    FOREIGN KEY (id_anterior) REFERENCES Mundo (id_mundo),
    FOREIGN KEY (id_proximo) REFERENCES Mundo (id_mundo)
);
```
23) Cria a tabela Viagem Origem Mundo.
```sql
CREATE TABLE Viagem_Origem (
    id_mundo INT NOT NULL,
    id_mundo_origem INT NOT NULL,
    FOREIGN KEY (id_mundo) REFERENCES Mundo(id_mundo),
    FOREIGN KEY (id_mundo_origem) REFERENCES Mundo(id_mundo)
);
```
24) Cria a tabela Viagem Destino Mundo.
```sql
CREATE TABLE Viagem_Destino (
    id_mundo INT NOT NULL,
    id_mundo_destino INT NOT NULL,
    PRIMARY KEY (id_mundo),
    FOREIGN KEY (id_mundo) REFERENCES Mundo(id_mundo),
    FOREIGN KEY (id_mundo_origem) REFERENCES Mundo(id_mundo)
);
```

## Histórico de versão 

|    Data    | Versão | Descrição                   | Autores                                                      |
| :--------: | :----: | --------------------------- | ------------------------------------------------------------ |
| 30/10/2023 | `1.0`  | Criação da primeira versão. | [Joao Lucas Pinto Vasconcelos](https://github.com/HacKairos), [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES)|
| 30/10/2023 | `1.1`  | Correções necessárias. | [Francisco Mizael](https://github.com/frmiza) |
| 02/12/2023 | `1.2`  | Correções necessárias terceira entrega | [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES) |
| 03/12/2023 | `1.3`  | Correções necessárias terceira entrega, modificado alguns tipos de dados | [Francisco Mizael Santos da Silva](https://github.com/frmiza) |
