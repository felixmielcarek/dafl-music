<?php
$connect="";
include "config.php";

$id = mysqli_real_escape_string($connect, $_POST['id']);
$latitude = mysqli_real_escape_string($connect, $_POST['latitude']);
$longitude = mysqli_real_escape_string($connect, $_POST['longitude']);

$id=intval($id);
$latitude=doubleval($latitude);
$longitude=doubleval($longitude);

$query = "DELETE FROM gps WHERE id='$id';";
$results = mysqli_query($connect, $query);

$query = "INSERT INTO gps (id,latitude,longitude) VALUES('$id','$latitude','$longitude');";
$results = mysqli_query($connect, $query);

if($results>0)
{
    echo "user added successfully";
}
