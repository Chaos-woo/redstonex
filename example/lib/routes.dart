import 'package:example/netease/hot_comment/hot_comment_binding.dart';
import 'package:example/netease/hot_comment/hot_comment_view.dart';
import 'package:example/netease/hot_comment_detail/hot_comment_detail_binding.dart';
import 'package:example/netease/hot_comment_detail/hot_comment_detail_view.dart';
import 'package:redstonex/routes/dispatcher.dart';
import 'package:redstonex/routes/router.dart';

class Routes {
  /// 业务路由初始化工具
  static void initGlobalRoutes() {
    RouterGroup neteaseGroup = Dispatcher.group(groupName: 'netease');
    neteaseGroup
        .newRoute(Router(Route.netease.hotComments, () => HotCommentPage(), binding: HotCommentBinding()))
        .newRoute(Router(Route.netease.hotCommentDetail, () => HotCommentDetailPage(), binding: HotCommentDetailBinding()));
  }
}

class Route {
  /// 路由业务分类
  static Netease netease = Netease();
}

/// 网易云业务路由
class Netease {
  String hotComments = '/netease/hotComments';
  String hotCommentDetail = '/netease/hotComments/detail';
}
