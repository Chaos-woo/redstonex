import 'package:dio/dio.dart';
import 'package:redstonex/commons/utils/ids_utils.dart';
import 'package:redstonex/network-core/definitions/http/http_method.dart';
import 'package:redstonex/network-core/definitions/http/request.dart';
import 'package:redstonex/network-core/definitions/http/request_context.dart';

/// Built-in request context interceptor.
///
/// It will be put in interceptors chain and before [LogInterceptor].
/// So, add custom interceptor will get [RequestContext] in [RequestOptions.extra]
class RequestContextInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Request request = Request(
      options,
      data: options.data,
      method: _resolveHttpMethod(options.method),
    );
    RequestContext rc = RequestContext(IdsUtil.uuidV4(), request);
    options.extra[RequestContext.fixedExtraRequestCtxName] = rc;
    handler.next(options);
  }

  HttpMethod _resolveHttpMethod(String method) {
    switch (method) {
      case 'GET':
        return HttpMethod.get;
      case 'POST':
        return HttpMethod.post;
      case 'PUT':
        return HttpMethod.put;
      case 'DELETE':
        return HttpMethod.delete;
      default:
        return HttpMethod.enumNotDefine;
    }
  }
}
