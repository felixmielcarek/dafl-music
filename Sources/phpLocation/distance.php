<?php


class distance
{
    public function meters($lat1, $lng1, $lat2, $lng2): float
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
}
class ListUser
{
    public function ListOfUser() {
        $db=0;
        require_once('db.php');
        $query = 'SELECT * FROM gps';
        $stm = $db->prepare($query);
        $stm->execute();
        $row = $stm->fetchAll(PDO::FETCH_ASSOC);
        $listUser = [];
        $lat1=0;
        $lng1=0;
        Foreach ($row as $col) {
            if ($col['id']==1){                 //1 est lid de l'user qui execute la commande le recup grâce à driko
                $lat1=$col['latitude'];
                $lng1=$col['longitude'];
            }if ($lat1==0 && $lng1==0){
                print ("ERROR No user found in the database (normally not supposed to happen)");
                exit(666);
            }
        }
        Foreach ($row as $col) {
            if ($col['id']!=1) {                //1 est lid de l'user qui execute la commande le recup grâce à driko
                $lat2 = $col['latitude'];
                $lng2 = $col['longitude'];
                $userID = $col['id'];
                $dist = (new distance)->meters($lat1, $lng1, $lat2, $lng2);
                if ($dist <= 100) {
                    $listUser[] = $userID;
                }
            }
        }
        return $listUser;
    }
}

/*
echo "Normalement pas beaucoup = ";
echo (new distance)->meters(45.762595,3.108837,45.762524,3.1088743);

echo "Normalement pas beaucoup = ";
echo (new distance)->distentre2co(45.891773, 4.662613,45.777222,3.087025);
*/
echo "\nListe User = ";
echo implode(",",(new ListUser)->ListOfUser());

