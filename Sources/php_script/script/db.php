<?php
$dns = 'mysql:host=89.83.53.34;dbname=positiondaflmusic';
$user = 'dafldev';
$password = 'wrap';
try{
    $db = new PDO ($dns, $user, $password);
}catch( PDOException $e){
    $error = $e->getMessage();
    echo $error;
}
