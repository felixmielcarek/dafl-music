<?php

$username="dafldev";
$host="89.83.53.34";
$password="wrap";
$db_name="positiondaflmusic";

$connect=mysqli_connect($host,$username,$password,$db_name);

if(!$connect)
{
echo json_encode("Connection Failed");
}

