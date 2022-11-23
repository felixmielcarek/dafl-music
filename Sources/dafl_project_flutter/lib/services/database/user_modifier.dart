


import 'package:dafl_project_flutter/model/user.dart';

abstract class UserModifier{
  changeUsername(String userToModify, String newName);

  changeCurrentPassword(String userToModify, String newPass);
}