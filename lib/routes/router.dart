import 'package:get/get.dart';

/// 路由对象
class Router {
  String routeName;
  GetPageBuilder pageBuilder;
  Bindings? binding;
  List<Bindings> bindings;
  Transition? transition;
  Duration? transitionDuration;
  CustomTransition? customTransition;

  Router(
    this.routeName,
    this.pageBuilder, {
    this.binding,
    this.bindings = const [],
    this.transition,
    this.transitionDuration,
    this.customTransition,
  });
}

/// 命名路由组
class RouterGroup {
  final String name;
  final List<Router> routes = [];

  RouterGroup(this.name);

  RouterGroup newRoute(Router route) {
    routes.add(route);
    return this;
  }
}
