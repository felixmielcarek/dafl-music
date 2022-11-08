class Track {
  final String _artist;
  final String _name;
  final String _albumImage;

  Track(this._artist, this._name, this._albumImage);

  String get artist => _artist;
  String get name => _name;
  String get albumImage => _albumImage;
}
