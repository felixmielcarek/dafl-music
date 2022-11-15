import 'dart:developer' as dev;

class ApiException implements Exception {
  ApiException() {
    dev.log('Api exception raised');
  }
}
