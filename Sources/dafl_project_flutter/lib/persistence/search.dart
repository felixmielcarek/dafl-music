import '../model/user.dart';

abstract class Search{
  bool searchUser(String? username, String? password);
  bool searchUsername(String? username);
}