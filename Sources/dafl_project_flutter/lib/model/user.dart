import 'dart:async';
import '../main.dart';
import 'music.dart';
import 'spot.dart';

class User {
  Timer? timer;
  int test = 0;

  //attributes from DAFL
  late int idDafl;
  late String usernameDafl;
  late String passwDafl;
  List<Music> discovery = [];
  List<Spot> spots = [];

  //attributes with Spotify API
  final String _idSpotify;

  late String currentMusic;
  bool sortChoise = true;

  //constructors
  User(this.usernameDafl, this._idSpotify);

  String get idSpotify => _idSpotify;

  addDiscovery(Music music) {
    discovery.add(music);
  }

  listSpots() {
    int verif = 0;
    Future<Map<String, dynamic>> rep = Location.sendCurrentLocation();
    //ex : dorian : 2d2s52a15d2a5 , audric : 2x5s2az3d1s5wx5s1 , lucas : s2a5d25a2a25d
    rep.then((Map<String, dynamic> result) {
      if (result.isNotEmpty) {
        result.forEach((key, value) {
          for (var element in spots) {
            if (element.userId == key) {
              verif = 1;
            }
          }
          if (verif == 0) {
            spots.add(Spot(key, Music(value)));
          }
          verif = 0;
        });
      }
    });
  }
}
