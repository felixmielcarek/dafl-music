<?php

include "config.php";
$res = connection();

$query = "SELECT id FROM gps";
$results =mysqli_query($res, $query);

while ($row = $results->fetch_row()) {                                      //For all the row in the database
    print("\n");
    print($row[0]);
    print("\n");
    print($row[1]);
    print("\n");
    print($row[2]);
    print("\n");
    print($row[3]);
    print("\n");
}