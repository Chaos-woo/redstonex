import 'package:dio/dio.dart';
import 'package:redstonex/network-core/definitions/http_option.dart';
import 'package:redstonex/network-core/impls/def_order_interceptors.dart';
import 'package:redstonex/network-core/impls/order_interceptor.dart';
import 'package:redstonex/network-core/impls/self_dio.dart';

/// Dio client manager.
class Dios {
  static final Map<String /*baseUrl*/, SelfDio> _dios = {};

  static SelfDio instance(String baseUrl, {HttpOption? option, List<OrderInterceptor>? interceptors}) {
    if (!_dios.containsKey(baseUrl)) {
      List<OrderInterceptor> interceptorWrappers = interceptors ??
          [
            DefOrderInterceptors.orderTimeoutInterceptor,
            DefOrderInterceptors.orderDioLogInterceptor,
            DefOrderInterceptors.orderErrorInterceptor,
          ];
      interceptorWrappers.sort();
      List<Interceptor> orderedInterceptors = interceptorWrappers.map((e) => e.interceptor).toList();
      _dios[baseUrl] = SelfDio.create(baseUrl, option ?? HttpOptionBuilder().build(), orderedInterceptors);
    }

    return _dios[baseUrl]!;
  }
}
