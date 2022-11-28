<?php

include "config.php";
$res = connection();

$query = "DELETE FROM gps WHERE id='0'";
mysqli_query($res, $query);