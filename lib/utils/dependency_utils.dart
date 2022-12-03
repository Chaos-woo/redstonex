import 'package:get/get.dart';

/// 依赖工具
class DependencyUtils {
  /// 从GetX获取S类型依赖
  static S findDependency<S>({String? tag}) {
    return Get.find<S>(tag: tag);
  }

  /// 向GetX注入依赖
  static S putDependency<S>(S dependency, {String? tag}) {
    return Get.put<S>(dependency, tag: tag);
  }

  /// GetX不存在S类型依赖时，向其注入依赖，存在时返回已有依赖
  static S putDependencyIfAbsent<S>(S dependency, {String? tag}) {
    if (existDependency<S>(tag: tag)) {
      return findDependency<S>(tag: tag);
    } else {
      return putDependency(dependency, tag: tag);
    }
  }

  /// 依赖懒加载
  static void lazyPutDependency<S>(S dependency, {String? tag, bool fenix = false}) {
    Get.lazyPut<S>(() => dependency, tag: tag, fenix: fenix);
  }

  ///是否注册依赖
  static bool existDependency<S>({String? tag}) => Get.isRegistered<S>(tag: tag);

  /// 移除依赖
  static void removeDependency<S>({String? tag}) => Get.delete<S>(tag: tag);

  /// 安全移除依赖
  static void removeDependencyIfExist<S>({String? tag}) {
    if (existDependency<S>(tag: tag)) {
      removeDependency<S>(tag: tag);
    }
  }
}
