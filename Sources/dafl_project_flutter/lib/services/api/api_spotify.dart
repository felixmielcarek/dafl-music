import 'package:dafl_project_flutter/services/api/api_spotify_identification.dart';
import 'package:dafl_project_flutter/services/api/api_spotify_requests.dart';

class ApiSpotify {
  late ApiSpotifyIdentification _identification;
  late ApiSpotifyRequests _requests;

  ApiSpotify() {
    _identification = ApiSpotifyIdentification();
  }

  ApiSpotifyIdentification get identification => _identification;

  ApiSpotifyRequests get requests => _requests;

  apiAuthorization(url) async {
    await _identification.setCode(url);
    _requests = ApiSpotifyRequests(await _identification.createToken());
  }
}
