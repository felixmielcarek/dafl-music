<?php

function connection(): bool|int|mysqli
{

    $username = "root";                                                       //Get the username
    $host = "localhost:3306";                                                 //Get the url of the database
    $password = "";                                       //Get the password for the user selected
    $db_name = $_ENV["DATABASE"];                                             //Get the name of the database

    try {                                                                     //Try to connect to the database

        return mysqli_connect($host, $username, $password);                   //Connecting to database

    }catch (mysqli_sql_exception) {                                           //If the connection failed

        return  -1;                                                           //Send a return code as -1, so insertAndMakeListUser.php can know if the connection is successful

    }
}

print(connection());



