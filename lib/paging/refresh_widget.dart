import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart' as pull2Refresh;
import 'package:styled_widget/styled_widget.dart';

import '../observer/refresh_list_event.dart';
import 'event_page_controller.dart';
import 'page_controller.dart';
import 'page_state.dart';
import 'refresh_text.dart';
import 'utils/depends.dart';

class RefreshableWidgets {
  static Widget buildRefreshableWidget({
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
      child: builder.call(),
    );
  }

  static Widget buildEventRefreshableListWidget<T,
      C extends EventPagingController<T, PagingState<T>, ListRefreshableEvent<T>>>({
    required Widget Function(Rx<T> item, int index) itemBuilder,
    ScrollController? scrollController,
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
    Widget Function()? prefixWidgetBuilder,
    Widget Function()? suffixWidgetBuilder,
  }) {
    C controller = XDepends().on(tag: tag);
    return GetBuilder<C>(
      builder: (controller) {
        return buildRefreshableWidget(
          builder: () => buildListView<T>(
            data: controller.pagingState.data,
            scrollController: scrollController,
            separatorBuilder: separatorBuilder,
            itemBuilder: itemBuilder,
            onItemClick: onItemClick,
            onItemLongPress: onItemLongPress,
            physics: physics,
            shrinkWrap: shrinkWrap,
            scrollDirection: scrollDirection,
            prefixWidgetBuilder: prefixWidgetBuilder,
            suffixWidgetBuilder: suffixWidgetBuilder,
          ),
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

  @Deprecated("Recommend use #buildEventRefreshableListWidget")
  static Widget buildRefreshableListWidget<T, C extends PagingController<T, PagingState<T>>>({
    required Widget Function(Rx<T> item, int index) itemBuilder,
    ScrollController? scrollController,
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
    Widget Function()? prefixWidgetBuilder,
    Widget Function()? suffixWidgetBuilder,
  }) {
    C controller = XDepends().on(tag: tag);
    return GetBuilder<C>(
      builder: (controller) {
        return buildRefreshableWidget(
          builder: () => buildListView<T>(
            data: controller.pagingState.data,
            scrollController: scrollController,
            separatorBuilder: separatorBuilder,
            itemBuilder: itemBuilder,
            onItemClick: onItemClick,
            onItemLongPress: onItemLongPress,
            physics: physics,
            shrinkWrap: shrinkWrap,
            scrollDirection: scrollDirection,
            prefixWidgetBuilder: prefixWidgetBuilder,
            suffixWidgetBuilder: suffixWidgetBuilder,
          ),
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
    ScrollController? scrollController,
    Widget Function(Rx<T> item, int index)? separatorBuilder,
    Function(Rx<T> item, int index)? onItemClick,
    Function(Rx<T> item, int index)? onItemLongPress,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    Axis scrollDirection = Axis.vertical,
    RefreshTextCompose? refreshText,
    pull2Refresh.RefreshIndicator? refreshIndicator,
    pull2Refresh.LoadIndicator? loadIndicator,
    Widget Function()? prefixWidgetBuilder,
    Widget Function()? suffixWidgetBuilder,
  }) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: physics,
      controller: scrollController,
      padding: EdgeInsets.zero,
      scrollDirection: scrollDirection,
      itemBuilder: (ctx, index) {
        if (index == 0 && null != prefixWidgetBuilder) {
          return <Widget>[
            prefixWidgetBuilder.call(),
            GestureDetector(
              child: itemBuilder.call(data[index], index),
              onTap: () => onItemClick?.call(data[index], index),
              onLongPress: () => onItemLongPress?.call(data[index], index),
            ),
          ].toColumn(mainAxisSize: MainAxisSize.min);
        } else if (index == data.length - 1 && null != suffixWidgetBuilder) {
          return <Widget>[
            GestureDetector(
              child: itemBuilder.call(data[index], index),
              onTap: () => onItemClick?.call(data[index], index),
              onLongPress: () => onItemLongPress?.call(data[index], index),
            ),
            suffixWidgetBuilder.call(),
          ].toColumn(mainAxisSize: MainAxisSize.min);
        } else {
          return GestureDetector(
            child: itemBuilder.call(data[index], index),
            onTap: () => onItemClick?.call(data[index], index),
            onLongPress: () => onItemLongPress?.call(data[index], index),
          );
        }
      },
      separatorBuilder: (ctx, index) => separatorBuilder?.call(data[index], index) ?? Container(),
      itemCount: data.length,
    );
  }
}
