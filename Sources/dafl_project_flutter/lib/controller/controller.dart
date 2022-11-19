import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../persistence/database_loader.dart';
import '../persistence/database_saver.dart';
import '../persistence/database_searcher.dart';
import '../persistence/loader.dart';
import '../persistence/saver.dart';
import '../model/user.dart';
import '../persistence/searcher.dart';

class Controller {
  static Saver saver = DatabaseSaver();
  static Loader loader = DatabaseLoader();
  static final Searcher _searcher = DatabaseSearcher();

  late BuildContext navigatorKey;

  late User currentUser;

  Controller() {
    currentUser = User('', ''); //TODO : remove this line
  }

  void save(User userToSave) {
    saver.save(userToSave);
  }

  load(String username, String password) async {
    _changeCurrentUser(await loader.load(username, password));
  }

  _changeCurrentUser(User user) {
    currentUser = user;
  }

  changeCurrentUsername(String newName) {
    currentUser.usernameDafl = newName;
  }

  changeCurrentPassword(String newPass) {
    currentUser.passwDafl = newPass;
  }

  Future<bool> searchByUsername(String username) async {
    return await _searcher.searchByUsername(username);
  }

  Future sendEmail(
      User reporter, User reported, String reason, String message) async {
    const serviceId = 'service_dzyndyb';
    const templateId = 'template_idgriw2';
    const userId = 'hy7HxL5QGV6gpdqry';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'from_name': reporter.usernameDafl,
          'to_name': reported.usernameDafl,
          'reason': reason,
          'message': message,
        },
      }),
    );
  }
}
