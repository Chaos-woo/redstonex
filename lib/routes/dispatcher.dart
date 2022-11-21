import 'package:get/get.dart';
import 'package:redstonex/routes/router.dart';
import 'package:redstonex/utils/id_utils.dart';

/// A initial quickly GetX routes of [GetPage] class.
///
/// Help generate [GetPage]s.
///
/// Because [Dispatcher] implements [Initializer], so, mapping any
/// route in this initializer, then registering it to [SingletonInitializerManager],
/// and then auto initial all routes.
class Dispatcher {
  /// all routes of app. [GetMaterialApp.getPages] can use this after initial
  static final List<GetPage> pageRoutes = [];

  /// maybe group by business-related, or irrelevant, just in the same group
  static final List<RouterGroup> routeGroups = [];

  /// remainder routes
  static final RouterGroup otherRouteGroup = RouterGroup('other');

  /// routes statistics
  static final RoutesStatistics statistics = RoutesStatistics();

  /// Get a [RouterGroup] to organize routes
  static RouterGroup group({String? groupName}) {
    RouterGroup group = RouterGroup(groupName ?? IdUtils.uuidV4());
    routeGroups.add(group);
    statistics.routeGroupCount++;
    return group;
  }

  /// Adding route in [otherRouteGroup] directly
  static void route(Router route) {
    otherRouteGroup.newRoute(route);
    statistics.routeCount++;
  }

  /// Initial [routeGroups]'s routes and [otherRouteGroup]
  /// to generate all [GetPage], then can use [pageRoutes].
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

  /// Get new [GetPage] route according to [Router]
  static GetPage _newPageRoute(Router route) {
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
