class XType {
  static final XType _single = XType._internal();

  XType._internal();

  factory XType() => _single;

  bool isBaseType(dynamic data) {
    return data.runtimeType is String ||
        data.runtimeType is double ||
        data.runtimeType is bool ||
        data.runtimeType is int;
  }

  Type typeAs<T>() => T;
}
