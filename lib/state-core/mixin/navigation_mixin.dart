
import 'package:redstonex/route-core/route_utils.dart';

/// Navigation mixin.
mixin NavigationMixin {
  static Future<R?>? push<R>(String route,
      {dynamic arguments, Map<String, String>? parameters}) {
    return RouteUtils.push<R>(route, arguments: arguments, parameters: parameters);
  }

  /// Pop the current named page and pushes a new `page`
  static Future<R?>? popAndPushNamed<R>(String route,
      {dynamic arguments, Map<String, String>? parameters}) {
    return RouteUtils.popAndPushNamed<R>(route, arguments: arguments, parameters: parameters);
  }

  /// Push a named `page` and pop several pages in the stack
  static Future<R?>? pushNamedAndRemoveUntil<R>(String route,
      {dynamic arguments, Map<String, String>? parameters}) {
    return RouteUtils.pushNamedAndRemoveUntil<R>(route, arguments: arguments, parameters: parameters);
  }

  static void pop<R>({R? result}) {
    RouteUtils.pop<R>(result: result);
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
    return RouteUtils.argument<T>();
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
    return RouteUtils.parameters(name);
  }
}