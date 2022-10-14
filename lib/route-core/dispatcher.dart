import 'package:get/get.dart';
import 'package:redstonex/commons/utils/ids_utils.dart';
import 'package:redstonex/ioc-core/metadata-core/component.dart';
import 'package:redstonex/route-core/routes.dart';

/// A initial quickly GetX routes of [GetPage] class.
///
/// Help generate [GetPage]s.
///
/// Because [Dispatcher] implements [Initializer], so, mapping any
/// route in this initializer, then registering it to [SingletonInitializerManager],
/// and then auto initial all routes.
@Component()
class Dispatcher {
  /// all routes of app. [GetMaterialApp.getPages] can use this after initial
  static final List<GetPage> pageRoutes = [];

  /// maybe group by business-related, or irrelevant, just in the same group
  static final List<RouteGroup> routeGroups = [];

  /// remainder routes
  static final RouteGroup otherRouteGroup = RouteGroup('other');

  /// routes statistics
  static final RoutesStatistics statistics = RoutesStatistics();

  /// Get a [RouteGroup] to organize routes
  RouteGroup group({String? groupName}) {
    RouteGroup group = RouteGroup(groupName ?? IdsUtil.uuidV4());
    routeGroups.add(group);
    statistics.routeGroupCount++;
    return group;
  }

  /// Adding route in [otherRouteGroup] directly
  void route(Route route) {
    otherRouteGroup.newRoute(route);
    statistics.routeCount++;
  }

  /// Initial [routeGroups]'s routes and [otherRouteGroup]
  /// to generate all [GetPage], then can use [pageRoutes].
  void init() {
    if (statistics.initial) {
      return;
    }

    for (RouteGroup group in routeGroups) {
      for (Route route in group.routes) {
        pageRoutes.add(_newPageRoute(route));
      }
    }

    if (otherRouteGroup.routes.isNotEmpty) {
      statistics.routeGroupCount++;
      statistics.routeCount += otherRouteGroup.routes.length;
      for (Route route in otherRouteGroup.routes) {
        pageRoutes.add(_newPageRoute(route));
      }
    }

    statistics.initial = true;
  }

  /// Get new [GetPage] route according to [Route]
  GetPage _newPageRoute(Route route) {
    return GetPage(
      name: route.routeName,
      page: route.pageBuilder,
      binding: route.bindings,
      transition: route.transition,
      transitionDuration: route.transitionDuration,
    );
  }
}

/// A singleton Initial statistics information.
class RoutesStatistics {
  /// initial state
  bool initial = false;

  /// route group count
  int routeGroupCount = 0;

  /// route count
  int routeCount = 0;
}
