
import 'package:logger/logger.dart';
import 'package:redstonex/app-configs/global_config.dart';

/// App default log configuration
class GlobalLogConfigs {
  /// default built-in logger log level
  Level get defBuiltinLogLevel => Level.info;

  /// default log level
  Level get defLogLevel => GlobalConfig.of().debugMode ? Level.debug : Level.info;
}