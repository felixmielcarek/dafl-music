import 'package:dafl_project_flutter/services/database/database_loader.dart';
import 'package:dafl_project_flutter/services/database/database_user_modifier.dart';
import 'package:dafl_project_flutter/services/database/database_saver.dart';
import 'package:dafl_project_flutter/services/database/database_searcher.dart';
import 'package:dafl_project_flutter/services/database/loader.dart';
import 'package:dafl_project_flutter/services/database/user_modifier.dart';
import 'package:dafl_project_flutter/services/database/saver.dart';
import 'package:dafl_project_flutter/services/database/searcher.dart';

import '../../model/user.dart';

class DataBaseService {
  static final Loader _loader = DatabaseLoader();
  static final Searcher _searcher = DatabaseSearcher();
  static final Saver _saver = DatabaseSaver();
  static final UserModifier _userModifier = DatabaseUserModifier();

  void save(String idDafl, String passw) {
    _saver.save(idDafl, passw);
  }

  Future<User?> load(String username, String password) async {
    return _loader.load(username, password);
  }

  Future<bool> searchUser(String username) async {
    return await _searcher.searchUser(username);
  }

  changeUsername(String newName) {
    //TODO : call database method
  }

  changeCurrentPassword(String newPass) {
    //TODO : call database method
  }
}
