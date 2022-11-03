import 'dart:async';

import 'loader.dart';
import '../model/user.dart';
import 'database_connexion.dart';

class DatabaseLoader extends Loader{

  @override
  Future<User?> load(String? username, String? password) async {
    final connection = await DatabaseConnexion.initConnexion();

    connection.query('select * from utilisateur where username = @username AND password = @password',
        {'username': username,
          'password': password}).toList()
        .then((result) {
      print(result); });
  }

}
