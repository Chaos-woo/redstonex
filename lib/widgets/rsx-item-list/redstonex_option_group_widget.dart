import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../resources/gaps.dart';
import 'redstonex_horizontal_toolbar_widget.dart';
import 'redstonex_horizontal_widget.dart';
import 'redstonex_item_list_model.dart';

typedef RsxOptionDivider = Widget Function(BuildContext context);

// ignore: must_be_immutable
class RsxOptionGroupWidget extends StatelessWidget {
  final List<RsxOptionGroupItem> optionGroupItems;
  final RsxOptionDivider? optionItemDivider;
  double? toolbarItemGap;
  double? optionGroupGap;
  ScrollPhysics? physics;

  RsxOptionGroupWidget({
    Key? key,
    required this.optionGroupItems,
    this.optionItemDivider,
    this.toolbarItemGap = 0.0,
    this.optionGroupGap = 10.0,
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
    return null != vGap ? Gaps.vGap(vGap) : Gaps.vGap(defaultVal);
  }

  @override
  Widget build(BuildContext context) {
    if (!_checkValidGroupItems()) {
      return Gaps.emptyBox;
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: optionGroupItems.length,
      itemBuilder: (context, index) {
        var optionGroup = optionGroupItems[index];
        var toolbar = RsxHorizontalToolbarWidget(toolbar: optionGroup.toolbar);
        var optionItems = optionGroup.optionItems.map((item) {
          var itemWidget = RsxHorizontalItemWidget(item: item);
          if (null != optionItemDivider && optionGroup.optionItems.last != item) {
            return <Widget>[
              itemWidget,
              optionItemDivider!.call(context),
            ].toColumn(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            );
          } else {
            return itemWidget;
          }
        }).toList();

        return <Widget>[
          toolbar,
          _defaultValGap(toolbarItemGap),
          ...optionItems,
          _defaultValGap(optionGroupGap),
        ].toColumn(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        );
      },
      physics: physics,
    );
  }
}
