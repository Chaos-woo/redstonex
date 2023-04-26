import 'package:dio/dio.dart';
import 'package:redstonex/redstonex.dart';

class BiliResponseConvertInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map<String, dynamic> data = response.data;
    if (0 == data['code']) {
      data['code'] = 200;
      data.remove('error_code');
    }

    response.data = data;

    XLog().debug('bilibili data request: ${response.toString()}');
    super.onResponse(response, handler);
  }
}
