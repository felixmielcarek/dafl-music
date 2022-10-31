import 'dart:async';

import 'package:dafl_project_flutter/persistence/database_connexion.dart';
import 'package:postgresql2/postgresql.dart';

import '../lib/persistence/database_saver.dart';


void main() async{
  DatabaseConnexion d = DatabaseConnexion();

  final conn = await d.initConnexion();

   conn.query('select * from utilisateur').toList().then((rows) {
    for (var row in rows) {
      print(row[0]);    // Or by column index.
    }
  });

}
