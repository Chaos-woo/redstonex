import 'package:example/routes.dart';
import 'package:example/widgets/rsx_option_item_utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

import 'simple_information_logic.dart';

class SimpleInformationComponent extends StatelessWidget {
  final logic = Provides.provide(SimpleInformationLogic());

  SimpleInformationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var optionItems = [
      RsxOptionItemUtils.navigatorRsxOptionItem(
        title: '设备信息',
        description: '页面宫格卡片式布局简单演示',
        onTap: () {
          Navigators.to(RouteCompose.deviceRoute.baseInfo);
        },
      ),
    ];

    var optionGroupItems = RsxOptionGroupItem(
      optionItems: optionItems,
    );

    return GFAccordion(
      title: '设备信息获取',
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
