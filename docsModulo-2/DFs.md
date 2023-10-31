# Normalização

A normalização de uma base de dados auxilia na sua manipulação e busca de dados nela, permitindo uma maior eficiência ou mesmo prevenindo gastos excessivos de espaço em disco. Para isso existe maneiras de realizar tal operação, sendo elas a primeira forma normal (1FN), a segunda forma normal (2FN), terceira forma normal (3FN), forma normal de Boyce Codd  e por fim a quarta forma normal (4FN), para realizar esta processo de normalização [é preciso conhecer as dependências funcionais dos atributos de uma tabela em uma base dados.
Desta maneira, foi realizada uma listagem das dependências funcionais, já devidamente normalizadas e suas tabelas.

## Dependências Funcionais

1) **Tabela Mundo:**  id_ mundo &rarr; {nome}
2) **Tabela PC:** id_pc &rarr; {nome, status}
3) **Tabela Chefe:** id_chefe, id_mundo &rarr; {nome}
4) **Tabela NPC:** id_npc, id_mundo &rarr; {nome, funcao, descricao_completa}
5) **T1abela NPC Inimigo:** id_npc, id_mundo &rarr; {nome, armadura, descricao_completa}
6) **Tabela Benção:** id_bencao &rarr; {nome, raridadem habilidade, nivel}
7) **Tabela Arma:**  id_arma &rarr; {nome, tipo}
8) **Tabela Inventário** id_invetario, id_pc &rarr; {nome}
9) **Tabela Sala:**  id_sala, id_mundo &rarr; {tipo, descricao}
10) **Tabela Loja:** id_loja, id_sala, id_npc &rarr; {nome, tipo}
11) **Tabela NPC Room:** id_npc_room, id_npc, id_sala &rarr; {nome, tipo, descricao}

## Histórico de versão 

|    Data    | Versão | Descrição                   | Autores                                                      |
| :--------: | :----: | --------------------------- | ------------------------------------------------------------ |
| 30/10/2023 | `1.0`  | Criação da primeira versão. | [Francisco Mizael](https://github.com/frmiza) |
