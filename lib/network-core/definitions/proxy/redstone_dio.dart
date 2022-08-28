import 'package:dio/dio.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/app-configs/user-configs/global_http_option_configs.dart';

/// An encapsulated dio
///
class RedStoneDio {
  /// name of dio for search it
  final String name;

  /// dio instance
  final Dio dio;

  /// interceptors of current dio
  final List<Interceptor> _interceptors = [];

  /// todo: support https

  RedStoneDio.newDio(
    this.name, {
    List<Interceptor>? interceptors,
    BaseOptions? options,
  }) : dio = Dio(options ?? defBaseOptions()) {
    _interceptors.addAll(interceptors ?? []);

    /// add user custom interceptors
    dio.interceptors.addAll(_interceptors);

    /// set json decode function
    (dio.transformer as DefaultTransformer).jsonDecodeCallback =
        GlobalConfig.of().globalHttpOptionConfigs.jsonDecodeCallback;
  }

  /// default [BaseOptions] from global http configuration
  static BaseOptions defBaseOptions() {
    GlobalHttpOptionConfigs config = GlobalConfig.of().globalHttpOptionConfigs;
    return BaseOptions(
      connectTimeout: config.connectTimeout,
      receiveTimeout: config.receiveTimeout,
      sendTimeout: config.sendTimeout,
      responseType: config.responseType,
      contentType: config.sendContentType,
    );
  }
}
