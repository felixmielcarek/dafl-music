import 'database_connexion.dart';
import 'searcher.dart';

class DatabaseSearcher extends Searcher {


  // Search an user in the database by username
  @override
  Future<bool> searchuser(String? username) async {
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
