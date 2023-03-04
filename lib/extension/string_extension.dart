

/// String 空安全处理
extension ExtString on String? {
  String get safeNull => this ?? '';

  String safeNullWithValue({String? defaultVal}) {
    return this ?? defaultVal.safeNull;
  }

  bool get oNull {
    return null == this ? true : false;
  }

  bool get oNullOrBlank {
    return null == this ? true : this!.isEmpty;
  }

}

extension ExtStringGeneral on String {
  DateTime get parseDateTime => DateTime.parse(this);
}