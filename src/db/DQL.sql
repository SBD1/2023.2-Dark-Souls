BEGIN TRANSACTION;

SELECT *
FROM Mundo;

SELECT *
FROM Mundo
WHERE nome = 'Nome do mundo'; 

SELECT Personagen.nome
FROM Personagen 
JOIN PC ON Personagem.id_personagem = PC.id_pc;

SELECT *
FROM Personagen
JOIN PC ON Personagem.id_personagem = PC.id_pc;

SELECT Sala.id_sala, Sala.nome, Sala.dificuldade
FROM Sala 
JOIN Mundo ON Sala.mundo = Mundo.id_mundo;

SELECT Sala.id_sala, Sala.nome, Sala.dificuldade
FROM Sala
JOIN PC ON PC.sala = Sala.id_sala;

SELECT Sala.id_sala, Sala.nome, Sala.dificuldade
FROM Sala
JOIN PC ON PC.sala = Sala.id_sala
JOIN Viagem_Destino ON Viagem_Destino.id_destino = Sala.id_sala;

SELECT Sala.id_sala, Sala.nome, Sala.dificuldade
FROM Sala
JOIN PC ON PC.sala = Sala.id_sala
JOIN Viagem_Origem ON Viagem_Origem.id_origem = Sala.id_sala;

SELECT Inimigo_Comum.*
FROM Instancias_NPC
JOIN Sala ON Instancias_NPC.id_sala = Sala.id_sala
JOIN Inimigo_Comum ON Inimigo_Comum.id_inm_com = Instancias_NPC.id_npc;

COMMIT;
