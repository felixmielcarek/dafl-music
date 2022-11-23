<?php
$username="dafldev";
$host="89.83.53.34";
$password="wrap";
$db_name="positiondaflmusic";

$connect=mysqli_connect($host,$username,$password,$db_name);

if (mysqli_connect_errno()) {
    print(json_encode("Failed to connect to MySQL"));
    exit(-1);
}

