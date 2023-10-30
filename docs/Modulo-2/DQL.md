# Data Query Language (DQL)

Data Query Language (DQL) é uma parte da Structured Query Language (SQL) que é usada para consultar e extrair dados de um banco de dados. DQL consiste principalmente do comando `SELECT`, que permite aos usuários especificar exatamente quais dados eles desejam obter de um banco de dados. 

Os usuários podem usar DQL para realizar uma variedade de tarefas, como selecionar todos os registros em uma tabela, selecionar registros específicos com base em certos critérios, ou até mesmo combinar dados de várias tabelas. Além disso, DQL suporta funções agregadas, como `COUNT`, `SUM`, `AVG`, `MIN` e `MAX`, que permitem aos usuários realizar cálculos nos dados recuperados.


## Consultas

Estas consultas são a base para um projeto que visa extrair e analisar dados do jogo. As consultas abrangem vários aspectos do jogo, incluindo informações sobre os mundos, chefes, NPCs, itens do inventário, bênçãos, personagens e armas. Cada consulta foi cuidadosamente elaborada para fornecer insights específicos sobre o jogo e suas mecânicas. Com estas consultas iniciais, esperamos estabelecer uma base sólida para futuras análises e explorações de dados do Hades.

1) **Recuperar todos os mundos**:
```sql
SELECT id_mundo, nome, data_criacao, data_atualizacao
FROM mundo;
```

2) **Recuperar um mundo específico**:
```sql
SELECT *
FROM mundo
WHERE nome = 'Tártaro';
```

3) **Para todos os chefes**:
```sql
SELECT chefe.id_chefe, chefe.nome, chefe.mundo_id, chefe.data_criacao, chefe.data_atualizacao
FROM chefe;
```

4) **Para um chefe específico**:
```sql
SELECT *
FROM chefe
WHERE nome = 'As 3 Fúrias';
```

5) **Para todos os NPCs**:
```sql
SELECT npc.id_npc, npc.nome, npc.mundo_id, npc.funcao, npc.descricao_completa, npc.data_criacao, npc.data_atualizacao
FROM npc;
```

6) **Para um NPC específico**:
```sql
SELECT *
FROM npc
WHERE nome = 'Caronte';
```

7) **Para o inventário do jogador**:
```sql
SELECT
  inventario.id_inventário AS id_inventário,
  inventario.nome AS nome_inventário,
  inventario.tipo AS tipo_inventário,
  personagem.nome AS nome_personagem
FROM inventario
JOIN personagem ON inventario.jogador_id = personagem.id_personagem;
```

8) **Para as bênçãos do jogador**:
```sql
SELECT bencao.id_bencao, bencao.nome, bencao.raridade, bencao.habilidade, bencao.nivel, personagem.nome
FROM bencao_player
JOIN bencao ON bencao_player.bencao_id = bencao.id_bencao
JOIN personagem ON bencao_player.jogador_id = personagem.id_personagem;
```

9) **Para uma bênção específica**:
```sql
SELECT bencao.id_bencao, bencao.nome, bencao.raridade, bencao.habilidade, bencao.nivel
FROM bencao
WHERE bencao.nome = 'Benção de Zeus';
```

10) **Para o personagem principal**:
```sql
SELECT personagem.id_personagem, personagem.nome
FROM personagem;
```

11) **Para a Romã do Poder**:
```sql
SELECT nome, tipo
FROM inventario_player
WHERE nome = 'Romã do poder';
```

12) **Para uma arma específica**:
```sql
SELECT *
FROM arma
WHERE nome = 'Stygius';
```

13) **Para todas as armas**:
```sql
SELECT arma.id_arma, arma.nome, arma.tipo, arma.data_criacao, arma.data_atualizacao
FROM arma;
```