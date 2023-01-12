import 'package:example/widgets/rsx_option_item_utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

class ToastToolsComponent extends StatelessWidget {
  const ToastToolsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var optionItems = [
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '基本Toast',
        description: 'toast',
        onTap: () {
          ToastUtils.show('Toast是一种简易的消息提示框');
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '长文案Toast',
        description: '有很长文案的toast，默认最大展示2行',
        onTap: () {
          ToastUtils.show('Toast是一种简易的消息提示框。很长的文案，很长的文案，很长的文案，很长的文案，很长的文案，很长的文案，很长的文案，很长的文案');
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '带图标的Toast',
        description: '有与文案相匹配的图标',
        onTap: () {
          ToastUtils.show('Toast还可以与icon组合', icon: Icons.tips_and_updates, iconColor: Colors.yellowAccent);
        },
      ),
    ];

    var optionGroupItems = RsxOptionGroupItem(
      optionItems: optionItems,
    );

    return GFAccordion(
      title: 'Toast',
      contentChild: RsxOptionGroupWidget(
        optionGroupItems: [optionGroupItems],
        physics: const NeverScrollableScrollPhysics(),
      ),
      margin: EdgeInsets.zero,
      collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      expandedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      showAccordion: false,
    );
  }
}
