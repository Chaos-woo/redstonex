import 'package:flutter/foundation.dart';
import 'package:redstonex/events/redstonex_event_bus.dart';
import 'package:redstonex/observer/inner_refresh_event.dart';

/// 支持事件方式更新UI
mixin HasEventEmitter {
  @protected
  void emitSingle<T extends InnerRefreshEvent>(T event) async {
    event.refresh();
    await XEventBus().fire(event);
  }

  @protected
  void emitMulti<T extends InnerRefreshEvents>(T event) async {
    event.refresh();
    await XEventBus().fire(event);
  }
}
