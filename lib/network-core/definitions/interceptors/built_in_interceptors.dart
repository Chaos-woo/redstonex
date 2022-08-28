import 'package:dio/dio.dart';
import 'package:redstonex/network-core/definitions/http/redstone_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/error_context_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/request_context_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/request_loading_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/response_context_interceptor.dart';

/// Get built-in interceptor of fixed order for dio.
///
class BuiltInInterceptors {
  /// log interceptor
  static RedStoneInterceptor get builtInLog => RedStoneInterceptor(
        LogInterceptor(requestBody: true, responseBody: true, requestHeader: true),
        order: 255,
      );

  /// publish loading event interceptor
  static RedStoneInterceptor get builtInLoadingPublisher => RedStoneInterceptor(
        RequestLoadingInterceptor(),
        order: -2,
      );

  /// request context interceptor
  static RedStoneInterceptor get builtInRequestCtx => RedStoneInterceptor(
        RequestContextInterceptor(),
        order: -20,
      );

  //// request context interceptor
  static RedStoneInterceptor get builtInResponseCtx => RedStoneInterceptor(
        ResponseContextInterceptor(),
        order: 20,
      );

  //// request context interceptor
  static RedStoneInterceptor get builtInErrorCtx => RedStoneInterceptor(
    ErrorContextInterceptor(),
    order: 19,
  );
}
