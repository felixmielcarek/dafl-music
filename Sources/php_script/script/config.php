<?php
$username=CODEFIRST_CLIENTDRONE_ENV_INNODB_USER;
$host=CODEFIRST_CLIENTDRONE_ENV_INNONDB_HOST;
$password=CODEFIRST_CLIENTDRONE_ENV_INNODB_PASSWORD;
$db_name=CODEFIRST_CLIENTDRONE_ENV_INNODB_DATABASE;

$connect=mysqli_connect($host,$username,$password,$db_name);
/*
if(!$connect)
{
    print "Connection Failed";
}
*/

