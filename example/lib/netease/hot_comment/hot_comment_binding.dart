import 'package:get/get.dart';

import 'hot_comment_logic.dart';

class HotCommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HotCommentLogic());
  }
}
