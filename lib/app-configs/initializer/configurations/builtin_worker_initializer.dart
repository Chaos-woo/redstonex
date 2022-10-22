import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/commons/functions/basic-functions/app_package_helper.dart';
import 'package:redstonex/commons/functions/basic-functions/directory_helper.dart';
import 'package:redstonex/commons/functions/basic-functions/mobile_device_helper.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/post_construct.dart';
import 'package:redstonex/ioc-core/metadata-core/component.dart';
import 'package:redstonex/local-storage-core/memory_cache_get.dart';
import 'package:redstonex/local-storage-core/persist_cache_get.dart';

@Component()
class BuiltinWorkerInitializer {
  /// Using application container initialize point
  /// to do something.
  @PostConstruct()
  Future<void> initialize() async {
    /// init device and app package information
    await _initDevicePackageCollector();

    /// init get storage key-value data for [GlobalConfig]
    await _initGetStorage();
  }

  /// initialize basic functions
  Future<void> _initDevicePackageCollector() async {
    await MobileDeviceHelper.init();
    await AppPackageHelper.init();
    await DirectoryHelper.init();
  }

  /// initialize third package
  Future<void> _initGetStorage() async {
    GlobalConfig global = GlobalConfig.of();
    if (global.globalAppConfigs.enableMemoryCache) {
      await MCG.of().init();
    }

    if (global.globalAppConfigs.enableLocalPersistCache) {
      await PCG.of().init();
    }
  }
}
