<?php

function meters($lat1, $lng1, $lat2, $lng2): float
{
    // Radius of the Earth in meters :
    $earth_radius = 6378137;
    // Calculation of the distance between 2 GPS coordinates:
    $rlo1 = deg2rad($lng1);
    $rla1 = deg2rad($lat1);
    $rlo2 = deg2rad($lng2);
    $rla2 = deg2rad($lat2);
    $dlo = ($rlo2 - $rlo1) / 2;
    $dla = ($rla2 - $rla1) / 2;
    $a = (sin($dla) * sin($dla)) + cos($rla1) * cos($rla2) * (sin($dlo) * sin($dlo));
    $d = 2 * atan2(sqrt($a), sqrt(1 - $a));
    // Return the distance in meters between 2 GPS points
    return round($earth_radius * $d);
}

$connect="";
include "config.php";
$id = $_POST['id'];
$query = 'SELECT * FROM gps';
$stm = $connect->prepare($query);
$stm->execute();
$row = $stm->fetchAll(PDO::FETCH_ASSOC);
$lat1=0;
$lng1=0;
$listUser=[];
Foreach ($row as $col) {
    if (strcmp($col['id'], $id) == 0) {
        $lat1 = $col['latitude'];
        $lng1 = $col['longitude'];
    }
}
if ($lat1==0 && $lng1==0){
    print(json_encode("ERROR No user found in the database"));
    exit(1);
}

Foreach ($row as $col) {
    if (strcmp($col['id'],$id)!=0) {
        $lat2 = $col['latitude'];
        $lng2 = $col['longitude'];
        $userID = $col['id'];
        $idMusic = $col['idMusic'];
        $dist = meters($lat1, $lng1, $lat2, $lng2);
        if ($dist <= 100) {
            $listUser[] = ['user' => $userID, 'music' => $idMusic];         }
    }
}

print(json_encode($listUser));


