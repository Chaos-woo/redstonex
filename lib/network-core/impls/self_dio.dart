
import 'package:dio/dio.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/network-core/definitions/http_option.dart';

/// Dio instance and configuration wrapper.
class SelfDio {
  final String _baseUrl;
  final HttpOption _httpOption;
  final List<Interceptor> _interceptors;
  late Dio _dio;

  Dio get dio => _dio;

  String get baseUrl => _baseUrl;

  SelfDio.create(this._baseUrl, this._httpOption, this._interceptors) {
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _httpOption.connectTimeout,
      receiveTimeout: _httpOption.receiveTimeOut,
      sendTimeout: _httpOption.sendTimeout,
      responseType: _httpOption.responseType,
      contentType: _httpOption.sendContentType,
    );

    _dio = Dio(options);
    _dio.interceptors.addAll(_interceptors);
    /// set json decode function
    (dio.transformer as DefaultTransformer).jsonDecodeCallback =
        GlobalConfig.of().globalHttpOptionConfigs.jsonDecodeCallback;

    networkProxy(dio);
  }

  void networkProxy(Dio dio) {}
}