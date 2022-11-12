<?php
$dns = 'mysql:host=82.216.56.128;dbname=positiondaflmusic';
$user = 'dafldev';
$password = 'wrap';
try{
    $db = new PDO ($dns, $user, $password);
}catch( PDOException $e){
    $error = $e->getMessage();
    echo $error;
}
