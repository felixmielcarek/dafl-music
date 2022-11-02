import 'dart:io';
import 'database_connexion.dart';
import 'saver.dart';
import '../model/user.dart';


class DatabaseSaver extends Saver{
  DatabaseConnexion dbConnexion = DatabaseConnexion();

  @override
  void save(User userToSave) async{
    final connection = await dbConnexion.initConnexion();

    connection.execute('insert into utilisateur (username, password) values (@username, @password)',
        { 'id' : '',
          'username': userToSave.usernameDafl,
          'password' : userToSave.passwDafl}).then((_) {});
  }
}