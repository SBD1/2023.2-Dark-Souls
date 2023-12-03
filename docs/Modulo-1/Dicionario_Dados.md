## Introdução

Um dicionário de dados em bancos de dados relacionais é uma coleção de dados que descrevem a estrutura e o conteúdo de um banco de dados. Através dele consigomos identificar Chaves Primárias e Estrangeiras, Nomes de Tabelas e campos, Tipos de Dados, Restrições e Regras, Observações e Descrição de tabelas e campos, tamanho.

O dicionário de dados é essencial para que os desenvolvedores do banco de dados entendam a sua estrutura e possam trabalhar com os dados de forma eficaz e segura. Ele orienta a manipulação e o gerenciamento dos dados no banco de dados relacional, permitindo uma melhor manutenção.

Para a confecção das tabelas foi utilizado a ferramento spreadsheets e o acesso ao dicionario pode ser encontrado em: [Link](https://docs.google.com/spreadsheets/d/1YHAq0cNd358JixKRJPjnu7olGClyv7xFmheFlepW34Q/edit?usp=sharing) 


## Entidades

A seguir Descrevemos todas Entidade que imaginamos para o jogo Hades.

### Inventário


| Nome | Descrição                                                   | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ---- | ----------------------------------------------------------- | ------------ | ------- | ---------------------- |
| Id_invent   | Identificador para o inventario do personagem                                  | Serial          |         | PK                     |
| portador | indica qual personagem é o portador do inventário | Int       |      | Not Null      |
| num_slots | indica o numero de slots do inventário | int       |      | Not Unique / Not Null     |

<center> <figcaption>
    <b>Figura 1:
     Entidade Inventário</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Arma

| Nome      | Descrição                          | Tipo de Dado | Tamanho | Restrições de Domínio    |
| --------- | ---------------------------------- | ------------ | ------- | ------------------------ |
| id_arma   | Identificador da arma              | Serial       |         | PK / FK                  |
| val_dano  | Indica o dano que a arma causa     | Int          |         | Not Null                 |
| raridade  | Indica a raridade da arma           | Char         | 25      | Unique, Not Null         |

<center> <figcaption>
    <b>Figura 2:
     Entidade Arma</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Item

| Nome       | Descrição                                    | Tipo de Dado | Tamanho | Restrições de Domínio    |
| ---------- | -------------------------------------------- | ------------ | ------- | ------------------------ |
| id_item    | Identificador do item                        | Int          |         | PK / Not Null            |
| nome       | Indica o nome do item                        | Varchar      | 50      | Not Null                 |
| descricao  | Descrição do item                            | Varchar      | 400     | Unique, Not Null          |
| valor_ouro | Quantidade de ouro coletado                  | Int          |         | Not Null                 |
| tipo       | Indica o tipo de item                        | Varchar      | 25      | Unique, Not Null          |
| nivel_min  | Indica o nível mínimo para coletar o item    | Int          |         | Not Null                 |

<center> <figcaption>
    <b>Figura 3:
     Entidade Item</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Poção de Vida


| Nome | Descrição                                                   | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ---- | ----------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_pocao_vida  | Identificador para a vida do personagem                                  | Serial          |         | PK / FK                    |
| val_vida | Identificador para a quantidade de vida que vai ser regenerada na poção | Int      |      | Unique / Not Null      |

<center> <figcaption>
    <b>Figura 4:
     Entidade Pocao Vida</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Pocão de Mana

| Nome | Descrição                                                   | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ---- | ----------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_pocao_mana  | Identificador para a mana do personagem                                  | Serial          |         | PK / FK                     |
| val_mana | Identificador para a quantidade de mana que vai ser regenerada na poção | Int       |      | Unique / Not Null      |

<center> <figcaption>
    <b>Figura 5:
     Entidade Pocao Mana</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Orbs

| Nome            | Descrição                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| --------------- | ------------------------------------------------ | ------------ | ------- | ---------------------- |
| id_orbs        | Identificador para os orbs do personagem                        | Serial          |         | PK / FK                     |

<center> <figcaption>
    <b>Figura 6:
     Entidade Orbs</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Consumivel

| Nome            | Descrição                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| --------------- | ------------------------------------------------ | ------------ | ------- | ---------------------- |
| id_cons          | Identificador para o consumível                        | Serial          |        | PK / FK                     |
| max_utilizacao | Identificador para a quantidade máxima de consumiveis    | int          |         | Not Null               |

<center> <figcaption>
    <b>Figura 7:
     Entidade Consumivel</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Armadura

| Nome            | Descrição                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| --------------- | ------------------------------------------------ | ------------ | ------- | ---------------------- |
| id_armor          | Identificador para a armadura do personagem                      | Serial          |         | PK / FK                     |
| cal_armor | calculo dos status da armadura | int          |         | Not Null               |

<center> <figcaption>
    <b>Figura 8:
     Entidade Armadura</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Instancia Item

| Nome      | Descrição                 | Tipo de Dado | Tamanho | Restrições  de Domínio |
| --------- | ------------------------- | ------------ | ------- | ---------------------- |
| id_invent    | Identificador do inventario    | Int          |         | FK  / Not Null                  |
| id_item  | Identificador do item     | Int       |      | FK / Not Null              |

<center> <figcaption>
    <b>Figura 9:
     Entidade Instancia Item</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### NPC

| Nome               | Descrição                                            | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_npc                 | Identificador Para o NPC                             | Serial          |         | PK / FK                     |
| funcao               | indica a função do npc  | Char       | 10     | Not Null      |
| descricao          | Descrição do NPC                           | Char       | 400     |      Not Null              |

<center> <figcaption>
    <b>Figura 10:
     Entidade NPC</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Mercador

| Nome               | Descrição                                            | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_mercador                | Identificador Para o mercador                          | Serial          |         | PK / FK                      |
| id_invent    | Identificador do inventario    | Int          |         | FK  / Not Null                    |
| ouro          | Identificador Para a compra de ouro                           | Int       |      | Not Null                   |
| orbs             | Identificador Para a compra de orbs            | Int     |      | Not Null               |

<center> <figcaption>
    <b>Figura 11:
     Entidade Mercador</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>


### Sala

| Nome      | Descrição                                                   | Tipo de Dado | Tamanho | Restrições  de Domínio |
| --------- | ----------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_sala       | Identificador Para a sala                                | Serial          |         | PK                     |
| mundo      |  informa a origem de uma Sala (Exemplo Fogo, Terra, Nublado) | Int       |      | FK  / Not Null              |
| Dificuldade |  Identificador para a dificuldade      | Int       |      | Not Null               |

<center> <figcaption>
    <b>Figura 12:
     Entidade Sala</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Personagem

| Nome        | Descrição                               | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ----------- | --------------------------------------- | ------------ | ------- | ---------------------- |
| id_personagem   | Identificador para o jogador            | Serial          |         | PK                     |
| nome | Descreve o nome para um jogador         | Char       | 40    |               |

<center> <figcaption>
    <b>Figura 13:
     Entidade Personagem</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Bencao

| Nome             | Descrição                                                  | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ---------------- | ---------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_pc         |  Identificador Para os status do jogador (PC)                            | int          |         | FK / Not Null                    |
| vida      |  Identificador para a vida do jogador                  | Int       |      | Not Null               |
| mana         |  Identificador para a mana do jogador | Int       |      | Not Null               |
| atk_base              | Identificador para o ataque base do personagem                                     | int          |         | Not Null               |
| arm_base             | Identificador para o armadura base do personagem                                        | int       |      | Not Null                     |
| operacao           | indica o que a benção faz                            | Char      | 3     | Unique / Not Null                    |

<center> <figcaption>
    <b>Figura 14:
     Entidade Bencao</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Inimigo Comumum

| Nome               | Descrição                                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_inm_com | Indetificador para a recompensa (cada recompensa possui um tipo) | Serial         |         | PK / FK          |
| vida               | Identificador para a vida do jogador      | Int          |         | Not Null               |
| nivel              | Identificador para o nível do personagem                             | Int       |      | Not Null               |
| atk_base              | Identificador para o ataque base do personagem                                     | int          |         | Not Null               |
| arm_base             | Identificador para o armadura base do personagem                                        | int      |      | Not Null                   |
| ouro_drop             | Identificador para os drops de ouro                                         | Int       |      | Not Null                     |
| orb_drop             | Identificador para os drops de orbs                                         | Int       |      | Not Null                     |

<center> <figcaption>
    <b>Figura 15:
     Entidade Inimigo Comum</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### PC 

| Nome               | Descrição                                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_pc         |  Identificador Para os status do jogador (PC)                            | Serial          |         | PK                   |
| vida               | Identificador para a vida do jogador    | Int          |         | Not Null               |
| mana               | Identificador para a mana do jogador                             | Int       |      | Not Null               |
| ouro              |  Identificador para a quantidade de ouro do personagem                                     | Int          |         | Not Null               |
| orbs            | Identificador para a quantidade de orbs do personagem                                        | Int      |      | Not Null                    |
| atk_base              | Identificador para o ataque base do personagem                                     | Int          |         | Not Null               |
| arm_base             | Identificador para o armadura base do personagem                                        | Int      |      | Not Null                   |
| armadura            | Indetificador para a armadura atual do personagem                                   | Int       |      | FK                     |
| arma            | Indetificador para a arma                                        | Int       |      | FK                     |
| sala            | Indetificador para a Sala                                        | Int       |      | FK                     |

<center> <figcaption>
    <b>Figura 16:
     Entidade PC</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Instancia_NPC

| Nome               | Descrição                                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_npc |  Indetificador para o NPC | Int          |         | FK / Not Null          |
| id_sala               |  Identificador para a sala do NPC    | Int          |         | FK / Not Null              |

<center> <figcaption>
    <b>Figura 17:
     Entidade Instancia NPC</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>


### Chefe

| Nome               | Descrição                                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_chefe | Indetificador para o chefe | Serial          |         | PK / FK          |
| arma            | Indetificador para a arma                                        | Int      |      | FK / Not Null                    |
| vida               | Identificador para a vida do jogador    | Int          |         | Not Null               |
| nivel              | Identificador para o nível do personagem                             | Int       |      | Not Null               |
| atk_base              | Identificador para o ataque base do personagem                                     | Int          |         | Not Null               |
| arm_base             | Identificador para a armadura base do personagem                                        | Int       |      | Not Null                   |
| ouro_drop             | Identificador para os drops de ouro                                         | Int       |      | Not Null                    |
| orb_drop             | Identificador para os drops de orbs                                         | Int       |      | Not Null                     |

<center> <figcaption>
    <b>Figura 18:
     Entidade Chefe</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Mundo

| Nome               | Descrição                                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_mundo | Indetificador para especificar o mundo | Serial          |         | PK          |
| id_anterior               | Indetificador para o mundo anterior  | Int          |         | FK               |
| id_proximo               | Indetificador para o próximo mundo                           | Int       |      | FK              |
| Dificuldade |  Identificador para a dificuldade      | Int       |      | Not Null               |

<center> <figcaption>
    <b>Figura 19:
     Entidade Mundo</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Viagem_origem

| Nome               | Descrição                                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_sala               |  Identificador para a sala     | Int          |         | PK / FK / Not Null             |
| id_origem               | Identificador para a sala de origem    | Int          |         | FK / Not Null              |

<center> <figcaption>
    <b>Figura 20:
     Entidade Viagem Origem</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Viagem_destino

| Nome               | Descrição                                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------------------- | ------------ | ------- | ---------------------- |
| id_sala               |  Identificador para a sala     | Int          |         | PK / FK / Not Null              |
| id_origem               | Identificador para a sala de origem    | Int          |         | FK  / Not Null             |

<center> <figcaption>
    <b>Figura 21:
     Entidade Viagem Destino</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

## Histórico de Versão
|    Data    | Versão |          Descrição          |                                                                                          Autores                                                                                           |
| :--------: | :----: | :-------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| 23/09/2023 | `1.0`  | Criação da primeira versão. | [Francisco Mizael Santos](https://github.com/frmiza), [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES), [Joao Lucas Pinto Vasconcelos](https://github.com/HacKairos) |
| 28/10/2023 |  1.1   |    Nomalizando os dados     |                                                                    [Francisco Mizael Santos](https://github.com/frmiza)                                                                    |
| 02/12/2023 |  1.2   |   Criação da segunda versão   |                                                                    [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES)                                                                    |
| 02/12/2023 |  1.3   |   Correções necessárias    |                                                                    [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES)                                                                    |
