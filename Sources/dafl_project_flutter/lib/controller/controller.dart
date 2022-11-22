import 'dart:convert';
import 'package:dafl_project_flutter/model/music.dart';
import 'package:dafl_project_flutter/services/api/api_spotify.dart';
import 'package:dafl_project_flutter/services/position/area.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/spot.dart';
import '../model/user.dart';

class Controller {
  ApiSpotify _api = ApiSpotify();
  late User _currentUser;
  Area _area = Area();

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
    return _area.spots;
  }

  Future<List<Spot>> getArea() async {
    await _area.sendCurrentLocation();
    await _area.getData();
    return _area.spots;
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

/*
  static Saver saver = DatabaseSaver();
  static Loader loader = DatabaseLoader();
  static final Searcher _searcher = DatabaseSearcher();
  late BuildContext navigatorKey;

  void save(User userToSave) {
    saver.save(userToSave);
  }

  load(String username, String password) async {
    //TODO : call database methode + create user
  }

  changeUsername(String newName) {
    //TODO : call database method
  }

  changeCurrentPassword(String newPass) {
    //TODO : call database method
  }

  Future<bool> searchByUsername(String username) async {
    return await _searcher.searchByUsername(username);
  }

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
  */
}
