
import 'package:dio/dio.dart';

/// A interceptor wrapper
///
class RedStoneInterceptor {
  /// real interceptor
  final Interceptor interceptor;

  /// order
  int order;

  RedStoneInterceptor(this.interceptor, {this.order = 0});

  @override
  String toString() {
    return 'RedStoneInterceptor{interceptor: $interceptor, order: $order}';
  }
}