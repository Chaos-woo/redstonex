import 'package:flutter/foundation.dart';
import 'package:redstonex/commons/utils/delayed_utils.dart';

/// An extension for [DelayedUtils]
///
extension DelayedMixin on DelayedUtils {
  /// delay callback for milliseconds
  static Future<void> delayMill(int milliseconds, VoidCallback callback) =>
      DelayedUtils.delayAny(callback, duration: Duration(milliseconds: milliseconds));

  /// delay callback for seconds
  static Future<void> delaySeconds(int seconds, VoidCallback callback) =>
      DelayedUtils.delayAny(callback, duration: Duration(seconds: seconds));

  /// replable callback
  static Future<void> replableDelay(VoidCallback callback,
          {Duration? initialDelay, int replay = 3, int intervalDelay = 100}) =>
      Future.delayed(initialDelay ?? Duration.zero).whenComplete(() async {
        for (int i = 0; i < replay; i++) {
          await delayMill(intervalDelay, callback);
        }
      });
}
