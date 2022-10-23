
import 'package:get_storage/get_storage.dart';
import 'package:redstonex/std-core/of_syntax.dart';
import 'package:redstonex/local-storage-core/definitions/object_cache.dart';

/// Persist cache by get_storage
class PCG implements ObjectCache, OfSyntax {
  /// instance of MCG
  static final PCG _mcg = PCG();

  static const String _psContainerName = 'PCG';

  static PCG of() => _mcg;

  GetStorage? _pcc;

  Future<void> init() async {
    await GetStorage.init(_psContainerName);
    _pcc = GetStorage(_psContainerName);
  }

  @override
  bool exist(String key) {
    return _pcc!.getKeys();
  }

  @override
  R? read<R>(String key) {
    return _pcc!.read(key) as R;
  }

  @override
  void write<T>(String key, T value) {
    _pcc!.write(key, value);
  }

  void writeIfNull<T>(String key, T value) {
    _pcc!.writeIfNull(key, value);
  }

  @override
  void remove(String key) {
    _pcc!.remove(key);
  }

}