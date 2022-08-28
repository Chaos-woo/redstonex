import 'package:redstonex/app-configs/initial/initializer.dart';
import 'package:redstonex/commons/functions/basic-functions/device_func.dart';
import 'package:redstonex/commons/functions/basic-functions/directory_func.dart';
import 'package:redstonex/commons/functions/basic-functions/package_func.dart';

/// BuiltIn function initializer.
class BuiltInFuncInitializer extends Initializer {
  @override
  void init() async {
    /// basic functions initial
    await DeviceFunc.init();
    await PackageFunc.init();
    await DirectoryFunc.init();

    ///
  }
}
