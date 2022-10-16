import 'package:dio/dio.dart';
import 'package:redstonex/network-core/definitions/http/redstone_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/error_context_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/request_context_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/request_loading_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/response_context_interceptor.dart';

/// Get built-in interceptor of fixed order for dio.
///
class BuiltinInterceptors {
  /// log interceptor
  static RedstoneInterceptor get builtinLog => RedstoneInterceptor(
        LogInterceptor(requestBody: true, responseBody: true, requestHeader: true),
        order: 255,
      );

  /// publish loading event interceptor
  static RedstoneInterceptor get builtinLoadingPublisher => RedstoneInterceptor(
        RequestLoadingInterceptor(),
        order: -2,
      );

  /// request context interceptor
  static RedstoneInterceptor get builtinRequestCtx => RedstoneInterceptor(
        RequestContextInterceptor(),
        order: -20,
      );

  //// request context interceptor
  static RedstoneInterceptor get builtinResponseCtx => RedstoneInterceptor(
        ResponseContextInterceptor(),
        order: 20,
      );

  //// request context interceptor
  static RedstoneInterceptor get builtinErrorCtx => RedstoneInterceptor(
    ErrorContextInterceptor(),
    order: 19,
  );
}
