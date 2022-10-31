import '../persistence/loader.dart';
import '../model/user.dart';
import 'database_connexion.dart';

class DatabaseLoader extends Loader{
  DatabaseConnexion dbConnexion = DatabaseConnexion();


  @override
  Future<User?> load(String? username, String? password) async {

    final connection = await dbConnexion.initConnexion();

    connection.query('select * from utilisateur where username = @username AND password = @password',
        {'username': username,
          'password': password}).toList()
        .then((result) {
          print(result); });
  }
}

