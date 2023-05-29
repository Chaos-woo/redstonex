import 'package:get/get.dart';

import '../../utils/dependency.dart';

/// 注入依赖
class rProvides {
  static final rProvides _single = rProvides._internal();

  rProvides._internal();

  factory rProvides() => _single;

  /// 向GetX注入依赖
  S provide<S>(S dependency, {String? tag}) {
    return rDependency().putDependency(dependency, tag: tag);
  }

  /// 如果不存在S类型依赖，则向GetX注入依赖，存在时返回已有依赖
  S provideIfAbsent<S>(S dependency, {String? tag}) {
    return rDependency().putDependencyIfAbsent(dependency, tag: tag);
  }

  /// 替换GetX中的S类型依赖，假如不存在该依赖，则注入依赖
  S replace<S>(S dependency, {String? tag}) {
    return rDependency().putDependency(dependency, tag: tag);
  }

  /// 假如GetX中存在S类型依赖时，才向GetX替换该依赖
  S? replaceIfExist<S>(S dependency, {String? tag}) {
    if (rDependency().existDependency<S>(tag: tag)) {
      return rDependency().putDependency(dependency, tag: tag);
    }

    return null;
  }

  /// 安全移除依赖
  void safeRemove<S>({String? tag}) {
    return rDependency().removeDependencyIfExist<S>(tag: tag);
  }

  /// 懒加载依赖
  void lazyProvide<S>(InstanceBuilderCallback<S> builder, {String? tag, bool fenix = false}) {
    rDependency().lazyPutDependency(builder, tag: tag, fenix: fenix);
  }
}
