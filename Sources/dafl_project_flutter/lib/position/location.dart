import 'dart:developer';
import '../api/api.dart';
import 'package:dafl_project_flutter/api/track.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../main.dart';



class Location {
  static Future<String> sendCurrentLocation() async {
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
      "idMusic": actualSong.toString(),
    });
    return getData();
  }

  static Future<String> getData() async {
    String actualUser = MyApp.controller.currentUser.usernameDafl;
    Uri uri = Uri.parse("http://89.83.53.34/phpmyadmin/dafldev/distance.php");
    http.Response response = await http.post(uri, body: {
      "id": actualUser.toString(),
    });
    var data = jsonDecode(response.body);
    return data.toString();
  }

  static  List<Future<Track>> getTrackList(Future<String> userList){
    int i=0;
    String listOfTrack="";
    List<Future<Track>> tracklist = [];
    List<List<String>> trackid = [];
    userList.then((String result) {
      listOfTrack = result;
      List<String> tab = result.split(",");
      for (i=0; i < tab.length; i++){
        trackid.add(tab[i].split("-"));
      }
      for (i=0; i < trackid.length; i++){
        tracklist.add(MyApp.api.getTrackInfo(trackid[i][1]));
      }
    });
    return tracklist;
  }
}


