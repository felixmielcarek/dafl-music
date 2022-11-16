import '../exceptions/api_exception.dart';
import '../main.dart';
import 'conversation.dart';
import 'music.dart';
import 'spot.dart';

class User {
  //attributes from DAFL
  late int idDafl;
  late String usernameDafl;
  late String passwDafl;

  //attributes with Spotify API
  String? _idSpotify; //use _getIdUser() as kind of a private getter
  late Music _currentMusic;

  Set<User> likedUsers = {};
  List<Music> discovery = [];
  List<Conversation> waitingConv = [];
  List<Conversation> confirmConv = [];

  List<Spot> spots = [];
  Map<User, Conversation> conversations = {};

  //constructors
  User(this.usernameDafl, this.passwDafl) {
    _actualiseCurrentMusic();
  }

  Music get currentMusic => _currentMusic; //lists

  Future<String> getIdSpotify() async {
    _idSpotify ??= await MyApp.api.getIdUser();
    return _idSpotify!;
  }

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

  _actualiseCurrentMusic() async {
    try {
      _currentMusic = Music(await MyApp.api.getCurrentlyPlayingTrack());
    } on ApiException {
      // TODO : add notification to show that an error occured
    }
  }

  @override
  String toString() => "$usernameDafl ($passwDafl)";
}
