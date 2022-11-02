class Music{
  String name;
  String artist;
  String linkCover;

  Music(this.name, this.artist, this.linkCover);


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