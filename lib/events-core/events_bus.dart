import 'dart:async';

import 'package:event_bus/event_bus.dart';

/// An event bus simple implement.
///
class EventsBus {
  /// real event bus entity
  static final EventBus _bus = EventBus();

  EventsBus._();

  static void _fire<T>(T event) => _bus.fire(event);

  /// Fire a event to bus.
  ///
  /// Put immediately event to bus
  static Future<void> fire<T>(T event) async => _fire(event);

  /// Fire a event to bus.
  ///
  /// Put event to dart next event cycle
  static Future<void> fireZeroDelay<T>(T event) =>
      Future.delayed(Duration.zero, () => _fire(event));

  /// Fire a event to bus.
  ///
  /// Put event to bus when delay x duration
  static Future<void> fireDelay<T>(T event, {Duration? duration}) => Future.delayed(
        duration ?? Duration.zero,
        () => _bus.fire(event),
      );

  /// subscribe type `T` event and auto cancel on error
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

  /// subscribe type `T` event
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
