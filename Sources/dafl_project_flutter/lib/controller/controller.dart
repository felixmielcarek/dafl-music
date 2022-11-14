import '../persistence/database_loader.dart';
import '../persistence/database_saver.dart';
import '../persistence/database_searcher.dart';
import '../persistence/loader.dart';

import '../persistence/saver.dart';
import '../model/user.dart';
import '../persistence/searcher.dart';

class Controller {
  static Saver saver = DatabaseSaver();
  static Loader loader = DatabaseLoader();
  static final Searcher _searcher = DatabaseSearcher();

  User currentUser = User("", "");

  void save(User userToSave) {
    saver.save(userToSave);
  }

  Future<void> load(String username, String password) async {
    changeCurrentUser(await loader.load(username, password));
  }

  User createUser(String username, String password) {
    return User(username, password);
  }

  void changeCurrentUser(User user) {
    currentUser = user;
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
}
