<?php

class distance
{
    public function distentre2co($lat1, $lng1, $lat2, $lng2) {
        // Rayon de la Terre en mètres :
        $earth_radius = 6378137;
        // Calcul de la distance entre 2 coordonées GPS :
        $rlo1 = deg2rad($lng1);
        $rla1 = deg2rad($lat1);
        $rlo2 = deg2rad($lng2);
        $rla2 = deg2rad($lat2);
        $dlo = ($rlo2 - $rlo1) / 2;
        $dla = ($rla2 - $rla1) / 2;
        $a = (sin($dla) * sin($dla)) + cos($rla1) * cos($rla2) * (sin($dlo) * sin($dlo));
        $d = 2 * atan2(sqrt($a), sqrt(1 - $a));
        // Return la distance en mètre entre les deux coordonées
        return round($earth_radius * $d);
    }
}

class ListeUser
{
    public function Liste() {
        $listeUser = ["001","002","003"];
        // Coordonées actuelles de l'User dans $lat1 et $lng1
        $lat1 = 45.891773;
        $lng1 = 4.662613;
        //parcours de toute les coordonées stockées dans le serveur PHP et entrée dans dist
        // for les co :
        $userID = "004";
        $dist =  (new distance)->distentre2co($lat1,$lng1,45.777222,3.087025);
        if ($dist <= 100 ){
            $listeUser[] = $userID;
        }
        return $listeUser;
    }
}

/*
echo "Normalement 597833 = ";
echo (new distance)->distentre2co(48.86417880,2.34250440,43.6008177,3.8873392);
*/
echo "Normalement pas beaucoup = ";
echo (new distance)->distentre2co(45.891773, 4.662613,45.777222,3.087025);
echo "\nListe User = ";
echo implode(",",(new ListeUser)->Liste());
