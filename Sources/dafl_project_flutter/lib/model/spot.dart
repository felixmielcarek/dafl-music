import 'music.dart';

class Spot {
  String userId;
  Music music;

  Spot(this.userId, this.music);

  @override
  bool operator ==(Object other) =>
      other is Spot &&
      runtimeType == other.runtimeType &&
      music.name == other.music.name;

  @override
  int get hashCode => music.hashCode;
}
