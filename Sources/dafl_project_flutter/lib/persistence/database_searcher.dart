import 'database_connexion.dart';
import 'searcher.dart';

class DatabaseSearcher extends Searcher {
  @override
  Future<bool> searchUser(String? username, String? password) async {
    return true;
  }

  // Search an user in the database by username
  @override
  Future<bool> searchByUsername(String? username) async {
    final connection = await DatabaseConnexion.initConnexion();

    bool queryResult = await connection
        .query('select * from utilisateur where username = @username',
            {'username': username})
        .toList()
        .then((rows) {
          return rows.isEmpty;
        })
        .whenComplete(() {
          connection.close();
        });

    return queryResult;
  }
}
