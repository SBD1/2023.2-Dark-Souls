# Data Query Language (DQL)

Data Query Language (DQL) é uma parte da Structured Query Language (SQL) que é usada para consultar e extrair dados de um banco de dados. DQL consiste principalmente do comando `SELECT`, que permite aos usuários especificar exatamente quais dados eles desejam obter de um banco de dados. 

Os usuários podem usar DQL para realizar uma variedade de tarefas, como selecionar todos os registros em uma tabela, selecionar registros específicos com base em certos critérios, ou até mesmo combinar dados de várias tabelas. Além disso, DQL suporta funções agregadas, como `COUNT`, `SUM`, `AVG`, `MIN` e `MAX`, que permitem aos usuários realizar cálculos nos dados recuperados.


## Consultas

Estas consultas são a base para um projeto que visa extrair e analisar dados do jogo. As consultas abrangem vários aspectos do jogo, incluindo informações sobre os mundos, chefes, NPCs, itens do inventário, bênçãos, personagens e armas. Cada consulta foi cuidadosamente elaborada para fornecer insights específicos sobre o jogo e suas mecânicas. Com estas consultas iniciais, esperamos estabelecer uma base sólida para futuras análises e explorações de dados do Hades.

1) **Recuperar todos os mundos**:
```sql
SELECT *
FROM Mundo;
```
2) **Recuperar um mundo específico**:
```sql
SELECT *
FROM Mundo
WHERE nome = 'Nome do mundo'; 
```
3) **Recuperar todos os pc do jogo**:
```sql
SELECT Personagen.nome
FROM Personagen 
JOIN PC ON Personagem.id_personagem = PC.id_pc;
```
4) **Recuperar todos os pc do jogo**:
```sql
SELECT *
FROM Personagen
JOIN PC ON Personagem.id_personagem = PC.id_pc;
```
5) **Recuperar todos as salas de um mondo especifico**:
```sql
SELECT Sala.id_sala, Sala.nome, Sala.dificuldade
FROM Sala 
JOIN Mundo ON Sala.mundo = Mundo.id_mundo;
```
6) **Recuperar a sala que um PC se encontra**:
```sql
SELECT Sala.id_sala, Sala.nome, Sala.dificuldade
FROM Sala
JOIN PC ON PC.sala = Sala.id_sala;
```
7) **Recupera as salas anteriores de uma sala que o PC esta**:
```sql
SELECT Sala.id_sala, Sala.nome, Sala.dificuldade
FROM Sala
JOIN PC ON PC.sala = Sala.id_sala
JOIN Viagem_Destino ON Viagem_Destino.id_destino = Sala.id_sala;
```
8) **Recupera as salas posteriores de uma sala que o PC esta**:
```sql
SELECT Sala.id_sala, Sala.nome, Sala.dificuldade
FROM Sala
JOIN PC ON PC.sala = Sala.id_sala
JOIN Viagem_Origem ON Viagem_Origem.id_origem = Sala.id_sala;
```
9) **Recupera todas as instancias de NPC inimigo comum em uma sala**:
```sql
SELECT Inimigo_Comum.*
FROM Instancias_NPC
JOIN Sala ON Instancias_NPC.id_sala = Sala.id_sala
JOIN Inimigo_Comum ON Inimigo_Comum.id_inm_com = Instancias_NPC.id_npc;
```
## Histórico de versão 

|    Data    | Versão | Descrição                   | Autores                                                      |
| :--------: | :----: | --------------------------- | ------------------------------------------------------------ |
| 30/10/2023 | `1.0`  | Criação da primeira versão. | [Joao Lucas Pinto Vasconcelos](https://github.com/HacKairos), [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES) |
| 30/11/2023 | `1.1`  | Atualização das buscas conforme o novo modelo. | [Francisco Mizael Santos da Silca](https://github.com/frmiza) |
