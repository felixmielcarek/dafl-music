import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../model/user.dart';
import 'package:postgresql2/constants.dart';
import 'package:postgresql2/pool.dart';
import 'package:postgresql2/postgresql.dart';

class DatabaseConnexion{
  final String filePath = 'assets/logs.txt';

  String? _psqlUser;
  String? _psqlPswd;
  String? _psqlHost;
  String? _psqlDataBase;


  Future<void> _loadLogs() async{
    try{
      final _loadedData = await rootBundle.loadString(filePath);

      final _logs = LineSplitter.split(_loadedData).toList();

      _psqlUser = _logs[0];
      _psqlPswd = _logs[1];
      _psqlHost = _logs[2];
      _psqlDataBase = _logs[3];
    }
    catch(e){
      throw Exception('Logs file Not Found');
    }
  }


  //Initialise connexion to the database
   Future<Connection> initConnexion() async{
    await _loadLogs();

    var uri = 'postgres://$_psqlUser:$_psqlPswd@$_psqlHost:5442/$_psqlDataBase';

    return connect(uri);
  }
}