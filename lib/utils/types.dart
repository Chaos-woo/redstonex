class XType {
  static final XType _single = XType._internal();

  XType._internal();

  factory XType() => _single;

  bool isBaseType(dynamic data) {
    return data is String || data is double || data is bool || data is int;
  }

  Type typeAs<T>() => T;
}
