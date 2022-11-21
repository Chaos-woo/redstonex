import 'package:redstonex/routes/router_utils.dart';

/// 导航快捷方式
mixin Navigator {
  static Future<R?>? to<R>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return RouterUtils.push<R>(
      route,
      arguments: arguments,
      parameters: parameters,
    );
  }

  /// Pop the current named page and pushes a new `page`
  static Future<R?>? toNewPageAndRemoveCurrentPage<R>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return RouterUtils.popAndPushNamed<R>(
      route,
      arguments: arguments,
      parameters: parameters,
    );
  }

  /// Push a named `page` and pop several pages in the stack
  static Future<R?>? toNewPageAndRemoveAllOlderPage<R>(
    String route, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return RouterUtils.pushNamedAndRemoveUntil<R>(
      route,
      arguments: arguments,
      parameters: parameters,
    );
  }

  static void back({dynamic result}) {
    RouterUtils.pop(result: result);
  }

  /// Give current route arguments.
  ///
  /// Like [to]/[toNewPageAndRemoveAllOlderPage] method, can set any
  /// type arguments that like string or object, using generic
  /// type and this method will transmit and return.
  ///
  /// e.g. push("/NextScreen", arguments: 'Get is the best');
  /// ```dart
  ///   String argument = Navigator.argument('arguments');
  ///   assert(argument == 'Get is the best');
  /// ```
  static T routeArgument<T>() {
    return RouterUtils.argument<T>();
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
  ///   String name = Navigator.parameters('name');
  ///   assert('Enzo' == name);
  /// ```
  ///
  static String? routeParameters(String name) {
    return RouterUtils.parameters(name);
  }
}
