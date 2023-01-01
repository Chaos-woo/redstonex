

/// String 空安全处理
extension StringExtension on String? {
  String get nullSafe => this ?? '';

  String nullSafeDefaultVal({String? defaultVal}) {
    return this ?? defaultVal.nullSafe;
  }

  bool get nullObj {
    return null == this ? true : false;
  }

  bool get nullOrBlankObj {
    return null == this ? true : this!.isEmpty;
  }

}

extension StringExtensionGeneral on String {
  DateTime get dateTime => DateTime.parse(this);
}