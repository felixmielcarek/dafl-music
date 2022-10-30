import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';

class Location{
  static Tuple2<double, double> getCurrentLocation() {
    Position currentPosition = Position();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
    .then((Position position) {currentPosition = position;}).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
    return Tuple2(currentPosition.longitude, currentPosition.latitude);
  }
}