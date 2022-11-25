<?php

function metersBetweenTwoUser($lat1, $lng1, $lat2, $lng2): float
{
    $earth_radius = 6378137;                                                            // Radius of the Earth in meters :

    $rlo1 = deg2rad($lng1);                                                             //Transform the coordinate longitude1 from degree to radian
    $rla1 = deg2rad($lat1);                                                             //Transform the coordinate latitude1 from degree to radian
    $rlo2 = deg2rad($lng2);                                                             //Transform the coordinate longitude2 from degree to radian
    $rla2 = deg2rad($lat2);                                                             //Transform the coordinate latitude2 from degree to radian

    $dlo = ($rlo2 - $rlo1) / 2;                                                         //Stock in $dlo the result of the calcul : ($rlo2 - $rlo1) / 2
    $dla = ($rla2 - $rla1) / 2;                                                         //Stock in $dla the result of the calcul : ($rla2 - $rla1) / 2

    $a = (sin($dla) * sin($dla)) + cos($rla1) * cos($rla2) * (sin($dlo) * sin($dlo));   //Do some operations to return the distance in meters

    $d = 2 * atan2(sqrt($a), sqrt(1 - $a));                                             //Do some operations to return the distance in meters

    return round($earth_radius * $d);                                                   // Return the distance in meters between 2 GPS points
}



