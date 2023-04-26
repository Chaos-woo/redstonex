import 'package:get/get.dart';
import 'package:redstonex/paging/utils/depends.dart';
import 'package:redstonex/paging/utils/provides.dart';

class xDeps_ {
  static T ofGetxService<T extends GetxService>({String? tag}) => XDepends().on<T>(tag: tag);

  static T ofGetxController<T extends GetxController>({String? tag}) => XDepends().on<T>(tag: tag);

  static T of<T>({String? tag}) => XDepends().on<T>(tag: tag);
}

class xInject_ {
  static T injectService<T extends GetxService>(T injection, {String? tag}) => XProvides().provide(injection, tag: tag);

  static void lazyInjectService<T extends GetxService>(T injection, {String? tag}) =>
      XProvides().lazyProvide(() => injection, tag: tag);

  static T injectController<T extends GetxController>(T injection, {String? tag}) =>
      XProvides().provide(injection, tag: tag);

  static void lazyInjectController<T extends GetxController>(T injection, {String? tag}) =>
      XProvides().lazyProvide(() => injection, tag: tag);

  static T inject<T>(T injection, {String? tag}) => XProvides().provide(injection, tag: tag);

  static void lazyInject<T>(T injection, {String? tag}) => XProvides().lazyProvide(() => injection, tag: tag);
}
