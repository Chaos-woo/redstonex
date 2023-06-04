import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../extension/number_extension.dart';
import '../../resources/gaps.dart';
import 'redstonex_horizontal_toolbar_widget.dart';
import 'redstonex_horizontal_widget.dart';
import 'redstonex_item_list_model.dart';

typedef rOptionDividerBuilder = Widget Function(BuildContext context);

/// 选项组组件
class rOptionGroupWidget extends StatelessWidget {
  /// 选项组
  final List<rOptionGroupItem> optionGroupItems;

  /// 选项间的分隔构造器
  rOptionDividerBuilder? optionItemDividerBuilder;

  /// 工具条和分组内容间的间隙
  double? toolbarItemGap;

  /// 多个分组之间的间隙
  double? optionGroupGap;

  /// 分组外框圆角
  double? optionGroupRadius;

  /// 整个选项组列表的物理滑动效果
  ScrollPhysics? physics;

  rOptionGroupWidget({
    Key? key,
    required this.optionGroupItems,
    this.optionItemDividerBuilder,
    this.toolbarItemGap = 5.0,
    this.optionGroupGap = 5.0,
    this.optionGroupRadius,
    this.physics,
  }) : super(key: key);

  bool _checkValidGroupItems() {
    if (optionGroupItems.isEmpty) {
      return false;
    }

    int optionItemCnt =
        optionGroupItems.map((gItem) => gItem.optionItems.length).reduce((int a, int b) => a + b);
    return optionItemCnt > 0;
  }

  Widget _defaultValGap(double? vGap, {double defaultVal = 0.0}) {
    return null != vGap ? rGaps.vGap(vGap) : rGaps.vGap(defaultVal);
  }

  @override
  Widget build(BuildContext context) {
    if (!_checkValidGroupItems()) {
      return rGaps.emptyBox;
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: optionGroupItems.length,
      itemBuilder: (context, index) {
        var optionGroup = optionGroupItems[index];
        var toolbar = rHorizontalToolbarWidget(toolbar: optionGroup.toolbar);
        var optionItems = optionGroup.optionItems.map((item) {
          var itemWidget = rHorizontalItemWidget(item: item);
          if (null != optionItemDividerBuilder && optionGroup.optionItems.last != item) {
            return <Widget>[
              itemWidget,
              optionItemDividerBuilder!.call(context),
            ].toColumn(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            );
          } else {
            return itemWidget;
          }
        }).toList();

        return Container(
          margin: (optionGroupGap ?? 0.0).bottomEdge,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(optionGroupRadius ?? 10.0),
            child: Container(
              child: <Widget>[
                toolbar,
                if (null != optionGroup.toolbar) _defaultValGap(toolbarItemGap),
                ...optionItems,
              ].toColumn(mainAxisSize: MainAxisSize.min),
            ),
          ),
        );
      },
      physics: physics,
    );
  }
}
