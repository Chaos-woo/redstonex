import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../events/redstonex_event_bus.dart';

class rEventObserverUtil {
  static List<StreamSubscription?> createAutoCloseableSubStreams() => [];
}

/// 支持事件方式更新UI
mixin rHasEventObserverOfController on GetxController {
  getAutoCloseableSubStreams();

  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    for (var ss in getAutoCloseableSubStreams()) {
      ss?.cancel();
    }
  }

  @protected
  StreamSubscription onEventObserve<T>(
      void Function(T event) onEvent,
      Function? onError,
      void Function()? onDone,
      ) {
    StreamSubscription subscription = rEventBus().subscribeAutoCancelOnError<T>(
          (T event) => onEvent.call(event),
      onDone: onDone,
      onError: onError,
    );

    getAutoCloseableSubStreams().add(subscription);
    return subscription;
  }

  @protected
  Future<void> closeEventObserve(StreamSubscription? subscription) async {
    subscription?.cancel();
    try {
      getAutoCloseableSubStreams().remove(subscription);
    } catch (e) {
      // do nothing
    }
  }
}

/// 支持事件方式更新UI
mixin rHasEventObserverOfService on GetxService {
  getAutoCloseableSubStreams();

  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    for (var ss in getAutoCloseableSubStreams()) {
      ss?.cancel();
    }
  }

  @protected
  StreamSubscription onEventObserve<T>(
      void Function(T event) onEvent,
      Function? onError,
      void Function()? onDone,
      ) {
    StreamSubscription subscription = rEventBus().subscribeAutoCancelOnError<T>(
          (T event) => onEvent.call(event),
      onDone: onDone,
      onError: onError,
    );

    getAutoCloseableSubStreams().add(subscription);
    return subscription;
  }

  @protected
  Future<void> closeEventObserve(StreamSubscription? subscription) async {
    subscription?.cancel();
    try {
      getAutoCloseableSubStreams().remove(subscription);
    } catch (e) {
      // do nothing
    }
  }
}
