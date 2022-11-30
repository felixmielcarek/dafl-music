import 'dart:convert';
import 'package:dafl_project_flutter/controller/live_datas.dart';
import 'package:dafl_project_flutter/model/music.dart';
import 'package:dafl_project_flutter/model/spot.dart';
import 'package:dafl_project_flutter/services/api/api_spotify.dart';
import 'package:dafl_project_flutter/services/database/database_service.dart';
import 'package:dafl_project_flutter/services/position/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class Controller {
  ApiSpotify _api = ApiSpotify();
  late User _currentUser;
  final DataBaseService _dataBaseService = DataBaseService();
  final LiveDatas _datas = LiveDatas();

  late BuildContext navigatorKey;

  //
  // Methods to manage datas
  //

  // Datas that can change

  bool getChoice() => _datas.discoveriesSortChoice;

  setChoice(bool c) {
    _datas.discoveriesSortChoice = c;
  }

  Music getCurrentMusic() => _datas.userCurrentMusic;

  setCurrentMusic() async {
    _datas.userCurrentMusic =
        await getCompleteMusic(await _api.requests.getCurrentlyPlayingTrack());
  }

  List<Spot> getSpots() => _datas.spots;

  setSpots() async {
    _datas.spots = await Location.sendCurrentLocation();
  }

  Map<Music, DateTime> getDiscoveries() => _datas.discoveries;

  setDiscoveries() async {
    Map<String, DateTime> tmpData = await _api.requests.getPlaylistTracks();
    Map<Music, DateTime> tmpCast = {};
    tmpData.forEach((key, value) async {
      tmpCast[(await getCompleteMusic(key))] = value;
    });
    _datas.discoveries = tmpCast;
  }

  //Data that can not change

  Uri getApiUrlAuthorize() => _api.identification.urlAuthorize;

  String getApiRedirectUrl() => _api.identification.redirectUri;

  String getIdSpotify() => _currentUser.idSpotify;

  int getIdDafl() => _currentUser.idDafl;

  //
  //Other methods
  //

  apiAuthorization(url) {
    _api.apiAuthorization(url);
  }

  Future<Music> getCompleteMusic(String id) async {
    Map infos = await _api.requests.getTrackInfo(id);
    return Music(id, infos['name'], infos['artist'], infos['cover']);
  }

  removeFromPlaylist(String id) {
    _api.requests.removeFromPlaylist(id);
  }

  addToPlaylist(String id) {
    _api.requests.addToPlaylist(id);
  }

  playTrack(String id) {
    _api.requests.playTrack(id);
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
