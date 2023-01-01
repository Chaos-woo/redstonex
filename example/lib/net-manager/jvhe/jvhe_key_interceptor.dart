
import 'package:dio/dio.dart';

class JvheKeyInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map<String, dynamic> queryParameters = options.queryParameters;
    queryParameters['key'] = '00c9717ec258764250bfa833231a68a2';
    options.queryParameters = queryParameters;
    super.onRequest(options, handler);
  }
}