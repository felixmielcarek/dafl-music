CREATE TABLE UserDafl(
    idDafl INT PRIMARY KEY,
    pseudo varchar(50) NOT NULL,
    idSpotify varchar(150) NOT NULL,
    profilPicture varchar(200) NOT NULL
);

CREATE TABLE Musique(
    idUser INT REFERENCES User(idDafl),
    idMusic INT,
    title varchar(50) NOT NULL,
    artist varchar(50) NOT NULL,
    album varchar(50) NOT NULL,
    category varchar(100),
    PRIMARY KEY(idUser,idMusic)
);

CREATE TABLE Matchs(
    idUserA INT REFERENCES User(idDafl),
    idUserB INT REFERENCES User(idDafl),
    dateMatch date NOT NULL,
    PRIMARY KEY(idUserA,idUserB)
);

CREATE TABLE LikeDafl(
    idUserWhoLike INT REFERENCES User(idDafl),
    idUserWhoGetLike INT REFERENCES User(idDafl),
    dateLike date NOT NULL,
    PRIMARY KEY(idUserWhoLike,idUserWhoGetLike)
);

CREATE TABLE MessageDafl(
    senderID INT NOT NULL REFERENCES User(idDafl) ,
    idMessage INT PRIMARY KEY,
    content varchar(500),
    dateMess date NOT NULL
);

CREATE TABLE ConversationDafl(
    idUserA INT NOT NULL REFERENCES User(idDafl),
    idUserB INT NOT NULL REFERENCES User(idDafl),
    idConversation INT PRIMARY KEY,
    waiting BOOLEAN NOT NULL CHECK (waiting=1 OR waiting=0)
);

CREATE TABLE MessToConv(
    idConv INT REFERENCES Conversation(idConversation),
    idMsg INT REFERENCES Message(idMessage),
    PRIMARY KEY (idConv,idMsg)
);