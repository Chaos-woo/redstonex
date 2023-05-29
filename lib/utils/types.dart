class rType {
  static final rType _single = rType._internal();

  rType._internal();

  factory rType() => _single;

  bool isBaseType(dynamic data) {
    return data.runtimeType is String ||
        data.runtimeType is double ||
        data.runtimeType is bool ||
        data.runtimeType is int;
  }

  Type typeAs<T>() => T;
}
