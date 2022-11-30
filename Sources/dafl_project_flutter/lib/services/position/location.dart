import 'package:dafl_project_flutter/model/spot.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../../main.dart';

class Location {
  static Future<List<Spot>> sendCurrentLocation() async {
    Uri uri = Uri.parse(
        "https://codefirst.iut.uca.fr/containers/php_script-dorianhodin/insertAndMakeListUser.php");
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        //TODO : handle this case
      }
    }

    String actualUser = MyApp.controller.getIdDafl();
    String actualSong = MyApp.controller.getCurrentMusic().id;
    Position current = await Geolocator.getCurrentPosition();

    http.Response response = await http.post(uri, body: {
      "id": actualUser,
      "latitude": current.latitude.toString(),
      "longitude": current.longitude.toString(),
      "idMusic": actualSong,
    });

    var data = jsonDecode(response.body);
    Map<String, String> spotsData = {};
    List<Spot> spots = [];

    if (data == 2) {
      return Future.error("Failed to connect, connection timeout");
    } else if (data == 3) {
      return Future.error("POST method failed");
    } else {
      data.forEach((s) => spotsData.putIfAbsent(s['user'], () => s['music']));
    }

    spotsData.forEach((key, value) async {
      spots.add(Spot(key, await MyApp.controller.getCompleteMusic(value)));
    });
    return spots;
  }
}
