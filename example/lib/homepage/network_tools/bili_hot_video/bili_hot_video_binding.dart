import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

import 'bili_hot_video_logic.dart';

class BiliHotVideoBinding extends Bindings {
  @override
  void dependencies() {
    XProvides().lazyProvide(() => BiliHotVideoLogic());
  }
}
