import 'package:flutter/services.dart';
import 'package:location/location.dart';

class Location {
  late Location _location;
  bool _serviceEnabled = false;
  PermissionStatus? _grantedPermission;

  Location() {
    _location = Location();
  }

  Future<bool> _checkPermission() async {
    if (await _checkService()){
      _grantedPermission = await  _location.hasPermission();
      if(_grantedPermission == PermissionStatus.denied){
        _grantedPermission = await _location.requestPermission();
      }
    }
    return _grantedPermission == PermissionStatus.granted;
  }

  Future<bool> _checkService() async {
    try{
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled){
        _serviceEnabled= await _location.requestService();
      }
    } on PlatformException catch (error){
      print('Error code : ${error.code} et le message d\' erreur : ${error.message}');
      _serviceEnabled = false;
      await _checkService();

    }
    return _serviceEnabled;
  }
}
