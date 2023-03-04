import 'package:example/homepage/common_tools/common_tools_view.dart';
import 'package:example/homepage/network_tools/network_tools_view.dart';
import 'package:example/homepage/simple_information/simple_information_view.dart';
import 'package:flutter/material.dart';
import 'package:redstonex/redstonex.dart';

import 'homepage_logic.dart';

class HomepagePage extends StatelessWidget {
  final logic = XDepends().on<HomepageLogic>();
  final state = XDepends().on<HomepageLogic>().state;

  HomepagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RsxVerticalScrollView(
      scrollViewPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      children: [
        _toolTitleBuilder('通用工具示例'),
        CommonToolsComponent(),
        Gaps.vGap16,
        _toolTitleBuilder('设备软件信息展示'),
        SimpleInformationComponent(),
        Gaps.vGap16,
        _toolTitleBuilder('网络请求示例'),
        NetworkToolsComponent(),
      ],
    );
  }

  Widget _toolTitleBuilder(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
          ],
        ),
        Gaps.vGap4,
      ],
    );
  }
}
