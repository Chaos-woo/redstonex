import 'package:dio/dio.dart';
import 'package:redstonex/commons/exceptions/app_exception.dart';
import 'package:redstonex/network-core/definitions/http/request_context.dart';

/// Built-in request context interceptor.
///
/// It will be put in interceptors chain and before [LogInterceptor].
/// So, add custom interceptor will get [RequestContext] in [RequestOptions.extra]
class ErrorContextInterceptor extends Interceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (null != err.response) {
      RequestContext rc = err.response?.extra[RequestContext.fixedExtraRequestCtxName];
      rc.appException = err.error as AppException;
      err.response?.extra[RequestContext.fixedExtraRequestCtxName] = rc;
    }
    handler.next(err);
  }
}
