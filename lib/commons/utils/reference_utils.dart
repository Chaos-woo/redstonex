import 'package:get/get.dart';

/// A GetX singleton container utils.
///
/// In order to semantic.
class ReferenceUtils {
  static S find<S>({String? tag}) => Get.find<S>(tag: tag);

  static S put<S>(S dependency, {String? tag}) => Get.put<S>(dependency, tag: tag);

  static void lazyPut<S>(S dependency, {String? tag}) =>
      Get.lazyPut<S>(() => dependency, tag: tag);

  static bool exist<S>({String? tag}) => Get.isRegistered<S>(tag: tag);

  static void remove<S>({String? tag}) => Get.delete<S>(tag: tag);

  static void safeRemove<S>({String? tag}) {
    if (Get.isRegistered<S>(tag: tag)) {
      Get.delete<S>(tag: tag);
    }
  }
}
