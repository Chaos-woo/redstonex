import 'package:flutter/foundation.dart';

/// define returnable parameter `R` type function.
typedef Callable<R> = R Function();

/// A delay execute util
///
class DelayedUtils {
  /// zero delay callback
  static Future<void> delay0(VoidCallback callback) => delayAny(callback);

  /// any delay duration callback, if [duration]
  /// is null or else zero delay to running
  static Future<void> delayAny(VoidCallback callback, {Duration? duration}) =>
      Future.delayed(duration ?? Duration.zero).whenComplete(callback);

  /// any delay duration callback and can
  /// return `R` type value
  static Future<R> delayReturn<R>(Callable<R> callable, {Duration? duration}) async =>
      await Future<R>.delayed(duration ?? Duration.zero).whenComplete(callable);
}
