import 'package:redstonex/ioc-core/reflectable-core/utils/reflections_utils.dart';

/// Provide simple semantic API to find dependency in container.
///
class Depends {
  /// Provide search method to find dependency.
  static S on<S>({String? tag}) {
    return ReflectionsUtils.find<S>(tag: tag);
  }

  /// Provide find method to judge dependency exist.
  static bool exist<S>({String? tag}) {
    return ReflectionsUtils.existInGetX<S>(tag: tag) || ReflectionsUtils.existInSelfContainer<S>(tag: tag);
  }
}
