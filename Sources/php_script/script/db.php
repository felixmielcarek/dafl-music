<?php
$dns = 'mysql:host='.$_ENV["CODEFIRST_CLIENTDRONE_ENV_INNONDB_HOST"].';dbname='.$_ENV["CODEFIRST_CLIENTDRONE_ENV_INNODB_DATABASE"];
$user = $_ENV["CODEFIRST_CLIENTDRONE_ENV_INNODB_USER"];
$password = $_ENV["CODEFIRST_CLIENTDRONE_ENV_INNODB_PASSWORD"];
try{
    $db = new PDO ($dns, $user, $password);
}catch( PDOException $e){
    $error = $e->getMessage();
    echo $error;
}
