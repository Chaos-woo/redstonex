import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:redstonex/observer/has_paging_event_observer.dart';
import 'package:redstonex/observer/refresh_list_event.dart';
import 'package:redstonex/paging/page_state.dart';
import 'package:redstonex/paging/paging_params.dart';

enum RefreshOperateType { refresh, loadMore }

/// 支持事件方式更新UI的分页控制器
abstract class EventPagingController<M, S extends PagingState<M>, E extends ListRefreshableEvent<M>>
    extends GetxController with HasEventPagingObserver<M, E> {
  /// 分页数据
  late S pagingState;

  /// 当前操作类型
  late RefreshOperateType _refreshOperateType;

  /// 刷新控件的 Controller
  late RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    pagingState = customPagingState();

    onPagingEvent(
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
    beforeRefresh();
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
      var rxList = list.map((item) => item.obs).toList();
      pagingState.data.addAll(rxList);
      pagingState.nextIndex += 1;
    }

    /// 判断是否有更多数据
    pagingState.hasMore = hasMoreData();

    /// 更新界面
    update([pagingState.refreshId]);
  }

  /// 数据加载
  Future<void> _loadData() async {
    PagingParams pagingParams = customPagingParams();
    pagingParams.currentIndex = pagingState.nextIndex;
    await loadData(pagingParams);
  }

  /// 加载更多
  void loadMoreData() async {
    beforeLoadMore();
    _refreshOperateType = RefreshOperateType.loadMore;
    await _loadData();

    /// 加载完成
    refreshController.loadComplete();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 自定义数据加载
  Future loadData(PagingParams pagingParams);

  /// 自定义加载异常处理
  void loadError(Exception? exception) => () {};

  /// 获取分页请求参数
  PagingParams customPagingParams() => PagingParams.create(pageIndex: pagingState.nextIndex);

  /// 获取State
  S customPagingState();

  /// 是否还有更多数据逻辑
  bool hasMoreData();

  /// 每次刷新前的操作
  Future<void> beforeRefresh() async {}

  /// 每次加载前的操作
  Future<void> beforeLoadMore() async {}

  /// 滑动至列表顶部并刷新
  Future<void> scrollToTopAndRefresh(
    ScrollController scrollController, {
    Duration animateDuration = const Duration(seconds: 2),
    Curve curve = Curves.linear,
  }) async {
    await scrollController.animateTo(0, duration: animateDuration, curve: curve);
    refreshData();
  }

  /// 自定义刷新控制器
  RefreshController customRefreshController() => RefreshController(initialRefresh: false);
}