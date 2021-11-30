CREATE TABLE users(
    username CHAR[50] NOT NULL,
    password CHAR[50] NOT NULL,
    sign CHAR[50],
    tags CHAR[50] NOT NULL,
    PRIMARY KEY(username)
);

CREATE TABLE corals(
    master CHAR[50],
    coralname CHAR[50] NOT NULL,
    position CHAR[50] NOT NULL,
    updatetime CHAR[10] NOT NULL,
    tags CHAR[50] NOT NULL,
    species CHAR[20] NOT NULL,
    light CHAR[10] NOT NULL,
    temp CHAR[10] NOT NULL,
    microelement CHAR[10] NOT NULL,
    size INT NOT NULL,
    lastmeasure FLOAT NOT NULL,
    growth FLOAT NOT NULL,
    score INT NOT NULL,
    PRIMARY KEY(coralname)
);