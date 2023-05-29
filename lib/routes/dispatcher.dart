import 'package:get/get.dart';

import '../utils/id_generator.dart';
import 'router.dart';

/// 页面路由辅助生成工具
///
/// 使用[group]、[route]添加路由后，框架初始化时自动调用
/// [initial]方法初始化页面路由，即可通过[rDispatcher.pageRoutes]
/// 获取GetX全部配置的路由
class rDispatcher {
  /// 是否初始化
  static bool routesInit = false;

  /// 全局GetX页面路由
  static final List<GetPage> pageRoutes = [];

  /// 路由组列表
  static final List<rRouteGroup> routeGroups = [];

  /// 单独处理的路由组
  static final rRouteGroup otherRouteGroup = rRouteGroup('other');

  /// 路由统计
  static final RoutesStatistics statistics = RoutesStatistics();

  /// 获取路由组
  static rRouteGroup group({String? groupName}) {
    rRouteGroup group = rRouteGroup(groupName ?? rId().uuidV4());
    routeGroups.add(group);
    statistics.routeGroupCount++;
    return group;
  }

  /// 添加单个路由
  static void route(rRoute route) {
    otherRouteGroup.newRoute(route);
    statistics.routeCount++;
  }

  /// 初始化路由，并生成GetX页面路由
  static void initial() {
    if (routesInit) {
      return;
    }
    routesInit = true;

    for (rRouteGroup group in routeGroups) {
      for (rRoute route in group.routes) {
        pageRoutes.add(_newPageRoute(route));
      }
    }

    statistics.routeGroups.addAll(routeGroups);
    routeGroups.clear();

    if (otherRouteGroup.routes.isNotEmpty) {
      statistics.routeGroupCount++;
      statistics.routeCount += otherRouteGroup.routes.length;
      for (rRoute route in otherRouteGroup.routes) {
        pageRoutes.add(_newPageRoute(route));
      }

      rRouteGroup otherRouteGroupCopy = rRouteGroup('other');
      otherRouteGroupCopy.routes.addAll(otherRouteGroup.routes);
      statistics.otherRouteGroup = otherRouteGroupCopy;
      otherRouteGroup.clearRoutes();
    }

    statistics.initial = true;
  }

  /// 创建GetX页面路由
  static GetPage _newPageRoute(rRoute route) {
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

  /// 路由组列表
  List<rRouteGroup> routeGroups = [];

  /// 单独处理的路由组
  rRouteGroup? otherRouteGroup;
}
