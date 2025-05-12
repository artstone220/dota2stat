USE master;
GO

DROP DATABASE IF EXISTS Dota2Stats;
GO

CREATE DATABASE Dota2Stats;
GO

USE Dota2Stats;
GO

-- Создание таблицы героев (узлы)
CREATE TABLE Heroes (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
) AS NODE;

-- Создание таблицы предметов (узлы)
CREATE TABLE Items (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
) AS NODE;

-- Создание таблицы игроков (узлы)
CREATE TABLE Players (
    id INT PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL
) AS NODE;

-- Создание таблицы связи "Игрок играет за героя" (ребро)
CREATE TABLE Plays (
    MatchesPlayed INT,
    WinRate VARCHAR(10)
) AS EDGE;

-- Создание таблицы связи "Игрок предпочитает предмет" (ребро)
CREATE TABLE PlayerPrefersItem (
    PreferenceScore INT NOT NULL
) AS EDGE;

-- Создание таблицы связи "Герой покупает предмет" (ребро)
CREATE TABLE HeroBuysItem (
    Priority INT NOT NULL,
    WinRateBoost VARCHAR(10) NOT NULL
) AS EDGE;

ALTER TABLE Plays
ADD CONSTRAINT EC_Plays CONNECTION (Players TO Heroes);

ALTER TABLE PlayerPrefersItem
ADD CONSTRAINT EC_PlayerPrefersItem CONNECTION (Players TO Items);

ALTER TABLE HeroBuysItem
ADD CONSTRAINT EC_HeroBuysItem CONNECTION (Heroes TO Items);

-- Вставка данных в таблицу героев
INSERT INTO Heroes (id, name) VALUES
(1, 'Anti-Mage'),
(2, 'Crystal Maiden'),
(3, 'Pudge'),
(4, 'Invoker'),
(5, 'Juggernaut'),
(6, 'Lion'),
(7, 'Tidehunter'),
(8, 'Storm Spirit'),
(9, 'Drow Ranger'),
(10, 'Earthshaker'),
(11, 'Axe'),
(12, 'Shadow Fiend');

-- Вставка данных в таблицу предметов
INSERT INTO Items (id, name) VALUES
(1, 'Battle Fury'),
(2, 'Blink Dagger'),
(3, 'Aghanim''s Scepter'),
(4, 'Black King Bar'),
(5, 'Power Treads'),
(6, 'Hand of Midas'),
(7, 'Divine Rapier'),
(8, 'Heart of Tarrasque'),
(9, 'Scythe of Vyse'),
(10, 'Pipe of Insight'),
(11, 'Radiance'),
(12, 'Eul''s Scepter');

-- Вставка данных в таблицу игроков
INSERT INTO Players (id, nickname) VALUES
(1, 'Miracle-'),
(2, 'Arteezy'),
(3, 'SumaiL'),
(4, 'N0tail'),
(5, 'Puppey'),
(6, 'Dendi'),
(7, 'Ana'),
(8, 'Topson'),
(9, 'GH'),
(10, 'KuroKy'),
(11, 's4'),
(12, 'Fear');

INSERT INTO Plays ($from_id, $to_id, MatchesPlayed, WinRate) VALUES

((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Heroes WHERE id = 4), 500, '65%'),
((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Heroes WHERE id = 8), 300, '70%'),

((SELECT $node_id FROM Players WHERE id = 2), (SELECT $node_id FROM Heroes WHERE id = 5), 800, '60%'),
((SELECT $node_id FROM Players WHERE id = 2), (SELECT $node_id FROM Heroes WHERE id = 1), 400, '55%'),

((SELECT $node_id FROM Players WHERE id = 3), (SELECT $node_id FROM Heroes WHERE id = 8), 600, '68%'),
((SELECT $node_id FROM Players WHERE id = 3), (SELECT $node_id FROM Heroes WHERE id = 12), 450, '62%'),

((SELECT $node_id FROM Players WHERE id = 4), (SELECT $node_id FROM Heroes WHERE id = 2), 700, '58%'),
((SELECT $node_id FROM Players WHERE id = 4), (SELECT $node_id FROM Heroes WHERE id = 6), 350, '52%'),

((SELECT $node_id FROM Players WHERE id = 5), (SELECT $node_id FROM Heroes WHERE id = 7), 450, '57%'),
((SELECT $node_id FROM Players WHERE id = 5), (SELECT $node_id FROM Heroes WHERE id = 10), 500, '60%'),

((SELECT $node_id FROM Players WHERE id = 6), (SELECT $node_id FROM Heroes WHERE id = 3), 1200, '63%'),
((SELECT $node_id FROM Players WHERE id = 6), (SELECT $node_id FROM Heroes WHERE id = 4), 400, '50%'),

((SELECT $node_id FROM Players WHERE id = 7), (SELECT $node_id FROM Heroes WHERE id = 5), 600, '65%'),
((SELECT $node_id FROM Players WHERE id = 7), (SELECT $node_id FROM Heroes WHERE id = 9), 300, '58%'),

((SELECT $node_id FROM Players WHERE id = 8), (SELECT $node_id FROM Heroes WHERE id = 4), 400, '75%'),
((SELECT $node_id FROM Players WHERE id = 8), (SELECT $node_id FROM Heroes WHERE id = 8), 200, '80%'),

((SELECT $node_id FROM Players WHERE id = 9), (SELECT $node_id FROM Heroes WHERE id = 6), 350, '62%'),
((SELECT $node_id FROM Players WHERE id = 9), (SELECT $node_id FROM Heroes WHERE id = 12), 300, '64%'),

((SELECT $node_id FROM Players WHERE id = 10), (SELECT $node_id FROM Heroes WHERE id = 2), 450, '70%'),
((SELECT $node_id FROM Players WHERE id = 10), (SELECT $node_id FROM Heroes WHERE id = 10), 500, '68%'),

((SELECT $node_id FROM Players WHERE id = 11), (SELECT $node_id FROM Heroes WHERE id = 11), 400, '60%'),
((SELECT $node_id FROM Players WHERE id = 11), (SELECT $node_id FROM Heroes WHERE id = 7), 350, '54%'),

((SELECT $node_id FROM Players WHERE id = 12), (SELECT $node_id FROM Heroes WHERE id = 3), 600, '69%'),
((SELECT $node_id FROM Players WHERE id = 12), (SELECT $node_id FROM Heroes WHERE id = 9), 450, '63%');

INSERT INTO PlayerPrefersItem ($from_id, $to_id, PreferenceScore) VALUES

((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Items WHERE id = 3), 90),
((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Items WHERE id = 2), 85),

((SELECT $node_id FROM Players WHERE id = 2), (SELECT $node_id FROM Items WHERE id = 1), 95),
((SELECT $node_id FROM Players WHERE id = 2), (SELECT $node_id FROM Items WHERE id = 4), 80),

((SELECT $node_id FROM Players WHERE id = 3), (SELECT $node_id FROM Items WHERE id = 12), 88),
((SELECT $node_id FROM Players WHERE id = 3), (SELECT $node_id FROM Items WHERE id = 2), 75),

((SELECT $node_id FROM Players WHERE id = 4), (SELECT $node_id FROM Items WHERE id = 10), 92),
((SELECT $node_id FROM Players WHERE id = 4), (SELECT $node_id FROM Items WHERE id = 9), 78),

((SELECT $node_id FROM Players WHERE id = 5), (SELECT $node_id FROM Items WHERE id = 6), 85),
((SELECT $node_id FROM Players WHERE id = 5), (SELECT $node_id FROM Items WHERE id = 7), 80),

((SELECT $node_id FROM Players WHERE id = 6), (SELECT $node_id FROM Items WHERE id = 2), 100),
((SELECT $node_id FROM Players WHERE id = 6), (SELECT $node_id FROM Items WHERE id = 3), 85),

((SELECT $node_id FROM Players WHERE id = 7), (SELECT $node_id FROM Items WHERE id = 1), 90),
((SELECT $node_id FROM Players WHERE id = 7), (SELECT $node_id FROM Items WHERE id = 4), 75),

((SELECT $node_id FROM Players WHERE id = 8), (SELECT $node_id FROM Items WHERE id = 3), 88),
((SELECT $node_id FROM Players WHERE id = 8), (SELECT $node_id FROM Items WHERE id = 12), 80),

((SELECT $node_id FROM Players WHERE id = 9), (SELECT $node_id FROM Items WHERE id = 9), 92),
((SELECT $node_id FROM Players WHERE id = 9), (SELECT $node_id FROM Items WHERE id = 8), 85),

((SELECT $node_id FROM Players WHERE id = 10), (SELECT $node_id FROM Items WHERE id = 2), 90),
((SELECT $node_id FROM Players WHERE id = 10), (SELECT $node_id FROM Items WHERE id = 10), 88),

((SELECT $node_id FROM Players WHERE id = 11), (SELECT $node_id FROM Items WHERE id = 11), 85),
((SELECT $node_id FROM Players WHERE id = 11), (SELECT $node_id FROM Items WHERE id = 12), 80),

((SELECT $node_id FROM Players WHERE id = 12), (SELECT $node_id FROM Items WHERE id = 7), 90),
((SELECT $node_id FROM Players WHERE id = 12), (SELECT $node_id FROM Items WHERE id = 8), 85);

INSERT INTO HeroBuysItem ($from_id, $to_id, Priority, WinRateBoost) VALUES

((SELECT $node_id FROM Heroes WHERE id = 1), (SELECT $node_id FROM Items WHERE id = 1), 1, '+15%'),
((SELECT $node_id FROM Heroes WHERE id = 1), (SELECT $node_id FROM Items WHERE id = 11), 2, '+10%'),

((SELECT $node_id FROM Heroes WHERE id = 2), (SELECT $node_id FROM Items WHERE id = 2), 1, '+10%'),
((SELECT $node_id FROM Heroes WHERE id = 2), (SELECT $node_id FROM Items WHERE id = 6), 2, '+7%'),

((SELECT $node_id FROM Heroes WHERE id = 3), (SELECT $node_id FROM Items WHERE id = 2), 1, '+18%'),
((SELECT $node_id FROM Heroes WHERE id = 3), (SELECT $node_id FROM Items WHERE id = 8), 2, '+14%'),

((SELECT $node_id FROM Heroes WHERE id = 4), (SELECT $node_id FROM Items WHERE id = 3), 1, '+20%'),
((SELECT $node_id FROM Heroes WHERE id = 4), (SELECT $node_id FROM Items WHERE id = 12), 2, '+12%'),

((SELECT $node_id FROM Heroes WHERE id = 5), (SELECT $node_id FROM Items WHERE id = 1), 1, '+16%'),
((SELECT $node_id FROM Heroes WHERE id = 5), (SELECT $node_id FROM Items WHERE id = 5), 2, '+8%'),

((SELECT $node_id FROM Heroes WHERE id = 6), (SELECT $node_id FROM Items WHERE id = 4), 1, '+16%'),
((SELECT $node_id FROM Heroes WHERE id = 6), (SELECT $node_id FROM Items WHERE id = 10), 2, '+8%'),

((SELECT $node_id FROM Heroes WHERE id = 7), (SELECT $node_id FROM Items WHERE id = 4), 1, '+15%'),
((SELECT $node_id FROM Heroes WHERE id = 7), (SELECT $node_id FROM Items WHERE id = 9), 2, '+10%'),

((SELECT $node_id FROM Heroes WHERE id = 8), (SELECT $node_id FROM Items WHERE id = 4), 1, '+12%'),
((SELECT $node_id FROM Heroes WHERE id = 8), (SELECT $node_id FROM Items WHERE id = 12), 2, '+9%'),

((SELECT $node_id FROM Heroes WHERE id = 9), (SELECT $node_id FROM Items WHERE id = 5), 1, '+12%'),
((SELECT $node_id FROM Heroes WHERE id = 9), (SELECT $node_id FROM Items WHERE id = 7), 2, '+20%'),

((SELECT $node_id FROM Heroes WHERE id = 10), (SELECT $node_id FROM Items WHERE id = 2), 1, '+14%'),
((SELECT $node_id FROM Heroes WHERE id = 10), (SELECT $node_id FROM Items WHERE id = 3), 2, '+16%'),

((SELECT $node_id FROM Heroes WHERE id = 11), (SELECT $node_id FROM Items WHERE id = 1), 1, '+15%'),
((SELECT $node_id FROM Heroes WHERE id = 11), (SELECT $node_id FROM Items WHERE id = 9), 2, '+10%'),

((SELECT $node_id FROM Heroes WHERE id = 12), (SELECT $node_id FROM Items WHERE id = 3), 1, '+20%'),
((SELECT $node_id FROM Heroes WHERE id = 12), (SELECT $node_id FROM Items WHERE id = 4), 2, '+15%');

SELECT P.nickname AS PlayerName, PL.MatchesPlayed, PL.WinRate
FROM Players P, Plays PL, Heroes H
WHERE MATCH(P-(PL)->H) AND H.name = 'Invoker';

SELECT I.name AS ItemName, PPI.PreferenceScore
FROM Players P, PlayerPrefersItem PPI, Items I
WHERE MATCH(P-(PPI)->I) AND P.nickname = 'Miracle-'
ORDER BY PPI.PreferenceScore DESC;

SELECT  I.name AS ItemName, HBI.Priority, HBI.WinRateBoost
FROM Heroes H, HeroBuysItem HBI, Items I
WHERE MATCH(H-(HBI)->I) AND H.name = 'Anti-Mage'
ORDER BY HBI.Priority ASC;

SELECT 
    H.name AS Hero,
    SUM(PL.MatchesPlayed) AS TotalMatchesPlayed
FROM 
    Players P,
    Plays PL,
    Heroes H
WHERE 
    MATCH(P-(PL)->H)
GROUP BY 
    H.name
ORDER BY 
    TotalMatchesPlayed DESC;

SELECT 
    P.nickname AS Player,
    H.name AS Hero,
    PL.MatchesPlayed AS HeroMatches,
    I.name AS PreferredItem,
    PPI.PreferenceScore
FROM Players P, Plays PL, Heroes H, PlayerPrefersItem PPI, Items I
WHERE MATCH(P-(PL)->H) AND MATCH(P-(PPI)->I) AND P.nickname = 'Arteezy';


	SELECT 
    P1.nickname + ' играет на ' + H1.name AS level1,
    H1.name + ' покупает ' + I.name AS level2
FROM 
    Players AS P1,
    Plays AS PL1,
    Heroes AS H1,
    HeroBuysItem AS HBI,
    Items AS I
WHERE 
    MATCH(P1-(PL1)->H1-(HBI)->I)
    AND P1.nickname = 'Miracle-';

DECLARE @PlayerFrom AS VARCHAR(50) = 'Miracle-';
DECLARE @PlayerTo AS VARCHAR(50) = 'Dendi';

WITH PlayerConnections AS (
    SELECT 
        P1.nickname AS PlayerName,
        P1.nickname + '->' + STRING_AGG(P2.nickname, '->') WITHIN GROUP (GRAPH PATH) AS ConnectionPath,
        LAST_VALUE(P2.nickname) WITHIN GROUP (GRAPH PATH) AS LastNode
    FROM 
        Players AS P1,
        PlayerPrefersItem FOR PATH AS ppi1,
        Items FOR PATH AS i,
        PlayerPrefersItem FOR PATH AS ppi2,
        Players FOR PATH AS P2
    WHERE 
        MATCH(SHORTEST_PATH(P1(-(ppi1)->i<-(ppi2)-P2)+))
        AND P1.nickname = @PlayerFrom
)
SELECT PlayerName, ConnectionPath
FROM PlayerConnections
WHERE LastNode = @PlayerTo;








