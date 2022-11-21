import 'package:get/get.dart';

/// A named navigation of GetX route.
///
/// [Router]'s properties are a main subset of [GetPage].
class Router {
  String routeName;
  GetPageBuilder pageBuilder;
  Bindings? binding;
  List<Bindings> bindings;
  Transition? transition;
  Duration? transitionDuration;

  Router(
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
class RouterGroup {
  final String name;
  final List<Router> routes = [];

  RouterGroup(this.name);

  void newRoute(Router route) => routes.add(route);
}
