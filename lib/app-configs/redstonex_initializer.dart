
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/object-storage/memory_cache_get.dart';
import 'package:redstonex/object-storage/persist_cache_get.dart';
import 'package:redstonex/routes/dispatcher.dart';
import 'package:redstonex/utils/app_package_util.dart';
import 'package:redstonex/utils/device_utils.dart';
import 'package:redstonex/utils/directory_utils.dart';
import 'package:redstonex/utils/log_utils.dart';

class RsxInit {
  /// 框架初始化
  static void init(Function() preBuiltinInit, Function() postBuiltinInit) {
    preBuiltinInit();
    _builtinInit();
    postBuiltinInit();
  }

  static void _builtinInit() {
    /// 初始化日志工具
    LogUtils.init();
    /// 初始化全局配置
    GlobalConfig.initDefGlobalConfig();
    /// 初始化设备信息
    DeviceUtils.initDeviceInfo();
    /// 初始化app信息
    AppPackageUtils.init();
    /// 初始化存储信息
    DirectoryUtils.init();
    /// 初始化内存缓存
    Mcg().initMemoryCache();
    /// 初始化本地缓存
    Pcg().initPersistCache();
    /// 初始化路由
    Dispatcher.init();
  }

}