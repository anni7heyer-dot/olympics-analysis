CREATE TABLE sports (
sport_id INT PRIMARY KEY,
sport_name VARCHAR(150)
);

CREATE TABLE countries (
noc VARCHAR(5) PRIMARY KEY,
country_name VARCHAR(100)
);

CREATE TABLE athletes(
athlete_id INT PRIMARY KEY,
name VARCHAR (150),
sex VARCHAR (20),
height SMALLINT,
weight SMALLINT
);

CREATE TABLE events(
event_id SMALLINT PRIMARY KEY,
event_name VARCHAR(255),
sport_id SMALLINT REFERENCES sports(sport_id)
);

CREATE TYPE medal_enum AS ENUM ('Gold', 'Silver', 'Bronze');

CREATE TABLE participations(
participation_id INT PRIMARY KEY,
athlete_id INT REFERENCES athletes(athlete_id),
event_id SMALLINT REFERENCES events(event_id),
noc VARCHAR (5) REFERENCES countries(noc),
year SMALLINT,
age SMALLINT,
medal medal_enum
);


COPY sports (sport_id, sport_name)
FROM 'C:\Program Files\PostgreSQL\17\data\import\sports.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

COPY countries (noc, country_name)
FROM 'C:\Program Files\PostgreSQL\17\data\import\countries.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

COPY athletes (athlete_id, name, sex, height, weight)
FROM 'C:\Program Files\PostgreSQL\17\data\import\athletes.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

COPY events (event_id, event_name, sport_id)
FROM 'C:\Program Files\PostgreSQL\17\data\import\events.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);


COPY participations (participation_id, athlete_id, event_id, noc, year, age, medal)
FROM 'C:\Program Files\PostgreSQL\17\data\import\participations.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    NULL ''
);