import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class ApiSptfy {
  var clientId = '7ceb49d874b9404492246027e4d68cf8';
  var redirectUri = 'https://felixmielcarek.github.io';
  var state;
  var scopes = 'user-read-private';
  var url;

  ApiSptfy() {
    state = generateRandomString();
    url = Uri.https('accounts.spotify.com', 'en/authorize', {
      'client_id': clientId,
      'response_type': 'code',
      'redirect_uri': redirectUri,
      'state': state,
      'scope': scopes,
      'show_dialog': 'true'
    });
  }

  Future<void> launchInBrowser() async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  String generateRandomString() {
    var r = Random();
    return String.fromCharCodes(
        List.generate(16, (index) => r.nextInt(33) + 89));
  }
}
