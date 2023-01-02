<?php

require "gateways/UserGateway.php";
require "gateways/LikesGateway.php";
require "business/User.php";

class Model
{
    public function getInformationsUser($id): array
    {
        global $app;
        $db = $app->getContainer()['settings']['db'];
        $id = filter_var($id, FILTER_SANITIZE_STRING);
        $gw = new UserGateway(new Connection($db['dsn'], $db['user'], $db['pass']));
        $userDb = $gw->getInformations($id);
        if (count($userDb) != 1) {
            throw new Exception("no user matches id");
        }
        $user = new User($userDb[0][0], $userDb[0][1]);
        return $user->getInformations();
    }

    public function addUser($idDafl, $idSpotify, $passw): void
    {
        global $app;
        $db = $app->getContainer()['settings']['db'];

        $data = [];
        $data['idDafl'] = filter_var($idDafl, FILTER_SANITIZE_STRING);
        $data['idSpotify'] = filter_var($idSpotify, FILTER_SANITIZE_STRING);
        $data['passw'] = filter_var($passw, FILTER_SANITIZE_STRING);
        $gw = new UserGateway(new Connection($db['dsn'], $db['user'], $db['pass']));
        $gw->addUser($data['idDafl'], $data['idSpotify'], $data['passw']);
    }

    public function like($user,$liked) : bool {
    	global $app;
	$db = $app->getContainer()['settings']['db'];

        $data = [];
        $data['user'] = filter_var($user, FILTER_SANITIZE_STRING);
        $data['liked'] = filter_var($liked, FILTER_SANITIZE_STRING);
        $gw = new LikesGateway(new Connection($db['dsn'], $db['user'], $db['pass']));
        return $gw->addUser($data['idDafl'], $data['idSpotify'], $data['passw']);
    }
}
