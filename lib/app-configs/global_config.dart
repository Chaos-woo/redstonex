import 'package:redstonex/app-configs/user-configs/global_app_configs.dart';
import 'package:redstonex/app-configs/user-configs/global_database_configs.dart';
import 'package:redstonex/app-configs/user-configs/global_http_option_configs.dart';
import 'package:redstonex/mvp/utils/depends.dart';
import 'package:redstonex/mvp/utils/provides.dart';

/// 全局配置
class GlobalConfig {
  static final GlobalConfig single = GlobalConfig();
  static const String globalConfigTag = '&globalConfigTag';

  static GlobalConfig of() => Depends.on<GlobalConfig>(tag: globalConfigTag);

  static initDefGlobalConfig() {
    Provides.provide(GlobalConfig(), tag: globalConfigTag);
  }

  static replaceDefGlobalConfig(GlobalConfig targetConfig) {
    Provides.replace(targetConfig, tag: globalConfigTag);
  }

  /// app模式
  bool get debugMode => false;

  /// app全局配置
  GlobalAppConfigs get globalAppConfigs => GlobalAppConfigs();

  /// http全局配置
  GlobalHttpOptionConfigs get globalHttpOptionConfigs => GlobalHttpOptionConfigs();

  /// 本地数据库配置
  GlobalDatabaseConfigs get globalDatabaseConfigs => GlobalDatabaseConfigs();
}
