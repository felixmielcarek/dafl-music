<?php

function meters($lat1, $lng1, $lat2, $lng2): float
{
    $earth_radius = 6378137;                                                                 // Radius of the Earth in meters :
    $rlo1 = deg2rad($lng1);                                                                  //Transform the coordinate longitude1 from degree to radian
    $rla1 = deg2rad($lat1);                                                                  //Transform the coordinate latitude1 from degree to radian
    $rlo2 = deg2rad($lng2);                                                                  //Transform the coordinate longitude2 from degree to radian
    $rla2 = deg2rad($lat2);                                                                  //Transform the coordinate latitude2 from degree to radian
    $dlo = ($rlo2 - $rlo1) / 2;                                                              //Stock in $dlo the result of the calcul : ($rlo2 - $rlo1) / 2
    $dla = ($rla2 - $rla1) / 2;                                                              //Stock in $dla the result of the calcul : ($rla2 - $rla1) / 2
    $a = (sin($dla) * sin($dla)) + cos($rla1) * cos($rla2) * (sin($dlo) * sin($dlo));        //Do some operations to return the distance in meters
    $d = 2 * atan2(sqrt($a), sqrt(1 - $a));                                             //Do some operations to return the distance in meters
    return round($earth_radius * $d);                                                   // Return the distance in meters between 2 GPS points
}
$connect="";                                                                    //Else PHP send an error, "connect don't exist", but that work anyway, this is just to remove a fake error
$res=include "config.php";                                                      //$res get the result of the calling of "config.php"
if ($res != 1){                                                                 //Check if config.php work
    print (json_encode("Failed to connect to MySQL"));                    //Return a json string, so the dart script can interpret the error
}
if (!empty($_POST)) {
    $id = $_POST['id'];                                                             //Get the result of the POST method in id
    $query = 'SELECT * FROM gps';                                                   //Browse all the database
    $results = mysqli_query($connect, $query);                                      //Execute the SQL command
    $lat1 = 0;                                                                      //Set $lat1 to test if the user exist
    $lng1 = 0;                                                                      //Set $lng1 to test if the user exist
    $listUser = [];                                                                 //Set the listUser to an empty list
    while ($row = $results->fetch_row()){                                           //For all the row in the database
        if (strcmp($row[0], $id) == 0) {                                            //If the user is found in the database
            $lat1 = $row[1];                                                        //Set $lat1 to the latitude of the current user
            $lng1 = $row[2];                                                        //Set $lng1 to the longitude of the current user
        }
    }
    if ($lat1 == 0 && $lng1 == 0) {                                                 //Check if the user get found in the database
        print(json_encode("ERROR No user found in the database"));            //Return a json string, so the dart script can interpret the error
        exit(1);                                                                    //Exit the actual script
    }
    $results = mysqli_query($connect, $query);                                      //Execute again the SQL command to restart the fetch_row()
    while ($row = $results->fetch_row()) {                                          //For all the row in the database
        if (strcmp($row[0], $id) != 0) {                                            //If the row is not the row of the current user
            $lat2 = $row[1];                                                        //Set $lat2 to the latitude of the user who is in the actual row
            $lng2 = $row[2];                                                        //Set $lng2 to the latitude of the user who is in the actual row
            $userID = $row[0];                                                      //Set $userID to the username of the user who is in the actual row
            $idMusic = $row[3];                                                     //Set $idMusic to the id of the actual song of the user who is in the actual row
            $dist = meters($lat1, $lng1, $lat2, $lng2);                             //With the function meters, calcul of the distance between the current user and the user who is in the actual row
            if ($dist <= 100) {                                                     //If the user in the actual row is less than 100 meters away of the current user
                $listUser[] = ['user' => $userID, 'music' => $idMusic];             //Add the username and the ID of the song that user who is in the actual row is listening
            }
        }
    }
    print(json_encode($listUser));                                                  //Return a json string of the list listUser
}else{                                                                              //If the method POST return nothing
    print (json_encode("The POST didn't return any values"));                 //Return a json string, so the dart script can interpret the error
}



