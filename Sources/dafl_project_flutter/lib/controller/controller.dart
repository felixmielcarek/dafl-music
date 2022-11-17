import 'dart:convert';
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

  /*void chargeExample() {
    currentUser.spots = [
      Spot(
          User('Félix', '1234'),
          Music('Couleurs', 'Khali',
              'https://khaligidilit.com/assets/images/cover-LAI%CC%88LA-Khali.jpeg')),
      Spot(
          User('Audric', '1234'),
          Music("J'suis PNL", 'PNL',
              'https://m.media-amazon.com/images/I/61aUOMzwS8L._SL1440_.jpg')),
      Spot(
          User('Dorian', '1234'),
          Music('Sundance', 'Nepal',
              'https://pbs.twimg.com/media/ExJ-My-XMAE3Ko2.jpg')),
      Spot(
          User('Lucas', '1234'),
          Music('Eternelle 2', 'So La Lune',
              'https://cdns-images.dzcdn.net/images/cover/2818a661c6d533155ce6dffc256b1f51/500x500.jpg')),
      Spot(
          User('David', '1234'),
          Music('M.I.L.S 3', 'Ninho',
              'https://cdns-images.dzcdn.net/images/cover/b351f0e935c9c3901f8d893b92ab952a/500x500.jpg')),
      Spot(
          User('Hugo', '1234'),
          Music('Deux frères', 'PNL',
              'https://cdns-images.dzcdn.net/images/cover/65147b581f2ace9e0f0723ee76e70fda/500x500.jpg')),
      Spot(
          User('Alban', '1234'),
          Music('Paradis', 'Sopico',
              'https://cdns-images.dzcdn.net/images/cover/17a9747927ac3e5ea56f92f635d9180c/500x500.jpg')),
    ].reversed.toList();
  }*/

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
