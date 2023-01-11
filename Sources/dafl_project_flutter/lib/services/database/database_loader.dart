import 'dart:async';
import 'loader.dart';
import '../../model/user.dart';
import 'database_connexion.dart';
import 'dart:developer' as dev;

class DatabaseLoader implements Loader {
  // Load an user from database
  @override
  Future<User?> load(String username, String password) async {
    final connection = await DatabaseConnexion.initConnexion();
    var queryResult = await connection
        .query(
            'select idDafl from users where idDafl = @username AND password = @password',
            {'username': username, 'password': password})
        .toList()
        .then((result) {
          dev.log(result.toString());
          if (result.isNotEmpty) {
            return User(username);
          } else {
            return null;
          }
        })
        .whenComplete(() {
          connection.close();
        });
    return queryResult;
  }
}
