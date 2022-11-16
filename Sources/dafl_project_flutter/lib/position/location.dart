import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
        //faire l'interface gra pour gérer ça
        return Future.error('Location Not Available');
      }
    }
    String actualUser = MyApp.controller.currentUser.usernameDafl;
    String actualSong = await MyApp.api.getCurrentlyPlayingTrack();
    Position current = await Geolocator.getCurrentPosition();
    await http.post(uri, body: {
      "id": actualUser.toString(),
      "latitude": current.latitude.toString(),
      "longitude": current.longitude.toString(),
      // "idMusic": actualSong,
    });
    log(actualSong);
     return getData();
  }

  static Future getData() async {
    String actualUser = MyApp.controller.currentUser.usernameDafl;
    Uri uri = Uri.parse("http://89.83.53.34/phpmyadmin/dafldev/distance.php");
    http.Response response = await http.post(uri, body : {
      "id" : actualUser.toString(),
    });
    var data = jsonDecode(response.body);
    return data.toString();
  }
}
