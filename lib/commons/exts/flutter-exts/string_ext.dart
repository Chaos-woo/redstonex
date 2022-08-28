
/// Extension for dart String
///
extension StringExt on String {
  /// parse datetime string
  DateTime get dateTime => DateTime.parse(this);
}