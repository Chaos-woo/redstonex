import 'package:redstonex/app-configs/user-configs/global_app_configs.dart';
import 'package:redstonex/app-configs/user-configs/global_database_configs.dart';
import 'package:redstonex/app-configs/user-configs/global_http_option_configs.dart';
import 'package:redstonex/extension/my_getx_extension.dart';
import 'package:redstonex/paging/utils/provides.dart';

/// 全局配置
class GlobalConfig {
  static const String _globalConfigTag = '&globalConfigTag';

  static GlobalConfig get instance => xDeps_.of<GlobalConfig>(tag: _globalConfigTag);

  static initial() {
    XProvides().provide(GlobalConfig(), tag: _globalConfigTag);
  }

  static replaceDefaultGlobalConfig(GlobalConfig targetConfig) {
    XProvides().replace(targetConfig, tag: _globalConfigTag);
  }

  /// debug模式
  bool get debugMode => false;

  /// app全局配置
  GlobalAppConfigs get globalAppConfigs => GlobalAppConfigs();

  /// http全局配置
  GlobalHttpOptionConfigs get globalHttpOptionConfigs => GlobalHttpOptionConfigs();

  /// 本地数据库配置
  GlobalDatabaseConfigs get globalDatabaseConfigs => GlobalDatabaseConfigs();
}

extension GlobalConfigExtension on GlobalConfig {
  T as<T>() => this as T;
}

extension GlobalAppConfigsExtension on GlobalAppConfigs {
  T as<T>() => this as T;
}

extension GlobalHttpOptionConfigsExtension on GlobalHttpOptionConfigs {
  T as<T>() => this as T;
}

extension GlobalDatabaseConfigsExtension on GlobalDatabaseConfigs {
  T as<T>() => this as T;
}
