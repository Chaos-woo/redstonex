import 'package:redstonex/utils/types.dart';

class RawData {
  dynamic value;

  T objectAs<T>({T Function(Map<String, dynamic>)? fromJsonConvertor}) {
    if (XType().isBaseType(T)) {
      return value as T;
    }
    return _objectItemAs<T>(value, fromJsonConvertor: fromJsonConvertor);
  }

  List<T> listAs<T>({T Function(Map<String, dynamic>)? fromJsonConvertor}) {
    List<dynamic> list = value as List<dynamic>;
    if (XType().isBaseType(T)) {
      return list.map((item) => item as T).toList();
    }

    return list.map((item) => _objectItemAs<T>(item, fromJsonConvertor: fromJsonConvertor)).toList();
  }

  T _objectItemAs<T>(dynamic item, {T Function(Map<String, dynamic>)? fromJsonConvertor}) {
    return null != fromJsonConvertor ? fromJsonConvertor.call((item as Map<String, dynamic>)) : item as T;
  }

  Map<String, dynamic> mapAs() {
    return value as Map<String, dynamic>;
  }
}
