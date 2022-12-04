import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/fix-null-safety/widget-chain/widget_chain.dart';
import 'package:redstonex/utils/theme_utils.dart';
import 'package:redstonex/widgets/option-bar-list/option_bar_item.dart';
import 'package:redstonex/widgets/option-bar-list/option_bar_style.dart';
import 'package:redstonex/widgets/option-bar-list/option_group_tip.dart';

class OptionBarGroup extends StatelessWidget {
  /// 分组数据
  List<List<OptionBarItem>> optionBarItemGroups;

  /// 分组工具条
  Map<int, OptionGroupToolBar> optionGroupToolBars;
  OptionBarStyle? style;
  late ThemeData _theme;

  OptionBarGroup({
    Key? key,
    required this.optionBarItemGroups,
    this.optionGroupToolBars = const {},
    this.style,
  }) : super(key: key);

  void _initProps() {
    style = style ?? OptionBarStyle.style();
    _theme = ThemeUtils.theme();
  }

  @override
  Widget build(BuildContext context) {
    _initProps();

    int optionItemCnt = optionBarItemGroups.map((g) => g.toList()).toList().length;

    if (optionItemCnt <= 0) {
      return Container();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: optionBarItemGroups.length,
      itemBuilder: (ctx, index) {
        List<OptionBarItem> singleOptionBarItem = optionBarItemGroups[index];
        int currentItemGroupLength = singleOptionBarItem.length;

        /// 添加工具条
        List<Widget> items = [];
        if (optionGroupToolBars[index] != null) {
          items.add(_optionGroupToolBarBuilder(optionGroupToolBars[index]!));
          items.add(OptionBarConst.groupDivider);
        }

        /// 添加当前分组的选项
        for (int i = 0; i < currentItemGroupLength; i++) {
          if (i != 0) {
            items.add(OptionBarConst.itemDivider);
          }
          items.add(_optionItemBuilder(singleOptionBarItem[i]));
        }

        return items
            .intoColumn(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            )
            .intoPadding(padding: const EdgeInsets.symmetric(vertical: 5));
      },
    );
  }

  /// 选项组自定义文案和组件
  Widget _optionGroupToolBarBuilder(OptionGroupToolBar toolBar) {
    List<Widget> rowLeftWidgets = [];
    List<Widget> rowRightWidgets = [];

    if (toolBar.title != null && toolBar.tool != null) {
      /// 处理分组提示文案和组件的位置
      if (toolBar.titlePosition == OptionGroupToolBarPosition.left &&
          toolBar.toolPosition == OptionGroupToolBarPosition.left) {
        if (toolBar.titleFirst) {
          rowLeftWidgets.add(Text(toolBar.title!, style: style?.groupTipTextStyle));
          rowLeftWidgets.add(toolBar.tool!);
        } else {
          rowLeftWidgets.add(toolBar.tool!);
          rowLeftWidgets.add(Text(toolBar.title!, style: style?.groupTipTextStyle));
        }
      } else if (toolBar.titlePosition == OptionGroupToolBarPosition.right &&
          toolBar.toolPosition == OptionGroupToolBarPosition.right) {
        if (toolBar.titleFirst) {
          rowLeftWidgets.add(toolBar.tool!);
          rowLeftWidgets.add(Text(toolBar.title!, style: style?.groupTipTextStyle));
        } else {
          rowLeftWidgets.add(Text(toolBar.title!, style: style?.groupTipTextStyle));
          rowLeftWidgets.add(toolBar.tool!);
        }
      } else {
        if (toolBar.titlePosition == OptionGroupToolBarPosition.left) {
          rowLeftWidgets.add(Text(toolBar.title!, style: style?.groupTipTextStyle));
        } else {
          rowRightWidgets.add(Text(toolBar.title!, style: style?.groupTipTextStyle));
        }

        if (toolBar.toolPosition == OptionGroupToolBarPosition.left) {
          rowLeftWidgets.add(toolBar.tool!);
        } else {
          rowRightWidgets.add(toolBar.tool!);
        }
      }
    } else if (toolBar.title != null) {
      /// 处理仅有分组提示文案
      Text tipText = Text(toolBar.title!, style: style?.groupTipTextStyle);
      if (toolBar.titlePosition == OptionGroupToolBarPosition.left) {
        rowLeftWidgets.add(tipText);
      } else {
        rowRightWidgets.add(tipText);
      }
    } else if (toolBar.tool != null) {
      /// 处理仅有分组自定义组件
      if (toolBar.toolPosition == OptionGroupToolBarPosition.left) {
        rowLeftWidgets.add(toolBar.tool!);
      } else {
        rowRightWidgets.add(toolBar.tool!);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          rowLeftWidgets.intoRow(mainAxisAlignment: MainAxisAlignment.start),
          rowRightWidgets.intoRow(mainAxisAlignment: MainAxisAlignment.end),
        ],
      ),
    );
  }

  /// 选项组件
  Widget _optionItemBuilder(OptionBarItem item) {
    double iconSize = item.leadingIconSize ?? item.titleTextStyle.fontSize! + 2;
    double rightIconSize = item.rightIconSize ?? item.titleTextStyle.fontSize! + 2;

    List<Widget> leftWidgets = [];
    List<Widget> rightWidgets = [];

    if (item.leadingWidget != null) {
      leftWidgets.add(item.leadingWidget!);
    } else if (item.leadingIcon != null) {
      Widget leadingIcon = Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(item.leadingIcon, size: iconSize, color: item.leadingIconColor ?? _theme.primaryColor),
      );
      leftWidgets.add(leadingIcon);
    }

    TextPainter? subTitlePainter;
    if (GetUtils.isNullOrBlank(item.subTitle)!) {
      leftWidgets.add(Text(item.title, style: item.titleTextStyle, maxLines: 1));
    } else {
      /// 处理标题和选项详情
      Text title = Text(
        item.title,
        style: item.titleTextStyle.merge(TextStyle(fontSize: item.titleTextStyle.fontSize! - 2)),
        maxLines: 1,
      );
      TextStyle subTitleStyle = TextStyle(
        fontSize: item.titleTextStyle.fontSize! - 8,
        color: item.subTitleColor,
      );
      subTitlePainter = TextPainter(
        text: TextSpan(text: item.subTitle),
        textAlign: TextAlign.start,
        maxLines: 1,
      );
      Text subTitle = Text(
        item.subTitle!,
        style: subTitleStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
      leftWidgets.add(title.addNeighbor(subTitle).intoColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ));
    }

    /// 处理扩展组件
    leftWidgets.addAll(_extComponentsBuilder(item, OptionExtPosition.left));

    /// 选项左边组件
    Widget leftWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: leftWidgets,
    );

    rightWidgets.addAll(_extComponentsBuilder(item, OptionExtPosition.right));
    if (item.rightIconWidget != null) {
      rightWidgets.add(item.rightIconWidget!);
    } else if (item.rightIcon != null) {
      rightWidgets.add(
        Icon(
          item.rightIcon,
          size: rightIconSize,
          color: item.rightIconColor ?? _theme.primaryColor,
        ),
      );
    }

    /// 选项右边组件
    final Widget rightWidgetRow = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: rightWidgets,
    );

    double widgetHeight = style!.optionItemHeight!;
    if (subTitlePainter != null && subTitlePainter.didExceedMaxLines) {
      widgetHeight += OptionBarConst.optionItemHeightPlus;
    }
    return InkWell(
      onTap: () async => item.onTap?.call(),
      onDoubleTap: () async => item.onDoubleTap?.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        color: style?.optionBarItemColor,
        height: widgetHeight,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [leftWidget, rightWidgetRow],
          ),
        ),
      ),
    );
  }

  /// 自定义扩展组件
  List<Widget> _extComponentsBuilder(OptionBarItem item, OptionExtPosition position) {
    List<Widget> exts = [];

    if (item.extPosition == position) {
      if (item.extWidget != null) {
        exts.add(item.extWidget!);
      } else if (item.extText != null) {
        exts.add(
          Text(
            item.extText!,
            style: item.titleTextStyle.merge(const TextStyle(fontSize: 13)),
          ),
        );
      }
    }

    return exts;
  }
}
