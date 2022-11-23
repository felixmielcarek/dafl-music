<?php
$connect="";                                                                    //Else PHP send an error, "connect don't exist", but that work anyway, this is just to remove a fake error
$res=include "config.php";                                                      //$res get the result of the calling of "config.php"
if ($res != 1){                                                                 //Check if config.php work
    print (json_encode("Failed to connect to MySQL"));                    //Return a json string, so the dart script can interpret the error
}
if (!empty($_POST)) {                                                           //Check if the method POST return something
    $id = mysqli_real_escape_string($connect, $_POST['id']);                    //Get the result of POST method
    $latitude = mysqli_real_escape_string($connect, $_POST['latitude']);        //Get the result of POST method
    $longitude = mysqli_real_escape_string($connect, $_POST['longitude']);      //Get the result of POST method
    $idMusic = mysqli_real_escape_string($connect, $_POST['idMusic']);          //Get the result of POST method
    $latitude = doubleval($latitude);                                           //Convert a string to a double
    $longitude = doubleval($longitude);                                         //Convert a string to a double
    /*
    $query = "DELETE FROM gps WHERE (SELECT TIMESTAMPDIFF(MINUTE,CURRENT_TIMESTAMP,dateLog))>10;";
    $results = mysqli_query($connect, $query);
    */
    $query = "DELETE FROM gps WHERE id='$id';";                                 //Delete the actual line and replace this line with the next lines
    $results = mysqli_query($connect, $query);                                  //Execute the SQL command

    $query = "INSERT INTO gps (id,latitude,longitude,idMusic,dateLog)           
    VALUES('$id','$latitude','$longitude','$idMusic',CURRENT_TIMESTAMP);";      //Insert into the database the new data and new information about this user
    $results = mysqli_query($connect, $query);                                  //Execute the SQL command
}else{                                                                          //If the method POST return nothing
    print (json_encode("The POST didn't return any values"));             //Return a json string, so the dart script can interpret the error
}