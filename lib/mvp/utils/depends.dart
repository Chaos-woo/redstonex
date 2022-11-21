import 'package:redstonex/utils/dependency_utils.dart';

/// Provide simple semantic API to find dependency in container.
///
class Depends {
  /// Provide search method to find dependency.
  static S on<S>({String? tag}) {
    return DependencyUtils.findDependency<S>(tag: tag);
  }

  /// Provide find method to judge dependency exist.
  static bool exist<S>({String? tag}) {
    return DependencyUtils.existDependency<S>(tag: tag);
  }
}
