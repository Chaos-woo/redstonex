import 'package:dio/dio.dart';
import 'package:redstonex/commons/exceptions/app_exception.dart';
import 'package:redstonex/network-core/definitions/http/request_context.dart';

/// Built-in request context interceptor.
///
/// It will be put in interceptors chain and before [LogInterceptor].
/// So, add custom interceptor will get [RequestContext] in [RequestOptions.extra]
class DefExceptionInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    AppException appException = AppException.http(err);
    err.error = appException;
    handler.next(err);
  }
}
