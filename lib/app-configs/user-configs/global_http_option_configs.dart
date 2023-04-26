import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:redstonex/networks/response/api_response.dart';
import 'package:redstonex/networks/response/raw_data.dart';

/// http全局配置
class GlobalHttpOptionConfigs {
  /// 默认连接时间
  int get connectTimeout => 5000;

  /// 默认读超时
  int get receiveTimeout => 30000;

  /// 默认写超时
  int get sendTimeout => 10000;

  /// 默认内容类型
  String get sendContentType => Headers.jsonContentType;

  /// 默认响应类型
  ResponseType get responseType => ResponseType.json;

  /// 默认解析
  JsonDecodeCallback get jsonDecodeCallback => _parseJson;

  /// 业务响应处理
  GlobalCustomHttpBusinessResponseProcessor get customBusinessResponseProcessor => (ApiResponse response) {
        return response.data;
      };

  /// 提供dio默认异常描述
  GlobalDioError get dioError => GlobalDioError();

  /// 提供HTTP默认异常描述
  GlobalHttpError get httpError => GlobalHttpError();
}

/// 全局HTTP业务响应处理器
typedef GlobalCustomHttpBusinessResponseProcessor = RawData Function(ApiResponse response);

/// dio默认异常描述
class GlobalDioError {
  String get cancel => '';

  String get connectTimeout => 'Network Anomaly';

  String get sendTimeout => 'Network Anomaly';

  String get receiveTimeout => 'Network Anomaly';

  String get other => 'Network Anomaly';
}

/// HTTP默认异常描述
class GlobalHttpError {
  String get e400 => 'Bad Request';

  String get e401 => 'Unauthorised';

  String get e403 => 'Unauthorised';

  String get e404 => 'Unauthorised';

  String get e405 => 'Wrong Request Method';

  String get e500 => 'Internal Service Error';

  String get e502 => 'Internal Service Error';

  String get e503 => 'Internal Service Error';

  String get e505 => '505';

  String get eDefault => 'Unknown';
}

/// 必须为顶级函数
_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

/// 必须为顶级函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}
