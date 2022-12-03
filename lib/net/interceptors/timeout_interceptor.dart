import 'package:dio/dio.dart';
import 'package:redstonex/net/configs/http_constant.dart';

/// 超时拦截器
class TimeoutInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map extra = options.extra;
    bool containsConnectTimeout = extra.containsKey(HttpConstant.connectTimeout);
    bool containsReceiveTimeout = extra.containsKey(HttpConstant.receiveTimeOut);
    // Header有指定字段名的连接超时、接收超时时，单独指定和设置本次请求
    if (containsConnectTimeout || containsReceiveTimeout) {
      if (containsConnectTimeout) {
        int connectTimeout = options.extra[HttpConstant.connectTimeout];
        options.connectTimeout = connectTimeout;
      }
      if (containsReceiveTimeout) {
        int receiveTimeOut = options.extra[HttpConstant.receiveTimeOut];
        options.receiveTimeout = receiveTimeOut;
      }
    }
    super.onRequest(options, handler);
  }
}
