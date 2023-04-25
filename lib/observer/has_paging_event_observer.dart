import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/events/redstonex_event_bus.dart';
import 'package:redstonex/observer/refresh_list_event.dart';

typedef RefreshListMultiEventObserverCallback = void Function<T>(List<T>? data, Exception? exception);

/// 支持事件方式更新UI
mixin HasEventPagingObserver<T, E extends ListRefreshableEvent<T>> on GetxController {
  final List<StreamSubscription?> _autoCancelableStreamSubscriptions = [];

  @protected
  StreamSubscription onPagingEvent({
    RefreshListMultiEventObserverCallback? onInit,
    RefreshListMultiEventObserverCallback? onLoading,
    RefreshListMultiEventObserverCallback? onSuccess,
    RefreshListMultiEventObserverCallback? onFail,
    Function? onError,
  }) {
    StreamSubscription subscription = XEventBus().subscribeAutoCancelOnError<E>((E event) {
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

    _autoCancelableStreamSubscriptions.add(subscription);
    return subscription;
  }

  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    for (var ss in _autoCancelableStreamSubscriptions) {
      ss?.cancel();
    }
  }
}
