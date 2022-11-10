<?php
$dns = 'mysql:host=82.216.56.128;dbname=positiondaflmusic';
$user = 'dafldev';
// $password = 'enter_the_password_of_your_database';
try{
    // $db = new PDO ($dns, $user, $pass);
    $db = new PDO ($dns, $user);
}catch( PDOException $e){
    $error = $e->getMessage();
    echo $error;
}
