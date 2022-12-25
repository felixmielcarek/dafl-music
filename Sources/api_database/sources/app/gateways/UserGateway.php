<?php

class UserGateway
{
    private Connection $con;

    public function __construct(Connection $con)
    {
        $this->con = $con;
    }

    public function getInformations($id): array
    {
        $query = 'SELECT idDafl,idSpotify FROM users WHERE idDafl=:id';
        $this->con->executeQuery($query, array(':id' => array($id, PDO::PARAM_STR)));
        return $this->con->getResults();
    }

    public function addUser($idDafl, $idSpotify, $passw)
    {
        $query = 'INSERT INTO users VALUES (:idDafl,:idSpotify,:passw)';
        $this->con->executeQuery($query, array(':idDafl' => array($idDafl, PDO::PARAM_STR), ':idSpotify' => array($idSpotify, PDO::PARAM_STR), ':passw' => array($passw, PDO::PARAM_STR)));
    }
}