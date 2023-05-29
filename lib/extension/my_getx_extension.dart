import 'package:get/get.dart';

import '../paging/utils/depends.dart';
import '../paging/utils/provides.dart';

class rDeps_ {
  static T ofGetxService<T extends GetxService>({String? tag}) => rDepends().on<T>(tag: tag);

  static T ofGetxController<T extends GetxController>({String? tag}) => rDepends().on<T>(tag: tag);

  static T of<T>({String? tag}) => rDepends().on<T>(tag: tag);
}

class rInject_ {
  static T injectService<T extends GetxService>(T injection, {String? tag}) =>
      rProvides().provide(injection, tag: tag);

  static void lazyInjectService<T extends GetxService>(T Function() injection, {String? tag}) =>
      rProvides().lazyProvide(injection, tag: tag);

  static T injectController<T extends GetxController>(T injection, {String? tag}) =>
      rProvides().provide(injection, tag: tag);

  static void lazyInjectController<T extends GetxController>(T Function() injection, {String? tag}) =>
      rProvides().lazyProvide(injection, tag: tag);

  static T inject<T>(T injection, {String? tag}) => rProvides().provide(injection, tag: tag);

  static void lazyInject<T>(T Function() injection, {String? tag}) =>
      rProvides().lazyProvide(injection, tag: tag);
}
