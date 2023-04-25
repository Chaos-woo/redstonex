import 'package:flutter/foundation.dart';
import 'package:redstonex/events/redstonex_event_bus.dart';

/// 支持事件方式更新
mixin HasEventEmitter {

  @protected
  void emitEvent<T>(T event) async {
    await XEventBus().fire(event);
  }
}
