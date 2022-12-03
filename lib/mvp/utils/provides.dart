import 'package:redstonex/utils/dependency_utils.dart';

/// 注入依赖
class Provides {
  /// 向GetX注入依赖
  static S provide<S>(S dependency, {String? tag}) {
    return DependencyUtils.putDependency(dependency, tag: tag);
  }

  /// 如果不存在S类型依赖，则向GetX注入依赖，存在时返回已有依赖
  static S provideIfAbsent<S>(S dependency, {String? tag}) {
    return DependencyUtils.putDependencyIfAbsent(dependency, tag: tag);
  }

  /// 替换GetX中的S类型依赖，假如不存在该依赖，则注入依赖
  static S replace<S>(S dependency, {String? tag}) {
    return DependencyUtils.putDependency(dependency, tag: tag);
  }

  /// 假如GetX中存在S类型依赖时，才向GetX替换该依赖
  static S? replaceIfExist<S>(S dependency, {String? tag}) {
    if (DependencyUtils.existDependency<S>(tag: tag)) {
      return DependencyUtils.putDependency(dependency, tag: tag);
    }

    return null;
  }

  /// 安全移除依赖
  static void safeRemove<S>({String? tag}) {
    return DependencyUtils.removeDependencyIfExist<S>(tag: tag);
  }

  /// 懒加载依赖
  static void lazyProvide<S>(S dependency, {String? tag, bool fenix = false}) {
    DependencyUtils.lazyPutDependency(dependency, tag: tag, fenix: fenix);
  }
}