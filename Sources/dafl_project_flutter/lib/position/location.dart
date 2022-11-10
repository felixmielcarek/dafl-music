import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Location {
  static Future<Tuple2<double, double>> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        //faire l'interface graphique pour gérer ça
        return Future.error('Location Not Available');
      }
    }
    Position current = await Geolocator.getCurrentPosition();
    return Tuple2(current.longitude, current.latitude);
  }

  static Future getData() async {
    var url = 'http://localhost:63342/phpLocation/get.php';
    http.Response response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    print(data.toString());
  }
}



