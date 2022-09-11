import 'package:get/get.dart';
import 'package:redstonex/ioc-core/application_container.dart';

/// A GetX singleton container utils.
///
/// In order to semantic.
class ReflectionsUtil {

  /// Find `S` type dependency from GetX container or [ApplicationContainer] .
  static S find<S>({String? tag}) {
    if (existInGetX<S>(tag: tag)) {
      return _findInGetXContainer<S>(tag: tag);
    } else {
      return _findInSelfContainer<S>(tag: tag);
    }
  }

  /// For short lifecycle object in GetX container.
  static S _findInGetXContainer<S>({String? tag}) {
    return Get.find<S>(tag: tag);
  }

  /// For long lifecycle object in self container.
  static S _findInSelfContainer<S>({String? tag}) {
    return ApplicationContainer().findInSelfContainer<S>(tag: tag);
  }

  /// Put it into GetX container.
  static S put<S>(S dependency, {String? tag}) {
    return Get.put<S>(dependency, tag: tag);
  }

  /// Put it into GetX container when it not exist in GetX container.
  static S putIfAbsent<S>(S dependency, {String? tag}) {
    if (existInGetX<S>(tag: tag)) {
      return _findInGetXContainer<S>(tag: tag);
    } else {
      return put(dependency, tag: tag);
    }
  }

  /// GetX's GetInstance#lazyPut proxy method.
  static void lazyPut<S>(S dependency, {String? tag, bool fenix = false}) {
    Get.lazyPut<S>(() => dependency, tag: tag, fenix: fenix);
  }

  /// Whether exist in GetX container
  static bool existInGetX<S>({String? tag}) => Get.isRegistered<S>(tag: tag);

  /// Remove from GetX container
  static void remove<S>({String? tag}) => Get.delete<S>(tag: tag);

  /// Remove when it exist in GetX container
  static void removeIfExist<S>({String? tag}) {
    if (existInGetX<S>(tag: tag)) {
      remove<S>(tag: tag);
    }
  }
}
