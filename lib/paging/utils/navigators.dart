import 'package:redstonex/routes/router.dart';

/// 导航快捷方式
class XNavigator {
  static final XNavigator _single = XNavigator._internal();

  XNavigator._internal();

  factory XNavigator() => _single;

  /// 跳转新路由
  Future<R?>? to<R>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return XRouter.push<R>(
      route,
      arguments: arguments,
      parameters: parameters,
    );
  }

  /// 弹出当前路由，并跳转新路由
  Future<R?>? toNewPageAndRemoveCurrentPage<R>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return XRouter.popAndPushNamed<R>(
      route,
      arguments: arguments,
      parameters: parameters,
    );
  }

  /// 弹出所有历史路由，并跳转新路由
  Future<R?>? toNewPageAndRemoveAllOlderPage<R>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return XRouter.pushNamedAndRemoveUntil<R>(
      route,
      arguments: arguments,
      parameters: parameters,
    );
  }

  /// 弹出当前路由，返回至历史路由栈顶
  void back({dynamic result}) {
    XRouter.pop(result: result);
  }

  /// 获取路由中的参数
  ///
  /// Like [to]/[toNewPageAndRemoveAllOlderPage] method, can set any
  /// type arguments that like string or object, using generic
  /// type and this method will transmit and return.
  ///
  /// e.g. push("/NextScreen", arguments: 'Get is the best');
  /// ```dart
  ///   String argument = Navigators.routeArgument('arguments');
  ///   assert(argument == 'Get is the best');
  /// ```
  T routeArgument<T>() {
    return XRouter.argument<T>();
  }

  ///
  /// Get routing url parameter like web, or use Map
  /// struct to pack some properties, next page can use
  /// [routeParameters] method to get it.
  ///
  /// Note: only can get [String] value.
  ///
  /// e.g. /NextScreen?device=phone&id=354&name=Enzo
  /// ```dart
  ///   String name = Navigators.routeParameters('name');
  ///   assert('Enzo' == name);
  /// ```
  ///
  String? routeParameters(String name) {
    return XRouter.parameters(name);
  }
}
