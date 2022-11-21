<?php
$connect="";
include "config.php";
$id = mysqli_real_escape_string($connect, $_POST['id']);
$latitude = mysqli_real_escape_string($connect, $_POST['latitude']);
$longitude = mysqli_real_escape_string($connect, $_POST['longitude']);
$idMusic = mysqli_real_escape_string($connect, $_POST['idMusic']);

$latitude=doubleval($latitude);
$longitude=doubleval($longitude);
/*
$query = "DELETE FROM gps WHERE (SELECT TIMESTAMPDIFF(MINUTE,CURRENT_TIMESTAMP,dateLog))>10;";
$results = mysqli_query($connect, $query);
*/
$query = "DELETE FROM gps WHERE id='$id';";
$results = mysqli_query($connect, $query);

$query = "INSERT INTO gps (id,latitude,longitude,idMusic,dateLog) VALUES('$id','$latitude','$longitude','$idMusic',CURRENT_TIMESTAMP);";
$results = mysqli_query($connect, $query);

