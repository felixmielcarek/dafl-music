<?php

$username="dafldev";
$host="82.216.56.128";
$password="wrap";
$db_name="positiondaflmusic";

$connect=mysqli_connect($host,$username,$password,$db_name);

if(!$connect)
{
echo json_encode("Connection Failed");
}

