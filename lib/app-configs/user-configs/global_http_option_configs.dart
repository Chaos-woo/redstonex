import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Global base option of http
class GlobalHttpOptionConfigs {
  /// base url
  String get baseUrl => 'www.google.com';

  /// default connect timeout
  int get connectTimeout => 5000;

  /// default receiveTimeout
  int get receiveTimeout => 30000;

  /// default send timeout
  int get sendTimeout => 10000;

  /// default send content type
  String get sendContentType => 'application/json; charset=utf-8';

  /// default response type
  ResponseType get responseType => ResponseType.json;

  /// default parse response json with using `compute`
  JsonDecodeCallback get jsonDecodeCallback => _parseJson;

  /// auto insert log interceptor for dio
  bool get enableAutoLogInterceptor => false;

  /// whether enable publish loading event when http request
  bool get enableHttpLoadingEventPublish => false;

  /// enable request context log
  bool get enableRequestContextInterceptor => false;
}

/// Must be a top-level function
_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

/// Must be a top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}
