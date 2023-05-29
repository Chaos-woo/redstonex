import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

import 'bili_favorite_video_logic.dart';

class BiliFavoriteVideoBinding extends Bindings {
  @override
  void dependencies() {
    rProvides().lazyProvide(() => BiliFavoriteVideoLogic());
  }
}
