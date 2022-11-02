import '../model/user.dart';

abstract class Saver{
  void save(User userToSave);
}