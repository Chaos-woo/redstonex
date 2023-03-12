import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:redstonex/networks/exception/api_exception.dart';
import 'package:redstonex/paging/page_state.dart';
import 'package:redstonex/paging/paging_data.dart';
import 'package:redstonex/paging/paging_params.dart';

abstract class PagingController<M, S extends PagingState<M>> extends GetxController {
  /// 分页数据
  late S pagingState;

  /// 刷新控件的 Controller
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();

    pagingState = providePagingState();
  }

  @override
  void onReady() {
    super.onReady();

    /// 进入页面刷新数据
    refreshData();
  }

  /// 刷新数据
  void refreshData() async {
    initPaging();
    beforeRefresh();
    await _loadData();

    /// 刷新完成
    refreshController.refreshCompleted();
  }

  ///初始化分页数据
  void initPaging() {
    pagingState.nextIndex = 1;
    pagingState.hasMore = true;
    pagingState.data.clear();
  }

  /// 数据加载
  Future<void> _loadData() async {
    PagingParams pagingParams = providePagingParams();
    pagingParams.currentIndex = pagingState.nextIndex;
    PagingData<M>? pagingData = await loadData(pagingParams);
    List<M>? list = pagingData?.data;

    /// 数据不为空，则将数据添加到 data 中
    /// 并且分页页数 pageIndex + 1
    if (list != null && list.isNotEmpty) {
      var rxList = list.map((item) => item.obs).toList();
      pagingState.data.addAll(rxList);
      pagingState.nextIndex += 1;
    }

    /// 判断是否有更多数据
    pagingState.hasMore = hasMoreData();

    /// 更新界面
    update([pagingState.refreshId]);
  }

  /// 加载更多
  void loadMoreData() async {
    beforeLoadMore();
    await _loadData();

    /// 加载完成
    refreshController.loadComplete();
  }

  /// 自定义数据加载
  Future<PagingData<M>?> loadData(PagingParams pagingParams, {bool Function(ApiException)? onError});

  /// 获取分页请求参数
  PagingParams providePagingParams() => PagingParams.create(pageIndex: pagingState.nextIndex);

  /// 获取State
  S providePagingState();

  /// 是否还有更多数据逻辑
  bool hasMoreData();

  /// 每次刷新前的操作
  Future<void> beforeRefresh() async {}

  /// 每次加载前的操作
  Future<void> beforeLoadMore() async {}
}
