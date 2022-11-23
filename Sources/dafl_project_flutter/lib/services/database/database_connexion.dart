import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:postgresql2/postgresql.dart';

class DatabaseConnexion {
  // Path to the file containing the database identifiers
  static const String filePath = 'assets/logs.txt';

  // Database identifiers
  static String? _psqlUser;
  static String? _psqlPswd;
  static String? _psqlHost;
  static String? _psqlDataBase;

  // Read the database connection identifiers in a file
  static Future<void> _loadLogs() async {
    try {
      final loadedData = await rootBundle.loadString(filePath);

      final logs = LineSplitter.split(loadedData).toList();

      _psqlUser = logs[0];
      _psqlPswd = logs[1];
      _psqlHost = logs[2];
      _psqlDataBase = logs[3];
    } catch (e) {
      throw Exception('Logs file Not Found');
    }
  }

  //Initialise and open a connection to the database
  static Future<Connection> initConnexion() async {
    if (_psqlHost == null ||
        _psqlPswd == null ||
        _psqlUser == null ||
        _psqlDataBase == null) {
      await _loadLogs();
    }

    try {
      var uri =
          'postgres://$_psqlUser:$_psqlPswd@$_psqlHost:5442/$_psqlDataBase';

      return connect(uri);
    } catch (e) {
      throw Exception('Connection to database : IMPOSSIBLE');
    }
  }
}
