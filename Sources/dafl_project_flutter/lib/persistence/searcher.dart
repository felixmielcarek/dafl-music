import '../model/user.dart';

abstract class Searcher{
  Future<bool> searchUser(String? username, String? password);
  Future<bool> searchByUsername(String? username);
}