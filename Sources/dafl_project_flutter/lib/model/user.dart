import 'dart:async';

class User {
  Timer? timer;
  int test = 0;

  //attributes from DAFL
  late int idDafl;
  late String usernameDafl;
  late String passwDafl;

  final String _idSpotify;

  //constructors
  User(this.usernameDafl, this._idSpotify);

  String get idSpotify => _idSpotify;
}
