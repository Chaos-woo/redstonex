

/// String 空安全处理
extension StringExtension on String? {
  String get nullSafe => this ?? '';
}