import 'package:get/get.dart';

/// A named navigation of GetX route.
///
/// [RouteHolder]'s properties are a main subset of [GetPage].
class RouteHolder {
  String routeName;
  GetPageBuilder pageBuilder;
  Bindings? binding;
  List<Bindings> bindings;
  Transition? transition;
  Duration? transitionDuration;

  RouteHolder(
    this.routeName,
    this.pageBuilder, {
    this.binding,
    this.bindings = const [],
    this.transition,
    this.transitionDuration,
  });
}

/// A named navigation of GetX route group.
///
/// Better organize business-related routes.
class RouteGroupHolder {
  final String name;
  final List<RouteHolder> routes = [];

  RouteGroupHolder(this.name);

  void newRoute(RouteHolder route) => routes.add(route);
}
