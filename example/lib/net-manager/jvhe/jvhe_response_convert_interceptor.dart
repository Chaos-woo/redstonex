import 'package:dio/dio.dart';
import 'package:redstonex/redstonex.dart';

class JvheResponseConvertInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map<String, dynamic> data = response.data;
    data['data'] = data['result'];
    data.remove('result');

    if (0 == data['error_code']) {
      data['code'] = 200;
      data.remove('error_code');
    }

    response.data = data;

    rLog().debug('Jvhe data request: ${response.toString()}');
    super.onResponse(response, handler);
  }
}
