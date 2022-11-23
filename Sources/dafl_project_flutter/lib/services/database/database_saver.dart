import 'database_connexion.dart';
import 'saver.dart';
import '../../model/user.dart';

class DatabaseSaver implements Saver {
  // Save user in the database
  @override
  void save(User userToSave) async {
    final connection = await DatabaseConnexion.initConnexion();

    connection.execute(
        'insert into utilisateur (username, password) values (@username, @password)',
        {
          'id': '',
          'username': userToSave.usernameDafl,
          'password': userToSave.passwDafl
        }).whenComplete(() {
      connection.close();
    });
  }
}
