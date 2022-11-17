import 'dart:async';
import '../../../api/track.dart';
import '../../../position/location.dart';
import '../exceptions/api_exception.dart';
import '../main.dart';
import 'conversation.dart';
import 'music.dart';
import 'spot.dart';

Timer? timer;
int test=0;

class User {
  //attributes from DAFL
  late int idDafl;
  late String usernameDafl;
  late String passwDafl;

  //attributes to link with API
  late String usernameAPI;
  late String passwAPI;

  //attributes with Spotify API
  late String _id;
  late Track track;

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
      // TODO : add notification to show that an error occured
    }
  }

  static List<Track> listspots (){
    Future<String>? rep;
    List<Track> tracklist = [];
    int i=0;
    String listOfTrack="";
    rep = Location.sendCurrentLocation();
    List<Future<Track>> futuretracklist = [];
    List<List<String>> trackid = [];
    rep.then((String result) {
      listOfTrack = result;
      List<String> tab = result.split(",");
      for (i = 0; i < tab.length; i++) {
        trackid.add(tab[i].split("-"));
      }
      for (i = 0; i < trackid.length; i++) {
        futuretracklist.add(MyApp.api.getTrackInfo(trackid[i][1]));
      }
      for (i = 0; i < futuretracklist.length; i++) {
        futuretracklist[i].then((Track t) {
          tracklist.add(t);
          if (i + 1 == futuretracklist.length) {
            return tracklist;
          }
        });
      }
    });
    return [];
  }

  static List<Track> getListSpots(){
    List<Track> listTrack =[];
    if (test==0){
      test=1;
      listTrack = listspots();
    }else{
      timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => listTrack=listspots());
    }
    return listTrack;
  }

  @override
  String toString() => "$usernameDafl ($passwDafl)";
}
