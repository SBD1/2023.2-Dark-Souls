# Modelo Entidade-Relacionamento

<div>
<p>O modelo Entidade-Relacionamento tem como principal função, descrever itens, em outras palavras entidades, que são utilizadas para representar participantes de um cenário em um problema que deseja ser resolvido mediante utilização de um banco de dados.</p>
</div>

## 1. Entidades 
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

## 2. Atributos
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

## 3. Relacionamentos
