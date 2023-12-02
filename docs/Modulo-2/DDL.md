# Data Definition Language (DDL)

Data Definition Language (DDL) é uma parte da Structured Query Language (SQL) que é usada para definir e modificar a estrutura de um banco de dados. DDL consiste principalmente dos comandos `CREATE`, `ALTER` e `DROP`, que permitem aos usuários criar, alterar e remover objetos do banco de dados, como tabelas, colunas, índices, chaves e restrições.

Os usuários podem usar DDL para realizar uma variedade de tarefas, como criar um novo banco de dados, adicionar ou remover colunas em uma tabela, mudar o tipo ou o nome de uma coluna, criar ou remover relacionamentos entre tabelas, ou até mesmo apagar todo o banco de dados. Além disso, DDL suporta especificações de domínio, que permitem aos usuários definir os valores válidos para uma coluna ou um conjunto de colunas.

## Comandos

Os comandos DDL abaixo criam o banco de dados Hades e as tabelas Mundo, Sala, NPC, Chefe, NPC room, PC, Bencao, Arma e Inventario. As tabelas estão relacionadas entre si através de chaves estrangeiras para representar as relações entre os diferentes aspectos do jogo. Cada tabela inclui colunas para armazenar informações específicas sobre cada aspecto do jogo, bem como colunas para registrar a data de criação e atualização de cada registro. Além disso, várias restrições foram definidas para garantir a integridade dos dados. Com esses comandos DDL, você pode criar a estrutura do banco de dados para o seu jogo inspirado no universo do Hades.

1) Cria o banco de dados Hades. 
```sql
CREATE DATABASE hades;
```

2) Cria a tabela Inventário. 
```sql
CREATE TABLE inventario (
  id_invent INT NOT NULL AUTO_INCREMENT,
  portador VARCHAR(255) NOT NULL,
  num_slots INT NOT NULL UNIQUE,
  PRIMARY KEY (id_invent),
);
```

3) Cria a tabela Arma. 
```sql
CREATE TABLE arma (
  id_arma INT NOT NULL AUTO_INCREMENT,
  val_dano INT NOT NULL,
  raridade VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (id_arma)
);
```

4) Cria a tabela Item. 
```sql
CREATE TABLE item (
  id_item INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  valor_ouro INT NOT NULL,
  tipo VARCHAR(255) NOT NULL,
  nivel_min INT NOT NULL,
  PRIMARY KEY (id_item)
);
```
5) Cria a tabela Pocao Vida. 
```sql
CREATE TABLE poção_vida (
  id_pocao_vida INT NOT NULL AUTO_INCREMENT,
  val_vida INT NOT NULL UNIQUE,
  PRIMARY KEY (id_pocao_vida)
);
```
6) Cria a tabela Pocao Mana. 
```sql
CREATE TABLE poção_mana (
  id_pocao_mana INT NOT NULL AUTO_INCREMENT,
  val_mana INT NOT NULL UNIQUE,
  PRIMARY KEY (id_pocao_mana)
);
```

7) Cria a tabela Orbs. 
```sql
CREATE TABLE orbs (
  id_orbs INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id_orbs)
);
```

8) Cria a tabela Consumivel. 
```sql
CREATE TABLE consumível (
  id_cons VARCHAR(255) NOT NULL UNIQUE,
  max_utilizacao INT NOT NULL,
  PRIMARY KEY (id_cons)
);
```

9) Cria a tabela Armadura. 
```sql
CREATE TABLE armadura (
  id_armadura INT NOT NULL AUTO_INCREMENT UNIQUE,
  cal_armor INT NOT NULL,
  PRIMARY KEY (id_armadura),
  FOREIGN KEY (id_armadura) REFERENCES Armadura (id_armadura)
);
```

10) Cria a tabela Instancia Item. 
```sql
CREATE TABLE instancia_item (
  id_item INT NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (id_item)
);
```

11) Cria a tabela NPC. 
```sql
CREATE TABLE npc (
  id_npc INT NOT NULL AUTO_INCREMENT,
  funcao VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_npc)
  FOREIGN KEY (id_npc) REFERENCES NPC (id_npc)
);
```

12) Cria a tabela Mercador. 
```sql
CREATE TABLE mercador (
  id_mercador INT NOT NULL AUTO_INCREMENT,
  id_invent INT NOT NULL,
  ouro INT NOT NULL,
  orbs INT NOT NULL,
  PRIMARY KEY (id_compra),
  FOREIGN KEY (id_mercador) REFERENCES mercador (id_mercador)
);
```

13) Cria a tabela Sala. 
```sql
CREATE TABLE sala (
  id_sala INT NOT NULL AUTO_INCREMENT,
  mundo INT NOT NULL,
  dificuldade VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_sala),
  FOREIGN KEY (mundo) REFERENCES mundo (id_mundo)
);
```

14) Cria a tabela Personagem. 
```sql
CREATE TABLE personagem (
  id_personagem INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) UNIQUE,
  PRIMARY KEY (id_personagem)
);
```

15) Cria a tabela Bencao. 
```sql
CREATE TABLE bencao (
  id_bencao INT NOT NULL AUTO_INCREMENT,
  id_pc INT NOT NULL,
  vida INT NOT NULL,
  mana INT NOT NULL,
  atk_base INT NOT NULL,
  arm_base VARCHAR(255) NOT NULL,
  operacao VARCHAR(255) UNIQUE NOT NULL,
  PRIMARY KEY (id_bencao),
  FOREIGN KEY (id_pc) REFERENCES personagem (id_personagem)
);
```

16) Cria a tabela Inim Comum.
```sql
CREATE TABLE inimigo_comum (
  vida INT NOT NULL,
  nivel INT NOT NULL,
  atk_base INT NOT NULL,
  arm_base INT NOT NULL,
  ouro_drop INT NOT NULL,
  orb_drop INT NOT NULL,
  PRIMARY KEY (id_inm_com),
  UNIQUE (vida, nivel)
);
```

17) Cria a tabela PC.
```sql
CREATE TABLE pc (
  id_pc INT NOT NULL AUTO_INCREMENT,
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
  FOREIGN KEY (armadura) REFERENCES armadura (id_armadura),
  FOREIGN KEY (arma) REFERENCES arma (id_arma),
  FOREIGN KEY (sala) REFERENCES sala (id_sala)
);
```

18) Cria a tabela Instancia_NPC.
```sql
CREATE TABLE instancia_npc (
  id_npc INT NOT NULL,
  id_sala INT NOT NULL,
  FOREIGN KEY (id_npc) REFERENCES npc (id_npc),
  FOREIGN KEY (id_sala) REFERENCES sala (id_sala)
);
```

19) Cria a tabela Chefe.
```sql
CREATE TABLE chefe (
  id_chefe INT NOT NULL AUTO_INCREMENT,
  arma INT NOT NULL,
  vida INT NOT NULL,
  nivel INT NOT NULL,
  atk_base INT NOT NULL,
  arm_base INT NOT NULL,
  ouro_drop INT NOT NULL,
  orb_drop INT NOT NULL,
  PRIMARY KEY (id_chefe),
  FOREIGN KEY (arma) REFERENCES arma (id_arma),
  FOREIGN KEY (arm_base) REFERENCES armadura (id_armadura),
  FOREIGN KEY (ouro_drop) REFERENCES recompensa (id_recompensa),
  FOREIGN KEY (orb_drop) REFERENCES recompensa (id_recompensa)
);
```

20) Cria a tabela Mundo.
```sql
CREATE TABLE mundo (
  id_mundo INT NOT NULL AUTO_INCREMENT,
  id_anterior INT,
  id_proximo INT,
  dificuldade INT NOT NULL,
  PRIMARY KEY (id_mundo),
  FOREIGN KEY (id_anterior) REFERENCES mundo (id_mundo),
  FOREIGN KEY (id_proximo) REFERENCES mundo (id_mundo)
);
```

21) Cria a tabela Viagem_origem.
```sql
CREATE TABLE viagem_origem (
  id_sala INT NOT NULL,
  id_origem INT NOT NULL,
  PRIMARY KEY (id_sala, id_origem),
  FOREIGN KEY (id_sala) REFERENCES sala (id_sala),
  FOREIGN KEY (id_origem) REFERENCES sala (id_sala)
);
```

22) Cria a tabela Viagem_destino.
```sql
CREATE TABLE viagem_destino (
  id_sala INT NOT NULL,
  id_origem INT NOT NULL,
  PRIMARY KEY (id_sala, id_origem),
  FOREIGN KEY (id_sala) REFERENCES sala (id_sala),
  FOREIGN KEY (id_origem) REFERENCES sala (id_sala)
);
```

## Histórico de versão 

|    Data    | Versão | Descrição                   | Autores                                                      |
| :--------: | :----: | --------------------------- | ------------------------------------------------------------ |
| 30/10/2023 | `1.0`  | Criação da primeira versão. | [Joao Lucas Pinto Vasconcelos](https://github.com/HacKairos), [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES)|
| 30/10/2023 | `1.1`  | Correções necessárias. | [Francisco Mizael](https://github.com/frmiza) |
| 02/12/2023 | `1.2`  | Correções necessárias terceira entrega | [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES) |
