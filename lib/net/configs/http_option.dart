import 'package:dio/dio.dart';
import 'package:redstonex/app-configs/global_config.dart';

class HttpOption {
  final int _connectTimeout;
  final int _receiveTimeOut;
  final int _sendTimeout;
  final String _sendContentType;
  final ResponseType _responseType;

  int get connectTimeout => _connectTimeout;

  int get receiveTimeOut => _receiveTimeOut;

  ResponseType get responseType => _responseType;

  String get sendContentType => _sendContentType;

  int get sendTimeout => _sendTimeout;

  HttpOption(HttpOptionBuilder builder)
      : _connectTimeout = builder._connectTimeout,
        _receiveTimeOut = builder._receiveTimeOut,
        _sendTimeout = builder._sendTimeout,
        _sendContentType = builder._sendContentType,
        _responseType = builder._responseType;

  HttpOption immutable() {
    HttpOptionBuilder builder = HttpOptionBuilder();
    builder.connectTimeout(_connectTimeout);
    builder.receiveTimeOut(_receiveTimeOut);
    builder.sendTimeout(sendTimeout);
    builder.sendContentType(_sendContentType);
    builder.responseType(_responseType);
    return builder.build();
  }
}

class HttpOptionBuilder {
  static final globalHttpConfig = GlobalConfig.of().globalHttpOptionConfigs;

  int _connectTimeout = globalHttpConfig.connectTimeout;
  int _receiveTimeOut = globalHttpConfig.receiveTimeout;
  int _sendTimeout = globalHttpConfig.sendTimeout;
  String _sendContentType = globalHttpConfig.sendContentType;
  ResponseType _responseType = globalHttpConfig.responseType;

  HttpOptionBuilder connectTimeout(int value) {
    _connectTimeout = value;
    return this;
  }

  HttpOptionBuilder receiveTimeOut(int value) {
    _receiveTimeOut = value;
    return this;
  }

  HttpOptionBuilder sendTimeout(int value) {
    _sendTimeout = value;
    return this;
  }

  HttpOptionBuilder sendContentType(String value) {
    _sendContentType = value;
    return this;
  }

  HttpOptionBuilder responseType(ResponseType value) {
    _responseType = value;
    return this;
  }

  HttpOption build() => HttpOption(this);
}
