<?php
$username=$_ENV["CODEFIRST_CLIENTDRONE_ENV_INNODB_USER"];
$host=$_ENV["CODEFIRST_CLIENTDRONE_ENV_INNODB_HOST"];
$password=$_ENV["CODEFIRST_CLIENTDRONE_ENV_INNODB_PASSWORD"];
$db_name=$_ENV["CODEFIRST_CLIENTDRONE_ENV_INNODB_DATABASE"];

$connect=mysqli_connect($host,$username,$password,$db_name);

