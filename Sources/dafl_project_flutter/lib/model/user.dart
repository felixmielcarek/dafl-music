import 'dart:async';
import '../../../position/location.dart';
import '../exceptions/api_exception.dart';
import '../main.dart';
import 'music.dart';
import 'spot.dart';
import 'package:collection/collection.dart';

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
    print('ajout test');
    Future<String> rep = Location.sendCurrentLocation();
    //ex : dorian-2d2s52a15d2a5,audric-2x5s2az3d1s5wx5s1,lucas-s2a5d25a2a25d

    rep.then((String result) {
      List<String> tab = result.split(",");
      //ex : [dorian-2d2s52a15d2a5 , audric-2x5s2az3d1s5wx5s1 , lucas-s2a5d25a2a25d]

      for (var element in tab) {
        List<String> tab2 = element.split("-");
        spots.add(Spot(tab2[0], Music(tab2[1])));
      }
    });
  }

  getListSpots() {
    if (test == 0) {
      test = 1;
      listSpots();
    } else {
      timer =
          Timer.periodic(const Duration(seconds: 72), (Timer t) => listSpots());
    }
  }
}
