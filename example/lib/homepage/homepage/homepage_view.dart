import 'package:example/homepage/common_tools/common_tools_view.dart';
import 'package:example/homepage/network_tools/network_tools_view.dart';
import 'package:flutter/material.dart';
import 'package:redstonex/redstonex.dart';

import 'homepage_logic.dart';

class HomepagePage extends StatelessWidget {
  final logic = Depends.on<HomepageLogic>();
  final state = Depends.on<HomepageLogic>().state;

  HomepagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RsxScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      children: [
        _toolTitleBuilder('通用工具示例'),
        CommonToolsComponent(),
        Gaps.vGap10,
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
              style: TextStyles.textBold16,
            ),
            const Spacer(),
          ],
        ),
        Gaps.vGap4,
      ],
    );
  }
}
