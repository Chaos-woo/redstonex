import 'dart:async';

import 'package:event_bus/event_bus.dart';

/// 事件流工具
class RsxBus {
  /// 单例
  static final EventBus _bus = EventBus();

  RsxBus._();

  static void _fire<T>(T event) => _bus.fire(event);

  /// 立即触发一个事件
  static Future<void> fire<T>(T event) async => _fire(event);

  /// 在dart单线程时间循环的下一个循环触发一个事件
  static Future<void> fireZeroDelay<T>(T event) =>
      Future.delayed(Duration.zero, () => _fire(event));

  /// 延时[duration]后触发一个事件
  static Future<void> fireDelay<T>(T event, {Duration? duration}) => Future.delayed(
        duration ?? Duration.zero,
        () => _bus.fire(event),
      );

  /// 订阅T类型事件，并在异常错误时自动取消订阅
  static StreamSubscription subscribeAutoCancelOnError<T>(
      void Function(T event) onData, {
        Function? onError,
        void Function()? onDone,
      }) {
    return subscribe<T>(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: true,
    );
  }

  /// 订阅T类型事件
  static StreamSubscription subscribe<T>(
      void Function(T event) onData, {
        Function? onError,
        void Function()? onDone,
        bool? cancelOnError,
      }) {
    StreamSubscription subscription = _bus.on<T>().listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
    return subscription;
  }
}
