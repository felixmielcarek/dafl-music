import 'dart:convert';
import 'dart:math';
import '../../exceptions/api_state_exception.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import '../http_response_verification.dart';
import 'token_spotify.dart';

class ApiSpotifyIdentification extends HttpResponseVerification {
  static const String clientId = '7ceb49d874b9404492246027e4d68cf8';
  final String _clientSecret = '98f9cb960bf54ebbb9ad306e7ff919cb';
  final String _scopes =
      'user-read-playback-state user-read-currently-playing user-read-recently-played playlist-modify-public ugc-image-upload user-modify-playback-state';

  late String _state;
  late String _codeVerifier;
  late String _codeChallenge;
  late String _encodedLogs;

  String? _code;

  String get redirectUri => 'https://daflmusic.000webhostapp.com/callback/';

  Uri get urlAuthorize => Uri.https('accounts.spotify.com', 'authorize', {
        'client_id': clientId,
        'response_type': 'code',
        'redirect_uri': redirectUri,
        'state': _state,
        'scope': _scopes,
        'show_dialog': 'false',
        'code_challenge_method': 'S256',
        'code_challenge': _codeChallenge
      });

  ApiSpotifyIdentification() {
    _state = _generateRandomString(16);
    _codeVerifier = _generateRandomString(_generateRandomInt(43, 128));
    _codeChallenge = _generateCodeChallenge();
    _encodedLogs = base64.encode(utf8.encode("$clientId:$_clientSecret"));
  }

  _generateRandomInt(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  _generateRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
  }

  _generateCodeChallenge() {
    return base64Encode(sha256.convert(utf8.encode(_codeVerifier)).bytes)
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', '');
  }

  setCode(Uri url) async {
    if (url.queryParameters['state'] != _state.toString()) {
      throw ApiStateException();
    }
    _code = url.queryParameters['code'];
  }

  Future<TokenSpotify> createToken() async {
    var urlToken = Uri.https('accounts.spotify.com', 'api/token', {
      'code': _code,
      'redirect_uri': redirectUri,
      'grant_type': 'authorization_code',
      'client_id': clientId,
      'code_verifier': _codeVerifier
    });
    setResponse(await http.post(urlToken, headers: <String, String>{
      'Authorization': 'Basic $_encodedLogs',
      'Content-Type': 'application/x-www-form-urlencoded'
    }));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return TokenSpotify(decodedResponse['access_token'],
        decodedResponse['refresh_token'], decodedResponse['expires_in']);
  }
}
