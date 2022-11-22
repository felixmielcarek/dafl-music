import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../../main.dart';
import '../../model/spot.dart';

class Area {
  late List<Spot> spots;

  sendCurrentLocation() async {
    Uri uri = Uri.parse("http://89.83.53.34/phpmyadmin/dafldev/insert.php");
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        //TODO : handle this case
      }
    }
    String actualUser = MyApp.controller.getIdSpotify();
    String actualSong = await MyApp.controller.getCurrentMusic();
    Position current = await Geolocator.getCurrentPosition();
    await http.post(uri, body: {
      "id": actualUser,
      "latitude": current.latitude.toString(),
      "longitude": current.longitude.toString(),
      "idMusic": actualSong
    });
  }

  getData() async {
    String actualUser = MyApp.controller.getIdDafl().toString();
    Uri uri = Uri.parse("http://89.83.53.34/phpmyadmin/dafldev/distance.php");
    http.Response response = await http.post(uri, body: {
      "id": actualUser,
    });
    var data = jsonDecode(response.body);
    data.forEach((s) => spots.add(Spot(s['user'], s['music'])));
  }
}
