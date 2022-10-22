
import 'package:get_storage/get_storage.dart';
import 'package:redstonex/commons/standards/of_syntax.dart';
import 'package:redstonex/local-storage-core/definitions/object_cache.dart';

/// Memory cache by get_storage
class MCG implements ObjectCache, OfSyntax {
  /// instance of MCG
  static final MCG _mcg = MCG();

  static const String _gsContainerName = 'MCG';

  static MCG of() => _mcg;

  GetStorage? _occ;

  Future<void> init() async {
    await GetStorage.init(_gsContainerName);
    _occ = GetStorage(_gsContainerName);
    await _occ!.erase();
  }

  @override
  bool exist(String key) {
    return _occ!.getKeys();
  }

  @override
  R? read<R>(String key) {
    return _occ!.read(key) as R;
  }

  @override
  void write<T>(String key, T value) {
    _occ!.write(key, value);
  }

  void writeIfNull<T>(String key, T value) {
    _occ!.writeIfNull(key, value);
  }

  @override
  void remove(String key) {
    _occ!.remove(key);
  }

}