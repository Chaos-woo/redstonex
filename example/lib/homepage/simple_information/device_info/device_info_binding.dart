

import 'package:example/homepage/simple_information/device_info/device_info_logic.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

class DeviceInfoBinding extends Bindings {
  @override
  void dependencies() {
    XProvides().provide(DeviceInfoLogic());
  }
}
