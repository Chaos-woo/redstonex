import 'package:redstonex/ioc-core/application_container.dart';
import 'package:redstonex/ioc-core/metadata-core/reflection.dart';
import 'package:redstonex/ioc-core/metadata-core/reflection_configuration.dart';
import 'package:reflectable/reflectable.dart';

///
/// Enable `reflectable`:
//    1. must in `main` method and first line
//    2. using any enable reflectable's method name, eg, `initializeReflectable()`
//    3. import reflectable package
//    4. import like 'main.reflectable.dart'
//    6. create named build.yaml like `redstoneX`, and write into `main` method relative path
//    7. keep in terminal and run command `flutter packages pub run build_runner build --delete-conflicting-outputs`
//    8. output `main.reflectable.dart` file and done.
//
//  note: `reflectable` only output in `main`, so don't do in here.
///
class SelfReflectable {
  static void startSelfRegistered() {
    _BuiltinReflectable builtin = _BuiltinReflectable();
    ApplicationContainer().initializeAppContainer(builtin.builtinDefinitions, builtin.builtinReflectableMetadatas);

  }
}

/// Builtin definition that must initialize.
class _BuiltinReflectable {
  final List<Type> _builtinDefinitions = [];
  final List<Reflectable> _builtinReflectableMetadatas = [const Reflection(), const  RefsConfiguration()];

  List<Type> get builtinDefinitions => _builtinDefinitions;

  List<Reflectable> get builtinReflectableMetadatas => _builtinReflectableMetadatas;
}
