import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import '../main.dart';

class Location {
  static Future sendCurrentLocation() async {
    Uri uri = Uri.parse("http://89.83.53.34/phpmyadmin/dafldev/insert.php");
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        //faire l'interface graphique pour gérer ça
        return Future.error('Location Not Available');
      }
    }
    String actualUser = MyApp.controller.currentUser.usernameDafl;
    Position current = await Geolocator.getCurrentPosition();
    await http.post(uri, body: {
      "id": actualUser.toString(),
      "latitude": current.latitude.toString(),
      "longitude": current.longitude.toString(),
    });
  }

  static Future getData() async {
    Uri uri = Uri.parse("http://89.83.53.34/phpmyadmin/dafldev/distance.php");
    http.Response response = await http.get(uri);
    var data = jsonDecode(response.body);
    log(data.toString());
    return data.toString();
  }
}
