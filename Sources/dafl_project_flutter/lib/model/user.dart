import 'conversation.dart';

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
  Map<User,Conversation> conversations={};


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