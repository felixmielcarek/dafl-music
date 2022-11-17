import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dafl_project_flutter/main.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as dev;
import '../exceptions/api_exception.dart';

class Api {
  //from dashboard
  final _clientId = '7ceb49d874b9404492246027e4d68cf8';
  final _clientSecret = '98f9cb960bf54ebbb9ad306e7ff919cb';

  //for web api
  get redirectUri => 'https://daflmusic.000webhostapp.com/callback/';
  final _scopes =
      'user-read-playback-state user-read-currently-playing user-read-recently-played playlist-modify-public ugc-image-upload';
  late String _state;
  dynamic _codeVerifier;
  dynamic _codeChallenge;
  late String _encodedLogs;
  final _tokenType = 'Bearer ';
  late http.Response _response; //use _setResponse() as kind of a private setter
  final _playlistName = "Dafl's discovery";

  //from web api
  String? _code;
  int? _expiresIn;
  String? _refreshToken;
  String? _accessToken; //use _getAccessToken() as kind of a private getter

  //other
  final _client = http.Client();
  late Uri _urlAuthorize;

  get urlAuthorize => _urlAuthorize;
  DateTime? _tokenEnd;

  Api() {
    _state = _generateRandomString(16);
    _codeVerifier = _generateRandomString(_generateRandomInt(43, 128));
    _codeChallenge = _generateCodeChallenge();
    _encodedLogs = base64.encode(utf8.encode("$_clientId:$_clientSecret"));
    _urlAuthorize = Uri.https('accounts.spotify.com', 'authorize', {
      'client_id': _clientId,
      'response_type': 'code',
      'redirect_uri': redirectUri,
      'state': _state,
      'scope': _scopes,
      'show_dialog': 'false',
      'code_challenge_method': 'S256',
      'code_challenge': _codeChallenge
    });
  }

  //PKCE generations

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

  //session management

  requestUserAuthorization(Uri url) async {
    if (url.queryParameters['state'] != _state.toString()) {
      throw ApiException('state');
    }
    _code = url.queryParameters['code'];
    await _requestAccessToken();
  }

  _requestAccessToken() async {
    var urlToken = Uri.https('accounts.spotify.com', 'api/token', {
      'code': _code,
      'redirect_uri': redirectUri,
      'grant_type': 'authorization_code',
      'client_id': _clientId,
      'code_verifier': _codeVerifier
    });
    _setResponse(await _client.post(urlToken, headers: <String, String>{
      'Authorization': 'Basic $_encodedLogs',
      'Content-Type': 'application/x-www-form-urlencoded'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    _accessToken = decodedResponse['access_token'];
    _expiresIn = decodedResponse['expires_in'];
    _tokenEnd = DateTime.now().add(Duration(seconds: _expiresIn!));
    _refreshToken = decodedResponse['refresh_token'];
  }

  Future<String?> _getAccessToken() async {
    if (DateTime.now().isAfter(_tokenEnd!)) {
      await _getRefreshedAccessToken();
    }
    return _accessToken;
  }

  _setResponse(value) {
    int sc = value.statusCode;
    if (sc >= 300) {
      dev.log(value.body.toString());
      throw ApiException(sc);
    }
    _response = value;
  }

  _getRefreshedAccessToken() async {
    var urlToken = Uri.https('accounts.spotify.com', 'api/token', {
      'grant_type': 'refresh_token',
      'refresh_token': _refreshToken,
      'client_id': _clientId
    });
    _setResponse(await _client.post(urlToken, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    _accessToken = decodedResponse['access_token'];
    _expiresIn = decodedResponse['expires_in'];
    _tokenEnd = DateTime.now().add(Duration(seconds: _expiresIn!));
  }

  //functional methods

  Future<String> getCurrentlyPlayingTrack() async {
    var url = Uri.https('api.spotify.com', 'v1/me/player/currently-playing');
    var token = await _getAccessToken();
    var response = await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 204) {
      return getRecentlyPlayedTrack();
    }
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse['item']['id'];
  }

  Future<String> getRecentlyPlayedTrack() async {
    var url = Uri.https(
        'api.spotify.com', 'v1/me/player/recently-played', {'limit': '1'});
    var token = await _getAccessToken();
    _setResponse(await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    return decodedResponse['items'][0]['track']['id'];
  }

  Future<Map> getTrackInfo(String id) async {
    var url = Uri.https('api.spotify.com', 'v1/tracks/$id');
    var token = await _getAccessToken();
    _setResponse(await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    Map<String, String> info = {
      'artist': decodedResponse['artists'][0]['name'],
      'name': decodedResponse['name'],
      'cover': decodedResponse['album']['images'][0]['url']
    };
    return info;
  }

  Future<bool> _isInPlaylist(String idTrack, String idPlaylist) async {
    var url = Uri.https('api.spotify.com', 'v1/playlists/$idPlaylist/tracks',
        {'limit': '50', 'fields': 'items(track(id))'});
    var token = await _getAccessToken();
    _setResponse(await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    var res = decodedResponse['items']
        .where((element) => element['track']['id'] == idTrack)
        .toList();
    if (res.length >= 1) {
      return true;
    }
    return false;
  }

  addToPLaylist(String idTrack) async {
    var idPlaylist = await _getPlaylist();
    if (idPlaylist == null) {
      idPlaylist = await _createPlaylist();
    } else {
      if (await _isInPlaylist(idTrack, idPlaylist)) {
        return;
      }
    }
    var token = await _getAccessToken();
    var url = Uri.https('api.spotify.com', 'v1/playlists/$idPlaylist/tracks',
        {'uris': 'spotify:track:$idTrack'});
    _setResponse(await _client.post(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
  }

  Future<String?> _getPlaylist() async {
    var url = Uri.https('api.spotify.com', 'v1/me/playlists', {'limit': '50'});
    var token = await _getAccessToken();
    _setResponse(await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    var daflplaylist = decodedResponse['items']
        .where((element) => element['name'] == _playlistName)
        .toList();
    if (daflplaylist.length == 1) {
      return daflplaylist[0]['uri'].substring(
          17); //17 char because format is 'spotify:playlist:MYPLAYLISTID'
    }
    return null;
  }

  _createPlaylist() async {
    //create playlist
    var idUser = await MyApp.controller.currentUser.getIdSpotify();
    var token = await _getAccessToken();
    var url = Uri.https('api.spotify.com', 'v1/users/$idUser/playlists');
    _setResponse(await _client.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$_tokenType $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'name': _playlistName,
          'description':
              'Retrouvez toutes vos découvertes faites sur DaflMusic 🎵',
          'public': 'true'
        })));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    var idPlaylist = decodedResponse['id'];

    //add image : problem in request, API doc does not explain how to give the image
    /*var byteData = await rootBundle.load('assets/images/playlist_icon.jpg');
    var buffer = byteData.buffer.asUint8List();
    String base64Encode = base64
        .encode(buffer)
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', '');
    dev.log(jsonEncode(base64Encode).toString());
    //dev.log(base64Encode);
    //the request should contain a Base64 encoded JPEG image data, maximum payload size is 256 KB
    url = Uri.https('api.spotify.com', 'v1/playlists/$idPlaylist/images');
    _setResponse(await _client.put(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$_tokenType $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(base64Encode)));
    decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    dev.log(decodedResponse.toString());*/
    return idPlaylist;
  }

  removeFromPlaylist(String idTrack) async {
    var idPlaylist = await _getPlaylist();
    if (idPlaylist == null) {
      return;
    }
    if (await _isInPlaylist(idTrack, idPlaylist)) {
      var token = await _getAccessToken();
      var url = Uri.https('api.spotify.com', 'v1/playlists/$idPlaylist/tracks');
      var jsonVar = jsonEncode(<String, List>{
        "tracks": [
          {'uri': 'spotify:track:$idTrack'}
        ]
      });
      jsonEncode(<String, String>{'uri': 'spotify:track:$idTrack'});
      _setResponse(await _client.delete(url,
          headers: <String, String>{
            'Authorization': '$_tokenType $token',
            'Content-Type': 'application/json'
          },
          body: jsonVar));
    }
  }

  Future<String> getIdUser() async {
    var url = Uri.https('api.spotify.com', 'v1/me');
    var token = await _getAccessToken();
    _setResponse(await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    return decodedResponse['id'];
  }
}
