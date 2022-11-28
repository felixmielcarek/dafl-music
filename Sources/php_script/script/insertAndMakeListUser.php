<?php

function metersBetweenTwoUser($lat1, $lng1, $lat2, $lng2): float
{
    $earth_radius = 6378137;                                                            // Radius of the Earth in meters :

    $rlo1 = deg2rad($lng1);                                                             //Transform the coordinate longitude1 from degree to radian
    $rla1 = deg2rad($lat1);                                                             //Transform the coordinate latitude1 from degree to radian
    $rlo2 = deg2rad($lng2);                                                             //Transform the coordinate longitude2 from degree to radian
    $rla2 = deg2rad($lat2);                                                             //Transform the coordinate latitude2 from degree to radian

    $dlo = ($rlo2 - $rlo1) / 2;                                                         //Stock in $dlo the result of the calcul : ($rlo2 - $rlo1) / 2
    $dla = ($rla2 - $rla1) / 2;                                                         //Stock in $dla the result of the calcul : ($rla2 - $rla1) / 2

    $a = (sin($dla) * sin($dla)) + cos($rla1) * cos($rla2) * (sin($dlo) * sin($dlo));   //Do some operations to return the distance in meters

    $d = 2 * atan2(sqrt($a), sqrt(1 - $a));                                             //Do some operations to return the distance in meters

    return round($earth_radius * $d);                                                   // Return the distance in meters between 2 GPS points
}

function insertUserAndReturnList(): array|int
{

    include "config.php";
    $res = connection();

    if (strcmp(gettype($res),"integer")==0) {
        return 5;
    }
    $query = "CREATE TABLE IF NOT EXISTS gps (
                id varchar(30) PRIMARY KEY,
                latitude double NOT NULL,
                longitude double NOT NULL,
                idMusic varchar(100) NOT NULL,
                dateLog datetime NOT NULL
              );";
    mysqli_query($res, $query);

    if (!empty($_POST)) {                                                           //Check if the method POST return something

        $id = $_POST['id'];                                                         //Get the result of POST method
        $latitude = $_POST['latitude'];                                             //Get the result of POST method
        $longitude = $_POST['longitude'];                                           //Get the result of POST method
        $idMusic = $_POST['idMusic'];                                               //Get the result of POST method

        $latitude = doubleval($latitude);                                           //Convert a string to a double
        $longitude = doubleval($longitude);                                         //Convert a string to a double

        /*
        $query = "DELETE FROM gps WHERE (SELECT TIMESTAMPDIFF(MINUTE,CURRENT_TIMESTAMP,dateLog))>10;";
        $results = mysqli_query($connect, $query);
        */

        $query = "UPDATE gps SET latitude='$latitude', longitude='$longitude', idMusic='$idMusic' WHERE id='$id'";                                 //Delete the actual line and replace this line with the next lines
        $results = mysqli_query($res, $query);                                      //Execute the SQL command

        if ($results==0){

            $query = "INSERT INTO gps(id,latitude,longitude,idMusic,dateLog) VALUES('$id','$latitude','$longitude','$idMusic',CURRENT_TIMESTAMP);";      //Insert into the database the new data and new information about this user
            mysqli_query($res, $query);

        }

        $query = "SELECT * FROM gps WHERE id != '$id'";                             //Browse all the database
        $results = mysqli_query($res, $query);                                      //Execute the SQL command
        $listUser = [];                                                             //Set the listUser to an empty list

        while ($row = $results->fetch_row()) {                                      //For all the row in the database

            $lat2 = $row[1];                                                        //Set $lat2 to the latitude of the user who is in the actual row
            $lng2 = $row[2];                                                        //Set $lng2 to the latitude of the user who is in the actual row
            $userID = $row[0];                                                      //Set $userID to the username of the user who is in the actual row
            $idMusic = $row[3];                                                     //Set $idMusic to the id of the actual song of the user who is in the actual row

            $dist = metersBetweenTwoUser($latitude, $longitude, $lat2, $lng2);      //With the function meters, determinate the distance between the current user and the user who is in the actual row

            if ($dist <= 100) {                                                     //If the user in the actual row is less than 100 meters away of the current user

                $listUser[] = ['user' => $userID, 'music' => $idMusic];             //Add the username and the ID of the song that user who is in the actual row is listening

            }
        }
        if (!empty($listUser)){
            return 3;
        }
        return 2;

    } else {                                                                        //If the method POST return nothing

        return 4;                                                                   //Return a code error

    }
}

print(json_encode(insertUserAndReturnList()));
