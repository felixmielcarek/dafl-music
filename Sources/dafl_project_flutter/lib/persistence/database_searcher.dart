import 'package:dafl_project_flutter/persistence/database_connexion.dart';

import 'searcher.dart';



class DatabaseSearcher extends Searcher{
  Future<bool> searchUser(String? username, String? password) async { return true; }



  // Search an user in the database by username
  @override
  Future<bool> searchByUsername(String? usernameToSearch) async{
    final connection = await DatabaseConnexion.initConnexion();

    bool queryResult = await connection.query('select * from utilisateur where username = @username',{ 'username' : usernameToSearch})
        .toList()
        .then((rows) { return rows.isEmpty; });


    return queryResult;
  }

}
