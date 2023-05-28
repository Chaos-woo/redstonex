import 'dart:math';

import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../resources/gaps.dart';
import 'redstonex_item_list_model.dart';

class RsxHorizontalItemWidget extends StatelessWidget {
  final RsxHorizontalItem item;

  const RsxHorizontalItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var calcLeadingTop = null != item.leading && item.leadingTop!;

    /// 当主轴方向为unbound的限制时，
    /// 假设子组件使用Flexible表示尽可能的扩展剩余空间时，
    /// 这与父组件主轴方向上尽可能收缩的意图是相反的，
    /// 最好 [MainAxisSize.min] 和 [Flexible类别的组件配合使用]
    var optionItemRow = <Widget>[
      <Widget>[
        item.leading ?? Gaps.emptyBox,
        _buildMainContent().flexible(),
      ]
          .toRow(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                  calcLeadingTop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min)
          .flexible(),
      item.suffix ?? Gaps.emptyBox,
    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween);

    /// 使单个选项卡高度尽可能符合实际高度
    var adaptiveOptionItemCol = <Widget>[
      optionItemRow,
    ].toColumn(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
    );

    return _buildOuterBox(child: adaptiveOptionItemCol);
  }

  Widget _buildMainContent() {
    var contentCol = <Widget>[
      item.titleWidget ?? Text(item.title ?? '', style: item.titleStyle),
      item.description ?? Gaps.emptyBox,
    ].toColumn(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
    );

    var extWidget = item.extWidget ?? Gaps.emptyBox;
    if (null != item.extWidget) {
      var normalizationRatio = item.extRatio!.clamp(0.0, 1.0);
      int extWidgetFlex = (normalizationRatio * 100).toInt();
      int contentColFlex = max(0, 100 - extWidgetFlex);

      contentCol = contentCol.flexible(flex: contentColFlex);
      extWidget = extWidget
          .alignment(
            RsxHorizontalItemExtPosition.left == item.extWidgetPosition
                ? Alignment.centerLeft
                : Alignment.centerRight,
          )
          .flexible(flex: extWidgetFlex);
    } else {
      /// 很重要
      return contentCol;
    }

    return <Widget>[
      contentCol,
      extWidget,
    ].toRow(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
    );
  }

  Widget _buildOuterBox({Widget? child}) {
    BoxConstraints constraints = item.constraints ??
        const BoxConstraints(
          minHeight: 45.0,
          maxHeight: 55.0,
          minWidth: 0.0,
          maxWidth: double.infinity,
        );

    return Styled.widget(child: child)
        .decorated(
          color: item.backgroundColor,
          borderRadius: item.borderRadius,
        )
        .constrained(
          minHeight: constraints.minHeight,
          maxHeight: constraints.maxHeight,
          minWidth: constraints.minWidth,
          maxWidth: constraints.maxWidth,
        )
        .gestures(
          onTap: item.onTap,
          onDoubleTap: item.onDoubleTap,
          onLongPress: item.onLongPress,
        );
  }
}
