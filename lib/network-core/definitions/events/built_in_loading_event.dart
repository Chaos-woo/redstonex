/// Built-in loading event type.
///
/// Notice all subscriber http loading event.
enum BuiltInLoadingEventType { request, error, ok }

/// Built-in loading event.
///
class BuiltInLoadingEvent {
  /// current event type
  final BuiltInLoadingEventType type;

  /// publish timestamp
  final int timestamp;

  BuiltInLoadingEvent(this.type) : timestamp = DateTime.now().millisecondsSinceEpoch;
}
