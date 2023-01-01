import 'package:flustars_flutter3/flustars_flutter3.dart';

/// 基于shared_preferences的本地化缓存
class Pcg {
  static final Pcg _single = Pcg._();

  factory Pcg() => _single;

  static Pcg of() => _single;

  Pcg._();

  Future<void> initPersistCache() async {
    await SpUtil.getInstance();
  }

  bool exist(String key) {
    return SpUtil.containsKey(key)!;
  }

  T? readObj<T>(String key, T Function(Map v) mapping, {T? defValue}) {
    return SpUtil.getObj<T>(key, mapping, defValue: defValue);
  }

  List<T>? readObjList<T>(String key, T Function(Map v) mapping, {List<T>? defValue}) {
    return SpUtil.getObjList<T>(key, mapping, defValue: defValue);
  }

  void writeObj<T>(String key, T value) {
    SpUtil.putObject(key, value!);
  }

  void putObjectList(String key, List<Object> list) {
    SpUtil.putObjectList(key, list);
  }

  void remove(String key) {
    SpUtil.remove(key);
  }

  bool? readBool(String key, {bool? defValue = false}) {
    return SpUtil.getBool(key, defValue: defValue);
  }

  void writeBool(String key, bool value) {
    SpUtil.putBool(key, value);
  }

  int? readInt(String key, {int? defValue}) {
    return SpUtil.getInt(key, defValue: defValue);
  }

  void writeInt(String key, int value) {
    SpUtil.putInt(key, value);
  }

  double? readDouble(String key, {double? defValue}) {
    return SpUtil.getDouble(key, defValue: defValue);
  }

  void writeDouble(String key, double value) {
    SpUtil.putDouble(key, value);
  }

  String? readString(String key, {String? defValue}) {
    return SpUtil.getString(key, defValue: defValue);
  }

  void writeString(String key, String value) {
    SpUtil.putString(key, value);
  }

  void writeStringList(String key, List<String> value) {
    SpUtil.putStringList(key, value);
  }
}
