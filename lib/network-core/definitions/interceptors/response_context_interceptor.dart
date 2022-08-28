import 'package:dio/dio.dart';
import 'package:redstonex/network-core/definitions/http/request_context.dart';

/// Built-in request context interceptor.
///
/// It will be put in interceptors chain and before [LogInterceptor].
/// So, add custom interceptor will get [RequestContext] in [RequestOptions.extra]
class ResponseContextInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    RequestContext? rc = response.extra[RequestContext.fixedExtraRequestCtxName];
    if (null != rc) {
      rc.response = response;
      response.extra[RequestContext.fixedExtraRequestCtxName] = rc;
    }
    handler.next(response);
  }
}
