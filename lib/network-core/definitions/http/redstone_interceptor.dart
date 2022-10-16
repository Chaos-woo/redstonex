
import 'package:dio/dio.dart';

/// A interceptor wrapper
///
class RedstoneInterceptor {
  /// real interceptor
  final Interceptor interceptor;

  /// order
  int order;

  RedstoneInterceptor(this.interceptor, {this.order = 0});

  @override
  String toString() {
    return 'RedstoneInterceptor{interceptor: $interceptor, order: $order}';
  }
}