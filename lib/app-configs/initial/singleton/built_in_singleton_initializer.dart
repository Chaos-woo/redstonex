import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/app-configs/initial/singleton/singleton_initializer.dart';
import 'package:redstonex/commons/utils/reference_utils.dart';

///
/// Built in singleton initializer.
///
/// In order to initial some necessary bean for
/// normal using of app or other basic functions.
///
class BuiltInSingletonInitializer extends SingletonInitializer {
  @override
  void initSingletons() {
    /// default global configuration
    ReferenceUtils.put(GlobalConfig(), tag: GlobalConfig.fixedGlobalConfigTag);
  }
}
