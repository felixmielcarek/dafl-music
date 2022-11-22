import 'dart:convert';

import 'package:dafl_project_flutter/services/api/api_spotify_identification.dart';

import '../http_response_verification.dart';
import 'package:http/http.dart' as http;

class TokenSpotify extends HttpResponseVerification {
  String _accessToken;
  final String _refreshToken;
  late DateTime _tokenEnd;

  TokenSpotify(this._accessToken, this._refreshToken, int expiresIn) {
    _setTokenEnd(expiresIn);
  }

  _setTokenEnd(int expiresIn) {
    _tokenEnd = DateTime.now().add(Duration(seconds: expiresIn));
  }

  Future<String> getAccessToken() async {
    if (DateTime.now().isAfter(_tokenEnd)) {
      await _actualiseToken();
    }
    return _accessToken;
  }

  _actualiseToken() async {
    var urlToken = Uri.https('accounts.spotify.com', 'api/token', {
      'grant_type': 'refresh_token',
      'refresh_token': _refreshToken,
      'client_id': ApiSpotifyIdentification.clientId
    });
    setResponse(await http.post(urlToken, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    }));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    _accessToken = decodedResponse['access_token'];
    _setTokenEnd(decodedResponse['expires_in']);
  }
}
