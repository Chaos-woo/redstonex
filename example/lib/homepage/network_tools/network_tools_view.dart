import 'package:example/routes.dart';
import 'package:example/widgets/rsx_option_item_utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

import 'network_tools_logic.dart';

class NetworkToolsComponent extends StatelessWidget {
  final logic = rProvides().provide(NetworkToolsLogic());

  NetworkToolsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var optionItems = [
      RsxOptionItemUtils.navigatorRsxOptionItem(
        title: '历史天气查询',
        description: '异步HTTP网络请求展示',
        onTap: () {
          rNavigator().to(RouteCompose.weatherRoute.homeWeather);
        },
      ),
      RsxOptionItemUtils.navigatorRsxOptionItem(
        title: 'Bilibili“综合热门”视频查询',
        description: '分页查询网络请求展示',
        onTap: () {
          rNavigator().to(RouteCompose.biliRoute.hotVideos);
        },
      ),
    ];

    var optionGroupItems = rOptionGroupItem(
      optionItems: optionItems,
    );

    // return GFAccordion(
    //   title: '简单三方API对接',
    //   contentChild: rOptionGroupWidget(
    //     optionGroupItems: [optionGroupItems],
    //     physics: const NeverScrollableScrollPhysics(),
    //   ),
    //   margin: EdgeInsets.zero,
    //   collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
    //   expandedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
    //   showAccordion: false,
    // );

    return rOptionGroupWidget(
      optionGroupItems: [optionGroupItems],
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
