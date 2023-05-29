import 'package:get/get.dart';

class rPagingState<T> {
  /// 分页的页数
  int nextIndex = 1;

  /// 是否还有更多数据
  bool hasMore = true;

  /// 用于列表刷新的id
  Object refreshId = Object();

  /// 列表数据
  List<Rx<T>> data = [];
}
