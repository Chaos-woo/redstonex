import 'package:dio/dio.dart';
import 'package:redstonex/network-core/definitions/http_config_consts.dart';

/// Timeout interceptor
class TimeoutInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map extra = options.extra;
    bool containsConnectTimeout = extra.containsKey(HttpConfigConsts.connectTimeout);
    bool containsReceiveTimeout = extra.containsKey(HttpConfigConsts.receiveTimeOut);
    if (containsConnectTimeout || containsReceiveTimeout) {
      if (containsConnectTimeout) {
        // set specify single request connect timeout
        int connectTimeout = options.extra[HttpConfigConsts.connectTimeout];
        options.connectTimeout = connectTimeout;
      }
      if (containsReceiveTimeout) {
        // set specify single request receive timeout
        int receiveTimeOut = options.extra[HttpConfigConsts.receiveTimeOut];
        options.receiveTimeout = receiveTimeOut;
      }
    }
    super.onRequest(options, handler);
  }
}
