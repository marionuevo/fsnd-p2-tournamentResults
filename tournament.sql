-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


-- drop DATABASE, if exist
DROP DATABASE tournament;

-- creating the DATABASE
CREATE DATABASE tournament;

--  connect to it
\c tournament;

-- creating TABLES
CREATE TABLE players (
    id serial PRIMARY KEY,
    name text
);

CREATE TABLE matches (
    id serial PRIMARY KEY,
    winner integer,
    looser integer
);

CREATE VIEW standings AS
    SELECT mat.id, mat.name, count (matches.winner) as wins, mat.matcheslist as matches
    FROM matches RIGHT JOIN (
        SELECT players.id, players.name, count (matches.winner + matches.looser) as matcheslist 
        FROM players LEFT JOIN matches ON (players.id = matches.winner OR players.id = matches.looser)
        GROUP BY players.id) as mat
    ON mat.id = matches.winner
    GROUP BY mat.id, mat.name, mat.matcheslist ORDER BY wins DESC