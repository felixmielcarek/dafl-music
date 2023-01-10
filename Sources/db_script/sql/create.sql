DROP TABLE IF EXISTS Musique;
DROP TABLE IF EXISTS Matchs;
DROP TABLE IF EXISTS LikeDafl;
DROP TABLE IF EXISTS UserDafl;


CREATE TABLE UserDafl(
    idDafl INT PRIMARY KEY,
    pseudo varchar(50) NOT NULL,
    idSpotify varchar(150) NOT NULL,
    profilPicture varchar(200) NOT NULL
);

CREATE TABLE Musique(
    idUser INT REFERENCES UserDafl(idDafl),
    idMusic INT,
    title varchar(50) NOT NULL,
    artist varchar(50) NOT NULL,
    album varchar(50) NOT NULL,
    category varchar(100),
    PRIMARY KEY(idUser,idMusic)
);

CREATE TABLE Matchs(
    idUserA INT REFERENCES UserDafl(idDafl),
    idUserB INT REFERENCES UserDafl(idDafl),
    dateMatch date NOT NULL,
    PRIMARY KEY(idUserA,idUserB)
);

CREATE TABLE LikeDafl(
    idUserWhoLike INT REFERENCES UserDafl(idDafl),
    idUserWhoGetLike INT REFERENCES UserDafl(idDafl),
    dateLike date NOT NULL,
    PRIMARY KEY(idUserWhoLike,idUserWhoGetLike)
);