import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class Location {


  static Future sendCurrentLocation() async {
    Uri uri = Uri.parse("http://82.216.56.128/phpmyadmin/dafldev/insert.php");
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
    await http.post(uri, body: {
      "id" : "5".toString(),
      "latitude" : current.latitude.toString(),
      "longitude" : current.longitude.toString(),
    });
  }

  static Future getData() async {
    Uri uri = Uri.parse("http://82.216.56.128/phpmyadmin/dafldev/distance.php");
    http.Response response = await http.get(uri);
    var data = jsonDecode(response.body);
    log(data.toString());
    return data.toString();
  }
}