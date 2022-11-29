<?php


include "config.php";
$res = connection();

$query = "SELECT id,TIMESTAMPDIFF(MINUTE,dateLog,CURRENT_TIMESTAMP) FROM gps WHERE (TIMESTAMPDIFF(MINUTE,dateLog,CURRENT_TIMESTAMP)>10);";

$results = mysqli_query($res, $query);

while ($row = $results->fetch_row()) {                                      //For all the row in the database

            print($row[0]);
            print($row[1]);                                                        //Set $lat2 to the latitude of the user who is in the actual row
                                                        //Set $lat2 to the latitude of the user who is in the actual row
}