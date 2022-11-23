import 'database_connexion.dart';
import 'searcher.dart';

class DatabaseSearcher implements Searcher {


  // Search an user in the database by username
  @override
  Future<bool> searchUser(String? username) async {
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
