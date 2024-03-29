import 'package:get/get.dart';

/// A GetX route, navigation utils.
///
/// In order to semantic.
class rRouter {
  static Future<R?>? push<R>(String route, {dynamic arguments, Map<String, String>? parameters}) {
    return Get.toNamed<R>(
      route,
      arguments: arguments,
      parameters: parameters,
    );
  }

  /// Pop the current named page and pushes a new `page`
  static Future<R?>? popAndPushNamed<R>(String route, {dynamic arguments, Map<String, String>? parameters}) {
    return Get.offAndToNamed<R>(
      route,
      arguments: arguments,
      parameters: parameters,
    );
  }

  /// Push a named `page` and pop several pages in the stack
  static Future<R?>? pushNamedAndRemoveUntil<R>(String route, {dynamic arguments, Map<String, String>? parameters}) {
    return Get.offAllNamed<R>(
      route,
      arguments: arguments,
      parameters: parameters,
    );
  }

  static void pop({dynamic result}) {
    Get.back(result: result);
  }

  /// Give current route arguments.
  ///
  /// Like [push]/[popAndPushNamed] method, can set any
  /// type arguments that like string or object, using generic
  /// type and this method will transmit and return.
  ///
  /// e.g. push("/NextScreen", arguments: 'Get is the best');
  /// ```dart
  ///   String argument = NavigationUtils.argument('arguments');
  ///   assert(argument == 'Get is the best');
  /// ```
  static T argument<T>() {
    return Get.arguments as T;
  }

  ///
  /// Get routing url parameter like web, or use Map
  /// struct to pack some properties, next page can use
  /// [parameters] method to get it.
  ///
  /// Note: only can get [String] value.
  ///
  /// e.g. /NextScreen?device=phone&id=354&name=Enzo
  /// ```dart
  ///   String name = NavigationUtils.parameters('name');
  ///   assert('Enzo' == name);
  /// ```
  ///
  static String? parameters(String name) {
    return Get.parameters[name];
  }
}

/// 路由对象
class rRoute {
  String routeName;
  GetPageBuilder pageBuilder;
  Bindings? binding;
  List<Bindings> bindings;
  Transition? transition;
  Duration? transitionDuration;
  CustomTransition? customTransition;

  rRoute(
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
class rRouteGroup {
  final String name;
  final List<rRoute> routes = [];

  rRouteGroup(this.name);

  rRouteGroup newRoute(rRoute route) {
    routes.add(route);
    return this;
  }

  void clearRoutes() {
    routes.clear();
  }
}