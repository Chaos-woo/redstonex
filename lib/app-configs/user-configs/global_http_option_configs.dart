import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// http全局配置
class GlobalHttpOptionConfigs {
  /// 全局url配置
  String get baseUrl => 'www.google.com';

  /// 默认连接时间
  int get connectTimeout => 5000;

  /// 默认读超时
  int get receiveTimeout => 30000;

  /// 默认写超时
  int get sendTimeout => 10000;

  /// 默认内容类型
  String get sendContentType => 'application/json; charset=utf-8';

  /// 默认响应类型
  ResponseType get responseType => ResponseType.json;

  /// 默认解析
  JsonDecodeCallback get jsonDecodeCallback => _parseJson;

  /// 默认业务成功码
  int get businessSuccessCode => 200;
}

/// Must be a top-level function
_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

/// Must be a top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}
