import 'package:dio/dio.dart';

import '../../app-configs/global_config.dart';

class rHttpOption {
  final int _connectTimeout;
  final int _receiveTimeout;
  final int _sendTimeout;
  final String _sendContentType;
  final ResponseType _responseType;
  final HttpClientAdapter? _httpClientAdapter;
  final JsonDecodeCallback _jsonDecodeCallback;

  int get connectTimeout => _connectTimeout;

  int get receiveTimeOut => _receiveTimeout;

  ResponseType get responseType => _responseType;

  String get sendContentType => _sendContentType;

  int get sendTimeout => _sendTimeout;

  HttpClientAdapter? get httpClientAdapter => _httpClientAdapter;

  JsonDecodeCallback get jsonDecodeCallback => _jsonDecodeCallback;

  rHttpOption(rHttpOptionBuilder builder)
      : _connectTimeout = builder.connectTimeout,
        _receiveTimeout = builder.receiveTimeOut,
        _sendTimeout = builder.sendTimeout,
        _sendContentType = builder.sendContentType,
        _responseType = builder.responseType,
        _httpClientAdapter = builder.httpClientAdapter,
        _jsonDecodeCallback = builder.jsonDecodeCallback;

  rHttpOption immutable() {
    return (rHttpOptionBuilder()
          ..connectTimeout = _connectTimeout
          ..receiveTimeOut = _receiveTimeout
          ..sendTimeout = _sendTimeout
          ..sendContentType = _sendContentType
          ..responseType = _responseType
          ..httpClientAdapter = _httpClientAdapter
          ..jsonDecodeCallback = _jsonDecodeCallback)
        .build();
  }

  rHttpOption copyWith({
    int? optionalConnectTimeout,
    int? optionalReceiveTimeout,
    int? optionalSendTimeout,
    String? optionalSendContentType,
    ResponseType? optionalResponseType,
    HttpClientAdapter? optionalHttpClientAdapter,
    JsonDecodeCallback? optionalJsonDecodeCallback,
  }) {
    return (rHttpOptionBuilder()
          ..connectTimeout = optionalConnectTimeout ?? _connectTimeout
          ..receiveTimeOut = optionalReceiveTimeout ?? _receiveTimeout
          ..sendTimeout = optionalSendTimeout ?? _sendTimeout
          ..sendContentType = optionalSendContentType ?? _sendContentType
          ..responseType = optionalResponseType ?? _responseType
          ..httpClientAdapter = optionalHttpClientAdapter ?? _httpClientAdapter
          ..jsonDecodeCallback = optionalJsonDecodeCallback ?? _jsonDecodeCallback)
        .build();
  }
}

class rHttpOptionBuilder {
  static final globalHttpConfig = rGlobalConfig.instance.globalHttpOptionConfigs;

  int connectTimeout = globalHttpConfig.connectTimeout;
  int receiveTimeOut = globalHttpConfig.receiveTimeout;
  int sendTimeout = globalHttpConfig.sendTimeout;
  String sendContentType = globalHttpConfig.sendContentType;
  ResponseType responseType = globalHttpConfig.responseType;
  HttpClientAdapter? httpClientAdapter;
  JsonDecodeCallback jsonDecodeCallback = globalHttpConfig.jsonDecodeCallback;

  rHttpOption build() => rHttpOption(this);
}
