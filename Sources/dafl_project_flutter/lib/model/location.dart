import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';

class Location {
  static Future<Tuple2<double, double>> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position current = await Geolocator.getCurrentPosition();
    double long = current.longitude;
    double lat = current.latitude;
    return Tuple2(long,lat);
  }
}




