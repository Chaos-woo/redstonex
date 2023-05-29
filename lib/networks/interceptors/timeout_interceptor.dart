import 'package:dio/dio.dart';

import '../configs/http_constant.dart';

/// 超时拦截器
class rTimeoutInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map extra = options.extra;
    bool containsConnectTimeout = extra.containsKey(rHttpConstant.connectTimeout);
    bool containsReceiveTimeout = extra.containsKey(rHttpConstant.receiveTimeOut);
    // Header有指定字段名的连接超时、接收超时时，单独指定和设置本次请求
    if (containsConnectTimeout || containsReceiveTimeout) {
      if (containsConnectTimeout) {
        int connectTimeout = options.extra[rHttpConstant.connectTimeout];
        options.connectTimeout = connectTimeout;
      }
      if (containsReceiveTimeout) {
        int receiveTimeOut = options.extra[rHttpConstant.receiveTimeOut];
        options.receiveTimeout = receiveTimeOut;
      }
    }
    super.onRequest(options, handler);
  }
}
