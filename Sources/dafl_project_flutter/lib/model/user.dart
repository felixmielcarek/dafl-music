import 'dart:async';
import '../main.dart';
import 'music.dart';
import 'spot.dart';

class User {
  Timer? timer;
  int test = 0;

  //attributes from DAFL
  late int idDafl;
  late String usernameDafl;
  late String passwDafl;
  Map<String, DateTime> discoveries = {};

  final String _idSpotify;
  late String currentMusic;
  bool sortChoise = true;

  //constructors
  User(this.usernameDafl, this._idSpotify);

  String get idSpotify => _idSpotify;
}
