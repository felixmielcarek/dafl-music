import 'dart:async';
import '../../../api/track.dart';
import '../../../position/location.dart';
import '../exceptions/api_exception.dart';
import '../main.dart';
import 'conversation.dart';
import 'music.dart';
import 'spot.dart';

Timer? timer;
int test = 0;

class User {
  //attributes from DAFL
  late int idDafl;
  late String usernameDafl;
  late String passwDafl;

  //attributes with Spotify API
  late String _id;
  late Track track;
  bool sortChoise = true;

  //constructors
  User(this.usernameDafl, this.passwDafl) {
    _actualiseTrack();
  }

  User.name(this.usernameDafl);

  User.fromDatabase(this.idDafl, this.usernameDafl);

  //lists
  Set<User> likedUsers = {};
  List<Music> discovery = [];
  List<Conversation> waitingConv = [];
  List<Conversation> confirmConv = [];

  Music currentSong = Music('Couleurs', 'Khali',
      'https://khaligidilit.com/assets/images/cover-LAI%CC%88LA-Khali.jpeg');

  List<Spot> spots = [];
  Map<User, Conversation> conversations = {};

  void addDiscovery(Music newmusic) {
    MyApp.controller.currentUser.discovery.add(newmusic);
  }

  void like(User liked) {
    likedUsers.add(liked);
    Conversation? conv = liked.conversations[this];
    if (conv == null) {
      conversations[liked] = Conversation(this, liked);
    } else {
      conversations[liked] = conv;
    }
  }

  void chat(User recipient, String content) {
    Conversation? conv = conversations[recipient];
    if (conv != null) conv.addMessage(this, content);
  }

  void displayConversations() {
    conversations.forEach((k, v) => v.displayMessages());
  }

  _actualiseTrack() async {
    try {
      _id = await MyApp.api.getCurrentlyPlayingTrack();
      track = await MyApp.api.getTrackInfo(_id);
    } on ApiException {
      // TODO : add notification to show that an error occurred
    }
  }

  void listspots() {
    Future<String>? rep;
    int i;
    rep = Location.sendCurrentLocation();
    List<Future<Music>> futureMusicList = [];
    List<List<String>> musicId = [];
    rep.then((String result) {
      List<String> tab = result.split(",");
      if (tab.isEmpty != true) {
        for (i = 0; i < tab.length; i++) {
          musicId.add(tab[i].split("-"));
        }
        /*
        for (i = 0; i < musicId.length; i++) {
          // futuretracklist.add(MyApp.api.getTrackInfo(trackid[i][1]));
        }
        futureMusicList[i].then((Music m) {
          for (i = 0; i < futureMusicList.length; i++) {
            discovery.add(m);
          }
        });

         */ // EN COMMENTAIRE PARCE QUE ERREUR SINON VU QUE J'AI PAS MUSIC POUR L'INSTANT
      }
    });
  }

  void getListSpots() {
    if (test == 0) {
      test = 1;
      listspots();
    } else {
      timer =
          Timer.periodic(const Duration(seconds: 72), (Timer t) => listspots());
    }
  }

  @override
  String toString() => "$usernameDafl ($passwDafl)";
}
