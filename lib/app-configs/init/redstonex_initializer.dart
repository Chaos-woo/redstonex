import '../../object-storage/shared_persistent.dart';
import '../../routes/dispatcher.dart';
import '../../utils/application_package.dart';
import '../../utils/device.dart';
import '../../utils/directory.dart';
import '../../utils/rsxlog.dart';
import '../global_config.dart';

/// redstonex框架初始化器
class rInitializer {
  /// 框架初始化
  static Future<void> init({Function()? preBuiltinInit, Function()? postBuiltinInit}) async {
    await _primaryBuiltinInit();
    preBuiltinInit?.call();
    await _builtinInit();
    postBuiltinInit?.call();
  }

  /// 内部工具配置初始化
  static Future<void> _primaryBuiltinInit() async {
    /// 初始化日志工具
    rLog().init();

    /// 初始化全局配置
    rGlobalConfig.initial();
  }

  static Future<void> _builtinInit() async {
    /// 初始化设备信息
    await rDevice.initial();

    /// 初始化app信息
    await rApplicationPackage().initial();

    /// 初始化存储信息
    await rDirectory().initial();

    /// 初始化本地缓存
    await rShared().initial();

    /// 初始化路由
    rDispatcher.initial();
  }
}
