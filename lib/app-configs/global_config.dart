import '../extension/my_getx_extension.dart';
import '../paging/utils/provides.dart';
import 'user-configs/global_app_configs.dart';
import 'user-configs/global_database_configs.dart';
import 'user-configs/global_http_option_configs.dart';

/// 应用全局配置
class rGlobalConfig {
  static const String _globalConfigTag = '&rGlobalConfig';

  static rGlobalConfig get instance => rDeps_.of<rGlobalConfig>(tag: _globalConfigTag);

  static initial() {
    rProvides().provide(rGlobalConfig(), tag: _globalConfigTag);
  }

  static replaceDefaultGlobalConfig(rGlobalConfig targetConfig) {
    rProvides().replace(targetConfig, tag: _globalConfigTag);
  }

  /// debug模式
  bool get debugMode => false;

  /// app全局配置
  rGlobalAppConfigs get globalAppConfigs => rGlobalAppConfigs();

  /// http全局配置
  rGlobalHttpOptionConfigs get globalHttpOptionConfigs => rGlobalHttpOptionConfigs();

  /// 本地数据库配置
  rGlobalDatabaseConfigs get globalDatabaseConfigs => rGlobalDatabaseConfigs();
}

extension GlobalConfigExtension on rGlobalConfig {
  T as<T>() => this as T;
}

extension GlobalAppConfigsExtension on rGlobalAppConfigs {
  T as<T>() => this as T;
}

extension GlobalHttpOptionConfigsExtension on rGlobalHttpOptionConfigs {
  T as<T>() => this as T;
}

extension GlobalDatabaseConfigsExtension on rGlobalDatabaseConfigs {
  T as<T>() => this as T;
}
