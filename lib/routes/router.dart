import 'package:get/get.dart';

/// 路由对象
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

/// 命名路由组
class RouterGroup {
  final String name;
  final List<Router> routes = [];

  RouterGroup(this.name);

  void newRoute(Router route) => routes.add(route);
}
