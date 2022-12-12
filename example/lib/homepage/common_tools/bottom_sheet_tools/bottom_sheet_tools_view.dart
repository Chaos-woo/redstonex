import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

class BottomSheetToolsComponent extends StatelessWidget {
  const BottomSheetToolsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<OptionBarItem> ops = [
      _opItem('深色模式选择', '切换使用模式', iconData: Icons.touch_app, () {
        BottomSheetUtils.showBottomSheet(_darkModeView(), shape: BottomSheetUtils.roundedTopLRRadius());
      }),
    ];

    var obGroup = [ops];
    return GFAccordion(
      title: 'Bottom Sheet',
      contentChild: OptionBarGroup(optionBarItemGroups: obGroup),
      margin: EdgeInsets.zero,
      collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      expandedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      showAccordion: false,
    );
  }

  Widget _darkModeView() {
    List<OptionBarItem> ops = [
      _opItem('浅色模式', '适合光线充足使用', () {
        Navigators.back();
      }),
      _opItem('深色模式', '适合光线较暗使用', () {
        Navigators.back();
      }),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          height: 45,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '选择展示模式',
              style: TextStyles.textBold18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: OptionBarGroup(optionBarItemGroups: [ops]),
        ),
      ],
    );
  }

  OptionBarItem _opItem(String label, String? description, VoidCallback onTap, {IconData? iconData}) {
    return OptionBarItem(
      label,
      leadingIcon: iconData ?? Icons.sunny,
      leadingIconColor: ThemeUtils.getIconColor(),
      subTitle: description,
      subTitleColor: ThemeUtils.getSecondaryTitleColor(),
      onTap: onTap,
    );
  }
}
