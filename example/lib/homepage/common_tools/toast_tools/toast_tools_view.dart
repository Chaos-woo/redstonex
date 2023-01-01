import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

class ToastToolsComponent extends StatelessWidget {
  const ToastToolsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<OptionBarItem> ops = [
      _opItem('基本Toast', 'toast', () {
        ToastUtils.show('Toast是一种简易的消息提示框');
      }),
      _opItem('长文案Toast', '有很长文案的toast，默认最大展示2行', () {
        ToastUtils.show('Toast是一种简易的消息提示框。很长的文案，很长的文案，很长的文案，很长的文案，很长的文案，很长的文案，很长的文案，很长的文案');
      }),
      _opItem('带图标的Toast', '有与文案相匹配的图标', () {
        ToastUtils.show('Toast还可以与icon组合', icon: Icons.tips_and_updates, iconColor: Colors.yellowAccent);
      }),
    ];

    var obGroup = [ops];
    return GFAccordion(
      title: 'Toast',
      contentChild: OptionBarGroup(optionBarItemGroups: obGroup),
      margin: EdgeInsets.zero,
      collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      expandedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      showAccordion: false,
    );
  }

  OptionBarItem _opItem(String label, String? description, VoidCallback onTap) {
    return OptionBarItem(
      label,
      leadingIcon: Icons.touch_app,
      leadingIconColor: ThemeUtils.theme().iconTheme.color,
      subTitle: description,
      subTitleColor: ThemeUtils.theme().textTheme.bodyText1?.color,
      onTap: onTap,
    );
  }
}
