import 'package:dafl_project_flutter/persistence/database_connexion.dart';

import 'searcher.dart';

class DatabaseSearcher extends Searcher{

  Future<bool> searchUser(String? username, String? password) async { return true; }


  @override
  Future<bool> searchByUsername(String? username) async{
    final connection = await DatabaseConnexion.initConnexion();
    bool isHere  = true;

    connection.query('select * from utilisateur where username = $username').toList().then((rows) {
      if(rows.isEmpty){
        isHere = false;
      }
    }).whenComplete(() {
      print('close');
    });

    return isHere;
  }
}
