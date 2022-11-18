import '../exceptions/api_exception.dart';
import '../main.dart';

class Music {
  late String _name;
  late String _artist;
  late String _linkCover;
  final String _id;
  late DateTime date;

  Music(this._id) {
    _completeInfo();
  }

  String get name => _name;
  String get artist => _artist;
  String get linkCover => _linkCover;
  String get id => _id;

  _completeInfo() async {
    try {
      var info = await MyApp.api.getTrackInfo(_id);
      _name = info['name'];
      _artist = info['artist'];
      _linkCover = info['cover'];
    } on ApiException {
      // TODO : add notification to show that an error occured
    }
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Music &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          artist == other.artist;

  @override
  int get hashCode => name.hashCode ^ artist.hashCode;

  void defineDate() {
    this.date = new DateTime.now();
  }
}
