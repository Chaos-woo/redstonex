import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart' as ptr;
import 'package:redstonex/mvp/paging/page_controller.dart';
import 'package:redstonex/mvp/paging/page_state.dart';
import 'package:redstonex/mvp/paging/refresh_text.dart';
import 'package:redstonex/mvp/utils/depends.dart';

class RefreshWidgets {
  static Widget buildRefreshWidget({
    required Widget Function() builder,
    VoidCallback? onRefresh,
    VoidCallback? onLoad,
    required ptr.RefreshController refreshController,
    bool enablePullUp = true,
    bool enablePullDown = true,
    RefreshTextCompose? refreshText,
    ptr.RefreshIndicator? refreshIndicator,
    ptr.LoadIndicator? loadIndicator,
  }) {
    RefreshTextCompose textCompose = refreshText ?? RefreshTextCompose();
    RefreshHeaderText headerText = textCompose.header;
    RefreshFooterText footerText = textCompose.footer;
    ptr.RefreshIndicator refreshDataIndicator = refreshIndicator ??
        ptr.ClassicHeader(
          idleText: headerText.idleText,
          releaseText: headerText.releaseText,
          completeText: headerText.completeText,
          refreshingText: headerText.refreshingText,
        );
    ptr.LoadIndicator loadDataIndicator = loadIndicator ??
        ptr.ClassicFooter(
          idleText: footerText.idleText,
          canLoadingText: footerText.canLoadingText,
          loadingText: footerText.loadingText,
        );

    return ptr.SmartRefresher(
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

  static Widget buildRefreshListWidget<T, C extends PagingController<T, PagingState<T>>>({
    required Widget Function(T item, int index) itemBuilder,
    bool enablePullUp = true,
    bool enablePullDown = true,
    String? tag,
    Widget Function(T item, int index)? separatorBuilder,
    Function(T item, int index)? onItemClick,
    Function(T item, int index)? onItemLongPress,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    Axis scrollDirection = Axis.vertical,
    RefreshTextCompose? refreshText,
    ptr.RefreshIndicator? refreshIndicator,
    ptr.LoadIndicator? loadIndicator,
  }) {
    C controller = Depends.on(tag: tag);
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
    required Widget Function(T item, int index) itemBuilder,
    required List<T> data,
    Widget Function(T item, int index)? separatorBuilder,
    Function(T item, int index)? onItemClick,
    Function(T item, int index)? onItemLongPress,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    Axis scrollDirection = Axis.vertical,
    RefreshTextCompose? refreshText,
    ptr.RefreshIndicator? refreshIndicator,
    ptr.LoadIndicator? loadIndicator,
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
