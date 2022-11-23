<?php
$dns = 'mysql:host='.CODEFIRST_CLIENTDRONE_ENV_INNONDB_HOST.';dbname='.CODEFIRST_CLIENTDRONE_ENV_INNODB_DATABASE;
$user = CODEFIRST_CLIENTDRONE_ENV_INNODB_USER;
$password = CODEFIRST_CLIENTDRONE_ENV_INNODB_PASSWORD;
try{
    $db = new PDO ($dns, $user, $password);
}catch( PDOException $e){
    $error = $e->getMessage();
    echo $error;
}
