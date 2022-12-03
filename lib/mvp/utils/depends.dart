import 'package:redstonex/utils/dependency_utils.dart';

/// 依赖获取
class Depends {
  /// 获取S类型依赖，支持tag指定同类型不同标签的依赖
  static S on<S>({String? tag}) {
    return DependencyUtils.findDependency<S>(tag: tag);
  }

  /// 判断是否存在S类型，标签为tag的依赖
  static bool exist<S>({String? tag}) {
    return DependencyUtils.existDependency<S>(tag: tag);
  }
}
