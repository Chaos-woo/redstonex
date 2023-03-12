import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart' as pull2Refresh;
import 'package:redstonex/paging/page_controller_2.dart';
import 'package:redstonex/paging/page_controller.dart';
import 'package:redstonex/paging/page_state.dart';
import 'package:redstonex/paging/refresh_text.dart';
import 'package:redstonex/paging/utils/depends.dart';

class RefreshWidgets {
  static Widget buildRefreshWidget({
    required Widget Function() builder,
    VoidCallback? onRefresh,
    VoidCallback? onLoad,
    required pull2Refresh.RefreshController refreshController,
    bool enablePullUp = true,
    bool enablePullDown = true,
    RefreshTextCompose? refreshText,
    pull2Refresh.RefreshIndicator? refreshIndicator,
    pull2Refresh.LoadIndicator? loadIndicator,
  }) {
    RefreshTextCompose textCompose = refreshText ?? RefreshTextCompose();
    RefreshHeaderText headerText = textCompose.header;
    RefreshFooterText footerText = textCompose.footer;
    pull2Refresh.RefreshIndicator refreshDataIndicator = refreshIndicator ??
        pull2Refresh.ClassicHeader(
          idleText: headerText.idleText,
          releaseText: headerText.releaseText,
          completeText: headerText.completeText,
          refreshingText: headerText.refreshingText,
        );
    pull2Refresh.LoadIndicator loadDataIndicator = loadIndicator ??
        pull2Refresh.ClassicFooter(
          idleText: footerText.idleText,
          canLoadingText: footerText.canLoadingText,
          loadingText: footerText.loadingText,
        );

    return pull2Refresh.SmartRefresher(
      enablePullUp: enablePullUp,
      enablePullDown: enablePullDown,
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoad,
      header: refreshDataIndicator,
      footer: loadDataIndicator,
      child: builder(),
    );
  }

  static Widget buildRefreshListWidget2<T, C extends PagingController2<T, PagingState<T>>>({
    required Widget Function(Rx<T> item, int index) itemBuilder,
    bool enablePullUp = true,
    bool enablePullDown = true,
    String? tag,
    Widget Function(Rx<T> item, int index)? separatorBuilder,
    Function(Rx<T> item, int index)? onItemClick,
    Function(Rx<T> item, int index)? onItemLongPress,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    Axis scrollDirection = Axis.vertical,
    RefreshTextCompose? refreshText,
    pull2Refresh.RefreshIndicator? refreshIndicator,
    pull2Refresh.LoadIndicator? loadIndicator,
  }) {
    C controller = XDepends().on(tag: tag);
    return GetBuilder<C>(
      builder: (controller) {
        return buildRefreshWidget(
          builder: () => buildListView<T>(
              data: controller.pagingState.data,
              separatorBuilder: separatorBuilder,
              itemBuilder: itemBuilder,
              onItemClick: onItemClick,
              onItemLongPress: onItemLongPress,
              physics: physics,
              shrinkWrap: shrinkWrap,
              scrollDirection: scrollDirection),
          refreshController: controller.refreshController,
          onRefresh: controller.refreshData,
          onLoad: controller.loadMoreData,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp && controller.pagingState.hasMore,
          refreshText: refreshText,
          refreshIndicator: refreshIndicator,
          loadIndicator: loadIndicator,
        );
      },
      tag: tag,
      id: controller.pagingState.refreshId,
    );
  }


  static Widget buildRefreshListWidget<T, C extends PagingController<T, PagingState<T>>>({
    required Widget Function(Rx<T> item, int index) itemBuilder,
    bool enablePullUp = true,
    bool enablePullDown = true,
    String? tag,
    Widget Function(Rx<T> item, int index)? separatorBuilder,
    Function(Rx<T> item, int index)? onItemClick,
    Function(Rx<T> item, int index)? onItemLongPress,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    Axis scrollDirection = Axis.vertical,
    RefreshTextCompose? refreshText,
    pull2Refresh.RefreshIndicator? refreshIndicator,
    pull2Refresh.LoadIndicator? loadIndicator,
  }) {
    C controller = XDepends().on(tag: tag);
    return GetBuilder<C>(
      builder: (controller) {
        return buildRefreshWidget(
          builder: () => buildListView<T>(
              data: controller.pagingState.data,
              separatorBuilder: separatorBuilder,
              itemBuilder: itemBuilder,
              onItemClick: onItemClick,
              onItemLongPress: onItemLongPress,
              physics: physics,
              shrinkWrap: shrinkWrap,
              scrollDirection: scrollDirection),
          refreshController: controller.refreshController,
          onRefresh: controller.refreshData,
          onLoad: controller.loadMoreData,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp && controller.pagingState.hasMore,
          refreshText: refreshText,
          refreshIndicator: refreshIndicator,
          loadIndicator: loadIndicator,
        );
      },
      tag: tag,
      id: controller.pagingState.refreshId,
    );
  }

  static Widget buildListView<T>({
    required Widget Function(Rx<T> item, int index) itemBuilder,
    required List<Rx<T>> data,
    Widget Function(Rx<T> item, int index)? separatorBuilder,
    Function(Rx<T> item, int index)? onItemClick,
    Function(Rx<T> item, int index)? onItemLongPress,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    Axis scrollDirection = Axis.vertical,
    RefreshTextCompose? refreshText,
    pull2Refresh.RefreshIndicator? refreshIndicator,
    pull2Refresh.LoadIndicator? loadIndicator,
  }) {
    return ListView.separated(
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: EdgeInsets.zero,
        scrollDirection: scrollDirection,
        itemBuilder: (ctx, index) => GestureDetector(
              child: itemBuilder.call(data[index], index),
              onTap: () => onItemClick?.call(data[index], index),
              onLongPress: () => onItemLongPress?.call(data[index], index),
            ),
        separatorBuilder: (ctx, index) => separatorBuilder?.call(data[index], index) ?? Container(),
        itemCount: data.length);
  }
}
