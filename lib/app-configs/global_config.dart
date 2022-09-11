import 'package:redstonex/app-configs/user-configs/global_app_configs.dart';
import 'package:redstonex/app-configs/user-configs/global_database_configs.dart';
import 'package:redstonex/app-configs/user-configs/global_http_option_configs.dart';
import 'package:redstonex/app-configs/user-configs/global_log_configs.dart';
import 'package:redstonex/commons/standards/of_syntax.dart';
import 'package:redstonex/ioc-core/reflectable-core/utils/reflections_utils.dart';

/// A global configuration.
///
/// If want to custom app global configuration, extending this
/// configuration class and override the attribute that want to
/// customize putting it in GetX bean container tagged
/// [GlobalConfig.fixedGlobalConfigTag].
///
class GlobalConfig with OfSyntax {
  static const String fixedGlobalConfigTag = 'fixedGlobalConfigTag';

  /// Get GetX bean container [GlobalConfig] instance
  static GlobalConfig of() =>
      ReflectionsUtil.find<GlobalConfig>(tag: GlobalConfig.fixedGlobalConfigTag);

  /// Get real type [GlobalConfig] instance from container
  ///
  /// note: `T` generic type must be subtype of [GlobalConfig]
  static T ofReal<T>() => of() as T;

  /// Safety put global configuration in GetX bean container.
  ///
  /// Default global configuration will put in container when built-in initialing,
  /// using the same tag replace default configuration when want to.
  static void safePutGlobalConfig(GlobalConfig customGlobalConfig) {
    if (ReflectionsUtil.existInGetX<GlobalConfig>(tag: fixedGlobalConfigTag)) {
      ReflectionsUtil.remove<GlobalConfig>(tag: fixedGlobalConfigTag);
    }

    ReflectionsUtil.put<GlobalConfig>(customGlobalConfig, tag: fixedGlobalConfigTag);
  }

  /// Current development mode whether debug mode
  bool get debugMode => false;

  /// global configuration of app
  GlobalAppConfigs get globalAppConfigs => GlobalAppConfigs();

  /// global configuration of log
  GlobalLogConfigs get globalLogConfigs => GlobalLogConfigs();

  /// global configuration of http
  GlobalHttpOptionConfigs get globalHttpOptionConfigs => GlobalHttpOptionConfigs();

  /// global configuration of database
  GlobalDatabaseConfigs get globalDatabaseConfigs=> GlobalDatabaseConfigs();
}
