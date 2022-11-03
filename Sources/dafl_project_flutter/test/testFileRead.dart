import 'package:dafl_project_flutter/main.dart';
import 'package:dafl_project_flutter/persistence/database_connexion.dart';
import 'package:flutter/cupertino.dart';


Future<void> main() async {
  MyApp mainApp = MyApp();

  runApp(mainApp);

  DatabaseConnexion d = DatabaseConnexion();

  DatabaseConnexion.initConnexion();

}