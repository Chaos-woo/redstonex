
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/object-storage/memory_cache_get.dart';
import 'package:redstonex/object-storage/persist_cache_get.dart';
import 'package:redstonex/routes/dispatcher.dart';
import 'package:redstonex/utils/application_package.dart';
import 'package:redstonex/utils/device.dart';
import 'package:redstonex/utils/directory.dart';
import 'package:redstonex/utils/xlog.dart';

class RsxInitializer {
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
    XLog().init();
    /// 初始化全局配置
    GlobalConfig.initDefGlobalConfig();
  }

  static Future<void> _builtinInit() async {
    /// 初始化设备信息
    await XDevice.initDeviceInfo();
    /// 初始化app信息
    await XAppPackage().init();
    /// 初始化存储信息
    await XDirectory().init();
    /// 初始化内存缓存
    await XMemoryStorage().initMemoryCache();
    /// 初始化本地缓存
    await XPersistentStorage().initPersistCache();
    /// 初始化路由
    XDispatcher.init();
  }

}