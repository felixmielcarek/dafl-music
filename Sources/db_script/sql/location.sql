CREATE DATABASE IF NOT EXISTS positiondaflmusic;

CREATE USER $(USER)@'%' IDENTIFIED BY $(PASSWORD);

GRANT ALL PRIVILEGES ON * . * TO $(USER)@'%';

FLUSH PRIVILEGES;

CREATE TABLE gps (
  id varchar(30) PRIMARY KEY,
  latitude double NOT NULL,
  longitude double NOT NULL,
  idMusic varchar(100) NOT NULL,
  dateLog datetime NOT NULL
);



