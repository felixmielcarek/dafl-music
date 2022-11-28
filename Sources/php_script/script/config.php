<?php

function connection(): bool|int|mysqli
{

    $username = "root";                                                       //Get the username
    $host = "193.49.118.214";                                                           //Get the url of the database
    $password = "michel2022";                                                   //Get the password for the user selected
    $db_name = "positiondaflmusic";                                                    //Get the name of the database

    try {                                                                            //Try to connect to the database

        print(json_encode(mysqli_connect($host, $username, $password, $db_name)));
        return mysqli_connect($host, $username, $password, $db_name);                //Connecting to database

    }catch (mysqli_sql_exception) {                                                  //If the connection failed

        return  -1;                                                                  //Send a return code as -1, so insertAndMakeListUser.php can know if the connection is successful

    }
}

connection();



