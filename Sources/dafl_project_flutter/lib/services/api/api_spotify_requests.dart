import 'dart:collection';
import 'dart:convert';
import 'package:dafl_project_flutter/services/api/token_spotify.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../http_response_verification.dart';

class ApiSpotifyRequests extends HttpResponseVerification {
  final String _tokenType = 'Bearer ';
  final String _playlistName = "Dafl's discovery";
  final TokenSpotify _token;

  ApiSpotifyRequests(this._token);

  Future<String> getCurrentlyPlayingTrack() async {
    var url = Uri.https('api.spotify.com', 'v1/me/player/currently-playing');
    var token = await _token.getAccessToken();
    var response = await http.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 204) {
      return _getRecentlyPlayedTrack();
    }
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse['item']['id'];
  }

  Future<String> _getRecentlyPlayedTrack() async {
    var url = Uri.https(
        'api.spotify.com', 'v1/me/player/recently-played', {'limit': '1'});
    var token = await _token.getAccessToken();
    setResponse(await http.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse['items'][0]['track']['id'];
  }

  Future<Map> getTrackInfo(String id) async {
    var url = Uri.https('api.spotify.com', 'v1/tracks/$id');
    var token = await _token.getAccessToken();
    setResponse(await http.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    Map<String, String> infos = {
      'artist': decodedResponse['artists'][0]['name'],
      'name': decodedResponse['name'],
      'cover': decodedResponse['album']['images'][0]['url']
    };
    return infos;
  }

  Future<String> getIdUser() async {
    var url = Uri.https('api.spotify.com', 'v1/me');
    var token = await _token.getAccessToken();
    setResponse(await http.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse['id'];
  }

  playTrack(String idTrack) async {
    var token = await _token.getAccessToken();
    var url = Uri.https('api.spotify.com', 'v1/me/player/play');
    setResponse(await http.put(url,
        headers: <String, String>{
          'Authorization': '$_tokenType $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, List>{
          'uris': ['spotify:track:$idTrack']
        })));
  }

  Future<String> _getPlaylistId() async {
    var url = Uri.https('api.spotify.com', 'v1/me/playlists', {'limit': '50'});
    var token = await _token.getAccessToken();
    setResponse(await http.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var daflPlaylist = decodedResponse['items']
        .where((element) => element['name'] == _playlistName)
        .toList();
    if (daflPlaylist.length == 1) {
      return daflPlaylist[0]['uri'].substring(
          17); //17 char because format is 'spotify:playlist:MYPLAYLISTID'
    }
    return await _createPlaylist();
  }

  Future<String> _createPlaylist() async {
    var idUser = MyApp.controller.getIdSpotify();
    var token = await _token.getAccessToken();
    var url = Uri.https('api.spotify.com', 'v1/users/$idUser/playlists');
    setResponse(await http.post(url,
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
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var idPlaylist = decodedResponse['id'];
    return idPlaylist;
  }

  addToPlaylist(String idTrack) async {
    var idPlaylist = await _getPlaylistId();
    if (await _isInPlaylist(idTrack, idPlaylist)) {
      return;
    }
    var token = await _token.getAccessToken();
    var url = Uri.https('api.spotify.com', 'v1/playlists/$idPlaylist/tracks',
        {'uris': 'spotify:track:$idTrack'});
    setResponse(await http.post(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
  }

  Future<bool> _isInPlaylist(String idTrack, String idPlaylist) async {
    var url = Uri.https('api.spotify.com', 'v1/playlists/$idPlaylist/tracks',
        {'limit': '50', 'fields': 'items(track(id))'});
    var token = await _token.getAccessToken();
    setResponse(await http.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var res = decodedResponse['items']
        .where((element) => element['track']['id'] == idTrack)
        .toList();
    return (res.length >= 1) ? true : false;
  }

  removeFromPlaylist(String idTrack) async {
    var idPlaylist = await _getPlaylistId();
    if (await _isInPlaylist(idTrack, idPlaylist)) {
      var token = await _token.getAccessToken();
      var url = Uri.https('api.spotify.com', 'v1/playlists/$idPlaylist/tracks');
      var jsonVar = jsonEncode(<String, List>{
        'tracks': [
          {'uri': 'spotify:track:$idTrack'}
        ]
      });
      setResponse(await http.delete(url,
          headers: <String, String>{
            'Authorization': '$_tokenType $token',
            'Content-Type': 'application/json'
          },
          body: jsonVar));
    }
  }

  Future<LinkedHashMap<String, DateTime>> getPlaylistTracks() async {
    var idPlaylist = _getPlaylistId();
    var url = Uri.https('api.spotify.com', 'v1/playlists/$idPlaylist/tracks',
        {'fields': 'items(track(id),added_at)'});
    var token = await _token.getAccessToken();
    setResponse(await http.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    LinkedHashMap<String, DateTime> mapRes = LinkedHashMap();
    decodedResponse['items'].toList().forEach((elem) =>
        {mapRes[elem['track']['id']] = DateTime.parse(elem['added_at'])});
    return mapRes;
  }
}
