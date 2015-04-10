-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- creating the DATABASE
CREATE DATABASE tournament;

-- creating TABLES
CREATE TABLE players (
	id serial PRIMARY KEY,
	name text
);

CREATE TABLE matches (
	p1 integer,
	p2 integer,
	winner integer,
	PRIMARY KEY (p1, p2)
);
