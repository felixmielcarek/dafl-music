<?php

function insertUserAndReturnList(): array|int
{

    $res = connection();

    if ($res == -1) {
        return 2;
    }

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

        $query = "SELECT id FROM gps WHERE id='$id'";
        $results = mysqli_query($res, $query);                                      //Execute the SQL command

        if (empty($results)){

            $query = "INSERT INTO gps(id,latitude,longitude,idMusic,dateLog) VALUES('$id','$latitude','$longitude','$idMusic',CURRENT_TIMESTAMP);";      //Insert into the database the new data and new information about this user

        }else{

            $query = "UPDATE gps SET latitude='$latitude', longitude='$longitude', idMusic='$idMusic' WHERE id='$id'";                                 //Delete the actual line and replace this line with the next lines

        }

        mysqli_query($res, $query);

        $query = "SELECT * FROM gps WHERE id != '$id'";                                                   //Browse all the database
        $results = mysqli_query($res, $query);                                      //Execute the SQL command
        $listUser = [];                                                                 //Set the listUser to an empty list

        while ($row = $results->fetch_row()) {                                          //For all the row in the database

            $lat2 = $row[1];                                                        //Set $lat2 to the latitude of the user who is in the actual row
            $lng2 = $row[2];                                                        //Set $lng2 to the latitude of the user who is in the actual row
            $userID = $row[0];                                                      //Set $userID to the username of the user who is in the actual row
            $idMusic = $row[3];                                                     //Set $idMusic to the id of the actual song of the user who is in the actual row

            $dist = metersBetweenTwoUser($latitude, $longitude, $lat2, $lng2);      //With the function meters, determinate the distance between the current user and the user who is in the actual row

            if ($dist <= 100) {                                                     //If the user in the actual row is less than 100 meters away of the current user

                $listUser[] = ['user' => $userID, 'music' => $idMusic];             //Add the username and the ID of the song that user who is in the actual row is listening

            }
        }
        return (json_encode($listUser));                                            //Return an encode array in json, so flutter ca=n interpret it

    } else {                                                                        //If the method POST return nothing

        return 3;                                                                   //Return a code error

    }
}