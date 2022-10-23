import 'package:get/get.dart';
import 'package:redstonex/utils/unique_utils.dart';
import 'package:redstonex/ioc-core/metadata-core/component.dart';
import 'package:redstonex/route-core/route_holder.dart';

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
  static final List<RouteGroupHolder> routeGroups = [];

  /// remainder routes
  static final RouteGroupHolder otherRouteGroup = RouteGroupHolder('other');

  /// routes statistics
  static final RoutesStatistics statistics = RoutesStatistics();

  /// Get a [RouteGroupHolder] to organize routes
  RouteGroupHolder group({String? groupName}) {
    RouteGroupHolder group = RouteGroupHolder(groupName ?? UniqueUtils.uuidV4());
    routeGroups.add(group);
    statistics.routeGroupCount++;
    return group;
  }

  /// Adding route in [otherRouteGroup] directly
  void route(RouteHolder route) {
    otherRouteGroup.newRoute(route);
    statistics.routeCount++;
  }

  /// Initial [routeGroups]'s routes and [otherRouteGroup]
  /// to generate all [GetPage], then can use [pageRoutes].
  void init() {
    if (statistics.initial) {
      return;
    }

    for (RouteGroupHolder group in routeGroups) {
      for (RouteHolder route in group.routes) {
        pageRoutes.add(_newPageRoute(route));
      }
    }

    if (otherRouteGroup.routes.isNotEmpty) {
      statistics.routeGroupCount++;
      statistics.routeCount += otherRouteGroup.routes.length;
      for (RouteHolder route in otherRouteGroup.routes) {
        pageRoutes.add(_newPageRoute(route));
      }
    }

    statistics.initial = true;
  }

  /// Get new [GetPage] route according to [RouteHolder]
  GetPage _newPageRoute(RouteHolder route) {
    return GetPage(
      name: route.routeName,
      page: route.pageBuilder,
      binding: route.binding,
      bindings: route.bindings,
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
