import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

import 'device_info_state.dart';

class DeviceInfoLogic extends GetxController {
  final DeviceInfoState state = DeviceInfoState();

  @override
  void onReady() {
    /// 简单模拟初始化
    initStateUpdateBuilder();
    super.onReady();
  }

  void initStateUpdateBuilder() {
    state.init();
    EasyLoading.show(status: '本地加载模拟...', maskType: EasyLoadingMaskType.black);
    DelayUtils.delayAny(() {
      EasyLoading.dismiss();
      update();
    }, duration: 2.seconds);
  }


}
