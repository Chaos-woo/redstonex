
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:redstonex/local-storage-core/definitions/object_cache.dart';
import 'package:redstonex/std-core/of_syntax.dart';

/// Persist cache by get_storage
class PCG implements ObjectCache, OfSyntax {
  /// instance of MCG
  static final PCG _pcg = PCG();

  static PCG of() => _pcg;

  static Future<void> init() async {
    await SpUtil.getInstance();
  }

  @override
  bool exist(String key) {
    bool? notEmpty = SpUtil.getKeys()?.isNotEmpty;
    return notEmpty != null && notEmpty && SpUtil.getKeys()!.contains(key);
  }

  @override
  R? read<R>(String key) {
    return SpUtil.getObj<R>(key, (v) => null as R);
  }

  @override
  void write<T>(String key, T value) {
    SpUtil.putObject(key, value!);
  }

  void writeIfNull<T>(String key, T value) {
    if (!exist(key)) {
      write(key, value);
    }
  }

  @override
  void remove(String key) {
    SpUtil.remove(key);
  }
}
