<?php
$username=$_ENV("INNONDB_USER");                                                             //Get the username
$host=$_ENV("INNONDB_HOST");                                                             //Get the address IP of the hosting machine
$password=$_ENV("INNONDB_PASSWORD");                                                              //Get the password for the user selected
$db_name=$_ENV("INNONDB_DATABASE");                                                    //Get the name of the database
try {                                                                            //Try to connect to the database
    $connect = mysqli_connect($host, $username, $password, $db_name);            //Connecting to database
}catch (mysqli_sql_exception){                                                   //If the connection failed
    print(json_encode(strval($host)));
    // print(json_encode("Failed to connect to MySQL, connection timeout"));        //Return a json string, so the dart script can interpret the error
    exit(-1);                                                                    //Send a return code as -1, so insert.php can know if the connection is successful
}




