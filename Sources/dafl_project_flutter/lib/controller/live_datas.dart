import 'dart:collection';

import '../model/music.dart';
import '../model/spot.dart';

class LiveData {
  bool discoveriesSortChoice = true;
  late LinkedHashMap<Music, DateTime> discoveries;
  late List<Spot> spots;
  late Music userCurrentMusic;
}
