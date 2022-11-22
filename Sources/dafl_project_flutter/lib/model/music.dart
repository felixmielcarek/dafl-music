import '../exceptions/api_state_exception.dart';
import '../main.dart';

class Music {
  final String _id;
  final String _name;
  final String _artist;
  final String _linkCover;

  Music(this._id, this._name, this._artist, this._linkCover);

  String get id => _id;

  String get name => _name;

  String get artist => _artist;

  String get linkCover => _linkCover;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Music &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          artist == other.artist;

  @override
  int get hashCode => name.hashCode ^ artist.hashCode;
}
