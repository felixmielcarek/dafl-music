import 'dart:convert';
import 'package:dafl_project_flutter/model/music.dart';
import 'package:dafl_project_flutter/services/api/api_spotify.dart';
import 'package:dafl_project_flutter/services/database/database_service.dart';
import 'package:dafl_project_flutter/services/position/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/spot.dart';
import '../model/user.dart';

class Controller {
  ApiSpotify _api = ApiSpotify();
  late User _currentUser;
  final Location _location = Location();
  final DataBaseService _dataBaseService = DataBaseService();
  bool sortChoice = false; //false = sort by name ; true = sort by date

  late BuildContext navigatorKey;

  Uri getApiUrlAuthorize() {
    return _api.identification.urlAuthorize;
  }

  String getApiRedirectUrl() {
    return _api.identification.redirectUri;
  }

  apiAuthorization(url) {
    _api.apiAuthorization(url);
  }

  String getIdSpotify() {
    return _currentUser.idSpotify;
  }

  Future<Music> getCompleteMusic(String id) async {
    Map infos = await _api.requests.getTrackInfo(id);
    return Music(id, infos['name'], infos['artist'], infos['cover']);
  }

  setCurrentMusic() async {
    _currentUser.currentMusic = await _api.requests.getCurrentlyPlayingTrack();
  }

  String getCurrentMusic() {
    return _currentUser.currentMusic;
  }

  int getIdDafl() {
    return _currentUser.idDafl;
  }

  List<Spot> getSpots() {
    return _location.spots;
  }

  getLocation() async {
    await _location.sendCurrentLocation();
  }

  playTrack(String id) {
    _api.requests.playTrack(id);
  }

  Future<Map<String, DateTime>> getDiscoveries() async {
    _currentUser.discoveries = await _api.requests.getPlaylistTracks();
    return _currentUser.discoveries;
  }

  removeFromPlaylist(String id) {
    _api.requests.removeFromPlaylist(id);
  }

  addToPlaylist(String id) {
    _api.requests.addToPlaylist(id);
  }

  // DATABASE
  void save(User userToSave) {
    _dataBaseService.save(userToSave);
  }

  load(String username, String password) async {
    //TODO : call database methode + create user
  }

  changeUsername(String newName) {
    _dataBaseService.changeUsername(newName);
  }

  changeCurrentPassword(String newPass) {
    _dataBaseService.changeCurrentPassword(newPass);
  }

  Future<bool> searchUser(String username) async {
    return await _dataBaseService.searchUser(username);
  }

  Future sendEmail(String reporterId, String reportedId, String reason,
      String message) async {
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
          'from_name': reporterId,
          'to_name': reportedId,
          'reason': reason,
          'message': message,
        },
      }),
    );
  }
}
