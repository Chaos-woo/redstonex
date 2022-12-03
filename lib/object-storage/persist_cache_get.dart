import 'package:flustars_flutter3/flustars_flutter3.dart';

/// 基于shared_preferences的本地化缓存
class Pcg {
  static final Pcg _pcg = Pcg._();

  factory Pcg() => _pcg;

  Pcg._();

  Future<void> initPersistCache() async {
    await SpUtil.getInstance();
  }

  bool exist(String key) {
    return SpUtil.containsKey(key)!;
  }

  R? readObj<R>(String key, R Function(Map v) mapping) {
    return SpUtil.getObj<R>(key, mapping);
  }

  List<R>? readObjList<R>(String key, R Function(Map v) mapping) {
    return SpUtil.getObjList<R>(key, mapping);
  }

  void writeObj<T>(String key, T value) {
    SpUtil.putObject(key, value!);
  }

  void remove(String key) {
    SpUtil.remove(key);
  }

  bool? readBool(String key) {
    return SpUtil.getBool(key);
  }

  void writeBool(String key, bool value) {
    SpUtil.putBool(key, value);
  }

  int? readInt(String key) {
    return SpUtil.getInt(key);
  }

  void writeInt(String key, int value) {
    SpUtil.putInt(key, value);
  }

  double? readDouble(String key) {
    return SpUtil.getDouble(key);
  }

  void writeDouble(String key, double value) {
    SpUtil.putDouble(key, value);
  }

  String? readString(String key) {
    return SpUtil.getString(key);
  }

  void writeString(String key, String value) {
    SpUtil.putString(key, value);
  }

  void writeStringList(String key, List<String> value) {
    SpUtil.putStringList(key, value);
  }
}
