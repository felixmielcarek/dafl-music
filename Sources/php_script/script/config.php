<?php

function connection(): bool|int|mysqli
{

    $username = $_ENV["USER"];                                                       //Get the username
    $host = "https://codefirst.iut.uca.fr/containers/mysql_location-dorianhodin";                                                           //Get the url of the database
    $password = $_ENV["PASSWORD"];                                                   //Get the password for the user selected
    $db_name = $_ENV["DATABASE"];                                                    //Get the name of the database

    try {                                                                            //Try to connect to the database

        return mysqli_connect($host, $username, $password, $db_name);                //Connecting to database

    }catch (mysqli_sql_exception) {                                                  //If the connection failed

        return  -1;                                                                  //Send a return code as -1, so insertAndMakeListUser.php can know if the connection is successful

    }
}




