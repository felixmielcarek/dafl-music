import 'package:flutter/cupertino.dart';

import '../exceptions/http_exception.dart';
import 'package:http/http.dart' as http;

abstract class HttpResponseVerification {
  @protected
  late http.Response response;

  @protected
  setResponse(var value) {
    if (value.statusCode >= 300) {
      throw HttpException(value);
    }
    response = value;
  }
}
