import 'dart:async';
import 'loader.dart';
import '../model/user.dart';
import 'database_connexion.dart';
import 'dart:developer' as dev;

class DatabaseLoader extends Loader {
  // Load an user from database
  @override
  Future<User> load(String username, String password) async {
    final connection = await DatabaseConnexion.initConnexion();

    var queryResult = await connection
        .query(
            'select * from utilisateur where username = @username AND password = @password',
            {'username': username, 'password': password})
        .toList()
        .then((result) {
          dev.log(result.toString());
          if (result.isNotEmpty) {
            return User(username, password);
          } else {
            return User("", "");
          }
        })
        .whenComplete(() {
          connection.close();
        });

    return queryResult;
  }
}
