# Álgebra Relacional

A Álgebra Relacional é um conjunto de operações que manipulam dados em uma estrutura de banco de dados relacional. Ela fornece uma maneira de descrever consultas sobre dados relacionais e é a base teórica para linguagens de consulta de banco de dados relacional, como SQL.

As operações básicas da Álgebra Relacional incluem seleção (σ), projeção (π), união (∪), diferença (-), produto cartesiano (x) e junção (⨝). Cada operação pega uma ou duas relações (tabelas) como entrada e produz uma nova relação como resultado.

Por exemplo, a operação de seleção (σ) filtra linhas em uma tabela com base em uma condição, enquanto a operação de projeção (π) seleciona certas colunas de uma tabela. A operação de junção (⨝) combina linhas de duas tabelas com base em uma condição relacionada entre as colunas dessas tabelas.

## Operações

As operações a seguir foram criadas com base nos comandos SELECT descritos no [documento DQL](DQL.md). Elas representam a tradução desses comandos para a Álgebra Relacional. Essas operações incluem seleção, projeção e produto cartesiano, que são usados para filtrar, selecionar e combinar dados, respectivamente.

1) **Recuperar todos os mundos**:
```
π(id_mundo, nome, data_criacao, data_atualizacao)(mundo)
```

2) **Recuperar um mundo específico**:
```
π*(σ(nome = 'Tártaro')(mundo))
```

3) **Para todos os chefes**:
```
π(id_chefe, nome, mundo_id, data_criacao, data_atualizacao)(chefe)
```

4) **Para um chefe específico**:
```
π*(σ(nome = 'As 3 Fúrias')(chefe))
```

5) **Para todos os NPCs**:
```
π(id_npc, nome, mundo_id, funcao, descricao_completa, data_criacao, data_atualizacao)(npc)
```

6) **Para um NPC específico**:
```
π*(σ(nome = 'Caronte')(npc))
```

7) **Para o inventário do jogador**:
```
π(id_inventário, nome_inventário, tipo_inventário, nome_personagem)(σ(inventario.jogador_id = personagem.id_personagem AND inventario x personagem))
```

8) **Para as bênçãos do jogador**:
```
π(id_bencao, nome, raridade, habilidade, nivel, nome)(σ(bencao_player.bencao_id = bencao.id_bencao AND bencao_player.jogador_id = personagem.id_personagem AND bencao_player x bencao x personagem))
```

9) **Para uma bênção específica**:
```
π(id_bencao, nome, raridade, habilidade, nivel)(σ(nome = 'Benção de Zeus')(bencao))
```

10) **Para o personagem principal**:
```
π(id_personagem, nome)(personagem)
```

11) **Para a Romã do Poder**:
```
π(nome, tipo)(σ(nome = 'Romã do poder')(inventario_player))
```

12) **Para uma arma específica**:
```
π*(σ(nome = 'Stygius')(arma))
```

13) **Para todas as armas**:
```
π(id_arma, nome, tipo, data_criacao, data_atualizacao)(arma)
```

## Histórico de versão 

|    Data    | Versão | Descrição                   | Autores                                                      |
| :--------: | :----: | --------------------------- | ------------------------------------------------------------ |
| 30/10/2023 | `1.0`  | Criação da primeira versão. | [Joao Lucas Pinto Vasconcelos](https://github.com/HacKairos), [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES) |