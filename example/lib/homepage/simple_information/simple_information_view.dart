import 'package:example/routes.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

import 'simple_information_logic.dart';

class SimpleInformationComponent extends StatelessWidget {
  final logic = Provides.provide(SimpleInformationLogic());

  SimpleInformationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<OptionBarItem> ops = [
      _opItem(
        '设备信息',
        '页面宫格卡片式布局简单演示',
        () {
          Navigators.to(RouteCompose.deviceRoute.baseInfo);
        },
        rightIcon: Icons.keyboard_arrow_right,
        rightIconColor: Colors.grey,
      ),
    ];

    var obGroup = [ops];
    return GFAccordion(
      title: '设备信息获取',
      contentChild: OptionBarGroup(optionBarItemGroups: obGroup),
      margin: EdgeInsets.zero,
      collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      expandedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      showAccordion: false,
    );
  }

  OptionBarItem _opItem(
    String label,
    String? description,
    VoidCallback onTap, {
    IconData? rightIcon,
    Color? rightIconColor,
  }) {
    return OptionBarItem(
      label,
      leadingIcon: Icons.find_in_page,
      leadingIconColor: ThemeUtils.theme().iconTheme.color,
      subTitle: description,
      subTitleColor: ThemeUtils.theme().textTheme.bodyText1?.color,
      onTap: onTap,
      rightIcon: rightIcon,
      rightIconColor: rightIconColor,
    );
  }
}
