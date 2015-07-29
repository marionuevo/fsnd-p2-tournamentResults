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

-- creating VIEWS
CREATE VIEW matchesNumber AS
    SELECT
        players.id,
        count (matches.winner + matches.looser) AS matches
    FROM players LEFT JOIN matches ON
        (players.id = matches.winner OR players.id = matches.looser)
    GROUP BY players.id;

CREATE VIEW winsNumber AS
    SELECT
        players.id,
        count (matches.winner) as wins
    FROM players LEFT JOIN matches ON
        (players.id = matches.winner)
    GROUP BY players.id;

CREATE VIEW standings AS
    SELECT
        players.id,
        players.name,
        winsNumber.wins,
        matchesNumber.matches
    FROM
        players, matchesNumber, winsNumber
    WHERE
        players.id = matchesNumber.id AND
        players.id = winsNumber.id
    ORDER BY wins DESC;
