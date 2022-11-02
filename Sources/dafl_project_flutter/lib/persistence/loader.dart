import 'dart:async';

import '../model/user.dart';

abstract class Loader{
  Future<User?> load(String? username, String? password);
}