import 'music.dart';

class Spot {
  String userId;
  Music music;

  Spot(this.userId, this.music);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Spot &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          music == other.music;

  @override
  int get hashCode => userId.hashCode ^ music.hashCode;
}
