import 'package:dafl_project_flutter/main.dart';

import '../model/music.dart';
import '../model/spot.dart';

class LiveDatas {
  bool discoveriesSortChoice =
      false; //false = sort by name ; true = sort by date
  Map<Music, DateTime> discoveries;
  List<Spot> spots;
  Music userCurrentMusic;

  LiveDatas() {}
}
