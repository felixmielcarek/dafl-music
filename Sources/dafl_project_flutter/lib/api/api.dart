import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class Api {
  //from dashboard
  final _clientId = '7ceb49d874b9404492246027e4d68cf8';
  final _clientSecret = '98f9cb960bf54ebbb9ad306e7ff919cb'; // TODO : hide it

  //for web api
  get redirectUri => 'https://daflmusic.000webhostapp.com/callback/';
  final _scopes = 'user-read-playback-state user-read-currently-playing';
  String? _state;
  String? _encodedLogs;
  final _tokenType = 'Bearer ';

  //from web api
  String? _code;
  int? _expiresIn;
  String? _refreshToken;
  String? _accessToken; //use _getToken() as kind of a private getter

  //other
  final _client = http.Client();
  Uri? _urlAuthorize;
  get urlAuthorize => _urlAuthorize;
  DateTime? _tokenEnd;

  Api() {
    _state = _generateRandomString();
    _encodedLogs = base64.encode(utf8.encode("$_clientId:$_clientSecret"));
    _urlAuthorize = Uri.https('accounts.spotify.com', 'authorize', {
      'client_id': _clientId,
      'response_type': 'code',
      'redirect_uri': redirectUri,
      'state': _state,
      'scope': _scopes,
      'show_dialog': 'true'
    });
  }

  // for state value
  String _generateRandomString() {
    var r = Random();
    return String.fromCharCodes(
        List.generate(16, (index) => r.nextInt(33) + 89));
  }

  //session management

  requestUserAuthorization(Uri url) async {
    if (url.queryParameters['state'] == _state.toString()) {
      _code = url.queryParameters['code'];
      await _requestAccessToken();
    }
    // TODO : implement the else
  }

  _requestAccessToken() async {
    var urlToken = Uri.https('accounts.spotify.com', 'api/token', {
      'code': _code,
      'redirect_uri': redirectUri,
      'grant_type': 'authorization_code'
    });
    var response = await _client.post(urlToken, headers: <String, String>{
      'Authorization': 'Basic $_encodedLogs',
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    _accessToken = decodedResponse['access_token'];
    _expiresIn = decodedResponse['expires_in'];
    _tokenEnd = DateTime.now().add(Duration(seconds: _expiresIn!));
    _refreshToken = decodedResponse['refresh_token'];
  }

  Future<String?> _getToken() async {
    await _tokenValidity();
    return _accessToken;
  }

  _tokenValidity() async {
    if (DateTime.now().isAfter(_tokenEnd!)) {
      await _getRefreshedAccessToken();
    }
  }

  _getRefreshedAccessToken() async {
    var urlToken = Uri.https('accounts.spotify.com', 'api/token',
        {'grant_type': 'refresh_token', 'refresh_token': '$_refreshToken'});
    var response = await _client.post(urlToken, headers: <String, String>{
      'Authorization': 'Basic $_encodedLogs',
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    _accessToken = decodedResponse['access_token'];
    _expiresIn = decodedResponse['expires_in'];
    _tokenEnd = DateTime.now().add(Duration(seconds: _expiresIn!));
  }

  //functional methods

  getCurrentlyPlayingTrack() async {
    var url = Uri.https('api.spotify.com', 'v1/me/player/currently-playing');
    var token = await _getToken();
    var response = await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    });
    // Implement treatment of data's
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print(decodedResponse['item']['href']);
  }
}
