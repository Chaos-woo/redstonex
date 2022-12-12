import 'package:get/get.dart';

import 'hot_comment_detail_logic.dart';

class HotCommentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HotCommentDetailLogic());
  }
}
