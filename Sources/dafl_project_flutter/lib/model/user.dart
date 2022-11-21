import 'dart:async';
import '../../../position/location.dart';
import '../exceptions/api_exception.dart';
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
  String? _idSpotify; //use _getIdUser() as kind of a private getter
  late Music _currentMusic;
  bool sortChoise = true;

  //constructors
  User(this.usernameDafl, this.passwDafl) {
    actualiseCurrentMusic();
  }

  Music get currentMusic => _currentMusic; //lists

  Future<String> getIdSpotify() async {
    _idSpotify ??= await MyApp.api.getIdUser();
    return _idSpotify!;
  }

  addDiscovery(Music music) {
    discovery.add(music);
  }

  actualiseCurrentMusic() async {
    try {
      _currentMusic = Music(await MyApp.api.getCurrentlyPlayingTrack());
    } on ApiException {
      // TODO : add notification to show that an error occurred
    }
  }

  listSpots() {
    int verif=0;
    Future<Map<String, dynamic>> rep = Location.sendCurrentLocation();
    //ex : dorian : 2d2s52a15d2a5 , audric : 2x5s2az3d1s5wx5s1 , lucas : s2a5d25a2a25d
    rep.then((Map<String, dynamic> result) {
      if (result.isNotEmpty) {
        result.forEach((key, value) {
          for (var element in spots) {
            if (element.userId==key){
              verif=1;
            }
          }
          if (verif==0){
            spots.add(Spot(key, Music(value)));
          }
          verif=0;
        });
      }
    });

  }
}
