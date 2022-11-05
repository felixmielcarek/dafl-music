import 'dart:math';

class Api {
  var clientId = '7ceb49d874b9404492246027e4d68cf8';
  var redirectUri = 'https://daflmusic.000webhostapp.com/callback/';
  var state;
  var scopes = 'user-read-private';
  var url;

  var code;

  Api() {
    state = generateRandomString();
    url = Uri.https('accounts.spotify.com', 'authorize', {
      'client_id': clientId,
      'response_type': 'code',
      'redirect_uri': redirectUri,
      'state': state,
      'scope': scopes,
      'show_dialog': 'true'
    });
  }

  verifyLogIn(Uri url) {
    if (verifyState(url.queryParameters['state'])) {
      code = url.queryParameters['code'];
    }
  }

  bool verifyState(String? newState) => state == newState;

  // for state value
  String generateRandomString() {
    var r = Random();
    return String.fromCharCodes(
        List.generate(16, (index) => r.nextInt(33) + 89));
  }
}
