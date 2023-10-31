# Modelo Entidade-Relacionamento

<div>
<p>O modelo Entidade-Relacionamento tem como principal função, descrever itens, em outras palavras entidades, que são utilizadas para representar participantes de um cenário em um problema que deseja ser resolvido mediante utilização de um banco de dados.</p>
</div>

## Entidades 
- **Mundo**
- **Bençãos**
- **BençãoPlayer**
- **InventarioPlayer**
- **Arma**
- **Sala**
    - **BossRoom**
    - **LootRoom**
    - **NpcRoom**
    - **Loja**
- **Personagem**
    - **PC**
    - **NPC**
    - **Inimigo**
        - **Comum**
        - **Boss**

## Atributos
- **Mundo**:<ins>ID_mundo</ins>, nome, descrição;
- **Bençãos**:<ins>ID_benção_undo</ins>,descrição, raridade, função; 
- **BençãoPlayer**:<ins>ID_benção_player</ins>, descrição, raridade, função;
- **InventarioPlayer**:
- **Arma**:<ins>ID_arma</ins>, nome, status;
- **Sala**:<ins>ID_sala</ins>, tipo, descrição, layout;
    - **BossRoom**:recompensa;
    - **LootRoom**:recompensa, chance de drop, quantidade inimigos, quantidade loots;
    - **NpcRoom**: recompensa;
    - **Loja**:item, quantidade itens, preços;
- **Personagem**:<ins>ID_personagem</ins>, nome
    - **PC**: status;
    - **NPC**: mundoID, função;
    - **Inimigo**: status, mundoID;
        - **Comum**:;
        - **Boss**:;

## Relacionamentos
**Mundo** Possui **Sala**<br>
Um Mundo possui N salas e uma sala pertence a um mundo.<br>
**Cardinalidade** (1:N)

**Sala** Possui **Benção**<br>
Um sala pode pode ter um ou nenhuma benção e uma benção pode estar ou não em uma sala.<br>
**Cardinalidade** (1:0,1)

**Sala** Contem **Personagem**<br>
Uma sala contem mais de um personagem e algum personagem independentemente do tipo esta em uma sala.<br>
**Cardinalidade** (1:N)

**Sala** **LootRoom** Possui varios **Personagem** **Inimigo** **Comum** <br>
 Uma sala de loot possui varios inimigos comuns.<br>
**Cadinalidade** (1:N)

**Sala** **NpcRoom** Controlado por um **Personagem** **NPC**<br>
Uma sala de Npc contem apenas um NPC.<br>
**Cardinalidade** (1:1)

**Sala** **Loja** Controlado por um **Personagem** **NPC**<br>
Uma sala de Loja contem apenas um NPC.<br>
**Cardinalidade** (1:1)

**Sala** **Loja** Vende zero ou uma **BençãosPlayer**<br>
Uma Sala loja pode vender até uma Benção para o player.<br>
**Cardinalidade** (1:0,1)

**Sala** **Loja** Cambia com um **BençãosPlayer**<br>
Uma Sala loja Cambia com um InventarioPlayer.<br>
**Cardinalidade** (1:1)

**Personagem** **PC** Possui de Uma a Seis **Armas**<br>
Um Personagem Pc pode ter de uma a seis armas.<br>
**Cardinalidade** (1:1,6)

**Personagem** **PC** Possui um **InventarioPlayer**<br>
Um personagem Possui Um inventario.<br>
**Cardinalidade** (1:1)

**Personagem** **PC** Possui Zero a N **BençãosPlayer**<br>
Um Personagem Pc pode ter de zero a N Bençãos.<br>
**Cardinalidade** (1:0,N)

**BençãosPlayer** Conquista **Bençãos**<br>
Bençãos são conquistadas em BençãosPlayer.<br>
**Cardinalidade** (1:0,N)

**Personagem** **Inimigo** **Boss** Governa uma **Sala** **BossRoom**<br>
Um personagem boss governa uma determinada sala.<br>
**Cardinalidade** (1:1)

**Personagem** **Inimigo** **Boss** Vive em um **Mundo**<br>
Um personagem boss Vive em um determinado Mundo.<br>
**Cardinalidade** (1:1)

**Personagem** **Inimigo** **Boss** Dropa uma **Arma**<br>
Um personagem boss Dropa uma arma ao ser derrotado.<br>
**Cardinalidade** (1:1)

## Histórico de versão 

| Data | Versão | Descrição | Autores |
|:------:|:--------:|-----------|-------|
| 23/09/2023 | `1.0` | Criação da primeira versão. | [Francisco Mizael Santos](https://github.com/frmiza), [Guilherme Basílio do Espirito Santo](https://github.com/GuilhermeBES), [Joao Lucas Pinto Vasconcelos](https://github.com/HacKairos),[Arthur José Nascimento de Lima](https://github.com/Arthurlima544)  |
