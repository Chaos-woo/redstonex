import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:redstonex/observer/has_event_observer.dart';
import 'package:redstonex/paging/page_state.dart';
import 'package:redstonex/paging/paging_data.dart';
import 'package:redstonex/paging/paging_params.dart';

enum RefreshOperateType { refresh, loadMore }

/// 支持事件方式更新UI的分页控制器
abstract class PagingController2<M, S extends PagingState<M>> extends GetxController with HasEventObserver<M> {
  /// 分页数据
  late S pagingState;

  /// 当前操作类型
  late RefreshOperateType _refreshOperateType;

  /// 刷新控件的 Controller
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    pagingState = getPagingState();

    onMulti(
      onSuccess: <M2>(data, exception) => _loadSuccess(data, exception),
      onFail: <M2>(data, exception) => _loadError(data, exception),
    );
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
    _refreshOperateType = RefreshOperateType.refresh;
    await _loadData();
  }

  ///初始化分页数据
  void initPaging() {
    pagingState.nextIndex = 1;
    pagingState.hasMore = true;
    pagingState.data.clear();
  }

  void _loadError(data, exception) {
    if (RefreshOperateType.refresh == _refreshOperateType) {
      refreshController.refreshFailed();
    } else if (RefreshOperateType.loadMore == _refreshOperateType) {
      refreshController.loadFailed();
    }

    loadError.call(exception);
  }

  void _loadSuccess(data, exception) {
    if (RefreshOperateType.refresh == _refreshOperateType) {
      refreshController.refreshCompleted();
    } else if (RefreshOperateType.loadMore == _refreshOperateType) {
      refreshController.loadComplete();
    }

    List<M>? list = data?.cast<M>();

    /// 数据不为空，则将数据添加到 data 中
    /// 并且分页页数 pageIndex + 1
    if (list != null && list.isNotEmpty) {
      pagingState.data.addAll(list);
      pagingState.nextIndex += 1;
    }

    /// 判断是否有更多数据
    pagingState.hasMore = hasMoreData();

    /// 更新界面
    update([pagingState.refreshId]);
  }

  /// 数据加载
  Future<void> _loadData() async {
    PagingParams pagingParams = getPagingParams();
    pagingParams.currentIndex = pagingState.nextIndex;
    await loadData(pagingParams);
  }

  /// 加载更多
  void loadMoreData() async {
    await _loadData();
    _refreshOperateType = RefreshOperateType.loadMore;

    /// 加载完成
    refreshController.loadComplete();
  }


  @override
  void onClose() {
    super.onClose();
  }

  /// 自定义数据加载
  Future<PagingData<M>?> loadData(PagingParams pagingParams);

  /// 自定义加载异常处理
  void loadError(Exception? exception) => () {};

  /// 获取分页请求参数
  PagingParams getPagingParams() => PagingParams.create(pageIndex: pagingState.nextIndex);

  /// 获取State
  S getPagingState();

  /// 是否还有更多数据逻辑
  bool hasMoreData();
}
