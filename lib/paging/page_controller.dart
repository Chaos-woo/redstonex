import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../networks/exception/api_exception.dart';
import 'page_state.dart';
import 'paging_data.dart';
import 'paging_params.dart';

@Deprecated("Recommend use EventPagingController based event bus")
abstract class PagingController<M, S extends rPagingState<M>> extends GetxController {
  /// 分页数据
  late S pagingState;

  /// 刷新控件的 Controller
  late RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = customRefreshController();
    pagingState = customPagingState();
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
    rPagingParams pagingParams = customPagingParams();
    pagingParams.currentIndex = pagingState.nextIndex;
    rPagingData<M>? pagingData = await loadData(pagingParams);
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
  Future<rPagingData<M>?> loadData(rPagingParams pagingParams,
      {bool Function(rApiException)? onError});

  /// 获取分页请求参数
  rPagingParams customPagingParams() => rPagingParams.create(pageIndex: pagingState.nextIndex);

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
