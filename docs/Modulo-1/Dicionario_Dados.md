## Introdução

Um dicionário de dados em bancos de dados relacionais é uma coleção de dados que descrevem a estrutura e o conteúdo de um banco de dados. Através dele consigomos identificar Chaves Primárias e Estrangeiras, Nomes de Tabelas e campos, Tipos de Dados, Restrições e Regras, Observações e Descrição de tabelas e campos, tamanho.

O dicionário de dados é essencial para que os desenvolvedores do banco de dados entendam a sua estrutura e possam trabalhar com os dados de forma eficaz e segura. Ele orienta a manipulação e o gerenciamento dos dados no banco de dados relacional, permitindo uma melhor manutenção.

Para a confecção das tabelas foi utilizado a ferramento spreadsheets e o acesso ao dicionario pode ser encontrado em: [Link](https://docs.google.com/spreadsheets/d/1YHAq0cNd358JixKRJPjnu7olGClyv7xFmheFlepW34Q/edit?usp=sharing) 


## Entidades

A seguir Descrevemos todas Entidade que imaginamos para o jogo Hades.
### Mundo


| Nome | Descrição                                                   | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ---- | ----------------------------------------------------------- | ------------ | ------- | ---------------------- |
| ID   | Identificador Para o mundo                                  | Int          |         | PK                     |
| Nome | indica o nome daquele mundo que será exibido para o jogador | String       | 255     | Unique / Not Null      |

<center> <figcaption>
    <b>Figura 1:
     Entidade Mundo</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### NPC

| Nome               | Descrição                                            | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------- | ------------ | ------- | ---------------------- |
| ID                 | Identificador Para o NPC                             | Int          |         | PK                     |
| Nome               | indica o nome do npc que será exibido para o Jogador | String       | 255     | Unique / Not Null      |
| Mundo_ID           | Identificador Para o Mundo                           | String       | 255     | FK                     |
| Funcao             | indica o que o NPC fará em determinada Sala          | Strring      | 255     | Not Null               |
| Descricao_Completa | Apresenta uma descricao para o NPC                   | Strring      | 255     | Not Null               |

<center> <figcaption>
    <b>Figura 2:
     Entidade NPC</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>


### Chefe
| Nome     | Descrição                                                 | Tipo de Dado | Tamanho | Restrições  de Domínio |
| -------- | --------------------------------------------------------- | ------------ | ------- | ---------------------- |
| ID       | Identificador Para o Boss                                 | Int          |         | PK                     |
| Nome     | Informação sobre o Boss no jogo que será exibido no mundo | String       | 255     | Not Null               |
| Mundo_ID | Identificador Para o Mundo                                | String       | 255     | FK                     |

<center> <figcaption>
    <b>Figura 3:
     Entidade Boss</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>


### Sala
| Nome      | Descrição                                                   | Tipo de Dado | Tamanho | Restrições  de Domínio |
| --------- | ----------------------------------------------------------- | ------------ | ------- | ---------------------- |
| ID        | Identificador Para o SalaID                                 | Int          |         | PK                     |
| Tipo      | informa a origem de uma Sala (Exemplo Fogo, Terra, Nublado) | String       | 255     | Not Null               |
| Descricao | Texto exibido para o jogador sobre informações da sala      | String       | 255     | Not Null               |
| EhChefe   | indica que na sala há um Boss                               | bool         |         | Not Null               |
| EhNPC     | indica que na sala há um NPC                                | bool         |         | Not Null               |

<center> <figcaption>
    <b>Figura 4:
     Entidade Sala</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>


### Jogador
| Nome        | Descrição                               | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ----------- | --------------------------------------- | ------------ | ------- | ---------------------- |
| JogadorID   | Identificador para o jogador            | int          |         | PK                     |
| NomeJogador | Descreve o nome para um jogador         | String       | 255     | Not Null               |
| Status      | Descreve se o jogador está ativo ou não | Bool         | 255     | Not Null               |

<center> <figcaption>
    <b>Figura 5:
     Entidade Jogador</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Bencao

| Nome             | Descrição                                                  | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ---------------- | ---------------------------------------------------------- | ------------ | ------- | ---------------------- |
| BencaoID         | Identificador Para o Bencao                                | int          |         | PK                     |
| NomeBencao       | Informação sobre o Nome da Bencao do Jogo                  | String       | 255     | Not Null               |
| raridade         | indica uma raridade para o poder (raro, muito raro, comum) | String       | 255     | Not Null               |
| habilidadeBencao | Indica o pré-requisito sobre a bencao                      | String       | 255     | Not Null               |
| Nívelbencao      | indica o nível que é necessário para adiquirir a bencao    | Int          |         | Not Null, > 0          |
| SalaID           | indica o indentificador da sala                            | String       | 255     | FK                     |
| JogadorID        | Indica o identificador do Jogador                          | String       | 255     | FK                     |

<center> <figcaption>
    <b>Figura 6:
     Entidade Bencao</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Recompensa

| Nome               | Descrição                                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| ------------------ | ---------------------------------------------------------------- | ------------ | ------- | ---------------------- |
| TipoDeRecompensaID | Indetificador para a recompensa (cada recompensa possui um tipo) | Int          |         | PK / Not Null          |
| Ouro               | Quantidade de Ouro necessário para a compra de uma recompensa    | Int          |         | Not Null               |
| Orbe               | Indica o item para upar o Personagem                             | String       | 255     | Not Null               |
| vida               | Quantidade de Vida restaurada                                    | int          |         | Not Null               |
| SalaID             | Indetificador para a Sala                                        | String       | 255     | FK                     |

<center> <figcaption>
    <b>Figura 7:
     Entidade Recompensa</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Loja

| Nome            | Descrição                                        | Tipo de Dado | Tamanho | Restrições  de Domínio |
| --------------- | ------------------------------------------------ | ------------ | ------- | ---------------------- |
| LojaID          | Identificador Para a Loja                        | Int          |         | PK                     |
| BencaoAleatoria | Informação sobre o Preco de uma benção aleatória | int          |         | Not Null               |
| Ouro            | Mostra o ouro atual do jogador                   | int          |         | Not Null               |
| vida            | Quantidade de Vida restaurada                    | int          |         | Not Null               |
| Orbe            | Indica o item para upar o Personagem             | String       | 255     | Not Null               |
| SalaID          | Identificador da Sala                            | String       | 255     | Not Null               |

<center> <figcaption>
    <b>Figura 8:
     Entidade Loja</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>

### Arma
| Nome      | Descrição                 | Tipo de Dado | Tamanho | Restrições  de Domínio |
| --------- | ------------------------- | ------------ | ------- | ---------------------- |
| ArmaID    | Identificador da arma     | Int          |         | PK                     |
| NomeArma  | indica o nome da Arma     | String       | 255     | Not Null               |
| JogadorID | Indentificador do Jogador | String       | 255     | FK                     |

<center> <figcaption>
    <b>Figura 9:
     Entidade Arma</b>
    <br><small>Fonte:Propria</small>
</figcaption> </center>


## Histórico de Versão
|    Data    | Versão |          Descrição          |                                                                                          Autores                                                                                           |
| :--------: | :----: | :-------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| 23/09/2023 | `1.0`  | Criação da primeira versão. | [Francisco Mizael Santos](https://github.com/frmiza), [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES), [Joao Lucas Pinto Vasconcelos](https://github.com/HacKairos) |
| 28/10/2023 |  1.1   |    Nomalizando os dados     |                                                                    [Francisco Mizael Santos](https://github.com/frmiza)                                                                    |
