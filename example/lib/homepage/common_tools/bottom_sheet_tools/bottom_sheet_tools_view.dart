import 'package:example/routes.dart';
import 'package:example/utils/random_utils.dart';
import 'package:example/widgets/rsx_option_item_utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';
import 'package:styled_widget/styled_widget.dart';

class BottomSheetToolsComponent extends StatelessWidget {
  final List<Widget> commentComponents = [];

  BottomSheetToolsComponent({Key? key}) : super(key: key) {
    for (int i = 0; i < RandomUtils.getRandomNum(10, 100); i++) {
      commentComponents.add(_renderSingleComment());
    }
  }

  @override
  Widget build(BuildContext context) {
    var optionItems = [
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '深色模式选择',
        description: '切换模式',
        onTap: () {
          XBottomSheet().showBottomSheet(
            _renderDarkModeView(),
            shape: XShapeBorder().roundedRectangleBorderOnly(topLeft: 15.0, topRight: 15.0),
          );
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '评论区',
        description: '展示用户评论',
        onTap: () {
          XBottomSheet().showBottomSheet(
            _renderCommentsView(context, commentComponents),
            shape: XShapeBorder().roundedRectangleBorderOnly(topLeft: 15.0, topRight: 15.0),
            enterBottomSheetDuration: 400.milliseconds,
            exitBottomSheetDuration: 300.milliseconds,
          );
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '评论区V2',
        description: '展示用户评论,设置bottom sheet高度',
        onTap: () {
          XBottomSheet().showBottomSheet(
            _renderCommentsView(context, commentComponents).height(XScreen().screenHeight * 0.85),
            shape: XShapeBorder().roundedRectangleBorderOnly(topLeft: 15.0, topRight: 15.0),
            enterBottomSheetDuration: 400.milliseconds,
            exitBottomSheetDuration: 300.milliseconds,
            customControlHeight: true,
          );
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: 'Lottie动画',
        description: 'Lottie bottom navigation',
        onTap: () {
          XNavigator().to(RouteCompose.lottieRoute.index);
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: 'Persistent Bottom NavBar',
        description: '文字路由导航',
        onTap: () {
          XNavigator().to(RouteCompose.textRoute.index);
        },
      ),
    ];

    var optionGroupItems = RsxOptionGroupItem(
      optionItems: optionItems,
    );

    return GFAccordion(
      title: 'Bottom Sheet',
      contentChild: RsxOptionGroupWidget(
        optionGroupItems: [optionGroupItems],
        physics: const NeverScrollableScrollPhysics(),
        optionItemDivider: (context) => const Divider().padding(left: 25),
      ),
      margin: EdgeInsets.zero,
      collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      expandedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      showAccordion: false,
    );
  }

  Widget _renderDarkModeView() {
    List<Map<String, dynamic>> modes = [
      {
        'mode': '浅色模式',
        'desc': '适合光线充足使用',
        'onTap': () {
          XNavigator().back();
        },
        'modeFlg': 'light',
      },
      {
        'mode': '深色模式',
        'desc': '适合光线较暗使用',
        'onTap': () {
          XNavigator().back();
        },
        'modeFlg': 'dark',
      },
    ];

    var modeSelectorOptionItems = modes.map((m) {
      return RsxHorizontalItem(
        title: m['mode'] as String,
        titleStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        description: Text(
          m['desc'] as String,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        leading: 'light' == m['modeFlg']
            ? const Icon(
                Icons.sunny,
                size: 22,
                color: Colors.orangeAccent,
              ).padding(right: 10)
            : const Icon(
                Icons.shield_moon,
                size: 22,
                color: Colors.black38,
              ).padding(right: 10),
        onTap: m['onTap'] as VoidCallback,
      );
    }).toList();

    var optionGroupItems = RsxOptionGroupItem(
      optionItems: modeSelectorOptionItems,
    );

    return <Widget>[
      /// 简单引导
      SizedBox(width: XScreen().screenWidth / 6, height: 4)
          .decorated(
            color: Colors.grey.withOpacity(0.6),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          )
          .center()
          .padding(vertical: 4),
      const Text('模式选择', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          .alignment(Alignment.centerLeft)
          .padding(
            horizontal: 20,
            vertical: 10,
          )
          .height(45),
      RsxOptionGroupWidget(
        optionGroupItems: [optionGroupItems],
      ).padding(horizontal: 20),
    ].toColumn(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min);
  }

  Widget _renderCommentsView(BuildContext context, List<Widget> commentComponents) {
    int allCommentCount = commentComponents.length;

    return <Widget>[
      Text(
        '$allCommentCount 条评论',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ).center().height(20),
      Gaps.vGap10,
      ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemBuilder: (context, index) {
          return commentComponents[index];
        },
        itemCount: allCommentCount,
      ).expanded(),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        )
        .padding(vertical: 15, horizontal: 15);
  }

  Widget _renderSingleComment() {
    var randomLevel = RandomUtils.getRandomNum(1, 5);
    var randomUserNickname = RandomUtils.getRandomName();
    var randomComment = RandomUtils.getRandomString(10, 100);

    RsxHorizontalItem item = RsxHorizontalItem(
      titleWidget: _renderUserNicknameAndLevel(randomUserNickname, randomLevel),
      description: Text(
        randomComment,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      leading: ClipRRect(
        child: RandomUtils.getFixedRandomAvatar(randomUserNickname, height: 20, width: 20),
      ).padding(right: 10),
      leadingTop: true,
      suffix: const Icon(
        Icons.favorite_outline_sharp,
        color: Colors.grey,
        size: 20,
      ).gestures(onTap: () => XToast().show('click favorite icon')).padding(left: 10),
      onLongPress: () => XToast().show('Copied $randomUserNickname\'s comment'),
      onDoubleTap: () => _handleUserCommentDialog({
        'nickname': randomUserNickname,
        'level': randomLevel,
        'comment': randomComment,
      }),
    );

    return RsxHorizontalItemWidget(
      item: item,
    ).padding(vertical: 5);
  }

  void _handleUserCommentDialog(Map<String, dynamic> param) {
    XDialog().showPromptDialog(
      title: '评论详情',
      backgroundColor: Colors.white,
      contentWidget: <Widget>[
        <Widget>[
          ClipRRect(
            child: RandomUtils.getFixedRandomAvatar(param['nickname'], height: 20, width: 20),
          ).padding(right: 10),
          _renderUserNicknameAndLevel(param['nickname'], param['level']),
          const Text(
            '说：',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ).padding(left: 6),
        ]
            .toRow(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
            )
            .padding(bottom: 5),
        Text(
          param['comment'],
          style: const TextStyle(fontSize: 14, color: Colors.black),
          softWrap: true,
        )
      ].toColumn(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
      ),
      textConfirm: '关闭',
      confirmTextColor: Colors.grey,
      onConfirm: () => XNavigator().back(),
    );
  }

  Widget _renderUserNicknameAndLevel(String nickname, int level) {
    var levelColor = {
      1: Colors.grey,
      2: Colors.green[300],
      3: Colors.blue[400],
      4: Colors.orange,
      5: Colors.red[700],
    };

    return <Widget>[
      Text(
        nickname,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ).padding(right: 5),
      RichText(
              text: TextSpan(children: [
        const TextSpan(text: 'Lv', style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold)),
        TextSpan(
            text: '$level',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ]))
          .padding(horizontal: 3)
          .decorated(
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            color: levelColor[level],
          )
          .padding(left: 3),
    ].toRow(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
    );
  }
}
