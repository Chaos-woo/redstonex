import 'package:redstonex/utils/types.dart';

class rRawData {
  dynamic value;

  /// 反序列化为T类型数据，存在反序列化器时返回对象
  T objectAs<T>({T Function(Map<String, dynamic>)? fromJsonConvertor}) {
    if (rType().isBaseType(T)) {
      return value as T;
    }
    return _objectItemAs<T>(value, fromJsonConvertor: fromJsonConvertor);
  }

  /// 反序列化为T类型数据数组，存在反序列化器时返回对象数组
  List<T> listAs<T>({T Function(Map<String, dynamic>)? fromJsonConvertor}) {
    List<dynamic> list = value as List<dynamic>;
    if (rType().isBaseType(T)) {
      return list.map((item) => item as T).toList();
    }

    return list.map((item) => _objectItemAs<T>(item, fromJsonConvertor: fromJsonConvertor)).toList();
  }

  /// 依据是否存在返回序列化器处理反序列化数据
  T _objectItemAs<T>(dynamic item, {T Function(Map<String, dynamic>)? fromJsonConvertor}) {
    return null != fromJsonConvertor ? fromJsonConvertor.call((item as Map<String, dynamic>)) : item as T;
  }

  /// 反序列化为KV键值对
  Map<String, dynamic> mapAs() {
    return value as Map<String, dynamic>;
  }
}
