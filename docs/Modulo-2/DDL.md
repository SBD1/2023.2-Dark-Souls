# Data Definition Language (DDL)

Data Definition Language (DDL) é uma parte da Structured Query Language (SQL) que é usada para definir e modificar a estrutura de um banco de dados. DDL consiste principalmente dos comandos `CREATE`, `ALTER` e `DROP`, que permitem aos usuários criar, alterar e remover objetos do banco de dados, como tabelas, colunas, índices, chaves e restrições.

Os usuários podem usar DDL para realizar uma variedade de tarefas, como criar um novo banco de dados, adicionar ou remover colunas em uma tabela, mudar o tipo ou o nome de uma coluna, criar ou remover relacionamentos entre tabelas, ou até mesmo apagar todo o banco de dados. Além disso, DDL suporta especificações de domínio, que permitem aos usuários definir os valores válidos para uma coluna ou um conjunto de colunas.

## Comandos

Os comandos DDL abaixo criam o banco de dados Hades e as tabelas Mundo, Sala, NPC, Chefe, NPC room, PC, Bencao, Arma e Inventario. As tabelas estão relacionadas entre si através de chaves estrangeiras para representar as relações entre os diferentes aspectos do jogo. Cada tabela inclui colunas para armazenar informações específicas sobre cada aspecto do jogo, bem como colunas para registrar a data de criação e atualização de cada registro. Além disso, várias restrições foram definidas para garantir a integridade dos dados. Com esses comandos DDL, você pode criar a estrutura do banco de dados para o seu jogo inspirado no universo do Hades.

1) Cria o banco de dados Hades. 
```sql
CREATE DATABASE hades;
```

2) Cria a tabela Mundo. 
```sql
CREATE TABLE mundo ( id INT NOT NULL AUTO_INCREMENT, nome VARCHAR(255) NOT NULL, data_criacao DATETIME NOT NULL, data_atualizacao DATETIME NOT NULL, PRIMARY KEY (id) );
```

3) Cria a tabela Sala. 
```sql
CREATE TABLE sala ( id INT NOT NULL AUTO_INCREMENT, tipo VARCHAR(255) NOT NULL, descricao VARCHAR(255) NOT NULL, eh_chefe BOOLEAN NOT NULL, eh_npc BOOLEAN NOT NULL, mundo_id INT NOT NULL, data_criacao DATETIME NOT NULL, data_atualizacao DATETIME NOT NULL, PRIMARY KEY (id), FOREIGN KEY (mundo_id) REFERENCES mundo (id) );
```

4) Cria a tabela NPC. 
```sql
CREATE TABLE npc ( id INT NOT NULL AUTO_INCREMENT, nome VARCHAR(255) NOT NULL, mundo_id INT NOT NULL, funcao VARCHAR(255) NOT NULL, descricao_completa VARCHAR(255), data_criacao DATETIME NOT NULL, data_atualizacao DATETIME NOT NULL, PRIMARY KEY (id), FOREIGN KEY (mundo_id) REFERENCES mundo (id) );
```

5) Cria a tabela Chefe. 
```sql
CREATE TABLE chefe ( id INT NOT NULL AUTO_INCREMENT, nome VARCHAR(255) NOT NULL, mundo_id INT NOT NULL, data_criacao DATETIME NOT NULL, data_atualizacao DATETIME NOT NULL, PRIMARY KEY (id), FOREIGN KEY (mundo_id) REFERENCES mundo (id) );
```

6) Cria a tabela NPC room. 
```sql
CREATE TABLE npc_room ( id INT NOT NULL AUTO_INCREMENT, tipo VARCHAR(255) NOT NULL, descricao VARCHAR(255) NOT NULL, sala_id INT NOT NULL, data_criacao DATETIME NOT NULL, data_atualizacao DATETIME NOT NULL, PRIMARY KEY (id), FOREIGN KEY (sala_id) REFERENCES sala (id) );
```

7) Cria a tabela PC. 
```sql
CREATE TABLE pc ( id INT NOT NULL AUTO_INCREMENT, nome VARCHAR(255) NOT NULL,status BOOLEAN NOT NULL, sala_id INT NOT NULL, data_criacao DATETIME NOT NULL, data_atualizacao DATETIME NOT NULL, PRIMARY KEY (id), FOREIGN KEY (sala_id) REFERENCES sala (id) );
```

8) Cria a tabela Bencao. 
```sql
CREATE TABLE bencao ( id INT NOT NULL AUTO_INCREMENT, nome VARCHAR(255) NOT NULL UNIQUE, raridade VARCHAR(255) NOT NULL CHECK (raridade IN (‘Comum’, ‘Raro’, ‘Épico’, ‘Heroico’, ‘Lendário’, ‘Duo’)), habilidade VARCHAR(255) NOT NULL CHECK (habilidade IN (‘Ataque’, ‘Especial’, ‘Elenco’, ‘Traço’, ‘Chamada’)), nivel INT NOT NULL CHECK (nivel >0 AND nivel <=5), data_criacao DATETIME NOT NULL, data_atualizacao DATETIME NOT NULL, PRIMARY KEY (id) );
```

9) Cria a tabela Arma. 
```sql
CREATE TABLE arma ( id INT NOT NULL AUTO_INCREMENT, nome VARCHAR(255) NOT NULL UNIQUE, tipo VARCHAR(255) NOT NULL CHECK (tipo IN (‘Espada’, ‘Lança’, ‘Escudo’, ‘Arco’, ‘Punho’, ‘Foice’)), data_criacao DATETIME NOT NULL, data_atualizacao DATETIME NOT NULL, PRIMARY KEY (id) );
```

10) Cria a tabela Inventario. 
```sql
CREATE TABLE inventario ( id INT NOT NULL AUTO_INCREMENT, nome VARCHAR(255) NOT NULL, tipo VARCHAR(255) NOT NULL CHECK (tipo IN (‘Item’, ‘Arma’, ‘Bencao’)), jogador_id INT NOT NULL, data_criacao DATETIME NOT NULL, data_atualizacao DATETIME NOT NULL, PRIMARY KEY (id), FOREIGN KEY (jogador_id) REFERENCES pc (id) );
```

## Histórico de versão 

|    Data    | Versão | Descrição                   | Autores                                                      |
| :--------: | :----: | --------------------------- | ------------------------------------------------------------ |
| 30/10/2023 | `1.0`  | Criação da primeira versão. | [Joao Lucas Pinto Vasconcelos](https://github.com/HacKairos), [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES) |