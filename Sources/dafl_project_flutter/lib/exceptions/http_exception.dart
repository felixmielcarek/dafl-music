import 'dart:developer' as dev;

class HttpException implements Exception {
  HttpException(var value) {
    dev.log('Http request failed :');
    dev.log('Status code : ${value.statusCode.toString()}');
    dev.log('Body : ${value.body.toString()}');
  }
}
