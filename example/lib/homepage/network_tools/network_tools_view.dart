import 'package:example/routes.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

import 'network_tools_logic.dart';

class NetworkToolsComponent extends StatelessWidget {
  final logic = Provides.provide(NetworkToolsLogic());

  NetworkToolsComponent({Key? key}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    List<OptionBarItem> ops = [
      _opItem(
        '历史天气查询',
        '异步HTTP网络请求展示',
            () {
          Navigators.to(RouteCompose.weatherRoute.homeWeather);
        },
        rightIcon: Icons.keyboard_arrow_right,
        rightIconColor: Colors.grey,
      ),
    ];

    var obGroup = [ops];
    return GFAccordion(
      title: '简单三方API对接',
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
