import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class Api {
  var clientId = '7ceb49d874b9404492246027e4d68cf8';
  var clientSecret = '98f9cb960bf54ebbb9ad306e7ff919cb';
  var redirectUri = 'https://daflmusic.000webhostapp.com/callback/';
  var state;
  String scopes = 'user-read-playback-state user-read-currently-playing';
  var code;
  var urlAuthorize;
  String? access_token;
  String token_type = 'Bearer ';
  int? expires_in;
  String? refresh_token;

  var client = http.Client();

  Api() {
    state = generateRandomString();
    urlAuthorize = Uri.https('accounts.spotify.com', 'authorize', {
      'client_id': clientId,
      'response_type': 'code',
      'redirect_uri': redirectUri,
      'state': state,
      'scope': scopes,
      'show_dialog': 'true'
    });
  }

  requestUserAuthorization(Uri url) {
    if (url.queryParameters['state'] == state.toString()) {
      code = url.queryParameters['code'];
      requestAccessToken();
    }
    // TODO : implement the else
  }

  requestAccessToken() async {
    var urlToken = Uri.https('accounts.spotify.com', 'api/token', {
      'code': code,
      'redirect_uri': redirectUri,
      'grant_type': 'authorization_code'
    });
    String credentials = "$clientId:$clientSecret";
    String encodedLogs = base64.encode(utf8.encode(credentials));
    var response = await client.post(urlToken, headers: <String, String>{
      'Authorization': 'Basic $encodedLogs',
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    access_token = decodedResponse['access_token'];
    expires_in = decodedResponse['expires_in'];
    refresh_token = decodedResponse['refresh_token'];
    getCurrentlyPlayingTrack();
  }

  getCurrentlyPlayingTrack() async {
    var url = Uri.https('api.spotify.com', 'v1/me/player/currently-playing');
    print('$token_type $access_token');
    var response = await client.post(url, headers: <String, String>{
      'Authorization': '$token_type $access_token',
      'Content-Type': 'application/json'
    });
    // Problem while trying to get body
    print(access_token);
    print(response.statusCode);
  }

  // for state value
  String generateRandomString() {
    var r = Random();
    return String.fromCharCodes(
        List.generate(16, (index) => r.nextInt(33) + 89));
  }
}
