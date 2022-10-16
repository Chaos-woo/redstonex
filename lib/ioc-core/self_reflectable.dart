import 'package:redstonex/app-configs/initializer/properties/def_global_config_initializer.dart';
import 'package:redstonex/ioc-core/metadata-core/component.dart';
import 'package:redstonex/ioc-core/metadata-core/components_configuration.dart';
import 'package:redstonex/ioc-core/self_container.dart';
import 'package:reflectable/reflectable.dart';

///
/// Enable `reflectable`:
//    1. must in `main` method and first line
//    2. using any enable reflectable 's method name, eg, `initializeReflectable()`
//    3. import reflectable package
//    4. import like 'main.reflectable.dart'
//    6. create named build.yaml like `redstonex`, and write into `main` method relative path
//    7. keep in terminal and run command `flutter packages pub run build_runner build --delete-conflicting-outputs`
//    8. output `main.reflectable.dart` file and done.
//
//  note: `reflectable` only output in `main`, so don't do in here.
///
class SelfReflectable {
  static void startSelfRegistered() {
    BuiltinReflectableConfiguration builtinConfig = BuiltinReflectableConfiguration();
    SelfContainer().initializeAppContainer(builtinConfig);
  }
}

/// Builtin definition that must initialize.
class BuiltinReflectableConfiguration {
  final List<Type> _builtinDefinitions = [];
  final List<Reflectable> _builtinReflectableMetadataList = [
    const ComponentsConfiguration(),
    const Component(),
  ];
  final List<Type> _builtinComponentsConfigHighPriorType = [
    DefGlobalConfigInitializer,
  ];

  List<Type> get builtinDefinitions => _builtinDefinitions;

  List<Reflectable> get builtinReflectableMetadataList => _builtinReflectableMetadataList;

  List<Type> get builtinHighPriorType => _builtinComponentsConfigHighPriorType;
}
