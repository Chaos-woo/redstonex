import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/events/redstonex_event_bus.dart';
import 'package:redstonex/observer/inner_refresh_event.dart';

typedef InnerSingleEventObserverCallback = void Function<T>(T? data, Exception? exception);
typedef InnerMultiEventObserverCallback = void Function<T>(List<T>? data, Exception? exception);

/// 支持事件方式更新UI
mixin HasEventObserver<T> on GetxController {
  final List<StreamSubscription?> streamSubscriptions = [];

  @protected
  StreamSubscription onSingle<E extends InnerRefreshEvent<T>>({
    InnerSingleEventObserverCallback? onInit,
    InnerSingleEventObserverCallback? onLoading,
    InnerSingleEventObserverCallback? onSuccess,
    InnerSingleEventObserverCallback? onFail,
    Function? onError,
  }) {
    StreamSubscription ss = XEventBus().subscribeAutoCancelOnError<E>((E event) {
      switch (event.state) {
        case EventState.init:
          onInit?.call(event.data, event.exception);
          break;
        case EventState.loading:
          onLoading?.call(event.data, event.exception);
          break;
        case EventState.success:
          onSuccess?.call(event.data, event.exception);
          break;
        case EventState.fail:
          onFail?.call(event.data, event.exception);
          break;
      }
    }, onError: onError);

    streamSubscriptions.add(ss);
    return ss;
  }

  @protected
  StreamSubscription onMulti<E extends InnerRefreshEvents<T>>({
    InnerMultiEventObserverCallback? onInit,
    InnerMultiEventObserverCallback? onLoading,
    InnerMultiEventObserverCallback? onSuccess,
    InnerMultiEventObserverCallback? onFail,
    Function? onError,
  }) {
    StreamSubscription ss = XEventBus().subscribeAutoCancelOnError<E>((E event) {
      switch (event.state) {
        case EventState.init:
          onInit?.call(event.data, event.exception);
          break;
        case EventState.loading:
          onLoading?.call(event.data, event.exception);
          break;
        case EventState.success:
          onSuccess?.call(event.data, event.exception);
          break;
        case EventState.fail:
          onFail?.call(event.data, event.exception);
          break;
      }
    }, onError: onError);

    streamSubscriptions.add(ss);
    return ss;
  }

  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    for (var ss in streamSubscriptions) {
      ss?.cancel();
    }
  }
}
