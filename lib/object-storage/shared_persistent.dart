import 'dart:convert';

import 'package:flustars_flutter3/flustars_flutter3.dart';

/// 基于shared_preferences的本地化缓存
class XShared {
  static final XShared _single = XShared._internal();

  factory XShared() => _single;

  XShared._internal();

  Future<void> initial() async {
    await SpUtil.getInstance();
  }

  bool exist(String key) {
    return SpUtil.containsKey(key)!;
  }

  void remove(String key) {
    SpUtil.remove(key);
  }

  T? getObj<T>(String key, T Function(Map v) mapping, {T? defValue}) {
    return SpUtil.getObj<T>(key, mapping, defValue: defValue);
  }

  List<T>? getObjList<T>(String key, T Function(Map v) mapping, {List<T>? defValue}) {
    return SpUtil.getObjList<T>(key, mapping, defValue: defValue);
  }

  bool? getBool(String key, {bool? defValue = false}) {
    return SpUtil.getBool(key, defValue: defValue);
  }

  int? getInt(String key, {int? defValue}) {
    return SpUtil.getInt(key, defValue: defValue);
  }

  double? getDouble(String key, {double? defValue}) {
    return SpUtil.getDouble(key, defValue: defValue);
  }

  String? getString(String key, {String? defValue}) {
    return SpUtil.getString(key, defValue: defValue);
  }

  List<T>? _getBaseTypeList<T>(String key) {
    if (!exist(key)) {
      return null;
    }

    List<T> list = [];
    for (String value in SpUtil.getStringList(key)!) {
      if (T == int) {
        (list as List<int>).add(int.parse(value));
      } else if (T == double) {
        (list as List<double>).add(double.parse(value));
      } else if (T == Map) {
        (list as List<Map>).add((json.decode(value) as Map<dynamic, dynamic>));
      } else {
        (list as List<String>).add(value);
      }
    }
    return list;
  }

  List<int>? getIntList(String key) {
    return _getBaseTypeList<int>(key);
  }

  List<double>? getDoubleList(String key) {
    return _getBaseTypeList<double>(key);
  }

  List<String>? getStringList(String key) {
    return _getBaseTypeList<String>(key);
  }

  List<Map<dynamic, dynamic>>? getMapList(String key) {
    return _getBaseTypeList<Map>(key);
  }

  void putInt(String key, int value) {
    SpUtil.putInt(key, value);
  }

  void putDouble(String key, double value) {
    SpUtil.putDouble(key, value);
  }

  void putString(String key, String value) {
    SpUtil.putString(key, value);
  }

  void putStringList(String key, List<String> value) {
    SpUtil.putStringList(key, value);
  }

  void putObj<T>(String key, T value) {
    SpUtil.putObject(key, value!);
  }

  void putObjectList(String key, List<Object> list) {
    SpUtil.putObjectList(key, list);
  }

  void putBool(String key, bool value) {
    SpUtil.putBool(key, value);
  }
}
