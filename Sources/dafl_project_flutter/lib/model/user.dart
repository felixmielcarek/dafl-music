import '../main.dart';
import 'conversation.dart';
import 'music.dart';
import 'spot.dart';

class User {
  //attributes from DAFL
  late int idDafl;
  late String usernameDafl;
  late String passwDafl;

  //attributes to link with API
  late String usernameAPI;
  late String passwAPI;

  //constructors
  User(this.usernameDafl, this.passwDafl);

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

  @override
  String toString() => "$usernameDafl ($passwDafl)";
}
