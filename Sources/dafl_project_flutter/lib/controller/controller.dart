import 'package:dafl_project_flutter/persistence/database_loader.dart';
import 'package:dafl_project_flutter/persistence/database_saver.dart';
import 'package:dafl_project_flutter/persistence/loader.dart';

import '../persistence/saver.dart';
import '../persistence/loader.dart';
import '../model/user.dart';


class Controller{
  static Controller? _this;

  static Saver? saver = DatabaseSaver();
  static Loader? loader = DatabaseLoader();

 Future<User?>? currentUser;

  factory Controller(){
    if (_this == null) _this = Controller._();
    return _this!;
  }

  Controller._();

  void save(User userToSave){
    saver?.save(userToSave);
  }

  void load(String username, String password) async{
     currentUser =  loader?.load(username, password);
  }
}



