import 'package:get/get.dart';

/// A GetX singleton container utils.
///
/// In order to semantic.
class DependencyUtils {
  /// Find `S` type dependency from GetX.
  static S findDependency<S>({String? tag}) {
    return Get.find<S>(tag: tag);
  }

  /// Put it into GetX container.
  static S putDependency<S>(S dependency, {String? tag}) {
    return Get.put<S>(dependency, tag: tag);
  }

  /// Put it into GetX container when it not exist in GetX container.
  static S putDependencyIfAbsent<S>(S dependency, {String? tag}) {
    if (existDependency<S>(tag: tag)) {
      return findDependency<S>(tag: tag);
    } else {
      return putDependency(dependency, tag: tag);
    }
  }

  /// GetX's GetInstance#lazyPut proxy method.
  static void lazyPutDependency<S>(S dependency, {String? tag, bool fenix = false}) {
    Get.lazyPut<S>(() => dependency, tag: tag, fenix: fenix);
  }

  /// Whether exist in GetX container
  static bool existDependency<S>({String? tag}) => Get.isRegistered<S>(tag: tag);

  /// Remove from GetX container
  static void removeDependency<S>({String? tag}) => Get.delete<S>(tag: tag);

  /// Remove when it exist in GetX container
  static void removeDependencyIfExist<S>({String? tag}) {
    if (existDependency<S>(tag: tag)) {
      removeDependency<S>(tag: tag);
    }
  }
}
