import 'package:flutter/foundation.dart';

/// define returnable parameter `R` type function.
typedef Callable<R> = R Function();

/// 延时执行工具
class rDelay {
  static final rDelay _single = rDelay._internal();

  rDelay._internal();

  factory rDelay() => _single;

  Future<void> delay(VoidCallback callback) => delayAny(callback);

  Future<void> delayAny(VoidCallback callback, {Duration? duration}) =>
      Future.delayed(duration ?? Duration.zero).whenComplete(callback);

  Future<R> delayReturn<R>(Callable<R> callable, {Duration? duration}) async =>
      await Future<R>.delayed(duration ?? Duration.zero).whenComplete(callable);
}
