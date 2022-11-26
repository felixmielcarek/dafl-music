import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../main.dart';

class Location {
  static Future<Map<String, dynamic>> sendCurrentLocation() async {

    Uri uri = Uri.parse("https://codefirst.iut.uca.fr/containers/php_script-dorianhodin/insertAndMakeListUser.php");
    Map<String, dynamic> spot = {};
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {

      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {

        return Future.error('Location Not Available');

      }
    }

    String actualUser = MyApp.controller.currentUser.usernameDafl;
    String actualSong = await MyApp.api.getCurrentlyPlayingTrack();
    Position current = await Geolocator.getCurrentPosition();

    http.Response response = await http.post(uri, body: {
      "id": actualUser.toString(),
      "latitude": current.latitude.toString(),
      "longitude": current.longitude.toString(),
      "idMusic": actualSong.toString(),
    });

    var data = jsonDecode(response.body);

    if (data == 2){

      return Future.error("Failed to connect, connection timeout");

    }else if (data == 3) {

      return Future.error("POST method failed");

    }else{

      data.forEach((s) => spot.putIfAbsent(s['user'], () => s['music']));
      return spot;

    }
  }
}


