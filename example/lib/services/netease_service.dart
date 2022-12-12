import 'package:example/providers/api_bug_provider.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

/// 网易云服务
/// 业务服务模块向上提供统一逻辑方法
class NeteaseService extends GetxService {
  final ApiBugProvider _apiBugProvider = Depends.on();

  /// 获取歌曲热门评论
  Future<void> getRandomHotComment() async {

  }

  /// 收藏热门评论
  Future<void> collectHotComment() async {

  }
}