import 'package:get/get.dart';
import 'package:redstonex/routes/router.dart';
import 'package:redstonex/utils/id_utils.dart';

/// 页面路由辅助生成工具
///
/// 使用[group]、[route]添加路由后，框架初始化时自动调用
/// [init]方法初始化页面路由，即可通过[Dispatcher.pageRoutes]
/// 获取GetX全部配置的路由
class Dispatcher {
  /// 全局GetX页面路由
  static final List<GetPage> pageRoutes = [];

  /// 路由组列表
  static final List<RouterGroup> routeGroups = [];

  /// 单独处理的路由组
  static final RouterGroup otherRouteGroup = RouterGroup('other');

  /// 路由统计
  static final RoutesStatistics statistics = RoutesStatistics();

  /// 获取路由组
  static RouterGroup group({String? groupName}) {
    RouterGroup group = RouterGroup(groupName ?? IdUtils.uuidV4());
    routeGroups.add(group);
    statistics.routeGroupCount++;
    return group;
  }

  /// 添加单个路由
  static void route(Router route) {
    otherRouteGroup.newRoute(route);
    statistics.routeCount++;
  }

  /// 初始化路由，并生成GetX页面路由
  static void init() {
    if (statistics.initial) {
      return;
    }

    for (RouterGroup group in routeGroups) {
      for (Router route in group.routes) {
        pageRoutes.add(_newPageRoute(route));
      }
    }

    if (otherRouteGroup.routes.isNotEmpty) {
      statistics.routeGroupCount++;
      statistics.routeCount += otherRouteGroup.routes.length;
      for (Router route in otherRouteGroup.routes) {
        pageRoutes.add(_newPageRoute(route));
      }
    }

    statistics.initial = true;
  }

  /// 创建GetX页面路由
  static GetPage _newPageRoute(Router route) {
    return GetPage(
      name: route.routeName,
      page: route.pageBuilder,
      binding: route.binding,
      bindings: route.bindings,
      transition: route.transition,
      transitionDuration: route.transitionDuration,
      customTransition: route.customTransition,
    );
  }
}

/// 路由统计
class RoutesStatistics {
  /// 是否初始化
  bool initial = false;

  /// 路由组数量
  int routeGroupCount = 0;

  /// 路由数量
  int routeCount = 0;
}
