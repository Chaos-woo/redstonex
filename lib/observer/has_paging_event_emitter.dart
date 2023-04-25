import 'package:flutter/foundation.dart';
import 'package:redstonex/events/redstonex_event_bus.dart';
import 'package:redstonex/observer/refresh_list_event.dart';

/// 支持事件方式更新UI
mixin HasEventPagingEmitter {

  @protected
  void emitPagingEvent<T extends ListRefreshableEvent>(T event) async {
    await XEventBus().fire(event);
  }
}
