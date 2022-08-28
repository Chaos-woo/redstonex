import 'package:get/get.dart';

/// A named navigation of GetX route.
///
/// [Route]'s properties are a main subset of [GetPage].
class Route {
  String routeName;
  GetPageBuilder pageBuilder;
  Bindings? bindings;
  Transition? transition;
  Duration? transitionDuration;

  Route(
    this.routeName,
    this.pageBuilder, {
    this.bindings,
    this.transition,
    this.transitionDuration,
  });

  /// Set binding for this route
  void binding(Bindings binding) => bindings = binding;
}

/// A named navigation of GetX route group.
///
/// Better organize business-related routes.
class RouteGroup {
  final String name;
  final List<Route> routes = [];

  RouteGroup(this.name);

  void add(Route route) => routes.add(route);
}
