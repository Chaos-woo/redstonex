
import 'package:dio/dio.dart';

/// Dynamic insert new interceptor to exist interceptor list.
class OrderInterceptor implements Comparable<OrderInterceptor> {
  final Interceptor interceptor;
  final int order;

  OrderInterceptor(this.interceptor, this.order);

  @override
  int compareTo(OrderInterceptor other) {
    return order.compareTo(other.order);
  }
}