import 'dart:developer' as dev;

class ApiException implements Exception {
  final String mess = 'Api exception raised,';

  ApiException(dynamic code) {
    if (code.runtimeType == String) {
      dev.log('$mess state verification failed.');
    } else {
      dev.log('$mess status code : $code.');
    }
  }
}
