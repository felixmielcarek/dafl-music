import 'dart:developer' as dev;

class ApiStateException implements Exception {
  ApiStateException() {
    dev.log('State verification failed.');
  }
}
