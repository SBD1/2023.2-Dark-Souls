# Dependências Funcionais e Normalização

Dependências Funcionais e Normalização são conceitos fundamentais em bancos de dados relacionais.

**Dependências Funcionais** se referem à relação entre dois conjuntos de atributos, A e B, de uma entidade. Dizemos que B é funcionalmente dependente de A (ou que A determina B) se, para cada valor de A, estiver associado um, e somente um, valor de B. Em outras palavras, se você conhece o valor de A, pode determinar o valor de B. Isso é representado como A → B.

**Normalização**, por outro lado, é um processo usado para organizar as tabelas em um banco de dados para evitar redundância ou complexidade nos dados. O objetivo da normalização é evitar problemas com repetição e atualização de dados, bem como cuidar da integridade dos dados. Isso é feito através da aplicação de uma série de regras estruturadas e agrupadas em níveis chamados Formas Normais.

## Dependências Funcionais

1) **Tabela Mundo:**  id_ mundo &rarr; {nome}<br>
2) **Tabela PC:** id_pc &rarr; {nome, status}<br>
3) **Tabela Chefe:** id_chefe, id_mundo &rarr; {nome}<br>
4) **Tabela NPC:** id_npc, id_mundo &rarr; {nome, funcao, descricao_completa}<br>
5) **T1abela NPC Inimigo:** id_npc, id_mundo &rarr; {nome, armadura, descricao_completa}<br>
6) **Tabela Benção:** id_bencao &rarr; {nome, raridadem habilidade, nivel}<br>
7) **Tabela Arma:**  id_arma &rarr; {nome, tipo}<br>
8) **Tabela Inventário** id_invetario, id_pc &rarr; {nome}<br>
9) **Tabela Sala:**  id_sala, id_mundo &rarr; {tipo, descricao}<br>
10) **Tabela Loja:** id_loja, id_sala, id_npc &rarr; {nome, tipo}<br>
11) **Tabela NPC Room:** id_npc_room, id_npc, id_sala &rarr; {nome, tipo, descricao}<br>

## Histórico de versão 

|    Data    | Versão | Descrição                   | Autores                                                      |
| :--------: | :----: | --------------------------- | ------------------------------------------------------------ |
| 30/10/2023 | `1.0`  | Criação da primeira versão. | [Francisco Mizael](https://github.com/frmiza) |

