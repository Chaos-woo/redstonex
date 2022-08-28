import 'package:redstonex/app-configs/initial/basic-functions/built_in_func_initializer.dart';
import 'package:redstonex/app-configs/initial/initializer.dart';
import 'package:redstonex/app-configs/initial/singleton/built_in_singleton_initializer.dart';
import 'package:redstonex/commons/log/built_in_logger_initializer.dart';

/// A built in initializer manager.
///
/// All built in initializer will put in this list,
/// external can starting from [initBuiltInInitializer] method,
/// initialize the internal data of the framework
class BuiltInInitializerManager {
  final List<Initializer> _initializers = [
    BuiltInLoggerInitializer(),
    BuiltInFuncInitializer(),
    BuiltInSingletonInitializer(),
  ];

  /// Need call this method first for [main]
  void initBuiltInInitializer() {
    for (Initializer initializer in _initializers) {
      initializer.init();
    }
  }
}
