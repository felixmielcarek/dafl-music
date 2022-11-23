<?php
$username="dafldev";                                                   //Get the username
$host="89.83.53.34";                                                   //Get the address IP of the hosting machine
$password="wrap";                                                      //Get the password for the user selected
$db_name="positiondaflmusic";                                          //Get the name of the database

$connect=mysqli_connect($host,$username,$password,$db_name);           //Connecting to database

if (mysqli_connect_errno()) {                                          //Check if the connection failed
    print(json_encode("Failed to connect to MySQL"));             //Return a json string, so the dart script can interpret the error
    exit(-1);                                                          //Send a return code as -1, so insert.php can know if the connection is successful
}

