import 'package:example/utils/random_utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

class BottomSheetToolsComponent extends StatelessWidget {
  final List<Widget> commentComponents = [];

  BottomSheetToolsComponent({Key? key}) : super(key: key) {
    for (int i = 0; i < RandomUtils.getRandomNum(10, 100); i++) {
      commentComponents.add(_commentComponent());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<OptionBarItem> ops = [
      _opItem('深色模式选择', '切换使用模式', iconData: Icons.touch_app, () {
        BottomSheetUtils.showBottomSheet(_darkModeView(), shape: BottomSheetUtils.roundedTopLRRadius());
      }),
      _opItem('评论区', '展示用户评论', iconData: Icons.touch_app, () {
        BottomSheetUtils.showBottomSheet(_commentsView(context, commentComponents), shape: BottomSheetUtils.roundedTopLRRadius(), enterBottomSheetDuration: 400.milliseconds, exitBottomSheetDuration: 300.milliseconds);
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
      leadingIconColor: ThemeUtils.theme().iconTheme.color,
      subTitle: description,
      subTitleColor: ThemeUtils.theme().textTheme.bodyText1?.color,
      onTap: onTap,
    );
  }

  Widget _commentsView(BuildContext context, List<Widget> commentComponents) {
    int allCommentCount = commentComponents.length;

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20,
            child: Center(
              child: Text(
                '$allCommentCount 条评论',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
          Gaps.vGap10,
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return commentComponents[index];
              },
              itemCount: allCommentCount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentComponent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: ClipRRect(
                  child: RandomUtils.getRandomAvatar(height: 40, width: 40),
                ),
              ),
            ),
          ),
          Gaps.hGap4,
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                RandomUtils.getRandomName(),
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                RandomUtils.getRandomString(20, 100),
                style: const TextStyle(fontSize: 13, color: Colors.black),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            ],
          )),
          SizedBox(
            width: 40,
            child: Center(
              child: ClickWidget(
                child: const Icon(
                  Icons.favorite_outline_sharp,
                  color: Colors.grey,
                ),
                onTap: () {
                  ToastUtils.show('click favorite icon');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
