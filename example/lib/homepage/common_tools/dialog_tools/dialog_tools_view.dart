import 'dart:async';

import 'package:example/widgets/rsx_option_item_utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';
import 'package:styled_widget/styled_widget.dart';

class DialogToolsComponent extends StatelessWidget {
  int flowerCount = 0;

  DialogToolsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var optionItems = [
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '基本Dialog',
        description: '标题,描述,确认按钮',
        onTap: () {
          XDialog().showPromptDialog(
              title: '什么是Dialog?',
              content: 'dialog是在当前界面弹出的一个小窗口，用于显示重要提示信息。',
              textConfirm: 'Ok',
              confirmTextColor: Colors.blue,
              onConfirm: () {
                XNavigator().back();
              });
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '处理事件Dialog',
        description: '标题,描述,确认按钮,取消按钮',
        onTap: () {
          XDialog().showPromptDialog(
              title: '删除?',
              content: '是否删除该条消息?',
              textConfirm: '确定',
              confirmTextColor: Colors.blue,
              onConfirm: () {
                XToast().show('已删除');
                XNavigator().back();
              },
              textCancel: '取消',
              cancelTextColor: Colors.grey,
              onCancel: () {
                XNavigator().back();
              });
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '应用升级Dialog',
        description: '标题,描述,确认按钮,取消按钮',
        onTap: () {
          XDialog().showPromptDialog(title: '新版本来袭！', content: '应用发布了更多好看好玩的功能，快去应用市场更新吧~', actions: <Widget>[
            XDialog().textButton(text: '暂不提醒', onTap: () => XNavigator().back(), textColor: Colors.grey),
            XDialog().dialogButton(
              text: '去升级 >>',
              onTap: () => XNavigator().back(),
              buttonColor: Colors.blue,
              textColor: Colors.white,
            ),
          ]);
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '自定义Dialog',
        description: '自定义',
        onTap: () {
          XDialog().showElasticDialog(
            backgroundColor: Colors.white.withOpacity(0.95),
            title: _renderCustomPersonalInformationDialogTitle(),
            content: <Widget>[
              _customStatisticsItem('经验值', 0),
              _customStatisticsItem('Ta的关注', 0),
              _customStatisticsItem('Ta的粉丝', 0),
              _customStatisticsItem('Ta的鲜花', flowerCount),
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround),
            actions: <Widget>[
              XDialog().textButton(
                  text: '私信Ta',
                  onTap: () {
                    XToast().show('Ta似乎并不理你~');
                    XNavigator().back();
                  },
                  textColor: Colors.grey),
              XDialog().dialogButton(
                text: '送Ta鲜花',
                onTap: () {
                  flowerCount++;
                  XToast().show('送出鲜花1朵');
                  XNavigator().back();
                },
                buttonColor: Colors.red,
                textColor: Colors.white,
              ),
            ],
          );
        },
      ),
    ];

    var optionGroupItems = RsxOptionGroupItem(
      optionItems: optionItems,
    );

    return GFAccordion(
      title: 'Dialog',
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

  Widget _renderCustomPersonalInformationDialogTitle() {
    return <Widget>[
      const SizedBox(width: 86, height: 86)
          .decorated(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(43.0)),
          )
          .positioned(top: -63),
      const GFAvatar(
        backgroundImage: NetworkImage('https://pic1.zhimg.com/50/v2-bc4cd78275421fbc79f362f011cbd265_hd.jpg?source=1940ef5c'),
      ).height(80).width(80).positioned(top: -60),
      const Text('example_1211',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )).positioned(top: 30),
      const Text('这个人很懒，什么都没写',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          )).positioned(top: 48),
    ]
        .toStack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
        )
        .padding(all: 0)
        .height(63);
  }

  Widget _customStatisticsItem(String label, int num) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$num',
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Gaps.vGap5,
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ],
    );
  }
}
