import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../events/redstonex_event_bus.dart';

abstract class EventObserver {
  List<StreamSubscription?> customAutoCancelableStreamSubscriptions();

  @protected
  StreamSubscription onEventObserve<T>(
    void Function(T event) onEvent,
    Function? onError,
    void Function()? onDone,
  ) {
    StreamSubscription subscription = XEventBus().subscribeAutoCancelOnError<T>(
      (T event) => onEvent.call(event),
      onDone: onDone,
      onError: onError,
    );

    customAutoCancelableStreamSubscriptions().add(subscription);
    return subscription;
  }

  @protected
  Future<void> closeEventObserve(StreamSubscription? subscription) async {
    try {
      customAutoCancelableStreamSubscriptions().remove(subscription);
    } catch (e) {
      // do nothing
    }
    subscription?.cancel();
  }
}

/// 支持事件方式更新UI
mixin HasEventObserverOfController on GetxController implements EventObserver {
  final List<StreamSubscription?> _cancelableStreamSubscriptions = [];

  @override
  customAutoCancelableStreamSubscriptions() => _cancelableStreamSubscriptions;

  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    for (var ss in _cancelableStreamSubscriptions) {
      ss?.cancel();
    }
  }
}

/// 支持事件方式更新UI
mixin HasEventObserverOfService on GetxService implements EventObserver {
  final List<StreamSubscription?> _cancelableStreamSubscriptions = [];

  @override
  customAutoCancelableStreamSubscriptions() => _cancelableStreamSubscriptions;

  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    for (var ss in _cancelableStreamSubscriptions) {
      ss?.cancel();
    }
  }
}
