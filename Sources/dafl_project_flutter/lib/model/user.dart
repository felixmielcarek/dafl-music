import 'package:dafl_project_flutter/main.dart';
import 'package:dafl_project_flutter/model/spot.dart';
import 'message.dart';
import 'spot.dart';

import 'conversation.dart';
import 'music.dart';

class User{
  //attributes from DAFL
  int? idDafl;
  String? usernameDafl;
  String? passwDafl;
  //attributes to link with API
  String? usernameAPI;
  String? passwAPI;

  //constructors
  User(this.usernameDafl, this.passwDafl);

  User.name(this.usernameDafl);

  User.fromDatabase(this.idDafl, this.usernameDafl);

  //lists
  Set<User> likedUsers={};
  List<Music> Discovery=[];
  List<Conversation> waitingConv=[];
  List<Conversation> confirmConv=[];

  Music currentSong = Music('Couleurs','Khali','https://khaligidilit.com/assets/images/cover-LAI%CC%88LA-Khali.jpeg');

  /*List<Music> Spots=[
    Music('Couleurs','Khali','https://khaligidilit.com/assets/images/cover-LAI%CC%88LA-Khali.jpeg'),
    Music("J'suis PNL",'PNL','https://m.media-amazon.com/images/I/61aUOMzwS8L._SL1440_.jpg'),
    Music('Sundance','Nepal','https://pbs.twimg.com/media/ExJ-My-XMAE3Ko2.jpg'),
    Music('Eternelle 2','So La Lune','https://cdns-images.dzcdn.net/images/cover/2818a661c6d533155ce6dffc256b1f51/500x500.jpg'),
    Music('M.I.L.S 3','Ninho','https://cdns-images.dzcdn.net/images/cover/b351f0e935c9c3901f8d893b92ab952a/500x500.jpg'),
    Music('Deux frères','PNL','https://cdns-images.dzcdn.net/images/cover/65147b581f2ace9e0f0723ee76e70fda/500x500.jpg'),
    Music('Paradis','Sopico','https://cdns-images.dzcdn.net/images/cover/17a9747927ac3e5ea56f92f635d9180c/500x500.jpg')].reversed.toList();*/

  List<Spot> Spots2= [];
  Map<User,Conversation> conversations={};

  void addDiscovery(Music newmusic){
    if(MyApp().controller.currentUser.Discovery == null){

    }
    else{
      MyApp().controller.currentUser.Discovery.add(newmusic);
    }


  }

  void like(User liked){
    likedUsers.add(liked);
    Conversation? conv = liked.conversations[this];
    if(conv==null) {
      conversations[liked]= Conversation(this, liked);
    } else {
      conversations[liked]= conv;
    }
  }

  void chat(User recipient,String content){
    Conversation? conv = conversations[recipient];
    if(conv != null) conv.addMessage(this, content);
  }

  void displayConversations(){
    conversations.forEach((k,v) => v.displayMessages());
  }

  @override
  String toString() => "$usernameDafl ($idDafl)";
}