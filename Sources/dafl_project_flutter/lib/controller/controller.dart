import '../persistence/database_loader.dart';
import '../persistence/database_saver.dart';
import '../persistence/database_searcher.dart';
import '../persistence/loader.dart';

import '../persistence/saver.dart';
import '../persistence/loader.dart';
import '../model/user.dart';
import '../persistence/searcher.dart';


class Controller{
  static Controller? _this;

  static Saver saver = DatabaseSaver();
  static Loader loader = DatabaseLoader();
  static Searcher _searcher = DatabaseSearcher();


  User currentUser = User("", "");


  factory Controller(){
    if (_this == null) _this = Controller._();
    return _this!;
  }

  Controller._();

  void save(User userToSave){
    saver.save(userToSave);
  }

  Future<void> load(String username, String password) async{
    changeCurrentUser(await loader.load(username, password));
  }

  User createUser(String username, String password){
    return User(username, password);
  }

  void changeCurrentUser(User user){
    this.currentUser = user;
  }

  void changeUsernameCourant(String newName){
    if(newName !=null){
      this.currentUser.usernameDafl = newName;
    }
  }
  void changePasswordCourant(String newPass){
    if(newPass !=null){
      this.currentUser.passwDafl = newPass;
    }
  }

  Future<bool> searchByUsername(String username) async{
    return await _searcher.searchByUsername(username);
  }
}
