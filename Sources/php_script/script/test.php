<?php

include "config.php";
$res = connection();

$query = "SELECT id FROM gps";
print(mysqli_query($res, $query));

