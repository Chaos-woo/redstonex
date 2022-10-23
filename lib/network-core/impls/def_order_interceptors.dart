import 'package:dio/dio.dart';
import 'package:redstonex/network-core/impls/order_interceptor.dart';
import 'package:redstonex/network-core/interceptors/error_interceptor.dart';
import 'package:redstonex/network-core/interceptors/timeout_interceptor.dart';

class DefOrderInterceptors {
  /// sort by 10
  static OrderInterceptor orderTimeoutInterceptor = OrderInterceptor(TimeoutInterceptor(), 10);

  /// sort by 70
  static OrderInterceptor orderDioLogInterceptor = OrderInterceptor(LogInterceptor(), 70);

  /// sort by 99
  static OrderInterceptor orderErrorInterceptor = OrderInterceptor(ErrorInterceptor(), 99);
}
