import '../model/user.dart';


class Controller{
  static Controller? _this;

  User currentUser = User(null, null);

  factory Controller(){
    if (_this == null) _this = Controller._();
    return _this!;
  }

  Controller._();

  void save(User userToSave){
  }

  void load(String username, String password) async{
  }

  User createUser(String username, String password){
    return User(username, password);
  }

  void changeCurrentUser(User user){
    this.currentUser = user;
  }

  void changeUsernameCourant(String newName){
    if(newName !=null){
      this.currentUser?.usernameDafl = newName;
    }
  }
}
