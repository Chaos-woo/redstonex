/// Built-in loading event type.
///
/// Notice all subscriber http loading event.
enum BuiltinLoadingEventType { request, error, ok }

/// Built-in loading event.
///
class BuiltinLoadingEvent {
  /// current event type
  final BuiltinLoadingEventType type;

  /// publish timestamp
  final int timestamp;

  BuiltinLoadingEvent(this.type) : timestamp = DateTime.now().millisecondsSinceEpoch;
}
