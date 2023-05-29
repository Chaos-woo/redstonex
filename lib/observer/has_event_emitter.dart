import 'package:flutter/foundation.dart';

import '../events/redstonex_event_bus.dart';

/// 支持事件方式更新
mixin rHasEventEmitter {
  @protected
  void emitEvent<T>(T event) async {
    await rEventBus().fire(event);
  }
}
