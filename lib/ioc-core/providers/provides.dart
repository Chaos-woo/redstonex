import 'package:redstonex/ioc-core/reflectable-core/utils/reflections_utils.dart';

/// Provide simple semantic API to put dependency to GetX container.
///
class Provides {
  /// Provide put method to add GetX container dependency.
  static S into<S>(S dependency, {String? tag}) {
    return ReflectionsUtil.put(dependency, tag: tag);
  }

  /// Provide put method to add GetX container dependency.
  static S intoIfAbsent<S>(S dependency, {String? tag}) {
    return ReflectionsUtil.putIfAbsent(dependency, tag: tag);
  }

  /// Provide replace method to replace GetX container dependency directly.
  /// If container not exist, it also will add to the container.
  static S replace<S>(S dependency, {String? tag}) {
    return ReflectionsUtil.put(dependency, tag: tag);
  }

  /// Provide replace method to replace GetX container dependency directly.
  /// If container not exist, it will not add to the container.
  static S? replaceIfExist<S>(S dependency, {String? tag}) {
    if (ReflectionsUtil.existInGetX<S>(tag: tag)) {
      return ReflectionsUtil.put(dependency, tag: tag);
    }

    return null;
  }

  /// Provide remove method to remove has existed dependency.
  static void safeRemove<S>({String? tag}) {
    return ReflectionsUtil.removeIfExist<S>(tag: tag);
  }
}