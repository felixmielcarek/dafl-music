import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/music.dart';
import '../model/spot.dart';
import '../model/user.dart';
import '../services/api/api_spotify.dart';
import '../services/database/database_service.dart';
import '../services/position/location.dart';
import 'live_datas.dart';
import 'package:dafl_project_flutter/model/message.dart';
import 'package:dafl_project_flutter/services/messaging/message_database_service.dart';
import 'dart:developer' as dev;

class Controller {
  final ApiSpotify _api = ApiSpotify();
  late User _currentUser;
  final DataBaseService _dataBaseService = DataBaseService();
  final LiveData _data = LiveData();
  final MessageDatabaseService _messageAccess = MessageDatabaseService();

  late BuildContext navigatorKey;



  /// FIREBASE Messaging
  void sendMessage(Message message, String idSender, String idReceiver) {
    _messageAccess.sendMessage(message, idSender, idReceiver);
  }

  Stream<List<Message>> getMessage(String idSender, String idReceiver) {
    return _messageAccess.getMessage(idSender, idReceiver);
  }

  void addUserConversation(String idSender, String idReceiver){
    _messageAccess.addMessagingUser(idSender, idReceiver);
  }






  initUser() async {
    await setCurrentMusic();
    await setDiscoveries();
  }

  beginRoutine() {
    Timer.periodic(const Duration(seconds: 20), (Timer t) => setSpots());
  }

  //
  // Methods to manage data
  //

  // Data that can change

  bool getChoice() => _data.discoveriesSortChoice;

  setChoice(bool c) {
    _data.discoveriesSortChoice = c;
  }

  Music getCurrentMusic() => _data.userCurrentMusic;

  setCurrentMusic() async {
    _data.userCurrentMusic =
        await getCompleteMusic(await _api.requests.getCurrentlyPlayingTrack());
  }

  List<Spot> getSpots() {
    return _data.spots;
  }

  setSpots() async {
    print('setspot');
    _data.spots = await Location.sendCurrentLocation();
  }

  LinkedHashMap<Music, DateTime> getDiscoveries() => _data.discoveries;

  void deleteDiscoveries(Music key) {
    _data.discoveries.remove(key);
    removeFromPlaylist(key.id);
  }


  setDiscoveries() async {
    LinkedHashMap<String, DateTime> tmpData =
        await _api.requests.getPlaylistTracks();
    LinkedHashMap<Music, DateTime> tmpCast = LinkedHashMap();
    tmpData.forEach((key, value) async {
      tmpCast[(await getCompleteMusic(key))] = value;
    });
    _data.discoveries = tmpCast;
  }

  //Data that can not change

  Uri getApiUrlAuthorize() => _api.identification.urlAuthorize;

  String getApiRedirectUrl() => _api.identification.redirectUri;

  String getIdSpotify() => _currentUser.idSpotify;

  String getIdDafl() => _currentUser.idDafl;

  //
  //Other methods
  //

  apiAuthorization(url) {
    _api.apiAuthorization(url);
  }

  Future<Music> getCompleteMusic(String id) async {
    Map info = await _api.requests.getTrackInfo(id);
    return Music(id, info['name'], info['artist'], info['cover']);
  }

  removeFromPlaylist(String id) {
    _api.requests.removeFromPlaylist(id);
  }

  addToPlaylist(String id) async {
    _api.requests.addToPlaylist(id);
    Music music = await getCompleteMusic(id);
    _data.discoveries.addAll({music: DateTime.now()});
  }

  playTrack(String id) {
    _api.requests.playTrack(id);
  }

  // DATABASE
  void save(String idDafl, String passw) {
    _dataBaseService.save(idDafl, passw);
  }

  Future<bool> load(String username, String password) async {
    User? newUser = await _dataBaseService.load(username, password);

    if (newUser == null) {
      return false;
    }
    _currentUser = newUser;
    _currentUser.idSpotify = await _api.requests.getIdUser();
    return true;
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
