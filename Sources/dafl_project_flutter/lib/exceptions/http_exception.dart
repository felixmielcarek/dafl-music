import 'dart:developer' as dev;
import 'package:http/http.dart';

class HttpException implements Exception {
  HttpException(var value) {
    dev.log('Http request failed');
    if (value.runtimeType == Response) {
      dev.log('Status code : ${value.statusCode.toString()}');
      dev.log('Body : ${value.body.toString()}');
    }
  }
}