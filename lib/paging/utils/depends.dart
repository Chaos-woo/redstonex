import '../../utils/dependency.dart';

/// 依赖获取
class rDepends {
  static final rDepends _single = rDepends._internal();

  rDepends._internal();

  factory rDepends() => _single;

  /// 获取S类型依赖，支持tag指定同类型不同标签的依赖
  S on<S>({String? tag}) {
    return rDependency().findDependency<S>(tag: tag);
  }

  /// 判断是否存在S类型，标签为tag的依赖
  bool exist<S>({String? tag}) {
    return rDependency().existDependency<S>(tag: tag);
  }
}
