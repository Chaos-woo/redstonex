import 'package:get_storage/get_storage.dart';

/// 基于get_storage的内存缓存
class XMemoryStorage {
  static const String _fixed = '&rsx-mcg';
  static final GetStorage _ocs = GetStorage(_fixed);

  GetStorage? occ() => _ocs;

  static final XMemoryStorage _single = XMemoryStorage._internal();

  factory XMemoryStorage() => _single;

  XMemoryStorage._internal();

  Future<void> initMemoryCache() async {
    await GetStorage.init(_fixed);
    await _ocs.erase();
  }

  bool exist(String key) {
    return _ocs.getKeys<List<String>>().contains(key);
  }

  R? read<R>(String key) {
    return _ocs.read(key) as R;
  }

  void write<T>(String key, T value) {
    _ocs.write(key, value);
  }

  void writeIfNull<T>(String key, T value) {
    _ocs.writeIfNull(key, value);
  }

  void remove(String key) {
    _ocs.remove(key);
  }

  bool? readBool(String key) {
    return read<bool>(key);
  }

  int? readInt(String key) {
    return read<int>(key);
  }

  double? readDouble(String key) {
    return read<double>(key);
  }

  String? readString(String key) {
    return read<String>(key);
  }
}
