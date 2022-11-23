<?php
$dns = 'mysql:host='.getenv("CODEFIRST_CLIENTDRONE_ENV_INNODB_HOST").';dbname='.getenv("CODEFIRST_CLIENTDRONE_ENV_INNODB_DATABASE");
$user = $_ENV["CODEFIRST_CLIENTDRONE_ENV_INNODB_USER"];
$password = $_ENV["CODEFIRST_CLIENTDRONE_ENV_INNODB_PASSWORD"];
echo "\n";echo "\n";echo "\n";
$env_array =getenv();
foreach ($env_array as $key=>$value)
{
    echo "$key => $value \n";
}
echo "\n";echo "\n";echo "\n";
try{
    $db = new PDO ($dns, $user, $password);
}catch( PDOException $e){
    $error = $e->getMessage();
    echo $error;
}
